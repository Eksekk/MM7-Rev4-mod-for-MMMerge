local max, min, ceil, floor, random, sqrt = math.max, math.min, math.ceil, math.floor, math.random, math.sqrt
local ReadyMons = {}
local MonBolStep = {}
OriginalMonstersTxt = nil

---- Additional mon properties and bolster tables

const.Bolster = {}

const.Bolster.Types = {
	NoBolster 		= 0,
	OriginalStats	= 1,
	LowerToEqual	= 2,
	AllToEqual		= 3
}

-- Fix const.MonsterKind
const.MonsterKind = {
	Undead = 1,
	Dragon = 2,
	Swimmer = 3,
	Immobile = 4,
	Peasant = 5,
	NoArena = 6,
	Ogre = 7,
	Elemental = 8,
	Demon = 9,
	Titan = 10,
	Elf = 11,
	Goblin = 12,
	Dwarf = 13,
	Human = 14
}

const.Bolster.MonsterType = {
	Unknown		= 0,
	Undead 		= 1,
	Dragon 		= 2,
	Swimmer		= 3,
	Immobile	= 4,
	Peasant		= 5,
	NoArena		= 6,
	Ogre		= 7,
	Elemental	= 8,
	Demon 		= 9,
	Titan 		= 10,
	Elf 		= 11,
	Goblin		= 12,
	Dwarf		= 13,
	Human		= 14,
	DarkElf		= 15,
	Lizardman	= 16,
	Minotaur	= 17,
	Troll		= 18,
	Creature	= 19,
	Construct	= 20
	}

const.Bolster.Creed = {
	Neutral	= 0,
	Light 	= 1,
	Dark 	= 2,
	Peasant = 3	-- for hireable creatures
	}

const.Bolster.Magic = {
	Any		= 0,
	Fire	= 1,
	Air		= 2,
	Water	= 3,
	Earth	= 4,
	Spirit	= 5,
	Mind	= 6,
	Body	= 7,
	Light	= 8,
	Dark	= 9,
	Self	= 10,
	Elemental = 11
	}

const.Bolster.Style = {
	Strength	= 0,
	Endurance 	= 1,
	Speed 		= 2,
	Magic		= 3,
	Wimpy		= 4
	}

local function ProcessBolsterTxt()

	local Warning = ""

	local function GetProp(Val, Type, i)
		local result = tonumber(Val) or const.Bolster[Type][Val] or 0
		if not result then
			result = 0
			Warning = Warning .. "Undefined property, line: " .. i .. ", type: " .. Type .. "\n"
		end
		return result
	end

	---- Monsters:

	Game.Bolster = {}
	Game.Bolster.Monsters = {}

	local Bolster = Game.Bolster.Monsters
	local BolsterTxt = io.open("Data/Tables/Bolster - monsters.txt", "r")

	if not BolsterTxt then
		BolsterTxt = io.open("Data/Tables/Bolster - monsters.txt", "w")
		BolsterTxt:write("#	Note	Type	ExtraType	Creed	Style	Pref magic	NoArena	Allow ranged attacks	Allow spells	HP by size	Allow replicate	Allow summons	Summon Id	Extra points	Max HP Boost (%)\n")
		for i,v in Game.MonstersTxt do
			BolsterTxt:write(i .. "\9" .. v.Name .. "\9\9\9\9\9\9-\9-\9-\9-\9-\9-\9\9\n")
			Bolster[i] = {Type = 0, Creed = 0, Style = 0, PrefMagic = 0, Ranged = false, Spells = false, HPBySize = false, Summons = false, SummonId = 0, LevelShift = 0}
		end
	else
		local LineIt = BolsterTxt:lines()
		LineIt() -- skip header

		for line in LineIt do
			local Words = string.split(line, "\9")
			local CurId = tonumber(Words[1]) or 0
			Bolster[CurId] = {
				Type 		= GetProp(Words[3], "MonsterType", CurId),
				ExtraType 	= {},
				Creed 		= GetProp(Words[5], "Creed", CurId),
				Gender 		= Words[6] == "F" and "F" or "M",
				Style	 	= GetProp(Words[7], "Style", CurId),
				Magic 		= GetProp(Words[8], "Magic", CurId),
				NoArena 	= Words[9]  == "x",
				Ranged 		= Words[10] == "x",
				Spells 		= Words[11] == "x",
				HPBySize	= Words[12] == "x",
				Replicate	= Words[13] == "x",
				Summons 	= Words[14] == "x",
				SummonId 	= tonumber(Words[15]) or 0,
				LevelShift 	= tonumber(Words[16]) or 0,
				MaxHPBoost	= (tonumber(Words[17]) or 300)/100}
			local types = string.split(Words[4], ",")
			for _, v in pairs(types) do
				local mon_type = GetProp(v, "MonsterType", CurId)
				if mon_type and mon_type > 0 then
					table.insert(Bolster[CurId].ExtraType, mon_type)
				end
			end
		end

		if string.len(Warning) > 0 then
			Warning = 'Errors in "Bolster - monsters.txt":\n'
			debug.Message(Warning)
		end
	end

	BolsterTxt:close()

	---- Per-map restrictions:

	Game.Bolster.Maps = {}
	Game.Bolster.MapsSource = {}

	Bolster = Game.Bolster.Maps
	BolsterTxt = io.open("Data/Tables/Bolster - maps.txt", "r")

	if not BolsterTxt then
		BolsterTxt = io.open("Data/Tables/Bolster - maps.txt", "w")
		BolsterTxt:write("#	Note	Continent	Bolster kind	Spells	Summons	Level shift\n")
		for i,v in Game.MapStats do
			BolsterTxt:write(i .. "\9" .. v.Name .. "\9\9NoBolster\9-\9-\9-\9\9\n")
			Bolster[i] = {Continent = 1, Type = 0, Spells = false, Summons = false, Weather = false, LevelShift = 0, CustomSky = false}
		end
	else
		local LineIt = BolsterTxt:lines()
		LineIt() -- skip header

		for line in LineIt do
			local Words = string.split(line, "\9")
			local CurId = tonumber(Words[1]) or 0
			Bolster[CurId] = {
				Continent	= tonumber(Words[3]) or 1,
				Type 		= GetProp(Words[4], "Types", CurId),
				Spells 		= Words[5] == "x",
				Summons	 	= Words[6] == "x",
				Weather	 	= Words[7] == "x",
				LevelShift	= tonumber(Words[8]) or 0,
				CustomSky 	= string.len(Words[10]) > 0 and Words[10] or false,
				ProfsMaxRarity = tonumber(Words[9]) or 0}

			Game.Bolster.MapsSource[CurId] = table.copy(Bolster[CurId])
		end

		if string.len(Warning) > 0 then
			Warning = 'Errors in "Bolster - monsters.txt":\n'
			debug.Message(Warning)
		end
	end

	BolsterTxt:close()

	----

	Game.Bolster.MonstersSource = Game.Bolster.Monsters

	---- Formulas:

	Game.Bolster.Formulas = {}
	Bolster = Game.Bolster.Formulas
	BolsterTxt = io.open("Data/Tables/Bolster - formulas.txt", "r")

	if BolsterTxt then
		local LineIt = BolsterTxt:lines()
		LineIt() -- skip header

		for line in LineIt do
			local Words = string.split(line, "\9")
			if Words[1] and Words[2] and Words[3] and string.len(Words[1]) > 0 and string.len(Words[2]) > 0 then
				local CurId = tonumber(Words[1]) or Words[1]
				local str
				Bolster[CurId] = Bolster[CurId] or {}

				if string.len(Words[3]) == 0 then
					str = "return false"
				elseif string.find(Words[3], "return") then
					str = Words[3]
				else
					str = "return " .. Words[3]
				end

				Bolster[CurId][Words[2]] = str
			end
		end
	end

end

local OffensiveSpells = {
{2,6,11},		-- fire
{15,18},		-- air
{24,26,29,32},	-- water
{39,41},		-- earth
{46,47,51,59},	-- spirit
{59,65},		-- mind
{68,70,76},		-- body
{78,87},		-- light
{90,93,95}		-- dark
}

local DefensiveSpells = {
{5},			-- fire
{17},			-- air
{26},			-- water
{38},			-- earth
{46,47,51,52},	-- spirit
{59,65},		-- mind
{68,71,77},		-- body
{86},			-- light
{95}			-- dark
}

local HPMulByStyle 		= {[0] = 1, 1.3, 0.9, 0.7, 0.5}
local DamageMulByStyle 	= {[0] = 1.5, 1, 1.2, 1, 1}
local BolsterTypes = const.Bolster.Types

local function GetOverallPartyLevel()
	local Ov, Cnt = 0, 1
	for i,v in Party do
		Ov = Ov + v.LevelBase
		Cnt = i + 1
	end
	return ceil(Ov/Cnt)
end

local function GetOverallItemBonus() -- approximate equipped items costs as their power
	local result = 0
	for ip,player in Party do
		for i,v in player.EquippedItems do
			if v > 0 then
				result = result + player.Items[v]:GetValue()
			end
		end
	end
	return result
end

local function SetAttackMaxDamage(Attack, MaxDamage)
	MaxDamage = ceil(MaxDamage)

	local Dices, Sides
	local FixDamage = MaxDamage * random(1,3)/10

	MaxDamage = MaxDamage - FixDamage
	Dices = sqrt(MaxDamage)
	Sides = Dices + random(ceil(sqrt(Dices)))

	Attack.DamageAdd 		= FixDamage
	Attack.DamageDiceSides 	= Sides
	Attack.DamageDiceCount 	= Dices
end

local function GenMonSpell(MonSettings, BolStep, SpellNum, OtherSpell)

	local Magic, Creed, Style, Ranged = MonSettings.Magic, MonSettings.Creed, MonSettings.Style, MonSettings.Ranged
	local NoSpell = SpellNum == 2 and (Style == 0 or Style == 2) or Style == 4

	if NoSpell then
		return 0
	end

	local School, Spell
	if Magic == 0 then
		School = random(1,9)
	elseif Magic < 10 then
		School = Magic
	elseif Magic == 10 then
		School = random(5,7)
	elseif Magic == 11 then
		School = random(1,4)
	end

	-- Light mages always have one offensive spell and one defensive spell.
	-- Dark mages always have two offensive spells.
	-- Strength monsters have one offensive or defensive spell according to ability to use ranged attacks.
	-- Endurance monsters have two defensive spells.
	-- Speed monsters have one defensive spell.

	local IsOffensive =
					(Creed == 2 and Style == 3)
				or 	(Creed ~= 2 and Style == 3 and SpellNum == 0)
				or 	(Style == 0 and SpellNum == 0)

	local SpellSet
	if IsOffensive then
		SpellSet = OffensiveSpells[School]
	else
		SpellSet = DefensiveSpells[School]
	end

	Spell = min(#SpellSet, BolStep + SpellNum)
	Spell = SpellSet[random(1,Spell)]

	if OtherSpell and OtherSpell == Spell then
		Spell = DefensiveSpells[School][1]
		if OtherSpell == Spell then
			Spell = 0
		end
	end

	return Spell

end

local BolStep, MonTable, MonKind
local TotalEquipCost
local MonsSettings
local BolsterMul
local Formulas

local function GetMaxDamage(Attack)
	return Attack.DamageDiceCount*Attack.DamageDiceSides+Attack.DamageAdd
end

function GetAvgLevel(mi)
	local mk = ceil(mi/3)
	local result = 0
	for p = 0, 2 do
		result = result + Game.MonstersTxt[mk*3-p].Level + MonsSettings[mk*3-p].LevelShift
	end
	return max(ceil(result/3), 3)
end

-- formulas variables

-- these globals are used for txt monsters only, because they are overwritten with each monster
local PartyLevel,MonsterLevel,TotalEquipCost,HP,BoostedHP,AC,MonsterHeight,MaxDamage,SpellSkill,SpellMastery,BolsterMul,MonsterPower,MonSettings,MoveSpeed,MapSettings
-- after processing txt, this table receives the data (indexed by monster id) and spell formulas in PrepareMapMon() use this
local formulaVariables = {}

function events.BeforeLoadMap()
	formulaVariables = {}
end

local env = {
	max				= max,
	min				= min,
	ceil			= ceil,
	floor			= floor,
	sqrt			= sqrt,
	random			= random
	}
	
-- addVariables is used in PrepareMapMon, because if a monster in txt doesn't have spells, but when modified individually gets them,
-- SpellSkill and SpellMastery aren't defined, because PrepareTxtMon skips setting it (it's nil)
local function ProcessFormula(Formula, Default, monId, addVariables)
	local f = Formula and assert(loadstring(Formula))

	if type(f) == "function" then
		if not monId then
			env.PartyLevel 		= PartyLevel
			env.MonsterLevel 	= MonsterLevel
			env.TotalEquipCost 	= TotalEquipCost
			env.HP				= HP
			env.BoostedHP 		= BoostedHP
			env.AC 				= AC
			env.MonsterHeight 	= MonsterHeight
			env.MaxDamage 		= MaxDamage
			env.SpellSkill		= SpellSkill
			env.SpellMastery 	= SpellMastery
			env.BolsterMul 		= BolsterMul
			env.MonsterPower 	= MonsterPower
			env.MonSettings 	= MonSettings
			env.MapSettings 	= MapSettings
			env.MoveSpeed		= MoveSpeed
		else
			if addVariables then
				table.copy(addVariables, formulaVariables[monId])
			end
			assert(tlen(formulaVariables[monId]) == 15)
			table.copy(formulaVariables[monId], env, true)
		end

		setfenv(f, env)
		return f()
	else
		debug.Message(f, Formula, debug.traceback())
	end
	return Default
end
	
local maxI1, maxI2, maxI4, maxI8, maxU1, maxU2, maxU4, maxU8 = 127, 32767, 2147483647,
	9223372036854775807, 255, 65535, 4294967295, 18446744073709551615

local function calcNewCurrentHp(oldFullHP, newFullHP, hp)
	if hp > 0 then
		local hitPointPercentage = oldFullHP and min(hp / oldFullHP, 1) or 1
		local scaled = floor(newFullHP * hitPointPercentage)
		return max(min(scaled, maxI2), 1)
	else
		return 0
	end
end

local SpellReplace = {[81] = 87}
function PrepareMapMon(mon)

	local TxtMon		= Game.MonstersTxt[mon.Id]
	local MonSettings	= Game.Bolster.Monsters[mon.Id]
	local BolStep		= MonBolStep[mon.Id]
	local oldMonBackup = tget(mapvars, "oldMons", mon:GetIndex(), "properties")
	mapvars.oldMons[mon:GetIndex()].id = mon.Id
	
	local function scaleParam(param, maxVal, onlyReturn)
		local parts = string.split(param, "%.")
		local monster, orig, txt = mon, OriginalMonstersTxt[mon.Id], TxtMon
		for i = 1, #parts - 1 do
			local part = parts[i]
			monster, orig, txt = monster[part], orig[part], txt[part]
		end
		local part = parts[#parts]
		oldMonBackup[param] = monster[part]
		if orig[part] ~= 0 then -- avoid divide by zero
			local scale = txt[part] / orig[part]
			if scale ~= scale then -- check for NaN
				error("scale is Not a Number")
			end
			local val = min(maxVal, math.round(monster[part] * scale))
			if onlyReturn then
				return val
			end
			monster[part] = val
		else
			if onlyReturn then
				return min(maxVal, txt[part])
			end
			monster[part] = min(maxVal, txt[part])
		end
	end

	if vars.ExtraSettings.UseMonsterBolster then
		-- Base stats
		
		-- formulas
		local MapSettings = Game.Bolster.Maps[Map.MapStatsIndex]
		local PartyLevel
		if MapSettings then
			PartyLevel = GetOverallPartyLevel() + MapSettings.LevelShift
		else
			return
		end
		
		Formulas = Game.Bolster.Formulas
		MonKind = ceil(mon.Id/3)
		local Formula = Formulas[MonKind] or Formulas["def"]
		
		local function getFormulaOrDefault(stat)
			return Formula[stat] or Formulas["def"][stat]
		end
		
		-- ~formulas

		local oldMonFullHP = tget(mapvars, "oldMonFullHP")
		mon.HP = calcNewCurrentHp(oldMonFullHP[mon:GetIndex()], scaleParam("FullHP", maxI2, true), mon.HP)
		oldMonFullHP[mon:GetIndex()] = nil
		scaleParam("FullHP", maxI2)

		scaleParam("ArmorClass", maxI4)
		scaleParam("MoveSpeed", maxI4)

		-- Attacks

		scaleParam("Attack1.DamageAdd", maxU1)
		scaleParam("Attack1.DamageDiceSides", maxU1)
		scaleParam("Attack1.DamageDiceCount", maxU1)

		scaleParam("Attack2.DamageAdd", maxU1)
		scaleParam("Attack2.DamageDiceSides", maxU1)
		scaleParam("Attack2.DamageDiceCount", maxU1)

		scaleParam("Attack2Chance", 80)
		if (not mon.Attack2.Missile or mon.Attack2.Missile == 0) and mon.Attack2Chance > 0 then
			oldMonBackup["Attack2.Missile"] = mon.Attack2.Missile
			mon.Attack2.Missile 		= TxtMon.Attack2.Missile
		end
		if not mon.Attack2.Type or mon.Attack2.Type == 0 and mon.Attack2Chance > 0 then
			oldMonBackup["Attack2.Type"] = mon.Attack2.Type
			mon.Attack2.Type 			= TxtMon.Attack2.Type
		end

		-- Spells
		-- Monsters can not cast paralyze, replace it:
		mon.Spell = SpellReplace[mon.Spell] or mon.Spell
		mon.Spell2 = SpellReplace[mon.Spell2] or mon.Spell2

		-- Base spells
		-- FIXME: -- this code occasionally reduces spell skill/mastery if there is custom boss with high skill
		-- this is fixed, but bolster still won't make their skill higher, as it probably should
		local Skill, Mas
		local BuffSpells = not (GetAvgLevel(mon.Id) >= PartyLevel and MapSettings.Type ~= BolsterTypes.AllToEqual)
		local NeedSpells = BuffSpells and MapSettings.Spells and MonSettings.Spells
		local function doSpell(isSecond)
			local spellKey, chanceKey, skillKey = isSecond and "Spell2" or "Spell", isSecond and "Spell2Chance" or "SpellChance", isSecond and "Spell2Skill" or "SpellSkill"
			if mon[spellKey] == 0 and NeedSpells then
				oldMonBackup[spellKey] = mon[spellKey]
				
				mon[spellKey] = GenMonSpell(MonSettings, BolStep, isSecond and 1 or 0, isSecond and mon[spellKey])
				if mon[spellKey] ~= 0 then
					oldMonBackup[chanceKey] = mon[chanceKey]
					oldMonBackup[skillKey] = mon[skillKey]
					mon[chanceKey]		= TxtMon[chanceKey]
					mon[skillKey] 		= TxtMon[skillKey]
				end
			elseif mon[spellKey] ~= 0 and BuffSpells and MapSettings.Type ~= BolsterTypes.OriginalStats then
				oldMonBackup[skillKey] = mon[skillKey]
				local SpellSkill, SpellMastery = SplitSkill(mon[skillKey])
				local ov = {SpellSkill = SpellSkill, SpellMastery = SpellMastery}
				Skill = ProcessFormula(getFormulaOrDefault("SpellSkill"), SpellSkill, mon.Id, ov)
				Mas   = ProcessFormula(getFormulaOrDefault("SpellMastery"), SpellMastery, mon.Id, ov)
				mon[skillKey] = JoinSkill(math.max(SpellSkill, Skill), math.max(SpellMastery, Mas))
			end
		end

		doSpell()
		doSpell(true)

		-- Summons
		if mon.Special == 3 then -- explode
			-- scaling because these params directly affect damage
			scaleParam("SpecialA", maxU1)
			scaleParam("SpecialB", maxU1)
			scaleParam("SpecialC", maxU1)
		elseif mon.Special == 0 then -- don't override existing specials
			oldMonBackup.Special 		= mon.Special
			oldMonBackup.SpecialA 	= mon.SpecialA
			oldMonBackup.SpecialB 	= mon.SpecialB
		--	oldMonBackup.SpecialC 	= mon.SpecialC
			oldMonBackup.SpecialD 	= mon.SpecialD
			
			mon.Special 	= TxtMon.Special
			mon.SpecialA 	= TxtMon.SpecialA
			mon.SpecialB 	= TxtMon.SpecialB
		--	mon.SpecialC 	= TxtMon.SpecialC
			mon.SpecialD 	= TxtMon.SpecialD
		end
		scaleParam("Level", maxU1)
	end

	-- Rewards
	-- bolster monster doesn't touch rewards, so this code effectively removes any custom rewards besides gold (and maybe set item)
	--[[
	mon.Experience = TxtMon.Experience
	mon.TreasureItemPercent = TxtMon.TreasureItemPercent
	mon.TreasureItemLevel	= TxtMon.TreasureItemLevel
	]]
	oldMonBackup.Experience = mon.Experience
	mon.Experience = math.round(mon.Experience * diffsel(1, 1.15, 1.3))
	if Merge.ModSettings.Rev4ForMergeNerfGoldGains == 1 then
		oldMonBackup.TreasureDiceCount = mon.TreasureDiceCount
		mon.TreasureDiceCount = math.round(mon.TreasureDiceCount * diffsel(1, 4/3, 2)) -- make monster gold relatively constant on every difficulty
	end
end

-- save old monster full HP to restore when loading saved game
-- (old properties are cleared before PrepareMapMon runs)

local function saveOldMonFullHP()
	mapvars.oldMonFullHP = {}
	for i, mon in Map.Monsters do
		mapvars.oldMonFullHP[i] = mon.FullHP
	end
end
events.BeforeSaveGame = saveOldMonFullHP

-- when leaving game, first leave map runs and zeroes
function events.LeaveMap()
	mapvars.oldMonFullHP = {} -- clear old hp if leaving map (NOT loading saved game)
	OriginalMonstersTxt = nil
end

local eventTypes = {"Before", "", "After"}
for i, v in ipairs(eventTypes) do
	events[v .. "LoadMap"] = function()
		if vars.lastVisitedMap and vars.lastVisitedMap == Map.Name then
			events.call(v .. "LoadSaveGame")
		end
	end
end

-- recent problem (fixed now):
-- enter with bolster: hp increased, old full hp saved in mapvars
-- 1. reenter map with bolster: hp = full hp, preparemapmon runs, hp is 100% of new full hp
-- 2. reenter map without bolster: hp = old full hp, restore runs, hp > full hp
-- 3. reload savegame without bolster: hp = old hp, restore runs, maybe hp > full hp
-- 4. reload savegame with bolster: hp = old hp, restore old full hp, preparemapmon runs, percentage = hp / old full hp, hp = percentage * new full hp

function restoreMonster(index, props)
	props = props or tget(mapvars, "oldMons", index, "properties")
	if type(props) == "table" and index >= 0 and index <= Map.Monsters.High then
		for k, v in pairs(props) do
			local mon = Map.Monsters[index]
			-- if bolster is active, PrepareMapMon() will adjust current HP
			-- BUG! Game.UseMonsterBolster is nil when params are restored (first ever load map)
			-- use vars instead
			if k == "FullHP" and not vars.ExtraSettings.UseMonsterBolster then
				mon.HP = calcNewCurrentHp(mon.FullHP, props.FullHP, mon.HP)
			end
			local parts = string.split(k, "%.")
			for j = 1, #parts - 1 do
				local part = parts[j]
				mon = mon[part]
			end
			mon[parts[#parts]] = v
		end
	end
end

local function checkMonster(index)
	if mapvars.oldMons[index].id ~= Map.Monsters[index].Id then
		debug.Message(string.format("Couldn't restore monster index %d: saved id (%d) doesn't match real id (%d)", index, mapvars.oldMons[index].id, Map.Monsters[index].Id))
		return false
	end
	return true
end

-- update monsters indexes in mapvars when they are changed by shrinking table, otherwise they could refer to invalid monsters
function events.MapMonstersIndexesChanged(t)
	updateMonsterIndexes(mapvars, "oldMons", t)
	updateMonsterIndexes(mapvars, "oldMonFullHP", t)
end

local function restore()
	if Editor and Editor.WorkMode then return end
	if not mapvars.oldMons then return end
	for i, v in pairs(mapvars.oldMons) do -- no ipairs, because indexes aren't sequential
		if checkMonster(i) then
			restoreMonster(i, v.properties)
		end
	end
	mapvars.oldMons = nil
end

events.AddFirst("LoadMap", restore) -- can't be BeforeLoadMap, because Map.Monsters isn't initialized yet

-- instantly restores dead monsters, in case Map.Monsters is shrunk (MiscTweaks.lua has something like that)
-- otherwise index in mapvars might refer to invalid, or even worse, another monster than originally saved
local function processDeadMonsters()
	if Editor and Editor.WorkMode then return end
	if not mapvars.oldMons then return end
	if Map.Monsters.High == -1 then return end -- map not loaded fully? happened when restoring uv
	
	local clear = {}
	for i, v in pairs(mapvars.oldMons) do
		if i < Map.Monsters.Low or i > Map.Monsters.High then
			table.insert(clear, i)
		else
			local mon = Map.Monsters[i]
			if mon.HP == 0 and mon.AIState == const.AIState.Removed then -- check for removed because player might want to resurrect buffed monster
				if checkMonster(i) then
					restoreMonster(i, v.properties)
				end
				table.insert(clear, i)
			end
		end
	end
	for i, v in ipairs(clear) do
		mapvars.oldMons[v] = nil
	end
end

events.BeforeSaveGame = processDeadMonsters
events.LeaveMap = processDeadMonsters
--events.LeaveGame = processDeadMonsters

local function PrepareTxtMon(i, OnlyThis)
	MonsSettings = Game.Bolster.Monsters
	MapSettings = Game.Bolster.Maps[Map.MapStatsIndex]
	if MapSettings then
		PartyLevel = GetOverallPartyLevel() + MapSettings.LevelShift
	else
		return
	end
	if not Game.UseMonsterBolster or PartyLevel < 0 or MapSettings.Type == 0 then
		return
	end
	
	TotalEquipCost = GetOverallItemBonus()
	BolsterMul = Game.BolsterAmount/100
	Formulas = Game.Bolster.Formulas

	MonTable = {}

	if type(i) == "number" then
		MonKind = ceil(i/3)
		MonTable = OnlyThis and {[i] = Game.MonstersTxt[i]}
			or 	{	[MonKind*3-2] = Game.MonstersTxt[MonKind*3-2],
					[MonKind*3-1] = Game.MonstersTxt[MonKind*3-1],
					[MonKind*3  ] = Game.MonstersTxt[MonKind*3  ]}

	elseif type(i) == "table" then
		for k,v in pairs(i) do
			MonKind = ceil(v/3)
			MonTable[MonKind*3-2] = Game.MonstersTxt[MonKind*3-2]
			MonTable[MonKind*3-1] = Game.MonstersTxt[MonKind*3-1]
			MonTable[MonKind*3  ] = Game.MonstersTxt[MonKind*3  ]
		end
	else
		return
	end

	for k,v in pairs(MonTable) do
		if ReadyMons[k] or GetAvgLevel(k) >= PartyLevel and MapSettings.Type ~= BolsterTypes.AllToEqual then
			MonTable[k] = nil
		end
	end

	local commonVars = {
		MapSettings = MapSettings,
		PartyLevel = PartyLevel,
		TotalEquipCost = TotalEquipCost,
		BolsterMul = BolsterMul,
	}

	for monId, mon in pairs(MonTable) do

		MonKind 		= ceil(monId/3)
		HP 				= mon.FullHP
		BoostedHP		= mon.FullHP
		AC 				= mon.ArmorClass
		MonSettings		= MonsSettings[monId]
		MonsterHeight 	= Game.MonListBin[monId].Height
		MonsterPower	= monId - MonKind*3 + 3
		MonsterLevel	= GetAvgLevel(monId)
		BolStep 		= min(floor(PartyLevel/MonsterLevel), 4)

		SpellSkill, SpellMastery = nil, nil -- unset from previous monster

		local Formula = Formulas[MonKind] or Formulas["def"]
		local function getFormulaOrDefault(stat)
			return Formula[stat] or Formulas["def"][stat]
		end

		MonBolStep[monId] = BolStep

		if MapSettings.Type ~= BolsterTypes.OriginalStats then

			-- Base hitpoints
			mon.FullHP = min(ProcessFormula(getFormulaOrDefault("HP"), mon.FullHP), 30000)
			BoostedHP  = mon.FullHP
			-- Armor class
			mon.ArmorClass = ProcessFormula(getFormulaOrDefault("AC"), ArmorClass) -- ??? global?

			-- Attacks
			MaxDamage = GetMaxDamage(mon.Attack1)
			MaxDamage = ProcessFormula(getFormulaOrDefault("MaxDamage"), MaxDamage)
			SetAttackMaxDamage(mon.Attack1, MaxDamage)

			if mon.Attack2Chance > 0 then
				MaxDamage = GetMaxDamage(mon.Attack2)
				MaxDamage = ProcessFormula(getFormulaOrDefault("MaxDamage"), MaxDamage)
				SetAttackMaxDamage(mon.Attack2, MaxDamage)
			end

			-- Base spells

			-- wromthrax in txt doesn't have spells, so his formula variables are missing spell skill and spell mastery
			local Skill, Mas
			if mon.Spell > 0 then
				SpellSkill, SpellMastery = SplitSkill(mon.SpellSkill)
				Skill = ProcessFormula(getFormulaOrDefault("SpellSkill"), SpellSkill)
				Mas   = ProcessFormula(getFormulaOrDefault("SpellMastery"), SpellMastery)
				mon.SpellSkill = JoinSkill(Skill, Mas)
			end

			if mon.Spell2 > 0 then
				SpellSkill, SpellMastery = SplitSkill(mon.Spell2Skill)
				Skill = ProcessFormula(getFormulaOrDefault("SpellSkill"), SpellSkill)
				Mas   = ProcessFormula(getFormulaOrDefault("SpellMastery"), SpellMastery)
				mon.Spell2Skill = JoinSkill(Skill, Mas)
			end
		end

		-- Move speed
		MoveSpeed = mon.MoveSpeed
		mon.MoveSpeed = ProcessFormula(getFormulaOrDefault("MoveSpeed"), mon.MoveSpeed)

		-- Additional attacks

		if mon.Attack2Chance == 0 and MonSettings.Ranged and BolStep > 0 then
			mon.Attack2Chance 			= min(BolStep*10, 35)
			mon.Attack2.Missile 		= BolStep > 2 and (MonSettings.Magic == 0 and 1 or 6) or 0
			mon.Attack2.Type 			= mon.Attack1.Type

			MaxDamage = GetMaxDamage(mon.Attack1)
			SetAttackMaxDamage(mon.Attack2, MaxDamage)
		end

		-- Additional spells

		if ProcessFormula(getFormulaOrDefault("AllowNewSpell"), false) then

			local SkillByMas = {1,4,7,10}
			local Mas = Style == 3 and 2 or 1
			local Skill = SkillByMas[Mas]
			
			SpellSkill, SpellMastery = Skill, Mas
			Skill = ProcessFormula(getFormulaOrDefault("SpellSkill"), SpellSkill)
			Mas   = ProcessFormula(getFormulaOrDefault("SpellMastery"), SpellMastery)

			if mon.Spell == 0 and (BolStep >= 1 or MonSettings.Style == 3) then
				mon.SpellSkill = JoinSkill(Skill, Mas)
				mon.SpellChance = MonSettings.Style == 3 and 60 or 35
			end

			if mon.Spell2 == 0 and (BolStep >= 2 or (MonSettings.Style == 3 and BolStep >= 1)) then
				mon.Spell2Skill = JoinSkill(Skill, Mas)
				mon.Spell2Chance = MonSettings.Style == 3 and 35 or 20
			end
		end

		-- Summons

		if ProcessFormula(getFormulaOrDefault("AllowReplicate"), false) then

			mon.Special = 4
			mon.SpecialA = 0
			mon.SpecialB = 0
			mon.SpecialC = 2
			mon.SpecialD = MonSettings.SummonId

		end

		if ProcessFormula(getFormulaOrDefault("AllowSummons"), false) then

			mon.Special = 2
			mon.SpecialA = mon.MoveType == 5 and 0 or max((1 + BolStep),3) -- If monster always stands still, like Trees in The Tularean forest, he will behave like spawn point.
			mon.SpecialB = Game.MonstersTxt[MonSettings.SummonId].Fly == 1 and 0 or 1 -- if summon can fly he will be summoned in air.
			mon.SpecialC = 0
			mon.SpecialD = MonSettings.SummonId == 0 and monId or MonSettings.SummonId

		end

		local vars = {
			HP = HP,
			BoostedHP = BoostedHP,
			AC = AC,
			MonSettings = MonSettings,
			MonsterHeight = MonsterHeight,
			MonsterPower = MonsterPower,
			MonsterLevel = MonsterLevel,
			MaxDamage = MaxDamage,
			SpellSkill = SpellSkill, -- ??? maybe overwritten by second spell?
			SpellMastery = SpellMastery, -- same as above
			MoveSpeed = MoveSpeed,	
		}
		table.copy(commonVars, vars)
		formulaVariables[mon.Id] = vars

		ReadyMons[monId] = true

	end

end

bolsterPerformed = false -- this will get set to true after performing initial bolster, because I summon monsters
	-- before that, and we don't want to boost them twice

-- variables that keep track of what to restore from unboosted monsters.txt when summoning
local restoreParams = {"FullHP", "ArmorClass", "Attack2Chance", "Spell", "Spell2", "SpellSkill", "Spell2Skill", "SpellChance", "Spell2Chance", "MoveSpeed", "SpecialA", "SpecialB", "SpecialC", "SpecialD"}
local restoreAttacks = {"Attack1", "Attack2"}
local restoreAttackParams = {"DamageDiceCount", "DamageDiceSides", "DamageAdd", "Type", "Missile"}

function restoreMonsterParams(mon, txt)
	for _, par in ipairs(restoreParams) do
		mon[par] = assert(txt[par])
	end
	for _, attack in ipairs(restoreAttacks) do
		for _, par in ipairs(restoreAttackParams) do
			mon[attack][par] = assert(txt[attack][par])
		end
	end
	mon.HP = mon.FullHP
end

-- TODO: monsters existing, but boosted after initial bolster lose their boosted stats on restore, unless RestoreMonster and then PrepareMapMon is used

local function Init()

	ProcessBolsterTxt()
	Game.Bolster.ReloadTxt = ProcessBolsterTxt

	local function onMonsterSummoned(mon, eventName, ...)
		-- fix monsters summoned after initial bolster not having their stats restored to normal after map exit or savegame reload
		-- (because they are summoned with boosted monsters.txt in effect, so that are their "default stats")
		if bolsterPerformed then -- if original monsters txt exists
			restoreMonsterParams(mon, OriginalMonstersTxt[mon.Id])
		end
		-- callback to allow modifying monster "base stats" before saving them to restore later
		events.call(eventName, mon, bolsterPerformed, ...)

		if not (Editor and Editor.WorkMode) then
			if bolsterPerformed then
				local MapSettings = Game.Bolster.Maps[Map.MapStatsIndex]
				if MapSettings then
					-- create data if first monster of type
					if not ReadyMons[mon.Id] then
						PrepareTxtMon(mon.Id)
					end
					-- bolster. Note that this will run only after initial bolster (see "if bolsterPerformed then")
					PrepareMapMon(mon)
				end
			end
		end
	end

	local StdSummonMonster = SummonMonster

	function SummonMonster(Id, ...)
		
		local mon, i = StdSummonMonster(Id, ...)
		if not mon then
			return
		end

		onMonsterSummoned(mon, "SummonMonster")

		return mon, i
	end
	
	function events.BeforeLoadMap()
		bolsterPerformed = false
	end

	-- Set monster kind check

	function events.IsMonsterOfKind(t)
		local MonExtra = Game.Bolster.MonstersSource[t.Id]
		if t.Kind == MonExtra.Type or table.find(MonExtra.ExtraType, t.Kind) then
			t.Result = 1
		end
	end

	-- evt.SummonMonsters
	mem.autohook(0x44D0DA, function(d)
		local mon = structs.MapMonster:new(d.esi)
		onMonsterSummoned(mon, "EvtSummonMonster")
	end)

	-- Boost summons
	mem.autohook2(0x44d4b1, function(d)
		if Game.UseMonsterBolster and not ReadyMons[d.esi] then
			local MapSettings = Game.Bolster.Maps[Map.MapStatsIndex]
			if MapSettings then
				local PartyLevel = GetOverallPartyLevel() + MapSettings.LevelShift

				for i = d.esi, d.esi+2 do
					if not ReadyMons[i] then
						PrepareTxtMon(i)
					end
				end
			end
		end
	end)

	mem.autohook2(0x44D70A, function(d)
		local mon = structs.MapMonster:new(d.esi)
		local summoner = structs.MapMonster:new(d.ebx)
		onMonsterSummoned(mon, "MonsterSummonMonster", summoner)
	end)

	-- Arena monsters generation
	local ArenaMonstersList, ArenaPartyLevel, ArenaMapSettings
	function events.BeforeArenaStart(ArenaLevel)

		local PartyLevel = GetOverallPartyLevel()

		local MinLevel, MaxLevel
		if ArenaLevel == 0 then
			MinLevel = 0
			MaxLevel = max(PartyLevel, 10)
		elseif ArenaLevel == 1 then
			MinLevel = min(ceil(PartyLevel/5), 70)
			MaxLevel = max(PartyLevel, 10) + 5
		elseif ArenaLevel == 2 then
			MinLevel = min(ceil(PartyLevel/3), 70)
			MaxLevel = max(PartyLevel, 10) + 7
		elseif ArenaLevel == 3 then
			MinLevel = min(ceil(PartyLevel/2), 70)
			MaxLevel = max(PartyLevel, 10) + 10
		end

		local MinKind, MaxKind
		if ArenaLevel == 0 then
			MinKind, MaxKind = 1,1
		elseif ArenaLevel == 1 then
			MinKind, MaxKind = 1,2
		elseif ArenaLevel == 2 then
			MinKind, MaxKind = 2,3
		elseif ArenaLevel == 3 then
			MinKind, MaxKind = 3,3
		end

		local MonstersTxt = Game.MonstersTxt
		local List, Kind, MonLevel = {}, nil, nil
		for i = 1, Game.MonstersTxt.count-1 do
			Kind = 3 - i % 3
			if not (Kind < MinKind or Kind > MaxKind) then
				MonLevel = MonstersTxt[i].Level
				if not (MonLevel < MinLevel or MonLevel > MaxLevel)
						and Game.IsMonsterOfKind(i, const.MonsterKind.NoArena) == 0
						and Game.IsMonsterOfKind(i, const.MonsterKind.Peasant) == 0 then
					table.insert(List, i)
				end
			end
		end

		ArenaPartyLevel = PartyLevel
		ArenaMonstersList = List
		ArenaMapSettings = Game.Bolster.Maps[Map.MapStatsIndex]
	end

	function events.GenerateArenaMonster(t)
		local MonId = ArenaMonstersList[random(#ArenaMonstersList)]

		t.Handled = true
		t.MonId = MonId

		if Game.UseMonsterBolster and ArenaMapSettings and not ReadyMons[MonId] then
			PrepareTxtMon(MonId, true)
		end
	end

	-- Add player's armor class penalty depending on enemy's bolster
	local NewCode = mem.asmpatch(0x48db2f, [[
	add esi, eax
	cmp dword[ds:0x4F37D8], 0; Check current screen
	jnz @std

	mov edx, dword [ds:ebp-0x4c]
	cmp edx, 0
	jl @std
	cmp edx, dword [ds:0x692FB0];
	jge @std

	nop; mem hook
	nop
	nop
	nop
	nop

	xor edx, edx
	@std:
	cmp esi, 0x1]])

	local pptr, psize = Party.PlayersArray["?ptr"], Party.PlayersArray[0]["?size"]
	local function GetPlayer(ptr)
		local PlayerId = (ptr - pptr)/psize
		return Party.PlayersArray[PlayerId], PlayerId
	end

	mem.hook(NewCode + 28, function(d)
		local monId = Map.Monsters[d.edx].Id
		if Game.UseMonsterBolster and ReadyMons[monId] then
			d.esi = ceil(d.esi/(MonBolStep[monId] or 1))
		end
		local t = {MapMonId = d.edx, AC = d.esi, Player = GetPlayer(d.edi)}
		events.call("GetArmorClass", t)
		d.esi = t.AC
	end)

end

local function BolsterMonsters()

	local MapSettings = Game.Bolster.Maps[Map.MapStatsIndex]
	if not MapSettings then
		return
	end

	local PartyLevel = GetOverallPartyLevel() + MapSettings.LevelShift
	local MapInTxt = Game.MapStats[Map.MapStatsIndex]
	local t = {}

	for i,v in Game.MonListBin do
		if 		string.find(v.Name, MapInTxt.Monster1Pic)
			or	string.find(v.Name, MapInTxt.Monster2Pic)
			or	string.find(v.Name, MapInTxt.Monster3Pic) then

			if not ReadyMons[i] then
				table.insert(t, i)
			end
		end
	end

	-- summons
	for i = 97, 99 do
		table.insert(t, i)
	end

	for i,v in Map.Monsters do
		if v.Id > 0 and v.Id < Game.MonstersTxt.Limit then
			table.insert(t, v.Id)
		else
			Log(Merge.Log.Error, "%s: Monster with incorrect Id (%s) at %s %s %s", Map.Name, v.Id, v.X, v.Y, v.Z)
			v.AIState = const.AIState.Removed
		end
	end

	PrepareTxtMon(t, false)

	--if Game.UseMonsterBolster then
		for i,v in Map.Monsters do
			if v.Id > 0 and v.Id < Game.MonstersTxt.Limit then
				PrepareMapMon(v)
			end
		end
		bolsterPerformed = true
	--end
	vars.lastVisitedMap = Map.Name
end

--[[ TODO: broken, rerunning if bolster enabled after initial bolster does nothing,
	and after turning bolster off, HP isn't adjusted to max HP
Game.BolsterMonsters = function()
	saveOldMonFullHP() -- if Game.BolsterMonsters() is rerun without reloading savegame - since old hp is cleared after PrepareMapMon, "hp percentage" would be 1, refilling all monsters' HP
	restore()
	bolsterPerformed = false -- just in case
	BolsterMonsters()
end
]]

function events.AfterLoadMap()
	if Editor and Editor.WorkMode then
		return
	end
	
	OriginalMonstersTxt = deepcopyMM(Game.MonstersTxt)
	
	LocalMonstersTxt()
	ReadyMons	= {}
	MonBolStep	= {}

	BolsterMonsters()
end

function events.GameInitialized2()
	Init()
end

--[[
for k, v in Map.Monsters do
	if v.Spell ~= 0 or v.Spell2 ~= 0 then
		print(k, v.Id)
		local orig = OriginalMonstersTxt[v.Id]
		local inv = table.invert(const.Spells)
		if v.Spell ~= 0 then
			local name = inv[v.Spell]
			local os, om = SplitSkill(orig.SpellSkill)
			os = os or 0
			om = om or 0
			local bs, bm = SplitSkill(v.SpellSkill)
			bs = bs or 0
			bm = bm or 0
			print(string.format("%s, Original: JoinSkill(%d, %d), Bolstered: JoinSkill(%d, %d)", name, os, om, bs, bm))
		end
		if v.Spell2 ~= 0 then
			local name = inv[v.Spell2]
			local os, om = SplitSkill(orig.Spell2Skill)
			os = os or 0
			om = om or 0
			local bs, bm = SplitSkill(v.Spell2Skill)
			bs = bs or 0
			bm = bm or 0
			print(string.format("%s, Original: JoinSkill(%d, %d), Bolstered: JoinSkill(%d, %d)", name, os, om, bs, bm))
		end
	end
end
]]