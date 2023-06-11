local MS = Merge.ModSettings
if not _G.getQuestBit then
	error("Data conversion functions are undefined")
end
if MS.Rev4ForMergeActivateExtraQuests == 1 then
	local questID = "ClearFortRiverstride"
	KillMonstersQuest {
		questID,
		{Map = "7d31.blv", Group = {56, 57, 58}},
		Gold = 10000,
		Experience = 35000,
		NPC = 771,
		Slot = 2,
		--Quest = REV4_FOR_MERGE_QUEST_INDEX,
		Done = function()
			for i = 1, 3 do
				evt.Add("Inventory", 1418)
			end
		end,
		Texts =
		{
			Topic = "Quest",
			TopicDone = false,
			Give = [[So you consider yourself good fighters? Let's put your skills into test. There's an old fort in Erathia, which guards the river against entry by us. If you are able to kill all creatures inside, we'll have much easier time invading Erathia.
			
Oh, one more warning. We've heard gossips that necromancers tried to take over the location by force, and Bracada sent its wizards to curb them. Be careful.]],
			Undone = "Our scouts have reported that they sighted guards inside the fort. Go on and kill them!",
			Done = "Well done! Now conquering Erathia will be a piece of cake. Take these genie lamps as your reward. I've inherited them from my mother, and we both were too afraid to use them. Maybe you'll be able to somehow overpower the genies' wrath.",
			
			Quest = "Kill everything inside Fort Riverstride and return to Rainyn Rivencrest in Tularean Forest.",
			Award = "Cleared out Fort Riverstride"
		}
	}
	
	function events.AfterLoadMap()
		if Map.Name == "7d31.blv" then -- Fort Riverstride
			Game.MapEvtLines:RemoveEvent(451)
			evt.map[451].clear()
			if not mapvars.MonstersCreated then
				mapvars.MonstersCreated = true
				-- plate fighters
				SummonMonster(259, 160, 1029, 0, true)
				SummonMonster(259, 448, 1092, 0, true)
				SummonMonster(260, -1050, -520, -448, true)
				
				SummonMonster(261, -3982, 1957, -896, true)
				
				pseudoSpawnpoint(259, 36, -786, -448, "2-3", {100, 0, 0})
				
				-- wizards
				pseudoSpawnpoint(292, -525, 199, 0, "2-3")
				
				pseudoSpawnpoint(292, -3259, 181, -896, "2-4", {50, 30, 20})
				
				pseudoSpawnpoint(292, -2629, 1311, -896, "2-4", {50, 30, 20})
				
				pseudoSpawnpoint(292, -1686, -111, -896, "2-4")
				
				
				-- leather fighters in main hallway
				for i = 0, 8 do
					SummonMonster(258, -1064 + 250 * i, -193, -448, true)
				end
				
				-- oozes
				for i = 0, 8 do
					SummonMonster(311, -1002 + 250 * i, 137, -448, true)
				end
				
				-- necromancers in one of the rooms
				pseudoSpawnpoint(307, 801, -740, -448, "2-3", {60, 40, 0})
				
				-- golems
				pseudoSpawnpoint(277, -2382, -422, -896, "2-3", {70, 20, 10})
				pseudoSpawnpoint(277, -4348, 2281, -896, "2-3", {70, 20, 10})
				
				-- liches
				pseudoSpawnpoint(289, -4533, 988, -896, "2-3", {70, 30, 0})
				
				-- ghasts
				pseudoSpawnpoint(454, -2194, 1846, -896, "5-10")
			end
			local function isWizardOrGolem(id)
				return (id + 2):div(3) == 98 or (id + 2):div(3) == 93
			end
			local function isUndeadOrNecro(id)
				return Game.IsMonsterOfKind(id, const.MonsterKind.Undead) or (id + 2):div(3) == 103
			end
			for k, v in Map.Monsters do
				if isWizardOrGolem(v.Id) then
					v.Group = 58
				elseif isUndeadOrNecro(v.Id) then
					v.Group = 57
				else
					v.Group = 56
				end
				v.ShowOnMap = false
			end
			for i = 56, 58 do
				evt.SetMonGroupBit(i, const.MonsterBits.Hostile, true)
			end
		end
	end
end

--------------------------- WROMTHRAX'S CAVE QUEST

-- There is portal which is spawning ether knights (maybe only if previous spawns are killed)
-- in addition to one-time spawns
-- Wromthrax is buffed and holds "ether gem"
-- after getting ether gem you can interact with the portal to close it
-- now ether knights stop spawning
-- if you clear the entire cave now, the quest is completed
-- add chests?

-- boost spiders level/experience/hit radius?

sharedSpawnpoint = {}
sharedSpawnpoints = {}
local function monClass(Id)
	if not Id then return end
	return (Id + 2):div(3)
end
function sharedSpawnpoint.new(mapname, spawnpointId, monster, max)
	if not mapname or not spawnpointId then error("Invalid parameters passed to sharedSpawnpoint.new function") end
	local MAX_SPAWNED_AT_ONCE = diffsel(4, 6, 8)
	local ret = {}
	local spawns = {}
	local maxSpawnByType = {}
	local spawned = {}
	local settings = {}
	local transforms = {}
	local class = monClass(monster)
	if class and max then
		maxSpawnByType[class] = max
	end
	function ret.setSpawnSettings(s)
		settings = table.copy(s)
	end
	function ret.saveSpawnedMonsters()
		if Map.Name ~= mapname then return end
		mapvars.SharedSpawnpointMonsters = mapvars.SharedSpawnpointMonsters or {}
		mapvars.SharedSpawnpointMonsters[spawnpointId] = {}
		for class, monArray in pairs(spawned) do
			mapvars.SharedSpawnpointMonsters[spawnpointId][class] = mapvars.SharedSpawnpointMonsters[spawnpointId][class] or {}
			for _, mon in ipairs(monArray) do
				table.insert(mapvars.SharedSpawnpointMonsters[spawnpointId][class], mon:GetIndex())
			end
		end
	end
	function ret.loadSpawnedMonsters()
		if Map.Name ~= mapname then return end
		mapvars.SharedSpawnpointMonsters = mapvars.SharedSpawnpointMonsters or {}
		local entry = mapvars.SharedSpawnpointMonsters[spawnpointId]
		if not entry then
			return
		elseif Map.Refilled then
			mapvars.SharedSpawnpointMonsters[spawnpointId] = {}
			return
		end
		for class, mapMonIds in pairs(entry) do
			for _, mapMonId in ipairs(mapMonIds) do
				if mapMonId < Map.Monsters["count"] then
					local mon = Map.Monsters[mapMonId]
					spawned[class] = spawned[class] or {}
					table.insert(spawned[class], mon)
				end
			end
		end
	end
	function ret.addSpawnpoint(data)
		if type(data) ~= "table" then error("Argument passed to sharedSpawnpoint.addSpawnpoint() isn't a table") end
		local class = monClass(data.monster)
		spawns[class] = spawns[class] or {}
		table.insert(spawns[class], data)
	end
	function ret.setMax(mon, max)
		maxSpawnByType[monClass(mon)] = max
	end
	function ret.setDefaultMax(max)
		MAX_SPAWNED_AT_ONCE = max
	end
	function ret.spawn()
		local monsterSpawnpoints, class
		local function spawn2()
			if Map.Name ~= mapname then
				error(string.format("Tried to spawn monsters while on different map. Destination map: %s, current map: %s", mapname, Map.Name), 3)
			end
			if #monsterSpawnpoints == 0 then return end
			local randOrder = {}
			if settings.RandomSpawnpointOrder then
				while #randOrder < #monsterSpawnpoints do
					local i = math.random(1, #monsterSpawnpoints)
					if not table.find(randOrder, i) then
						table.insert(randOrder, i)
					end
				end
			else
				for i = 1, #monsterSpawnpoints do
					randOrder[i] = i
				end
			end
			for _, index in ipairs(randOrder) do
				local spawn = monsterSpawnpoints[index]
				local canSpawn = (maxSpawnByType[class] or MAX_SPAWNED_AT_ONCE) - #(spawned[class] or {})
				local maxInOneSpawn = canSpawn
				local minInOneSpawn = 1
				if settings.ExactSpawnMin then
					local min, max = getRange(spawn.count)
					minInOneSpawn = min
				end
				if settings.ExactSpawnMax then
					local min, max = getRange(spawn.count)
					maxInOneSpawn = max
				end
				if settings.DivideAcrossAllSpawnpoints then
					maxInOneSpawn = math.ceil(canSpawn / #monsterSpawnpoints)
				end
				local max = math.min(canSpawn, maxInOneSpawn)
				if max <= 0 then return end
				local oldTransform = spawn.transform
				local function newTransform(mon)
					if oldTransform then
						oldTransform(mon)
					end
					local f = transforms[class]
					if f then
						f(mon)
					end
				end
				spawn.transform = newTransform
				local oldC = spawn.count
				spawn.count = minInOneSpawn == max and max or (tostring(minInOneSpawn) .. "-" .. tostring(max))
				local mons = pseudoSpawnpoint(spawn)
				spawn.count, spawn.transform = oldC, oldTransform
				for i, v in ipairs(mons) do
					local class = monClass(v.Id)
					spawned[class] = spawned[class] or {}
					table.insert(spawned[class], mons[i])
				end
				canSpawn = canSpawn - #mons
			end
		end
		for k, v in pairs(spawns) do
			class = k
			monsterSpawnpoints = v
			spawn2()
		end
	end
	function ret.getSpawnedMonsters(monster)
		local class = monClass(monster)
		return class and spawned[class] or spawned
	end
	function ret.tryRemoveSpawnedMonster(mon)
		if mapname ~= Map.Name then return end
		if mon then
			local class = monClass(mon.Id)
			spawned[class] = spawned[class] or {}
			local index = table.find(spawned[class], mon)
			if index then
				table.remove(spawned[class], index)
			end
		else
			spawned = {}
		end
	end
	ret.tryRemoveAllSpawnedMonsters = ret.tryRemoveSpawnedMonster
	function ret.clearSpawns(monster)
		local class = monClass(monster)
		if class then
			spawns[class] = {}
		else
			spawns = {}
		end
	end
	ret.clearAllSpawns = ret.clearSpawns
	function ret.getMap()
		return mapname
	end
	function ret.setTransform(mon, fn)
		transforms[monClass(mon)] = fn
	end
	function ret.clearSpawnedTable()
		spawned = {}
	end
	
	table.insert(sharedSpawnpoints, ret)
	return ret
end

local cleared -- needed to not save twice on leaving map (first time from LeaveMap, clearing table,
			  -- and second time from BeforeSaveGame, overriding correct table with empty one)
function events.LoadMap()
	cleared = false
	for _, ss in ipairs(sharedSpawnpoints) do
		ss.loadSpawnedMonsters()
		--debug.Message(dump(ss.getSpawnedMonsters(), 2))
	end
end

local save = function(clear)
	return function()
		if cleared then return end
		for _, ss in ipairs(sharedSpawnpoints) do
			ss.saveSpawnedMonsters()
			if clear then
				cleared = true
				ss.clearSpawnedTable()
			end
		end
	end
end

events.LeaveMap = save(true)
events.BeforeSaveGame = save(false)

function events.MonsterKilled(mon, index, handler)
	for _, ss in ipairs(sharedSpawnpoints) do
		ss.tryRemoveSpawnedMonster(mon)
	end
end
if MS.Rev4ForMergeActivateExtraQuests == 1 then
	-- chests, ground items?
	-- randomized monster spells, monster bonuses
	function events.BeforeLoadMap()
		Game.MapStats[238].Tres = 7
	end
	
	local sp = sharedSpawnpoint.new("mdt09orig.blv", "WromthraxCaveQuest")
	sp.setSpawnSettings{["RandomSpawnpointOrder"] = 1, ["DivideAcrossAllSpawnpoints"] = 1}
	sp.addSpawnpoint{monster = 154, x = 18285, y = 7348, z = -127, powerChances = diffsel({70, 20, 10}, {50, 25, 25}, {30, 30, 40}), radius = 512}
	sp.addSpawnpoint{monster = 154, x = 15760, y = 3873, z = -127, powerChances = diffsel({70, 20, 10}, {50, 25, 25}, {30, 30, 40}), radius = 512}
	sp.addSpawnpoint{monster = 154, x = 15002, y = 6179, z = -127, powerChances = diffsel({70, 20, 10}, {50, 25, 25}, {30, 30, 40}), radius = 512}
	sp.setMax(154, diffsel(8, 10, 12))
	sp.setTransform(154, function(mon)
		monUtils.randomBoostResists(mon)
		monUtils.randomGiveSpell(mon)
		mon.TreasureDiceCount = mon.TreasureDiceCount * 3
	end)
	
	sp.addSpawnpoint{monster = 151, x = 16058, y = 8317, z = -127, powerChances = diffsel({70, 20, 10}, {50, 25, 25}, {30, 30, 40}), radius = 512}
	sp.addSpawnpoint{monster = 151, x = 16913, y = 4169, z = -127, powerChances = diffsel({70, 20, 10}, {50, 25, 25}, {30, 30, 40}), radius = 512}
	sp.setMax(151, diffsel(3, 5, 7))
	sp.setTransform(151, function(mon)
		monUtils.randomBoostResists(mon)
		mon.PhysResistance = 100 -- remove immunity
		monUtils.randomGiveElementalAttack(mon)
		mon.TreasureDiceCount = mon.TreasureDiceCount * 3
	end)
	
	sp.addSpawnpoint({monster = 145, x = 13493, y = 2928, z = -127, powerChances = diffsel({70, 20, 10}, {50, 25, 25}, {30, 30, 40}), radius = 1024})
	sp.setMax(145, diffsel(3, 4, 6))
	sp.setTransform(145, monUtils.randomBoostResists)
	
	local questID = "WromthraxCaveDisablePortalAndClear"
	local PORTAL_FACET_INDEX = 10
	local DARK_TALISMAN_ID = 981
	vars.WromthraxCaveQuest = vars.WromthraxCaveQuest or {}
	function events.AfterLoadMap() -- need to execute after binding map monsters with spawnpoints that spawned them
		if Map.Name ~= "mdt09orig.blv" then return end
		if not vars.WromthraxCaveQuest.Setup then
			vars.WromthraxCaveQuest.Setup = true
			for i, v in Map.FacetData do
				if v.Id == PORTAL_FACET_INDEX then
					vars.WromthraxCaveQuest.OldBitmapIds = vars.WromthraxCaveQuest.OldBitmapIds or {}
					local f = Map.Facets[v.FacetIndex]
					vars.WromthraxCaveQuest.OldBitmapIds[v.FacetIndex] = f.BitmapId
				end
			end
			
			--[[local function randomizeAndSetCorrectType(obj, level, typ) -- override general function, because we don't want to remove items
				debug.Message(obj.Item.Number)
				obj.Item:Randomize(level, typ)
				debug.Message(obj.Item.Number)
				obj.Type = Game.ItemsTxt[obj.Item.Number].SpriteIndex
				obj.TypeIndex = Game.ItemsTxt[obj.Item.Number].SpriteIndex
			end
			for i, v in Map.Objects do
				if v.Item and v.Item.Number ~= 0 then
					randomizeAndSetCorrectType(v, 6)
				end
			end]]
			
			local WromthraxId -- could be assumed 0 because he is the only monster on the map, but just in case I'll do a loop
			for k, v in Map.Monsters do
				if v.NameId == 117 then
					WromthraxId = k
					break
				end
			end
			if WromthraxId then
				local wrom = Map.Monsters[WromthraxId]
				XYZ(wrom, 17477, 6215, -127) -- move him deeper into the cave, where he'll be protected by his legions of monsters
				wrom.StartX, wrom.StartY, wrom.StartZ, wrom.GuardX, wrom.GuardY, wrom.GuardZ = wrom.X, wrom.Y, wrom.Z, XYZ(wrom)
				wrom.HP, wrom.FullHP = math.round(wrom.FullHP * diffsel(1.2, 1.6, 2.1)), math.round(wrom.FullHP * diffsel(1.2, 1.6, 2.1))
				wrom.Group = 255
				wrom.Spell, wrom.SpellChance, wrom.SpellSkill = const.Spells.IceBlast, (difficulty + 1) * 10, JoinSkill((difficulty + 1) * 5, const.GM)
				wrom.Spell2, wrom.Spell2Chance, wrom.Spell2Skill = const.Spells.PowerCure, (difficulty + 1) * 15, JoinSkill((difficulty + 1) * 8, const.GM)
				monUtils.boostResistances(wrom, diffsel(10, 30, 50))
				wrom.Attack1.DamageAdd = diffsel(20, 25, 30)
				wrom.TreasureDiceCount = wrom.TreasureDiceCount * 3
				evt.SetMonsterItem{Monster = WromthraxId, Item = DARK_TALISMAN_ID, Has = true}
			else
				-- killed before enabling extra quests
				SummonItem(DARK_TALISMAN_ID, 17477, 6215, -127)
			end
			
			-- no chests, so let's just scatter a bunch of highest-lvl items
			pseudoSpawnpointItem{x = 14557, y = 5769, z = -127, count = 35, radius = 4096, level = 6}
			
			-- one-time spawnpoints
			-- knights
			local n = pseudoSpawnpoint{monster = 154, x = 9418, y = 9879, z = -127, count = diffsel("3-6", "5-9", "8-13"), powerChances = diffsel({60, 30, 10}, {50, 25, 25},  {34, 33, 33}), radius = 4096}
			n = table.join(n, pseudoSpawnpoint{monster = 154, x = 10281, y = 2911, z = -127, count = diffsel("3-6", "5-9", "8-13"), powerChances = diffsel({60, 30, 10}, {50, 25, 25},  {34, 33, 33}), radius = 4096})
			for i, v in ipairs(n) do
				monUtils.randomBoostResists(v)
				monUtils.randomGiveSpell(v)
				v.TreasureDiceCount = v.TreasureDiceCount * 3
				--randomGiveElementalAttack(v)
			end
			
			-- nightmares
			n = pseudoSpawnpoint{monster = 151, x = 7073, y = 3927, z = -127, count = diffsel("2-4", "4-7", "6-10"), powerChances = diffsel({60, 30, 10}, {50, 25, 25},  {34, 33, 33}), radius = 4096}
			for i, v in ipairs(n) do
				monUtils.randomBoostResists(v)
				v.PhysResistance = 150
				monUtils.randomGiveElementalAttack(v)
				v.TreasureDiceCount = v.TreasureDiceCount * 3
			end
			
			-- "MM8 behemoths"
			n = pseudoSpawnpoint{monster = 145, x = 11704, y = 6109, z = 65, count = diffsel("2-4", "4-7", "7-11"), powerChances = diffsel({60, 30, 10}, {50, 25, 25},  {34, 33, 33}), radius = 4096}
			for i, v in ipairs(n) do
				monUtils.randomBoostResists(v)
				--randomGiveElementalAttack(v)
			end
		end
		
		if not vars.WromthraxCaveQuest.PortalDeactivated then
			Timer(sp.spawn, const.Minute * diffsel(30, 25, 20), Game.Time, true)
			local function rem()
				RemoveTimer(sp.spawn)
				events.Remove("LeaveMap", rem)
				events.Remove("LeaveGame", rem)
			end
			events.LeaveMap = rem
			events.LeaveGame = rem
			for i, v in Map.FacetData do
				if v.Id == PORTAL_FACET_INDEX then
					v.Event = 200
					local f = Map.Facets[v.FacetIndex]
					f.ScrollUp = true
					f.TriggerByClick = true
				end
			end
			evt.SetTexture{Facet = PORTAL_FACET_INDEX, Name = "sgSTARS"}
			evt.map[200] = function()
				if evt.All.Cmp("Inventory", DARK_TALISMAN_ID) then
					for i, v in Map.FacetData do
						if v.Id == PORTAL_FACET_INDEX then
							v.Event = 0
							local f = Map.Facets[v.FacetIndex]
							f.ScrollUp = false
							f.TriggerByClick = false
							v.BitmapId = vars.WromthraxCaveQuest.OldBitmapIds[f.FacetIndex]
						end
					end
					vars.WromthraxCaveQuest.PortalDeactivated = true
					evt.All.Subtract("Inventory", DARK_TALISMAN_ID)
					evt.map[200].clear()
					RemoveTimer(sp.spawn)
					Game.ShowStatusText("Portal deactivated!")
				else
					Game.ShowStatusText("You need something to close the portal with!")
				end
			end
			evt.hint[200] = "Strange portal"
		else
			-- I don't know if facets changed directly (not by evt command) will have their bitmap IDs saved
			-- on map reload, putting this code just in case
			for i, v in Map.FacetData do
				if v.Id == PORTAL_FACET_INDEX then
					v.BitmapId = vars.WromthraxCaveQuest.OldBitmapIds[v.FacetIndex]
				end
			end
		end
	end
	
	KillMonstersQuest{
		questID,
		{Map = "mdt09orig.blv", Group = 255},
		CheckDone = function() return vars.WromthraxCaveQuest.PortalDeactivated end, -- kill monsters part is handled by MMExt
		NPC = 779, -- Rawn Talreish in Erathia (house with a pillar in front of it)
		Slot = 3,
		Experience = 220000,
		Gold = 45000,
		--Quest = REV4_FOR_MERGE_QUEST_INDEX + 1,
		Done = function() for i = 0, 2 do for j = 1, 3 + (2 - i) do evt.Add("Inventory", 1491 + i) end end end, --  5 Kergar, 4 Erudine, 3 Stalt
		Texts = {
			Topic = "Quest",
			TopicDone = false,
			Give = [[For a long time, we had thought that, after many battles, we finally settled on peace with Wromthrax, Tatalia's blue dragon. We had to not disturb him and give him monthly tributes, both in food and gold, and in return he didn't attack or anyhow damage humans. But recently, several people went into his cave and they all reported seeing the dragon inside to work with forces not belonging to this world. He even managed to open a portal and summon new ones through it!

We're afraid they're preparing an invasion into our world. Can you help us? If you manage to somehow close the portal and kill all creatures inside, you'll have done all of us a great favor. But don't go there unprepared. The creatures are really intimidating and it's best that you prepare everything you can before venturing there.]],
			Undone = "Did you fail to counter the dragon's plans? You have to help us, you're our only hope!",
			Done = "Well done! Now we will feel much safer, thanks to you. Take these pieces of ore I've found in my travels. Hope they will help you.",
			
			Quest = "Deal with the dangerous forces in Wromthrax's Cave in Tatalia and return to Rawn Talreish in Erathia.",
			Award = "Stopped Wromthrax's evil plans"
		}
	}
	
	
	
	-- CLANKER'S LAB QUEST
	-- quest giver: Elzbet Winterspoon (Nighon, master alchemy trainer)
	-- could be alchemy GM, but he already manages one quest in Rev4
	-- bring back pristine Phoenix Feather, pristine Dragon Turtle Fang and pristine Unicorn Horn

	-- TODO: this item in conjunction with reagents is way too powerful reward
	local rewardItem = 1394 -- Mog'Draxar
	local itemIDs = {982, 983, 984}
	local questID = "ClankersLabCollectPowerfulReagents"
	Quest{
		questID,
		NPC = 546, -- Elzbet Winterspoon in Nighon
		Slot = 2,
		Experience = 125000,
		Gold = 25000,
		--Quest = REV4_FOR_MERGE_QUEST_INDEX + 2,
		CheckDone = function()
			for i = 1, 3 do
				if not evt.Cmp("Inventory", itemIDs[i]) then
					return false
				end
			end
			return true
		end,
		Done = function()
			for i = 1, 3 do
				evt.Subtract("Inventory", itemIDs[i])
			end
			
			-- give 5 of each MM7 strongest reagent
			for i = 0, 4 do
				for j = 0, 15, 5 do
					evt.GiveItem{Id = 1006 + j}
				end
			end
			evt.GiveItem{Id = rewardItem}
		end,
		Texts = {
			Topic = "Quest",
			TopicDone = false,
			Give = [[I've always had dreams of becoming the greatest alchemist in the world. They have been made impossible by Clanker's and Lucid Apple's success, obviously. But I still can be much better than I am right now.
			
I've read about an old concoction, appropriately named Potion of the Swift Mind, which reportedly greatly enhances the imbiber's intelligence. I don't believe it is as good as it sounds, but still, something is better than nothing, right?

Unfortunately, it requires three magic reagents I don't have: Pristine Phoenix Feather, Pristine Dragon Turtle Fang and Pristine Unicorn Horn. They're so powerful that the alchemists have used up all of them long time ago. Except... Yes, maybe my greatest adversary could prove useful for once. There's a sliver of chance that Clanker has them in his old lab in Tularean forest. Will you help an old woman pursue her dream? You'll be greatly rewarded for your support.

But beware, this place attracts magic like crazy. I wouldn't be surprised if Clanker used this aura to create some powerful magical guardians to assist in defending his place. He won't give away his secrets so easily.]],
			Undone = "Did you not find them? Please search the lab thoroughly, knowing Clanker he hid them in most obscure locations.",
			Done = "YOU HAVE DONE IT? Found them? I don't know why he hadn't used them all. But yes, finally some of his character paid off. You will receive your reward as promised. Thanks again for doing the impossible.",
			
			Quest = "Find three alchemical reagents of immense power in Clanker's Laboratory and deliver them to Elzbet Winterspoon in Nighon.",
			Award = "Assisted in creation of the ancient Potion of the Swift Mind."
		}
	}
	
	local manaRing = 985
	function events.LoadMap()
		if Map.Name ~= "7d12orig.blv" then return end
		
		if not mapvars.ClankersLabSetup then
			mapvars.ClankersLabSetup = true
			-- genies
			pseudoSpawnpoint{monster = 265, x = 14, y = 179, z = 1, count = diffsel("1-3", "2-4", "4-5"), powerChances = diffsel({70, 20, 10}, {50, 30, 20}, {34, 33, 33}), radius = 512, group = 56}
			pseudoSpawnpoint{monster = 265, x = 677, y = 2844, z = 385, count = diffsel("1-3", "2-4", "4-5"), powerChances = diffsel({70, 20, 10}, {50, 30, 20}, {34, 33, 33}), radius = 512, group = 56}
			pseudoSpawnpoint{monster = 265, x = 2969, y = 673, z = 193, count = diffsel("1-3", "2-4", "4-5"), powerChances = diffsel({70, 20, 10}, {50, 30, 20}, {34, 33, 33}), radius = 256, group = 56}
			
			-- liches
			pseudoSpawnpoint{monster = 289, x = 2641, y = 2434, z = 385, count = diffsel("1-3", "2-4", "4-5"), powerChances = diffsel({70, 20, 10}, {50, 30, 20}, {34, 33, 33}), radius = 512, group = 56}
			pseudoSpawnpoint{monster = 289, x = -2412, y = 2073, z = 385, count = diffsel("1-3", "2-4", "4-5"), powerChances = diffsel({70, 20, 10}, {50, 30, 20}, {34, 33, 33}), radius = 512, group = 56}
			
			-- manticores
			pseudoSpawnpoint{monster = 295, x = -699, y = 3672, z = 385, count = diffsel("1-2", "2-3", "3-4"), powerChances = diffsel({70, 20, 10}, {50, 30, 20}, {34, 33, 33}), radius = 256, group = 56}
			pseudoSpawnpoint{monster = 295, x = 638, y = 3674, z = 385, count = diffsel("1-2", "2-3", "3-4"), powerChances = diffsel({70, 20, 10}, {50, 30, 20}, {34, 33, 33}), radius = 256, group = 56}
			
			-- miniboss: Clanker's Puppet, mage
			-- changing stats here works, because he is summoned before bolster happens
			local wiz = pseudoSpawnpoint{monster = 292, x = 321, y = 1735, z = 385, count = 1, powerChances = {0, 100, 0}, radius = 32, group = 56, exactZ = true}[1]
			wiz.FullHP = wiz.FullHP * diffsel(3, 4, 5)
			wiz.HP = wiz.FullHP
			monUtils.boostResistances(wiz, diffsel(40, 60, 80))
			wiz.ArmorClass = wiz.ArmorClass * 2
			wiz.Attack1.DamageDiceCount = wiz.Attack1.DamageDiceCount * 2
			wiz.NameId = placemonAdditionalStart
			wiz.Experience = wiz.Experience * 25
			wiz.Special = 1 -- shoot
			wiz.SpecialC = 5 -- x5
			
			-- reward: Enchanter's Ring of Mana Flows
			wiz.Item = manaRing
			
			-- f##k dispel magic, also he needs a damage spell and healing ability
			wiz.Spell, wiz.SpellSkill, wiz.SpellChance = const.Spells.PsychicShock, JoinSkill(diffsel(10, 13, 16), const.GM), 50
			wiz.Spell2, wiz.Spell2Skill, wiz.Spell2Chance = const.Spells.PowerCure, JoinSkill(diffsel(20, 25, 30), const.GM), 30
			
			-- additional random items in chests
			
			for chestID = 1, 14 do
				local fifth, sixth = false, false
				for i, item in Map.Chests[chestID].Items do
					if sixth and fifth then break end
					if item.Number == 0 and not sixth then
						item:Randomize(6)
						sixth = true
					elseif item.Number == 0 and not fifth then
						item:Randomize(5)
						fifth = true
					end
				end
			end
			
			-- put quest items
			-- shelf near evil eye with clanker's amulet
			pseudoSpawnpointItem{item = itemIDs[1], x = 1930, y = -830, z = 289, count = 1, radius = 16, exactZ = true}
			-- on the ground in left reagents storage
			pseudoSpawnpointItem{item = itemIDs[2], x = -2500, y = 2398, z = 385, count = 1, radius = 16, exactZ = true}
			
			-- in chest, left room at the top of minimap
			assert(addChestItem(10, itemIDs[3]))
		end
	end
	
	function events.RegenTick(pl)
		if pl:WearsItem(manaRing) then
			local FSP = pl:GetFullSP()
			pl.SP = math.min(math.max(FSP, pl.SP), pl.SP + 10)
		end
	end
	
	function events.CalcStatBonusByItems(t)
		if not t.Player:WearsItem(rewardItem) then return end
		if t.Stat == const.Stats.HP or t.Stat == const.Stats.SP then
			t.Result = t.Result + 50
		end
	end
	
	function events.GetSkill(t)
		if not t.Player:WearsItem(rewardItem) then return end
		if (t.Skill >= const.Skills.Staff and t.Skill <= const.Skills.Blaster) or (t.Skill >= const.Skills.Fire and t.Skill <= const.Skills.Dark) or t.Skill == const.Skills.Armsmaster then
			local s, m = SplitSkill(t.Result)
			t.Result = JoinSkill(s + 3, m)
		end
	end
	
	
	-- TULAREAN CAVERNS QUEST
	-- similar to original, rescue a prisoner, but you have to use a key and have to kill custom guards

	-- IMPORTANT NOTE: files in Scripts/Localization directory break npc texts
	do
		local cellKey = 979
		local jailerNameId = placemonAdditionalStart + 1
		local NpcToRescue = 1286
		assert(Game.NPCDataTxt[NpcToRescue].Name == "Bradley Clark")
		local questGiverHouseId = 1105
		
		local questId = "TulareanCavesRescuePrisoner"
		local QData = tget(vars, questId)
		
		-- imprisoned and guards alive topic
		NPCTopic{
			NPC = NpcToRescue,
			Slot = 0,
			CanShow = function()
				return vars.Quests[questId] ~= "Done" and not NPCFollowers.NPCInGroup(NpcToRescue) and not QData.guardsKilled
			end,
			"The Rescue",
			"Thank god finally someone came! We can't escape while guards are alive, we'll probably be killed in the process."
		}

		-- guards dead or in party topic
		NPCTopic{
			NPC = NpcToRescue,
			Slot = 0,
			CanShow = function()
				return NPCFollowers.NPCInGroup(NpcToRescue) or QData.guardsKilled
			end,
			"The Escape",
			"We can go now! Please don't waste too much time, we'll probably get some 'tail' from the elves, if you know what I mean."
		}

		-- join topic
		NPCTopic{
			NPC = NpcToRescue,
			Slot = 1,
			CanShow = function()
				return QData.guardsKilled
					and not NPCFollowers.NPCInGroup(NpcToRescue)
					and vars.Quests[questId] ~= "Done"
			end,
			Ungive = function()
				NPCFollowers.Add(NpcToRescue)
				ExitCurrentScreen()
			end,
			"Let's go!"
		}
		
		-- thank you topic
		NPCTopic{
			NPC = NpcToRescue,
			Slot = 0,
			CanShow = function() return vars.Quests[questId] == "Done" end,
			"The Rescue",
			"Thanks again for rescuing me! You are true heroes and have done your people a great favor."
		}

		Quest{
			questId,
			NPC = 588, -- Matric Bowes in Harmondale (he's kinda hidden, he resides in house behind weapon/armor shop),
			-- I always wanted his location to be starting point of an amazing quest
			Slot = 2,
			Experience = 75000,
			Gold = 13000,
			--Quest = REV4_FOR_MERGE_QUEST_INDEX + 3,
			CheckDone = function()
				return NPCFollowers.NPCInGroup(NpcToRescue)
			end,
			Done = function()
				NPCFollowers.Remove(NpcToRescue)
				evt.MoveNPC{NPC = NpcToRescue, HouseId = questGiverHouseId}
				ReloadHouse()
			end,
			Texts = {
				Topic = "Quest",
				TopicDone = false,
				Give = [[I'm glad you've come here. I need your help desperately. See, my best friend Bradley Clark is also a very important person (he is one of human ambassadors who have dealt with elves). That's not as fortunate as it might seem, because elves have kidnapped and imprisoned him! Since then, I've fallen into deep sorrow. I can't take the fact my best friend is no longer here with me, and what's worse, he suffers or maybe even is tortured for information!
				
	I've had a private spy hired to investigate this kidnapping, and he reported he's almost sure my friend is kept in Tularean Caves in the forest. There's a connection with the caves from Elvish castle, but our spy was unable to open the way. We have theorized that maybe you need to arrive from the other side. Whatever, even if the locked door can be bypassed, you shouldn't take this route. You'll have entire legion of elves mad at you.

	The rescue still won't be easy. You can't escape with him until the route is mostly safe, and I'm almost positive you'll need to find a key first (they probably don't keep such important prisoners unlocked).

	Can you do it? You'll be greatly rewarded for your services.]],
				Undone = "What went wrong? Were guards too sturdy or you couldn't find the key? I'm sure it is in the caverns, you'll find it eventually.",
				Done = [[My god, you've actually did it? My friend owes you his life, and you have lifetime of my gratitude. Was the escape mission difficult? [Bradley Clark tells Matric about your epic encounter with guards]. Hah, so not only you managed it, you also did it in such amazing style?
				
	Not only did you help me and my friend, but also dealt very heavy blow to the elves. I hope you will enjoy your reward.
				]],
				
				Quest = "Rescue Bradley Clark from Tularean Caverns and return to Matric Bowes in Harmondale.",
				Award = "Rescued Bradley Clark"
			}
		}

		function events.LoadMap()
			if Map.Name ~= "7d08orig.blv" then return end
			Game.MapEvtLines:RemoveEvent(376)
			evt.map[376].clear()
			evt.hint[376] = "Cell Door"
			evt.map[376] = function()
				if not evt.All.Cmp("Inventory", cellKey) then
					Game.ShowStatusText("It's locked.")
					return
				elseif NPCFollowers.NPCInGroup(NpcToRescue) or vars.Quests[questId] == "Done" then
					Game.ShowStatusText("It's empty.")
					return
				end
				evt.SpeakNPC{NPC = NpcToRescue}
			end
			if not cmpSetMapvarBool("questSetup") then
				-- spawn item near castle navan door
				pseudoSpawnpointItem{item = cellKey, x = -5622, y = -10314, z = 768, count = 1}

				-- elven warrior guards
				pseudoSpawnpoint{monster = 250, x = -4849, y = -9421, z = 703, powerChances = {20, 20, 60}, count = 6, transform = function(mon)
					monUtils.hp(mon, 2)
					monUtils.rewards(mon, 8, nil, 4)
				end}

				-- guards near npc cell
				-- elven warriors
				local guards = {}
				local function warrior(lev)
					return function(mon)
						table.insert(guards, mon:GetIndex())
						mon.NameId = jailerNameId
						monUtils.hp(mon, lev)
						monUtils.rewards(mon, 5 + lev * 2, -4, lev)
						mon.Attack1.DamageAdd = mon.Attack1.DamageAdd + lev * 3
					end
				end
				-- pillar room
				pseudoSpawnpoint{monster = 250, x = 9084, y = 7435, z = -29, count = 4, powerChances = {33, 33, 34}, transform = warrior(3)}
				pseudoSpawnpoint{monster = 250, x = 7947, y = 6682, z = -68, count = 4, powerChances = {33, 33, 34}, transform = warrior(3)}

				-- cell slope
				pseudoSpawnpoint{monster = 250, x = 12228, y = 4095, z = 622, count = 2, powerChances = {0, 0, 100}, transform = warrior(2)}
				pseudoSpawnpoint{monster = 250, x = 11791, y = 3998, z = 622, count = 2, powerChances = {0, 0, 100}, transform = warrior(2)}

				-- archers
				local function archer(lev)
					return function(mon)
						table.insert(guards, mon:GetIndex())
						mon.NameId = jailerNameId
						monUtils.hp(mon, lev)
						monUtils.rewards(mon, lev * 4, -4, lev)
						mon.Attack1.DamageDiceSides = math.round(mon.Attack1.DamageDiceSides * (1 + 0.1 * lev))
					end
				end
				-- cell slope
				pseudoSpawnpoint{monster = 247, x = 11441, y = 5474, z = 315, count = "2-3", powerChances = {40, 40, 20}, transform = archer(3)}
				pseudoSpawnpoint{monster = 247, x = 12171, y = 2951, z = 795, count = "2-3", powerChances = {20, 50, 30}, transform = archer(2)}
				
				mapvars.aliveGuards = guards
				evt.SetMonGroupBit(255, const.MonsterBits.Hostile, true)

				-- wyverns guarding switch
				local function wyvern(mon)
					monUtils.hp(mon, 3)
					monUtils.spells(mon, const.Spells.PoisonSpray, 40, JoinSkill(7, const.Master))
					monUtils.resists(mon, 15)
					monUtils.rewards(mon, 10, -3, 5)
				end

				pseudoSpawnpoint{monster = 121, x = -6542, y = 10041, z = 648, count = 1, powerChances = {0, 100, 0}, transform = wyvern}
				pseudoSpawnpoint{monster = 121, x = -8033, y = 10290, z = 638, count = 1, powerChances = {0, 100, 0}, transform = wyvern}
			end
			-- fixme: when quests are disabled, killing guards won't count
			function events.MonsterKilled(mon, index)
				local i = table.find(mapvars.aliveGuards, index)
				if i then
					table.remove(mapvars.aliveGuards, i)
					if #mapvars.aliveGuards == 0 then
						QData.guardsKilled = true
					end
				end
			end
		end
	end
end

-- RESTORE TRUMPET QUEST



-- BDJ change class quest

-- each different class has own topic
-- current player index in variables
-- enter npc: set quest branch
-- save quest branch in vars when switching
do
	local cc = const.Class
	local mt = getmetatable(const.Class) or {}
	local oldIndex = mt.__index or function() end
	function mt.__index(tbl, key)
		local old = oldIndex(tbl, key)
		if old == nil then
			error(string.format("Unknown class %q", key), 2)
		else
			return old
		end
	end
	setmetatable(cc, mt)

	local classes =
	{
		-- class = {{first promo classes}, {second promo classes(l = light, d = dark, others)}, if class from MM7 then \"MM7\" = true}, MM7 flag is only used for correct light/dark/neutral path behavior
		[cc.Archer] = {{cc.WarriorMage}, {l = cc.MasterArcher, d = cc.Sniper, cc.BattleMage}, MM7 = true},
		[cc.Cleric] = {{cc.Priest}, {l = cc.PriestLight, d = cc.PriestDark, cc.HighPriest}, MM7 = true},
		[cc.Deerslayer] = {{cc.Pioneer}, {cc.Pathfinder}},
		[cc.Dragon] = {{cc.FlightLeader}, {cc.GreatWyrm}},
		[cc.Druid] = {{cc.GreatDruid}, {l = cc.ArchDruid, d = cc.Warlock, cc.MasterDruid}, MM7 = true},
		[cc.Knight] = {{cc.Cavalier}, {l = cc.Champion, d = cc.BlackKnight, cc.Templar}, MM7 = true},
		[cc.Minotaur] = {{cc.MinotaurHeadsman}, {cc.MinotaurLord}},
		[cc.Monk] = {{cc.InitiateMonk}, {l = cc.MasterMonk, d = cc.Ninja}, MM7 = true},
		[cc.Paladin] = {{cc.Crusader}, {l = cc.Hero, d = cc.Villain}, MM7 = true},
		[cc.Ranger] = {{cc.Hunter}, {l = cc.RangerLord, d = cc.BountyHunter}, MM7 = true},
		[cc.Thief] = {{cc.Rogue}, {l = cc.Spy, d = cc.Assassin, cc.Robber}, MM7 = true},
		[cc.Barbarian] = {{cc.Berserker}, {cc.Warmonger}},
		[cc.Vampire] = {{cc.ElderVampire}, {cc.Nosferatu}},
		[cc.Sorcerer] = {{cc.Wizard}, {l = cc.ArchMage, d = cc.MasterNecromancer, cc.MasterWizard}, MM7 = true},
		--[cc.] = {{cc.}, {l = cc., d = cc., cc.}},
	}
	classes[cc.Necromancer] = classes[cc.Sorcerer]

	local classChangeChart =
	{
		-- ORIGINAL
		[cc.Archer] = {cc.Paladin, cc.Monk, cc.Druid},
		[cc.Cleric] = {cc.Druid, cc.Paladin, cc.Archer},
		[cc.Druid] = {cc.Archer, cc.Monk, cc.Sorcerer},
		[cc.Knight] = {cc.Archer, cc.Ranger, cc.Druid},
		[cc.Monk] = {cc.Thief, cc.Druid, cc.Archer},
		[cc.Paladin] = {cc.Druid, cc.Ranger, cc.Archer},
		[cc.Ranger] = {cc.Archer, cc.Paladin, cc.Thief},
		[cc.Thief] = {cc.Archer, cc.Knight, cc.Monk},
		[cc.Sorcerer] = {cc.Archer, cc.Paladin, cc.Cleric},
		-- MERGE ADDITION
		[cc.Deerslayer] = {cc.Ranger, cc.Thief, cc.Sorcerer},
		[cc.Dragon] = {cc.Monk, cc.Archer, cc.Druid},
		[cc.Minotaur] = {cc.Knight, cc.Ranger, cc.Paladin},
		[cc.Barbarian] = {cc.Vampire, cc.Paladin, cc.Druid},
		[cc.Vampire] = {cc.Deerslayer, cc.Druid, cc.Knight},
		--[cc.] = {cc., cc., cc.},
	}

	local cs = const.Stats
	local classChangeStatBonuses =
	{
		-- ORIGINAL
		[cc.Archer] = {[cs.Speed] = 15, [cs.Intellect] = 5},
		[cc.Cleric] = {[cs.Personality] = 20},
		[cc.Druid] = {[cs.Intellect] = 10, [cs.Personality] = 10},
		[cc.Knight] = {[cs.Endurance] = 15, [cs.Might] = 5},
		[cc.Monk] = {[cs.Endurance] = 10, [cs.Might] = 10},
		[cc.Paladin] = {[cs.Personality] = 5, [cs.Endurance] = 10, [cs.Might] = 5},
		[cc.Ranger] = {[cs.Endurance] = 10, [cs.Might] = 10},
		[cc.Thief] = {[cs.Luck] = 20},
		[cc.Sorcerer] = {[cs.Intellect] = 20},
		-- MERGE ADDITION
		[cc.Deerslayer] = {[cs.Accuracy] = 10, [cs.Intellect] = 10},
		[cc.Dragon] = {[cs.Might] = 5, [cs.Endurance] = 15},
		[cc.Minotaur] = {[cs.Personality] = 10, [cs.Might] = 10},
		[cc.Barbarian] = {[cs.Endurance] = 20},
		[cc.Vampire] = {[cs.Speed] = 10, [cs.Accuracy] = 5, [cs.Intellect] = 5},
	}
	getmetatable(cc).__index = oldIndex

	function bdjtest()
		evt.MoveToMap{Name = "7d12.blv", X = 2753, Y = 773, Z = 193}
		function events.AfterLoadMap()
			cocall(function()
				kill()
				Sleep(500)
				for i in Map.Doors do
					evt.SetDoorState{Id = i, State = 2}
				end
				events.Remove("AfterLoadMap", 1)
			end)
		end
	end

	-- IMPORTANT
	-- normal event shouldn't be assigned (by default or through event)

	local Q = tget(vars, "bdjClassChangeQuest")
	rev4m.bdjQ = Q
	local function myQuestBranch(str)
		Q.branch = str
		QuestBranch(str, true)
	end
	local branches = {}
	function branches.chooseClass(id)
		return "BDJ_class_" .. id
	end
	function branches.newProfession(index)
		return "BDJ_choose_" .. index
	end
	function branches.welcome()
		return "BDJ_welcome"
	end
	function branches.welcome2()
		return "BDJ_welcome2"
	end
	function branches.finished_confirm()
		return "BDJ_finished_confirm"
	end
	function branches.noTopics()
		return "BDJ_done"
	end
	function branches.brazier()
		return "BDJ_brazier"
	end
	local npc = 1279 -- BDJ
	function events.EnterNPC(id)
		if id == npc then
			if not Q.branch then
				myQuestBranch(branches.welcome())
			else
				--QuestBranch(Q.branch, true)
			end
		end
	end

	function events.CanExitNPC(id)
		if id == npc then
			t.Allow = true
		end
	end

	local function nextPlayer()
		Q.currentPlayer = (Q.currentPlayer or -1) + 1
		if Q.currentPlayer > Party.High then
			myQuestBranch(branches.finished_confirm())
		else
			Q.currentClass = -1
			myQuestBranch(branches.newProfession(Q.currentPlayer))
		end
	end

	local function getClassTier(classId)
		for k, v in pairs(classes) do
			if k == classId then
				return 0
			elseif table.find(v[1], classId) then
				return 1
			elseif table.findIf(v[2], function(v) return v == classId end) then
				return 2
			end
		end
		error(string.format("Invalid class %d", classId))
	end

	local invClass = table.invert(cc)
	local function getClassEntry(classId)
		for class, promos in pairs(classes) do
			if class == classId or table.find(promos[1], classId) or table.findIf(promos[2], function(v) return v == classId end) then
				return class, promos
			end
		end
		error(string.format("Can't find base class for class %d (%q)", classId, invClass[classId]), 2)
	end
	
	local brazierAction

	function events.AfterLoadMap()
		if Map.Name == "7d12.blv" then
			-- Promotion Brazier
			Game.MapEvtLines:RemoveEvent(12)
			evt.map[12].clear()
			evt.map[12] = brazierAction
		end
	end

	function brazierAction()
		if not Q.currentClass or Q.currentClass == -1 then
			Game.ShowStatusText(evt.str[20])
			return
		end
		local destinationClass = Q.currentClass
		local pl = Party[Q.currentPlayer or 0]
		local tier = getClassTier(pl.Class)
		local baseClassId, baseClassPromos = getClassEntry(pl.Class)
		local newClassId, newClassPromos = getClassEntry(destinationClass)
		if tier == 0 then
			evt.Set("ClassIs", newClassId)
		elseif tier == 1 then
			evt.Set("ClassIs", newClassPromos[1][1])
		elseif tier == 2 then
			local finalBase, finalNew = baseClassPromos[2], newClassPromos[2]
			if baseClassPromos.MM7 then
				if newClassPromos.MM7 then
					-- MM7 to MM7 - try to convert
					if finalBase.l == pl.Class and finalNew.l then
						evt.Set("ClassIs", finalNew.l)
					elseif finalBase.d == pl.Class and finalNew.d then
						evt.Set("ClassIs", finalNew.d)
					else
						evt.Set("ClassIs", finalNew[1] or error(string.format("Class %d (%q)", pl.Class, invClass[pl.Class])))
					end
				else
					-- MM7 to not MM7 - pick first available
					evt.Set("ClassIs", finalNew[1] or error(string.format("Class %d (%q)", pl.Class, invClass[pl.Class])))
				end
			else
				-- (not MM7 to MM7) or (not MM7 to not MM7) - pick neutral (first available)
				evt.Set("ClassIs", finalNew[1] or finalNew.l or finalNew.d or error(string.format("Class %d (%q)", pl.Class, invClass[pl.Class])))
			end
		else
			error(string.format("Class %d (%q)", baseClassId, invClass[baseClassId]))
		end
		for id, add in pairs(classChangeStatBonuses[newClassId] or {}) do
			pl.Stats[id].Base = pl.Stats[id].Base + add
		end
		Game.ShowStatusText(evt.str[21])
		nextPlayer()
	end

	local function checkShow() -- check if topics should be shown, because BDJ also appears in The Vault and probably The Gauntlet
		return Map.Name == "7d12.blv"
	end

	NPCTopic
	{
		Game.NPCTopic[getGlobalEvent(48)],
		Game.NPCText[getMessage(71)],
		Slot = 0,
		Branch = branches.welcome(),
		CanShow = checkShow,
		Ungive = function()
			--debug.Message(QuestBranch())
			myQuestBranch(branches.welcome2())
			-- evt.SetNPCTopic{NPC = getNPC(456), Index = 0, Event = getGlobalEvent(49)}         -- "The Coding Wizard" : "How does this work?"
			evt.MoveNPC{NPC = getNPC(460), HouseId = getHouseID(470)}         -- "Lord Godwinson" -> "Godwinson Estate"
			evt.SetNPCTopic{NPC = getNPC(460), Index = 0, Event = getGlobalEvent(96)}         -- "Lord Godwinson" : "Coding Wizard Quest"
			evt.SetNPCGreeting{NPC = getNPC(460), Greeting = getGreeting(26)}         -- "Lord Godwinson" : "Well met, my friends!  Sit a-spell and tell me all about your recent adventures."
		end
	}

	NPCTopic
	{
		Game.NPCTopic[getGlobalEvent(49)],
		Game.NPCText[getMessage(72)],
		Slot = 0,
		Branch = branches.welcome2(),
		CanShow = checkShow,
		Ungive = nextPlayer
	}

	for i = 0, 4 do
		NPCTopic
		{
			Game.NPCTopic[getGlobalEvent(50)],
			string.format("Adventurer %d, select your new profession.", i + 1),
			Slot = 0,
			Ungive = function()
				local pl = Party[Q.currentPlayer or 0]
				local base = getClassEntry(pl.Class)
				myQuestBranch(branches.chooseClass(base))
			end,
			Branch = branches.newProfession(i),
			CanShow = checkShow,
		}
	end

	for classId, data in pairs(classChangeChart) do
		for i = 1, 3 do
			NPCTopic {
				Game.ClassNames[data[i]],
				Game.NPCText[getMessage(41)],
				Slot = i - 1,
				Branch = branches.chooseClass(classId),
				CanShow = checkShow,
				Ungive = function()
					Q.currentClass = data[i]
					myQuestBranch(branches.brazier())
				end
			}
		end
		-- "skip profession" topic
		NPCTopic {
			Game.NPCTopic[getGlobalEvent(123)],
			Game.NPCText[getMessage(267)],
			Slot = 3,
			Branch = branches.chooseClass(classId),
			CanShow = checkShow,
			Ungive = nextPlayer
		}
	end

	NPCTopic {
		-- "Let's Continue."
		Game.NPCTopic[getGlobalEvent(87)],
		-- "There ya go!  Now return this scroll to Lord Godwinson to complete this quest.  Then he’ll know that I am more than a myth."
		Game.NPCText[getMessage(87)],
		Slot = 0,
		Branch = branches.finished_confirm(),
		CanShow = checkShow,
		Ungive = function()
			myQuestBranch(branches.noTopics())
			--[[
			evt.Set("QBits", 206)         -- Harmondale - Town Portal
			evt.Set("QBits", 207)         -- Erathia - Town Portal
			evt.Set("QBits", 208)         -- Tularean Forest - Town Portal
			]]
			Q.done = true
			rev4m.restoreGauntletQBits()
			evt.SetMonGroupBit{NPCGroup = getNpcGroup(9), Bit = const.MonsterBits.Invisible, On = true}         -- "Group for Malwick's Assc."
			evt.ForPlayer("Current")
			evt.Add("Inventory", getItem(775))         -- "LG's Proof"
		end
	}
end