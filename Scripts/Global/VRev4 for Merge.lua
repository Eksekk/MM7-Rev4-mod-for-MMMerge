local MS = Merge.ModSettings

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
	500, 45,
	400, 40,
	350, 35,
	300, 30,
	275, 29,
	250, 28,
	225, 26,
	200, 24,
	180, 23,
	161, 22,
	146, 21,
	131, 20,
	116, 19,
	101, 18,
	91, 17,
	82, 16,
	74, 15,
	67, 14,
	61, 13,
	55, 12,
	50, 11,
	45, 10,
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

local hubNPCID = 1285

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
local BDJNPCID = 1279
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
	local correctTexts =
	{
		["7d08orig.blv"] = 394,
		["7d12orig.blv"] = 395,
		["mdt09orig.blv"] = 8,
		--["mdt12orig.blv"] = ,
		--["7nwcorig.blv"] = 
		
	}
	function events.GetTransitionText(t)
		local val = correctTexts[t.EnterMap:lower()]
		if val then
			t.TransId = val
		end
	end
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

	-- difficulty monster damage, skill barrels skill level, selling prices, deleting strong items (randomize items in removed chest's contents), new spawns, max npcs hired at the same time
	-- DARK AND LIGHT RESISTANCE! sources which I can probably program into the game: altars in Tularean Forest and Deyja (one light, other dark), cauldrons, day of protection, elemental totems, cleric totems, harmondale prison phasing cauldron
	-- GM shield reduce damage by 25% (elemental mod)
	
	-- check maps in rev4 and merge: timer with evt.MoveToMap and
	-- for k, v in Map.Objects do if v.Item then print(k, v.Item.Number, Game.ItemsTxt[v.Item.Number].Name) end end
	-- as debug message (write to file?)
end

if not Rev4ForMergeMapstatsBoosted then
	Rev4ForMergeMapstatsBoosted = true
	function events.BeforeLoadMap()
		-- boost mapstats spawns depending on difficulty
		for i, v in Game.MapStats do
			local indexes = ({"Mon1Low", "Mon1Hi", "Mon2Low", "Mon2Hi", "Mon3Low", "Mon3Hi"})
			for j = 1, 5, 2 do
				local idx = indexes[j]
				local idx2 = indexes[j + 1]
				if --[[v[idx] > 0 and ]]v[idx2] > 0 and v[idx] ~= v[idx2] then -- I once adopted a rule that when both spawn values are equal, no boost happens
				-- idk why, but I'll preserve it to not break anything
					v[idx] = v[idx] + (TownPortalControls.MapOfContinent(i) == 2 and diffsel(0, 1, 2) or diffsel(2, 4, 6)) -- 2 = Antagarich
					v[idx2] = v[idx2] + (TownPortalControls.MapOfContinent(i) == 2 and diffsel(0, 1, 2) or diffsel(2, 4, 6))
				end
			end
		end
		Game.MapStats[70].Tres = 4 -- Barrow Downs
		events.Remove("BeforeLoadMap", 1) -- should only run once, general won't work because I need TownPortalControls.MapOfContinent
	end
end

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

--[[ double the gold gains from monsters, they're not enough IMO, now killing monsters will be worth it
-- (larger values used because previous difficulty restriction reduces gold from monsters too, and I'm not skilled enough to make it work only with gold piles)
if Merge.ModSettings.Rev4ForMergeBoostCorpseGold == 1 then
	function events.PickCorpse(t)
		t.Monster.TreasureDiceCount = math.round(t.Monster.TreasureDiceCount * (isEasy() and 2 or (isMedium() and (8 / 3) or 4)))
	end
end]]

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
		if isMedium() then
			level = math.max(reqSkill[mastery], level - 1)
			--level = math.max(1, level - 1)
		elseif isHard() then
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
		if level > s or mastery > m or (s >= 2 and Merge.ModSettings.Rev4ForMergeRefundSkillpoints == 1) then
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

evt.global[878] = function()
	giveFreeSkill(const.Skills.Dark, 8, const.Master, function(pl) return pl.Skills[const.Skills.Fire] ~= 0 or pl.Skills[const.Skills.Body] ~= 0 end)
end

-- spawn monsters
function events.AfterLoadMap()
	if difficulty == const.Difficulty.Easy or Merge.ModSettings.Rev4ForMergeExtraMonsterSpawns ~= 1 then
		mapvars.Rev4ForMergeMonstersSpawned = true
		return
	end
	if not mapvars.Rev4ForMergeMonstersSpawned then
		if Map.Name == "7out02.odm" then -- Harmondale
			-- ideas from MM7 Refilled
			-- elves
			pseudoSpawnpoint{monster = 247, x = 12389, y = 14730, z = 1225, count = diffsel("2-4", "4-6", "6-8"), powerChances = diffsel({70, 20, 10}, {50, 30, 20}, {34, 33, 33}), radius = 256, group = 62}
			pseudoSpawnpoint{monster = 247, x = 16442, y = 16059, z = 1731, count = diffsel("2-4", "4-6", "6-8"), powerChances = diffsel({70, 20, 10}, {50, 30, 20}, {34, 33, 33}), radius = 256, group = 62}
			
			-- dragonflies
			pseudoSpawnpoint{monster = 226, x = 21040, y = -6884, z = 673, count = diffsel("5-8", "7-11", "10-15"), powerChances = diffsel({70, 20, 10}, {50, 30, 20}, {34, 33, 33}), radius = 1024, group = 62}
			
			-- human archers
			pseudoSpawnpoint{monster = 202, x = -7417, y = -3007, z = 2176, count = diffsel("2-4", "4-6", "6-8"), powerChances = diffsel({70, 20, 10}, {50, 30, 20}, {34, 33, 33}), radius = 1024, group = 63}
			pseudoSpawnpoint{monster = 202, x = -7350, y = -8517, z = 640, count = diffsel("2-4", "4-6", "6-8"), powerChances = diffsel({70, 20, 10}, {50, 30, 20}, {34, 33, 33}), radius = 1024, group = 63}
			
			-- skelly guards on road to Barrow Downs
			pseudoSpawnpoint{monster = 397, x = -1395, y = -20740, z = 1, count = diffsel("2-4", "4-6", "6-8"), powerChances = diffsel({70, 20, 10}, {50, 30, 20}, {34, 33, 33}), radius = 1024, group = 61}
			
			evt.SetMonGroupBit{NPCGroup = 62, Bit = const.MonsterBits.Hostile, On = true}
			evt.SetMonGroupBit{NPCGroup = 63, Bit = const.MonsterBits.Hostile, On = true}
		elseif Map.Name == "7out03.odm" then -- Erathia
			-- soldiers, idea from MM7 Refilled
			pseudoSpawnpoint{monster = 253, x = 7187, y = -836, z = 865, count = isMedium() and "10-15" or "20-30", powerChances = isMedium() and {70, 20, 10} or {50, 25, 25}, radius = 1024, group = 57}
			
			-- leather fighters, idea once again from MM7 Refilled
			pseudoSpawnpoint{monster = 256, x = 5756, y = -7091, z = 928, count = isMedium() and "5-8" or "10-15", powerChances = isMedium() and {60, 30, 10} or {34, 33, 33}, radius = 1024, group = 57}
			
			-- plate fighters
			pseudoSpawnpoint{monster = 259, x = 3687, y = -16928, z = 1006, count = isMedium() and "2-3" or "4-6", powerChances = isMedium() and {70, 30, 0} or {60, 30, 10}, radius = 4096, group = 57}
			
			-- gogs near luck altar
			pseudoSpawnpoint{monster = 274, x = 14529, y = -16490, z = 968, count = isMedium() and "5-9" or "8-12", powerChances = isMedium() and {60, 30, 10} or {34, 33, 33}, radius = 1024, group = 57}
			
			-- griffins near contest
			pseudoSpawnpoint{monster = 280, x = 21997, y = -10825, z = 3104, count = isMedium() and "3-5" or "6-8", powerChances = isMedium() and {60, 30, 10} or {34, 33, 33}, radius = 1024, group = 57}
			
			-- goblins near harmondale road (idea from MM7 Refilled)
			pseudoSpawnpoint{monster = 271, x = 19654, y = 6288, z = 3936, count = isMedium() and "8-12" or "11-18", powerChances = isMedium() and {60, 30, 10} or {34, 33, 33}, radius = 2048, group = 57}
			
			-- thieves near bandits' caverns (idea from MM7 Refilled)
			pseudoSpawnpoint{monster = 406, x = 18162, y = 6898, z = 2901, count = isMedium() and "6-9" or "8-13", powerChances = isMedium() and {60, 30, 10} or {34, 33, 33}, radius = 2048, group = 57}
			
			-- monks aiding robbers (idea also from MM7 Refilled)
			pseudoSpawnpoint{monster = 304, x = 19412, y = 13127, z = 3994, count = isMedium() and "5-8" or "9-13", powerChances = isMedium() and {70, 25, 5} or {55, 35, 10}, radius = 2048, group = 57}
			
			-- powerful plate fighter guarding fort riverstride, idea as usual from MM7 Refilled
			pseudoSpawnpoint{monster = 259, x = 10391, y = -1963, z = 1571, count = isMedium() and "1-1" or "2-2", powerChances = {0, 0, 100}, radius = 64, group = 57, exactZ = true}
			
			evt.SetMonGroupBit{NPCGroup = 57, Bit = const.MonsterBits.Hostile, On = true}
		elseif Map.Name == "7out04.odm" then -- Tularean Forest
			-- dragonflies near contest
			pseudoSpawnpoint{monster = 226, x = 10912, y = 1462, z = 2813, count = isMedium() and "5-10" or "10-18", powerChances = isMedium() and {60, 30, 10} or {34, 33, 33}, radius = 2048, group = 61}
			
			-- dragonflies near chest with very good items
			pseudoSpawnpoint{monster = 226, x = 5679, y = 4262, z = 1407, count = isMedium() and "5-10" or "10-18", powerChances = isMedium() and {60, 30, 10} or {34, 33, 33}, radius = 2048, group = 61}
			
			-- water elementals near high magic presence place
			pseudoSpawnpoint{monster = 244, x = 15743, y = -10792, z = 60, count = isMedium() and "5-10" or "10-18", powerChances = isMedium() and {60, 30, 10} or {34, 33, 33}, radius = 1024, group = 61}
			
			-- water elementals near shoreline with good reagents
			pseudoSpawnpoint{monster = 244, x = -15629, y = 11100, z = 1151, count = isMedium() and "3-5" or "6-8", powerChances = isMedium() and {60, 30, 10} or {34, 33, 33}, radius = 4096, group = 61}
			
			-- wyverns near resistance altar
			pseudoSpawnpoint{monster = 424, x = -20489, y = -19134, z = 2982, count = isMedium() and "2-5" or "3-6", powerChances = isMedium() and {60, 40, 0} or {30, 70, 0}, radius = 2048, group = 61}
			
			-- rocs near obelisk with ores
			pseudoSpawnpoint{monster = 391, x = -9229, y = 3108, z = 2289, count = isMedium() and "2-4" or "4-7", powerChances = isMedium() and {70, 25, 5} or {50, 30, 20}, radius = 1024, group = 61}
			
			-- griffins near Clanker's Lab
			pseudoSpawnpoint{monster = 280, x = 12851, y = 12879, z = 274, count = isMedium() and "10-15" or "16-21", powerChances = isMedium() and {70, 25, 5} or {50, 30, 20}, radius = 2048}
			evt.SetMonGroupBit{NPCGroup = 61, Bit = const.MonsterBits.Hostile, On = true}
		elseif Map.Name == "7out05.odm" then -- Deyja
			-- wights near town and chest
			pseudoSpawnpoint{monster = 421, x = -8863, y = 19828, z = 3073, count = isMedium() and "3-5" or "4-7", powerChances = isMedium() and {60, 30, 10} or {34, 33, 33}, radius = 512, group = 56}
			
			-- same, but near golem chest
			pseudoSpawnpoint{monster = 421, x = 22048, y = 8490, z = 3165, count = isMedium() and "3-5" or "4-7", powerChances = isMedium() and {60, 30, 10} or {34, 33, 33}, radius = 512, group = 56}
			
			-- necros
			pseudoSpawnpoint{monster = 307, x = -6041, y = -12719, z = 2326, count = isMedium() and "3-5" or "5-7", powerChances = isMedium() and {70, 30, 0} or {50, 50, 0}, radius = 4096, group = 56}
			
			-- gargoyles near resistance altar
			pseudoSpawnpoint{monster = 262, x = 19483, y = -20412, z = 6400, count = isMedium() and "6-9" or "8-12", powerChances = isMedium() and {70, 30, 0} or {40, 60, 0}, radius = 4096, group = 56}
			
			evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}
		elseif Map.Name == "7out06.odm" then -- Bracada Desert
			if isHard() then
				-- Titans near lamps, idea from MM7 Reimagined
				pseudoSpawnpoint{monster = 409, x = -20563, y = -11665, z = 969, count = "2-3", powerChances = {70, 30, 0}, radius = 512, group = 61}
				pseudoSpawnpoint{monster = 409, x = -6940, y = -21192, z = 1, count = "2-3", powerChances = {70, 30, 0}, radius = 512, group = 61}
				pseudoSpawnpoint{monster = 409, x = 19043, y = -9014, z = 148, count = "2-3", powerChances = {70, 30, 0}, radius = 512, group = 61}
			end
			-- oozes near dwarf mines, idea from MM7 Refilled
			pseudoSpawnpoint{monster = 310, x = 21484, y = 13715, z = 0, count = isMedium() and "5-8" or "8-12", powerChances = isMedium() and {60, 30, 10} or {34, 33, 33}, radius = 512, group = 61}
			evt.SetMonGroupBit{NPCGroup = 61, Bit = const.MonsterBits.Hostile, On = true}
		elseif Map.Name == "out09.odm" then -- Evenmorn Island
			-- acolytes of the moon near dark temple entrance
			pseudoSpawnpoint{monster = 214, x = 8077, y = -4231, z = 21, count = isMedium() and "5-8" or "8-12", powerChances = isMedium() and {60, 30, 10} or {34, 33, 33}, radius = 1024, group = 56}
			-- and near druid circle (idea from MM7 Reimagined)
			pseudoSpawnpoint{monster = 214, x = -13659, y = 3835, z = 172, count = isMedium() and "5-8" or "8-12", powerChances = isMedium() and {60, 30, 10} or {34, 33, 33}, radius = 1024, group = 56}
			-- fire elementals near high magic point
			-- yes, fire elementals are guarding a body of water, what's so strange about it? :D
			pseudoSpawnpoint{monster = 238, x = -5341, y = -344, z = 917, count = isMedium() and "3-5" or "5-7", powerChances = isMedium() and {60, 30, 10} or {34, 33, 33}, radius = 128, group = 56, exactZ = true}
			
			-- clerics near sun temple (they fight with undead intentionally)
			pseudoSpawnpoint{monster = 217, x = -5241, y = 9495, z = 289, count = isMedium() and "7-10" or "9-13", powerChances = isMedium() and {60, 30, 10} or {34, 33, 33}, radius = 1024}
			
			evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}
		elseif Map.Name == "out10.odm" then -- Nighon
			-- dragons near... something
			pseudoSpawnpoint{monster = 223, x = 19587, y = 4873, z = 1793, count = "2-3", powerChances = isMedium() and {60, 30, 10} or {34, 33, 33}, radius = 512, group = 56}
			
			-- dragons on the sandy area
			pseudoSpawnpoint{monster = 223, x = 18166, y = 18614, z = 1087, count = "2-3", powerChances = isMedium() and {60, 30, 10} or {34, 33, 33}, radius = 1024, group = 56}
			pseudoSpawnpoint{monster = 223, x = 11002, y = 15729, z = 1034, count = "2-3", powerChances = isMedium() and {60, 30, 10} or {34, 33, 33}, radius = 1024, group = 56}
			
			-- dragons near three chests
			pseudoSpawnpoint{monster = 223, x = 20279, y = 9351, z = 4724, count = "2-3", powerChances = isMedium() and {60, 30, 10} or {34, 33, 33}, radius = 1024, group = 56}
			
			-- air elementals near int/per altar
			pseudoSpawnpoint{monster = 232, x = -18517, y = -17545, z = 1527, count = isMedium() and "4-8" or "7-11", powerChances = isMedium() and {60, 30, 10} or {34, 33, 33}, radius = 512, group = 56}
			
			-- minos near labyrinth entrance
			pseudoSpawnpoint{monster = 301, x = -10800, y = 20376, z = 3054, count = isMedium() and "4-8" or "7-11", powerChances = isMedium() and {60, 30, 10} or {34, 33, 33}, radius = 1024, group = 56}
			evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}
		elseif Map.Name == "out11.odm" then -- Barrow Downs
			-- wights near might/endurance altar
			pseudoSpawnpoint{monster = 421, x = -18478, y = -19643, z = 864, count = isMedium() and "2-4" or "5-7", powerChances = isMedium() and {60, 30, 10} or {34, 33, 33}, radius = 1024, group = 56}
			
			-- skellies near barrows entrances
			pseudoSpawnpoint{monster = 397, x = 16861, y = 13268, z = 1601, count = diffsel("4-7", "6-10", "9-14"), powerChances = diffsel({70, 20, 10}, {50, 30, 20}, {34, 33, 33}), radius = 1024, group = 56}
			pseudoSpawnpoint{monster = 397, x = 9220, y = -19299, z = 1601, count = diffsel("4-7", "6-10", "9-14"), powerChances = diffsel({70, 20, 10}, {50, 30, 20}, {34, 33, 33}), radius = 128, group = 56}
			pseudoSpawnpoint{monster = 397, x = -13785, y = 19617, z = 961, count = diffsel("4-7", "6-10", "9-14"), powerChances = diffsel({70, 20, 10}, {50, 30, 20}, {34, 33, 33}), radius = 256, group = 56}
			
			-- scatter some items near spider hell
			pseudoSpawnpointItem{item = 1, x = 8945, y = -14763, z = 1, count = 8, radius = 2048, level = 4} -- effective 3-4 on Tres 4 (General/ZRev4 for Merge.lua)
			pseudoSpawnpointItem{item = 1, x = 1873, y = -1833, z = 0, count = 16, radius = 1024, level = 5} -- effective 4 on Tres 4
			
		elseif Map.Name == "7out13.odm" then -- Tatalia
			-- Hydras near obelisk, idea from MM7 Reimagined
			pseudoSpawnpoint{monster = 286, x = -19083, y = 17025, z = 337, count = isMedium() and "2-3" or "3-5", powerChances = isMedium() and {60, 30, 10} or {34, 33, 33}, radius = 2048, group = 51}
			pseudoSpawnpoint{monster = 286, x = -11426, y = 16821, z = 2206, count = isMedium() and "2-3" or "3-5", powerChances = isMedium() and {60, 30, 10} or {34, 33, 33}, radius = 2048, group = 51}
			
			-- ghosts and skellies near tidewater caverns
			pseudoSpawnpoint{monster = 268, x = -17438, y = 2611, z = 369, count = isMedium() and "7-12" or "11-15", powerChances = isMedium() and {60, 30, 10} or {34, 33, 33}, radius = 4096, group = 51}
			pseudoSpawnpoint{monster = 397, x = -17438, y = 2611, z = 369, count = isMedium() and "7-12" or "11-15", powerChances = isMedium() and {60, 30, 10} or {34, 33, 33}, radius = 4096, group = 51}
			
			-- earth elementals near meteorite crater, though those with rock blast won't spawn, because it's OP when used by monsters
			pseudoSpawnpoint{monster = 235, x = 7309, y = 6416, z = 2426, count = isMedium() and "2-4" or "4-6", powerChances = isMedium() and {60, 0, 40} or {40, 0, 60}, radius = 1024, group = 51}
			
			-- hydras near other reagent area
			pseudoSpawnpoint{monster = 286, x = 10437, y = 19770, z = 2617, count = isMedium() and "2-3" or "3-5", powerChances = isMedium() and {60, 30, 10} or {34, 33, 33}, radius = 1024, group = 51}
			
			-- vampires on the shore
			pseudoSpawnpoint{monster = 415, x = -6591, y = 5825, z = 54, count = isMedium() and "2-4" or "3-5", powerChances = isMedium() and {70, 25, 5} or {50, 30, 20}, radius = 64, group = 51}
			
			-- warlocks near statuette shrine, idea from MM7 Reimagined
			pseudoSpawnpoint{monster = 418, x = -12430, y = -20934, z = 224, count = isMedium() and "5-9" or "8-12", powerChances = isMedium() and {60, 30, 10} or {34, 33, 33}, radius = 1024, group = 51}
			evt.SetMonGroupBit{NPCGroup = 51, Bit = const.MonsterBits.Hostile, On = true}
		elseif Map.Name == "out14.odm" then -- Avlee
			-- earth elementals near good items
			pseudoSpawnpoint{monster = 235, x = -8683, y = -11027, z = 151, count = isMedium() and "2-4" or "5-7", powerChances = isMedium() and {60, 0, 40} or {40, 0, 60}, radius = 1024, group = 51}
		end
		-- 7d24.blv (Stone City) troglodyte boss
		evt.SetMonGroupBit{NPCGroup = 255, Bit = const.MonsterBits.Hostile, On = true}
	end
	mapvars.Rev4ForMergeMonstersSpawned = true
	-- BOOST SUPER VAMPIRE IN 7d16.blv
end

-- remove most free endgame items

--[=[ pretty-print chest contents in editor in Rev4
for k, v in pairs(Editor.State.Chests) do
	if #v.Items > 0 then
		print("Chest " .. k - 1)
		for i, v in pairs(v.Items) do
			local d
			if type(v) == "number" and v >= 0 then
				v2 = getItem(v)
				d = v2 .. "\t" .. Game.ItemsTxt[v].Name
			elseif v.Number and v.Number >= 0 then
				v = table.copy(v)
				local n = v.Number
				v.Number = getItem(v.Number)
				d = Game.ItemsTxt[n].Name .. "\n" .. dump(v)
			else
				d = dump(v)
			end
			print(i, d)
		end
	end
end

-- in editor in Merge
for k, v in pairs(Editor.State.Chests) do
	if #v.Items > 0 then
		print("Chest " .. k - 1)
		for i, v in pairs(v.Items) do
			local d
			if type(v) == "number" and v >= 0 then
				d = v .. "\t" .. Game.ItemsTxt[v].Name
			elseif v.Number and v.Number >= 0 then
				d = Game.ItemsTxt[v.Number].Name .. "\n" .. dump(v)
			else
				d = dump(v)
			end
			print(i, d)
		end
	end
end

-- copy-paste from rev4 to merge
for k, v in pairs(Editor.State.Chests) do
	if #v.Items > 0 then
		print("Chest " .. k - 1)
		for i, v in pairs(v.Items) do
			local d
			if type(v) == "number" and v >= 0 then
				v2 = getItem(v)
				d = v2 .. "\t" .. Game.ItemsTxt[v].Name
			elseif v.Number and v.Number >= 0 then
				v = table.copy(v)
				local n = v.Number
				v.Number = getItem(v.Number)
				d = --[[Game.ItemsTxt[n].Name .. "\n" .. ]]dump(v)
			else
				d = dump(v)
			end
			print(d)
		end
	end
end
]=]
--[=[

]=]

-- boost loot in the Gauntlet?

if not isEasy() and Merge.ModSettings.Rev4ForMergeRemoveFreeEndgameItems == 1 then
	-- for k, v in Map.Objects do if v.Item then print(k, v.Item.Number, Game.ItemsTxt[v.Item.Number].Name) end end
	-- defined in file General/ZRev4 for Merge.lua
	-- local function randomizeAndSetCorrectType(id, level, typ)
	local function randomizeAndSetCorrectType(id, level, typ) -- just Randomize() leaves item look on map unchanged
		if Merge.ModSettings.Rev4ForMergeRandomizeRemovedItems == 1 then
			local obj = Map.Objects[id]
			obj.Item:Randomize(level, typ)
			obj.Type = Game.ItemsTxt[obj.Item.Number].SpriteIndex
			obj.TypeIndex = Game.ItemsTxt[obj.Item.Number].SpriteIndex
		else
			Map.RemoveObject(id)
		end
	end
	
	function events.AfterLoadMap()
		local function removeOrReplace(items)
			for i, v in ipairs(items) do
				randomizeAndSetCorrectType(v.id, v.level, v.itemType)
			end
		end
		if not mapvars.Rev4ForMergeEndgameItemsRemoved then
			if Map.Name == "7out01.odm" then -- Emerald Island
			--[[0	1448	Horseshoe
				1	856	Supreme Flail
				2	1001	Gold
				3	807	Duelist Blade
				4	1012	Poppysnaps
				5	845	Longbow
				6	1012	Poppysnaps
				7	1007	Phirna Root
				8	872	Royal Leather
				9	1448	Horseshoe
				10	848	Griffin Bow
				11	253	Divine Cure
				12	1448	Horseshoe--]]
				removeOrReplace({{id = 3, level = 2, itemType = const.ItemType.Sword}, {id = 10, level = 2, itemType = const.ItemType.Bow}})
				if isHard() then
					removeOrReplace({{id = 1, level = 2, itemType = const.ItemType.Mace}})
					--Map.Objects[2].Item.Bonus2 = 700 -- down from 1700
				end
				-- chests
			elseif Map.Name == "7out02.odm" then -- Harmondale
				removeOrReplace({{id = 2, level = 4, itemType = const.ItemType.Amulet}})
				if MS.Rev4ForMergeRemoveBowsOfCarnage == 1 then
					-- it's a delicate issue, so I'll require additional check to remove these bows
					removeOrReplace({{id = 1, level = 4, itemType = const.ItemType.Bow}})
				end
				-- chests
			elseif Map.Name == "7out04.odm" then -- Tularean Forest
				removeOrReplace({{id = 109, level = 4, itemType = const.ItemType.Sword}})
			elseif Map.Name == "7out05.odm" then -- Deyja
			--[[36	267	Pure Endurance
				37	268	Pure Personality]]
				removeOrReplace({{id = 37, level = 3, itemType = const.ItemType.Potion}})
				if isHard() then
					removeOrReplace({{id = 36, level = 3, itemType = const.ItemType.Potion}})
				end
			elseif Map.Name == "out11.odm" then -- Barrow Downs
				if isHard() then
					removeOrReplace({{id = 28, level = 3, itemType = const.ItemType.Boots}})
				end
			elseif Map.Name == "7d24.blv" then -- Stone City
				-- gemstones! they make money problems go away, especially with stone city
				-- reputation to sell at cost at like expert 5 merchant
				
				--[[Chest 0
				1	990	Emerald
				2	993	Rose Crystal
				3	998	Ruby
				Chest 3
				1	-3
				2	-3
				Chest 4
				1	990	Emerald
				2	993	Rose Crystal
				3	998	Ruby
				Chest 7
				1	990	Emerald
				2	993	Rose Crystal
				3	998	Ruby
				Chest 8
				1	990	Emerald
				2	993	Rose Crystal
				3	998	Ruby
				Chest 9
				1	Brass Ring
				{
					Bonus = 8,
					BonusStrength = 200,
					Number = 922
				}
				2	Brass Ring
				{
					Bonus = 8,
					BonusStrength = 200,
					Number = 922
				}
				3	Brass Ring
				{
					Bonus = 8,
					BonusStrength = 200,
					Number = 922
				}
				Chest 10
				1	Brass Ring
				{
					Bonus = 8,
					BonusStrength = 200,
					Number = 922
				}
				2	Brass Ring
				{
					Bonus = 8,
					BonusStrength = 200,
					Number = 922
				}
				Chest 12
				1	990	Emerald
				2	993	Rose Crystal
				3	998	Ruby
				4	994	Diamond
				Chest 13
				1	664	Large Round Crystal
				2	990	Emerald
				3	993	Rose Crystal
				4	998	Ruby
				5	994	Diamond
				Chest 14
				1	990	Emerald
				2	993	Rose Crystal
				3	998	Ruby
				Chest 15
				1	990	Emerald
				2	993	Rose Crystal
				3	994	Diamond
				Chest 16
				1	990	Emerald
				2	993	Rose Crystal
				3	998	Ruby
				Chest 17
				1	994	Diamond
				2	993	Rose Crystal
				3	998	Ruby
				Chest 18
				1	990	Emerald
				2	993	Rose Crystal
				3	998	Ruby
				Chest 19
				1	990	Emerald
				2	993	Rose Crystal
				3	998	Ruby]]
				changeChestItem(0, 1, -1)
				changeChestItem(4, 2, -3)
				changeChestItem(7, 3, -2)
				changeChestItem(8, 3, -2)
				changeChestItem(12, 1, -6)
				changeChestItem(13, 2, -5)
				changeChestItem(13, 5, -5)
				changeChestItem(14, 1, -2)
				changeChestItem(15, 3, -2)
				changeChestItem(16, 2, -2)
				changeChestItem(17, 1, -2)
				changeChestItem(17, 3, -2)
				changeChestItem(18, 1, -2)
				changeChestItem(19, 3, -6)
				
				if isHard() then
					changeChestItem(0, 3, -1)
					changeChestItem(4, 1, -3)
					changeChestItem(7, 2, -2)
					changeChestItem(12, 2, -3)
					changeChestItem(12, 3, -5)
					changeChestItem(13, 3, -4)
					changeChestItem(15, 2, -2)
					changeChestItem(16, 1, -2)
					changeChestItem(18, 3, -2)
					changeChestItem(19, 2, -5)
				end
				Game.GenerateChests()
			elseif Map.Name == "7d29.blv" then -- Castle Harmondale
				--[[
				Chest 0
				1	-4
				Chest 1
				1	Gold
				{
					Bonus2 = 113,
					Number = 1000
				}
				2	Gold
				{
					Bonus2 = 400,
					Number = 1000
				}
				Chest 2
				1	Gold
				{
					Bonus2 = 200,
					Number = 1000
				}
				2	Composite Bow
				{
					Bonus2 = 3,
					Identified = true,
					Number = 847
				}
				Chest 3
				1	Gold
				{
					Bonus2 = 341,
					Identified = true,
					Number = 1000
				}
				2	Town Portal
				{
					Identified = true,
					Number = 1132
				}
				3	Horseshoe
				{
					Identified = true,
					Number = 1448
				}
				4	Letter to Hairbaugh
				{
					Identified = true,
					Number = 1518
				}
				5	Horseshoe
				{
					Identified = true,
					Number = 1448
				}
				6	Horseshoe
				{
					Identified = true,
					Number = 1448
				}
				Chest 4
				1	Gold
				{
					Bonus2 = 400,
					Identified = true,
					Number = 1000
				}
				2	Silver Belt
				{
					Bonus = 8,
					BonusStrength = 25,
					Identified = true,
					Number = 905
				}
				3	Mage Dagger
				{
					Bonus2 = 16,
					Identified = true,
					Number = 821
				}
				4	Town Portal
				{
					Identified = true,
					Number = 1132
				}
				Chest 5
				1	Composite Bow
				{
					Bonus2 = 3,
					Identified = true,
					Number = 847
				}
				2	{
					Identified = true,
					Number = -3
				}
				3	{
					Identified = true,
					Number = -2
				}
				Chest 6
				1	Gold
				{
					Bonus2 = 153,
					Number = 1000
				}
				2	Gold
				{
					Bonus2 = 240,
					Number = 1000
				}
				Chest 7
				1	Gold
				{
					Bonus2 = 500,
					Number = 1000
				}
				2	Gold
				{
					Bonus2 = 500,
					Number = 1000
				}
				Chest 8
				1	{
					Identified = true,
					Number = -2
				}
				2	Divine Restoration
				{
					Identified = true,
					Number = 252
				}
				3	Pure Might
				{
					Identified = true,
					Number = 270
				}
				Chest 9
				1	Modder's Precious
				{
					Bonus2 = 37,
					Identified = true,
					Number = 1368
				}
				2	Modder's Precious
				{
					Bonus2 = 38,
					Identified = true,
					Number = 1368
				}
				Chest 10
				1	Paladin Boots
				{
					Identified = true,
					Number = 921
				}
				2	{
					Identified = true,
					Number = -4
				}]]
				if MS.Rev4ForMergeRemoveBowsOfCarnage == 1 then
					changeChestItem(2, 2, -4)
					changeChestItem(5, 1, -4)
				end
				changeChestItem(4, 3, { -- probably weaker enchantment
					Bonus2 = 4,
					Identified = true,
					Number = 821
				})
				changeChestItem(7, 1, { -- less money
					Bonus2 = 250,
					Number = 1000
				})
				changeChestItem(7, 2, { -- less money
					Bonus2 = 200,
					Number = 1000
				})
				if isHard() then
					changeChestItem(4, 2, -3)
					changeChestItem(8, 3, -4)
					changeChestItem(10, 2, -3)
				else
					changeChestItem(4, 2, { -- reduce enchantment power
						Bonus = 8,
						BonusStrength = 15,
						Identified = true,
						Number = 905
					})
				end
				Game.GenerateChests()
			elseif Map.Name == "7d34.blv" then -- Red Dwarf Mines
				if MS.Rev4ForMergeRemoveBowsOfCarnage == 1 then
					changeChestItem(1, 1, -4)
					Game.GenerateChests()
				end
			elseif Map.Name == "mdt05.blv" then -- Barrow XIII
				if isMedium() then
					changeChestItem(2, 1, {
					Bonus = 8,
					BonusStrength = 50,
					Number = 894
				})
				else
					changeChestItem(2, 1, {
					Bonus = 8,
					BonusStrength = 25,
					Number = 894
				})
				end
			end
			-- tatalia has no rev4 items (except required quest item)
		end
		mapvars.Rev4ForMergeEndgameItemsRemoved = true
	end
else
	function events.AfterLoadMap()
		mapvars.Rev4ForMergeEndgameItemsRemoved = true
	end
end

-- make fire aura always work with permanent enchantments (elemental mod)

if MS.Rev4ForMergeManaHealthRegenStacking == 1 then
	-- make mana and health-restoring spc items stack linearly (extra restore is (items - 1) * items / 2, so 0, 1, 3, 6, 10...
	function events.RegenTick(pl)
		local manaRegenSpcBonuses = {38, 47, 55, 66}
		local healthRegenSpcBonuses = {37, 44, 50, 54, 66}
		local manaRegenItems = {} -- TODO
		local healthRegenItems = {} -- TODO
		local manaCount, healthCount = 0, 0
		for item, slot in pl:EnumActiveItems(false) do
			if table.find(manaRegenSpcBonuses, item.Bonus2) or table.find(manaRegenItems, item.Number) then
				manaCount = manaCount + 1
			end
			if table.find(healthRegenSpcBonuses, item.Bonus2) or table.find(healthRegenItems, item.Number) then
				healthCount = healthCount + 1
			end
		end
		local manaAdd, healthAdd = (manaCount - 1) * manaCount / 2, (healthCount - 1) * healthCount / 2
		if manaAdd > 0 then
			local FSP = pl:GetFullSP()
			pl.SP = math.min(math.max(FSP, pl.SP), pl.SP + manaAdd)
		end
		if healthAdd > 0 then
			local FHP = pl:GetFullHP()
			pl.HP = math.min(math.max(FHP, pl.HP), pl.HP + healthAdd)
		end
	end
end

function events.CalcStatBonusBySkills(t)
	-- make GM leather actually give decent resistances
	if t.Stat >= const.Stats.FireResistance and t.Stat <= const.Stats.EarthResistance then
		local s, m = SplitSkill(t.Player.Skills[const.Skills.Leather])
		if m == const.GM and t.Player.ItemArmor ~= 0 then
			for item, slot in t.Player:EnumActiveItems(false) do
				if slot == const.ItemSlot.Armor and item:T().Skill == const.Skills.Leather then
					t.Result = t.Result + s * 3
					break
				end
			end
		end
	end
end

function events.CalcStatBonusByItems(t)	
	-- boost "of Doom" to not be garbage
	if t.Stat >= const.Stats.Might and t.Stat <= const.Stats.BodyResistance then
		for item, slot in t.Player:EnumActiveItems(false) do
			if item.Bonus2 == 42 then
				t.Result = t.Result + 4
			end
		end
	end
	
	-- make "of the Gods" actually deserve D rating and 3000 gold price (it still sucks for spellcasters though)
	if t.Stat >= const.Stats.Might and t.Stat <= const.Stats.Luck then
		for item, slot in t.Player:EnumActiveItems(false) do
			if item.Bonus2 == 2 then
				t.Result = t.Result + 15
			end
		end
	end
end

function events.GetShopSellPriceMul(t)
	if isEasy() then return end
	t.Multiplier = isMedium() and 0.75 or 0.5
end

-- IDEA:
-- make mana giving items always work, even on a knight (meditation, especially at expert level, is not a viable way of getting spellpoints
-- you'd need 15 expert just to cast 1 Darkfire Bolt!

-- HookData
--[[
AC = false,
	AF = false,
	AH = 0,
	AL = 1,
	AX = 1,
	BH = 29,
	BL = 216,
	BX = 7640,
	CF = false,
	CH = 0,
	CL = 100,
	CX = 100,
	DF = false,
	DH = 0,
	DI = 37,
	DL = 0,
	DX = 0,
	EAX = 1,
	EBP = 1698124,
	EBX = 11673048,
	ECX = 100,
	EDI = 37,
	EDX = 0,
	EFLAGS = 518,
	ESI = 7,
	ESP = 1698120,
	FLAGS = 518,
	ID = false,
	IF = true,
	NT = false,
	OF = false,
	PF = true,
	RF = false,
	SF = false,
	SI = 7,
	TF = false,
	VIF = false,
	VIP = false,
	VM = false,
	ZF = false,
	ac = false,
	af = false,
	ah = 0,
	al = 1,
	ax = 1,
	bh = 29,
	bl = 216,
	bx = 7640,
	cf = false,
	ch = 0,
	cl = 100,
	cx = 100,
	df = false,
	dh = 0,
	di = 37,
	dl = 0,
	dx = 0,
	eax = 1,
	ebp = 1698124,
	ebx = 11673048,
	ecx = 100,
	edi = 37,
	edx = 0,
	eflags = 518,
	esi = 7,
	esp = 1698120,
	flags = 518,
	id = false,
	if = true,
	nt = false,
	of = false,
	pf = true,
	rf = false,
	sf = false,
	si = 7,
	tf = false,
	vif = false,
	vip = false,
	vm = false,
	zf = false
--]]