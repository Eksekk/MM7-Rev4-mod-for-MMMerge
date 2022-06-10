-- disable town portal on antagarich when not completed archmage quest or in The Gauntlet
function events.CanCastTownPortal(t)
	if t.CanCast and Merge.Functions.GetContinent() == 2 then -- Antagarich
		t.Handled = true
		t.CanCast = evt.All.Cmp("QBits", 718)         -- Harmondale - Town Portal
	end
end

-- The Gauntlet
-- restore town portal QBits upon map leave
-- need workaround with last map name because QBits aren't set in events.LeaveMap

local lastMapName = nil
function events.LeaveMap()
	lastMapName = Game.Map.Name
end

function events.AfterLoadMap()
	if lastMapName == "7d08.blv" then
		for i = 0, 2 do
			 Party.QBits[i + 718] = vars.TheGauntletQBits and vars.TheGauntletQBits[i + 718] or false
		end
		--[[
		Party.QBits[718] = true         -- Harmondale - Town Portal
		Party.QBits[719] = true         -- Erathia - Town Portal
		Party.QBits[720] = true         -- Tularean Forest - Town Portal
		--]]
	end
end

-- increase stat breakpoint rewards

local vals = {
	500, 37,
	400, 32,
	350, 27,
	300, 26,
	275, 25,
	250, 24,
	225, 23,
	200, 22,
	180, 21,
	161, 20,
	145, 19,
	130, 18,
	116, 17,
	103, 16,
	91, 15,
	80, 14,
	70, 13,
	61, 12,
	53, 11,
	46, 10,
	40, 9,
	35, 8,
	31, 7,
	27, 6,
	24, 5,
	21, 4,
	19, 3,
	17, 2,
	15, 1,
	13, 0,
	11, -1,
	9, -2,
	7, -3,
	5, -4,
	3, -5,
	0, -6
}

if Merge.ModSettings.Rev4ForMergeChangeStatisticBreakpoints == 1 then
	function events.GetStatisticEffect(t)
		for i = 1, #vals - 2, 2 do
			if t.Value >= vals[i] then
				t.Result = vals[i + 1]
				return
			end
		end
		t.Result = vals[#vals]
	end
end

-- correct transition text for Markham's Manor
function events.GetTransitionText(t)
	if t.EnterMap:lower() == "7d18.blv" then
		t.TransId = 9
	end
end

-- Harmondale Teleportal Hub

local mapLocationsToKeys =
{
	
	[1467] = {{X = 6604, Y = -8941, Z = 0, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "7Out13.odm"}, "Tatalia"},
	[1469] = {{X = 14414, Y = 12615, Z = 0, Direction = 768, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "Out14.odm"}, "Avlee"},
	[1468] = {{X = 4586, Y = -12681, Z = 0, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "7Out05.odm"}, "Deyja"},
	[1471] = {{X = 8832, Y = 18267, Z = 0, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "7Out06.odm"}, "Bracada Desert"},
	[1470] = {{X = 17161, Y = -10827, Z = 0, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "Out09.odm"}, "Evenmorn Island"}
}

local hubNPCID = 1265

for i = 1993, 1999 do Game.GlobalEvtLines:RemoveEvent(i); evt.global[i].clear() end
for i = 0, 5 do Game.NPC[hubNPCID].Events[i] = 0 end

local slot = 0
for key, locationData in pairs(mapLocationsToKeys) do
	Quest{
		Branch = slot <= 2 and "Rev4ForMergeHarmondaleTeleportalHubFirstPartOfLocations" or "Rev4ForMergeHarmondaleTeleportalHubSecondPartOfLocations",
		NPC = hubNPCID,
		Slot = slot <= 2 and slot or slot - 3,
		Ungive = function() evt.MoveToMap(locationData[1]) end,
		CanShow = function()
			return evt.All.Cmp("Inventory", key)
		end,
		Texts = {
			Topic = locationData[2]
		}
	}
	slot = slot + 1
end

function events.EnterNPC(npc)
	if npc == hubNPCID then
		QuestBranch("Rev4ForMergeHarmondaleTeleportalHubFirstPartOfLocations")
	end
end

NPCTopic
{
	Branch = "Rev4ForMergeHarmondaleTeleportalHubFirstPartOfLocations",
	Ungive = function() QuestBranch("Rev4ForMergeHarmondaleTeleportalHubSecondPartOfLocations") end,
	Slot = 3,
	NPC = hubNPCID,
	"More destinations"
}

NPCTopic
{
	Branch = "Rev4ForMergeHarmondaleTeleportalHubSecondPartOfLocations",
	Ungive = function() QuestBranch("Rev4ForMergeHarmondaleTeleportalHubFirstPartOfLocations") end,
	Slot = 3,
	NPC = hubNPCID,
	"Go back"
}

-- BDJ change class quest

local classes =
{
	-- class = {{first promo classes}, {second promo classes(light, dark, others)}, if class from MM7 then \"MM7\" = true}, MM7 flag is only used for correct light/dark/neutral path behavior
	[const.Class.Archer] = {{const.Class.WarriorMage}, {const.Class.MasterArcher, const.Class.Sniper, const.Class.BattleMage}, ["MM7"] = true},
	--[const.Class.Cleric] = {{
}

--[[
AcolyteDark	12
AcolyteLight	10
ApprenticeMage	110
ArchDruid	40
ArchDruid3	41
ArchMage	116
ArchMage3	117
Archer	0
Assassin	90
Assassin3	91
Barbarian	92
Barbarian3	95
BarbarianDark	98
BarbarianDark3	99
BarbarianLight2	96
BarbarianLight3	97
BattleMage	2
BattleMage3	3
Berserker	93
BlackKnight	50
BlackKnight3	51
BountyHunter	82
BountyHunter3	83
Cavalier	45
Champion	46
Champion3	47
Cleric	8
ClericDark	13
ClericLight	11
Crusader	69
DarkAdept	112
Deerslayer	20
Dragon	28
DragonDark2	34
DragonDark3	35
DragonLight2	32
DragonLight3	33
Druid	36
ElderVampire	101
FlightLeader	29
GreatDruid	37
GreatWyrm	30
GreatWyrm3	31
Hero	72
Hero3	73
HighPriest	14
HighPriest3	15
Hunter	77
InitiateMonk	61
Justiciar	70
Knight	44
Mage	111
MasterArcher	4
MasterArcher3	5
MasterDruid	38
MasterDruid3	39
MasterMonk	64
MasterMonk3	65
MasterNecromancer	118
MasterNecromancer3	119
MasterWizard	114
MasterWizard3	115
Minotaur	52
MinotaurDark2	58
MinotaurDark3	59
MinotaurHeadsman	53
MinotaurLight2	56
MinotaurLight3	57
MinotaurLord	54
MinotaurLord3	55
Monk	60
Monk2	62
Monk3	63
Necromancer	113
Ninja	66
Ninja3	67
Nosferatu	102
Nosferatu3	103
NosferatuDark	106
NosferatuDark3	107
NosferatuLight	104
NosferatuLight3	105
Paladin	68
Paladin3	71
Pathfinder	22
Pathfinder3	23
PathfinderDark	26
PathfinderDark3	27
PathfinderLight	24
PathfinderLight3	25
Peasant	120
Pioneer	21
Priest	9
PriestDark	18
PriestDark3	19
PriestLight	16
PriestLight3	17
Ranger	76
Ranger2	78
Ranger3	79
RangerLord	80
RangerLord3	81
Robber	86
Robber3	87
Rogue	85
Sniper	6
Sniper3	7
Sorcerer	108
Spy	88
Spy3	89
Templar	48
Templar3	49
Thief	84
Vampire	100
Villain	74
Villain3	75
Warlock	42
Warlock3	43
Warmonger	94
WarriorMage	1
Wizard	109
nuPeas	121
]]

local classChangeChart =
{
	--[const.Class.
}

Game.GlobalEvtLines:RemoveEvent(800)
evt.global[800].clear() -- New Profession

function events.LoadMap()
	if Map.Name == "7d12.blv" then
		-- Promotion Brazier
		Game.MapEvtLines:RemoveEvent(12)
		evt.map[12].clear()
	end
end

local BDJQuestID = "BDJClassChangeQuest"
local BDJNPCID = 1259
Quest
{
	BDJQuestID,
	NPC = BDJNPCID
}

-- duplicate modded dungeons

local oldMapOfContinent = TownPortalControls.MapOfContinent
function TownPortalControls.MapOfContinent(Map)
	local MapId

	if type(Map) == "string" then
		for i,v in Game.MapStats do
			if v.FileName == Map then
				MapId = i
				break
			end
		end
	elseif type(Map) == "number" then
		MapId = Map
	else
		return TownPortalControls.GetCurrentSwitch()
	end

	if not MapId then
		return TownPortalControls.GetCurrentSwitch()
	end
	if MapId >= 208 and MapId <= 235 then
		return 3 -- Enroth
	elseif MapId >= 236 and MapId <= 240 then
		return 2 -- Antagarich
	else
		return oldMapOfContinent(Map)
	end
end

if Merge.ModSettings.Rev4ForMergeDuplicateModdedDungeons == 1 then
	local function replaceEnterEvent(num, t)
		Game.MapEvtLines:RemoveEvent(num)
		evt.map[num].clear()
		evt.map[num] = function()
			evt.MoveToMap(t)
		end
	end
	local oldPlacemonWromthrax, oldPlacemonMegaDragon
	function events.AfterLoadMap()
		if Map.Name == "7out04.odm" then -- Tularean Forest
			-- Tularean Caves
			replaceEnterEvent(502, {X = 2071, Y = 448, Z = 1, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 394, Icon = 3, Name = "7d08orig.blv"})
			-- Clanker's Lab
			replaceEnterEvent(503, {X = 0, Y = -709, Z = 1, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 395, Icon = 9, Name = "7d12orig.blv"})
		elseif Map.Name == "7d32.blv" then -- Castle Navan
			-- exit to Tularean Caves
			replaceEnterEvent(502, {X = -3257, Y = -12544, Z = 833, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 3, Name = "7d08orig.blv"})
		elseif Map.Name == "7d08orig.blv" then -- Duplicated Tularean Caves
			-- remove Loren event for now
			Game.MapEvtLines:RemoveEvent(376)
			evt.map[376].clear()
		elseif Map.Name == "7out13.odm" then -- Tatalia
			replaceEnterEvent(505, {X = -2568, Y = -143, Z = 97, Direction = 257, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 3, Name = "mdt09orig.blv"})
		elseif Map.Name == "mdt09orig.blv" then -- Duplicated Wromthrax's Cave
			-- always make Wromthrax visible
			Game.MapEvtLines:RemoveEvent(1)
			evt.map[1].clear()
			evt.map[1] = function()
				evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Invisible, On = false}
			end
			oldPlacemonWromthrax = Game.PlaceMonTxt[117]
			Game.PlaceMonTxt[117] = "Wromthrax"
			
			-- shut up Quixote
			Game.MapEvtLines:RemoveEvent(376)
			evt.map[376].clear()
		elseif Map.Name == "out12.odm" then -- The Land of the Giants
			-- Dragon Caves (Eofol) entrances
			replaceEnterEvent(503, {X = -54, Y = 3470, Z = 1, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 3, Name = "mdt12orig.blv"})
			replaceEnterEvent(504, {X = 19341, Y = 21323, Z = 1, Direction = 256, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 3, Name = "mdt12orig.blv"})
		elseif Map.Name == "mdt12orig.blv" then -- Duplicated Dragon Caves
			oldPlacemonMegaDragon = Game.PlaceMonTxt[118]
			Game.PlaceMonTxt[118] = "Mega-Dragon"
		elseif Map.Name == "7d28.blv" then -- The Dragon's Lair (on Emerald Island)
			-- remove monster spawning
			Game.MapEvtLines:RemoveEvent(1)
			evt.map[1].clear()
			-- always exit to Emerald Island
			replaceEnterEvent(101, {X = 13839, Y = 16367, Z = 169, Direction = 1, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 4, Name = "7Out01.Odm"})
		elseif Map.Name == "7out15.odm" and not mapvars.placedTempleInABottle then -- Shoals
			-- place Temple in a Bottle in chest
			for i, item in Map.Chests[0].Items do
				if item.Number == 0 then
					item.Number = 1452
					mapvars.placedTempleInABottle = true
					break
				end
			end
		end
		function events.LeaveMap()
			if Map.Name == "mdt09orig.blv" then -- Duplicated Wromthrax's Cave
				Game.PlaceMonTxt[117] = oldPlacemonWromthrax
			elseif Map.Name == "mdt12orig.blv" then -- Duplicated Dragon Caves
				Game.PlaceMonTxt[118] = oldPlacemonMegaDragon
			end
		end
	end
	-- tularean forest tularean caves and clanker's lab entrances, tularean caves remove loren event
	-- castle navan tularean caves exit
	-- tatalia wromthrax's cave, entering, remove quixote event and add removing invisibility from orig, change wromthrax's name?
	-- dragon's caves in eofol: two entrances in odm, remove dragon spawning from EI morcarack's cave, turn off exit to eofol, don't add qbits
	-- create temple in a bottle in shoals when using duplicated dungeons

	-- search for map file names in newest merge's scripts directory
	-- add new mapstats entries handling to TownPortalControls.MapOfContinent from TownPortalSwitches, call original if not new entry

	-- fort riverstride delete plans item

	-- difficulty monster damage, skill barrels skill level, selling prices, deleting strong items (randomize items in removed chest's contents), new spawns, max npcs hired in the same time
	-- DARK AND LIGHT RESISTANCE! sources which I can probably program into the game: altars in Tularean Forest and Deyja (one light, other dark), cauldrons, day of protection, elemental totems, cleric totems, harmondale prison phasing cauldron
	-- GM shield reduce damage by 25% (elemental mod)
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

if not isEasy() then
	if Merge.ModSettings.Rev4ForMergeNerfDamage == 1 then
		function events.CalcDamageToMonster(t)
			-- TODO: WhoHitMonster, if monster then don't reduce damage
			-- TODO: <del>anything can hit oozes for 1 now</del> (same probably applies with medusas and spells)
			local m = 1
			-- handle monsters immune to t.DamageKind
			if t.Monster.Resistances[t.DamageKind] and t.Monster.Resistances[t.DamageKind] == const.MonsterImmune then
				m = 0
			end
			t.Result = math.max(m, isMedium() and math.round(t.Result * 0.85) or math.round(t.Result * 0.70))
		end
	end
	
	-- reduce gold gains from monsters and gold piles
	if Merge.ModSettings.Rev4ForMergeNerfGoldGains == 1 then
		function events.BeforeGotGold(t)
			t.Amount = isMedium() and math.round(t.Amount * 0.75) or math.round(t.Amount * 0.50)
		end
	end
end

-- double the gold gains from monsters, they're not enough IMO, now killing monsters will be worth it
-- (larger values used used because previous difficulty restriction reduces gold from monsters too, and I'm not skilled enough to make it work only with gold piles)
if Merge.ModSettings.Rev4ForMergeBoostCorpseGold == 1 then
	function events.PickCorpse(t)
		t.Monster.TreasureDiceCount = math.round(t.Monster.TreasureDiceCount * (isEasy() and 2 or (isMedium() and (8 / 3) or 4)))
	end
end

function refundSkillpoints(skill, freeSkillLevel)
	for _, pl in Party do
		local s, m = SplitSkill(pl.Skills[skill])
		local level = math.min(s, freeSkillLevel)
		if level >= 2 then
			local refund = level * (level + 1) / 2 - 1
			pl.SkillPoints = pl.SkillPoints + refund
		end
	end
end

local reqSkill = {1, 4, 7, 10}
function giveFreeSkill(skill, level, mastery, check)
	if Merge.ModSettings.Rev4ForMergeNerfSkillBoosts == 1 then
		if isMedium then
			level = math.max(reqSkill[mastery], level - 1)
			--level = math.max(1, level - 1)
		elseif isHard then
			level = math.max(reqSkill[mastery], level - 3)
			--level = math.max(1, level - 3)
		end
	end
	local benefit = false
	if Merge.ModSettings.Rev4ForMergeRefundSkillpoints == 1 then
		refundSkillpoints(skill, level)
	end
	for i, pl in Party do
		if check and type(check) == "function" and not check(pl) then
			goto continue
		end
		local s, m = SplitSkill(pl.Skills[skill])
		if level > s or mastery > m or s >= 2 then
			benefit = true
			evt[i].Add("Experience", 0) -- make sparkle sound and animation
			pl.Skills[skill] = JoinSkill(math.max(level, s), math.max(m, mastery))
		end
		::continue::
	end
	if not benefit then
		Game.ShowStatusText("You received the bonus but didn't benefit from it")
	end
end

evt.global[128] = function()
	giveFreeSkill(const.Skills.Dark, 8, const.Master, function(pl) return pl.Skills[const.Skills.Fire] ~= 0 or pl.Skills[const.Skills.Body] ~= 0 end)
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
local summoned = {}
function pseudoSpawnpoint(monster, x, y, z, count, powerChances, radius, group)
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
	
	for i = 1, toCreate do
		-- https://stackoverflow.com/questions/9879258/how-can-i-generate-random-points-on-a-circles-circumference-in-javascript
		local angle = random() * math.pi * 2
		local xadd = math.cos(angle) * random(1, t.radius)
		local yadd = math.sin(angle) * random(1, t.radius)
		
		local power = nil
		local rand = random(1, 100)
		if rand < t.powerChances[1] or (not t.powerChances[2] and not t.powerChances[3]) then
			power = 0
		elseif t.powerChances[2] and rand < t.powerChances[2] + t.powerChances[1] or (not t.powerChances[1] and not t.powerChances[3]) then
			power = 1
		elseif t.powerChances[3] then
			power = 2
		elseif t.powerChances[2] then
			power = 1
		else
			power = 0
		end
		
		table.insert(summoned, (SummonMonster(class * 3 - 2 + power, t.x + xadd, t.y + yadd, t.z, true)))
		summoned[#summoned].Group = t.group or 255
	end
end

function pseudoSpawnpointItem(item, x, y, z, count, radius)
	local t = {}
	if type(item) == "table" then
		t = item -- user passed table with arguments instead of item
	else
		t.Item, t.item = item, item
		t.X, t.x = x, x
		t.Y, t.y = y, y
		t.Z, t.z = z, z
		t.Count, t.count = count, count
		r.Radius, t.radius = radius, radius
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
		
		SummonItem(item, t.x + xadd, t.y + yadd, t.z, nil)
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
	print(("pseudoSpawnpoint{monster = 1, x = %d, y = %d, z = %d, count = isMedium() and \"1-3\" or \"3-5\", powerChances = isMedium() and {60, 30, 10} or {34, 33, 33}, radius = 64}"):format(Party.X, Party.Y, Party.Z))
end

function pseudoSpawnpointItemPrint()
	print(("pseudoSpawnpointItem{item = 1, x = %d, y = %d, z = %d, count = 1, radius = 64}"):format(Party.X, Party.Y, Party.Z))
end

-- spawn monsters
function events.LoadMap()
	if difficulty == const.Difficulty.Easy or Merge.ModSettings.Rev4ForMergeExtraMonsterSpawns ~= 1 then
		mapvars.Rev4ForMergeMonstersSpawned = true
		return
	end
	if not mapvars.Rev4ForMergeMonstersSpawned then
		if Map.Name == "7out03.odm" then -- Erathia
			-- soldiers, idea from MM7 Refilled
			pseudoSpawnpoint{monster = 253, x = 7187, y = -836, z = 865, count = isMedium() and "10-15" or "20-30", powerChances = isMedium() and {60, 30, 10} or {34, 33, 33}, radius = 1024}
		elseif Map.Name == "7out04.odm" then -- Tularean Forest
			-- dragonflies near contest
			pseudoSpawnpoint{monster = 226, x = 10912, y = 1462, z = 2813, count = isMedium() and "5-10" or "10-18", powerChances = isMedium() and {60, 30, 10} or {34, 33, 33}, radius = 2048}
			
			-- dragonflies near power chest
			pseudoSpawnpoint{monster = 226, x = 5679, y = 4262, z = 1407, count = isMedium() and "5-10" or "10-18", powerChances = isMedium() and {60, 30, 10} or {34, 33, 33}, radius = 2048}
			
			-- water elementals near high magic presence place
			pseudoSpawnpoint{monster = 244, x = 15743, y = -10792, z = 60, count = isMedium() and "5-10" or "10-18", powerChances = isMedium() and {60, 30, 10} or {34, 33, 33}, radius = 1024}
			
			-- water elementals near shoreline with good reagents
			pseudoSpawnpoint{monster = 244, x = -15629, y = 11100, z = 1151, count = isMedium() and "3-5" or "6-8", powerChances = isMedium() and {60, 30, 10} or {34, 33, 33}, radius = 4096}
			
			-- wyverns near resistance altar
			pseudoSpawnpoint{monster = 424, x = -20489, y = -19134, z = 2982, count = isMedium() and "3-6" or "6-10", powerChances = isMedium() and {60, 40, 0} or {30, 70, 0}, radius = 2048}
			
			-- rocs near obelisk with ores
			pseudoSpawnpoint{monster = 391, x = -9229, y = 3108, z = 2289, count = isMedium() and "2-4" or "4-7", powerChances = isMedium() and {70, 25, 5} or {50, 30, 20}, radius = 1024}
			
			-- griffins near Clanker's Lab
			pseudoSpawnpoint{monster = 280, x = 12851, y = 12879, z = 274, count = isMedium() and "5-7" or "8-10", powerChances = isMedium() and {70, 25, 5} or {50, 30, 20}, radius = 1024}
		elseif Map.Name == "7out13.odm" then -- Tatalia
		-- Hydras near obelisk
			pseudoSpawnpoint{monster = 286, x = -19083, y = 17025, z = 337, count = isMedium() and "2-3" or "3-5", powerChances = isMedium() and {60, 30, 10} or {34, 33, 33}, radius = 2048}
		end
		evt.SetMonGroupBit{NPCGroup = 255, Bit = const.MonsterBits.Hostile, On = true}
	end
	mapvars.Rev4ForMergeMonstersSpawned = true
end