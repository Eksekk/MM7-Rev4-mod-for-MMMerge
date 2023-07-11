local MS, format = Merge.ModSettings, string.format
if not _G.getQuestBit then
	error("Data conversion functions are undefined")
end

if MS.Rev4ForMergeActivateExtraQuests == 1 then
	local questID = "ClearFortRiverstride"
	KillMonstersQuest {
		questID,
		{Map = "7d31.blv", Group = {56, 57, 58}},
		Gold = 4000,
		Experience = 32000,
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

if MS.Rev4ForMergeActivateExtraQuests == 1 then
	-- chests, ground items?
	-- randomized monster spells, monster bonuses
	function events.BeforeLoadMap()
		Game.MapStats[238].Tres = 7
	end
	
	local sp = sharedSpawnpoint.new("mdt09orig.blv", "WromthraxCaveQuest")
	sp.setSpawnSettings{["RandomSpawnpointOrder"] = 1, ["DivideAcrossAllSpawnpoints"] = 1}
	sp.addSpawnpoint{monster = 154, x = 18285, y = 7348, z = -127, powerChances = diffsel({70, 20, 10}, {50, 25, 25}, {30, 30, 40}), radius = 512, group = 56}
	sp.addSpawnpoint{monster = 154, x = 15760, y = 3873, z = -127, powerChances = diffsel({70, 20, 10}, {50, 25, 25}, {30, 30, 40}), radius = 512, group = 56}
	sp.addSpawnpoint{monster = 154, x = 15002, y = 6179, z = -127, powerChances = diffsel({70, 20, 10}, {50, 25, 25}, {30, 30, 40}), radius = 512, group = 56}
	sp.setMax(154, diffsel(8, 10, 12))
	sp.setTransform(154, function(mon)
		monUtils.randomBoostResists(mon)
		monUtils.randomGiveSpell(mon)
		mon.TreasureDiceCount = mon.TreasureDiceCount * 3
	end)
	
	sp.addSpawnpoint{monster = 151, x = 16058, y = 8317, z = -127, powerChances = diffsel({70, 20, 10}, {50, 25, 25}, {30, 30, 40}), radius = 512, group = 56}
	sp.addSpawnpoint{monster = 151, x = 16913, y = 4169, z = -127, powerChances = diffsel({70, 20, 10}, {50, 25, 25}, {30, 30, 40}), radius = 512, group = 56}
	sp.setMax(151, diffsel(3, 5, 7))
	sp.setTransform(151, function(mon)
		monUtils.randomBoostResists(mon)
		mon.PhysResistance = 100 -- remove immunity
		monUtils.randomGiveElementalAttack(mon)
		mon.TreasureDiceCount = mon.TreasureDiceCount * 3
	end)
	
	sp.addSpawnpoint{monster = 145, x = 13493, y = 2928, z = -127, powerChances = diffsel({70, 20, 10}, {50, 25, 25}, {30, 30, 40}), radius = 1024, group = 56}
	sp.setMax(145, diffsel(3, 4, 6))
	sp.setTransform(145, monUtils.randomBoostResists)
	
	local questID = "WromthraxCaveDisablePortalAndClear"
	local PORTAL_FACET_INDEX = 10
	local DARK_TALISMAN_ID = 981
	vars.WromthraxCaveQuest = vars.WromthraxCaveQuest or {}
	function events.AfterLoadMap() -- need to execute after binding map monsters with spawnpoints that spawned them
		if Map.Name ~= "mdt09orig.blv" then return end
		if not cmpSetMapvarBool("WromthraxCaveQuestSetup") then
			for i, v in Map.FacetData do
				if v.Id == PORTAL_FACET_INDEX then
					vars.WromthraxCaveQuest.OldBitmapIds = vars.WromthraxCaveQuest.OldBitmapIds or {}
					local f = Map.Facets[v.FacetIndex]
					vars.WromthraxCaveQuest.OldBitmapIds[v.FacetIndex] = f.BitmapId
				end
			end
			
			local WromthraxId -- could be assumed 0 because he is the only monster on the map, but just in case I'll do a loop
			for k, v in Map.Monsters do
				if v.NameId == rev4m.placeMon.wromthrax then
					WromthraxId = k
					break
				end
			end
			if WromthraxId then
				if _G.bolsterPerformed then
					_G.restoreMonster(WromthraxId)
				end
				local wrom = Map.Monsters[WromthraxId]
				XYZ(wrom, 17477, 6215, -127) -- move him deeper into the cave, where he'll be protected by his legions of monsters
				wrom.StartX, wrom.StartY, wrom.StartZ, wrom.GuardX, wrom.GuardY, wrom.GuardZ = wrom.X, wrom.Y, wrom.Z, XYZ(wrom)
				monUtils.hpMul(wrom, diffsel(1.2, 1.6, 2.1))
				wrom.Spell, wrom.SpellChance, wrom.SpellSkill = const.Spells.IceBlast, (difficulty + 1) * 10, JoinSkill((difficulty + 1) * 5, const.GM)
				wrom.Spell2, wrom.Spell2Chance, wrom.Spell2Skill = const.Spells.PowerCure, (difficulty + 1) * 15, JoinSkill((difficulty + 1) * 8, const.GM)
				monUtils.boostResistances(wrom, diffsel(10, 30, 50))
				wrom.Attack1.DamageAdd = diffsel(20, 25, 30)
				wrom.TreasureDiceCount = wrom.TreasureDiceCount * 3
				if _G.bolsterPerformed then
					_G.PrepareMapMon(wrom)
				end

				evt.SetMonsterItem{Monster = WromthraxId, Item = DARK_TALISMAN_ID, Has = true}
			else
				-- killed before enabling extra quests
				SummonItem(DARK_TALISMAN_ID, 17477, 6215, -127)
			end
			
			-- no chests, so let's just scatter a bunch of highest-lvl items
			pseudoSpawnpointItem{x = 14557, y = 5769, z = -127, count = 35, radius = 4096, level = 6}
			
			-- one-time spawnpoints
			-- knights
			local n = pseudoSpawnpoint{monster = 154, x = 9418, y = 9879, z = -127, count = diffsel("3-6", "5-9", "8-13"), powerChances = diffsel({60, 30, 10}, {50, 25, 25},  {34, 33, 33}), radius = 4096, group = 56}
			n = table.join(n, pseudoSpawnpoint{monster = 154, x = 10281, y = 2911, z = -127, count = diffsel("3-6", "5-9", "8-13"), powerChances = diffsel({60, 30, 10}, {50, 25, 25},  {34, 33, 33}), radius = 4096, group = 56})
			for i, v in ipairs(n) do
				monUtils.randomBoostResists(v)
				monUtils.randomGiveSpell(v)
				v.TreasureDiceCount = v.TreasureDiceCount * 3
				--randomGiveElementalAttack(v)
			end
			
			-- nightmares
			n = pseudoSpawnpoint{monster = 151, x = 7073, y = 3927, z = -127, count = diffsel("2-4", "4-7", "6-10"), powerChances = diffsel({60, 30, 10}, {50, 25, 25},  {34, 33, 33}), radius = 4096, group = 56}
			for i, v in ipairs(n) do
				monUtils.randomBoostResists(v)
				v.PhysResistance = 150
				monUtils.randomGiveElementalAttack(v)
				v.TreasureDiceCount = v.TreasureDiceCount * 3
			end
			
			-- "MM8 behemoths"
			n = pseudoSpawnpoint{monster = 145, x = 11704, y = 6109, z = 65, count = diffsel("2-4", "4-7", "7-11"), powerChances = diffsel({60, 30, 10}, {50, 25, 25},  {34, 33, 33}), radius = 4096, group = 56}
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
		{Map = "mdt09orig.blv", Group = 56},
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

	-- FIXME: this item in conjunction with reagents is way too powerful reward
	-- keep for another quest
	local rewardItem = 1394 -- Mog'Draxar
	local itemIDs = {982, 983, 984}
	local questID = "ClankersLabCollectPowerfulReagents"
	Quest{
		questID,
		NPC = 546, -- Elzbet Winterspoon in Nighon
		Slot = 2,
		Experience = 60000,
		Gold = 8000,
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
			-- keep for another quest
			--evt.GiveItem{Id = rewardItem}
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
		
		if not cmpSetMapvarBool("ClankersLabSetup") then
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
			monUtils.hpMul(wiz, diffsel(2.5, 3.5, 4.5))
			monUtils.boostResistances(wiz, diffsel(20, 40, 60))
			wiz.ArmorClass = wiz.ArmorClass * 2
			wiz.Attack1.DamageDiceCount = wiz.Attack1.DamageDiceCount * 2
			wiz.NameId = rev4m.placeMon.clankerWizard
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
		--[[
			test progress:
			* key spawns - working
			* no key = locked door - working
			* no quest = refuse topic - working
			* jailers not killed = cannot escape - working
			* key, quest, jailers killed = can go topic, join topic - working
			* in party = empty cell - working
			* quest done = empty cell - working

			* jailers fighting with other monsters - fixed
			* GIVE TEXT GLITCHES - fixed, need to remove all indent from lines and preferably remove newlines from begin and end
			* complete text not shown (ReloadHouse) - disabled that call and it's working well enough
		]]

		-- cell
		-- x = 12045, y = 1385, z = 1089
		-- X = 12045, Y = 1385, Z = 1089
		local cellKey = 979
		local jailerNameId = rev4m.placeMon.tulareanJailer
		local NpcToRescue = 1286
		assert(Game.NPCDataTxt[NpcToRescue].Name == "Bradley Clark")
		local questGiverHouseId = 1105
		
		local questId = "TulareanCavesRescuePrisoner"
		local QData = tget(vars, questId)

		function events.EnterNPC(id)
			if id == NpcToRescue and Map.Name == "7d08orig.blv" then
				QData.guardsKilled = evt.CheckMonstersKilled{CheckType = 4, Id = rev4m.placeMon.tulareanJailer, Count = 0}
			end
		end
		
		-- quest not taken topic
		NPCTopic{
			NPC = NpcToRescue,
			Slot = 0,
			CanShow = function()
				return not vars.Quests[questId]
			end,
			"The Rescue",
			"You clearly aren't elves, but you might still be allied with them. I don't think I can trust you.",
		}

		-- quest taken, guards alive topic
		NPCTopic{
			NPC = NpcToRescue,
			Slot = 0,
			CanShow = function()
				return vars.Quests[questId] ~= nil and vars.Quests[questId] ~= "Done" and not NPCFollowers.NPCInGroup(NpcToRescue) and not QData.guardsKilled
			end,
			"The Rescue",
			"Thank god finally someone came! We can't escape while guards are alive, we'll probably be killed in the process."
		}

		-- guards dead or in party topic
		NPCTopic{
			NPC = NpcToRescue,
			Slot = 0,
			CanShow = function()
				return vars.Quests[questId] ~= nil
					and vars.Quests[questId] ~= "Done"
					and (NPCFollowers.NPCInGroup(NpcToRescue)
						or QData.guardsKilled)
			end,
			"The Escape",
			"We can go now! Please don't waste too much time, we'll probably get some 'tail' from the elves, if you know what I mean."
		}

		-- join topic
		NPCTopic{
			NPC = NpcToRescue,
			Slot = 1,
			CanShow = function()
				return vars.Quests[questId] ~= nil
					and QData.guardsKilled
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
			Experience = 30000,
			Gold = 5000,
			--Quest = REV4_FOR_MERGE_QUEST_INDEX + 3,
			CheckDone = function()
				return NPCFollowers.NPCInGroup(NpcToRescue)
			end,
			Done = function(t)
				NPCFollowers.Remove(NpcToRescue)
				evt.MoveNPC{NPC = NpcToRescue, HouseId = questGiverHouseId}
				--ReloadHouse() -- doesn't show "Done" text
				--Message(t.Texts.Done)
			end,
			Texts = {
				Topic = "Quest",
				TopicDone = false,
				Give = [[I'm glad you've come here. I need your help desperately. See, my best friend Bradley Clark is also a very important person (one of human ambassadors who have dealt with elves). That's not as fortunate as it might seem, because elves have kidnapped and imprisoned him! I've fallen into deep sorrow. My best friend is no longer here with me, and what's worse, he suffers or maybe even is tortured for information!
				
I've had a spy hired to investigate this kidnapping, and he reported my friend is probably kept in Tularean Caves in the forest. There's a connection with the caves from Elvish castle, but the route was blocked. We have theorized that maybe you need to arrive from the other side. Whatever, you shouldn't take this route anyways. You'll have entire legion of elves mad at you.

The rescue won't be easy. You can't escape with him until the route is mostly safe, and I'm almost sure you'll need to find a key first (they probably don't keep prisoners unlocked). Can you do it? You'll be greatly rewarded for your services.]],
				Undone = "What went wrong? Were guards too sturdy or you couldn't find the key? I'm sure it is in the caverns, you'll find it eventually.",
				Done = [[My god, you actually did it? My friend owes you his life, and you have lifetime of my gratitude. Was the escape mission difficult? [Bradley Clark tells Matric about your epic encounter with guards]. Hah, so not only you managed it, you also did it in such amazing style?
				
Not only did you help me and my friend, but also dealt very heavy blow to the elves. I hope you will enjoy your reward.]],
				
				Quest = "Rescue Bradley Clark from Tularean Caverns and return to Matric Bowes in Harmondale.",
				Award = "Rescued Bradley Clark"
			}
		}

		function events.LoadMap()
			if Map.Name ~= "7d08orig.blv" then return end
			replaceMapEvent(376, function()
				if not evt.All.Cmp("Inventory", cellKey) then
					Game.ShowStatusText("It's locked.")
					return
				elseif NPCFollowers.NPCInGroup(NpcToRescue) or vars.Quests[questId] == "Done" then
					Game.ShowStatusText("It's empty.")
					return
				end
				evt.SpeakNPC{NPC = NpcToRescue}
			end, nil, "Cell Door")
			if not cmpSetMapvarBool("questSetup") then
				-- spawn item near castle navan door
				pseudoSpawnpointItem{item = cellKey, x = -5622, y = -10314, z = 768, count = 1}

				-- elven warrior guards
				pseudoSpawnpoint{monster = 250, x = -4849, y = -9421, z = 703, powerChances = {20, 20, 60}, count = 6, transform = function(mon)
					monUtils.hpMul(mon, 2)
					monUtils.rewards(mon, 8, nil, 4)
				end}

				-- guards near npc cell
				-- elven warriors
				local guards = {}
				local function warrior(lev)
					return function(mon)
						table.insert(guards, mon:GetIndex())
						mon.NameId = jailerNameId
						monUtils.hpMul(mon, lev)
						monUtils.rewards(mon, 3 + lev * 2, -4, lev)
						mon.Attack1.DamageAdd = mon.Attack1.DamageAdd + lev * 3
					end
				end
				-- pillar room
				pseudoSpawnpoint{monster = 250, x = 9084, y = 7435, z = -29, count = 4, powerChances = {33, 33, 34}, transform = warrior(3), group = 51}
				pseudoSpawnpoint{monster = 250, x = 7947, y = 6682, z = -68, count = 4, powerChances = {33, 33, 34}, transform = warrior(3), group = 51}

				-- cell slope
				pseudoSpawnpoint{monster = 250, x = 12228, y = 4095, z = 622, count = 2, powerChances = {0, 0, 100}, transform = warrior(2), group = 51}
				pseudoSpawnpoint{monster = 250, x = 11791, y = 3998, z = 622, count = 2, powerChances = {0, 0, 100}, transform = warrior(2), group = 51}

				-- archers
				local function archer(lev)
					return function(mon)
						table.insert(guards, mon:GetIndex())
						mon.NameId = jailerNameId
						monUtils.hpMul(mon, lev)
						monUtils.rewards(mon, lev * 2, -4, lev)
						mon.Attack1.DamageDiceSides = math.round(mon.Attack1.DamageDiceSides * (1 + 0.1 * lev))
					end
				end
				-- cell slope
				pseudoSpawnpoint{monster = 247, x = 11441, y = 5474, z = 315, count = "2-3", powerChances = {40, 40, 20}, transform = archer(3), group = 51}
				pseudoSpawnpoint{monster = 247, x = 12171, y = 2951, z = 795, count = "2-3", powerChances = {20, 50, 30}, transform = archer(2), group = 51}
				
				mapvars.aliveGuards = guards
				evt.SetMonGroupBit(51, const.MonsterBits.Hostile, true)

				-- wyverns guarding switch
				local function wyvern(mon)
					monUtils.hpMul(mon, 3)
					monUtils.spells(mon, const.Spells.PoisonSpray, JoinSkill(10, const.GM), 40)
					monUtils.resists(mon, 35)
					monUtils.rewards(mon, 4, -4, 5)
				end

				pseudoSpawnpoint{monster = 121, x = -6542, y = 10041, z = 648, count = 1, powerChances = {0, 100, 0}, transform = wyvern}
				pseudoSpawnpoint{monster = 121, x = -8033, y = 10290, z = 638, count = 1, powerChances = {0, 100, 0}, transform = wyvern}
				evt.SetMonGroupBit(255, const.MonsterBits.Hostile, true)
			end
		end
	end

	-- GM dark magic quest
	do
		local DMGM_QuestNPC = 388 -- Halfgild Wynac
		local ShardOfManaItemId = 980
		local questID = "MM7_LichAndDarkMagicGM"
		local function makeGMDarkLearnableIfQuestCompleted()
			if vars.Quests[questID] == "Done" then
				Game.Classes.Skills[const.Class.PriestLight][const.Skills.Dark] = const.GM
				--Game.Classes.Skills[const.Class.Lich][const.Skills.Dark] = const.GM
			else
				Game.Classes.Skills[const.Class.PriestLight][const.Skills.Dark] = 0
			end
		end

		local MF = Merge.Functions
		local MT = Merge.Tables
		local MM = Merge.ModSettings
		-- maybe required for revamp promotion system?
		if not table.find(MT.ClassPromotionsInv[const.Class.MasterNecromancer], const.Class.ArchMage) then
			table.insert(MT.ClassPromotionsInv[const.Class.MasterNecromancer], const.Class.ArchMage)
		end
		if not table.find(tget(MT.ClassPromotions, const.Class.ArchMage), const.Class.MasterNecromancer) then
			table.insert(MT.ClassPromotions[const.Class.ArchMage], const.Class.MasterNecromancer)
		end

		-- TODO: allow class change also for master wizards etc.
		Quest{
			questID,
			Gold = 12000,
			Exp = 80000,
			Slot = 0,
			NPC = DMGM_QuestNPC,
			CheckGive = function()
				return (Party.QBits[1621]	-- Promoted to Archmage
						or Party.QBits[1622])	-- Promoted to Honorary Archmage
					and evt[0].Cmp("Awards", 119)         -- "Declared Heroes of Erathia"
			end,
			CheckDone = function()
				local count = 0
				local meetRequirements = true
				for i, pl in Party do
					if (pl.Class == const.Class.ArchMage and not evt[i].Cmp("Inventory", 1417)) then
						meetRequirements = false
						break
					end
					for i, item in pl.Items do
						if item.Number == ShardOfManaItemId then
							count = count + 1
						end
					end
				end
				return meetRequirements and count >= 4
			end,

			Done = function()
				for i = 1, 4 do
					evt.Subtract("Inventory", ShardOfManaItemId)
				end
				Game.NPC[DMGM_QuestNPC].EventB = 362 -- dark magic grandmaster
				
				Party.QBits[1623] = true		-- Promoted to Lich
				Party.QBits[1624] = true		-- Promoted to Honorary Lich

				--[[
					Adapted code from General/PromotionTopics.lua and Structs/18_MergeFunctions.lua

					Changes from default code:
					* skipped code which reduced skills (refunding skillpoints) and unlearned spells
					* skipped some race stuff
					* removed message, experience reward etc. - I handle this myself

					This and other promo quests will get redone properly in the future (for example, allowing to
					promote independently of completing quest like in other Merge promos)
				]]

				local function doMaturity(player)
					local from_maturity = player.Attrs.Maturity or 0
					local maturity = 2
					if MM.Races and MM.Races.MaxMaturity then
						if MM.Races.MaxMaturity == 1 then
							if maturity == 1 then
								maturity = from_maturity
							elseif maturity > 1 then
								maturity = 1
							end
						elseif maturity > MM.Races.MaxMaturity then
							maturity = MM.Races.MaxMaturity
						end
					end
					player.Attrs.Maturity = maturity
				end
				
				for k, pl in Party do
					evt[k].Subtract("Inventory", 1417)
					local class = const.Class.MasterNecromancer
					local player = Party[k]
					evt.ForPlayer(k)
					local award = rev4m.lich.CPA[rev4m.lich.promo_award_cont[7] .. "PowerLich"]
					local new_race = rev4m.lich.can_convert_to_undead(player)
					if new_race == 0 then
						player.Attrs.PromoAwards[award] = true
						doMaturity(player)
						player.Class = class
					elseif new_race > 0 then
						local orig_race = player.Attrs.Race
						if player.Class ~= const.Class.ArchMage then
							goto noPromo
						end
						player.Attrs.PromoAwards[award] = true
						doMaturity(player)
						player.Class = class
						player.Attrs.Race = new_race

						rev4m.lich.SetLichAppearance(k, player, orig_race)
						-- Consider not to increase overbuffed lich resistances
						for j = 0, 3 do
							player.Resistances[j].Base = math.max(player.Resistances[j].Base, 20)
						end
					end
					::noPromo::
				end
				makeGMDarkLearnableIfQuestCompleted()
			end,
			Texts =
			{
				Topic = "Lich",
				TopicDone = false,
				Give = [[So you have decided to seek the path of true darkness. Very well then, you've come to a good teacher. Unfortunately I teach only the best of students, so you will first need to show your worth.
				
For the starters, you'll of course need to gather a soul jar for each sorcerer that wants to be lichified. If I recall correctly, warlocks of nighon might have some, and they foolishly hid them in the Maze, thinking we can't get to them. Well, as you'll prove to them, we can.
				
The second task is a personal favor for me. I need to prepare a spell far exceeding my capabilities, and a way to increase these capabilities is with Shards of Mana, which are scattered around the world. I'll need at least 4 of them. I can't give you the locations - if I could, I'd go get them myself. So keep looking.]],
				Done = "So you managed to do this all? Outstanding. I thought my requirements would deter everyone, well, I was wrong. You can now learn grandmaster dark magic from me (priests of the light can do it too!), and all sorcerers are now liches.",
				Undone = "I know the tasks might seem daunting, but once you set your mind to it they are possible. Also remember, each sorcerer (ArchMage) must have a jar in his inventory.",
				
				FirstGreet = "I can sense you have a lot of magical potential. I can instruct you, but first you need to learn much more, be more prepared, and need to do a favor for me.",
				Greet = "Welcome. How are you doing?",
				GreetGiven = "Have you done what I requested?",
				GreetDone = "Welcome back, my best students. How are you doing with your newfound power?",
				
				Ungive = "You are not ready yet. Make sure you've gone as far your path as you can.",
				
				After = "Welcome back, my best students. How are you doing with your newfound power?",
				
				Quest = "Gather soul jars and 4 shards of mana, and return to Halfgild Wynac in the Pit.",
				Award = "Became a lich and able to learn grandmaster dark magic"
			}
		}
		
		function events.LoadMap()
			local npc = Game.NPC[DMGM_QuestNPC]
			if npc.House ~= 1073 then
				evt.MoveNPC{DMGM_QuestNPC, 1073}
			end
			
			if vars.Quests[questID] == "Done" and Game.NPC[DMGM_QuestNPC].EventB ~= 362 then
				Game.NPC[DMGM_QuestNPC].EventB = 362 -- gm dark magic
			end
			
			makeGMDarkLearnableIfQuestCompleted()
			
			local function placeShardOfMana(chestID)
				if not cmpSetMapvarBool("PlacedShardOfMana") then
					addChestItem(chestID, ShardOfManaItemId)
				end
			end
			
			if Map.Name == "out10.odm" then -- nighon
				placeShardOfMana(5)
			elseif Map.Name == "out11.odm" then -- barrow downs
				placeShardOfMana(3)
			elseif Map.Name == "7d31.blv" then -- fort riverstride
				placeShardOfMana(18)
			elseif Map.Name == "7d22.blv" then -- hall under the hill
				placeShardOfMana(2)
			elseif Map.Name == "d02.blv" and (not mapvars.PlacedJars or mapvars.PlacedJars < 5) then -- the maze
				mapvars.PlacedJars = mapvars.PlacedJars or 0
				assert(addChestItem(5, 1417, 5 - mapvars.PlacedJars)) -- jar
				mapvars.PlacedJars = 5
			end
		end

		--[[-- remove dark magic learning from dark guilds
		function events.DrawLearnTopics(t)
			if t.HouseType == const.HouseType["Dark Guild"] then
				t.Handled = true
				t.NewTopics[1] = const.LearnTopics.Meditation
			end
		end--]]

		--[[-- remove dark magic grandmaster from all NPCs except our quest npc
		for i, npc in Game.NPC do
			if npc ~= DMGM_QuestNPC then
				for eid, event in npc.Events do
					if event == 362 then -- dark magic grandmaster
						npc.Events[eid] = 0
					end
				end
			end
		end]]
	end
end

-- RESTORE TRUMPET QUEST



-- BDJ change class quest

-- each different class has own topic
-- current player index in variables
-- enter npc: set quest branch
-- save quest branch in vars when switching
do
	function bdjtest()
		evt.MoveToMap{Name = "7d12.blv", X = 2753, Y = 773, Z = 193}
		function events.AfterLoadMap()
			events.Remove("AfterLoadMap", 1)
			cocall(function() -- doing this in coroutine allows using "Sleep()"
				kill()
				Sleep(50)
				for i in Map.Doors do
					evt.SetDoorState{Id = i, State = 2}
				end
			end)
		end
	end
	
	function debugClasses(a, b, c, d, e)
		local t = {a, b, c, d, e}
		for i, classStr in ipairs(t) do
			Party[i - 1].Class = assert(const.Class[classStr], string.format("Invalid class string %q", classStr))
		end
	end

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
		-- (class or {(l = light, d = dark, others)}) = {{first promo classes(l = light, d = dark, others)}, {second promo classes(l = light, d = dark, others)}, if class from MM7 then \"MM7\" = true}, MM7 flag is only used for correct light/dark/neutral path behavior
		[cc.Archer] = {{cc.WarriorMage}, {l = cc.MasterArcher, d = cc.Sniper, cc.BattleMage}, MM7 = true},
		[{l = cc.AcolyteLight, d = AcolyteDark, cc.Cleric}] = {{l = cc.ClericLight, d = cc.ClericDark, cc.Priest}, {l = cc.PriestLight, d = cc.PriestDark, cc.HighPriest}, MM7 = true},
		[cc.Deerslayer] = {{cc.Pioneer}, {cc.Pathfinder}},
		[cc.Dragon] = {{cc.FlightLeader}, {cc.GreatWyrm}},
		[cc.Druid] = {{cc.GreatDruid}, {l = cc.ArchDruid, d = cc.Warlock, cc.MasterDruid}, MM7 = true},
		[cc.Knight] = {{cc.Cavalier}, {l = cc.Templar, d = cc.BlackKnight, cc.Champion}, MM7 = true},
		[cc.Minotaur] = {{cc.MinotaurHeadsman}, {cc.MinotaurLord}},
		[cc.Monk] = {{cc.InitiateMonk}, {l = cc.MasterMonk, d = cc.Ninja}, MM7 = true},
		[cc.Paladin] = {{cc.Crusader}, {l = cc.Hero, d = cc.Villain, cc.Justiciar}, MM7 = true},
		[cc.Ranger] = {{cc.Hunter}, {l = cc.RangerLord, d = cc.BountyHunter}, MM7 = true},
		[cc.Thief] = {{cc.Rogue}, {l = cc.Spy, d = cc.Assassin, cc.Robber}, MM7 = true},
		[cc.Barbarian] = {{cc.Berserker}, {cc.Warmonger}},
		[cc.Vampire] = {{cc.ElderVampire}, {cc.Nosferatu}},
		[{l = cc.ApprenticeMage, d = cc.DarkAdept, cc.Sorcerer}] = {{l = cc.Mage, d = cc.Necromancer, cc.Wizard}, {l = cc.ArchMage, d = cc.MasterNecromancer, cc.MasterWizard}, MM7 = true},
		--[cc.] = {{cc.}, {l = cc., d = cc., cc.}},
	}

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
		[cc.Vampire] = {[cs.Speed] = 10, [cs.Accuracy] = 5, [cs.Personality] = 5},
	}
	getmetatable(cc).__index = oldIndex

	local invClass = table.invert(cc)
	local function getClassEntry(classId)
		local findClass = function(v) return v == classId end
		for class, promos in pairs(classes) do
			if (type(class) == "table" and table.findIf(class, findClass) or (type(class) == "number" and class == classId)) then
				return class, promos, 0
			elseif table.findIf(promos[1], findClass) then
				return class, promos, 1
			elseif table.findIf(promos[2], findClass) then
				return class, promos, 2
			end
		end
		error(string.format("Can't find base class for class %d (%q)", classId, invClass[classId]), 2)
	end

	-- find base class used in class change chart
	function findBaseClassInChart(class)
		if type(class) == "table" then
			local _
			_, class = next(class)
		end
		local base = getClassEntry(class)
		if type(base) == "table" then
			local base2 = base[table.findIf(base, function(v, k) return classChangeChart[v] end)]
			base = base2
		end
		return base
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

	-- IMPORTANT
	-- normal event shouldn't be assigned (by default or through event)

	local Q = tget(vars, "bdjClassChangeQuest")
	rev4m.bdjQ = Q
	local function myQuestBranch(str)
		Q.branch = str
		QuestBranch(str, true)
	end
	local bdjNpcId = 1279 -- BDJ
	QuestNPC = bdjNpcId
	local nextPlayer
	function events.EnterNPC(id)
		if id == bdjNpcId and Map.Name == "7d12.blv" then -- shouldn't hurt, but just in case start only inside Coding Fortress
			if not Q.branch then
				myQuestBranch(branches.welcome())
			elseif Q.nextPlayer then
				nextPlayer()
				Q.nextPlayer = nil
			end
		end
	end

	function events.CanExitNPC(id)
		if id == bdjNpcId then
			t.Allow = true
		end
	end

	function nextPlayer() -- call only from NPC dialog - uses GetCurrentNPC() which is nil when not in NPC dialog
		Q.currentPlayer = (Q.currentPlayer or -1) + 1
		if Q.currentPlayer > Party.High then
			myQuestBranch(branches.finished_confirm())
		else
			myQuestBranch(branches.newProfession(Q.currentPlayer))
			Q.currentClass = -1
		end
	end
	
	local brazierAction

	function events.AfterLoadMap()
		if Map.Name == "7d12.blv" then
			-- Promotion Brazier
			replaceMapEvent(12, brazierAction)
		end
	end

	function brazierAction()
		if not Q.currentClass or Q.currentClass == -1 then
			Game.ShowStatusText(evt.str[20])
			return
		end
		local destinationClass = Q.currentClass
		local index = Q.currentPlayer or 0
		local pl = Party[index]
		local baseClass, baseClassPromos, baseClassTier = getClassEntry(pl.Class)
		local newClass, newClassPromos = getClassEntry(destinationClass)
		local baseMM7, newMM7 = baseClassPromos.MM7, newClassPromos.MM7

		local function doClassChange(baseClassPromos, newClassPromos)
			-- table wrap if single class (number)
			if type(baseClassPromos) == "number" then
				baseClassPromos = {baseClassPromos}
			end
			if type(newClassPromos) == "number" then
				newClassPromos = {newClassPromos}
			end
			local errorMsg = string.format("Couldn't find appropriate class to change into for class %d (%q)", pl.Class, invClass[pl.Class])
			if baseMM7 then
				if newMM7 then
					-- MM7 to MM7 - try to convert according to path
					if baseClassPromos.l == pl.Class and newClassPromos.l then
						evt.Set("ClassIs", newClassPromos.l)
					elseif baseClassPromos.d == pl.Class and newClassPromos.d then
						evt.Set("ClassIs", newClassPromos.d)
					else
						evt.Set("ClassIs", newClassPromos[1] or error(errorMsg, 2))
					end
				else
					-- MM7 to not MM7 - pick first available, preferring neutral
					evt.Set("ClassIs", newClassPromos[1] or newClassPromos.l or newClassPromos.d or error(errorMsg, 2))
				end
			else
				-- (not MM7 to MM7) or (not MM7 to not MM7) - pick first available, preferring neutral
				evt.Set("ClassIs", newClassPromos[1] or newClassPromos.l or newClassPromos.d or error(errorMsg, 2))
			end
		end

		evt.ForPlayer(index) -- set evt.Player to act on correct one

		if baseClassTier == 0 then
			doClassChange(baseClass, newClass)
		elseif baseClassTier == 1 then
			doClassChange(baseClassPromos[1], newClassPromos[1])
		elseif baseClassTier == 2 then
			doClassChange(baseClassPromos[2], newClassPromos[2])
		else
			error(string.format("Couldn't find class tier for class %d (%q)", pl.Class, invClass[pl.Class]))
		end

		-- stat bonuses for class
		-- for now every class should have bonus
		local cls = assert(findBaseClassInChart(newClass), dump(newClass))
		local err = string.format("Couldn't find stat bonuses for class %d (%q)", cls, invClass[cls])
		for id, add in pairs(assert(classChangeStatBonuses[cls], err)) do
			pl.Stats[id].Base = pl.Stats[id].Base + add
		end
		Game.ShowStatusText(evt.str[21])
		-- nextPlayer()
		Q.nextPlayer = true
		Q.currentClass = -1
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
				myQuestBranch(branches.chooseClass(findBaseClassInChart(pl.Class)))
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