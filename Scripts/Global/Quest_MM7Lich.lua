-- functions from scripts/global/PromotionTopics.lua

do return end

local MF, MM, MS, MT = Merge.Functions, Merge.ModSettings, Merge.Settings, Merge.Tables
local CPA = const.PromoAwards
local max, min = math.max, math.min
local strformat, strlower = string.format, string.lower

local LichAppearance = {
[const.Race.Dwarf]		= {[0] = {Portrait = 65, Voice = 26}, [1] = {Portrait = 66, Voice = 27}},
[const.Race.Dragon]		= {[0] = {Portrait = 67, Voice = 28}, [1] = {Portrait = 67, Voice = 28}},
[const.Race.Minotaur]	= {[0] = {Portrait = 69, Voice = 67}, [1] = {Portrait = 69, Voice = 67}},
[const.Race.Troll]	= {[0] = {Portrait = 75, Voice = 72}, [1] = {Portrait = 75, Voice = 72}},
default					= {[0] = {Portrait = 26, Voice = 26}, [1] = {Portrait = 27, Voice = 27}}
}

local function SetLichAppearance(i, v)
	local player = v
	if v.Class == const.Class.MasterNecromancer then
		local Race = GetCharRace(v)

		if MS.Conversions.PreserveRaceOnLichPromotion == 1
				and Game.Races[Race].Kind == const.RaceKind.Undead then
			if MS.Races.MaxMaturity > 0 then
				Log(Merge.Log.Info, "Lich promotion: only improve maturity of undead kind race")
				local maturity = player.Attrs.Maturity or 0
				-- FIXME
				player.Attrs.Maturity = min(2, MS.Races.MaxMaturity)
			else
				Log(Merge.Log.Info, "Lich promotion: do not convert undead kind race")
			end
		elseif MS.Conversions.PreserveRaceOnLichPromotion == 2 then
			Log(Merge.Log.Info, "Lich promotion: keep current race")
		else
			Log(Merge.Log.Info, "Lich promotion: convert race")
			local CurPortrait = Game.CharacterPortraits[v.Face]
			local CurSex = CurPortrait.DefSex

			if Game.Races[Race].Family ~= const.RaceFamily.Undead
					and Game.Races[Race].Family ~= const.RaceFamily.Ghost then
				local NewFace = LichAppearance[Game.Races[Race].BaseRace]
						or LichAppearance.default
				NewFace = NewFace[CurSex]

				local new_race

				new_race = table.filter(Game.Races, 0,
					"BaseRace", "=", Game.Races[Race].BaseRace,
					"Family", "=", const.RaceFamily.Undead
					)[1].Id

				if new_race and new_race >= 0 then
					player.Attrs.Race = new_race
					if MS.Races.MaxMaturity > 0 then
						-- FIXME
						player.Attrs.Maturity = min(2, MS.Races.MaxMaturity)
					end
				end

				player.Face = NewFace.Portrait
				if MS.Conversions.KeepVoiceOnRaceConversion == 1 then
					Log(Merge.Log.Info, "Lich Promotion: keep current voice")
				else
					v.Voice = NewFace.Voice
				end
				SetCharFace(i, NewFace.Portrait)
			end

			-- Consider not to increase overbuffed lich resistances
			for j = 0, 3 do
				v.Resistances[j].Base = max(v.Resistances[j].Base, 20)
			end

			local RepSkill = SplitSkill(v.Skills[26])
			if RepSkill > 0 then
				local CR = 0
				for i = 1, RepSkill do
					CR = CR + i
				end
				v.SkillPoints = v.SkillPoints + CR - 1
				v.Skills[26] = 0
			end
		end
	end
end

-- end of functions from scripts/global/PromotionTopics.lua

local DMGM_QuestNPC = 388 -- Halfgild Wynac
local ShardOfManaItemId = 980
local questID = "MM7_LichAndDarkMagicGM"
if Merge.ModSettings.Rev4ForMergeActivateExtraQuests == 1 then
	local function makeGMDarkLearnableIfQuestCompleted()
		if vars.Quests[questID] == "Done" then
			Game.Classes.Skills[const.Class.PriestLight][const.Skills.Dark] = const.GM
			--Game.Classes.Skills[const.Class.Lich][const.Skills.Dark] = const.GM
		else
			Game.Classes.Skills[const.Class.PriestLight][const.Skills.Dark] = 0
		end
	end
	Quest{
		questID,
		Gold = 25000,
		Exp = 125000,
		Slot = 0,
		NPC = DMGM_QuestNPC,
		CheckGive = function()
			--[[for _, pl in Party do
				local s, m = SplitSkill(pl.Skills[const.Skills.Dark])
				if m >= const.Master then
					return true
				end
			end
			return false--]]
			return Party.QBits[1619]	-- Promoted to Wizard
			and evt[0].Cmp("Awards", 119)         -- "Declared Heroes of Erathia"
		end,
		CheckDone = function()
			local count = 0
			local sorcNoJar = false
			for i, pl in Party do
				evt.ForPlayer(i)
				if pl.Class == const.Class.ArchMage and not evt.Cmp("Inventory", 1417) then
					sorcNoJar = true
					break
				end
				for i, item in pl.Items do
					if item.Number == ShardOfManaItemId then
						count = count + 1
					end
				end
			end
			return not sorcNoJar and count >= 4
		end,
		Done = function()
			for i = 1, 4 do
				evt.Subtract("Inventory", ShardOfManaItemId)
			end
			Game.NPC[DMGM_QuestNPC].EventB = 362 -- dark magic grandmaster
			
			Party.QBits[1623] = true		-- Promoted to Lich
			Party.QBits[1624] = true		-- Promoted to Honorary Lich
			for i, pl in Party do
				evt.ForPlayer(i)
				if pl.Class == const.Class.ArchMage then
					pl.Class = const.Class.MasterNecromancer
					SetLichAppearance(i, pl)
					evt.Subtract("Inventory", 1417)
				end
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
			
			Ungive = "You are not ready yet.",
			
			After = "Welcome back, my best students. How are you doing with your newfound power?",
			
			Quest = "Gather soul jars and 4 shards of mana, and return to Halfgild Wynac in the Pit.",
			Award = "Became a lich and able to learn grandmaster dark magic"
		}
	}
	
	--[[evt.MoveNPC{DMGM_QuestNPC, 1073} -- Halfgild Wynac
	evt.SetNPCGreeting{DMGM_QuestNPC, 369}--]]
	
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
			for i, item in Map.Chests[chestID].Items do
				if item.Number == 0 then
					item.Number = ShardOfManaItemId
					mapvars.PlacedShardOfMana = true
					break
				end
			end
		end
			
		if Map.Name == "out10.odm" and not mapvars.PlacedShardOfMana then -- nighon
			placeShardOfMana(5)
		elseif Map.Name == "out11.odm" and not mapvars.PlacedShardOfMana then -- barrow downs
			placeShardOfMana(3)
		elseif Map.Name == "7d31.blv" and not mapvars.PlacedShardOfMana then -- fort riverstride
			placeShardOfMana(18)
		elseif Map.Name == "7d22.blv" and not mapvars.PlacedShardOfMana then -- hall under the hill
			placeShardOfMana(2)
		elseif Map.Name == "d02.blv" and (not mapvars.PlacedJars or mapvars.PlacedJars < 5) then -- the maze
			mapvars.PlacedJars = mapvars.PlacedJars or 0
			for i, item in Map.Chests[5].Items do
				if item.Number == 0 then
					item.Number = 1417
					mapvars.PlacedJars = mapvars.PlacedJars + 1
					if mapvars.PlacedJars >= 5 then
						break
					end
				end
			end
		end
		--elseif
		
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