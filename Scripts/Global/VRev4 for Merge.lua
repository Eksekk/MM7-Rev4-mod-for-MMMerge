local MS = Merge.ModSettings

-- disable town portal on antagarich when not completed archmage quest or in The Gauntlet
function events.CanCastTownPortal(t)
	if t.CanCast and Merge.Functions.GetContinent() == 2 then -- Antagarich
		t.Handled = true
		t.CanCast = evt.All.Cmp("QBits", getQuestBit(206))         -- Harmondale - Town Portal
	end
end

-- The Gauntlet
-- store town portal QBits on map enter and restore on map leave

function rev4m.storeGauntletQBits()
	if rev4m.bdjQ and rev4m.bdjQ.done then return end
	vars.TheGauntletQBits = vars.TheGauntletQBits or {}
	if not next(vars.TheGauntletQBits) then
		for i = 0, 2 do
			vars.TheGauntletQBits[i] = Party.QBits[i + getQuestBit(206)]
			Party.QBits[i + getQuestBit(206)] = false
		end
	end
end

function rev4m.restoreGauntletQBits()
	for i = 0, 2 do
		Party.QBits[i + getQuestBit(206)] = vars.TheGauntletQBits and vars.TheGauntletQBits[i] or false
   	end
end

function events.BeforeLoadMap()
	if Map.Name == "7d08.blv" or Map.Name == "7d12.blv" then -- The Gauntlet or Coding Fortress
		rev4m.storeGauntletQBits()
	end
end

function events.LeaveMap()
	if Map.Name == "7d12.blv" then -- Coding Fortress
		rev4m.restoreGauntletQBits()
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
	Ungive = function() QuestBranchScreen("Rev4ForMergeHarmondaleTeleportalHubSecondPartOfLocations") end,
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
		
	elseif Map.Name == "7out13.odm" then -- Tatalia
		replaceEnterEvent(505, {X = -2568, Y = -143, Z = 97, Direction = 257, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 3, Name = "mdt09orig.blv"})
	elseif Map.Name == "mdt09orig.blv" then -- Duplicated Wromthrax's Cave
		-- always make Wromthrax visible
		-- handled in map patches file
		for i, mon in Map.Monsters do
			if mon.NameId == 117 then -- wromthrax
				mon.NameId = rev4m.placeMon.wromthrax
				break
			end
		end
		
		-- shut up Quixote
		Game.MapEvtLines:RemoveEvent(376)
		evt.map[376].clear()
	elseif Map.Name == "out12.odm" then -- The Land of the Giants
		-- Dragon Caves (Eofol) entrances
		replaceEnterEvent(503, {X = -54, Y = 3470, Z = 1, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 3, Name = "mdt12orig.blv"})
		replaceEnterEvent(504, {X = 19341, Y = 21323, Z = 1, Direction = 256, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 3, Name = "mdt12orig.blv"})
	elseif Map.Name == "mdt12orig.blv" then -- Duplicated Dragon Caves
		for i, mon in Map.Monsters do
			if mon.NameId == 118 then -- wromthrax
				mon.NameId = rev4m.placeMon.megaDragon
				break
			end
		end
	elseif Map.Name == "7d28.blv" then -- The Dragon's Lair (on Emerald Island)
		-- remove monster spawning
		Game.MapEvtLines:RemoveEvent(1)
		evt.map[1].clear()
		-- always exit to Emerald Island
		replaceEnterEvent(101, {X = 13839, Y = 16367, Z = 169, Direction = 1, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 4, Name = "7Out01.Odm"})
	elseif Map.Name == "7out15.odm" and not mapvars.placedTempleInABottle then -- Shoals
		-- place Temple in a Bottle in chest
		assert(addChestItem(0, 1452), "Couldn't add temple in a bottle to chest")
		mapvars.placedTempleInABottle = true
	end
end

-- fort riverstride delete plans item

-- difficulty monster damage, skill barrels skill level, selling prices, deleting strong items (randomize items in removed chest's contents), new spawns, max npcs hired at the same time
-- DARK AND LIGHT RESISTANCE! sources which I can probably program into the game: altars in Tularean Forest and Deyja (one light, other dark), cauldrons, day of protection, elemental totems, cleric totems, harmondale prison phasing cauldron
-- GM shield reduce damage by 25% (elemental mod)

-- check maps in rev4 and merge: timer with evt.MoveToMap and
-- for k, v in Map.Objects do if v.Item then print(k, v.Item.Number, Game.ItemsTxt[v.Item.Number].Name) end end
-- as debug message (write to file?)

evt.global[878] = function()
	giveFreeSkill(const.Skills.Dark, 8, const.Master, function(pl) return pl.Skills[const.Skills.Fire] ~= 0 or pl.Skills[const.Skills.Body] ~= 0 end)
end

-- spawn monsters
function events.LoadMap()
	if difficulty == const.Difficulty.Easy or Merge.ModSettings.Rev4ForMergeExtraMonsterSpawns ~= 1 then
		mapvars.Rev4ForMergeMonstersSpawned = true
		return
	end
	if not mapvars.Rev4ForMergeMonstersSpawned then
		if Map.Name == "7out02.odm" then -- Harmondale
			-- ideas from MM7 Refilled
			-- elves
			pseudoSpawnpoint{monster = 247, x = 12389, y = 14730, z = 1225, count = diffsel("1-3", "3-5", "5-7"), powerChances = diffsel({70, 20, 10}, {50, 30, 20}, {34, 33, 33}), radius = 256, group = 62}
			pseudoSpawnpoint{monster = 247, x = 16442, y = 16059, z = 1731, count = diffsel("1-3", "3-5", "5-7"), powerChances = diffsel({70, 20, 10}, {50, 30, 20}, {34, 33, 33}), radius = 256, group = 62}
			
			-- dragonflies
			pseudoSpawnpoint{monster = 226, x = 21040, y = -6884, z = 673, count = diffsel("5-8", "7-11", "10-15"), powerChances = diffsel({70, 20, 10}, {50, 30, 20}, {34, 33, 33}), radius = 1024, group = 62}
			
			-- human archers
			pseudoSpawnpoint{monster = 202, x = -7417, y = -3007, z = 2176, count = diffsel("2-4", "4-6", "6-8"), powerChances = diffsel({70, 20, 10}, {50, 30, 20}, {34, 33, 33}), radius = 1024, group = 63}
			pseudoSpawnpoint{monster = 202, x = -7350, y = -8517, z = 640, count = diffsel("2-4", "4-6", "6-8"), powerChances = diffsel({70, 20, 10}, {50, 30, 20}, {34, 33, 33}), radius = 1024, group = 63}

			------------------
			
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
			pseudoSpawnpoint{monster = 259, x = 10391, y = -1963, z = 1571, count = isMedium() and 1 or 2, powerChances = {0, 0, 100}, radius = 64, group = 57, exactZ = true}
			
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
			pseudoSpawnpointItem{x = 8945, y = -14763, z = 1, count = 8, radius = 2048, level = 4} -- effective 3-4 on Tres 4 (General/ZRev4 for Merge.lua)
			pseudoSpawnpointItem{x = 1873, y = -1833, z = 0, count = 16, radius = 1024, level = 5} -- effective 4 on Tres 4
			
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
		evt.SetMonGroupBit{NPCGroup = 255, Bit = const.MonsterBits.Hostile, On = true}
	end
	mapvars.Rev4ForMergeMonstersSpawned = true
end

-- allow changing per-monster size
local monsterSizeMultipliers
function events.BeforeLoadMap()
	monsterSizeMultipliers = tget(mapvars, "changedMonsterSizes")
end

function events.MapMonstersIndexesChanged(t)
	updateMonsterIndexes(mapvars, "changedMonsterSizes", t)
end

function events.MonsterSpriteScale(t)
	local s = monsterSizeMultipliers[t.Monster:GetIndex()]
	if s then
		t.Scale = math.round(t.Scale * s)
	end
end

function multiplyMonsterSize(mon, scale)
	monsterSizeMultipliers[type(mon) == "number" and mon or mon:GetIndex()] = scale
end

-- Bosses
if MS.Rev4ForMergeAddBosses == 1 then -- need to be before bolster happens (in AfterLoadMap)
-- could be after, but changing properties would need to be wrapped in transform function passed to pseudoSpawnpoint
	function events.LoadMap()
		if mapvars.Rev4ForMergeBossesSpawned then
			return
		end
		mapvars.Rev4ForMergeBossesSpawned = true
		
		local makeHostile = {}
		local function hostile(mon)
			table.insert(makeHostile, mon:GetIndex())
		end
		function events.AfterLoadMap() -- need AfterLoadMap to override some map scripts setting monsters to friendly
			for i, v in ipairs(makeHostile) do
				evt.SetMonsterBit{Monster = v, Bit = const.MonsterBits.Hostile, On = true}
			end
			events.Remove("AfterLoadMap", 1)
		end
		local hp, hpMul, rewards, spells, resists = monUtils.hp, monUtils.hpMul, monUtils.rewards, monUtils.spells, monUtils.resists
		local damage, addDamage, acMul = monUtils.damage, monUtils.addDamage, monUtils.acMul
		
		if Map.Name == "7out01.odm" then -- Emerald Island
			
		elseif Map.Name == "7out02.odm" then -- Harmondale
			
		elseif Map.Name == "7out03.odm" then -- Erathia
			
		elseif Map.Name == "7out04.odm" then -- The Tularean Forest
			
		elseif Map.Name == "7out05.odm" then -- Deyja
			-- necro
			local mon = pseudoSpawnpoint{monster = 307, x = -9248, y = 3548, z = -1391, count = 1, powerChances = {0, 100, 0}, radius = 256, group = 56}[1]
			mon.NameId = rev4m.placeMon.deyjaNecro
			hpMul(mon, 3)
			resists(mon, 15)
			spells(mon, nil, nil, nil, const.Spells.AcidBurst, JoinSkill(10, const.Master), 30)
			addDamage(mon, 0, 0, 20)
			rewards(mon, 10, {-5, const.ItemType.Ring, 100}, 5)
		elseif Map.Name == "7out06.odm" then -- The Bracada Desert
			
		elseif Map.Name == "out09.odm" then -- Evenmorn Island
			
		elseif Map.Name == "out10.odm" then -- Mount Nighon
			
		elseif Map.Name == "out11.odm" then -- The Barrow Downs
			
		elseif Map.Name == "out12.odm" then -- The Land of the Giants
			-- The Oldest Titan
			local mon = pseudoSpawnpoint{monster = 409, x = 6020, y = -3299, z = 1169, count = 1, powerChances = {0, 0, 100}, radius = 64, group = 51}[1]
			mon.NameId = rev4m.placeMon.theOldestTitan
			hpMul(mon, diffsel(2, 3, 3.5))
			resists(mon, 20)
			addDamage(mon, 2, 5)
			acMul(mon, diffsel(1.2, 1.3, 1.4))
			rewards(mon, 8, -7, 4)
		elseif Map.Name == "7out13.odm" then -- Tatalia
			
		elseif Map.Name == "out14.odm" then -- Avlee
			
		elseif Map.Name == "7out15.odm" then -- Shoals
			
		elseif Map.Name == "d01.blv" then -- The Erathian Sewers
			-- Master Thief Advisor
			local mon = pseudoSpawnpoint{monster = 256, x = 1105, y = 13164, z = -563, count = 1, powerChances = {0, 100, 0}, radius = 64, group = 0}[1]
			mon.NameId = rev4m.placeMon.masterThiefAdvisor
			hpMul(mon, diffsel(2, 2.5, 3))
			resists(mon, 10)
			damage(mon, diffsel("2d4+10", "3d4+8", "4d4+6"))
			rewards(mon, 5, -3, 2)
			spells(mon, const.Spells.FireBolt, JoinSkill(7, const.Expert), 30)
		elseif Map.Name == "d02.blv" then -- The Maze
			
		elseif Map.Name == "d03.blv" then -- Castle Gloaming
			
		elseif Map.Name == "d04.blv" then -- The Temple of Baa
			
		elseif Map.Name == "7d05.blv" then -- The Arena
			
		elseif Map.Name == "7d06.blv" then -- The Temple of the Moon
			
		elseif Map.Name == "7d07.blv" then -- Thunderfist Mountain
			
		elseif Map.Name == "7d08.blv" then -- The Gauntlet
			
		elseif Map.Name == "7d09.blv" then -- The Titans' Stronghold
			
		elseif Map.Name == "7d10.blv" then -- The Breeding Zone
			
		elseif Map.Name == "7d11.blv" then -- The Walls of Mist
			
		elseif Map.Name == "7d12.blv" then -- The Coding Fortress
			
		elseif Map.Name == "7d13.blv" then -- Zokarr's Tomb
			
		elseif Map.Name == "7d14.blv" then -- The School of Sorcery
			
		elseif Map.Name == "7d15.blv" then -- Watchtower 6
			
		elseif Map.Name == "7d16.blv" then -- The Wine Cellar
			-- BOOST SUPER VAMPIRE
		elseif Map.Name == "7d17.blv" then -- The Tidewater Caverns
			-- derelict adventurer
			local mon = pseudoSpawnpoint{monster = 403, x = 270, y = 7671, z = 992, count = 1, powerChances = {0, 0, 100}, radius = 256, group = 56}[1]
			mon.NameId = rev4m.placeMon.derelictAdventurer
			hostile(mon)
			mon.ArmorClass = 40
			hpMul(mon, 4)
			damage(mon, diffsel("5d6+5", "5d6+10", "5d6+15"))
			resists(mon, 10)
			spells(mon, const.Spells.IceBolt, JoinSkill(8, const.Master), 25)
			rewards(mon, 5, nil, 10)
		elseif Map.Name == "7d18.blv" then -- Lord Markham's Manor
			
		elseif Map.Name == "7d19.blv" then -- Grand Temple of the Moon
			
		elseif Map.Name == "7d20.blv" then -- The Mercenary Guild
			
		elseif Map.Name == "7d21.blv" then -- White Cliff Cave
			
		elseif Map.Name == "7d22.blv" then -- The Hall under the Hill
			
		elseif Map.Name == "7d23.blv" then -- The Lincoln
			
		elseif Map.Name == "7d24.blv" then -- Stone City
			-- idea from MM7 Reimagined
			local mon = pseudoSpawnpoint{monster = 412, x = -9248, y = 3548, z = -1391, count = 1, powerChances = {0, 0, 100}, radius = 64, group = 51}[1]
			mon.NameId = rev4m.placeMon.infernalTroglodyte
			hpMul(mon, diffsel(5, 6, 8))
			hostile(mon)
			mon.Attack1.DamageDiceCount = math.round(mon.Attack1.DamageDiceCount * diffsel(2, 2.5, 3))
			spells(mon, const.Spells.IceBolt, JoinSkill(diffsel(10, 13, 16), const.GM), 50)
			resists(mon, {20, 20, 20, 20, 0, 0, 0, 20, 20, 20})
			rewards(mon, 20, -4, 8)
		elseif Map.Name == "7d25.blv" then -- Celeste
			
		elseif Map.Name == "7d26.blv" then -- The Pit
			
		elseif Map.Name == "7d27.blv" then -- Colony Zod
			
		elseif Map.Name == "7d28.blv" then -- The Dragon's Lair
			
		elseif Map.Name == "7d29.blv" then -- Castle Harmondale
			
		elseif Map.Name == "7d30.blv" then -- Castle Lambent
			
		elseif Map.Name == "7d31.blv" then -- Fort Riverstride
			
		elseif Map.Name == "7d32.blv" then -- Castle Navan
			
		elseif Map.Name == "7d33.blv" then -- Castle Gryphonheart
			
		elseif Map.Name == "7d34.blv" then -- The Red Dwarf Mines
			
		elseif Map.Name == "7d35.blv" then -- Nighon Tunnels
			
		elseif Map.Name == "7d36.blv" then -- Tunnels to Eeofol
			
		elseif Map.Name == "7d37.blv" then -- The Haunted Mansion
			-- primordial barrow wight
			local mon = pseudoSpawnpoint{monster = 421, x = 56, y = 1072, z = -72, count = 1, powerChances = {0, 0, 100}, radius = 256, group = 56}[1]
			mon.NameId = rev4m.placeMon.primordialBarrowWight
			hpMul(mon, diffsel(2, 2.5, 3))
			addDamage(mon, 1, 2, diffsel(3, 5, 7))
			rewards(mon, 1, -5, 10)
		elseif Map.Name == "mdk01.blv" then -- Barrow VII
			
		elseif Map.Name == "mdk02.blv" then -- Barrow IV
			
		elseif Map.Name == "mdk03.blv" then -- Barrow II
			
		elseif Map.Name == "mdk04.blv" then -- Barrow XIV
			
		elseif Map.Name == "mdk05.blv" then -- Barrow III
			
		elseif Map.Name == "mdt01.blv" then -- Barrow IX
			
		elseif Map.Name == "mdt02.blv" then -- Barrow VI
			
		elseif Map.Name == "mdt03.blv" then -- Barrow I
			
		elseif Map.Name == "mdt04.blv" then -- Barrow VIII
			
		elseif Map.Name == "mdt05.blv" then -- Barrow XIII
			
		elseif Map.Name == "mdr01.blv" then -- Barrow X
			
		elseif Map.Name == "mdr02.blv" then -- Barrow XII
			
		elseif Map.Name == "mdr03.blv" then -- Barrow V
			
		elseif Map.Name == "mdr04.blv" then -- Barrow XI
			
		elseif Map.Name == "mdr05.blv" then -- Barrow XV
			
		elseif Map.Name == "mdt09.blv" then -- Blue Guardian's Trove
			
		elseif Map.Name == "mdt10.blv" then -- The Treasury
			
		elseif Map.Name == "mdt11.blv" then -- The Kennel
			
		elseif Map.Name == "mdt12.blv" then -- The Vault
			
		elseif Map.Name == "mdt14.blv" then -- The Bandit Caves
			-- Unrelenting Soldier
			local mon = pseudoSpawnpoint{monster = 193, x = 1751, y = 35, z = -44, count = 1, powerChances = {100, 0, 0}, radius = 64, group = 56}[1]
			mon.NameId = rev4m.placeMon.unrelentingSoldier
			addDamage(mon, 1, 1, diffsel(0, 2, 4))
			hpMul(mon, diffsel(2, 2.25, 2.5))
			resists(mon, 5)
			rewards(mon, 5, {-2, 100, const.ItemType.Sword}, 2)
		elseif Map.Name == "mdt15.blv" then -- The Small House
			
		elseif Map.Name == "t01.blv" then -- Temple of the Light
			
		elseif Map.Name == "t02.blv" then -- Temple of the Dark
			
		elseif Map.Name == "t03.blv" then -- Grand Temple of the Sun
			
		elseif Map.Name == "t04.blv" then -- The Hall of the Pit
			
		elseif Map.Name == "7nwc.blv" then -- The Strange Temple
			
		elseif Map.Name == "7d08orig.blv" then -- The Tularean Caves
			
		elseif Map.Name == "7d12orig.blv" then -- Clanker's Laboratory
			
		elseif Map.Name == "mdt09orig.blv" then -- Wromthrax's Cave
			
		elseif Map.Name == "mdt12orig.blv" then -- The Dragon Caves
			
		elseif Map.Name == "7nwcorig.blv" then -- The Strange Temple
			
		end
	end
end

-- remove most free endgame items

-- pretty-print chest contents in editor in Rev4
local function rev4ChestDump()
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
end

-- in editor in Merge
local function mergeChestDump()
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
end

-- copy-paste from rev4 to merge
local function chestsRev4ToMerge()
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
end

if not isEasy() and Merge.ModSettings.Rev4ForMergeRemoveFreeEndgameItems == 1 then
	-- for k, v in Map.Objects do if v.Item then print(k, v.Item.Number, Game.ItemsTxt[v.Item.Number].Name) end end
	-- defined in file General/ZRev4 for Merge.lua
	-- local function randomizeAndSetCorrectType(id, level, typ)
	local function randomizeAndSetCorrectType(id, level, typ) -- just Randomize() leaves item look on map unchanged
		if Merge.ModSettings.Rev4ForMergeRandomizeRemovedItems == 1 then
			local obj = Map.Objects[id]
			local mapStats = Game.MapStats[Map.MapStatsIndex]
			local old = mapStats.Tres
			mapStats.Tres = 6 -- hack to make treasure levels directly correspond to real treasure levels
			obj.Item:Randomize(level, typ)
			mapStats.Tres = old
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
				removeOrReplace({{id = 3, level = 2, itemType = const.ItemType.Sword}, {id = 10, level = 2, itemType = const.ItemType.Bow}})
				if isHard() then
					removeOrReplace({{id = 1, level = 2, itemType = const.ItemType.Mace}, {id = 8, level = 2, itemType = const.ItemType.Leather}})
					--Map.Objects[2].Item.Bonus2 = 700 -- down from 1700
				end
				-- chests
			elseif Map.Name == "7out02.odm" then -- Harmondale
				removeOrReplace({{id = 2, level = 3, itemType = const.ItemType.Amulet}})
				if MS.Rev4ForMergeRemoveBowsOfCarnage == 1 then
					-- it's a delicate issue, so I'll require additional check to remove these bows
					removeOrReplace({{id = 1, level = 3, itemType = const.ItemType.Bow}})
				end
				-- chests
			elseif Map.Name == "7out04.odm" then -- Tularean Forest
				removeOrReplace({{id = 109, level = 2, itemType = const.ItemType.Sword}})
			elseif Map.Name == "7out05.odm" then -- Deyja
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
				-- reputation to sell at cost at like expert 5 merchant (which is basically given for free
				-- at beginning of the game)
				
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

if MS.Rev4ForMergeManaHealthRegenStacking == 1 then
	-- make mana and health-restoring spc items stack linearly (extra restore is (items - 1) * items / 2, so 0, 1, 3, 6, 10...
	function events.RegenTick(pl)
		local manaRegenSpcBonuses = {38, 47, 55, 66}
		local healthRegenSpcBonuses = {37, 44, 50, 54, 66}
		local manaRegenItems = {513, 1331, 1334, 1439}
		local healthRegenItems = {509, 520, 1331, 1337, 1439, 2027}
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

function events.GetShopSellPriceMul(t)
	if isEasy() then return end
	t.Multiplier = isMedium() and 0.75 or 0.5
end