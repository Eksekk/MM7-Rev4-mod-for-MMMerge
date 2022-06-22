local MS = Merge.ModSettings

if MS.Rev4ForMergeDuplicateModdedDungeons == 1 then
	-- Temple in a bottle
	evt.UseItemEffects[1452] = function(Target, Item, PlayerId)
		ExitCurrentScreen(false, true)
		evt.MoveToMap{0,0,0,0,0,0,0,0,"7nwcorig.blv"}
		return 0
	end
end

-- made thanks to Tomsod's Elemental Mod sources

-- shop sell item event, can be used to tweak amount of gold that player will receive
-- (it affects even merchant, so GM with 0.5 multiplier will get 250 gold
-- for 500 gold item)

-- disable short jump (it will be processed in event handler function)
mem.asmpatch(0x4B66C6, [[
	nop
	nop
	nop
	nop
	nop
	nop
]])
mem.hook(0x4B66C6, function(d)
	local t = {Multiplier = 1}
	events.call("GetShopSellPriceMul", t)
	local amount = d.esi
	if t.Multiplier ~= 1 then
		amount = math.round(amount * t.Multiplier)
	end
	d.eax = amount > 1 and amount or 0
end)

-- Celeste location near Walls of the Mist door can be used for another dungeon entrance (explained with "it's a portal")

-- spell resistance penetration! My dream idea is coming true :)
if MS.Rev4ForMergeAddResistancePenetration == 1 then
	-- for i = 0, 137 do evt.GiveItem{Strength = 6, Type = const.ItemType.Ring} end
	--[[local stdItemsDataStart
	mem.autohook2(0x4546EC, function(d)
		stdItemsDataStart = d.eax
	end)]]
	
	local chanceSumDataStart
	mem.autohook2(0x4547A8, function(d)
		chanceSumDataStart = d.esi
	end)
	-- allow res pen items to generate
	function events.GameInitialized2()
		-- local entrySize = 4 + 4 + 9 * 1
		-- Arm	 Shld	 Helm	 Belt	 Cape	 Gaunt	 Boot	 Ring	 Amul
		local indexes = {"Arm", "Shld", "Helm", "Belt", "Cape", "Gaunt", "Boot", "Ring", "Amul"}
		local values = {0, 0, 5, 5, 5, 5, 5, 15, 15}
		for stdBonus = 59, 67 do
			for i, v in ipairs(indexes) do
				Game.StdItemsTxt[stdBonus][v] = values[i]
				-- mem.u1[stdItemsDataStart + stdBonus * entrySize + 8 + (i - 1)] = values[i]
			end
		end
		-- correct chance sums, otherwise items won't generate
		mem.IgnoreProtection(true)
		for i = 1, 9 do
			mem.u4[chanceSumDataStart + (i - 1) * 4] = mem.u4[chanceSumDataStart + (i - 1) * 4] + 9 * values[i]
		end
		mem.IgnoreProtection(false)
	end
	
	local oldResType
	local oldRes
	function events.MonsterAttacked(t)
		-- TODO: handle race skills
		local damageType
		local obj = t.Attacker.Object
		if obj and obj.Spell and t.Attacker.Player then
			local reduction = 0
			local damageType
			for i = 11, 11 * 9, 11 do
				if obj.Spell <= i then
					damageType = math.ceil(i / 11) - 1
					if damageType >= const.Damage.Phys then
						damageType = damageType + 2
					end
					break
				end
			end
			if not damageType then
				return
			end
			for item in t.Attacker.Player:EnumActiveItems(false) do
				if item.Bonus == 60 + damageType - (damageType >= const.Damage.Spirit and 2 or 0) then
					reduction = reduction + item.BonusStrength
				end
			end
			oldResType = damageType
			oldRes = t.Monster.Resistances[damageType]
			--debug.Message(oldResType, oldRes, oldRes - reduction)
			t.Monster.Resistances[damageType] = math.max(0, (oldRes == const.MonsterImmune and 200 or oldRes) - reduction)
		end
	end
	
	function events.AfterMonsterAttacked(t)
		if oldRes then
			t.Monster.Resistances[oldResType] = oldRes
			oldRes = nil
			oldResType = nil
		end
	end
end

-- difficulty
const.Difficulty =
{
	Easy = 0,
	Medium = 1,
	Hard = 2
}

modSettingsDifficulty = Merge.ModSettings.Rev4ForMergeDifficulty
difficulty = modSettingsDifficulty and modSettingsDifficulty >= 0 and modSettingsDifficulty <= 2 and math.floor(modSettingsDifficulty) == modSettingsDifficulty and modSettingsDifficulty or const.Difficulty.Easy
isEasy = function() return difficulty == const.Difficulty.Easy end
isMedium = function() return difficulty == const.Difficulty.Medium end
isHard = function() return difficulty == const.Difficulty.Hard end

function diffsel(...)
	return assert(select(difficulty + 1, ...))
end

local lookupTable = {}
local function getRange(str)
	if lookupTable[str] then return lookupTable[str][1], lookupTable[str][2] end
	local min, max = str:match("(%d+)%-(%d+)")
	min = tonumber(min)
	max = tonumber(max)
	assert(min ~= nil and max ~= nil)
	lookupTable[str] = {min, max}
	return min, max
end

local random = math.random
function pseudoSpawnpoint(monster, x, y, z, count, powerChances, radius, group, exactZ)
	local t = {}
	if type(monster) == "table" then
		t = monster -- user passed table with arguments instead of monster
	else
		t.Monster, t.monster = monster, monster
		t.X, t.x = x, x
		t.Y, t.y = y, y
		t.Z, t.z = z, z
		t.Count, t.count = count, count
		t.PowerChances, t.powerChances = powerChances, powerChances
		t.Radius, t.radius = radius, radius
		t.Group, t.group = group, group
		t.exactZ, t.ExactZ = exactZ, exactZ
	end
	t.count = t.count or "1-3"
	assert(type(t.count) == "string")
	t.powerChances = t.powerChances or {34, 33, 33}
	for i, v in ipairs(t.powerChances) do
		if v == 0 then
			t.powerChances[i] = nil
		end
	end
	t.radius = t.radius or 64
	assert(t.monster and t.x and t.y and t.z and true or nil)
	local class = (t.monster + 2):div(3)
	
	local min, max = getRange(t.count)
	local toCreate = random(min, max)
	
	local summoned = {}
	for i = 1, toCreate do
		-- https://stackoverflow.com/questions/9879258/how-can-i-generate-random-points-on-a-circles-circumference-in-javascript
		local angle = random() * math.pi * 2
		local xadd = math.cos(angle) * random(1, t.radius)
		local yadd = math.sin(angle) * random(1, t.radius)
		
		local power = nil
		local rand = random(1, 100)
		if t.powerChances[1] and (rand < t.powerChances[1] or (not t.powerChances[2] and not t.powerChances[3])) then
			power = 0
		elseif t.powerChances[2] and (rand < t.powerChances[2] + t.powerChances[1] or (not t.powerChances[1] and not t.powerChances[3])) then
			power = 1
		elseif t.powerChances[3] then
			power = 2
		elseif t.powerChances[2] then
			power = 1
		else
			power = 0
		end
		
		local x, y = t.x + xadd, t.y + yadd
		local mon = (SummonMonster(class * 3 - 2 + power, x, y, not t.exactZ and Map.IndoorOrOutdoor == 2 and Map.GetGroundLevel(x, y) or t.z, true))
		mon.Group = t.group or 255
		table.insert(summoned, mon)
	end
	return summoned
end

function pseudoSpawnpointItem(item, x, y, z, count, radius, level, typ)
	local t = {}
	if type(item) == "table" then
		t = item -- user passed table with arguments instead of item
	else
		t.Item, t.item = item, item
		t.X, t.x = x, x
		t.Y, t.y = y, y
		t.Z, t.z = z, z
		t.Count, t.count = count, count
		t.Radius, t.radius = radius, radius
		t.level, t.Level = level, level
		t.typ, t.Typ = typ, typ
		t.level, t.level = level, level
	end
	t.count = t.count or 1
	t.radius = t.radius or 64
	assert(t.item and t.x and t.y and t.z and true or nil)
	
	local min, max
	if type(t.count) == "number" then
		min, max = t.count, t.count
	else
		min, max = getRange(t.count)
	end
	local toCreate = random(min, max)
	
	for i = 1, toCreate do
		-- https://stackoverflow.com/questions/9879258/how-can-i-generate-random-points-on-a-circles-circumference-in-javascript
		local angle = random() * math.pi * 2
		local xadd = math.cos(angle) * random(1, t.radius)
		local yadd = math.sin(angle) * random(1, t.radius)
		
		local x, y = t.x + xadd, t.y + yadd
		local item = SummonItem(t.item or 1, x, y, Map.IndoorOrOutdoor == 2 and Map.GetGroundLevel(x, y) or t.z, nil)
		if t.level then
			item:Randomize(t.level, t.typ or 0)
			local obj = Map.Objects[Map.Objects["count"] - 1]
			obj.Type, obj.TypeIndex = Game.ItemsTxt[item.Number].SpriteIndex, Game.ItemsTxt[item.Number].SpriteIndex
		end
	end
end

function events.LeaveMap()
	--mapvars.Summoned = summoned
	summoned = {}
end
--[[function events.LoadMap()
	if mapvars.Summoned then
		summoned = mapvars.Summoned
	end
end]]

function pseudoSpawnpointPrint()
	print(("pseudoSpawnpoint{monster = 1, x = %d, y = %d, z = %d, count = isMedium() and \"1-3\" or \"3-5\", powerChances = isMedium() and {60, 30, 10} or {34, 33, 33}, radius = 512}"):format(Party.X, Party.Y, Party.Z))
end

function pseudoSpawnpointItemPrint()
	print(("pseudoSpawnpointItem{item = 1, x = %d, y = %d, z = %d, count = 1, radius = 64}"):format(Party.X, Party.Y, Party.Z))
end

psp = pseudoSpawnpointPrint
psip = pseudoSpawnpointItemPrint