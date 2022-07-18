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
local chanceSumDataStart
mem.autohook2(0x4547A8, function(d)
	chanceSumDataStart = d.esi
end)
if MS.Rev4ForMergeAddResistancePenetration == 1 then
	-- for i = 0, 137 do evt.GiveItem{Strength = 6, Type = const.ItemType.Ring} end
	--[[local stdItemsDataStart
	mem.autohook2(0x4546EC, function(d)
		stdItemsDataStart = d.eax
	end)]]
	-- allow res pen items to generate
	function events.GameInitialized2()
		-- local entrySize = 4 + 4 + 9 * 1
		-- Arm	 Shld	 Helm	 Belt	 Cape	 Gaunt	 Boot	 Ring	 Amul
		local indexes = {"Arm", "Shld", "Helm", "Belt", "Cape", "Gaunt", "Boot", "Ring", "Amul"}
		local values = {0, 0, 5, 5, 10, 15, 5, 10, 10}
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
		local skill = mem.i2[monsterData + skillOffset]
		local s, m = SplitSkill(skill)
		local add = " " .. s .. (({"N", "E", "M", "G"})[m] or "None") .. "\n" -- "None" is for situations where monster had 0 spell skill so game doesn't crash, yes this happened during development (a bug obviously)
		mem.copy(afterSpellName, add)
		mem.u1[afterSpellName + add:len()] = 0 -- null terminator
		mem.u4[0x19F93C + lenOffset] = mem.u4[0x19F93C + lenOffset] + add:len() -- update length of row
		mem.prot(false)
	end
end
mem.autohook(0x41E673, showSpellSkill(0x6E, 0))
mem.autohook(0x41E6C1, showSpellSkill(0x70, 4))

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
	mem.autohook2(0x437243, critProcHook) -- melee attack
	
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
else -- only makes identify monster shared skill, no other changes
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

if MS.Rev4ForMergeNerfDrainSp == 1 then
	-- remove maxMana / 4 per drainsp instead of zeroing
	-- no reason to use asm function over lua, except for increasing asm skills :)
	local nerfDrainsp = mem.asmproc([[
		push eax
		push ecx
		mov ecx, esi
		call absolute 0x48DA18 ; GetFullSP()
		shr eax, 2
		mov ecx, dword [ds:esi+0x1BFC] ; current mana
		test eax, eax
		jnz @notzero
		mov eax, 1
		@notzero:
		neg eax
		lea edi, dword [ecx + eax]
		cmp edi, 0
		jge @over
		mov edi, 0
		@over:
		mov dword [ds:esi+0x1BFC], edi
		pop ecx
		pop eax
		ret
	]])
	mem.asmpatch(0x48D501, "call absolute " .. nerfDrainsp)
end

-- dark/light resistances!

function getItemBonusSum(pl, bonus)
	local val = 0
	for item, slot in pl:EnumActiveItems(false) do
		if item.Bonus == bonus then
			val = val + item.BonusStrength
		end
	end
	return val
end

function getLightRes(pl, temp)
	return mem.i2[pl["?ptr"] + (temp and 0x1A30 or 0x1A1A)] + (not temp and getItemBonusSum(pl, 69) or 0) + (temp and getLightRes(pl, false) or 0)
end
function getDarkRes(pl, temp)
	return mem.i2[pl["?ptr"] + (temp and 0x1A32 or 0x1A1C)] + (not temp and getItemBonusSum(pl, 70) or 0) + (temp and getDarkRes(pl, false) or 0)
end
function addLightRes(pl, amount, temp)
	mem.i2[pl["?ptr"] + (temp and 0x1A30 or 0x1A1A)] = math.max(0, mem.i2[pl["?ptr"] + (temp and 0x1A30 or 0x1A1A)] + amount)
end
function addDarkRes(pl, amount, temp)
	mem.i2[pl["?ptr"] + (temp and 0x1A32 or 0x1A1C)] = math.max(0, mem.i2[pl["?ptr"] + (temp and 0x1A32 or 0x1A1C)] + amount)
end
function addLightResAll(amount, temp)
	for _, pl in Party do
		addLightRes(pl, amount, temp)
	end
end
function addDarkResAll(amount, temp)
	for _, pl in Party do
		addDarkRes(pl, amount, temp)
	end
end

if MS.Rev4ForMergeAddDarkLightResistances == 1 then
	
	-- hook to make game respect item dark/light resistance bonuses
	mem.autohook(0x48DF74, function(d)
		if d.edi == const.Damage.Light or d.edi == const.Damage.Dark then
			local i, pl = internal.GetPlayer(d.esi)
			if d.edi == const.Damage.Light then
				d.eax = d.eax + getItemBonusSum(pl, 69)
			elseif d.edi == const.Damage.Dark then
				d.eax = d.eax + getItemBonusSum(pl, 70)
			end
		end
	end)
	
	-- add sources of new resistances

	function events.LoadMap()
		if Map.Name == "7out04.odm" then -- Tularean Forest
			Game.MapEvtLines:RemoveEvent(452)
			evt.map[452].clear()
			evt.map[452] = function()
				if evt.Cmp{"PlayerBits", Value = 25} then
					Game.ShowStatusText("You Pray")
				else
					evt.Add{"WaterResistance", Value = 10}
					evt.Add{"FireResistance", Value = 10}
					evt.Add{"AirResistance", Value = 10}
					addLightRes(Party[math.max(Game.CurrentPlayer, 0)], 10)
					evt.Add{"PlayerBits", Value = 25}
					Game.ShowStatusText("+10 Water, Fire, Air and Light resistances (permanent)")
				end
			end
		elseif Map.Name == "7out05.odm" then -- Deyja
			Game.MapEvtLines:RemoveEvent(452)
			evt.map[452].clear()
			evt.map[452] = function()
				if evt.Cmp{"PlayerBits", Value = 26} then
					Game.ShowStatusText("You Pray")
				else
					evt.Add{"MindResistance", Value = 10}
					evt.Add{"EarthResistance", Value = 10}
					evt.Add{"BodyResistance", Value = 10}
					addDarkRes(Party[math.max(Game.CurrentPlayer, 0)], 10)
					evt.Add{"PlayerBits", Value = 26}
					Game.ShowStatusText("+10 Mind, Earth, Body and Dark resistances (permanent)")
				end
			end
		end
	end
	
	-- cauldrons are handled in Structs/After/GlobalEventsNewHandler.lua
	
	-- item bonuses
	function events.GameInitialized2()
		-- Arm	 Shld	 Helm	 Belt	 Cape	 Gaunt	 Boot	 Ring	 Amul
		local indexes = {"Arm", "Shld", "Helm", "Belt", "Cape", "Gaunt", "Boot", "Ring", "Amul"}
		local values = {10, 10, 5, 0, 10, 15, 5, 10, 10}
		for stdBonus = 68, 69 do
			for i, v in ipairs(indexes) do
				Game.StdItemsTxt[stdBonus][v] = values[i]
			end
		end
		-- correct chance sums, otherwise items won't generate
		mem.IgnoreProtection(true)
		for i = 1, 9 do
			mem.u4[chanceSumDataStart + (i - 1) * 4] = mem.u4[chanceSumDataStart + (i - 1) * 4] + 2 * values[i]
		end
		mem.IgnoreProtection(false)
	end
	
	-- add way to check new resistances
	
	local strGreen = "\f02016" -- taken directly from debugger, I'm too dumb to understand StrColor/RGB
	local strDefaultColor = "\f00000"
	
	local template = "Light resistance      %s%d%s / %d\nDark resistance      %s%d%s / %d"
	local extraDataText = CustomUI.CreateText{
		Text = "Extra attributes:",
		X =	110,
		Y =	33,
		--Width = 300,
		Screen = const.Screens.Inventory,
		Active = true,
		Condition = function(t)
			return Game.CurrentCharScreen == const.CharScreens.Stats
		end}
	
	local resText = CustomUI.CreateText{
		Text = string.format(template, "", 0, "", 0, "", 0, "", 0),
		X = 110,
		Y = 100,
		Width = 300,
		Screen = const.Screens.Inventory,
		Active = false,
		Condition = function(t)
			--[[if Keys.IsPressed(const.Keys.LBUTTON) or os.time() > t.Timeout then
				CustomUI.RemoveElement(t)
			else]]
			if Game.CurrentCharScreen ~= const.CharScreens.Stats then return false end
			CustomUI.ShowTooltip(t.Text, t.X, t.Y, t.Wt)
			--end
			return false
		end}
	
	local btnCheckRes = CustomUI.CreateButton{
			IconUp = "TglXDataU",
			IconDown = "TglXDataD",
			Screen = const.Screens.Inventory,
			Layer = 1,
			DynLoad = true,
			X =	275,
			Y =	33,
			--Masked = true,
			Condition = function(t)
				local show = Game.CurrentCharScreen == const.CharScreens.Stats
				if show and Game.CurrentPlayer >= 0 then
					local pl = Party[Game.CurrentPlayer]
					local tempL, permL, tempD, permD = getLightRes(pl, true), getLightRes(pl, false), getDarkRes(pl, true), getDarkRes(pl, false)
					local aboveBaseL, aboveBaseD = tempL > permL, tempD > permD
					resText.Text = string.format(template, aboveBaseL and strGreen or "", tempL, aboveBaseL and strDefaultColor or "", permL,
												 aboveBaseD and strGreen or "", tempD, aboveBaseD and strDefaultColor or "", permD)
				else
					resText.Active = false
				end
				return show
			end,
			Action = function()
				resText.Active = not resText.Active
			end,
			--MouseOverAction = function() ShowSlotSpellName(i) end
		}
	
	
	-- elemental totems and cleric totems
else
	-- Merge (Revamp?) default is to have fields in structs.Player for dark/light resists,
	-- but there's nothing in the game that raises them, so because I modify them in save game,
	-- I have to override them with 0, otherwise you could resist dark/light
	-- with ModSettings option turned off
	mem.autohook2(0x48DF74, function(d)
		if d.edi == const.Damage.Light or d.edi == const.Damage.Dark then
			d.eax = 0
		end
	end)
end

local GMDesc = "Skill * 4 added to Elemental (Fire/Earth/Air/Water) Resistances."
function events.GameInitialized2()
	mem.u4[0x5E4A54] = mem.topointer(GMDesc)
end

-- buff single-element resistance spells (10 fixed + 2/3/4/5 per skill point)
-- yes I could do it via lua event, but I chose to carve through the harder way
mem.nop2(0x427447, 0x42746D)
mem.asmpatch(0x427447, [[
mov dword [ss:ebp-10], edx
dec eax
jz @normal
dec eax
jz @expert
dec eax
jz @master
dec eax
jnz @end
lea edi, [edi + edi*4 + 0xA]
jmp @end
@normal:
lea edi, [edi*2 + 0xA]
jmp @end
@expert:
lea edi, [edi + edi*2 + 0xA]
jmp @end
@master:
lea edi, [edi*4 + 0xA]
@end:
mov [ss:ebp-0x4], edi
]], 0x26)

-- remove multilooting "bug"
if MS.Rev4ForMergeRemoveMultilooting == 1 then
	mem.nop(0x4251F3)
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

local Rev4ForMergeMapstatsBoosted -- needed for Global/VRev4 for Merge.lua

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
	t.radius = t.radius or 64
	assert(t.monster and t.x and t.y and t.z and true or nil)
	local class = (t.monster + 2):div(3)
	
	local min, max = getRange(t.count)
	local toCreate = random(min, max)
	
	local summoned = {}
	for i = 1, toCreate do
		
		local x, y, z
		while true do
			-- https://stackoverflow.com/questions/9879258/how-can-i-generate-random-points-on-a-circles-circumference-in-javascript
			local angle = random() * math.pi * 2
			local xadd = math.cos(angle) * random(1, t.radius)
			local yadd = math.sin(angle) * random(1, t.radius)
			x, y = t.x + xadd, t.y + yadd
			z = not t.exactZ and Map.IsOutdoor() and Map.GetGroundLevel(x, y) or t.z
			if Map.IsOutdoor() or Map.RoomFromPoint(x, y, z) > 0 then -- room from point check makes sure that monsters won't generate in a wall
				break
			end
		end
		
		local power = nil
		local rand = random(1, 100)
		if t.powerChances[1] ~= 0 and (rand <= t.powerChances[1] or (t.powerChances[2] == 0 and t.powerChances[3] == 0)) then
			power = 0
		elseif t.powerChances[2] ~= 0 and ((rand <= t.powerChances[2] + t.powerChances[1]) or (t.powerChances[1] == 0 and t.powerChances[3] == 0)) then
			power = 1
		elseif t.powerChances[3] ~= 0 then
			power = 2
		elseif t.powerChances[2] ~= 0 then
			power = 1
		else
			power = 0
		end
		
		local mon = SummonMonster(class * 3 - 2 + power, x, y, z, true)
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
	
	local items, objects = {}, {}
	for i = 1, toCreate do
		local x, y, z
		while true do
			-- https://stackoverflow.com/questions/9879258/how-can-i-generate-random-points-on-a-circles-circumference-in-javascript
			local angle = random() * math.pi * 2
			local xadd = math.cos(angle) * random(1, t.radius)
			local yadd = math.sin(angle) * random(1, t.radius)
			
			x, y = t.x + xadd, t.y + yadd
			z = Map.IsOutdoor() and Map.GetGroundLevel(x, y) or t.z
			if Map.IsOutdoor() or Map.RoomFromPoint(x, y, z) > 0 then
				break
			end
		end
		SummonItem(t.item or 1, x, y, z, nil)
		local obj = Map.Objects[Map.Objects.High]
		local item = obj.Item
		table.insert(objects, obj)
		table.insert(items, item)
		if t.level then
			item:Randomize(t.level, t.typ or const.ItemType.Any)
			obj.Type, obj.TypeIndex = Game.ItemsTxt[item.Number].SpriteIndex, Game.ItemsTxt[item.Number].SpriteIndex
		end
	end
	return items, objects
end

function pseudoSpawnpointPrint()
	print(("pseudoSpawnpoint{monster = 1, x = %d, y = %d, z = %d, count = isMedium() and \"1-3\" or \"3-5\", powerChances = isMedium() and {60, 30, 10} or {34, 33, 33}, radius = 512}"):format(Party.X, Party.Y, Party.Z))
end

function pseudoSpawnpointItemPrint()
	print(("pseudoSpawnpointItem{item = 1, x = %d, y = %d, z = %d, count = 1, radius = 64}"):format(Party.X, Party.Y, Party.Z))
end

psp = pseudoSpawnpointPrint
psip = pseudoSpawnpointItemPrint

-- BUGFIX BY CTHSCR: shield spell halves projectile damage now (was bugged to not do this)
mem.asmpatch(0x43800A, [[
cmp dword ptr [0xB21818 + 0x4], 0
jl @std
jg @half
cmp dword ptr [0xB21818], 0
jbe @std
@half:
sar dword ptr [ebp - 0x4], 1
@std:
cmp dword ptr [ebx + 0x1B08], 0
]])

function randomizeAndSetCorrectType(id, level, typ) -- just Randomize() leaves item look on map unchanged
	if Merge.ModSettings.Rev4ForMergeRandomizeRemovedItems == 1 then
		local obj = Map.Objects[id]
		obj.Item:Randomize(level, typ)
		obj.Type = Game.ItemsTxt[obj.Item.Number].SpriteIndex
		obj.TypeIndex = Game.ItemsTxt[obj.Item.Number].SpriteIndex
	else
		Map.RemoveObject(id)
	end
end

function events.GameInitialized2()
	-- changed resistance spell descriptions
	-- for i, v in ipairs({3, 14, 25, 36, 58, 69}) do local sp = Game.SpellsTxt[v]; print(dump(sp)) end
	for i, v in ipairs({3, 14, 25, 36, 58, 69}) do
		local sp = Game.SpellsTxt[v]
		sp.Description = sp.Description:gsub("(your skill)", string.format("%d + %d * %%1", 10, 2))
		for i, idx in ipairs({"Normal", "Expert", "Master", "GM"}) do
			sp[idx] = sp[idx]:gsub("%d point", string.format("%d + %d point", 10, i + 1))
		end
	end
end

-- QUESTS IN SCHOOL OF SORCERY AND BREEDING PIT (maybe make completing one a condition for completing other for extra variety?)

-- writing information about map objects to file
-- to use I launched the game and started new party on Antagarich
-- (you shouldn't load a saved game, because some items might be
-- missing, because they were collected (I was bitten by this)
--[=[local file = io.open("Output map items merge.txt", "wb")
local prevI
i = 62
outT = {"Map name\tObject id\tItem number\tItem name\tX\tY\tZ"}
local first = true
function fn()
	if Game.CurrentScreen ~= const.Screens.Game then return end
	evt.MoveToMap{Name = i <= 207 and Game.MapStats[i].FileName or "7out01.odm"}
	--coroutine.resume(coroutine.create(Sleep), 3000))
	--local t = {}
	if not first and prevI <= 207 then
		for k, v in Map.Objects do
			if v.Item then
				--table.insert(t, {k, v.Item.Number, Game.ItemsTxt[v.Item.Number].Name})
				table.insert(outT, string.format("%s\t%d\t%d\t%s\t%d\t%d\t%d", Game.MapStats[prevI].FileName:lower(), k, v.Item.Number, Game.ItemsTxt[v.Item.Number].Name, v.X, v.Y, v.Z))
			end
		end
	else
		first = false
	end
	--[[for k, v in ipairs(t) do
		t[k] = v[1] .. "\t" .. v[2] .. "\t" .. v[3]
	end
	debug.Message("Map name: " .. sorted[i].Name .. "("  .. sorted[i].FileName .. ")", unpack(t))]]
	prevI = i
	i = i + 1
	if i == 137 then
		prevI = 136
		i = 207
	end
end
local once = true
function events.LoadMap()
	if i > 207 + 1 then
		if once then
			once = false
			file:write(table.concat(outT, "\r\n"))
			file:close()
		end
		events.Remove(1)
		return
	end
	Timer(fn, 1, false) -- timer is removed on next map load
end]=]

function mtm2(str) local t = str:split("\t") t[1] = tonumber(t[1]) t[2] = tonumber(t[2]) t[3] = tonumber(t[3]) XYZ(Party, t[1], t[2], t[3]) end

function changeChestItem(chest, index, item)
	local chestItem = Map.Chests[chest].Items[index]
	if type(item) == "number" then
		chestItem.Number = item
	elseif type(item) == "table" and not item.level then
		for k, v in pairs(item) do
			chestItem[k] = v
		end
	elseif type(item) == "table" and item.level then
		chestItem:Randomize(item.level, item.type or const.ItemType.Any)
	end
	return true
end

function addChestItem(chest, item)
	for i, chestItem in Map.Chests[chest].Items do
		if chestItem.Number == 0 then
			changeChestItem(chest, i, item)
			return true
		end
	end
	return false
end

function removeChestItem(chest, index)
	local setZero = {"Number", "Bonus", "BonusStrength", "Bonus2", "Charges", "MaxCharges"}
	local setFalse = {"Identified", "Broken", "Hardened", "Stolen"}
	local item = Map.Chests[chest].Items[index]
	for i, v in ipairs(setZero) do
		item[v] = 0
	end
	for i, v in ipairs(setFalse) do
		item[v] = false
	end
	return true
end