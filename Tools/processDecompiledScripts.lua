rev4m = rev4m or {}
function rev4m.mapScripts()
	local replacements = table.copy(rev4m.scriptReplacements)

	--[[ TODO
	* out01.lua - house226?
	

	https://discord.com/channels/296507109997019137/795807513924075540/885284417893957633
	--]]

	local patches =
	{
		
	}

	local patchesAfter =
	{
		-- different table because I failed and edited a processed script
		-- The Gauntlet
		-- fix evt.SpeakNPC
		["d08.lua"] = 
		{
			[[evt.SpeakNPC(355)         -- "BDJ the Coding Wizard"
			evt.Set("QBits", 863)         -- Three Use
			evt.Subtract("NPCs", 357)         -- "Lord Godwinson"
			Game.NPC[357].Events[1] = 1172         -- "Lord Godwinson" : "Now that's what I call 'fun'!"
			evt.SetMonGroupBit{NPCGroup = 58, Bit = const.MonsterBits.Hostile, On = false}         -- "Group fo M2"
			evt.Subtract("QBits", 868)         -- 0]],
			[[evt.Set("QBits", 863)         -- Three Use
			evt.Subtract("NPCs", 357)         -- "Lord Godwinson"
			Game.NPC[357].Events[1] = 1172         -- "Lord Godwinson" : "Now that's what I call 'fun'!"
			evt.SetMonGroupBit{NPCGroup = 58, Bit = const.MonsterBits.Hostile, On = false}         -- "Group fo M2"
			evt.Subtract("QBits", 868)         -- 0
			evt.SpeakNPC(355)         -- "BDJ the Coding Wizard"]],
			
			[[evt.Subtract("Inventory", 1134)         -- "Lloyd's Beacon"
		if evt.Cmp("Inventory", 1134) then         -- "Lloyd's Beacon"
			goto _5
		end]],
		[[for _, scroll in ipairs({332, 1134, 1834}) do
			while evt.Cmp("Inventory", scroll) do
				evt.Subtract("Inventory", scroll)
			end
		end]],
		-- fix bug in BDJ's code
		[[evt.ForPlayer(Party.High)
		if evt.Cmp("FireSkill", 1) then
			evt.Set("SP", 0)
			evt.SetMonGroupBit{NPCGroup = 66, Bit = const.MonsterBits.Hostile, On = true}         -- "Group walkers in the Tularean forest"
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 8, X = -668, Y = 6965, Z = -384, -- ERROR: Not found
	NPCGroup = 563, unk = 0}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 5, X = -4721, Y = -10652, Z = 833, -- ERROR: Not found
	NPCGroup = 563, unk = 0}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 5, X = -5159, Y = -10152, Z = 833, -- ERROR: Not found
	NPCGroup = 563, unk = 0}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = -4934, Y = -6884, Z = 833, -- ERROR: Not found
	NPCGroup = 563, unk = 0}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 5, X = -4268, Y = -3983, Z = 833, -- ERROR: Not found
	NPCGroup = 563, unk = 0}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 5, X = -5525, Y = -5947, Z = 833, -- ERROR: Not found
	NPCGroup = 563, unk = 0}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = -4606, Y = -1643, Z = 833, -- ERROR: Not found
	NPCGroup = 563, unk = 0}
			evt.Subtract("QBits", 878)         -- 0
		end]],
		[[evt.SetMonGroupBit{NPCGroup = 66, Bit = const.MonsterBits.Hostile, On = true}         -- "Group walkers in the Tularean forest"
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 8, X = -668, Y = 6965, Z = -384, -- ERROR: Not found
	NPCGroup = 563, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 5, X = -4721, Y = -10652, Z = 833, -- ERROR: Not found
	NPCGroup = 563, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 5, X = -5159, Y = -10152, Z = 833, -- ERROR: Not found
	NPCGroup = 563, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = -4934, Y = -6884, Z = 833, -- ERROR: Not found
	NPCGroup = 563, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 5, X = -4268, Y = -3983, Z = 833, -- ERROR: Not found
	NPCGroup = 563, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 5, X = -5525, Y = -5947, Z = 833, -- ERROR: Not found
	NPCGroup = 563, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = -4606, Y = -1643, Z = 833, -- ERROR: Not found
	NPCGroup = 563, unk = 0}
		evt.Subtract("QBits", 878)         -- 0]]
		},
		-- Titan's Stronghold
		-- correct dispel magic on map load (asshole mechanic, but let's preserve it)
		["d09.lua"] =
		{
		[[evt.CastSpell{Spell = 80, Mastery = const.GM, Skill = 21, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Dispel Magic"]],
		[[-- doesn't work -- evt.CastSpell{Spell = 80, Mastery = const.GM, Skill = 21, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Dispel Magic"
		-- dispel magic
		for i, pl in Party do
			for buffid, buff in pl.SpellBuffs do
				mem.call(0x455E3C, 1, Party[i].SpellBuffs[buffid]["?ptr"])
			end
		end
		for i, buff in Party.SpellBuffs do
			mem.call(0x455E3C, 1, Party.SpellBuffs[i]["?ptr"])
		end]]
		},
		-- Zokarr's Tomb
		-- fix barrow IV enter coordinates
		["d13.lua"] = {[[evt.MoveToMap{X = -426, Y = 281, Z = -15, Direction = 1664, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "MDT02.blv"}]],
		[[evt.MoveToMap{X = -21, Y = -2122, Z = 0, Direction = 1408, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "MDT02.blv"}]]},
		-- Wine Cellar
		-- require actually killing the vampire
		["d16.lua"] = {[[evt.map[501] = function()
		evt.Set("QBits", 619)         -- Slayed the vampire]], [[evt.map[501] = function()]]},
		-- Hall Under the Hill
		-- fix one tree setSprite
		["d22.lua"] = {"evt.SetSprite{SpriteId = 56, Visible = 1, Name = \"tree\"}", "evt.SetSprite{SpriteId = 56, Visible = 1, Name = \"tree37\"}"
		},
		-- Lincoln
		-- delegate exit event to Merge script
		-- btw in following patch evt.Cmp should have item number updated, but since Merge handles that event differently and I patch the only check of this VarNum, I'm ignoring it
		["d23.lua"] = {[[

	evt.hint[501] = evt.str[2]  -- "Leave the Lincoln"
	Game.MapEvtLines:RemoveEvent(501)
	evt.map[501] = function()
		evt.ForPlayer(0)
		if evt.Cmp("IsWearingItem", 604) then
			evt.ForPlayer(1)
			if evt.Cmp("IsWearingItem", 604) then
				evt.ForPlayer(2)
				if evt.Cmp("IsWearingItem", 604) then
					evt.ForPlayer(3)
					if evt.Cmp("IsWearingItem", 604) then
						evt.MoveToMap{X = -7005, Y = 7856, Z = 225, Direction = 128, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "7out15.odm"}
						return
					end
				end
			end
		end
		evt.StatusText(20)         -- "You must all be wearing your wetsuits to exit the ship"
	end]], ""},
		-- Stone City
		-- perception skill barrel
		["d24.lua"] = {[[evt.map[10] = function()
		evt.ForPlayer("All")
		if not evt.Cmp("QBits", 846) then         -- 1-time stone city
			evt.Set("QBits", 846)         -- 1-time stone city
			evt.Set("PerceptionSkill", 70)
		end
	end]], [[evt.map[10] = function()
		if not evt.Cmp("QBits", 846) then         -- 1-time stone city
			evt.Set("QBits", 846)         -- 1-time stone city
			giveFreeSkill(const.Skills.Perception, 6, const.Expert)
		end
	end]]},
		-- Celeste
		-- fix evt.SpeakNPC
		["d25.lua"] =
		{[[evt.SpeakNPC(358)         -- "Resurectra"
				evt.MoveNPC{NPC = 422, HouseId = 1065}         -- "Robert the Wise" -> "Hostel"
				Game.NPC[422].Events[0] = 947         -- "Robert the Wise" : "Control Cube"]],
		[[evt.MoveNPC{NPC = 422, HouseId = 1065}         -- "Robert the Wise" -> "Hostel"
				Game.NPC[422].Events[0] = 947         -- "Robert the Wise" : "Control Cube"
				evt.SpeakNPC(358)         -- "Resurectra"]]
		},
		-- Colony Zod
		-- remove buggy script which is replaced in Merge anyways
		["d27.lua"] = {[[evt.map[376] = function()
		if not evt.Cmp("QBits", 752) then         -- Talked to Roland
			evt.SpeakNPC(626)         -- "Roland Ironfist"
			evt.SetSprite{SpriteId = 20, Visible = 1, Name = "dec05"}
			evt.Add("Inventory", 1463)         -- "Colony Zod Key"
			evt.Add("QBits", 752)         -- Talked to Roland
			evt.Add("History24", 0)
			evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Untouchable, On = true}
			evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Invisible, On = true}
		end
	end
	]], "",
		-- delegate exit event to EVT file so it doesn't crash the game (bugfix)
		[[evt.hint[501] = evt.str[2]  -- "Leave the Hive"
	evt.map[501] = function()
		evt.MoveToMap{X = -18246, Y = -11910, Z = 3201, Direction = 128, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "Out12.odm"}
	end]], ""},
		-- Castle Harmondale
		-- bodybuilding skill barrel
		["d29.lua"] = {[[evt.map[37] = function()
		evt.ForPlayer("All")
		if not evt.Cmp("QBits", 829) then         -- 1-time Castle Harm
			evt.Set("QBits", 829)         -- 1-time Castle Harm
			evt.Set("BodybuildingSkill", 71)
		end
	end]], [[evt.map[37] = function()
		if not evt.Cmp("QBits", 829) then         -- 1-time Castle Harm
			evt.Set("QBits", 829)         -- 1-time Castle Harm
			giveFreeSkill(const.Skills.Bodybuilding, 7, const.Expert)
		end
	end]],
		-- script processing fix
		[[evt.SetMonGroupBit{NPCGroup = 5, -- ERROR: Const not found
	Bit = 0x0, On = false}]], [[evt.SetMonGroupBit{NPCGroup = 56, -- ERROR: Const not found
	Bit = 0x0, On = false}]],
		-- fix evt.SpeakNPC
		[[evt.SpeakNPC(366)         -- "Messenger"
				evt.Set("QBits", 881)         -- "Raise the siege of Stone City by killing all creatures in the Barrow Downs within one week and then proceed to King Hothffar for your reward."
				evt.Set("QBits", 883)         -- Dwarven Messenger Once
				evt.Subtract("QBits", 880)         -- Barrow Normal
				evt.Set("Counter2", 0)]],
		[[evt.Set("QBits", 881)         -- "Raise the siege of Stone City by killing all creatures in the Barrow Downs within one week and then proceed to King Hothffar for your reward."
				evt.Set("QBits", 883)         -- Dwarven Messenger Once
				evt.Subtract("QBits", 880)         -- Barrow Normal
				evt.Set("Counter2", 0)
				evt.SpeakNPC(366)         -- "Messenger"]]
		},

		-- Red Dwarf Mines
		-- Learning skill barrel
		["d34.lua"] = {[[evt.map[10] = function()
		evt.ForPlayer("All")
		if not evt.Cmp("QBits", 847) then         -- BDJ 1
			evt.Set("QBits", 847)         -- BDJ 1
			evt.Set("LearningSkill", 70)
		end
	end]], [[evt.map[10] = function()
		if not evt.Cmp("QBits", 847) then         -- BDJ 1
			evt.Set("QBits", 847)         -- BDJ 1
			giveFreeSkill(const.Skills.Learning, 6, const.Expert)
		end
	end]]},
		-- Emerald Island
		-- fix for different NPCs talking (QBit wasn't set originally)
		["out01.lua"] =
		{
		[[evt.map[200] = function()
		if not evt.Cmp("QBits", 529) then         -- No more docent babble
			evt.SpeakNPC(342)         -- "Big Daddy Jim"
		end
		evt.Set("QBits", 529)         -- No more docent babble
	end]], [[evt.map[200] = function()
		if not evt.Cmp("QBits", 529) then         -- No more docent babble
			evt.Set("QBits", 529)        -- No more docent babble
			evt.SpeakNPC(342)         -- "Big Daddy Jim"
		end
	end]],
		-- fix evt.SpeakNPC
		[[evt.SpeakNPC(356)         -- "Sally"
			evt.Subtract("QBits", 806)         -- Return to EI]],
			[[evt.Subtract("QBits", 806)         -- Return to EI
			evt.SpeakNPC(356)         -- "Sally"]]},
		-- Harmondale teleportal hub
		["out02.lua"] =
		{
			[[evt.map[218] = function()
		evt.ForPlayer(0)
		if evt.Cmp("Inventory", 1467) then         -- "Tatalia Teleportal Key"
			evt.MoveToMap{X = 6604, Y = -8941, Z = 0, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 1172, Icon = 4, Name = "7Out13.odm"}         -- "Harmondale Teleportal Hub"
			goto _9
		end
		if evt.Cmp("Inventory", 1469) then         -- "Avlee Teleportal Key"
			goto _9
		end
		if evt.Cmp("Inventory", 1468) then         -- "Deja Teleportal Key"
			goto _10
		end
		if evt.Cmp("Inventory", 1471) then         -- "Bracada Teleportal Key"
			goto _11
		end
		if not evt.Cmp("Inventory", 1470) then         -- "Evenmorn Teleportal Key"
			evt.StatusText(20)         -- "You need a key to use this hub!"
			return
		end
	::_12::
		evt.MoveToMap{X = 17161, Y = -10827, Z = 0, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 1172, Icon = 4, Name = "Out09.odm"}         -- "Harmondale Teleportal Hub"
		do return end
	::_9::
		evt.MoveToMap{X = 14414, Y = 12615, Z = 0, Direction = 768, LookAngle = 0, SpeedZ = 0, HouseId = 1172, Icon = 4, Name = "Out14.odm"}         -- "Harmondale Teleportal Hub"
	::_10::
		evt.MoveToMap{X = 4586, Y = -12681, Z = 0, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 1172, Icon = 4, Name = "7Out05.odm"}         -- "Harmondale Teleportal Hub"
	::_11::
		evt.MoveToMap{X = 8832, Y = 18267, Z = 0, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 1172, Icon = 4, Name = "7Out06.odm"}         -- "Harmondale Teleportal Hub"
		goto _12
	end]], [[evt.map[218] = function()
		local hasKey = false
		for i = 0, 4 do
			if evt.All.Cmp("Inventory", 1467 + i) then
				hasKey = true
				break
			end
		end
		if not hasKey then
			Game.ShowStatusText(evt.str[20])
		else
			evt.EnterHouse(925)
		end
	end]],
		-- remove original castle harmondale enter event, as it's replaced in Merge
		[[

	evt.hint[301] = evt.str[30]  -- "Enter Castle Harmondale"
	Game.MapEvtLines:RemoveEvent(301)
	evt.map[301] = function()
		if evt.Cmp("QBits", 610) then         -- Built Castle to Level 2 (rescued dwarf guy)
			evt.MoveToMap{X = -5073, Y = -2842, Z = 1, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 382, Icon = 9, Name = "7D29.Blv"}         -- "Castle Harmondale"
		elseif evt.Cmp("QBits", 644) then         -- Butler only shows up once (area 2)
			evt.MoveToMap{X = -5073, Y = -2842, Z = 1, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 390, Icon = 9, Name = "7D29.Blv"}         -- "Castle Harmondale"
		else
			evt.Add("History3", 0)
			evt.SpeakNPC(397)         -- "Butler"
			evt.MoveNPC{NPC = 397, HouseId = 240}         -- "Butler" -> "On the House"
			evt.ForPlayer("All")
			evt.Set("QBits", 587)         -- "Clean out Castle Harmondale and return to the Butler in the tavern, On the House, in Harmondale."
			evt.Set("QBits", 644)         -- Butler only shows up once (area 2)
		end
	end]], "",
		-- fix the Gauntlet script to subtract MM6/MM8 scrolls as well, and remove SP from all party members, and set QBits in vars to restore later
		[[evt.map[221] = function()
		evt.ForPlayer("All")
		if not evt.Cmp("QBits", 868) then         -- 0
			evt.StatusText(54)         -- "You Pray"
			return
		end
		evt.Subtract("QBits", 718)         -- Harmondale - Town Portal
		evt.Subtract("QBits", 719)         -- Erathia - Town Portal
		evt.Subtract("QBits", 720)         -- Tularean Forest - Town Portal
		evt.Subtract("Inventory", 223)         -- "Magic Potion"
	::_8::
		evt.Subtract("Inventory", 223)         -- "Magic Potion"
		evt.Subtract("Inventory", 223)         -- "Magic Potion"
		evt.Subtract("Inventory", 223)         -- "Magic Potion"
		evt.Subtract("Inventory", 223)         -- "Magic Potion"
		evt.Subtract("Inventory", 223)         -- "Magic Potion"
		evt.Subtract("Inventory", 1134)         -- "Lloyd's Beacon"
		if evt.Cmp("Inventory", 1134) then         -- "Lloyd's Beacon"
			goto _8
		end
		if evt.Cmp("Inventory", 223) then         -- "Magic Potion"
			goto _8
		end
		for pl = 0, Party.High do
			evt.ForPlayer(pl)
			if evt.Cmp("FireSkill", 1) then
				evt.Set("SP", 0)
			end
		end
		evt.ForPlayer("All")
		evt.CastSpell{Spell = 80, Mastery = const.GM, Skill = 53, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Dispel Magic"
		evt.Subtract("QBits", 718)         -- Harmondale - Town Portal
		evt.MoveToMap{X = -3257, Y = -12544, Z = 833, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 3, Name = "7D08.blv"}
	end]],
		[[evt.map[221] = function()
		evt.ForPlayer("All")
		if not evt.Cmp("QBits", 868) then         -- 0
			evt.StatusText(54)         -- "You Pray"
			return
		end
		vars.TheGauntletQBits = {}
		for i = 0, 2 do
			vars.TheGauntletQBits[i + 718] = Party.QBits[i + 718]
		end
		evt.Subtract("QBits", 718)         -- Harmondale - Town Portal
		evt.Subtract("QBits", 719)         -- Erathia - Town Portal
		evt.Subtract("QBits", 720)         -- Tularean Forest - Town Portal
		while evt.Cmp("Inventory", 223) do         -- "Magic Potion"
			evt.Subtract("Inventory", 223)         -- "Magic Potion"
		end
		for _, scroll in ipairs({332, 1134, 1834}) do
			while evt.Cmp("Inventory", scroll) do
				evt.Subtract("Inventory", scroll)
			end
		end
		for _, pl in Party do
			if pl.Skills[const.Skills.Fire] ~= 0 then
				pl.SP = 0
			end
		end
		evt.ForPlayer("All")
		-- doesn't work -- evt.CastSpell{Spell = 80, Mastery = const.GM, Skill = 53, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Dispel Magic"
		-- dispel magic
		for i, pl in Party do
			for buffid, buff in pl.SpellBuffs do
				mem.call(0x455E3C, 1, Party[i].SpellBuffs[buffid]["?ptr"])
			end
		end
		for i, buff in Party.SpellBuffs do
			mem.call(0x455E3C, 1, Party.SpellBuffs[i]["?ptr"])
		end
		evt.Subtract("QBits", 718)         -- Harmondale - Town Portal
		evt.MoveToMap{X = -3257, Y = -12544, Z = 833, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 3, Name = "7D08.blv"}
	end]],
		-- fix evt.SpeakNPC
		[[evt.SpeakNPC(365)         -- "Count ZERO"
				evt.Set("Awards", 123)         -- "Completed the MM7Rev4mod Game!!"
				evt.Subtract("QBits", 642)         -- "Go to the Lincoln in the sea west of Avlee and retrieve the Oscillation Overthruster and return it to Resurectra in Celeste."]],
				[[evt.Set("Awards", 123)         -- "Completed the MM7Rev4mod Game!!"
				evt.Subtract("QBits", 642)         -- "Go to the Lincoln in the sea west of Avlee and retrieve the Oscillation Overthruster and return it to Resurectra in Celeste."
				evt.SpeakNPC(365)         -- "Count ZERO"]],
		[[evt.SpeakNPC(437)         -- "Messenger"
					evt.Add("QBits", 693)         -- "Go to the Mercenary Guild in Tatalia and talk to Niles Stantley within two weeks."]],
		[[evt.Add("QBits", 693)         -- "Go to the Mercenary Guild in Tatalia and talk to Niles Stantley within two weeks."
					evt.SpeakNPC(437)         -- "Messenger"]],
		[[evt.SpeakNPC(357)         -- "Lord Godwinson"
				evt.Set("NPCs", 357)         -- "Lord Godwinson"
				evt.MoveNPC{NPC = 1283, HouseId = 0}         -- "Lord Godwinson"
				Game.NPC[357].Events[0] = 846         -- "Lord Godwinson" : "Coding Wizard Quest"
				evt.Set("QBits", 888)         -- LG 1-time]],
		[[evt.Set("NPCs", 357)         -- "Lord Godwinson"
				evt.MoveNPC{NPC = 1283, HouseId = 0}         -- "Lord Godwinson"
				Game.NPC[357].Events[0] = 846         -- "Lord Godwinson" : "Coding Wizard Quest"
				evt.Set("QBits", 888)         -- LG 1-time
				evt.SpeakNPC(357)         -- "Lord Godwinson"]],
		[[evt.SpeakNPC(430)         -- "Messenger"
				evt.Add("QBits", 665)         -- "Choose a judge to succeed Judge Grey as Arbiter in Harmondale."
				evt.Add("History6", 0)
				evt.MoveNPC{NPC = 406, HouseId = 0}         -- "Ellen Rockway"
				evt.MoveNPC{NPC = 407, HouseId = 0}         -- "Alain Hani"
				evt.MoveNPC{NPC = 414, HouseId = 1169}         -- "Ambassador Wright" -> "Throne Room"
				evt.MoveNPC{NPC = 416, HouseId = 244}         -- "Judge Fairweather" -> "Familiar Place"
				evt.Set("QBits", 646)         -- Arbiter Messenger only happens once]],
		[[evt.Add("QBits", 665)         -- "Choose a judge to succeed Judge Grey as Arbiter in Harmondale."
				evt.Add("History6", 0)
				evt.MoveNPC{NPC = 406, HouseId = 0}         -- "Ellen Rockway"
				evt.MoveNPC{NPC = 407, HouseId = 0}         -- "Alain Hani"
				evt.MoveNPC{NPC = 414, HouseId = 1169}         -- "Ambassador Wright" -> "Throne Room"
				evt.MoveNPC{NPC = 416, HouseId = 244}         -- "Judge Fairweather" -> "Familiar Place"
				evt.Set("QBits", 646)         -- Arbiter Messenger only happens once
				evt.SpeakNPC(430)         -- "Messenger"]]},
		-- Erathia
		-- fix small bug in town portal code
		["out03.lua"] = {[[evt.map[35] = function()
		evt.ForPlayer("All")
		if evt.Cmp("Inventory", 1539) then         -- "Town Portal Pass"
			evt.Subtract("Inventory", 1539)         -- "Town Portal Pass"
			evt.MoveToMap{X = -6731, Y = 14045, Z = -512, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "7Out02.Odm"}
		else
			evt.StatusText(22)         -- "You need a town portal pass!"
		end
	end]], [[evt.map[35] = function()
		evt.ForPlayer("All")
		if evt.Cmp("Inventory", 1539) then         -- "Town Portal Pass"
			evt.MoveToMap{X = -6731, Y = 14045, Z = -512, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "7Out02.Odm"}
			evt.Subtract("Inventory", 1539)         -- "Town Portal Pass"
		else
			evt.StatusText(22)         -- "You need a town portal pass!"
		end
	end]], [[evt.map[36] = function()
		evt.ForPlayer("All")
		if evt.Cmp("Inventory", 1539) then         -- "Town Portal Pass"
			evt.Subtract("Inventory", 1539)         -- "Town Portal Pass"
			evt.MoveToMap{X = -15148, Y = -10240, Z = 1312, Direction = 40, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "7Out04.odm"}
		else
			evt.StatusText(22)         -- "You need a town portal pass!"
		end
	end]], [[evt.map[36] = function()
		evt.ForPlayer("All")
		if evt.Cmp("Inventory", 1539) then         -- "Town Portal Pass"
			evt.MoveToMap{X = -15148, Y = -10240, Z = 1312, Direction = 40, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "7Out04.odm"}
			evt.Subtract("Inventory", 1539)         -- "Town Portal Pass"
		else
			evt.StatusText(22)         -- "You need a town portal pass!"
		end
	end]],
		-- brianna's brandy (identify item tea)
		[[evt.map[37] = function()
		evt.ForPlayer("All")
		if not evt.Cmp("QBits", 843) then         -- 1-time Erathia
			evt.Set("QBits", 843)         -- 1-time Erathia
			evt.Set("IdentifyItemSkill", 70)
			evt.SetSprite{SpriteId = 16, Visible = 1, Name = "sp57"}
		end
	end]], [[evt.map[37] = function()
		if not evt.Cmp("QBits", 843) then         -- 1-time Erathia
			evt.Set("QBits", 843)         -- 1-time Erathia
			giveFreeSkill(const.Skills.IdentifyItem, 6, const.Expert)
			evt.SetSprite{SpriteId = 16, Visible = 1, Name = "sp57"}
		end
	end]],
		-- fix evt.SpeakNPC
		[[evt.SpeakNPC(366)         -- "Messenger"
				evt.Set("QBits", 881)         -- "Raise the siege of Stone City by killing all creatures in the Barrow Downs within one week and then proceed to King Hothffar for your reward."
				evt.Set("QBits", 883)         -- Dwarven Messenger Once
				evt.Subtract("QBits", 880)         -- Barrow Normal
				evt.Set("Counter2", 0)]],
		[[evt.Set("QBits", 881)         -- "Raise the siege of Stone City by killing all creatures in the Barrow Downs within one week and then proceed to King Hothffar for your reward."
				evt.Set("QBits", 883)         -- Dwarven Messenger Once
				evt.Subtract("QBits", 880)         -- Barrow Normal
				evt.Set("Counter2", 0)
				evt.SpeakNPC(366)         -- "Messenger"]],
		[[evt.SpeakNPC(412)         -- "Messenger"
				Game.NPC[408].Events[0] = 946         -- "Queen Catherine" : "The Kennel"
				evt.SetNPCGreeting{NPC = 408, Greeting = 134}         -- "Queen Catherine" : "Have you returned with the Journal of Experiments?"
				evt.Set("QBits", 873)         -- mESSENGER ONE-TIME]],
		[[Game.NPC[408].Events[0] = 946         -- "Queen Catherine" : "The Kennel"
				evt.SetNPCGreeting{NPC = 408, Greeting = 134}         -- "Queen Catherine" : "Have you returned with the Journal of Experiments?"
				evt.Set("QBits", 873)         -- mESSENGER ONE-TIME
				evt.SpeakNPC(412)         -- "Messenger"]]},
		-- Tularean Forest
		-- fix evt.SpeakNPC
		["out04.lua"] = 
		{[[evt.SpeakNPC(412)         -- "Messenger"
					evt.Add("Inventory", 1502)         -- "Message from Erathia"
					evt.Set("QBits", 649)         -- Artifact Messenger only happens once
					evt.Set("QBits", 591)         -- "Retrieve Gryphonheart's Trumpet from the battle in the Tularean Forest and return it to whichever side you choose."
					evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Untouchable, On = false}
					evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Invisible, On = false}
					evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 3, X = -15752, Y = 21272, Z = 3273, NPCGroup = 51, unk = 0}
					evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 5, X = -14000, Y = 18576, Z = 4250, NPCGroup = 51, unk = 0}
					evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 10, X = -16016, Y = 19280, Z = 3284, NPCGroup = 51, unk = 0}
					evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 30, X = -15752, Y = 21272, Z = 3273, NPCGroup = 51, unk = 0}
					evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 9, X = -14000, Y = 18576, Z = 4250, NPCGroup = 51, unk = 0}
					evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 10, X = -16016, Y = 19280, Z = 3284, NPCGroup = 51, unk = 0}]],
		[[evt.Add("Inventory", 1502)         -- "Message from Erathia"
					evt.Set("QBits", 649)         -- Artifact Messenger only happens once
					evt.Set("QBits", 591)         -- "Retrieve Gryphonheart's Trumpet from the battle in the Tularean Forest and return it to whichever side you choose."
					evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Untouchable, On = false}
					evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Invisible, On = false}
					evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 3, X = -15752, Y = 21272, Z = 3273, NPCGroup = 51, unk = 0}
					evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 5, X = -14000, Y = 18576, Z = 4250, NPCGroup = 51, unk = 0}
					evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 10, X = -16016, Y = 19280, Z = 3284, NPCGroup = 51, unk = 0}
					evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 30, X = -15752, Y = 21272, Z = 3273, NPCGroup = 51, unk = 0}
					evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 9, X = -14000, Y = 18576, Z = 4250, NPCGroup = 51, unk = 0}
					evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 10, X = -16016, Y = 19280, Z = 3284, NPCGroup = 51, unk = 0}
					evt.SpeakNPC(412)         -- "Messenger"]]},
		-- Deyja
		-- fix evt.SpeakNPC
		["out05.lua"] = 
		{[[evt.SpeakNPC(461)         -- "Lunius Shador"
				evt.Set("MapVar29", 0)]],
		[[evt.Set("MapVar29", 0)
				evt.SpeakNPC(461)         -- "Lunius Shador"]],
		[[evt.SpeakNPC(374)         -- "Sir Vilx of Stone City"
			evt.Set("QBits", 890)         -- Vilx
			evt.Set("NPCs", 374)         -- "Sir Vilx of Stone City"]],
		[[evt.Set("QBits", 890)         -- Vilx
			evt.Set("NPCs", 374)         -- "Sir Vilx of Stone City"
			evt.SpeakNPC(374)         -- "Sir Vilx of Stone City"]],
		[[evt.SpeakNPC(373)         -- "Duke Bimbasto"
			evt.Set("QBits", 889)         -- Bimbasto
			evt.Set("NPCs", 373)         -- "Duke Bimbasto"]],
		[[evt.Set("QBits", 889)         -- Bimbasto
			evt.Set("NPCs", 373)         -- "Duke Bimbasto"
			evt.SpeakNPC(373)         -- "Duke Bimbasto"]]
		},
		-- Bracada Desert
		-- fix dock teleporter to teleport you on the ground
		["out06.lua"] =
		{
			[[evt.MoveToMap{X = 17656, Y = -20704, Z = 800, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}]],
			[[evt.MoveToMap{X = 17656, Y = -20704, Z = 326, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}]],
			-- fix evt.SpeakNPC
			[[evt.SpeakNPC(366)         -- "Messenger"
				evt.Set("QBits", 881)         -- "Raise the siege of Stone City by killing all creatures in the Barrow Downs within one week and then proceed to King Hothffar for your reward."
				evt.Set("QBits", 883)         -- Dwarven Messenger Once
				evt.Subtract("QBits", 880)         -- Barrow Normal
				evt.Set("Counter2", 0)]],
			[[evt.Set("QBits", 881)         -- "Raise the siege of Stone City by killing all creatures in the Barrow Downs within one week and then proceed to King Hothffar for your reward."
				evt.Set("QBits", 883)         -- Dwarven Messenger Once
				evt.Subtract("QBits", 880)         -- Barrow Normal
				evt.Set("Counter2", 0)
				evt.SpeakNPC(366)         -- "Messenger"]]
		},
		-- Barrow Downs
		-- repair tea
		["out11.lua"] = {[[evt.map[10] = function()
		evt.ForPlayer("All")
		if not evt.Cmp("QBits", 833) then         -- Gepetto's Thermos
			evt.Set("QBits", 833)         -- Gepetto's Thermos
			evt.Set("RepairSkill", 71)
		end
	end]], [[evt.map[10] = function()
		evt.ForPlayer("All")
		if not evt.Cmp("QBits", 833) then         -- Gepetto's Thermos
			evt.Set("QBits", 833)         -- Gepetto's Thermos
			giveFreeSkill(const.Skills.Repair, 7, const.Expert)
		end
	end]],
		-- fix evt.SpeakNPC
		[[evt.SpeakNPC(398)         -- "Hothfarr IX"
			evt.Set("QBits", 882)         -- "Obtain Plague Elixir from Lucid Apple in Avlee and deliver it to King Hothffar in Stone City within two days."
			evt.Subtract("QBits", 881)         -- "Raise the siege of Stone City by killing all creatures in the Barrow Downs within one week and then proceed to King Hothffar for your reward."
			evt.ForPlayer("All")
			evt.Set("Counter2", 0)]],
		[[evt.Set("QBits", 882)         -- "Obtain Plague Elixir from Lucid Apple in Avlee and deliver it to King Hothffar in Stone City within two days."
			evt.Subtract("QBits", 881)         -- "Raise the siege of Stone City by killing all creatures in the Barrow Downs within one week and then proceed to King Hothffar for your reward."
			evt.ForPlayer("All")
			evt.Set("Counter2", 0)
			evt.SpeakNPC(398)         -- "Hothfarr IX"]],
		[[evt.SpeakNPC(369)         -- "Doom Bearer"
		evt.Set("Awards", 124)         -- "Inducted into the Erathian Hall of Shame!"]],
		[[evt.Set("Awards", 124)         -- "Inducted into the Erathian Hall of Shame!
		evt.SpeakNPC(369)         -- "Doom Bearer]]
		},
		["mdk02.lua"] = {[[evt.SetMonGroupBit{NPCGroup = 5, -- ERROR: Const not found
	Bit = const.MonsterBits.Hostile + 0x40000 + const.MonsterBits.NoFlee + const.MonsterBits.Invisible, On = false}]],
	[[evt.SetMonGroupBit{NPCGroup = 56, -- ERROR: Const not found
	Bit = const.MonsterBits.Hostile + 0x40000 + const.MonsterBits.NoFlee + const.MonsterBits.Invisible, On = false}]]
		},

		-- The Strange Temple
		-- remove unfinished Rev4 script which will interfere with my own quest
		["nwc.lua"] = {[[
		Game.NPC[388].Events[0] = 847         -- "Halfgild Wynac" : "Lord Godwinson sent us!"]], ""
		},
		
		-- The Vault
		-- fix MMExtension bugs where script stops executing after evt.SpeakNPC
		["mdt12.lua"] = 
		{[[evt.SpeakNPC(1279)         -- "The Coding Wizard"
			evt.SetNPCGreeting{NPC = 360, Greeting = 151}         -- "Zedd True Shot" : "What a glorious day for victory, my friends!."
			evt.SetNPCGreeting{NPC = 376, Greeting = 151}         -- "Pascal the Mad Mage" : "What a glorious day for victory, my friends!."
			evt.SetNPCGreeting{NPC = 373, Greeting = 151}         -- "Duke Bimbasto" : "What a glorious day for victory, my friends!."
			evt.SetNPCGreeting{NPC = 374, Greeting = 151}         -- "Sir Vilx of Stone City" : "What a glorious day for victory, my friends!."
			evt.SetNPCGreeting{NPC = 359, Greeting = 151}         -- "Baron BunGleau" : "What a glorious day for victory, my friends!."
			evt.SetNPCGreeting{NPC = 357, Greeting = 151}         -- "Lord Godwinson" : "What a glorious day for victory, my friends!."
			evt.Set("NPCs", 360)         -- "Zedd True Shot"
			evt.Set("NPCs", 357)         -- "Lord Godwinson"
			evt.Set("NPCs", 359)         -- "Baron BunGleau"
			evt.Set("NPCs", 374)         -- "Sir Vilx of Stone City"
			evt.Set("NPCs", 373)         -- "Duke Bimbasto"
			evt.Set("NPCs", 376)         -- "Pascal the Mad Mage"
			evt.Set("QBits", 891)         -- Exit 1-time Cave 1 Vault]]
				,
				[[evt.SetNPCGreeting{NPC = 360, Greeting = 151}         -- "Zedd True Shot" : "What a glorious day for victory, my friends!."
			evt.SetNPCGreeting{NPC = 376, Greeting = 151}         -- "Pascal the Mad Mage" : "What a glorious day for victory, my friends!."
			evt.SetNPCGreeting{NPC = 373, Greeting = 151}         -- "Duke Bimbasto" : "What a glorious day for victory, my friends!."
			evt.SetNPCGreeting{NPC = 374, Greeting = 151}         -- "Sir Vilx of Stone City" : "What a glorious day for victory, my friends!."
			evt.SetNPCGreeting{NPC = 359, Greeting = 151}         -- "Baron BunGleau" : "What a glorious day for victory, my friends!."
			evt.SetNPCGreeting{NPC = 357, Greeting = 151}         -- "Lord Godwinson" : "What a glorious day for victory, my friends!."
			evt.Set("NPCs", 360)         -- "Zedd True Shot"
			evt.Set("NPCs", 357)         -- "Lord Godwinson"
			evt.Set("NPCs", 359)         -- "Baron BunGleau"
			evt.Set("NPCs", 374)         -- "Sir Vilx of Stone City"
			evt.Set("NPCs", 373)         -- "Duke Bimbasto"
			evt.Set("NPCs", 376)         -- "Pascal the Mad Mage"
			evt.Set("QBits", 891)         -- Exit 1-time Cave 1 Vault
			evt.SpeakNPC(1279)         -- "The Coding Wizard"]]
				,
				[[evt.SpeakNPC(1279)         -- "The Coding Wizard"
			evt.Set("QBits", 892)         -- "Pass the Test of Friendship"
			evt.Subtract("NPCs", 360)         -- "Zedd True Shot"
			evt.Subtract("NPCs", 357)         -- "Lord Godwinson"
			evt.Subtract("NPCs", 359)         -- "Baron BunGleau"
			evt.Subtract("NPCs", 374)         -- "Sir Vilx of Stone City"
			evt.Subtract("NPCs", 373)         -- "Duke Bimbasto"
			evt.Subtract("NPCs", 376)         -- "Pascal the Mad Mage"
			evt.SetMonGroupBit{NPCGroup = 57, Bit = const.MonsterBits.Hostile, On = false}         -- "Group for M1"
			evt.SetMonGroupBit{NPCGroup = 58, Bit = const.MonsterBits.Hostile, On = false}         -- "Group fo M2"
			evt.SetMonGroupBit{NPCGroup = 59, Bit = const.MonsterBits.Hostile, On = false}         -- "Group for M3"
			evt.SetMonGroupBit{NPCGroup = 60, Bit = const.MonsterBits.Hostile, On = false}         -- "Group for Malwick's Assc."
			evt.SetMonGroupBit{NPCGroup = 61, Bit = const.MonsterBits.Hostile, On = false}         -- "Southern Village Group in Harmondy"
			evt.SetMonGroupBit{NPCGroup = 62, Bit = const.MonsterBits.Hostile, On = false}         -- "Main village in Harmondy"
			evt.SetMonGroupBit{NPCGroup = 57, Bit = const.MonsterBits.Invisible, On = false}         -- "Group for M1"
			evt.SetMonGroupBit{NPCGroup = 58, Bit = const.MonsterBits.Invisible, On = false}         -- "Group fo M2"
			evt.SetMonGroupBit{NPCGroup = 59, Bit = const.MonsterBits.Invisible, On = false}         -- "Group for M3"
			evt.SetMonGroupBit{NPCGroup = 60, Bit = const.MonsterBits.Invisible, On = false}         -- "Group for Malwick's Assc."
			evt.SetMonGroupBit{NPCGroup = 61, Bit = const.MonsterBits.Invisible, On = false}         -- "Southern Village Group in Harmondy"
			evt.SetMonGroupBit{NPCGroup = 62, Bit = const.MonsterBits.Invisible, On = false}         -- "Main village in Harmondy"
			evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
			Game.NPC[360].Events[1] = 790         -- "Zedd True Shot" : "Let's Go!"
			Game.NPC[373].Events[1] = 876         -- "Duke Bimbasto" : "Let's Go!"
			Game.NPC[374].Events[1] = 877         -- "Sir Vilx of Stone City" : "Let's Go!"
			Game.NPC[376].Events[1] = 884         -- "Pascal the Mad Mage" : "Let's Go!"
			Game.NPC[359].Events[1] = 885         -- "Baron BunGleau" : "Let's Go!"
			Game.NPC[357].Events[1] = 886         -- "Lord Godwinson" : "Let's Go!"
			Game.NPC[1279].Events[0] = 1174         -- "The Coding Wizard" : "A word of Caution!"
			evt.MoveToMap{X = -54, Y = 3470, Z = 0, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}]],
			[[evt.Set("QBits", 892)         -- "Pass the Test of Friendship"
			evt.Subtract("NPCs", 360)         -- "Zedd True Shot"
			evt.Subtract("NPCs", 357)         -- "Lord Godwinson"
			evt.Subtract("NPCs", 359)         -- "Baron BunGleau"
			evt.Subtract("NPCs", 374)         -- "Sir Vilx of Stone City"
			evt.Subtract("NPCs", 373)         -- "Duke Bimbasto"
			evt.Subtract("NPCs", 376)         -- "Pascal the Mad Mage"
			evt.SetMonGroupBit{NPCGroup = 57, Bit = const.MonsterBits.Hostile, On = false}         -- "Group for M1"
			evt.SetMonGroupBit{NPCGroup = 58, Bit = const.MonsterBits.Hostile, On = false}         -- "Group fo M2"
			evt.SetMonGroupBit{NPCGroup = 59, Bit = const.MonsterBits.Hostile, On = false}         -- "Group for M3"
			evt.SetMonGroupBit{NPCGroup = 60, Bit = const.MonsterBits.Hostile, On = false}         -- "Group for Malwick's Assc."
			evt.SetMonGroupBit{NPCGroup = 61, Bit = const.MonsterBits.Hostile, On = false}         -- "Southern Village Group in Harmondy"
			evt.SetMonGroupBit{NPCGroup = 62, Bit = const.MonsterBits.Hostile, On = false}         -- "Main village in Harmondy"
			evt.SetMonGroupBit{NPCGroup = 57, Bit = const.MonsterBits.Invisible, On = false}         -- "Group for M1"
			evt.SetMonGroupBit{NPCGroup = 58, Bit = const.MonsterBits.Invisible, On = false}         -- "Group fo M2"
			evt.SetMonGroupBit{NPCGroup = 59, Bit = const.MonsterBits.Invisible, On = false}         -- "Group for M3"
			evt.SetMonGroupBit{NPCGroup = 60, Bit = const.MonsterBits.Invisible, On = false}         -- "Group for Malwick's Assc."
			evt.SetMonGroupBit{NPCGroup = 61, Bit = const.MonsterBits.Invisible, On = false}         -- "Southern Village Group in Harmondy"
			evt.SetMonGroupBit{NPCGroup = 62, Bit = const.MonsterBits.Invisible, On = false}         -- "Main village in Harmondy"
			evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
			Game.NPC[360].Events[1] = 790         -- "Zedd True Shot" : "Let's Go!"
			Game.NPC[373].Events[1] = 876         -- "Duke Bimbasto" : "Let's Go!"
			Game.NPC[374].Events[1] = 877         -- "Sir Vilx of Stone City" : "Let's Go!"
			Game.NPC[376].Events[1] = 884         -- "Pascal the Mad Mage" : "Let's Go!"
			Game.NPC[359].Events[1] = 885         -- "Baron BunGleau" : "Let's Go!"
			Game.NPC[357].Events[1] = 886         -- "Lord Godwinson" : "Let's Go!"
			Game.NPC[1279].Events[0] = 1174         -- "The Coding Wizard" : "A word of Caution!"
			evt.MoveToMap{X = -54, Y = 3470, Z = 0, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
			evt.SpeakNPC(1279)         -- "The Coding Wizard"]],
			-- need ansi encoding (windows 1252 for vscode) to correctly represent these funny apostrophes
			[[evt.SpeakNPC(1279)         -- "The Coding Wizard"
			evt.Set("Awards", 128)         -- "Hall of Shame Award ‘Unfaithful Friends’"
			evt.Subtract("Inventory", 1477)         -- "Control Cube"
			evt.Set("Eradicated", 0)]],
			
			[[evt.Set("Awards", 128)         -- "Hall of Shame Award ‘Unfaithful Friends’"
			evt.Subtract("Inventory", 1477)         -- "Control Cube"
			evt.Set("Eradicated", 0)
			evt.SpeakNPC(1279)         -- "The Coding Wizard"]]},
			-- The Small House
			-- fix evt.SpeakNPC
			["mdt15.lua"] =
			{
			[[evt.SpeakNPC(762)         -- "Maximus"
					evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 10, X = 3, Y = 3042, Z = 0, -- ERROR: Not found
	NPCGroup = 1587, unk = 0}
					evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 10, X = 718, Y = 2956, Z = 0, -- ERROR: Not found
	NPCGroup = 1587, unk = 0}
					evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 10, X = -646, Y = 2889, Z = 0, -- ERROR: Not found
	NPCGroup = 1587, unk = 0}
					evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 10, X = 0, Y = 3500, Z = 0, -- ERROR: Not found
	NPCGroup = 1587, unk = 0}
					evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 10, X = -31, Y = 1900, Z = 0, -- ERROR: Not found
	NPCGroup = 1587, unk = 0}
					evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 10, X = 597, Y = 1900, Z = 0, -- ERROR: Not found
	NPCGroup = 1587, unk = 0}
					evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 10, X = -624, Y = 1900, Z = 0, -- ERROR: Not found
	NPCGroup = 1587, unk = 0}]],
			[[evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 10, X = 3, Y = 3042, Z = 0, -- ERROR: Not found
	NPCGroup = 1587, unk = 0}
					evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 10, X = 718, Y = 2956, Z = 0, -- ERROR: Not found
	NPCGroup = 1587, unk = 0}
					evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 10, X = -646, Y = 2889, Z = 0, -- ERROR: Not found
	NPCGroup = 1587, unk = 0}
					evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 10, X = 0, Y = 3500, Z = 0, -- ERROR: Not found
	NPCGroup = 1587, unk = 0}
					evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 10, X = -31, Y = 1900, Z = 0, -- ERROR: Not found
	NPCGroup = 1587, unk = 0}
					evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 10, X = 597, Y = 1900, Z = 0, -- ERROR: Not found
	NPCGroup = 1587, unk = 0}
					evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 10, X = -624, Y = 1900, Z = 0, -- ERROR: Not found
	NPCGroup = 1587, unk = 0}
					evt.SpeakNPC(762)         -- "Maximus"]],
			[[evt.SpeakNPC(724)         -- "Sir Carneghem"
					evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 10, X = 3, Y = 3042, Z = 0, -- ERROR: Not found
	NPCGroup = 1587, unk = 0}
					evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 10, X = 718, Y = 2956, Z = 0, -- ERROR: Not found
	NPCGroup = 1587, unk = 0}
					evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 10, X = -646, Y = 2889, Z = 0, -- ERROR: Not found
	NPCGroup = 1587, unk = 0}
					evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 10, X = 0, Y = 3500, Z = 0, -- ERROR: Not found
	NPCGroup = 1587, unk = 0}
					evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 10, X = -31, Y = 1900, Z = 0, -- ERROR: Not found
	NPCGroup = 1587, unk = 0}
					evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 10, X = 597, Y = 1900, Z = 0, -- ERROR: Not found
	NPCGroup = 1587, unk = 0}
					evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 10, X = -624, Y = 1900, Z = 0, -- ERROR: Not found
	NPCGroup = 1587, unk = 0}]],
			[[evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 10, X = 3, Y = 3042, Z = 0, -- ERROR: Not found
	NPCGroup = 1587, unk = 0}
					evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 10, X = 718, Y = 2956, Z = 0, -- ERROR: Not found
	NPCGroup = 1587, unk = 0}
					evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 10, X = -646, Y = 2889, Z = 0, -- ERROR: Not found
	NPCGroup = 1587, unk = 0}
					evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 10, X = 0, Y = 3500, Z = 0, -- ERROR: Not found
	NPCGroup = 1587, unk = 0}
					evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 10, X = -31, Y = 1900, Z = 0, -- ERROR: Not found
	NPCGroup = 1587, unk = 0}
					evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 10, X = 597, Y = 1900, Z = 0, -- ERROR: Not found
	NPCGroup = 1587, unk = 0}
					evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 10, X = -624, Y = 1900, Z = 0, -- ERROR: Not found
	NPCGroup = 1587, unk = 0}
						evt.SpeakNPC(724)         -- "Sir Carneghem"]]}
	}

	local patchesMerge =
	{
		-- Tularean Forest
		-- remove event which is replaced in rev4
		["out04.lua"] = {[[

	-- Clanker's Laboratory
Game.MapEvtLines:RemoveEvent(503)
evt.map[503] = function()

	if Party.QBits[710] then
		evt.MoveNPC{427, 395}
		Game.Houses[395].ExitMap = 86
		Game.Houses[395].ExitPic = 1
		evt.EnterHouse{395}
	else
		evt.MoveToMap{0,-709,1,512,0,0,395,9,"7d12.blv"}
	end

end]], ""},
		["out14.lua"] = {"Party.QBits[783]", "Party.QBits[980]"},
		["hive.lua"] = {"Party.QBits[784]", "Party.QBits[981]"},
		-- Barrow Downs
		-- remove conflicting Stone City enter event
		["out11.lua"] = {
		[[Game.MapEvtLines:RemoveEvent(501)
	evt.hint[501] = evt.str[30]
	evt.map[501] = function()
		evt.MoveToMap {179, -5386, 33, 240, 0, 0, 408, 2, "7d24.blv"}
		--evt.MoveToMap {245, -5362, 34, 512, 0, 0, 408, 2, "7d24.blv"}
	end]], ""
		},
		-- remove original event from script to allow Merge replacement to work correctly
		["out12.lua"] = {
		[[-- Correct load map event.
	Game.MapEvtLines:RemoveEvent(1)]],
		[[-- Correct load map event.
	Game.MapEvtLines:RemoveEvent(1)
	evt.map[1].clear()]]},
	}

	local additions =
	{
		["out01.lua"] =
		{
		-- Emerald Island
		-- add QBits and show movie on arrival
		[[
	-- starting QBits
	evt.map[100] = function()  -- function events.LoadMap()
		local add = true
		for qb = 513, 519 do
			if Party.QBits[qb] then
				add = false
				break
			end
		end
		if add then
			for qb = 513, 518 do
				evt.Add("QBits", qb) -- evt to show flash on PC faces
			end
			evt.ShowMovie{DoubleSize = 1, Name = "\"intro post\""}
		end
	end

	events.LoadMap = evt.map[100].last]],
	-- old patch, kept just in case
	--[=[
	evt.map[100] = function()  -- function events.LoadMap()
		if not evt.Cmp("QBits", 519) then         -- Finished Scavenger Hunt
			if not evt.Cmp("QBits", 518) then         -- "Return a wealthy hat to the Judge on Emerald Island."
				if not evt.Cmp("QBits", 517) then         -- "Return a musical instrument to the Judge on Emerald Island."
					if not evt.Cmp("QBits", 516) then         -- "Return a floor tile to the Judge on Emerald Island."
						if not evt.Cmp("QBits", 515) then         -- "Return a longbow to the Judge on Emerald Island."
							if not evt.Cmp("QBits", 514) then         -- "Return a seashell to the Judge on Emerald Island."
								if not evt.Cmp("QBits", 513) then         -- "Return a red potion to the Judge on Emerald Island."
									evt.Add("QBits", 518)         -- "Return a wealthy hat to the Judge on Emerald Island."
									evt.Add("QBits", 517)         -- "Return a musical instrument to the Judge on Emerald Island."
									evt.Add("QBits", 516)         -- "Return a floor tile to the Judge on Emerald Island."
									evt.Add("QBits", 515)         -- "Return a longbow to the Judge on Emerald Island."
									evt.Add("QBits", 514)         -- "Return a seashell to the Judge on Emerald Island."
									evt.Add("QBits", 513)         -- "Return a red potion to the Judge on Emerald Island."
									evt.ShowMovie{DoubleSize = 1, Name = "\"intro post\""}
								end
							end
						end
					end
				end
			end
		end
	end

	events.LoadMap = evt.map[100].last]=]},
		-- Coding Fortress
		-- make BDJ invisible by default
		-- make BDJ hostile on save game reload/lloyd back to dungeon
		["d12.lua"] = {[[
	function events.AfterLoadMap()
		if Map.Name == "7d12.blv" then
			-- make BDJ invisible by default
			if not vars["BDJ hidden"] then
				evt.SetMonGroupBit{NPCGroup = 60, Bit = const.MonsterBits.Invisible, On = true}
				vars["BDJ hidden"] = true
			end
			-- make BDJ hostile on save game reload/lloyd back to dungeon
			if vars["make BDJ hostile"] then
				evt.SetMonGroupBit{NPCGroup = 60, Bit = const.MonsterBits.Hostile, On = true}
			end
			vars["make BDJ hostile"] = true
		end
	end]]},
		-- Castle Harmondale
		-- fix for a bug where golem and messenger of the saints are visible by default
		["d29.lua"] = {[[
	-- fix for a bug where golem and messenger of the saints are visible by default
	function events.AfterLoadMap()
		if (not vars["Castle Harmondale NPCs hidden"]) and Game.Map.Name == "7d29.blv" then
			if not (Party.QBits[585] or Party.QBits[586]) then
				evt.SetMonGroupBit{NPCGroup = 57, Bit = const.MonsterBits.Invisible, On = true}
			end
			if not Party.QBits[647] then
				evt.SetMonGroupBit{NPCGroup = 61, Bit = const.MonsterBits.Invisible, On = true}
			end
			vars["Castle Harmondale NPCs hidden"] = true
		end
	end]]},
		-- Bracada Desert
		-- fix teleporters so one of two teleporting to temple teleports to shops instead
		["out06.lua"] = {
			[[evt.hint[318] = evt.str[100]  -- ""
	evt.map[318] = function()
		evt.MoveToMap{X = -14125, Y = -7638, Z = 1345, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	end]]
		},
		-- The Vault
		-- fix so that friends will fight with dragons & hydras
		["mdt12.lua"] = {[[
	-- fix so that friends will fight with dragons & hydras
	function events.AfterLoadMap()
		LocalHostileTxt()
		local nameids = {}
		for k, v in Map.Monsters do
			if v.NameId ~= 0 then
				table.insert(nameids, (v.Id + 2):div(3))
			end
		end
		for _, m in ipairs(nameids) do
			for i, v in Game.HostileTxt do
				if not table.find(nameids, i) then
					Game.HostileTxt[m][i] = 4
					Game.HostileTxt[i][m] = 4
				end
			end
		end
	end]]}
	}

	local ignoreMergeAdditions =
	{
		["d08.lua"] = true
	}

	local function patchFailure(what, patch)
		printf("Error (%s): replacement not made: %s", what, patch:sub(1, math.min(300, patch:len())))
		error("breakpoint")
	end
	rev4m.f = rev4m.f or {}
	rev4m.f.patchFailure = patchFailure

	for i in path.find(rev4m.path.originalRev4Scripts .. "*.lua") do
		print("Current file: " .. path.name(i))
		local file = io.open(i)
		local content = file:read("*a")
		file:close()
		local name = path.name(i):lower()
		rev4m.currentlyProcessedScript = name
		local done = nil
		if patches[name] ~= nil then
			for i = 1, #patches[name], 2 do
				content, done = content:replaceIndent(patches[name][i], patches[name][i + 1])
				if done == 0 then
					patchFailure("Patches before", patches[name][i])
				end
			end
		end
		for regex, fun in pairs(replacements) do
			if regex ~= "evt%.StatusText%((%d+)%)" then
				content = content:gsub(regex, fun)
			end
		end
		
		if additions[name] ~= nil then
			for i, v in ipairs(additions[name]) do
				content = content .. v
			end
		end
		
		if patchesAfter[name] ~= nil then
			for i = 1, #patchesAfter[name], 2 do
				--content, done = content:replace(patchesAfter[name][i], patchesAfter[name][i + 1])
				content, done = content:replaceIndent(patchesAfter[name][i], patchesAfter[name][i + 1])
				if done == 0 then
					patchFailure("patchesAfter", patchesAfter[name][i])
				end
			end
		end
		
		-- preserve MMMerge script additions
		if ignoreMergeAdditions[name] == nil then
			local file = io.open(rev4m.path.mergeMapScripts .. getFileName(path.name(i)), "r")
			if file then
				local content2 = file:read("*a")
				content = content .. "\n\n--[[ MMMerge additions ]]--\n\n" .. content2
				file:close()
			end
		end
		
		if patchesMerge[name] ~= nil then
			for i = 1, #patchesMerge[name], 2 do
				content, done = content:replaceIndent(patchesMerge[name][i], patchesMerge[name][i + 1])
				if done == 0 then
					patchFailure("patchesMerge", patchesMerge[name][i])
				end
			end
		end
		
		-- convert DDMapBuffs
		local done
		content, done = content:gsub("Party%.QBits%[(%d+)%] = true	%-%- DDMapBuff", function(buff)
			buff = tonumber(buff)
			return ("Party.QBits[%d] = true	-- DDMapBuff, changed for rev4 for merge"):format(getDDMapBuff(buff))
		end)
		if done ~= 1 and name:find("out") ~= nil then
			print("Outdoor map " .. name .. ", no DDMapBuff replacement made - check this")
		end
		content = content:replace("Game.MapEvtLines.Count = 0  -- Deactivate all standard events", "-- REMOVED BY REV4 FOR MERGE\n-- Game.MapEvtLines.Count = 0  -- Deactivate all standard events")
		io.save(rev4m.path.processedRev4Scripts .. getFileName(path.name(i)), content)
	end
	rev4m.ddMapBuffs() -- process maps not modified in rev4
end

rev4m = rev4m or {}
function rev4m.globalScripts()
	local content = io.load(rev4m.path.rev4GlobalLua)

	local replacements = table.copy(rev4m.scriptReplacements)

	--[[ USEFUL STUFF
	shows event id when event is triggered on the map
	function events.EvtMap(evtId, seq)
		Message(tostring(evtId))
	end
	--]]

	for regex, fun in pairs(replacements) do
		content = content:gsub(regex, fun)
	end

	local patches =
	{
		[ [[Game.GlobalEvtLines.Count = 0  -- Deactivate all standard events

		]] ] = "",

		[ [[evt.ForPlayer(3)
		if evt.Cmp("FireSkill", 1) then
			evt.Set("FireSkill", 49152)
			evt.Set("FireSkill", 72)
		end
		evt.ForPlayer(2)
		if evt.Cmp("FireSkill", 1) then
			evt.Set("FireSkill", 49152)
			evt.Set("FireSkill", 72)
		end
		evt.ForPlayer(1)
		if evt.Cmp("FireSkill", 1) then
			evt.Set("FireSkill", 49152)
			evt.Set("FireSkill", 72)
		end
		evt.ForPlayer(0)
		if evt.Cmp("FireSkill", 1) then
			evt.Set("FireSkill", 49152)
			evt.Set("FireSkill", 72)
		end]] ] = [[giveFreeSkill(const.Skills.Fire, 8, const.Expert, function(pl) return pl.Skills[const.Skills.Fire] ~= 0 end)]],
	-- don't need sparkles, as later there's evt.Add("Experience")
	[ [[if not evt.Cmp("QBits", 807) then         -- Water
			if not evt.Cmp("QBits", 808) then         -- Fire
				if not evt.Cmp("QBits", 809) then         -- Air
					if not evt.Cmp("QBits", 810) then         -- Earth
						return
					end
				end
			end
		end]] ] = [[if not evt.Cmp("QBits", 807) or not evt.Cmp("QBits", 808) or not evt.Cmp("QBits", 809) or not evt.Cmp("QBits", 810) then
			return
		end]],
		[ [[evt.Set("DarkSkill", 136)]] ] = [[-- evt.Set("DarkSkill", 136) -- given in "global/ZRev4 for Merge.lua" file]],
		[ [[evt.Set("LightSkill", 136)]] ] = [[-- evt.Set("LightSkill", 136)]],
		-- [ [[evt.Subtract("QBits", 811)         -- "Clear out the Strange Temple,  retrieve the ancient weapons, and return to Maximus in The Pit"]] ] =
		-- [[evt.SetNPCGreeting{NPC = 388, Greeting = 370} -- Halfgild Wynac
		-- evt.Subtract("QBits", 811)         -- "Clear out the Strange Temple,  retrieve the ancient weapons, and return to Maximus in The Pit"]],
		--
		
		[ [[evt.MoveNPC{NPC = 60, -- ERROR: Not found
	HouseId = 999}         -- "Drathen Keldin"]] ] = "",

		[ [[evt.Add(-- ERROR: Not found
	"Awards", 83886128)]] ] = [[evt.Add(-- ERROR: Not found
	"Awards", 21)]],
		[ [[evt.global[42397] = function()
		evt.SetSnow{EffectId = 18, On = true}
	end]] ] = "",
		[ [[evt.Set(-- ERROR: Award index outside of normal range
	"Awards", 108)         -- "Inducted into the Erathian Hall of Shame!"
			evt.EnterHouse(600)         -- Win Good]] ] =
		[[evt.Set(-- ERROR: Award index outside of normal range
	"Awards", 133)         -- "Inducted into the Erathian Hall of Shame!]]
	}

	for from, to in pairs(patches) do
		local done = 0
		content, done = content:replaceIndent(from, to)
		if done == 0 then
			rev4m.f.patchFailure("global patches", from)
		end
	end

	io.save(rev4m.path.processedRev4GlobalLua, content)
end

function rev4m.processScripts()
	rev4m.mapScripts()
	rev4m.globalScripts()
end