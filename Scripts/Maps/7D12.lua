local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Entrance to Vori",
	[3] = "Chest",
	[4] = "Button",
	[5] = "Lever",
	[6] = "Vault",
	[7] = "Cabinet",
	[8] = "Switch",
	[9] = "You need the pasword to enter Vori.",
	[10] = "Bookcase",
	[11] = "",
	[12] = "Promotion Brazier",
	[13] = "",
	[14] = "You Successfully disarm the trap",
	[15] = "",
	[16] = "Take a Drink",
	[17] = "Not Very Refreshing",
	[18] = "Refreshing",
	[19] = "",
	[20] = "Only BDJ can activate this Brazier.",
	[21] = "Return to the Coding Wizard.",
	[22] = "Summon the Coding Wizard",
	[23] = "",
	[24] = "",
	[25] = "Might Barrel",
	[26] = "Endurance Barrel",
	[27] = "Luck Barrel",
	[28] = "Accuracy Barrel",
	[29] = "Intelligence Barrel",
	[30] = "Personality Barrel",
	[31] = "+5 Might",
	[32] = "+5 Endurance",
	[33] = "+5 Luck",
	[34] = "+5 Accuracy",
	[35] = "+5 Intelligence",
	[36] = "+5 Personality",
	[37] = "Use Barrels to select attribute bonus",
}
table.copy(TXT, evt.str, true)


evt.hint[1] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(1)
evt.map[1] = function()  -- function events.LoadMap()
	evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
end

events.LoadMap = evt.map[1].last

Game.MapEvtLines:RemoveEvent(3)
evt.map[3] = function()
	evt.SetDoorState{Id = 17, State = 1}
	evt.SetDoorState{Id = 3, State = 0}
end

evt.hint[4] = evt.str[4]  -- "Button"
Game.MapEvtLines:RemoveEvent(4)
evt.map[4] = function()
	evt.SetDoorState{Id = 6, State = 1}
	evt.Set{"MapVar0", Value = 1}
	evt.SetDoorState{Id = 20, State = 0}
end

Game.MapEvtLines:RemoveEvent(5)
evt.map[5] = function()
	if evt.Cmp{"MapVar0", Value = 1} then
		evt.SetDoorState{Id = 5, State = 0}
		evt.SetDoorState{Id = 4, State = 0}
		evt.Set{"MapVar0", Value = 0}
	end
end

evt.hint[6] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(6)
evt.map[6] = function()
	evt.SetDoorState{Id = 10, State = 0}
	evt.SetDoorState{Id = 11, State = 0}
end

evt.hint[7] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(7)
evt.map[7] = function()
	evt.SetDoorState{Id = 12, State = 0}
	evt.SetDoorState{Id = 13, State = 0}
end

evt.hint[8] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(8)
evt.map[8] = function()
	evt.SetDoorState{Id = 14, State = 1}
	evt.SetDoorState{Id = 2, State = 1}
end

evt.hint[9] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(9)
evt.map[9] = function()
	evt.SetDoorState{Id = 1, State = 0}
end

evt.hint[10] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(10)
evt.map[10] = function()
	evt.SetDoorState{Id = 15, State = 0}
	evt.SetDoorState{Id = 16, State = 0}
end

Game.MapEvtLines:RemoveEvent(11)
evt.map[11] = function()
	evt.SetDoorState{Id = 21, State = 0}
	evt.SetDoorState{Id = 22, State = 0}
end

evt.hint[12] = evt.str[12]  -- "Promotion Brazier"
Game.MapEvtLines:RemoveEvent(12)
evt.map[12] = function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if not evt.Cmp{"QBits", Value = 861} then         -- One Use
		evt.StatusText{Str = 20}         -- "Only BDJ can activate this Brazier."
		return
	end
	evt.Subtract{"QBits", Value = 861}         -- One Use
	if evt.Cmp{"QBits", Value = 850} then         -- BDJ Final
		evt.Set{"QBits", Value = 860}         -- Final
		evt.ForPlayer(-- ERROR: Const not found
3)
	else
		if evt.Cmp{"QBits", Value = 849} then         -- BDJ 3
			evt.Set{"QBits", Value = 850}         -- BDJ Final
			evt.ForPlayer(-- ERROR: Const not found
2)
		else
			if evt.Cmp{"QBits", Value = 848} then         -- BDJ 2
				evt.Set{"QBits", Value = 849}         -- BDJ 3
				evt.ForPlayer(-- ERROR: Const not found
1)
			else
				evt.Set{"QBits", Value = 848}         -- BDJ 2
				evt.ForPlayer(-- ERROR: Const not found
0)
			end
		end
	end
	if evt.Cmp{"QBits", Value = 851} then         -- Sorcerer
		evt.Add{"BaseIntellect", Value = 20}
		evt.Set{"ClassIs", Value = const.Class.ArchMage}
		evt.Subtract{"QBits", Value = 851}         -- Sorcerer
	else
		if evt.Cmp{"QBits", Value = 852} then         -- Cleric
			evt.Add{"BasePersonality", Value = 20}
			evt.Set{"ClassIs", Value = const.Class.PriestLight}
			evt.Subtract{"QBits", Value = 852}         -- Cleric
			goto _78
		end
		if evt.Cmp{"QBits", Value = 853} then         -- Fighter
			evt.Add{"BaseEndurance", Value = 15}
			evt.Add{"BaseMight", Value = 5}
			evt.Set{"ClassIs", Value = const.Class.Champion}
			evt.Subtract{"QBits", Value = 853}         -- Fighter
			goto _78
		end
		if evt.Cmp{"QBits", Value = 854} then         -- Paladin
			evt.Add{"BasePersonality", Value = 5}
			evt.Add{"BaseEndurance", Value = 10}
			evt.Add{"BaseMight", Value = 5}
			evt.Set{"ClassIs", Value = const.Class.Hero}
			evt.Subtract{"QBits", Value = 854}         -- Paladin
			goto _78
		end
		if evt.Cmp{"QBits", Value = 855} then         -- Monk
			evt.Add{"BaseEndurance", Value = 10}
			evt.Add{"BaseMight", Value = 10}
			evt.Set{"ClassIs", Value = const.Class.Master}
			evt.Subtract{"QBits", Value = 855}         -- Monk
			goto _78
		end
		if evt.Cmp{"QBits", Value = 856} then         -- Thief
			evt.Add{"BaseLuck", Value = 20}
			evt.Set{"ClassIs", Value = const.Class.Spy}
			evt.Subtract{"QBits", Value = 856}         -- Thief
			goto _78
		end
		if evt.Cmp{"QBits", Value = 857} then         -- Ranger
			evt.Add{"BaseEndurance", Value = 10}
			evt.Add{"BaseMight", Value = 10}
			evt.Set{"ClassIs", Value = const.Class.RangerLord}
			evt.Subtract{"QBits", Value = 857}         -- Ranger
		else
			if evt.Cmp{"QBits", Value = 858} then         -- Archer
				evt.Add{"BaseSpeed", Value = 15}
				evt.Add{"BaseIntellect", Value = 5}
				evt.Set{"ClassIs", Value = const.Class.MasterArcher}
				evt.Subtract{"QBits", Value = 858}         -- Archer
			else
				evt.Add{"BaseIntellect", Value = 10}
				evt.Add{"BasePersonality", Value = 10}
				evt.Set{"ClassIs", Value = const.Class.ArchDruid}
				evt.Subtract{"QBits", Value = 859}         -- Druid
			end
		end
	end
	if not evt.Cmp{"FireSkill", Value = 8} then
		evt.Set{"FireSkill", Value = 72}
	end
::_78::
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if evt.Cmp{"QBits", Value = 860} then         -- Final
		evt.SetNPCTopic{NPC = 1279, Index = 0, Event = 837}         -- "The Coding Wizard" : "Let's Continue."
	else
		evt.StatusText{Str = 21}         -- "Return to the Coding Wizard."
		evt.SetNPCTopic{NPC = 1279, Index = 0, Event = 800}         -- "The Coding Wizard" : "New Profession."
	end
end

evt.hint[13] = evt.str[25]  -- "Might Barrel"
evt.hint[14] = evt.str[26]  -- "Endurance Barrel"
evt.hint[15] = evt.str[27]  -- "Luck Barrel"
evt.hint[16] = evt.str[29]  -- "Intelligence Barrel"
evt.hint[17] = evt.str[30]  -- "Personality Barrel"
evt.hint[18] = evt.str[28]  -- "Accuracy Barrel"
evt.hint[176] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(176)
evt.map[176] = function()
	evt.OpenChest{Id = 1}
end

evt.hint[177] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(177)
evt.map[177] = function()
	evt.OpenChest{Id = 2}
end

evt.hint[178] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(178)
evt.map[178] = function()
	evt.OpenChest{Id = 3}
end

evt.hint[179] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(179)
evt.map[179] = function()
	evt.OpenChest{Id = 4}
end

evt.hint[180] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(180)
evt.map[180] = function()
	evt.OpenChest{Id = 5}
end

evt.hint[181] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(181)
evt.map[181] = function()
	evt.OpenChest{Id = 6}
end

evt.hint[182] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(182)
evt.map[182] = function()
	evt.OpenChest{Id = 7}
end

evt.hint[183] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(183)
evt.map[183] = function()
	evt.OpenChest{Id = 8}
end

evt.hint[184] = evt.str[7]  -- "Cabinet"
Game.MapEvtLines:RemoveEvent(184)
evt.map[184] = function()
	evt.OpenChest{Id = 9}
end

evt.hint[185] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(185)
evt.map[185] = function()
	evt.OpenChest{Id = 10}
end

evt.hint[186] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(186)
evt.map[186] = function()
	evt.OpenChest{Id = 11}
end

evt.hint[187] = evt.str[7]  -- "Cabinet"
Game.MapEvtLines:RemoveEvent(187)
evt.map[187] = function()
	evt.OpenChest{Id = 12}
end

evt.hint[188] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(188)
evt.map[188] = function()
	evt.OpenChest{Id = 13}
end

evt.hint[189] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(189)
evt.map[189] = function()
	evt.OpenChest{Id = 14}
end

evt.hint[190] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(190)
evt.map[190] = function()
	evt.OpenChest{Id = 15}
end

evt.hint[191] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(191)
evt.map[191] = function()
	evt.OpenChest{Id = 16}
end

evt.hint[192] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(192)
evt.map[192] = function()
	evt.OpenChest{Id = 17}
end

evt.hint[193] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(193)
evt.map[193] = function()
	evt.OpenChest{Id = 18}
end

evt.hint[194] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(194)
evt.map[194] = function()
	evt.OpenChest{Id = 19}
end

evt.hint[195] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(195)
evt.map[195] = function()
	evt.OpenChest{Id = 0}
end

evt.hint[196] = evt.str[10]  -- "Bookcase"
Game.MapEvtLines:RemoveEvent(196)
evt.map[196] = function()
	local i
	if evt.Cmp{"MapVar49", Value = 1} then
		return
	end
	i = Game.Rand() % 6
	if i == 3 then
		return
	elseif i == 4 then
		i = Game.Rand() % 6
		if i == 1 then
			evt.Add{"Inventory", Value = 1203}         -- "Fire Bolt"
		elseif i == 2 then
			evt.Add{"Inventory", Value = 1214}         -- "Feather Fall"
		elseif i == 3 then
			evt.Add{"Inventory", Value = 1216}         -- "Sparks"
		elseif i == 4 then
			evt.Add{"Inventory", Value = 1281}         -- "Dispel Magic"
		elseif i == 5 then
			evt.Add{"Inventory", Value = 1269}         -- "Heal"
		end
		goto _14
	elseif i == 5 then
		goto _15
	end
	evt.GiveItem{Strength = 5, Type = const.ItemType.Scroll_, Id = 0}
::_14::
	i = Game.Rand() % 6
	if i == 4 or i == 5 then
		return
	end
::_15::
	evt.Add{"MapVar49", Value = 1}
end

evt.hint[197] = evt.str[10]  -- "Bookcase"
Game.MapEvtLines:RemoveEvent(197)
evt.map[197] = function()
	local i
	if evt.Cmp{"MapVar50", Value = 1} then
		return
	end
	i = Game.Rand() % 6
	if i == 3 then
		return
	elseif i == 4 then
		i = Game.Rand() % 6
		if i == 1 then
			evt.Add{"Inventory", Value = 1203}         -- "Fire Bolt"
		elseif i == 2 then
			evt.Add{"Inventory", Value = 1214}         -- "Feather Fall"
		elseif i == 3 then
			evt.Add{"Inventory", Value = 1216}         -- "Sparks"
		elseif i == 4 then
			evt.Add{"Inventory", Value = 1281}         -- "Dispel Magic"
		elseif i == 5 then
			evt.Add{"Inventory", Value = 1269}         -- "Heal"
		end
		goto _14
	elseif i == 5 then
		goto _15
	end
	evt.GiveItem{Strength = 5, Type = const.ItemType.Scroll_, Id = 0}
::_14::
	i = Game.Rand() % 6
	if i == 4 or i == 5 then
		return
	end
::_15::
	evt.Add{"MapVar50", Value = 1}
end

evt.hint[198] = evt.str[10]  -- "Bookcase"
Game.MapEvtLines:RemoveEvent(198)
evt.map[198] = function()
	local i
	if evt.Cmp{"MapVar51", Value = 1} then
		return
	end
	i = Game.Rand() % 6
	if i == 3 then
		return
	elseif i == 4 then
		i = Game.Rand() % 6
		if i == 1 then
			evt.Add{"Inventory", Value = 1203}         -- "Fire Bolt"
		elseif i == 2 then
			evt.Add{"Inventory", Value = 1214}         -- "Feather Fall"
		elseif i == 3 then
			evt.Add{"Inventory", Value = 1216}         -- "Sparks"
		elseif i == 4 then
			evt.Add{"Inventory", Value = 1281}         -- "Dispel Magic"
		elseif i == 5 then
			evt.Add{"Inventory", Value = 1269}         -- "Heal"
		end
		goto _14
	elseif i == 5 then
		goto _15
	end
	evt.GiveItem{Strength = 5, Type = const.ItemType.Scroll_, Id = 0}
::_14::
	i = Game.Rand() % 6
	if i == 4 or i == 5 then
		return
	end
::_15::
	evt.Add{"MapVar51", Value = 1}
end

evt.hint[199] = evt.str[10]  -- "Bookcase"
Game.MapEvtLines:RemoveEvent(199)
evt.map[199] = function()
	local i
	if evt.Cmp{"MapVar52", Value = 1} then
		return
	end
	i = Game.Rand() % 6
	if i == 3 then
		return
	elseif i == 4 then
		i = Game.Rand() % 6
		if i == 1 then
			evt.Add{"Inventory", Value = 1203}         -- "Fire Bolt"
		elseif i == 2 then
			evt.Add{"Inventory", Value = 1214}         -- "Feather Fall"
		elseif i == 3 then
			evt.Add{"Inventory", Value = 1216}         -- "Sparks"
		elseif i == 4 then
			evt.Add{"Inventory", Value = 1281}         -- "Dispel Magic"
		elseif i == 5 then
			evt.Add{"Inventory", Value = 1269}         -- "Heal"
		end
		goto _14
	elseif i == 5 then
		goto _15
	end
	evt.GiveItem{Strength = 5, Type = const.ItemType.Scroll_, Id = 0}
::_14::
	i = Game.Rand() % 6
	if i == 4 or i == 5 then
		return
	end
::_15::
	evt.Add{"MapVar52", Value = 1}
end

evt.hint[200] = evt.str[10]  -- "Bookcase"
Game.MapEvtLines:RemoveEvent(200)
evt.map[200] = function()
	evt.StatusText{Str = 19}         -- ""
end

evt.hint[376] = evt.str[22]  -- "Summon the Coding Wizard"
Game.MapEvtLines:RemoveEvent(376)
evt.map[376] = function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if not evt.Cmp{"QBits", Value = 862} then         -- Two Use
		evt.SetTexture{Facet = 1, Name = "solid01"}
		evt.SetMonGroupBit{NPCGroup = 60, Bit = const.MonsterBits.Invisible, On = false}         -- "Group for Malwick's Assc."
		evt.SetMonGroupBit{NPCGroup = 60, Bit = const.MonsterBits.Hostile, On = false}         -- "Group for Malwick's Assc."
		evt.SetNPCTopic{NPC = 1279, Index = 0, Event = 798}         -- "The Coding Wizard" : "Greetings from BDJ!"
		evt.SetNPCGreeting{NPC = 1279, Greeting = 138}         --[[ "The Coding Wizard" : "BDJ's the name, Coding Wizard's The Game

Now what can I do for you?" ]]
	end
	evt.Set{"QBits", Value = 862}         -- Two Use
end

evt.hint[451] = evt.str[16]  -- "Take a Drink"
Game.MapEvtLines:RemoveEvent(451)
evt.map[451] = function()
	if not evt.Cmp{"EnduranceBonus", Value = 35} then
		if not evt.Cmp{"BaseEndurance", Value = 35} then
			evt.Set{"PoisonedRed", Value = 0}
			evt.StatusText{Str = 17}         -- "Not Very Refreshing"
			return
		end
	end
	evt.StatusText{Str = 18}         -- "Refreshing"
end

evt.hint[452] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(452)
evt.map[452] = function()
	evt.CastSpell{Spell = 39, Mastery = const.GM, Skill = 15, FromX = 1591, FromY = 2837, FromZ = 400, ToX = -1595, ToY = 2837, ToZ = 400}         -- "Blades"
	evt.CastSpell{Spell = 39, Mastery = const.GM, Skill = 15, FromX = -1595, FromY = 2837, FromZ = 400, ToX = 1591, ToY = 2837, ToZ = 400}         -- "Blades"
end

evt.hint[501] = evt.str[2]  -- "Entrance to Vori"
Game.MapEvtLines:RemoveEvent(501)
evt.map[501] = function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if evt.Cmp{"Inventory", Value = 1578} then         -- "VORI Password"
		evt.Set{"QBits", Value = 875}         -- Eradicated
		evt.Set{"Eradicated", Value = 0}
	else
		evt.StatusText{Str = 9}         -- "You need the pasword to enter Vori."
	end
end

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
end