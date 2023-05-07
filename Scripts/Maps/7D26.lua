local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave the Pit",
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
	[25] = "Castle Gloaming",
	[26] = "Temple of the Dark",
	[27] = "The Breeding Zone",
	[28] = "",
	[29] = "",
	[30] = "Enter Castle Gloaming",
	[31] = "Enter The Temple of the Dark",
	[32] = "Enter the Breeding Zone",
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
	[51] = "srhtfnut",
}
table.copy(TXT, evt.str, true)

-- REMOVED BY REV4 FOR MERGE
-- Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.hint[1] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(1)
evt.map[1] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 805) then         -- Return to NWC
		goto _16
	end
	if not evt.Cmp("QBits", 722) then         -- The Pit - Town Portal
		evt.Add("QBits", 722)         -- The Pit - Town Portal
	end
	if not evt.Cmp("QBits", 612) then         -- Chose the path of Dark
		goto _8
	end
	if evt.Cmp("QBits", 782) then         -- Your friends are mad at you 
		if not evt.Cmp("Counter10", 720) then
			goto _8
		end
		evt.Subtract("QBits", 782)         -- Your friends are mad at you 
		evt.Set("MapVar4", 0)
		goto _16
	end
	if not evt.Cmp("MapVar4", 2) then
		return
	end
::_9::
	evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
	evt.SetMonGroupBit{NPCGroup = 55, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	do return end
::_16::
	evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = false}         -- "Generic Monster Group for Dungeons"
	evt.SetMonGroupBit{NPCGroup = 55, Bit = const.MonsterBits.Hostile, On = false}         -- "Guards"
	do return end
::_8::
	evt.Set("MapVar4", 2)
	goto _9
end

events.LoadMap = evt.map[1].last

evt.hint[176] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(176)
evt.map[176] = function()
	evt.OpenChest(1)
end

evt.hint[177] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(177)
evt.map[177] = function()
	evt.OpenChest(2)
end

evt.hint[178] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(178)
evt.map[178] = function()
	evt.OpenChest(3)
end

evt.hint[179] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(179)
evt.map[179] = function()
	evt.OpenChest(4)
end

evt.hint[180] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(180)
evt.map[180] = function()
	evt.OpenChest(5)
end

evt.hint[181] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(181)
evt.map[181] = function()
	evt.OpenChest(6)
end

evt.hint[182] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(182)
evt.map[182] = function()
	evt.OpenChest(7)
end

evt.hint[183] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(183)
evt.map[183] = function()
	evt.OpenChest(8)
end

evt.hint[184] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(184)
evt.map[184] = function()
	evt.OpenChest(9)
end

evt.hint[185] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(185)
evt.map[185] = function()
	evt.OpenChest(10)
end

evt.hint[186] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(186)
evt.map[186] = function()
	evt.OpenChest(11)
end

evt.hint[187] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(187)
evt.map[187] = function()
	evt.OpenChest(12)
end

evt.hint[188] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(188)
evt.map[188] = function()
	evt.OpenChest(13)
end

evt.hint[189] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(189)
evt.map[189] = function()
	evt.OpenChest(14)
end

evt.hint[190] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(190)
evt.map[190] = function()
	evt.OpenChest(15)
end

evt.hint[191] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(191)
evt.map[191] = function()
	evt.OpenChest(16)
end

evt.hint[192] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(192)
evt.map[192] = function()
	evt.OpenChest(17)
end

evt.hint[193] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(193)
evt.map[193] = function()
	evt.OpenChest(18)
end

evt.hint[194] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(194)
evt.map[194] = function()
	evt.OpenChest(19)
end

evt.hint[195] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(195)
evt.map[195] = function()
	evt.OpenChest(0)
end

evt.house[376] = 1070  -- "Hostel"
Game.MapEvtLines:RemoveEvent(376)
evt.map[376] = function()
	if not evt.Cmp("QBits", 612) then         -- Chose the path of Dark
		if not evt.Cmp("QBits", 814) then         -- Small House only Once
			if evt.Cmp("QBits", 815) then         -- Reward
				evt.MoveToMap{X = -15360, Y = 3808, Z = 129, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 9, Name = "MDT15.blv"}
			elseif evt.Cmp("QBits", 811) then         -- "Clear out the Strange Temple,  retrieve the ancient weapons, and return to Maximus in The Pit"
				evt.MoveToMap{X = 0, Y = 3808, Z = 129, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 9, Name = "MDT15.blv"}
			end
		end
	end
end

evt.hint[415] = evt.str[50]  -- "Obelisk"
Game.MapEvtLines:RemoveEvent(415)
evt.map[415] = function()
	if not evt.Cmp("QBits", 682) then         -- Visited Obelisk in Area 8
		evt.StatusText(51)         -- "srhtfnut"
		evt.Add("AutonotesBits", 315)         -- "Obelisk message #7: srhtfnut"
		evt.ForPlayer("All")
		evt.Add("QBits", 682)         -- Visited Obelisk in Area 8
	end
end

evt.hint[416] = evt.str[9]  -- "House"
Game.MapEvtLines:RemoveEvent(417)
evt.HouseDoor(417, 53)  -- "Shields of Malice"
evt.house[418] = 53  -- "Shields of Malice"
Game.MapEvtLines:RemoveEvent(419)
evt.HouseDoor(419, 13)  -- "Blades of Spite"
evt.house[420] = 13  -- "Blades of Spite"
Game.MapEvtLines:RemoveEvent(421)
evt.HouseDoor(421, 290)  -- "Frozen Assets"
evt.house[422] = 290  -- "Frozen Assets"
Game.MapEvtLines:RemoveEvent(423)
evt.HouseDoor(423, 91)  -- "Eldritch Influences"
evt.house[424] = 91  -- "Eldritch Influences"
Game.MapEvtLines:RemoveEvent(425)
evt.HouseDoor(425, 149)  -- "Paramount Guild of Earth"
evt.house[426] = 149  -- "Paramount Guild of Earth"
Game.MapEvtLines:RemoveEvent(427)
evt.HouseDoor(427, 178)  -- "Guild of Night"
evt.house[428] = 178  -- "Guild of Night"
Game.MapEvtLines:RemoveEvent(429)
evt.HouseDoor(429, 123)  -- "Infernal Temptations"
evt.house[430] = 123  -- "Infernal Temptations"
Game.MapEvtLines:RemoveEvent(431)
evt.HouseDoor(431, 207)  -- "Hall of Midnight"
evt.house[432] = 207  -- "Hall of Midnight"
Game.MapEvtLines:RemoveEvent(433)
evt.HouseDoor(433, 1575)  -- "Perdition's Flame"
evt.house[434] = 1575  -- "Perdition's Flame"
Game.MapEvtLines:RemoveEvent(435)
evt.HouseDoor(435, 246)  -- "The Vampyre Lounge "
evt.house[436] = 246  -- "The Vampyre Lounge "
Game.MapEvtLines:RemoveEvent(438)
evt.HouseDoor(438, 1080)  -- "Hostel"
Game.MapEvtLines:RemoveEvent(439)
evt.HouseDoor(439, 1078)  -- "Hostel"
Game.MapEvtLines:RemoveEvent(440)
evt.HouseDoor(440, 1071)  -- "Hostel"
evt.house[441] = 1079  -- "Hostel"
Game.MapEvtLines:RemoveEvent(441)
evt.map[441] = function()
	if evt.Cmp("QBits", 710) then         -- Archibald in Clankers Lab now
		evt.StatusText(21)         -- "This Door is Locked"
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(1079)         -- "Hostel"
	end
end

Game.MapEvtLines:RemoveEvent(442)
evt.HouseDoor(442, 1072)  -- "House Umberpool"
Game.MapEvtLines:RemoveEvent(443)
evt.HouseDoor(443, 1074)  -- "Sand Residence"
Game.MapEvtLines:RemoveEvent(444)
evt.HouseDoor(444, 1073)  -- "Darkenmore Residence"
Game.MapEvtLines:RemoveEvent(445)
evt.HouseDoor(445, 1075)  -- "Hostel"
Game.MapEvtLines:RemoveEvent(446)
evt.HouseDoor(446, 1081)  -- "Hostel"
Game.MapEvtLines:RemoveEvent(447)
evt.HouseDoor(447, 1076)  -- "Hostel"
Game.MapEvtLines:RemoveEvent(448)
evt.HouseDoor(448, 1077)  -- ""
Game.MapEvtLines:RemoveEvent(452)
evt.map[452] = function()
	evt.MoveToMap{X = -1873, Y = -8516, Z = 64, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

Game.MapEvtLines:RemoveEvent(453)
evt.map[453] = function()
	evt.MoveToMap{X = -1824, Y = -7136, Z = 33, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[454] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(454)
evt.map[454] = function()
	evt.MoveToMap{X = -26354, Y = -10440, Z = 689, Direction = 1664, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[455] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(455)
evt.map[455] = function()
	evt.MoveToMap{X = -2854, Y = -23128, Z = 625, Direction = 541, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[456] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(456)
evt.map[456] = function()
	evt.MoveToMap{X = 6196, Y = -10401, Z = -362, Direction = 832, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[457] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(457)
evt.map[457] = function()
	evt.MoveToMap{X = 9683, Y = -5602, Z = -19, Direction = 1600, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[501] = evt.str[2]  -- "Leave the Pit"
Game.MapEvtLines:RemoveEvent(501)
evt.map[501] = function()
	evt.MoveToMap{X = 498, Y = 16198, Z = 161, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 1, Name = "T04.blv"}
end

Game.MapEvtLines:RemoveEvent(502)
evt.HouseDoor(502, 317)  -- "Temple of Dark"
evt.hint[503] = evt.str[32]  -- "Enter the Breeding Zone"
Game.MapEvtLines:RemoveEvent(503)
evt.map[503] = function()
	evt.MoveToMap{X = -320, Y = -1216, Z = 1, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 2, Name = "7D10.blv"}
end

evt.hint[504] = evt.str[30]  -- "Enter Castle Gloaming"
Game.MapEvtLines:RemoveEvent(504)
evt.map[504] = function()
	evt.MoveToMap{X = 96, Y = 3424, Z = 1, Direction = 1088, LookAngle = 0, SpeedZ = 0, HouseId = 385, Icon = 9, Name = "d03.blv"}         -- "Castle Gloaming"
end

evt.hint[505] = evt.str[30]  -- "Enter Castle Gloaming"
Game.MapEvtLines:RemoveEvent(505)
evt.map[505] = function()
	evt.MoveToMap{X = 874, Y = -261, Z = -377, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 385, Icon = 9, Name = "d03.blv"}         -- "Castle Gloaming"
end



--[[ MMMerge additions ]]--

-- The Pit

function events.AfterLoadMap()
	Party.QBits[723] = true	-- TP Buff The Pit
end
