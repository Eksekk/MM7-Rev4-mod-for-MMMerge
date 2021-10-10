local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave the Lincoln",
	[3] = "Chest",
	[4] = "Button",
	[5] = "Lever",
	[6] = "Vault",
	[7] = "Cabinet",
	[8] = "Switch",
	[9] = "",
	[10] = "Bookcase",
	[11] = "Power Restored",
	[12] = "",
	[13] = "",
	[14] = "You Successfully disarm the trap",
	[15] = "",
	[16] = "Take a Drink",
	[17] = "Not Very Refreshing",
	[18] = "Refreshing",
	[19] = "",
	[20] = "You must all be wearing your wetsuits to exit the ship",
}
table.copy(TXT, evt.str, true)

-- ERROR: Duplicate label: 153:0

Game.MapEvtLines:RemoveEvent(1)
evt.map[1] = function()  -- function events.LoadMap()
	evt.Set{"MapVar0", Value = 2}
	evt.Set{"MapVar1", Value = 2}
	evt.SetLight{Id = 1, On = false}
	evt.SetLight{Id = 2, On = false}
end

events.LoadMap = evt.map[1].last

Game.MapEvtLines:RemoveEvent(3)
evt.map[3] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 10, State = 0}
		evt.SetDoorState{Id = 11, State = 0}
	end
end

Game.MapEvtLines:RemoveEvent(4)
evt.map[4] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 10, State = 1}
		evt.SetDoorState{Id = 11, State = 1}
	end
end

Game.MapEvtLines:RemoveEvent(6)
evt.map[6] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 12, State = 0}
		evt.SetDoorState{Id = 13, State = 0}
	end
end

Game.MapEvtLines:RemoveEvent(7)
evt.map[7] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 12, State = 1}
		evt.SetDoorState{Id = 13, State = 1}
	end
end

Game.MapEvtLines:RemoveEvent(8)
evt.map[8] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 15, State = 2}         -- switch state
		evt.SetDoorState{Id = 16, State = 2}         -- switch state
	end
end

Game.MapEvtLines:RemoveEvent(9)
evt.map[9] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 15, State = 1}
		evt.SetDoorState{Id = 16, State = 1}
	end
end

Game.MapEvtLines:RemoveEvent(10)
evt.map[10] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 19, State = 0}
		evt.SetDoorState{Id = 20, State = 0}
	end
end

Game.MapEvtLines:RemoveEvent(11)
evt.map[11] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 23, State = 0}
	end
end

Game.MapEvtLines:RemoveEvent(12)
evt.map[12] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 23, State = 1}
	end
end

Game.MapEvtLines:RemoveEvent(13)
evt.map[13] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 24, State = 0}
		evt.SetDoorState{Id = 25, State = 0}
	end
end

Game.MapEvtLines:RemoveEvent(14)
evt.map[14] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 24, State = 1}
		evt.SetDoorState{Id = 25, State = 1}
	end
end

Game.MapEvtLines:RemoveEvent(15)
evt.map[15] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 26, State = 0}
	end
end

Game.MapEvtLines:RemoveEvent(16)
evt.map[16] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 26, State = 1}
	end
end

Game.MapEvtLines:RemoveEvent(17)
evt.map[17] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 27, State = 0}
	end
end

Game.MapEvtLines:RemoveEvent(18)
evt.map[18] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 28, State = 1}
		evt.SetDoorState{Id = 37, State = 1}
		evt.SetDoorState{Id = 27, State = 0}
	end
end

Game.MapEvtLines:RemoveEvent(19)
evt.map[19] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 28, State = 0}
	end
end

Game.MapEvtLines:RemoveEvent(20)
evt.map[20] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 27, State = 1}
		evt.SetDoorState{Id = 37, State = 0}
		evt.SetDoorState{Id = 28, State = 0}
	end
end

Game.MapEvtLines:RemoveEvent(21)
evt.map[21] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 29, State = 0}
		evt.SetDoorState{Id = 30, State = 0}
	end
end

Game.MapEvtLines:RemoveEvent(22)
evt.map[22] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 29, State = 1}
		evt.SetDoorState{Id = 30, State = 1}
	end
end

Game.MapEvtLines:RemoveEvent(23)
evt.map[23] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 31, State = 0}
		evt.SetDoorState{Id = 32, State = 0}
	end
end

Game.MapEvtLines:RemoveEvent(24)
evt.map[24] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 31, State = 1}
		evt.SetDoorState{Id = 32, State = 1}
	end
end

Game.MapEvtLines:RemoveEvent(25)
evt.map[25] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 33, State = 0}
		evt.SetDoorState{Id = 34, State = 0}
	end
end

Game.MapEvtLines:RemoveEvent(26)
evt.map[26] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 33, State = 1}
		evt.SetDoorState{Id = 34, State = 1}
	end
end

Game.MapEvtLines:RemoveEvent(27)
evt.map[27] = function()
	evt.SetDoorState{Id = 35, State = 0}
	evt.SetDoorState{Id = 36, State = 0}
end

Game.MapEvtLines:RemoveEvent(28)
evt.map[28] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 35, State = 1}
		evt.SetDoorState{Id = 36, State = 1}
	end
end

Game.MapEvtLines:RemoveEvent(29)
evt.map[29] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 37, State = 2}         -- switch state
	end
end

Game.MapEvtLines:RemoveEvent(30)
evt.map[30] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 39, State = 0}
		evt.SetDoorState{Id = 40, State = 0}
	end
end

Game.MapEvtLines:RemoveEvent(31)
evt.map[31] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 39, State = 1}
		evt.SetDoorState{Id = 40, State = 1}
	end
end

Game.MapEvtLines:RemoveEvent(32)
evt.map[32] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 45, State = 0}
		evt.SetDoorState{Id = 46, State = 0}
	end
end

Game.MapEvtLines:RemoveEvent(33)
evt.map[33] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 45, State = 1}
		evt.SetDoorState{Id = 46, State = 1}
	end
end

Game.MapEvtLines:RemoveEvent(34)
evt.map[34] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 48, State = 0}
		evt.SetDoorState{Id = 49, State = 0}
		evt.SetDoorState{Id = 47, State = 1}
	end
end

Game.MapEvtLines:RemoveEvent(35)
evt.map[35] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 48, State = 1}
		evt.SetDoorState{Id = 49, State = 1}
	end
end

Game.MapEvtLines:RemoveEvent(36)
evt.map[36] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 51, State = 0}
	end
end

Game.MapEvtLines:RemoveEvent(37)
evt.map[37] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 51, State = 0}
	end
end

Game.MapEvtLines:RemoveEvent(38)
evt.map[38] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 59, State = 0}
	end
end

Game.MapEvtLines:RemoveEvent(39)
evt.map[39] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 59, State = 1}
	end
end

Game.MapEvtLines:RemoveEvent(40)
evt.map[40] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 60, State = 0}
	end
end

Game.MapEvtLines:RemoveEvent(41)
evt.map[41] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 60, State = 1}
	end
end

Game.MapEvtLines:RemoveEvent(42)
evt.map[42] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 61, State = 0}
		evt.SetDoorState{Id = 62, State = 0}
	end
end

Game.MapEvtLines:RemoveEvent(43)
evt.map[43] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 61, State = 1}
		evt.SetDoorState{Id = 62, State = 1}
	end
end

Game.MapEvtLines:RemoveEvent(44)
evt.map[44] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 63, State = 0}
		evt.SetDoorState{Id = 64, State = 0}
	end
end

Game.MapEvtLines:RemoveEvent(45)
evt.map[45] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 63, State = 1}
		evt.SetDoorState{Id = 64, State = 1}
	end
end

Game.MapEvtLines:RemoveEvent(46)
evt.map[46] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 65, State = 0}
		evt.SetDoorState{Id = 66, State = 0}
	end
end

Game.MapEvtLines:RemoveEvent(47)
evt.map[47] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 65, State = 1}
		evt.SetDoorState{Id = 66, State = 1}
	end
end

Game.MapEvtLines:RemoveEvent(49)
evt.map[49] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 67, State = 0}
		evt.SetDoorState{Id = 68, State = 0}
	end
end

Game.MapEvtLines:RemoveEvent(50)
evt.map[50] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 67, State = 1}
		evt.SetDoorState{Id = 68, State = 1}
	end
end

Game.MapEvtLines:RemoveEvent(51)
evt.map[51] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 73, State = 0}
		evt.SetDoorState{Id = 74, State = 0}
	end
end

Game.MapEvtLines:RemoveEvent(52)
evt.map[52] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 75, State = 0}
		evt.SetDoorState{Id = 76, State = 0}
	end
end

Game.MapEvtLines:RemoveEvent(53)
evt.map[53] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 69, State = 0}
		evt.SetDoorState{Id = 70, State = 0}
	end
end

Game.MapEvtLines:RemoveEvent(54)
evt.map[54] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 71, State = 0}
		evt.SetDoorState{Id = 72, State = 0}
	end
end

Game.MapEvtLines:RemoveEvent(55)
evt.map[55] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 69, State = 1}
		evt.SetDoorState{Id = 70, State = 1}
		evt.SetDoorState{Id = 73, State = 1}
		evt.SetDoorState{Id = 74, State = 1}
	end
end

Game.MapEvtLines:RemoveEvent(56)
evt.map[56] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 71, State = 1}
		evt.SetDoorState{Id = 72, State = 1}
		evt.SetDoorState{Id = 75, State = 1}
		evt.SetDoorState{Id = 76, State = 1}
	end
end

Game.MapEvtLines:RemoveEvent(151)
evt.map[151] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		if evt.Cmp{"MapVar0", Value = 2} then
			evt.SetDoorState{Id = 9, State = 1}
			evt.SetDoorState{Id = 38, State = 1}
			evt.Set{"MapVar0", Value = 1}
		else
			evt.SetDoorState{Id = 9, State = 0}
			evt.SetDoorState{Id = 38, State = 0}
			evt.Set{"MapVar0", Value = 2}
		end
	end
end

Game.MapEvtLines:RemoveEvent(152)
evt.map[152] = function()
	evt.SetDoorState{Id = 17, State = 2}         -- switch state
end

Game.MapEvtLines:RemoveEvent(153)
evt.map[153] = function()
	evt.SetDoorState{Id = 18, State = 2}         -- switch state
end

Game.MapEvtLines:RemoveEvent(154)
evt.map[154] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 47, State = 0}
		evt.SetDoorState{Id = 48, State = 1}
		evt.SetDoorState{Id = 49, State = 1}
	end
end

Game.MapEvtLines:RemoveEvent(155)
evt.map[155] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 50, State = 1}
		evt.SetDoorState{Id = 51, State = 1}
	end
end

Game.MapEvtLines:RemoveEvent(156)
evt.map[156] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 50, State = 0}
		evt.SetDoorState{Id = 26, State = 1}
	end
end

Game.MapEvtLines:RemoveEvent(157)
evt.map[157] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 77, State = 0}
	end
end

Game.MapEvtLines:RemoveEvent(158)
evt.map[158] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 78, State = 0}
	end
end

Game.MapEvtLines:RemoveEvent(159)
evt.map[159] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 79, State = 0}
	end
end

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

evt.hint[376] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(376)
evt.map[376] = function()
	if not evt.Cmp{"QBits", Value = 633} then         -- Got the sci-fi part
		if not evt.Cmp{"MapVar2", Value = 1} then
			return
		end
		if not evt.Cmp{"Inventory", Value = 1407} then         -- "Oscillation Overthruster"
			evt.Add{"Inventory", Value = 1407}         -- "Oscillation Overthruster"
			evt.Set{"QBits", Value = 633}         -- Got the sci-fi part
			evt.Add{"QBits", Value = 748}         -- Final Part - I lost it
			evt.SetDoorState{Id = 80, State = 1}
			evt.Set{"MapVar3", Value = 1}
		end
	end
	evt.SetLight{Id = 1, On = false}
	evt.SetLight{Id = 2, On = true}
end

Game.MapEvtLines:RemoveEvent(451)
evt.map[451] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 1, State = 2}         -- switch state
		evt.SetDoorState{Id = 5, State = 2}         -- switch state
	end
end

Game.MapEvtLines:RemoveEvent(452)
evt.map[452] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 2, State = 2}         -- switch state
		evt.SetDoorState{Id = 6, State = 2}         -- switch state
	end
end

Game.MapEvtLines:RemoveEvent(453)
evt.map[453] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 3, State = 2}         -- switch state
		evt.SetDoorState{Id = 7, State = 2}         -- switch state
	end
end

Game.MapEvtLines:RemoveEvent(454)
evt.map[454] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 4, State = 2}         -- switch state
		evt.SetDoorState{Id = 8, State = 2}         -- switch state
	end
end

Game.MapEvtLines:RemoveEvent(455)
evt.map[455] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 14, State = 2}         -- switch state
	end
end

Game.MapEvtLines:RemoveEvent(456)
evt.map[456] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 44, State = 2}         -- switch state
	end
end

Game.MapEvtLines:RemoveEvent(457)
evt.map[457] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.MoveToMap{X = 7165, Y = -1629, Z = 1037, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	end
end

Game.MapEvtLines:RemoveEvent(458)
evt.map[458] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.MoveToMap{X = 1536, Y = -1909, Z = 1037, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	end
end

Game.MapEvtLines:RemoveEvent(459)
evt.map[459] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 52, State = 0}
	end
end

Game.MapEvtLines:RemoveEvent(460)
evt.map[460] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 52, State = 1}
	end
end

Game.MapEvtLines:RemoveEvent(461)
evt.map[461] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 53, State = 0}
	end
end

Game.MapEvtLines:RemoveEvent(462)
evt.map[462] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 53, State = 1}
	end
end

Game.MapEvtLines:RemoveEvent(463)
evt.map[463] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 54, State = 0}
	end
end

Game.MapEvtLines:RemoveEvent(464)
evt.map[464] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 54, State = 1}
	end
end

Game.MapEvtLines:RemoveEvent(465)
evt.map[465] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 55, State = 0}
	end
end

Game.MapEvtLines:RemoveEvent(466)
evt.map[466] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 55, State = 1}
	end
end

Game.MapEvtLines:RemoveEvent(467)
evt.map[467] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 56, State = 0}
	end
end

Game.MapEvtLines:RemoveEvent(468)
evt.map[468] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 56, State = 1}
	end
end

Game.MapEvtLines:RemoveEvent(469)
evt.map[469] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 57, State = 0}
	end
end

Game.MapEvtLines:RemoveEvent(470)
evt.map[470] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 57, State = 1}
	end
end

Game.MapEvtLines:RemoveEvent(471)
evt.map[471] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 58, State = 0}
	end
end

Game.MapEvtLines:RemoveEvent(472)
evt.map[472] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 58, State = 1}
	end
end

Game.MapEvtLines:RemoveEvent(473)
evt.map[473] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 50, State = 1}
		evt.SetDoorState{Id = 47, State = 0}
		evt.SetDoorState{Id = 26, State = 0}
	end
end

Game.MapEvtLines:RemoveEvent(474)
evt.map[474] = function()
	if evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 50, State = 0}
		evt.SetDoorState{Id = 51, State = 0}
	end
end

Game.MapEvtLines:RemoveEvent(475)
evt.map[475] = function()
	if not evt.Cmp{"MapVar2", Value = 1} then
		evt.Set{"MapVar2", Value = 1}
		evt.SetLight{Id = 1, On = true}
		evt.SetTexture{Facet = 15, Name = "sfpnlon"}
		evt.StatusText{Str = 11}         -- "Power Restored"
	end
end

Game.MapEvtLines:RemoveEvent(476)
evt.map[476] = function()  -- Timer(<function>, 2*const.Minute)
	if evt.Cmp{"MapVar3", Value = 1} then
		evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 20, FromX = 4448, FromY = -9376, FromZ = 2272, ToX = 0, ToY = 0, ToZ = 0}         -- "Sparks"
		evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 20, FromX = 2816, FromY = -8480, FromZ = 1792, ToX = 0, ToY = 0, ToZ = 0}         -- "Sparks"
		evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 20, FromX = 3104, FromY = -5600, FromZ = 1888, ToX = 0, ToY = 0, ToZ = 0}         -- "Sparks"
		evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 20, FromX = 3104, FromY = -1888, FromZ = 320, ToX = 0, ToY = 0, ToZ = 0}         -- "Sparks"
	end
end

Timer(evt.map[476].last, 2*const.Minute)

Game.MapEvtLines:RemoveEvent(477)
evt.map[477] = function()  -- Timer(<function>, 1*const.Minute)
	if evt.Cmp{"MapVar3", Value = 1} then
		evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 20, FromX = 224, FromY = 1376, FromZ = 992, ToX = 0, ToY = 0, ToZ = 0}         -- "Sparks"
		evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 20, FromX = 5856, FromY = -8512, FromZ = 1792, ToX = 0, ToY = 0, ToZ = 0}         -- "Sparks"
		evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 20, FromX = 5600, FromY = -5664, FromZ = 1888, ToX = 0, ToY = 0, ToZ = 0}         -- "Sparks"
		evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 20, FromX = 4896, FromY = -3808, FromZ = 1888, ToX = 0, ToY = 0, ToZ = 0}         -- "Sparks"
		evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 20, FromX = 3104, FromY = -3680, FromZ = 320, ToX = 0, ToY = 0, ToZ = 0}         -- "Sparks"
		evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 20, FromX = 512, FromY = -736, FromZ = 992, ToX = 0, ToY = 0, ToZ = 0}         -- "Sparks"
		evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 20, FromX = 512, FromY = 1344, FromZ = 992, ToX = 0, ToY = 0, ToZ = 0}         -- "Sparks"
	end
end

Timer(evt.map[477].last, 1*const.Minute)




--[[ MMMerge additions ]]--


evt.SetMonGroupBit {56,  const.MonsterBits.Hostile,  false}
evt.SetMonGroupBit {56,  const.MonsterBits.Invisible, true}

Game.MapEvtLines:RemoveEvent(501)
evt.hint[501] = evt.str[2]
evt.map[501] = function()

	for i,v in Party do
		if v.ItemArmor == 0 or v.Items[v.ItemArmor].Number ~= 1406 then
			if not evt[i].Cmp{"Inventory", 1406} then
				Game.ShowStatusText(evt.str[20])
				return
			end
		end
	end

	evt.MoveToMap{-7005, 7856, 225, 128, 0, 0, 0, 8, "7out15.odm"}

end
