-- functions from scripts/global/PromotionTopics.lua

local LichAppearance = {
[const.Race.Dwarf]		= {[0] = {Portrait = 65, Voice = 26}, [1] = {Portrait = 66, Voice = 27}},
[const.Race.Dragon]		= {[0] = {Portrait = 67, Voice = 24}, [1] = {Portrait = 67, Voice = 24}},
[const.Race.Minotaur]	= {[0] = {Portrait = 69, Voice = 59}, [1] = {Portrait = 69, Voice = 59}},
default					= {[0] = {Portrait = 26, Voice = 26}, [1] = {Portrait = 27, Voice = 27}}
}

local function SetLichAppearance(i, v)
	if v.Class == const.Class.Lich then
		local Race = GetCharRace(v)

		if Merge.Settings.Conversions.PreserveRaceOnLichPromotion == 1
				and Game.Races[Race].Kind == const.RaceKind.Undead then
			if Merge.Settings.Races.MaxMaturity > 0	then
				Log(Merge.Log.Info, "Lich promotion: only improve maturity of undead kind race")
				local new_race = table.filter(Game.Races, 0,
					"BaseRace", "=", Game.Races[Race].BaseRace,
					"Family", "=", Game.Races[Race].Family,
					"Mature", "=", 1
					)[1].Id
				if new_race and new_race >= 0 then
					v.Attrs.Race = new_race
				end
			else
				Log(Merge.Log.Info, "Lich promotion: do not convert undead kind race")
			end
		elseif Merge.Settings.Conversions.PreserveRaceOnLichPromotion == 2 then
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
					"Family", "=", const.RaceFamily.Undead,
					"Mature", "=", 	Merge.Settings.Races.MaxMaturity > 0 and 1 or 0
					)[1].Id

				if new_race and new_race >= 0 then
					v.Attrs.Race = new_race
				end

				v.Face = NewFace.Portrait
				if Merge.Settings.Conversions.KeepVoiceOnRaceConversion == 1 then
					Log(Merge.Log.Info, "Lich Promotion: keep current voice")
				else
					v.Voice = NewFace.Voice
				end
				SetCharFace(i, NewFace.Portrait)
			end

			for i = 0, 3 do
				v.Resistances[i].Base = math.max(v.Resistances[i].Base, 20)
			end
			--v.Resistances[7].Base = 65000
			--v.Resistances[8].Base = 65000

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

local TXT = Localize
{
	Topic = "Lich",
	Give = [[So you have decided to seek the path of true darkness. Very well then, you've come to a good person. Unfortunately I teach only the best of students, so you will need to perform 2 tasks for me.
	
	First - you need to gather a soul jar for each sorcerer that wants to be lichified. If I recall correctly, warlocks of nighon might have some, and they foolishly hid them in the Maze, thinking we can't get to them. Well, as you'll prove to them, we can.
	
	Second - this is a personal favor for me. You need to gather 4 Shards of Mana, which are scattered around the world. I can't give you the locations - if I could, I'd go get them myself. So keep looking.]],
	Done = "So you managed to do this all? Outstanding. I thought my requirements would deter everyone, well, I was wrong.",
	Undone = "I know the tasks might seem daunting, but once you set your mind to it and start doing them one-at-a-time, it is much simpler.",
	After = "Welcome back, my best students. How are you doing with your newfound power?",
	
	Quest = "Gather soul jars and shards of mana, and return to Halfgild Wynac in the Pit.",
	Award = "Became a lich and able to learn grandmaster dark magic"
}
local DMGM_QuestNPC = 388 -- Halfgild Wynac
local ShardOfManaItemId = 980
local questID = "MM7_LichAndDarkMagicGM"
if Merge.ModSettings.Rev4ForMergeActivateExtraQuests == 1 then
	local function makeGMDarkLearnableIfQuestCompleted()
		if vars.Quests[questID] == "Done" then
			Game.Classes.Skills[const.Class.PriestLight][const.Skills.Dark] = const.GM
			--Game.Classes.Skills[const.Class.Lich][const.Skills.Dark] = const.GM
		end
	end
	Quest{
		questID,
		Gold = 15000,
		Exp = 75000,
		Slot = 0,
		Quest = true, -- gives an error if this is not present
		NPC = DMGM_QuestNPC,
		CanShow = function()
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
				if evt.Cmp("ClassIs", const.Class.ArchMage) and not evt.Cmp("Inventory", 1417) then
					sorcNoJar = true
					break
				end
				for i, item in pl.Items do
					if item == ShardOfManaItemId then
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
			
			for i, pl in Party do
				evt.ForPlayer(i)
				if evt.Cmp("ClassIs", const.Class.ArchMage) then
					evt.Set("ClassIs", const.Class.Lich)
					SetLichAppearance(i, pl)
				end
			end
			makeGMDarkLearnableIfQuestCompleted()
			evt.SetNPCGreeting{DMGM_QuestNPC, 371}
		end
	}.SetTexts(TXT)
	
	--[[evt.MoveNPC{DMGM_QuestNPC, 1073} -- Halfgild Wynac
	evt.SetNPCGreeting{DMGM_QuestNPC, 369}--]]
	
	function events.LoadMap()
		local npc = Game.NPC[DMGM_QuestNPC]
		if npc.House ~= 1073 then
			evt.MoveNPC{DMGM_QuestNPC, 1073}
		end
		if npc.Greet ~= 369 and npc.Greet ~= 370 and npc.Greet ~= 371 then
			evt.SetNPCGreeting{DMGM_QuestNPC, 369}
		elseif Party.QBits[1619]	-- Promoted to Wizard
		and evt.All.Cmp("Awards", 119)
		and npc.Greet ~= 370 and npc.Greet ~= 371 then
			evt.SetNPCGreeting{DMGM_QuestNPC, 370}
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

	-- remove dark magic grandmaster from all NPCs except our quest npc
	for i, npc in Game.NPC do
		if npc ~= DMGM_QuestNPC then
			for eid, event in npc.Events do
				if event == 362 then -- dark magic grandmaster
					npc.Events[eid] = 0
				end
			end
		end
	end
end