local MS = Merge.ModSettings
local IMMUNE_MONSTER_RESISTANCE = 200

if MS.Rev4ForMergeDuplicateModdedDungeons == 1 then
	-- Temple in a bottle
	evt.UseItemEffects[1452] = function(Target, Item, PlayerId)
		ExitCurrentScreen(false, true)
		evt.MoveToMap{0,0,0,0,0,0,0,0,"7nwcorig.blv"}
		return 0
	end
end

-- TODO: test all my asm additions

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
			t.Monster.Resistances[damageType] = math.max(0, (oldRes == const.MonsterImmune and IMMUNE_MONSTER_RESISTANCE or oldRes) - reduction)
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

-- show spell skill in monster right click info

local monsterRightclickDataBuf = 0x5DF0E0

local function moveLeft(amount)
	local buf = mem.string(monsterRightclickDataBuf)
	local pos = buf:find(string.char(9))
	if not pos then return end
	-- next 3 bytes describe shift to the right (in ascii), so we need to decrease it
	local replacement = tostring(tonumber(buf:sub(pos + 1, pos + 3)) - amount)
	if replacement:len() < 3 then
		replacement = string.rep("0", 3 - replacement:len()) .. replacement
	end
	mem.copy(monsterRightclickDataBuf + pos, replacement)
end

local showSpellSkill = function(skillOffset, lenOffset)
	return function(d)
		mem.prot(true)
		-- move spells info to the left
		moveLeft(10)
		local afterSpellName = monsterRightclickDataBuf
		while mem.u1[afterSpellName] ~= 0xA and mem.u1[afterSpellName] ~= 0 do
			afterSpellName = afterSpellName + 1
		end
		local monsterData = mem.u4[d.ebp - 0x10]
		local skill = mem.u2[monsterData + skillOffset]
		local s, m = SplitSkill(skill)
		local add = " " .. s .. ({"N", "E", "M", "G"})[m] .. "\n"
		mem.copy(afterSpellName, add)
		mem.u1[afterSpellName + add:len()] = 0 -- null terminator
		mem.u4[0x19F93C + lenOffset] = mem.u4[0x19F93C + lenOffset] + add:len() -- update length of row
		mem.prot(false)
	end
end
mem.autohook(0x41E673, showSpellSkill(0x6E, 0))
mem.autohook(0x41E6C1, showSpellSkill(0x4C, 4))

-- show spell resistance penetration in monster right click info
if MS.Rev4ForMergeAddResistancePenetration == 1 then
	local i = 1
	local resOrder = {const.Damage.Fire, const.Damage.Air, const.Damage.Water, const.Damage.Earth,
					  const.Damage.Mind, const.Damage.Spirit, const.Damage.Body, const.Damage.Light, const.Damage.Dark, const.Damage.Phys}
	mem.autohook(0x41E8A0, function(d)
		local pl = Party.CurrentPlayer
		-- move resistance values a little to the left (default is 070)
		moveLeft(20)
		if pl < 0 then return end -- skip if no player selected
		local damageType = resOrder[i]
		if i == 10 then
			i = 1
			-- shorten "Physical" to "Phys" to get more space
			local str = mem.string(monsterRightclickDataBuf)
			-- Physical
			-- 12345678
			str = str:sub(1, 4) .. str:sub(9, str:len()) .. string.char(0)
			mem.copy(monsterRightclickDataBuf, str)
			return
		end
		local reduction = 0
		for item in Party[pl]:EnumActiveItems(false) do
			if item.Bonus == 60 + damageType - (damageType >= const.Damage.Spirit and 2 or 0) then
				reduction = reduction + item.BonusStrength
			end
		end
		if reduction == 0 then i = i + 1; return end
		local buf = mem.string(monsterRightclickDataBuf)
		if buf:find("None") then i = i + 1; return end
		local res = mem.u2[mem.u4[d.ebp - 0x10] + 0x50 + (i - 1) * 2]
		local strToFind = tostring(res)
		local immune = res == const.MonsterImmune
		if immune then
			strToFind = "Immune"
			res = IMMUNE_MONSTER_RESISTANCE
		end
		local pos, pos2 = 0, -1
		while pos2 ~= nil do
			pos2 = buf:find(strToFind, pos + 1)
			if pos2 then
				pos = pos2
			end
		end
		local add = (immune and "I" or "") .. res .. "-" .. math.min(reduction, res) .. "=" .. math.max(res - reduction, 0) .. "\n" .. string.char(0)
		mem.copy(monsterRightclickDataBuf + pos - 1, add)
		i = i + 1
	end)
end

-- always show full info if you have required skill, no matter the id monster mastery
-- identify monster gives ability to do critical hits
if MS.Rev4ForMergeRemakeIdentifyMonster == 1 then
	mem.nop2(0x41E07A, 0x41E0EF)
	mem.hook(0x41E07A, function(d)
		local maxS, maxM = 0, 0
		for _, pl in Party do
			if pl:IsConscious() then
				local s, m = SplitSkill(pl.Skills[const.Skills.IdentifyMonster])
				-- id monster bonus
				local maxBonus = 0
				for item, slot in pl:EnumActiveItems(false) do
					if item.Bonus == 21 then
						maxBonus = math.max(maxBonus, item.BonusStrength)
					end
				end
				if s * 4 + maxBonus > maxS then
					maxS = s * 4 + maxBonus
				end
				maxM = math.max(maxM, m)
			end
		end
		d.eax, d.ecx = maxS, maxM
	end)

	mem.asmpatch(0x41E07F, [[
		cmp ecx, 4
		jae @show
		mov ecx,dword [ss:ebp-0x10]
		movzx ecx,byte [ds:ecx+0x34]
		cmp eax,ecx
		jb @dontshow
		@show:
		mov dword [ss:ebp-0x1C],1
		mov dword [ss:ebp-0x24],1
		mov dword [ss:ebp-0x14],1
		mov dword [ss:ebp-0x34],1
		@dontshow: 
		jmp absolute 0x41E0EF
	]])
	
	local critAttackMsg = "%s critically hits %s for %lu damage!" .. string.char(0)
	local critShootMsg = "%s critically shoots %s for %lu points!" .. string.char(0)
	local critKillMsg = "%s critically inflicts %lu points killing %s!" .. string.char(0)
	
	local function isCrit(pl, damage)
		local s, m = SplitSkill(pl.Skills[const.Skills.IdentifyMonster])
		if s == 0 then return false end
		local chance = ({2, 5, 10, 20})[m]
		local roll = math.random(1, 100)
		if roll <= chance then
			local skillDamageMul = ({1, 2, 3, 5})[m]
			local maxBonus = 0
			for item, slot in pl:EnumActiveItems(false) do
				if item.Bonus == 21 then
					maxBonus = math.max(maxBonus, item.BonusStrength)
				end
			end
			return true, math.round(damage * (1 + (s * skillDamageMul + 9 + maxBonus) / 100))
		else
			return false
		end
	end
	
	local crit, dmg = false
	local function critProcHook(d)
		local i, pl = internal.GetPlayer(mem.u4[d.ebp - 0x8])
		crit, dmg = isCrit(pl, d.eax)
		if not crit then return end
		d.eax = dmg
	end
	mem.autohook2(0x43703F, critProcHook) -- shoot (ranged)
	mem.autohook2(0x437148, critProcHook) -- spell
	mem.autohook2(0x437243, critProcHook) -- attack
	
	mem.autohook(0x4376AC, function(d)
		if not crit then return end
		local addr, result = mem.u4[d.esp + 4]
		if addr == mem.u4[0x6016D8] then -- attack
			result = mem.topointer(critAttackMsg)
		elseif addr == mem.u4[0x60173C] then -- shoot
			result = mem.topointer(critShootMsg)
		elseif addr == mem.u4[0x601704] then -- kill
			result = mem.topointer(critKillMsg)
		else
			error("Unknown attack message type")
		end
		mem.u4[d.esp + 4] = result
		crit = false
	end)
	
	local IdMonsterDescriptions =
	{
		"The identify monster skill is applied when you right-click on a monster. If you have high enough skill, all information about the monster will be displayed. It also allows you to perform critical hits with melee/ranged attacks and spells.",
		"Critical hit chance: 2%, extra damage: skill + 9%",
		"Critical hit chance: 5%, extra damage: skill * 2 + 9%",
		"Critical hit chance: 10%, extra damage: skill * 3 + 9%",
		"Critical hit chance: 20%, extra damage: skill * 5 + 9%"
	}
	
	function events.GameInitialized2()
		for i, v in ipairs({0x5E4D38, 0x5E4C98, 0x5E4BF8, 0x5E4B58, 0x5E4AB8}) do
			mem.u4[v] = mem.topointer(IdMonsterDescriptions[i])
		end
	end
	--[[for i, v in ipairs(IdMonsterDescriptions) do
		mem.u4[0x19E410 + (i - 1) * 0x10] = mem.topointer(v)
	end
	function events.GameInitialized2()
		
	end]]
else
	mem.nop2(0x41E07A, 0x41E086)
	mem.hook(0x41E07A, function(d)
		local maxS, maxM = 0, 0
		for _, pl in Party do
			if pl:IsConscious() then
				local s, m = SplitSkill(pl.Skills[const.Skills.IdentifyMonster])
				-- id monster bonus
				local maxBonus = 0
				for item, slot in pl:EnumActiveItems(false) do
					if item.Bonus == 21 then
						maxBonus = math.max(maxBonus, item.BonusStrength)
					end
				end
				if s + maxBonus > maxS then
					maxS = s + maxBonus
				end
				maxM = math.max(maxM, m)
			end
		end
		d.edi, d.eax = maxS, maxM
	end)
end
-- Party[0].Skills[const.Skills.IdentifyMonster] = JoinSkill(1, const.Novice)

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
function getRange(str)
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