local TXT = Localize{
	[0] = " ",
	[1] = "Chest ",
	[2] = "Barrel",
	[3] = "Well",
	[4] = "Drink from the Well",
	[5] = "Fountain",
	[6] = "Drink from the Fountain",
	[7] = "House",
	[8] = "The entrance has been sealed by a rock slide",
	[9] = "Tent",
	[10] = "Hut",
	[11] = "Refreshing!",
	[12] = "Boat",
	[13] = "Dock",
	[14] = "Drink",
	[15] = "Button",
	[16] = "",
	[17] = "",
	[18] = "",
	[19] = "",
	[20] = "",
	[21] = "This Door is Locked",
	[22] = "You need the Home Key to use this teleporter.",
	[23] = "",
	[24] = "",
	[25] = "Wine Cellar",
	[26] = "The Mercenary Guild ",
	[27] = "Tidewater Caverns",
	[28] = "Lord Markham's Manor",
	[29] = "",
	[30] = "Enter the Wine Cellar",
	[31] = "Enter the Mercenary Guild",
	[32] = "Enter the Tidewater Caverns",
	[33] = "Enter Lord Markham's Manor",
	[34] = "Enter the Cave",
	[35] = "Temple",
	[36] = "Guilds",
	[37] = "Stables",
	[38] = "Wharf",
	[39] = "Shops",
	[40] = "",
	[41] = "Castle Harmondy",
	[42] = "East to Steadwick",
	[43] = "North ",
	[44] = "Tatalia",
	[45] = "South ",
	[46] = "",
	[47] = "",
	[48] = "",
	[49] = "",
	[50] = "Obelisk",
	[51] = "e_laru_a",
	[52] = "Shrine",
	[53] = "Altar",
	[54] = "You Pray",
	[55] = "Stone",
	[56] = "Home Portal",
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
	[70] = "You do not feel well.",
	[71] = "+2 Speed (Permanent)",
	[72] = "+20 Air Resistance (Temporary)",
	[73] = "+20 AC (Temporary)",
	[74] = "You decide it would be a bad idea to try that again.",
}
table.copy(TXT, evt.str, true)


evt.hint[1] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(1)
evt.map[1] = function()  -- function events.LoadMap()
	if evt.Cmp{"QBits", Value = 612} then         -- Chose the path of Dark
		evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.SetMonGroupBit{NPCGroup = 55, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	end
end

events.LoadMap = evt.map[1].last

evt.house[3] = 55  -- "The Missing Link"
Game.MapEvtLines:RemoveEvent(3)
evt.map[3] = function()
	evt.EnterHouse{Id = 55}         -- "The Missing Link"
end

evt.house[4] = 55  -- "The Missing Link"
Game.MapEvtLines:RemoveEvent(4)
evt.map[4] = function()
end

evt.house[5] = 466  -- "Dry Saddles"
Game.MapEvtLines:RemoveEvent(5)
evt.map[5] = function()
	evt.EnterHouse{Id = 466}         -- "Dry Saddles"
end

evt.house[6] = 466  -- "Dry Saddles"
Game.MapEvtLines:RemoveEvent(6)
evt.map[6] = function()
end

evt.house[7] = 491  -- "Narwhale"
Game.MapEvtLines:RemoveEvent(7)
evt.map[7] = function()
	evt.EnterHouse{Id = 491}         -- "Narwhale"
end

evt.house[8] = 491  -- "Narwhale"
Game.MapEvtLines:RemoveEvent(8)
evt.map[8] = function()
end

evt.house[9] = 319  -- "The Order of Tatalia"
Game.MapEvtLines:RemoveEvent(9)
evt.map[9] = function()
	evt.EnterHouse{Id = 319}         -- "The Order of Tatalia"
end

evt.house[10] = 319  -- "The Order of Tatalia"
Game.MapEvtLines:RemoveEvent(10)
evt.map[10] = function()
end

evt.house[11] = 1577  -- "Training Essentials"
Game.MapEvtLines:RemoveEvent(11)
evt.map[11] = function()
	evt.EnterHouse{Id = 1577}         -- "Training Essentials"
end

evt.house[12] = 1577  -- "Training Essentials"
Game.MapEvtLines:RemoveEvent(12)
evt.map[12] = function()
end

evt.house[13] = 250  -- "The Loyal Mercenary"
Game.MapEvtLines:RemoveEvent(13)
evt.map[13] = function()
	evt.EnterHouse{Id = 250}         -- "The Loyal Mercenary"
end

evt.house[14] = 250  -- "The Loyal Mercenary"
Game.MapEvtLines:RemoveEvent(14)
evt.map[14] = function()
end

evt.house[15] = 291  -- "The Depository"
Game.MapEvtLines:RemoveEvent(15)
evt.map[15] = function()
	evt.EnterHouse{Id = 291}         -- "The Depository"
end

evt.house[16] = 291  -- "The Depository"
Game.MapEvtLines:RemoveEvent(16)
evt.map[16] = function()
end

evt.house[17] = 160  -- "Master Guild of Mind"
Game.MapEvtLines:RemoveEvent(17)
evt.map[17] = function()
	evt.EnterHouse{Id = 160}         -- "Master Guild of Mind"
end

evt.house[18] = 160  -- "Master Guild of Mind"
Game.MapEvtLines:RemoveEvent(18)
evt.map[18] = function()
end

evt.house[19] = 15  -- "Vander's Blades & Bows"
Game.MapEvtLines:RemoveEvent(19)
evt.map[19] = function()
	evt.EnterHouse{Id = 15}         -- "Vander's Blades & Bows"
end

evt.house[20] = 15  -- "Vander's Blades & Bows"
Game.MapEvtLines:RemoveEvent(20)
evt.map[20] = function()
end

evt.house[21] = 19  -- "Alloyed Weapons"
Game.MapEvtLines:RemoveEvent(21)
evt.map[21] = function()
	evt.EnterHouse{Id = 19}         -- "Alloyed Weapons"
end

evt.house[22] = 19  -- "Alloyed Weapons"
Game.MapEvtLines:RemoveEvent(22)
evt.map[22] = function()
end

evt.house[23] = 59  -- "Alloyed Armor and Shields"
Game.MapEvtLines:RemoveEvent(23)
evt.map[23] = function()
	evt.EnterHouse{Id = 59}         -- "Alloyed Armor and Shields"
end

evt.house[24] = 59  -- "Alloyed Armor and Shields"
Game.MapEvtLines:RemoveEvent(24)
evt.map[24] = function()
end

evt.hint[30] = evt.str[56]  -- "Home Portal"
Game.MapEvtLines:RemoveEvent(30)
evt.map[30] = function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if evt.Cmp{"Inventory", Value = 1472} then         -- "Home Key"
		evt.MoveToMap{X = -9853, Y = 8656, Z = -1024, Direction = 2047, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "7Out03.Odm"}
	else
		evt.StatusText{Str = 22}         -- "You need the Home Key to use this teleporter."
	end
end

evt.hint[51] = evt.str[7]  -- "House"
evt.house[52] = 1025  -- "Steele Residence"
Game.MapEvtLines:RemoveEvent(52)
evt.map[52] = function()
	evt.EnterHouse{Id = 1025}         -- "Steele Residence"
end

evt.house[53] = 1026  -- "Conscience Home"
Game.MapEvtLines:RemoveEvent(53)
evt.map[53] = function()
	evt.EnterHouse{Id = 1026}         -- "Conscience Home"
end

evt.house[54] = 1027  -- "Everil's House"
Game.MapEvtLines:RemoveEvent(54)
evt.map[54] = function()
	evt.EnterHouse{Id = 1027}         -- "Everil's House"
end

evt.house[57] = 1030  -- "Tricia's House"
Game.MapEvtLines:RemoveEvent(57)
evt.map[57] = function()
	evt.EnterHouse{Id = 1030}         -- "Tricia's House"
end

evt.house[58] = 1031  -- "Isram's House"
Game.MapEvtLines:RemoveEvent(58)
evt.map[58] = function()
	evt.EnterHouse{Id = 1031}         -- "Isram's House"
end

evt.house[59] = 1032  -- "Stonecleaver Residence"
Game.MapEvtLines:RemoveEvent(59)
evt.map[59] = function()
	evt.EnterHouse{Id = 1032}         -- "Stonecleaver Residence"
end

evt.house[61] = 1034  -- "Calindra's Home"
Game.MapEvtLines:RemoveEvent(61)
evt.map[61] = function()
	evt.EnterHouse{Id = 1034}         -- "Calindra's Home"
end

evt.house[62] = 1035  -- "Brother Bombah's"
Game.MapEvtLines:RemoveEvent(62)
evt.map[62] = function()
	evt.EnterHouse{Id = 1035}         -- "Brother Bombah's"
end

evt.house[63] = 1036  -- "Redding Residence"
Game.MapEvtLines:RemoveEvent(63)
evt.map[63] = function()
	evt.EnterHouse{Id = 1036}         -- "Redding Residence"
end

evt.house[65] = 1038  -- "Fist's House"
Game.MapEvtLines:RemoveEvent(65)
evt.map[65] = function()
	evt.EnterHouse{Id = 1038}         -- "Fist's House"
end

evt.house[66] = 1039  -- "Wacko's"
Game.MapEvtLines:RemoveEvent(66)
evt.map[66] = function()
	evt.EnterHouse{Id = 1039}         -- "Wacko's"
end

evt.house[67] = 1040  -- "Weldric's Home"
Game.MapEvtLines:RemoveEvent(67)
evt.map[67] = function()
	evt.EnterHouse{Id = 1040}         -- "Weldric's Home"
end

evt.house[69] = 1042  -- "Visconti Residence"
Game.MapEvtLines:RemoveEvent(69)
evt.map[69] = function()
	evt.EnterHouse{Id = 1042}         -- "Visconti Residence"
end

evt.house[70] = 1043  -- "Arin Residence"
Game.MapEvtLines:RemoveEvent(70)
evt.map[70] = function()
	evt.EnterHouse{Id = 1043}         -- "Arin Residence"
end

evt.house[73] = 1046  -- "Sampson Residence"
Game.MapEvtLines:RemoveEvent(73)
evt.map[73] = function()
	evt.EnterHouse{Id = 1046}         -- "Sampson Residence"
end

evt.house[75] = 1048  -- "Taren's House"
Game.MapEvtLines:RemoveEvent(75)
evt.map[75] = function()
	evt.EnterHouse{Id = 1048}         -- "Taren's House"
end

evt.house[76] = 1049  -- "Moore Residence"
Game.MapEvtLines:RemoveEvent(76)
evt.map[76] = function()
	evt.EnterHouse{Id = 1049}         -- "Moore Residence"
end

evt.house[77] = 1050  -- "Rothham's House"
Game.MapEvtLines:RemoveEvent(77)
evt.map[77] = function()
	evt.EnterHouse{Id = 1050}         -- "Rothham's House"
end

evt.house[78] = 1005  -- "Greydawn Residence"
Game.MapEvtLines:RemoveEvent(78)
evt.map[78] = function()
	evt.EnterHouse{Id = 1005}         -- "Greydawn Residence"
end

evt.house[79] = 1006  -- "Stormeye's House"
Game.MapEvtLines:RemoveEvent(79)
evt.map[79] = function()
	evt.EnterHouse{Id = 1006}         -- "Stormeye's House"
end

evt.house[80] = 1007  -- "Bremen Residence"
Game.MapEvtLines:RemoveEvent(80)
evt.map[80] = function()
	evt.EnterHouse{Id = 1007}         -- "Bremen Residence"
end

evt.house[81] = 989  -- "Riverstone House"
Game.MapEvtLines:RemoveEvent(81)
evt.map[81] = function()
	evt.EnterHouse{Id = 989}         -- "Riverstone House"
end

evt.hint[151] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(151)
evt.map[151] = function()
	evt.OpenChest{Id = 1}
end

evt.hint[152] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(152)
evt.map[152] = function()
	evt.OpenChest{Id = 2}
end

evt.hint[153] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(153)
evt.map[153] = function()
	evt.OpenChest{Id = 3}
end

evt.hint[154] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(154)
evt.map[154] = function()
	evt.OpenChest{Id = 4}
end

evt.hint[155] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(155)
evt.map[155] = function()
	evt.OpenChest{Id = 5}
end

evt.hint[156] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(156)
evt.map[156] = function()
	evt.OpenChest{Id = 6}
end

evt.hint[157] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(157)
evt.map[157] = function()
	evt.OpenChest{Id = 7}
end

evt.hint[158] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(158)
evt.map[158] = function()
	evt.OpenChest{Id = 8}
end

evt.hint[159] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(159)
evt.map[159] = function()
	evt.OpenChest{Id = 9}
end

evt.hint[160] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(160)
evt.map[160] = function()
	evt.OpenChest{Id = 10}
end

evt.hint[161] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(161)
evt.map[161] = function()
	evt.OpenChest{Id = 11}
end

evt.hint[162] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(162)
evt.map[162] = function()
	evt.OpenChest{Id = 12}
end

evt.hint[163] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(163)
evt.map[163] = function()
	evt.OpenChest{Id = 13}
end

evt.hint[164] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(164)
evt.map[164] = function()
	evt.OpenChest{Id = 14}
end

evt.hint[165] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(165)
evt.map[165] = function()
	evt.OpenChest{Id = 15}
end

evt.hint[166] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(166)
evt.map[166] = function()
	evt.OpenChest{Id = 16}
end

evt.hint[167] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(167)
evt.map[167] = function()
	evt.OpenChest{Id = 17}
end

evt.hint[168] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(168)
evt.map[168] = function()
	evt.OpenChest{Id = 18}
end

evt.hint[169] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(169)
evt.map[169] = function()
	evt.OpenChest{Id = 19}
end

evt.hint[170] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(170)
evt.map[170] = function()
	evt.OpenChest{Id = 0}
	if not evt.Cmp{"QBits", Value = 582} then         -- Placed Golem left leg
		if not evt.Cmp{"QBits", Value = 733} then         -- Right arm - I lost it
			evt.Add{"QBits", Value = 733}         -- Right arm - I lost it
		end
	end
end

evt.hint[201] = evt.str[3]  -- "Well"
evt.hint[202] = evt.str[4]  -- "Drink from the Well"
Game.MapEvtLines:RemoveEvent(202)
evt.map[202] = function()
	if evt.Cmp{"PlayerBits", Value = 21} then
		evt.StatusText{Str = 11}         -- "Refreshing!"
		return
	end
	if not evt.Cmp{"AutonotesBits", Value = 285} then         -- "20 points of temporary Armor Class from the well in the northern village in Tatalia."
		evt.Add{"AutonotesBits", Value = 285}         -- "20 points of temporary Armor Class from the well in the northern village in Tatalia."
	end
	evt.Add{"ArmorClassBonus", Value = 20}
	evt.Add{"PlayerBits", Value = 21}
	evt.StatusText{Str = 73}         -- "+20 AC (Temporary)"
end

Timer(function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	evt.Subtract{"PlayerBits", Value = 21}
end, const.Day, 1*const.Hour)

evt.hint[203] = evt.str[4]  -- "Drink from the Well"
Game.MapEvtLines:RemoveEvent(203)
evt.map[203] = function()
	if evt.Cmp{"PlayerBits", Value = 20} then
		evt.StatusText{Str = 11}         -- "Refreshing!"
		return
	end
	if not evt.Cmp{"AutonotesBits", Value = 284} then         -- "20 points of temporary Air resistance from the well in the eastern section of Tidewater in Tatalia."
		evt.Add{"AutonotesBits", Value = 284}         -- "20 points of temporary Air resistance from the well in the eastern section of Tidewater in Tatalia."
	end
	evt.Add{"AirResBonus", Value = 20}
	evt.Add{"PlayerBits", Value = 20}
	evt.StatusText{Str = 72}         -- "+20 Air Resistance (Temporary)"
end

Timer(function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	evt.Subtract{"PlayerBits", Value = 20}
end, const.Day, 1*const.Hour)

evt.hint[204] = evt.str[4]  -- "Drink from the Well"
Game.MapEvtLines:RemoveEvent(204)
evt.map[204] = function()
	if evt.Cmp{"PlayerBits", Value = 19} then
		evt.StatusText{Str = 11}         -- "Refreshing!"
		return
	end
	if not evt.Cmp{"AutonotesBits", Value = 283} then         -- "2 points of permanent Speed from the well in the western section of Tidewater in Tatalia."
		evt.Add{"AutonotesBits", Value = 283}         -- "2 points of permanent Speed from the well in the western section of Tidewater in Tatalia."
	end
	evt.Add{"BaseSpeed", Value = 2}
	evt.Add{"PlayerBits", Value = 19}
	evt.StatusText{Str = 71}         -- "+2 Speed (Permanent)"
end

evt.hint[205] = evt.str[26]  -- "The Mercenary Guild "
evt.hint[206] = evt.str[27]  -- "Tidewater Caverns"
evt.hint[207] = evt.str[28]  -- "Lord Markham's Manor"
evt.hint[208] = evt.str[44]  -- "Tatalia"
evt.hint[209] = evt.str[42]  -- "East to Steadwick"
evt.hint[210] = evt.str[38]  -- "Wharf"
evt.hint[211] = evt.str[35]  -- "Temple"
evt.hint[212] = evt.str[37]  -- "Stables"
evt.hint[213] = evt.str[55]  -- "Stone"
evt.hint[214] = evt.str[14]  -- "Drink"
Game.MapEvtLines:RemoveEvent(214)
evt.map[214] = function()
	local i
	if evt.Cmp{"DiseasedGreen", Value = 0} then
		goto _12
	end
	if evt.Cmp{"DiseasedYellow", Value = 0} then
		goto _12
	end
	if evt.Cmp{"DiseasedRed", Value = 0} then
		goto _12
	end
	i = Game.Rand() % 3
	if i == 1 then
		evt.Set{"DiseasedGreen", Value = 0}
	elseif i == 2 then
		evt.Set{"DiseasedYellow", Value = 0}
	else
		evt.Set{"DiseasedRed", Value = 0}
	end
	evt.StatusText{Str = 70}         -- "You do not feel well."
	do return end
::_12::
	evt.StatusText{Str = 74}         -- "You decide it would be a bad idea to try that again."
end

evt.hint[215] = evt.str[43]  -- "North "
evt.hint[401] = evt.str[53]  -- "Altar"
Game.MapEvtLines:RemoveEvent(401)
evt.map[401] = function()
	if evt.Cmp{"QBits", Value = 561} then         -- "Visit the three stonehenge monoliths in Tatalia, the Evenmorn Islands, and Avlee, then return to Anthony Green in the Tularean Forest."
		if not evt.Cmp{"QBits", Value = 562} then         -- Visited all stonehenges
			if not evt.Cmp{"QBits", Value = 564} then         -- Visited stonehenge 2 (area 13)
				evt.StatusText{Str = 56}         -- "Home Portal"
				evt.ForPlayer(-- ERROR: Const not found
"All")
				evt.Set{"QBits", Value = 564}         -- Visited stonehenge 2 (area 13)
				evt.ForPlayer(-- ERROR: Const not found
"All")
				evt.Add{"QBits", Value = 757}         -- "Congratulations"
				evt.Subtract{"QBits", Value = 757}         -- "Congratulations"
				if evt.Cmp{"QBits", Value = 563} then         -- Visited stonehenge 1 (area 9)
					if evt.Cmp{"QBits", Value = 565} then         -- Visited stonehenge 3 (area 14)
						evt.ForPlayer(-- ERROR: Const not found
"All")
						evt.Set{"QBits", Value = 562}         -- Visited all stonehenges
					end
				end
			end
		end
	end
end

evt.hint[451] = evt.str[52]  -- "Shrine"
evt.hint[452] = evt.str[53]  -- "Altar"
Game.MapEvtLines:RemoveEvent(452)
evt.map[452] = function()
	if not evt.Cmp{"QBits", Value = 714} then         -- Place item 618 in out13(statue)
		if evt.Cmp{"QBits", Value = 712} then         -- "Retrieve the three statuettes and place them on the shrines in the Bracada Desert, Tatalia, and Avlee, then return to Thom Lumbra in the Tularean Forest."
			evt.ForPlayer(-- ERROR: Const not found
"All")
			if evt.Cmp{"Inventory", Value = 1420} then         -- "Eagle Statuette"
				evt.SetSprite{SpriteId = 25, Visible = 1, Name = "0"}
				evt.Subtract{"Inventory", Value = 1420}         -- "Eagle Statuette"
				evt.Set{"QBits", Value = 714}         -- Place item 618 in out13(statue)
			end
		end
	end
end

evt.hint[453] = evt.str[50]  -- "Obelisk"
Game.MapEvtLines:RemoveEvent(453)
evt.map[453] = function()
	if not evt.Cmp{"QBits", Value = 687} then         -- Visited Obelisk in Area 13
		evt.StatusText{Str = 51}         -- "e_laru_a"
		evt.Add{"AutonotesBits", Value = 320}         -- "Obelisk message #12: e_laru_a"
		evt.ForPlayer(-- ERROR: Const not found
"All")
		evt.Add{"QBits", Value = 687}         -- Visited Obelisk in Area 13
	end
end

evt.hint[454] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(454)
evt.map[454] = function()  -- function events.LoadMap()
	if evt.Cmp{"QBits", Value = 526} then         -- Accepted Fireball wand from Malwick
		if not evt.Cmp{"QBits", Value = 702} then         -- Finished with Malwick & Assc.
			if evt.Cmp{"QBits", Value = 695} then         -- Failed either goto or do guild quest
				return
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
			goto _12
		end
	end
	do return end
::_12::
	evt.ForPlayer(-- ERROR: Const not found
"All")
	evt.Set{"QBits", Value = 695}         -- Failed either goto or do guild quest
	evt.SpeakNPC{NPC = 437}         -- "Messenger"
end

events.LoadMap = evt.map[454].last

evt.hint[455] = evt.str[8]  -- "The entrance has been sealed by a rock slide"
evt.hint[500] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(500)
evt.map[500] = function()
	if not evt.CheckSeason{Season = 3} then
		if not evt.CheckSeason{Season = 2} then
			if not evt.CheckSeason{Season = 1} then
				evt.CheckSeason{Season = 0}
			end
		end
	end
end

evt.hint[501] = evt.str[30]  -- "Enter the Wine Cellar"
Game.MapEvtLines:RemoveEvent(501)
evt.map[501] = function()
	evt.MoveToMap{X = 601, Y = -512, Z = 1, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 412, Icon = 2, Name = "7D16.blv"}         -- "Wine Cellar"
end

evt.hint[502] = evt.str[31]  -- "Enter the Mercenary Guild"
Game.MapEvtLines:RemoveEvent(502)
evt.map[502] = function()
	if not evt.Cmp{"QBits", Value = 526} then         -- Accepted Fireball wand from Malwick
		goto _6
	end
	if evt.Cmp{"QBits", Value = 702} then         -- Finished with Malwick & Assc.
		goto _6
	end
	if evt.Cmp{"QBits", Value = 695} then         -- Failed either goto or do guild quest
		goto _14
	end
	if evt.Cmp{"QBits", Value = 693} then         -- "Go to the Mercenary Guild in Tatalia and talk to Niles Stantley within two weeks."
		if evt.Cmp{"Counter5", Value = 336} then
			goto _12
		end
	else
		if not evt.Cmp{"QBits", Value = 694} then         -- "Steal the Tapestry from your associate's Castle and return it to Niles Stantley in the Mercenary Guild in Tatalia."
			goto _6
		end
		if evt.Cmp{"Counter5", Value = 672} then
			goto _12
		end
	end
::_17::
	evt.SpeakNPC{NPC = 438}         -- "Niles Stantley"
	do return end
::_6::
	evt.MoveToMap{X = 886, Y = 2601, Z = 1, Direction = 474, LookAngle = 0, SpeedZ = 0, HouseId = 410, Icon = 9, Name = "7D20.blv"}         -- "Mercenary Guild"
	do return end
::_14::
	evt.SetNPCGreeting{NPC = 438, Greeting = 283}         -- "Niles Stantley" : "Your lack of punctuality has cost yourselves and your town grievously.  I think you may find your bank account somewhat… pinched.  Consider this an important lesson learned.  Good day."
	evt.Subtract{"QBits", Value = 693}         -- "Go to the Mercenary Guild in Tatalia and talk to Niles Stantley within two weeks."
	evt.Subtract{"QBits", Value = 694}         -- "Steal the Tapestry from your associate's Castle and return it to Niles Stantley in the Mercenary Guild in Tatalia."
	goto _17
::_12::
	evt.ForPlayer(-- ERROR: Const not found
"All")
	evt.Set{"QBits", Value = 695}         -- Failed either goto or do guild quest
	goto _14
end

evt.hint[503] = evt.str[32]  -- "Enter the Tidewater Caverns"
Game.MapEvtLines:RemoveEvent(503)
evt.map[503] = function()
	evt.MoveToMap{X = -1944, Y = -2052, Z = 1, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 411, Icon = 9, Name = "7D17.blv"}         -- "Tidewater Caverns"
end

evt.hint[504] = evt.str[33]  -- "Enter Lord Markham's Manor"
Game.MapEvtLines:RemoveEvent(504)
evt.map[504] = function()
	evt.MoveToMap{X = -33, Y = -600, Z = 1, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 9, Name = "7D18.blv"}
end

evt.hint[505] = evt.str[34]  -- "Enter the Cave"
Game.MapEvtLines:RemoveEvent(505)
evt.map[505] = function()
	evt.StatusText{Str = 8}         -- "The entrance has been sealed by a rock slide"
end



--[[ MMMerge additions ]]--

-- Tatalia

function events.AfterLoadMap()
	Party.QBits[948] = true	-- DDMapBuff, changed for rev4 for merge
end

----------------------------------------
-- Adventurer's Inn

evt.house[82] = 1607
evt.map[82] = function() evt.EnterHouse{1607} end
