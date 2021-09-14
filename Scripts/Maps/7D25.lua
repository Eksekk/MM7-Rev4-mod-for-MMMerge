local TXT = Localize{
	[0] = " ",
	[1] = "",
	[2] = "Leave Celeste",
	[3] = "Chest",
	[4] = "Button",
	[5] = "Lever",
	[6] = "Vault",
	[7] = "Cabinet",
	[8] = "Switch",
	[9] = "House",
	[10] = "Bookcase",
	[11] = "",
	[12] = "",
	[13] = "",
	[14] = "You Successfully disarm the trap",
	[15] = "",
	[16] = "Take a Drink",
	[17] = "Not Very Refreshing",
	[18] = "Refreshing",
	[19] = "",
	[20] = "",
	[21] = "This Door is Locked",
	[22] = "",
	[23] = "",
	[24] = "",
	[25] = "Castle Lambent",
	[26] = "Temple of the Light",
	[27] = "Walls of Mist",
	[28] = "",
	[29] = "",
	[30] = "Enter Castle Lambent",
	[31] = "Enter The Temple of the Light",
	[32] = "Enter the Walls of Mist",
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
	[51] = "eut__i_n",
	[52] = "",
	[53] = "",
	[54] = "",
	[55] = "",
	[56] = "",
	[57] = "",
	[58] = "",
	[59] = "",
	[60] = "",
	[61] = "",
	[62] = "",
	[63] = "",
	[64] = "",
	[65] = "",
	[66] = "",
	[67] = "",
	[68] = "",
	[69] = "",
	[70] = "+25 to all Stats(Temporary)",
}
table.copy(TXT, evt.str, true)


evt.hint[1] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(1)
evt.map[1] = function()  -- function events.LoadMap()
	evt.Add{"QBits", Value = 721}         -- Celeste - Town Portal
	if evt.Cmp{"QBits", Value = 805} then         -- Return to NWC
		goto _15
	end
	if not evt.Cmp{"QBits", Value = 611} then         -- Chose the path of Light
		goto _7
	end
	if evt.Cmp{"QBits", Value = 782} then         -- Your friends are mad at you 
		if not evt.Cmp{"Counter10", Value = 720} then
			goto _7
		end
		evt.Subtract{"QBits", Value = 782}         -- Your friends are mad at you 
		evt.Set{"MapVar4", Value = 0}
		goto _15
	end
	if not evt.Cmp{"MapVar4", Value = 2} then
		return
	end
::_8::
	evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
	evt.SetMonGroupBit{NPCGroup = 55, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	do return end
::_15::
	evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = false}         -- "Generic Monster Group for Dungeons"
	evt.SetMonGroupBit{NPCGroup = 55, Bit = const.MonsterBits.Hostile, On = false}         -- "Guards"
	do return end
::_7::
	evt.Set{"MapVar4", Value = 2}
	goto _8
end

events.LoadMap = evt.map[1].last

evt.hint[2] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(2)
evt.map[2] = function()  -- function events.LoadMap()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if not evt.Cmp{"QBits", Value = 837} then         -- Resurectra
		if evt.Cmp{"BlasterSkill", Value = 1} then
			evt.Set{"QBits", Value = 837}         -- Resurectra
			evt.SetNPCGreeting{NPC = 358, Greeting = 136}         --[[ "Resurectra" : "Ah, our Heroes have returned!  Excellent accomplishment!  Erathia will always be in your debt.

However, we still have work to do in order to triumph in our endeavors.  After you have healed and rested, see Robert the Wise for you next assignment.  He can be found in the Hostel across the way from Sir Caneghem." ]]
			evt.SpeakNPC{NPC = 358}         -- "Resurectra"
			evt.MoveNPC{NPC = 422, HouseId = 1065}         -- "Robert the Wise" -> "Hostel"
			evt.SetNPCTopic{NPC = 422, Index = 0, Event = 947}         -- "Robert the Wise" : "Control Cube"
		end
	end
end

events.LoadMap = evt.map[2].last

Game.MapEvtLines:RemoveEvent(3)
evt.map[3] = function()
	evt.SetDoorState{Id = 5, State = 2}         -- switch state
end

Game.MapEvtLines:RemoveEvent(4)
evt.map[4] = function()
	evt.SetDoorState{Id = 1, State = 2}         -- switch state
	evt.SetDoorState{Id = 2, State = 2}         -- switch state
end

Game.MapEvtLines:RemoveEvent(5)
evt.map[5] = function()
	evt.SetDoorState{Id = 3, State = 2}         -- switch state
	evt.SetDoorState{Id = 4, State = 2}         -- switch state
end

evt.hint[6] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(6)
evt.map[6] = function()  -- function events.LoadMap()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if evt.Cmp{"QBits", Value = 617} then         -- Slayed Xenofex
		evt.ForPlayer(-- ERROR: Const not found
"All")
		evt.SetNPCTopic{NPC = 419, Index = 1, Event = 883}         -- "Resurectra" : "Most Excellent!!"
	end
end

events.LoadMap = evt.map[6].last

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

evt.hint[184] = evt.str[3]  -- "Chest"
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

evt.house[376] = 1065  -- "Hostel"
Game.MapEvtLines:RemoveEvent(376)
evt.map[376] = function()
	evt.EnterHouse{Id = 1065}         -- "Hostel"
end

evt.hint[377] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(377)
evt.map[377] = function()  -- function events.LoadMap()
	if evt.Cmp{"QBits", Value = 533} then         -- "Go to the Celestial Court in Celeste and kill Lady Eleanor Carmine.  Return with proof to Seknit Undershadow in the Deyja Moors."
		evt.SetMonGroupBit{NPCGroup = 52, Bit = const.MonsterBits.Invisible, On = false}         -- ""
		evt.SetMonGroupBit{NPCGroup = 52, Bit = const.MonsterBits.Hostile, On = true}         -- ""
		evt.Set{"MapVar0", Value = 1}
	end
end

events.LoadMap = evt.map[377].last

evt.hint[378] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(378)
evt.map[378] = function()  -- function events.LeaveMap()
	if evt.Cmp{"MapVar0", Value = 1} then
		if evt.CheckMonstersKilled{CheckType = 1, Id = 52, Count = 0} then
			evt.Set{"QBits", Value = 725}         -- Dagger - I lost it
		end
	end
end

events.LeaveMap = evt.map[378].last

evt.hint[415] = evt.str[50]  -- "Obelisk"
Game.MapEvtLines:RemoveEvent(415)
evt.map[415] = function()
	if not evt.Cmp{"QBits", Value = 681} then         -- Visited Obelisk in Area 7
		evt.StatusText{Str = 51}         -- "eut__i_n"
		evt.Add{"AutonotesBits", Value = 314}         -- "Obelisk message #6: eut__i_n"
		evt.Add{"QBits", Value = 681}         -- Visited Obelisk in Area 7
	end
end

evt.hint[416] = evt.str[9]  -- "House"
evt.house[417] = 1059  -- "House Devine"
Game.MapEvtLines:RemoveEvent(417)
evt.map[417] = function()
	evt.EnterHouse{Id = 1059}         -- "House Devine"
end

evt.house[418] = 1060  -- "Morningstar Residence"
Game.MapEvtLines:RemoveEvent(418)
evt.map[418] = function()
	evt.EnterHouse{Id = 1060}         -- "Morningstar Residence"
end

evt.house[419] = 1061  -- "House Winterbright"
Game.MapEvtLines:RemoveEvent(419)
evt.map[419] = function()
	evt.EnterHouse{Id = 1061}         -- "House Winterbright"
end

evt.house[420] = 1062  -- "Hostel"
Game.MapEvtLines:RemoveEvent(420)
evt.map[420] = function()
	if evt.Cmp{"QBits", Value = 631} then         -- Killed Evil MM3 Person
		evt.StatusText{Str = 21}         -- "This Door is Locked"
		evt.FaceAnimation{-- ERROR: Const not found
Player = "Current", Animation = 18}
	else
		evt.EnterHouse{Id = 1062}         -- "Hostel"
	end
end

evt.house[421] = 1063  -- "Hostel"
Game.MapEvtLines:RemoveEvent(421)
evt.map[421] = function()
	evt.EnterHouse{Id = 1063}         -- "Hostel"
end

evt.house[422] = 1064  -- "Hostel"
Game.MapEvtLines:RemoveEvent(422)
evt.map[422] = function()
	evt.EnterHouse{Id = 1064}         -- "Hostel"
end

evt.house[423] = 1067  -- "Ramiez Residence"
Game.MapEvtLines:RemoveEvent(423)
evt.map[423] = function()
	evt.EnterHouse{Id = 1067}         -- "Ramiez Residence"
end

evt.house[424] = 1066  -- "Tarent Residence"
Game.MapEvtLines:RemoveEvent(424)
evt.map[424] = function()
	evt.EnterHouse{Id = 1066}         -- "Tarent Residence"
end

evt.house[426] = 1068  -- "Hostel"
Game.MapEvtLines:RemoveEvent(426)
evt.map[426] = function()
	evt.EnterHouse{Id = 1068}         -- "Hostel"
end

evt.house[427] = 1069  -- "Hostel"
Game.MapEvtLines:RemoveEvent(427)
evt.map[427] = function()
	evt.EnterHouse{Id = 1069}         -- "Hostel"
end

evt.house[428] = 12  -- "The Hallowed Sword"
Game.MapEvtLines:RemoveEvent(428)
evt.map[428] = function()
end

evt.house[429] = 12  -- "The Hallowed Sword"
Game.MapEvtLines:RemoveEvent(429)
evt.map[429] = function()
	evt.EnterHouse{Id = 12}         -- "The Hallowed Sword"
end

evt.house[430] = 52  -- "Armor of Honor"
Game.MapEvtLines:RemoveEvent(430)
evt.map[430] = function()
end

evt.house[431] = 52  -- "Armor of Honor"
Game.MapEvtLines:RemoveEvent(431)
evt.map[431] = function()
	evt.EnterHouse{Id = 52}         -- "Armor of Honor"
end

evt.house[432] = 1574  -- "Trial of Honor"
Game.MapEvtLines:RemoveEvent(432)
evt.map[432] = function()
end

evt.house[433] = 1574  -- "Trial of Honor"
Game.MapEvtLines:RemoveEvent(433)
evt.map[433] = function()
	evt.EnterHouse{Id = 1574}         -- "Trial of Honor"
end

evt.house[434] = 245  -- "The Blessed Brew"
Game.MapEvtLines:RemoveEvent(434)
evt.map[434] = function()
end

evt.house[435] = 245  -- "The Blessed Brew"
Game.MapEvtLines:RemoveEvent(435)
evt.map[435] = function()
	evt.EnterHouse{Id = 245}         -- "The Blessed Brew"
end

evt.house[436] = 289  -- "Material Wealth"
Game.MapEvtLines:RemoveEvent(436)
evt.map[436] = function()
end

evt.house[437] = 289  -- "Material Wealth"
Game.MapEvtLines:RemoveEvent(437)
evt.map[437] = function()
	evt.EnterHouse{Id = 289}         -- "Material Wealth"
end

evt.house[438] = 122  -- "Phials of Faith"
Game.MapEvtLines:RemoveEvent(438)
evt.map[438] = function()
end

evt.house[439] = 122  -- "Phials of Faith"
Game.MapEvtLines:RemoveEvent(439)
evt.map[439] = function()
	evt.EnterHouse{Id = 122}         -- "Phials of Faith"
end

evt.house[440] = 137  -- "Paramount Guild of Air"
Game.MapEvtLines:RemoveEvent(440)
evt.map[440] = function()
end

evt.house[441] = 137  -- "Paramount Guild of Air"
Game.MapEvtLines:RemoveEvent(441)
evt.map[441] = function()
	evt.EnterHouse{Id = 137}         -- "Paramount Guild of Air"
end

evt.house[442] = 172  -- "Guild of Enlightenment"
Game.MapEvtLines:RemoveEvent(442)
evt.map[442] = function()
end

evt.house[443] = 172  -- "Guild of Enlightenment"
Game.MapEvtLines:RemoveEvent(443)
evt.map[443] = function()
	evt.EnterHouse{Id = 172}         -- "Guild of Enlightenment"
end

evt.house[444] = 90  -- "Esoteric Indulgences"
Game.MapEvtLines:RemoveEvent(444)
evt.map[444] = function()
end

evt.house[445] = 90  -- "Esoteric Indulgences"
Game.MapEvtLines:RemoveEvent(445)
evt.map[445] = function()
	evt.EnterHouse{Id = 90}         -- "Esoteric Indulgences"
end

evt.house[446] = 206  -- "Hall of Dawn"
Game.MapEvtLines:RemoveEvent(446)
evt.map[446] = function()
end

evt.house[447] = 206  -- "Hall of Dawn"
Game.MapEvtLines:RemoveEvent(447)
evt.map[447] = function()
	evt.EnterHouse{Id = 206}         -- "Hall of Dawn"
end

evt.hint[451] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(451)
evt.map[451] = function()
	local i
	i = Game.Rand() % 6
	if i == 1 then
		goto _6
	elseif i == 2 then
		goto _2
	elseif i == 3 then
		goto _3
	elseif i == 4 then
		goto _4
	elseif i == 5 then
		goto _5
	end
	evt.MoveToMap{X = 8146, Y = 4379, Z = 3700, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
::_2::
	evt.MoveToMap{X = -2815, Y = 1288, Z = 3700, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "7out06.odm"}
::_3::
	evt.MoveToMap{X = -11883, Y = 8667, Z = 3700, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "7out06.odm"}
::_4::
	evt.MoveToMap{X = -22231, Y = 13145, Z = 3700, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "7out06.odm"}
::_5::
	evt.MoveToMap{X = -12770, Y = 18344, Z = 3700, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "7out06.odm"}
::_6::
	evt.MoveToMap{X = 9185, Y = 18564, Z = 3700, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "7out06.odm"}
end

evt.hint[452] = evt.str[16]  -- "Take a Drink"
Game.MapEvtLines:RemoveEvent(452)
evt.map[452] = function()
	if not evt.Cmp{"PlayerBits", Value = 30} then
		evt.Add{"MightBonus", Value = 25}
		evt.Add{"IntellectBonus", Value = 25}
		evt.Add{"PersonalityBonus", Value = 25}
		evt.Add{"EnduranceBonus", Value = 25}
		evt.Add{"AccuracyBonus", Value = 25}
		evt.Add{"SpeedBonus", Value = 25}
		evt.Add{"LuckBonus", Value = 25}
		evt.StatusText{Str = 70}         -- "+25 to all Stats(Temporary)"
		evt.Add{"PlayerBits", Value = 30}
	end
end

Timer(function()
	evt.Subtract{"PlayerBits", Value = 30}
end, const.Day, 1*const.Hour)

evt.hint[501] = evt.str[2]  -- "Leave Celeste"
Game.MapEvtLines:RemoveEvent(501)
evt.map[501] = function()
	evt.MoveToMap{X = -9718, Y = 10097, Z = 2449, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "7out06.odm"}
end

evt.hint[502] = evt.str[32]  -- "Enter the Walls of Mist"
Game.MapEvtLines:RemoveEvent(502)
evt.map[502] = function()
	evt.MoveToMap{X = -896, Y = -4717, Z = 161, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 400, Icon = 9, Name = "7D11.blv"}         -- "Walls of Mist"
end

evt.hint[503] = evt.str[30]  -- "Enter Castle Lambent"
Game.MapEvtLines:RemoveEvent(503)
evt.map[503] = function()
	evt.MoveToMap{X = 64, Y = -640, Z = 1, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 386, Icon = 9, Name = "7D30.blv"}         -- "Castle Lambent"
end

evt.house[504] = 316  -- "Temple of Light"
Game.MapEvtLines:RemoveEvent(504)
evt.map[504] = function()
	evt.EnterHouse{Id = 316}         -- "Temple of Light"
end



--[[ MMMerge additions --]]


function events.AfterLoadMap()
	if Party.QBits[612] then
		evt.SetMonGroupBit{57, const.MonsterBits.Hostile, true}
		evt.SetMonGroupBit{56, const.MonsterBits.Hostile, true}
		evt.SetMonGroupBit{55, const.MonsterBits.Hostile, true}
	end
end
