local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave Stone City",
	[3] = "Chest",
	[4] = "Button",
	[5] = "Lever",
	[6] = "Vault",
	[7] = "Cabinet",
	[8] = "Switch",
	[9] = "House",
	[10] = "Bookcase",
	[11] = "Nothing Here",
	[12] = "Ore Vein",
	[13] = "Cave In !",
	[14] = "You Successfully disarm the trap",
	[15] = "Shirley's Astral Elixir",
	[16] = "Take a Drink",
	[17] = "Not Very Refreshing",
	[18] = "Refreshing",
	[19] = "The Door is Locked",
	[20] = "Enter the Throne Room",
	[21] = "The Chest is Locked",
	[22] = "",
	[23] = "",
	[24] = "",
	[25] = "",
	[26] = "",
	[27] = "",
	[28] = "",
	[29] = "",
	[30] = "",
	[31] = "",
	[32] = "",
	[33] = "",
	[34] = "",
	[35] = "",
	[36] = "",
	[37] = "",
	[38] = "",
	[39] = "",
	[40] = "",
	[41] = "",
	[42] = "",
	[43] = "",
	[44] = "",
	[45] = "",
	[46] = "",
	[47] = "",
	[48] = "",
	[49] = "",
	[50] = "Obelisk",
	[51] = "___d___d",
}
table.copy(TXT, evt.str, true)


evt.hint[1] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(1)
evt.map[1] = function()  -- function events.LoadMap()
	if not evt.Cmp{"QBits", Value = 611} then         -- Chose the path of Light
		evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
	end
end

events.LoadMap = evt.map[1].last

evt.hint[2] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(2)
evt.map[2] = function()  -- function events.LoadMap()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if evt.Cmp{"QBits", Value = 882} then         -- "Obtain Plague Elixir from Lucid Apple in Avlee and deliver it to King Hothffar in Stone City within two days."
		evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Invisible, On = true}         -- "Generic Monster Group for Dungeons"
		evt.Set{"DiseasedRed", Value = 0}
	end
end

events.LoadMap = evt.map[2].last

evt.hint[3] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(3)
evt.map[3] = function()
	evt.SetDoorState{Id = 1, State = 0}
	evt.SetDoorState{Id = 2, State = 0}
end

evt.hint[4] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(4)
evt.map[4] = function()
	evt.SetDoorState{Id = 3, State = 0}
	evt.SetDoorState{Id = 4, State = 0}
end

evt.hint[5] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(5)
evt.map[5] = function()
	evt.SetDoorState{Id = 5, State = 0}
	evt.SetDoorState{Id = 6, State = 0}
end

evt.hint[6] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(6)
evt.map[6] = function()
	evt.SetDoorState{Id = 7, State = 0}
	evt.SetDoorState{Id = 8, State = 0}
end

evt.hint[10] = evt.str[15]  -- "Shirley's Astral Elixir"
Game.MapEvtLines:RemoveEvent(10)
evt.map[10] = function()
	if not evt.Cmp{"QBits", Value = 846} then         -- 1-time stone city
		evt.Set{"QBits", Value = 846}         -- 1-time stone city
		evt.ForPlayer("All").Add("Experience", 0) -- make sparkle sound and animation
		for _, pl in Party do
			local s, m = SplitSkill(pl.Skills[const.Skills.Perception])
			pl.Skills[const.Skills.Perception] = JoinSkill(math.max(s, 6), math.max(m, const.Expert))
		end
	end
end

evt.hint[151] = evt.str[4]  -- "Button"
Game.MapEvtLines:RemoveEvent(151)
evt.map[151] = function()
	evt.SetDoorState{Id = 10, State = 1}
end

evt.hint[152] = evt.str[4]  -- "Button"
Game.MapEvtLines:RemoveEvent(152)
evt.map[152] = function()
	evt.SetDoorState{Id = 10, State = 0}
end

evt.hint[153] = evt.str[4]  -- "Button"
Game.MapEvtLines:RemoveEvent(153)
evt.map[153] = function()
	evt.SetDoorState{Id = 11, State = 1}
end

evt.hint[154] = evt.str[4]  -- "Button"
Game.MapEvtLines:RemoveEvent(154)
evt.map[154] = function()
	evt.SetDoorState{Id = 11, State = 0}
end

evt.hint[176] = evt.str[7]  -- "Cabinet"
Game.MapEvtLines:RemoveEvent(176)
evt.map[176] = function()
	evt.OpenChest{Id = 0}
end

evt.hint[177] = evt.str[7]  -- "Cabinet"
Game.MapEvtLines:RemoveEvent(177)
evt.map[177] = function()
	evt.OpenChest{Id = 1}
end

evt.hint[178] = evt.str[7]  -- "Cabinet"
Game.MapEvtLines:RemoveEvent(178)
evt.map[178] = function()
	evt.OpenChest{Id = 2}
end

evt.hint[179] = evt.str[7]  -- "Cabinet"
Game.MapEvtLines:RemoveEvent(179)
evt.map[179] = function()
	evt.OpenChest{Id = 3}
end

evt.hint[180] = evt.str[7]  -- "Cabinet"
Game.MapEvtLines:RemoveEvent(180)
evt.map[180] = function()
	evt.OpenChest{Id = 4}
end

evt.hint[181] = evt.str[7]  -- "Cabinet"
Game.MapEvtLines:RemoveEvent(181)
evt.map[181] = function()
	evt.OpenChest{Id = 5}
end

evt.hint[182] = evt.str[7]  -- "Cabinet"
Game.MapEvtLines:RemoveEvent(182)
evt.map[182] = function()
	evt.OpenChest{Id = 6}
end

evt.hint[183] = evt.str[7]  -- "Cabinet"
Game.MapEvtLines:RemoveEvent(183)
evt.map[183] = function()
	evt.OpenChest{Id = 7}
end

evt.hint[184] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(184)
evt.map[184] = function()
	evt.OpenChest{Id = 8}
end

evt.hint[185] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(185)
evt.map[185] = function()
	if evt.Cmp{"Awards", Value = 125} then         -- "Proclaimed Friend of Hothfarr, King of Dwarves and Savior of Stone City"
		evt.OpenChest{Id = 9}
	else
		evt.StatusText{Str = 21}         -- "The Chest is Locked"
	end
end

evt.hint[186] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(186)
evt.map[186] = function()
	if evt.Cmp{"Awards", Value = 125} then         -- "Proclaimed Friend of Hothfarr, King of Dwarves and Savior of Stone City"
		evt.OpenChest{Id = 10}
	else
		evt.StatusText{Str = 21}         -- "The Chest is Locked"
	end
end

evt.hint[187] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(187)
evt.map[187] = function()
	evt.OpenChest{Id = 11}
end

evt.hint[188] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(188)
evt.map[188] = function()
	evt.OpenChest{Id = 12}
end

evt.hint[189] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(189)
evt.map[189] = function()
	evt.OpenChest{Id = 13}
end

evt.hint[190] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(190)
evt.map[190] = function()
	evt.OpenChest{Id = 14}
end

evt.hint[191] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(191)
evt.map[191] = function()
	evt.OpenChest{Id = 15}
end

evt.hint[192] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(192)
evt.map[192] = function()
	evt.OpenChest{Id = 16}
end

evt.hint[193] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(193)
evt.map[193] = function()
	evt.OpenChest{Id = 17}
end

evt.hint[194] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(194)
evt.map[194] = function()
	evt.OpenChest{Id = 18}
end

evt.hint[195] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(195)
evt.map[195] = function()
	evt.OpenChest{Id = 19}
end

evt.hint[196] = evt.str[16]  -- "Take a Drink"
Game.MapEvtLines:RemoveEvent(196)
evt.map[196] = function()
	evt.StatusText{Str = 18}         -- "Refreshing"
end

evt.hint[197] = evt.str[16]  -- "Take a Drink"
Game.MapEvtLines:RemoveEvent(197)
evt.map[197] = function()
	evt.StatusText{Str = 18}         -- "Refreshing"
end

evt.hint[198] = evt.str[16]  -- "Take a Drink"
Game.MapEvtLines:RemoveEvent(198)
evt.map[198] = function()
	evt.StatusText{Str = 18}         -- "Refreshing"
end

evt.hint[199] = evt.str[10]  -- "Bookcase"
Game.MapEvtLines:RemoveEvent(199)
evt.map[199] = function()
	evt.StatusText{Str = 11}         -- "Nothing Here"
end

evt.hint[200] = evt.str[12]  -- "Ore Vein"
Game.MapEvtLines:RemoveEvent(200)
evt.map[200] = function()
	local i
	if evt.Cmp{"MapVar14", Value = 1} then
		return
	end
	i = Game.Rand() % 6
	if i == 3 then
		evt.Add{"Inventory", Value = 1489}         -- "Siertal-laced ore"
		goto _9
	elseif i == 4 then
		evt.DamagePlayer{-- ERROR: Const not found
Player = "All", DamageType = const.Damage.Fire, Damage = 50}
		evt.StatusText{Str = 13}         -- "Cave In !"
		goto _8
	elseif i == 5 then
		goto _8
	end
	evt.Add{"Inventory", Value = 1488}         -- "Iron-laced ore"
::_9::
	evt.Set{"MapVar14", Value = 1}
	evt.SetTexture{Facet = 2, Name = "cwb1"}
	do return end
::_8::
	evt.Add{"Inventory", Value = 1490}         -- "Phylt-laced ore"
	goto _9
end

function events.LoadMap()
	if evt.Cmp{"MapVar14", Value = 1} then
		evt.SetTexture{Facet = 2, Name = "cwb1"}
	end
end

evt.hint[201] = evt.str[12]  -- "Ore Vein"
Game.MapEvtLines:RemoveEvent(201)
evt.map[201] = function()
	local i
	if evt.Cmp{"MapVar15", Value = 1} then
		return
	end
	i = Game.Rand() % 6
	if i == 3 then
		evt.Add{"Inventory", Value = 1489}         -- "Siertal-laced ore"
		goto _9
	elseif i == 4 then
		evt.DamagePlayer{-- ERROR: Const not found
Player = "All", DamageType = const.Damage.Fire, Damage = 50}
		evt.StatusText{Str = 13}         -- "Cave In !"
		goto _8
	elseif i == 5 then
		goto _8
	end
	evt.Add{"Inventory", Value = 1488}         -- "Iron-laced ore"
::_9::
	evt.Set{"MapVar15", Value = 1}
	evt.SetTexture{Facet = 3, Name = "cwb1"}
	do return end
::_8::
	evt.Add{"Inventory", Value = 1490}         -- "Phylt-laced ore"
	goto _9
end

function events.LoadMap()
	if evt.Cmp{"MapVar15", Value = 1} then
		evt.SetTexture{Facet = 3, Name = "cwb1"}
	end
end

evt.hint[415] = evt.str[50]  -- "Obelisk"
Game.MapEvtLines:RemoveEvent(415)
evt.map[415] = function()
	if not evt.Cmp{"QBits", Value = 689} then         -- Visited Obelisk in Area 39
		evt.StatusText{Str = 51}         -- "___d___d"
		evt.Add{"AutonotesBits", Value = 322}         -- "Obelisk message #14: ___d___d"
		evt.ForPlayer(-- ERROR: Const not found
"All")
		evt.Add{"QBits", Value = 689}         -- Visited Obelisk in Area 39
	end
end

evt.house[416] = 216  -- "Throne Room"
Game.MapEvtLines:RemoveEvent(416)
evt.map[416] = function()
	if evt.Cmp{"Awards", Value = 3} then         -- "Cleared out Castle Harmondale"
		evt.EnterHouse{Id = 216}         -- "Throne Room"
	else
		evt.FaceAnimation{-- ERROR: Const not found
Player = "Current", Animation = 18}
		evt.StatusText{Str = 19}         -- "The Door is Locked"
	end
end

evt.house[417] = 17  -- "The Balanced Axe"
Game.MapEvtLines:RemoveEvent(417)
evt.map[417] = function()
	evt.EnterHouse{Id = 17}         -- "The Balanced Axe"
end

evt.house[418] = 17  -- "The Balanced Axe"
Game.MapEvtLines:RemoveEvent(418)
evt.map[418] = function()
end

evt.house[419] = 57  -- "The Polished Pauldron"
Game.MapEvtLines:RemoveEvent(419)
evt.map[419] = function()
	evt.EnterHouse{Id = 57}         -- "The Polished Pauldron"
end

evt.house[420] = 57  -- "The Polished Pauldron"
Game.MapEvtLines:RemoveEvent(420)
evt.map[420] = function()
end

evt.house[421] = 93  -- "Delicate Things"
Game.MapEvtLines:RemoveEvent(421)
evt.map[421] = function()
	evt.EnterHouse{Id = 93}         -- "Delicate Things"
end

evt.house[422] = 93  -- "Delicate Things"
Game.MapEvtLines:RemoveEvent(422)
evt.map[422] = function()
end

evt.house[423] = 124  -- "Potent Potions & Brews"
Game.MapEvtLines:RemoveEvent(423)
evt.map[423] = function()
	evt.EnterHouse{Id = 124}         -- "Potent Potions & Brews"
end

evt.house[424] = 124  -- "Potent Potions & Brews"
Game.MapEvtLines:RemoveEvent(424)
evt.map[424] = function()
end

evt.house[425] = 321  -- "Temple of Stone"
Game.MapEvtLines:RemoveEvent(425)
evt.map[425] = function()
	evt.EnterHouse{Id = 321}         -- "Temple of Stone"
end

evt.house[426] = 321  -- "Temple of Stone"
Game.MapEvtLines:RemoveEvent(426)
evt.map[426] = function()
end

evt.house[427] = 1579  -- "War College"
Game.MapEvtLines:RemoveEvent(427)
evt.map[427] = function()
	evt.EnterHouse{Id = 1579}         -- "War College"
end

evt.house[428] = 1579  -- "War College"
Game.MapEvtLines:RemoveEvent(428)
evt.map[428] = function()
end

evt.house[429] = 252  -- "Grogg's Grog"
Game.MapEvtLines:RemoveEvent(429)
evt.map[429] = function()
	evt.EnterHouse{Id = 252}         -- "Grogg's Grog"
end

evt.house[430] = 252  -- "Grogg's Grog"
Game.MapEvtLines:RemoveEvent(430)
evt.map[430] = function()
end

evt.house[431] = 293  -- "Mineral Wealth"
Game.MapEvtLines:RemoveEvent(431)
evt.map[431] = function()
	evt.EnterHouse{Id = 293}         -- "Mineral Wealth"
end

evt.house[432] = 293  -- "Mineral Wealth"
Game.MapEvtLines:RemoveEvent(432)
evt.map[432] = function()
end

evt.house[433] = 148  -- "Master Guild of Earth"
Game.MapEvtLines:RemoveEvent(433)
evt.map[433] = function()
	evt.EnterHouse{Id = 148}         -- "Master Guild of Earth"
end

evt.house[434] = 148  -- "Master Guild of Earth"
Game.MapEvtLines:RemoveEvent(434)
evt.map[434] = function()
end

evt.house[435] = 1051  -- "Keenedge Residence"
Game.MapEvtLines:RemoveEvent(435)
evt.map[435] = function()
	evt.EnterHouse{Id = 1051}         -- "Keenedge Residence"
end

evt.house[436] = 1052  -- "Seline's House"
Game.MapEvtLines:RemoveEvent(436)
evt.map[436] = function()
	evt.EnterHouse{Id = 1052}         -- "Seline's House"
end

evt.house[437] = 1053  -- "Welman Residence"
Game.MapEvtLines:RemoveEvent(437)
evt.map[437] = function()
	evt.EnterHouse{Id = 1053}         -- "Welman Residence"
end

evt.house[438] = 1054  -- "Thain's House"
Game.MapEvtLines:RemoveEvent(438)
evt.map[438] = function()
	evt.EnterHouse{Id = 1054}         -- "Thain's House"
end

evt.house[439] = 1055  -- "Gizmo's"
Game.MapEvtLines:RemoveEvent(439)
evt.map[439] = function()
	evt.EnterHouse{Id = 1055}         -- "Gizmo's"
end

evt.house[440] = 1056  -- "Spark's House"
Game.MapEvtLines:RemoveEvent(440)
evt.map[440] = function()
	evt.EnterHouse{Id = 1056}         -- "Spark's House"
end

evt.house[441] = 1057  -- "Thorinson Residence"
Game.MapEvtLines:RemoveEvent(441)
evt.map[441] = function()
	evt.EnterHouse{Id = 1057}         -- "Thorinson Residence"
end

evt.house[442] = 1058  -- "Urthsmite Residence"
Game.MapEvtLines:RemoveEvent(442)
evt.map[442] = function()
	evt.EnterHouse{Id = 1058}         -- "Urthsmite Residence"
end

evt.house[443] = 216  -- "Throne Room"
Game.MapEvtLines:RemoveEvent(443)
evt.map[443] = function()
	evt.EnterHouse{Id = 216}         -- "Throne Room"
end

evt.hint[444] = evt.str[9]  -- "House"
evt.hint[451] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(451)
evt.map[451] = function()
	if not evt.Cmp{"Invisible", Value = 0} then
		if not evt.Cmp{"MapVar4", Value = 1} then
			evt.SpeakNPC{NPC = 780}         -- "Guard"
			evt.Set{"MapVar4", Value = 1}
		end
	end
end

evt.hint[452] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(452)
evt.map[452] = function()
	if not evt.Cmp{"Invisible", Value = 0} then
		if not evt.Cmp{"MapVar4", Value = 2} then
			evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
			evt.SetMonGroupBit{NPCGroup = 55, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
			evt.Set{"MapVar4", Value = 2}
		end
	end
end

evt.hint[453] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(453)
evt.map[453] = function()
	if not evt.Cmp{"Invisible", Value = 0} then
		if not evt.Cmp{"MapVar4", Value = 2} then
			evt.Set{"MapVar4", Value = 0}
		end
	end
end

evt.hint[501] = evt.str[2]  -- "Leave Stone City"
Game.MapEvtLines:RemoveEvent(501)
evt.map[501] = function()
	evt.MoveToMap{X = -2384, Y = 3064, Z = 2091, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "Out11.odm"}
end

evt.hint[502] = evt.str[2]  -- "Leave Stone City"
Game.MapEvtLines:RemoveEvent(502)
evt.map[502] = function()
	evt.MoveToMap{X = 522, Y = -808, Z = 1, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 3, Name = "7D35.blv"}
end

