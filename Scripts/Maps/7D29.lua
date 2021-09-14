local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave Castle Harmondale",
	[3] = "Chest",
	[4] = "Button",
	[5] = "Lever",
	[6] = "Vault",
	[7] = "Cabinet",
	[8] = "Switch",
	[9] = "Strange Torch",
	[10] = "Bookcase",
	[11] = "Arnold's Super Protein Drink",
	[12] = "Phasing Cauldron",
	[13] = "Elemental Totem",
	[14] = "You Successfully disarm the trap",
	[15] = "",
	[16] = "Take a Drink",
	[17] = "Not Very Refreshing",
	[18] = "Refreshing",
	[19] = "",
	[20] = "Enter the Throne Room",
	[21] = "The door is blocked",
	[22] = "This cabinet requires a Blue Dragon's Key.",
}
table.copy(TXT, evt.str, true)


Game.MapEvtLines:RemoveEvent(1)
evt.map[1] = function()  -- function events.LoadMap()
	if evt.Cmp{"QBits", Value = 610} then         -- Built Castle to Level 2 (rescued dwarf guy)
		evt.SetDoorState{Id = 35, State = 0}
		evt.SetSprite{SpriteId = 10, Visible = 0, Name = "0"}
		evt.SetTexture{Facet = 4, Name = "tfb09r1a"}
		evt.SetTexture{Facet = 5, Name = "tfb09r1b"}
		evt.SetTexture{Facet = 6, Name = "tfb09r1c"}
		evt.SetTexture{Facet = 7, Name = "tfb09r1d"}
		evt.SetTexture{Facet = 8, Name = "tfb09r1e"}
		evt.SetTexture{Facet = 9, Name = "tfb09r1f"}
		evt.SetTexture{Facet = 10, Name = "tfb09r1g"}
		evt.SetTexture{Facet = 11, Name = "tfb09r1h"}
		evt.SetTexture{Facet = 12, Name = "tfb09r1i"}
		evt.SetTexture{Facet = 13, Name = "tfb09r1j"}
	else
		evt.SetTexture{Facet = 1, Name = "ch1b1"}
		evt.SetTexture{Facet = 3, Name = "ch1b1"}
		evt.SetTexture{Facet = 14, Name = "ch1b1el"}
		evt.SetTexture{Facet = 15, Name = "ch1b1er"}
		evt.SetTexture{Facet = 16, Name = "ch1b1"}
		evt.SetTexture{Facet = 17, Name = "ch1b1"}
		evt.SetTexture{Facet = 19, Name = "ch1b1"}
		evt.SetTexture{Facet = 20, Name = "ch1b1"}
	end
	if evt.Cmp{"QBits", Value = 614} then         -- Completed Proving Grounds without killing a single creature
		evt.SetTexture{Facet = 19, Name = "wizh-a"}
		evt.SetTexture{Facet = 20, Name = "wizh-b"}
	else
		if not evt.Cmp{"QBits", Value = 641} then         -- Completed Breeding Pit.
			return
		end
		evt.SetTexture{Facet = 19, Name = "nechuma"}
		evt.SetTexture{Facet = 20, Name = "nechumb"}
	end
	evt.SetDoorState{Id = 36, State = 0}
	evt.SetFacetBit{Id = 3, Bit = const.FacetBits.Invisible, On = false}
end

events.LoadMap = evt.map[1].last

Game.MapEvtLines:RemoveEvent(2)
evt.map[2] = function()  -- function events.LeaveMap()
	if not evt.Cmp{"QBits", Value = 647} then         -- Player castle goblins are all dead
		if evt.CheckMonstersKilled{CheckType = 1, Id = 56, Count = 0} then
			evt.ForPlayer(-- ERROR: Const not found
"All")
			evt.Set{"QBits", Value = 647}         -- Player castle goblins are all dead
		end
	end
end

events.LeaveMap = evt.map[2].last

evt.hint[3] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(3)
evt.map[3] = function()
	evt.SetDoorState{Id = 3, State = 0}
end

evt.hint[4] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(4)
evt.map[4] = function()
	evt.SetDoorState{Id = 4, State = 0}
end

evt.hint[5] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(5)
evt.map[5] = function()
	evt.SetDoorState{Id = 5, State = 0}
end

evt.hint[6] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(6)
evt.map[6] = function()
	evt.SetDoorState{Id = 6, State = 0}
end

evt.hint[7] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(7)
evt.map[7] = function()
	evt.SetDoorState{Id = 7, State = 0}
end

evt.hint[8] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(8)
evt.map[8] = function()
	evt.SetDoorState{Id = 8, State = 0}
end

evt.hint[9] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(9)
evt.map[9] = function()
	evt.SetDoorState{Id = 9, State = 0}
end

evt.hint[10] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(10)
evt.map[10] = function()
	evt.SetDoorState{Id = 10, State = 1}
end

evt.hint[11] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(11)
evt.map[11] = function()
	evt.SetDoorState{Id = 11, State = 0}
end

evt.hint[12] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(12)
evt.map[12] = function()
	evt.SetDoorState{Id = 12, State = 0}
end

evt.hint[13] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(13)
evt.map[13] = function()
	evt.SetDoorState{Id = 13, State = 0}
end

evt.hint[14] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(14)
evt.map[14] = function()
	evt.SetDoorState{Id = 14, State = 0}
end

Game.MapEvtLines:RemoveEvent(15)
evt.map[15] = function()
	if not evt.Cmp{"QBits", Value = 614} then         -- Completed Proving Grounds without killing a single creature
		if not evt.Cmp{"QBits", Value = 641} then         -- Completed Breeding Pit.
			return
		end
	end
	evt.SetDoorState{Id = 15, State = 0}
end

Game.MapEvtLines:RemoveEvent(16)
evt.map[16] = function()
	if not evt.Cmp{"QBits", Value = 614} then         -- Completed Proving Grounds without killing a single creature
		if not evt.Cmp{"QBits", Value = 641} then         -- Completed Breeding Pit.
			return
		end
	end
	evt.SetDoorState{Id = 16, State = 0}
end

Game.MapEvtLines:RemoveEvent(17)
evt.map[17] = function()
	evt.SetDoorState{Id = 17, State = 0}
end

evt.hint[18] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(18)
evt.map[18] = function()
	evt.SetDoorState{Id = 18, State = 0}
	evt.SetDoorState{Id = 19, State = 0}
end

evt.hint[19] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(19)
evt.map[19] = function()
	evt.SetDoorState{Id = 20, State = 0}
	evt.SetDoorState{Id = 21, State = 0}
end

evt.hint[20] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(20)
evt.map[20] = function()
	evt.SetDoorState{Id = 22, State = 0}
end

evt.hint[21] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(21)
evt.map[21] = function()
	evt.SetDoorState{Id = 23, State = 0}
end

evt.hint[22] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(22)
evt.map[22] = function()
	evt.SetDoorState{Id = 24, State = 0}
end

evt.hint[23] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(23)
evt.map[23] = function()
	evt.SetDoorState{Id = 25, State = 0}
end

evt.hint[24] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(24)
evt.map[24] = function()
	evt.SetDoorState{Id = 26, State = 0}
end

evt.hint[25] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(25)
evt.map[25] = function()
	evt.SetDoorState{Id = 27, State = 0}
end

Game.MapEvtLines:RemoveEvent(26)
evt.map[26] = function()
	evt.SetDoorState{Id = 28, State = 0}
end

evt.hint[27] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(27)
evt.map[27] = function()
	evt.SetDoorState{Id = 29, State = 0}
end

evt.hint[28] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(28)
evt.map[28] = function()
	evt.SetDoorState{Id = 30, State = 0}
end

evt.hint[29] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(29)
evt.map[29] = function()
	evt.SetDoorState{Id = 31, State = 0}
end

evt.hint[30] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(30)
evt.map[30] = function()
	evt.SetDoorState{Id = 32, State = 0}
end

evt.hint[31] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(31)
evt.map[31] = function()
	evt.SetDoorState{Id = 33, State = 0}
end

evt.hint[32] = evt.str[10]  -- "Bookcase"
Game.MapEvtLines:RemoveEvent(32)
evt.map[32] = function()
	evt.SetDoorState{Id = 34, State = 0}
end

evt.hint[33] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(33)
evt.map[33] = function()
	evt.SetDoorState{Id = 1, State = 0}
end

evt.hint[34] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(34)
evt.map[34] = function()
	evt.SetDoorState{Id = 2, State = 0}
end

evt.hint[35] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(35)
evt.map[35] = function()  -- function events.LoadMap()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if not evt.Cmp{"QBits", Value = 883} then         -- Dwarven Messenger Once
		if evt.Cmp{"Awards", Value = 120} then         -- "Completed Coding Wizard Quest"
			evt.SetNPCGreeting{NPC = 366, Greeting = 142}         -- "Messenger" : ""
			evt.SpeakNPC{NPC = 366}         -- "Messenger"
			evt.Set{"QBits", Value = 881}         -- "Raise the siege of Stone City by killing all creatures in the Barrow Downs within one week and then proceed to King Hothffar for your reward."
			evt.Set{"QBits", Value = 883}         -- Dwarven Messenger Once
			evt.Subtract{"QBits", Value = 880}         -- Barrow Normal
			evt.Set{"Counter2", Value = 0}
		end
	end
end

events.LoadMap = evt.map[35].last

evt.hint[37] = evt.str[11]  -- "Arnold's Super Protein Drink"
Game.MapEvtLines:RemoveEvent(37)
evt.map[37] = function()
	if not evt.Cmp{"QBits", Value = 829} then         -- 1-time Castle Harm
		evt.Set{"QBits", Value = 829}         -- 1-time Castle Harm
		evt.All.Add("Experience", 0)
		for _, pl in Party do
			local s, m = SplitSkill(pl.Skills[const.Skills.Bodybuilding])
			pl.Skills[const.Skills.Bodybuilding] = JoinSkill(math.max(s, 7), math.max(m, const.Expert))
		end
	end
end

evt.hint[38] = evt.str[9]  -- "Strange Torch"
Game.MapEvtLines:RemoveEvent(38)
evt.map[38] = function()
	evt.MoveToMap{X = -2015, Y = 2870, Z = 1152, Direction = 524, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[39] = evt.str[9]  -- "Strange Torch"
Game.MapEvtLines:RemoveEvent(39)
evt.map[39] = function()
	evt.MoveToMap{X = -12372, Y = -1047, Z = 0, Direction = 2047, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[40] = evt.str[12]  -- "Phasing Cauldron"
Game.MapEvtLines:RemoveEvent(40)
evt.map[40] = function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if not evt.Cmp{"QBits", Value = 830} then         -- 1-time phasing cauldron
		evt.Set{"QBits", Value = 830}         -- 1-time phasing cauldron
		evt.Add{"FireResistance", Value = 20}
		evt.Add{"AirResistance", Value = 20}
		evt.Add{"WaterResistance", Value = 20}
		evt.Add{"EarthResistance", Value = 20}
	end
end

evt.hint[41] = evt.str[13]  -- "Elemental Totem"
Game.MapEvtLines:RemoveEvent(41)
evt.map[41] = function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if not evt.Cmp{"QBits", Value = 835} then         -- Dancing Flame
		evt.Set{"QBits", Value = 835}         -- Dancing Flame
		evt.Add{"FireResistance", Value = 10}
		evt.Add{"AirResistance", Value = 10}
		evt.Add{"WaterResistance", Value = 10}
		evt.Add{"EarthResistance", Value = 10}
	end
	evt.SetSprite{SpriteId = 13, Visible = 1, Name = "sp57"}
end

evt.hint[50] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(50)
evt.map[50] = function()  -- function events.LoadMap()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if evt.Cmp{"QBits", Value = 835} then         -- Dancing Flame
		evt.SetSprite{SpriteId = 13, Visible = 1, Name = "sp57"}
	end
end

events.LoadMap = evt.map[50].last

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

evt.hint[182] = evt.str[7]  -- "Cabinet"
Game.MapEvtLines:RemoveEvent(182)
evt.map[182] = function()
	evt.OpenChest{Id = 7}
end

evt.hint[183] = evt.str[7]  -- "Cabinet"
Game.MapEvtLines:RemoveEvent(183)
evt.map[183] = function()
	evt.OpenChest{Id = 8}
end

evt.hint[184] = evt.str[7]  -- "Cabinet"
Game.MapEvtLines:RemoveEvent(184)
evt.map[184] = function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if evt.Cmp{"Inventory", Value = 964} then         -- "Blue Dragon's Key"
		evt.OpenChest{Id = 9}
	else
		evt.StatusText{Str = 22}         -- "This cabinet requires a Blue Dragon's Key."
	end
end

evt.hint[185] = evt.str[7]  -- "Cabinet"
Game.MapEvtLines:RemoveEvent(185)
evt.map[185] = function()
	evt.OpenChest{Id = 10}
end

evt.hint[186] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(186)
evt.map[186] = function()
	evt.OpenChest{Id = 11}
end

evt.hint[187] = evt.str[3]  -- "Chest"
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
	if not evt.Cmp{"QBits", Value = 657} then         -- Membership to the School of Sorcery Scroll Shop
		return
	end
	if evt.Cmp{"MapVar2", Value = 3} then
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
		goto _16
	elseif i == 5 then
		goto _17
	end
	evt.GiveItem{Strength = 5, Type = const.ItemType.Scroll_, Id = 0}
::_16::
	i = Game.Rand() % 6
	if i == 4 or i == 5 then
		return
	end
::_17::
	evt.Add{"MapVar2", Value = 1}
end

evt.hint[197] = evt.str[10]  -- "Bookcase"
Game.MapEvtLines:RemoveEvent(197)
evt.map[197] = function()
	if not evt.Cmp{"MapVar1", Value = 1} then
		evt.Add{"Inventory", Value = 1505}         -- "Basic Cryptography"
		evt.Set{"MapVar1", Value = 1}
	end
end

evt.hint[198] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(198)
evt.map[198] = function()  -- function events.LoadMap()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if evt.Cmp{"QBits", Value = 885} then         -- Harm no respawn
		evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Invisible, On = true}         -- "Generic Monster Group for Dungeons"
	end
end

events.LoadMap = evt.map[198].last

evt.hint[376] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(376)
evt.map[376] = function()  -- function events.LoadMap()
	if evt.Cmp{"QBits", Value = 585} then         -- Finished constructing Golem with Abbey normal head
		evt.SetMonGroupBit{NPCGroup = 57, Bit = const.MonsterBits.Hostile, On = true}         -- "Group for M1"
		goto _5
	end
	if evt.Cmp{"QBits", Value = 586} then         -- Finished constructing Golem with normal head
		goto _5
	end
::_7::
	evt.ForPlayer(-- ERROR: Const not found
"Current")
	if not evt.Cmp{"QBits", Value = 2102} then         -- "Promoted to Crusader"
		if not evt.Cmp{"QBits", Value = 2103} then         -- "Promoted to Honorary Crusader"
			return
		end
	end
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if evt.Cmp{"QBits", Value = 612} then         -- Chose the path of Dark
		evt.SetMonGroupBit{NPCGroup = 56, -- ERROR: Const not found
Bit = 0x0, On = false}         -- "Generic Monster Group for Dungeons"
	end
	do return end
::_5::
	evt.Subtract{"NPCs", Value = 395}         -- "Golem"
	evt.SetMonGroupBit{NPCGroup = 57, Bit = const.MonsterBits.Invisible, On = false}         -- "Group for M1"
	goto _7
end

events.LoadMap = evt.map[376].last

evt.hint[377] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(377)
evt.map[377] = function()  -- function events.LoadMap()
	if not evt.Cmp{"QBits", Value = 526} then         -- Accepted Fireball wand from Malwick
		return
	end
	if evt.Cmp{"QBits", Value = 702} then         -- Finished with Malwick & Assc.
		return
	end
	if evt.Cmp{"QBits", Value = 695} then         -- Failed either goto or do guild quest
		goto _14
	end
	if not evt.Cmp{"QBits", Value = 694} then         -- "Steal the Tapestry from your associate's Castle and return it to Niles Stantley in the Mercenary Guild in Tatalia."
		if not evt.Cmp{"QBits", Value = 693} then         -- "Go to the Mercenary Guild in Tatalia and talk to Niles Stantley within two weeks."
			return
		end
		if not evt.Cmp{"Counter5", Value = 336} then
			return
		end
	else
		if not evt.Cmp{"Counter5", Value = 672} then
			return
		end
	end
	evt.ForPlayer(-- ERROR: Const not found
"All")
	evt.Add{"QBits", Value = 695}         -- Failed either goto or do guild quest
::_14::
	evt.SetMonGroupBit{NPCGroup = 60, Bit = const.MonsterBits.Hostile, On = true}         -- "Group for Malwick's Assc."
	evt.SetMonGroupBit{NPCGroup = 60, Bit = const.MonsterBits.Invisible, On = false}         -- "Group for Malwick's Assc."
	evt.Set{"BankGold", Value = 0}
	evt.Subtract{"QBits", Value = 693}         -- "Go to the Mercenary Guild in Tatalia and talk to Niles Stantley within two weeks."
	evt.Subtract{"QBits", Value = 694}         -- "Steal the Tapestry from your associate's Castle and return it to Niles Stantley in the Mercenary Guild in Tatalia."
end

events.LoadMap = evt.map[377].last

evt.hint[378] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(378)
evt.map[378] = function()  -- Timer(<function>, 10*const.Minute)
	if evt.Cmp{"QBits", Value = 695} then         -- Failed either goto or do guild quest
		if not evt.Cmp{"QBits", Value = 696} then         -- Killed all castle monsters
			if evt.CheckMonstersKilled{CheckType = 1, Id = 60, Count = 0} then
				evt.ForPlayer(-- ERROR: Const not found
"All")
				evt.Add{"QBits", Value = 696}         -- Killed all castle monsters
				if evt.Cmp{"QBits", Value = 697} then         -- Killed all outdoor monsters
					evt.ForPlayer(-- ERROR: Const not found
"All")
					evt.Add{"QBits", Value = 702}         -- Finished with Malwick & Assc.
					evt.Subtract{"QBits", Value = 695}         -- Failed either goto or do guild quest
				end
			end
		end
	end
end

Timer(evt.map[378].last, 10*const.Minute)

evt.house[416] = 380  -- ""
Game.MapEvtLines:RemoveEvent(416)
evt.map[416] = function()
	if not evt.Cmp{"QBits", Value = 610} then         -- Built Castle to Level 2 (rescued dwarf guy)
		evt.EnterHouse{Id = 380}         -- ""
		return
	end
	if not evt.Cmp{"QBits", Value = 614} then         -- Completed Proving Grounds without killing a single creature
		if not evt.Cmp{"QBits", Value = 641} then         -- Completed Breeding Pit.
			evt.EnterHouse{Id = 381}         -- ""
			return
		end
	end
	evt.EnterHouse{Id = 322}         -- "Sanctuary"
end

evt.house[417] = 380  -- ""
Game.MapEvtLines:RemoveEvent(417)
evt.map[417] = function()
	if not evt.Cmp{"QBits", Value = 610} then         -- Built Castle to Level 2 (rescued dwarf guy)
		evt.EnterHouse{Id = 380}         -- ""
		return
	end
	if not evt.Cmp{"QBits", Value = 614} then         -- Completed Proving Grounds without killing a single creature
		if not evt.Cmp{"QBits", Value = 641} then         -- Completed Breeding Pit.
			evt.EnterHouse{Id = 381}         -- ""
			return
		end
	end
	evt.EnterHouse{Id = 125}         -- "Beakers and Bottles"
end

evt.house[418] = 380  -- ""
Game.MapEvtLines:RemoveEvent(418)
evt.map[418] = function()
	if not evt.Cmp{"QBits", Value = 610} then         -- Built Castle to Level 2 (rescued dwarf guy)
		evt.EnterHouse{Id = 380}         -- ""
		return
	end
	if not evt.Cmp{"QBits", Value = 614} then         -- Completed Proving Grounds without killing a single creature
		if not evt.Cmp{"QBits", Value = 641} then         -- Completed Breeding Pit.
			evt.EnterHouse{Id = 381}         -- ""
			return
		end
	end
	evt.EnterHouse{Id = 58}         -- "Thel's Armor and Shields"
end

evt.house[419] = 380  -- ""
Game.MapEvtLines:RemoveEvent(419)
evt.map[419] = function()
	if not evt.Cmp{"QBits", Value = 610} then         -- Built Castle to Level 2 (rescued dwarf guy)
		evt.EnterHouse{Id = 380}         -- ""
		return
	end
	if not evt.Cmp{"QBits", Value = 614} then         -- Completed Proving Grounds without killing a single creature
		if not evt.Cmp{"QBits", Value = 641} then         -- Completed Breeding Pit.
			evt.EnterHouse{Id = 381}         -- ""
			return
		end
	end
	evt.EnterHouse{Id = 18}         -- "Swords Inc."
end

evt.house[420] = 1169  -- "Throne Room"
Game.MapEvtLines:RemoveEvent(420)
evt.map[420] = function()
	if evt.Cmp{"QBits", Value = 610} then         -- Built Castle to Level 2 (rescued dwarf guy)
		evt.EnterHouse{Id = 1169}         -- "Throne Room"
	else
		evt.StatusText{Str = 21}         -- "The door is blocked"
	end
end

evt.hint[451] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(451)
evt.map[451] = function()  -- function events.LoadMap()
	if evt.Cmp{"QBits", Value = 592} then         -- Gave plans to elfking
		if evt.Cmp{"QBits", Value = 593} then         -- Gave Loren to Catherine
			goto _13
		end
		if not evt.Cmp{"QBits", Value = 597} then         -- Gave artifact to elves
			if not evt.Cmp{"QBits", Value = 595} then         -- Gave false Loren to Catherine (betray)
				return
			end
		end
		goto _20
	end
	if evt.Cmp{"QBits", Value = 594} then         -- Gave false plans to elfking (betray)
		if not evt.Cmp{"QBits", Value = 595} then         -- Gave false Loren to Catherine (betray)
			return
		end
		goto _13
	end
	if not evt.Cmp{"QBits", Value = 595} then         -- Gave false Loren to Catherine (betray)
		return
	end
	if evt.Cmp{"QBits", Value = 597} then         -- Gave artifact to elves
		goto _20
	end
::_16::
	evt.SetTexture{Facet = 16, Name = "chb1p6"}
	evt.SetTexture{Facet = 17, Name = "chb1p7"}
	evt.Add{"QBits", Value = 783}         -- "Find the Blessed Panoply of Sir BunGleau."
	do return end
::_13::
	if evt.Cmp{"QBits", Value = 659} then         -- Gave artifact to arbiter
		evt.SetTexture{Facet = 16, Name = "bannwc-a"}
		evt.SetTexture{Facet = 17, Name = "bannwc-b"}
		return
	end
	if not evt.Cmp{"QBits", Value = 596} then         -- Gave artifact to humans
		if evt.Cmp{"QBits", Value = 597} then         -- Gave artifact to elves
			goto _20
		end
	end
	goto _16
::_20::
	evt.SetTexture{Facet = 16, Name = "elfhuma"}
	evt.SetTexture{Facet = 17, Name = "elfhumb"}
	evt.Add{"QBits", Value = 783}         -- "Find the Blessed Panoply of Sir BunGleau."
end

events.LoadMap = evt.map[451].last

evt.hint[501] = evt.str[2]  -- "Leave Castle Harmondale"
Game.MapEvtLines:RemoveEvent(501)
evt.map[501] = function()
	if evt.CheckMonstersKilled{CheckType = 1, Id = 56, Count = 0} then
		evt.ForPlayer(-- ERROR: Const not found
"All")
		evt.Set{"QBits", Value = 647}         -- Player castle goblins are all dead
		evt.SetMonGroupBit{NPCGroup = 61, Bit = const.MonsterBits.Invisible, On = false}         -- "Southern Village Group in Harmondy"
		evt.MoveToMap{X = -18325, Y = 12564, Z = 480, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "7out02.odm"}
	else
		evt.MoveToMap{X = -18325, Y = 12564, Z = 480, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "7out02.odm"}
	end
end



--[[ MMMerge additions --]]


-- Golem quest (wizard first promotion) (mm7)

evt.Map[376] = function()
	if Party.QBits[585] or Party.QBits[586] then
		NPCFollowers.Remove(395)
	end
end-- Golem join part is in StdQuestsFollowers.lua

-- Rest cost

function events.CalcRestFoodCost(t)
	if Party.QBits[610] then
		t.Amount = 0
	end
end

--

function events.LeaveMap()
	if Party.QBits[695] and evt.CheckMonstersKilled{1, 60, 0, 6} then
		Party.QBits[696] = true
		Party.QBits[702] = Party.QBits[696] and Party.QBits[697]
		Party.QBits[695] = not Party.QBits[702]
	end
end

Game.MapEvtLines:RemoveEvent(377)
function events.LoadMap()
	if Party.QBits[526] and Party.QBits[695] and not (Party.QBits[696] or Party.QBits[702]) then
		evt.SetMonGroupBit{60, const.MonsterBits.Hostile, true}
		evt.SetMonGroupBit{60, const.MonsterBits.Invisible, false}
		evt.Set{"BankGold", 0}
		evt.Subtract {"QBits", 693}
		evt.Subtract {"QBits", 694}
	else
		evt.SetMonGroupBit{60, const.MonsterBits.Hostile, false}
		evt.SetMonGroupBit{60, const.MonsterBits.Invisible, true}
	end
end

