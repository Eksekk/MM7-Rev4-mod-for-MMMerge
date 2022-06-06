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

function events.GetStatisticEffect(t)
	local handled = false
	for i = 1, #vals - 2, 2 do
		if t.Value >= vals[i] then
			t.Result = vals[i + 1]
			handled = true
			break
		end
	end
	if not handled then
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

for i = 1993, 1999 do Game.GlobalEvtLines:RemoveEvent(i) end
for i = 0, 5 do Game.NPC[1265].Events[i] = 0 end

local slot = 0
for key, locationData in pairs(mapLocationsToKeys) do
	Quest{
		Branch = slot <= 2 and "Rev4ForMergeHarmondaleTeleportalHubFirstPartOfLocations" or "Rev4ForMergeHarmondaleTeleportalHubSecondPartOfLocations",
		NPC = 1265,
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
	if npc == 1265 then
		QuestBranch("Rev4ForMergeHarmondaleTeleportalHubFirstPartOfLocations")
	end
end

NPCTopic
{
	Branch = "Rev4ForMergeHarmondaleTeleportalHubFirstPartOfLocations",
	Ungive = function() QuestBranch("Rev4ForMergeHarmondaleTeleportalHubSecondPartOfLocations") end,
	Slot = 3,
	NPC = 1265,
	"More destinations"
}

NPCTopic
{
	Branch = "Rev4ForMergeHarmondaleTeleportalHubSecondPartOfLocations",
	Ungive = function() QuestBranch("Rev4ForMergeHarmondaleTeleportalHubFirstPartOfLocations") end,
	Slot = 3,
	NPC = 1265,
	"Go back"
}

-- BDJ change class quest
-- event 12 (promotion brazier) is removed by map script

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

evt.global[800].clear() -- New Profession

function events.LoadMap()
	if Map.Name = "7d12.blv" then
		evt.map[12].clear()
	end
end
local BDJQuestID = "BDJClassChangeQuest"
Quest
{
	BDJQuestID,
	NPC = 1259
}

-- duplicate modded dungeons

if Merge.ModSettings.Rev4ForMergeDuplicateModdedDungeons == 1 then
	local function replaceEnterEvent(num, t)
		Game.MapEvtLines:RemoveEvent(num)
		evt.map[num].clear()
		evt.map[num] = function()
			evt.MoveToMap(t)
		end
	end
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
		elseif Map.Name == "7out13.blv" then -- Tatalia
			replaceEnterEvent(505, {X = -2568, Y = -143, Z = 97, Direction = 257, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 3, Name = "mdt09orig.blv"})
		elseif Map.Name == "mdt09orig.blv" then -- Duplicated Wromthrax's Cave
			-- always make Wromthrax visible
			Game.MapEvtLines:RemoveEvent(1)
			evt.map[1].clear()
			evt.map[1] = function()
				evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Invisible, On = false}
			end
			
			-- shut up Quixote
			Game.MapEvtLines:RemoveEvent(376)
			evt.map[376].clear()
		end
		elseif Map.Name == "out12.odm" then -- The Land of the Giants
			-- Dragon Caves (Eofol) entrances
			replaceEnterEvent(503, {X = -54, Y = 3470, Z = 1, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 3, Name = "mdt12orig.blv"})
			replaceEnterEvent(504, {X = 19341, Y = 21323, Z = 1, Direction = 256, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 3, Name = "mdt12orig.blv"})
		elseif Map.Name == "7d28.blv" then -- The Dragon's Lair (on Emerald Island)
			-- remove monster spawning
			Game.MapEvtLines:RemoveEvent(1)
			evt.map[1].clear()
			-- always exit to Emerald Island
			replaceEnterEvent(101, {X = 13839, Y = 16367, Z = 169, Direction = 1, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 4, Name = "7Out01.Odm"})
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

	-- difficulty monster damage, skill barrels skill level, selling prices, deleting strong items (randomize items in removed chest's contents)
end

-- difficulty
const.Difficulty =
{
	Easy = 0,
	Medium = 1,
	Hard = 2
}

modSettingsDifficulty = ModSettings.Rev4ForMergeDifficulty
difficulty = modSettingsDifficulty and modSettingsDifficulty >= 0 and modSettingsDifficulty <= 2 and math.floor(modSettingsDifficulty) == modSettingsDifficulty and modSettingsDifficulty or const.Difficulty.Easy