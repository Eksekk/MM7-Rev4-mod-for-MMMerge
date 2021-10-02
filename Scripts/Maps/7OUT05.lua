local TXT = Localize{
	[0] = " ",
	[1] = "Chest ",
	[2] = "Barrel",
	[3] = "Well",
	[4] = "Drink from the Well",
	[5] = "Fountain",
	[6] = "Drink from the Fountain",
	[7] = "House",
	[8] = "",
	[9] = "Tent",
	[10] = "Hut",
	[11] = "Refreshing!",
	[12] = "Boat",
	[13] = "Dock",
	[14] = "Drink",
	[15] = "Button",
	[16] = "",
	[17] = "",
	[18] = "The Treasury is locked",
	[19] = "",
	[20] = "Ambush",
	[21] = "This Door is Locked",
	[22] = "You need the Home Key to use this teleporter.",
	[23] = "",
	[24] = "",
	[25] = "Hall of the Pit",
	[26] = "Watchtower 6",
	[27] = "",
	[28] = "",
	[29] = "",
	[30] = "Enter the Hall of the Pit",
	[31] = "Enter Watchtower 6",
	[32] = "",
	[33] = "",
	[34] = "",
	[35] = "Temple",
	[36] = "Guilds",
	[37] = "Stables",
	[38] = "Docks",
	[39] = "Shops",
	[40] = "",
	[41] = "Castle Harmondy",
	[42] = "East ",
	[43] = "North ",
	[44] = "West",
	[45] = "South ",
	[46] = "Harmondale",
	[47] = "",
	[48] = "",
	[49] = "",
	[50] = "Obelisk",
	[51] = " a_eetcoa",
	[52] = "Shrine",
	[53] = "Altar",
	[54] = "You Pray",
	[55] = "Home Portal",
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
	[70] = "+2 Intellect (Permanent)",
	[71] = "+5 Fire Resistance (Permanent)",
	[72] = "+10 Personality (Temporary)",
	[73] = "You Feel Great!!",
	[74] = "+10 Fire Resistance (Temporary)",
	[75] = "Haven't you had enough ?",
	[76] = "Do you think that's such a good idea ?",
	[77] = "+10 Mind, Earth, and Body Resistance(Permanent)",
}
table.copy(TXT, evt.str, true)


evt.hint[1] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(1)
evt.map[1] = function()  -- function events.LoadMap()
	evt.Set{"MapVar29", Value = 5}
	if evt.Cmp{"QBits", Value = 611} then         -- Chose the path of Light
		goto _6
	end
	if evt.Cmp{"QBits", Value = 782} then         -- Your friends are mad at you 
		if not evt.Cmp{"Counter10", Value = 720} then
			goto _6
		end
		evt.Subtract{"QBits", Value = 782}         -- Your friends are mad at you 
		evt.Set{"MapVar4", Value = 0}
		evt.SetMonGroupBit{NPCGroup = 55, Bit = const.MonsterBits.Hostile, On = false}         -- "Guards"
	else
		if evt.Cmp{"MapVar4", Value = 2} then
			goto _7
		end
	end
::_8::
	evt.SetMonGroupBit{NPCGroup = 58, Bit = const.MonsterBits.Hostile, On = true}         -- "Group fo M2"
	do return end
::_6::
	evt.Set{"MapVar4", Value = 2}
::_7::
	evt.SetMonGroupBit{NPCGroup = 55, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	goto _8
end

events.LoadMap = evt.map[1].last

evt.house[3] = 120  -- "The Blackened Vial"
Game.MapEvtLines:RemoveEvent(3)
evt.map[3] = function()
	evt.EnterHouse{Id = 120}         -- "The Blackened Vial"
end

evt.house[4] = 120  -- "The Blackened Vial"
Game.MapEvtLines:RemoveEvent(4)
evt.map[4] = function()
end

evt.house[5] = 464  -- "Faithful Steeds"
Game.MapEvtLines:RemoveEvent(5)
evt.map[5] = function()
	evt.EnterHouse{Id = 464}         -- "Faithful Steeds"
end

evt.house[6] = 464  -- "Faithful Steeds"
Game.MapEvtLines:RemoveEvent(6)
evt.map[6] = function()
end

evt.house[7] = 314  -- "Temple of Dark"
Game.MapEvtLines:RemoveEvent(7)
evt.map[7] = function()
	evt.EnterHouse{Id = 314}         -- "Temple of Dark"
end

evt.house[8] = 314  -- "Temple of Dark"
Game.MapEvtLines:RemoveEvent(8)
evt.map[8] = function()
end

evt.house[9] = 243  -- "The Snobbish Goblin"
Game.MapEvtLines:RemoveEvent(9)
evt.map[9] = function()
	evt.EnterHouse{Id = 243}         -- "The Snobbish Goblin"
end

evt.house[10] = 243  -- "The Snobbish Goblin"
Game.MapEvtLines:RemoveEvent(10)
evt.map[10] = function()
end

evt.house[11] = 154  -- "Master Guild of Spirit"
Game.MapEvtLines:RemoveEvent(11)
evt.map[11] = function()
	evt.EnterHouse{Id = 154}         -- "Master Guild of Spirit"
end

evt.house[12] = 154  -- "Master Guild of Spirit"
Game.MapEvtLines:RemoveEvent(12)
evt.map[12] = function()
end

evt.house[13] = 176  -- "Guild of Twilight"
Game.MapEvtLines:RemoveEvent(13)
evt.map[13] = function()
	evt.EnterHouse{Id = 176}         -- "Guild of Twilight"
end

evt.house[14] = 176  -- "Guild of Twilight"
Game.MapEvtLines:RemoveEvent(14)
evt.map[14] = function()
end

evt.house[15] = 88  -- "Death's Door"
Game.MapEvtLines:RemoveEvent(15)
evt.map[15] = function()
	evt.EnterHouse{Id = 88}         -- "Death's Door"
end

evt.house[16] = 88  -- "Death's Door"
Game.MapEvtLines:RemoveEvent(16)
evt.map[16] = function()
end

evt.hint[20] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(20)
evt.map[20] = function()  -- function events.LoadMap()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if evt.Cmp{"Inventory", Value = 1531} then         -- "Saints of Selinas Scroll 1"
		if evt.Cmp{"Inventory", Value = 1532} then         -- "Saints of Selinas Scroll 2"
			if evt.Cmp{"Inventory", Value = 1533} then         -- "Saints of Selinas Scroll 3"
				if evt.Cmp{"Inventory", Value = 1534} then         -- "Saints of Selinas Scroll 4"
					if evt.Cmp{"Inventory", Value = 1535} then         -- "Saints of Selinas Scroll 5"
						if evt.Cmp{"Inventory", Value = 1537} then         -- "Saints of Selinas Scroll 6"
							evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Invisible, On = false}         -- "Generic Monster Group for Dungeons"
							evt.SetMonGroupBit{NPCGroup = 57, Bit = const.MonsterBits.Hostile, On = false}         -- "Group for M1"
							evt.SetMonGroupBit{NPCGroup = 57, Bit = const.MonsterBits.Invisible, On = false}         -- "Group for M1"
						end
					end
				end
			end
		end
	end
end

events.LoadMap = evt.map[20].last

evt.hint[30] = evt.str[55]  -- "Home Portal"
Game.MapEvtLines:RemoveEvent(30)
evt.map[30] = function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if evt.Cmp{"Inventory", Value = 1472} then         -- "Home Key"
		evt.MoveToMap{X = -9853, Y = 8656, Z = -1024, Direction = 2047, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "7Out03.Odm"}
	else
		evt.StatusText{Str = 22}         -- "You need the Home Key to use this teleporter."
	end
end

evt.hint[51] = evt.str[7]  -- "House"
evt.house[52] = 969  -- "Karrand Residence"
Game.MapEvtLines:RemoveEvent(52)
evt.map[52] = function()
	evt.EnterHouse{Id = 969}         -- "Karrand Residence"
end

evt.house[53] = 970  -- "Cleareye's Home"
Game.MapEvtLines:RemoveEvent(53)
evt.map[53] = function()
	evt.EnterHouse{Id = 970}         -- "Cleareye's Home"
end

evt.house[54] = 971  -- "Foestryke Residence"
Game.MapEvtLines:RemoveEvent(54)
evt.map[54] = function()
	evt.EnterHouse{Id = 971}         -- "Foestryke Residence"
end

evt.house[55] = 972  -- "Oxhide Residence"
Game.MapEvtLines:RemoveEvent(55)
evt.map[55] = function()
	evt.EnterHouse{Id = 972}         -- "Oxhide Residence"
end

evt.house[56] = 973  -- "Shadowrunner's Home"
Game.MapEvtLines:RemoveEvent(56)
evt.map[56] = function()
	evt.EnterHouse{Id = 973}         -- "Shadowrunner's Home"
end

evt.house[57] = 974  -- "Kedrin Residence"
Game.MapEvtLines:RemoveEvent(57)
evt.map[57] = function()
	evt.EnterHouse{Id = 974}         -- "Kedrin Residence"
end

evt.house[58] = 975  -- "Botham's Home"
Game.MapEvtLines:RemoveEvent(58)
evt.map[58] = function()
	evt.EnterHouse{Id = 975}         -- "Botham's Home"
end

evt.house[59] = 976  -- "Mogren Residence"
Game.MapEvtLines:RemoveEvent(59)
evt.map[59] = function()
	evt.EnterHouse{Id = 976}         -- "Mogren Residence"
end

evt.house[60] = 977  -- "Draken Residence"
Game.MapEvtLines:RemoveEvent(60)
evt.map[60] = function()
	evt.EnterHouse{Id = 977}         -- "Draken Residence"
end

evt.house[61] = 978  -- "Harli's Place"
Game.MapEvtLines:RemoveEvent(61)
evt.map[61] = function()
	evt.EnterHouse{Id = 978}         -- "Harli's Place"
end

evt.house[62] = 979  -- "Nevermore Residence"
Game.MapEvtLines:RemoveEvent(62)
evt.map[62] = function()
	evt.EnterHouse{Id = 979}         -- "Nevermore Residence"
end

evt.house[63] = 980  -- "Avalanche's"
Game.MapEvtLines:RemoveEvent(63)
evt.map[63] = function()
	evt.EnterHouse{Id = 980}         -- "Avalanche's"
end

evt.house[64] = 981  -- "Nightcrawler Residence"
Game.MapEvtLines:RemoveEvent(64)
evt.map[64] = function()
	evt.EnterHouse{Id = 981}         -- "Nightcrawler Residence"
end

evt.house[65] = 982  -- "Felburn's House"
Game.MapEvtLines:RemoveEvent(65)
evt.map[65] = function()
	evt.EnterHouse{Id = 982}         -- "Felburn's House"
end

evt.house[66] = 983  -- "Empty House"
Game.MapEvtLines:RemoveEvent(66)
evt.map[66] = function()
	evt.EnterHouse{Id = 983}         -- "Empty House"
end

evt.house[67] = 984  -- "Duchess of Deja"
Game.MapEvtLines:RemoveEvent(67)
evt.map[67] = function()
	evt.EnterHouse{Id = 984}         -- "Duchess of Deja"
end

evt.house[68] = 985  -- "Kruella's Domain"
Game.MapEvtLines:RemoveEvent(68)
evt.map[68] = function()
	evt.EnterHouse{Id = 985}         -- "Kruella's Domain"
end

evt.house[69] = 1133  -- "Putnam Residence"
Game.MapEvtLines:RemoveEvent(69)
evt.map[69] = function()
	evt.EnterHouse{Id = 1133}         -- "Putnam Residence"
end

evt.house[70] = 1134  -- "Hawker Residence"
Game.MapEvtLines:RemoveEvent(70)
evt.map[70] = function()
	evt.EnterHouse{Id = 1134}         -- "Hawker Residence"
end

evt.house[71] = 1135  -- "Wiseman Residence"
Game.MapEvtLines:RemoveEvent(71)
evt.map[71] = function()
	evt.EnterHouse{Id = 1135}         -- "Wiseman Residence"
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
	if not evt.Cmp{"QBits", Value = 580} then         -- Placed Golem right leg
		if not evt.Cmp{"QBits", Value = 735} then         -- Right leg - I lost it
			evt.Add{"QBits", Value = 735}         -- Right leg - I lost it
		end
	end
end

evt.hint[170] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(170)
evt.map[170] = function()
	evt.OpenChest{Id = 0}
	if not evt.Cmp{"QBits", Value = 579} then         -- Placed Golem left leg
		if not evt.Cmp{"QBits", Value = 736} then         -- Left leg - I lost it
			evt.Add{"QBits", Value = 736}         -- Left leg - I lost it
		end
	end
end

evt.hint[201] = evt.str[3]  -- "Well"
evt.hint[202] = evt.str[4]  -- "Drink from the Well"
Game.MapEvtLines:RemoveEvent(202)
evt.map[202] = function()
	if not evt.Cmp{"BankGold", Value = 99} then
		if not evt.Cmp{"Gold", Value = 199} then
			if not evt.Cmp{"MapVar19", Value = 1} then
				evt.Add{"Gold", Value = 200}
				evt.Set{"MapVar19", Value = 1}
			end
		end
	end
	evt.StatusText{Str = 11}         -- "Refreshing!"
end

RefillTimer(function()
	evt.Set{"MapVar19", Value = 0}
end, const.Week, true)

evt.hint[203] = evt.str[4]  -- "Drink from the Well"
Game.MapEvtLines:RemoveEvent(203)
evt.map[203] = function()
	if evt.Cmp{"PlayerBits", Value = 9} then
		evt.StatusText{Str = 11}         -- "Refreshing!"
		return
	end
	if not evt.Cmp{"AutonotesBits", Value = 270} then         -- "2 points of permanent Intellect from the southern village well in Deyja."
		evt.Add{"AutonotesBits", Value = 270}         -- "2 points of permanent Intellect from the southern village well in Deyja."
	end
	evt.Add{"BaseIntellect", Value = 2}
	evt.Add{"PlayerBits", Value = 9}
	evt.StatusText{Str = 70}         -- "+2 Intellect (Permanent)"
end

evt.hint[204] = evt.str[4]  -- "Drink from the Well"
Game.MapEvtLines:RemoveEvent(204)
evt.map[204] = function()
	if evt.Cmp{"PlayerBits", Value = 11} then
		evt.StatusText{Str = 11}         -- "Refreshing!"
		return
	end
	if not evt.Cmp{"AutonotesBits", Value = 272} then         -- "10 points of temporary Personality from the well near the Temple of the Dark in Moulder in Deyja."
		evt.Add{"AutonotesBits", Value = 272}         -- "10 points of temporary Personality from the well near the Temple of the Dark in Moulder in Deyja."
	end
	evt.Add{"PersonalityBonus", Value = 10}
	evt.Add{"PlayerBits", Value = 11}
	evt.StatusText{Str = 72}         -- "+10 Personality (Temporary)"
end

Timer(function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	evt.Subtract{"PlayerBits", Value = 11}
end, const.Day, 1*const.Hour)

evt.hint[205] = evt.str[4]  -- "Drink from the Well"
Game.MapEvtLines:RemoveEvent(205)
evt.map[205] = function()
	if evt.Cmp{"PlayerBits", Value = 12} then
		evt.StatusText{Str = 11}         -- "Refreshing!"
		return
	end
	if not evt.Cmp{"AutonotesBits", Value = 273} then         -- "10 points of temporary Fire resistance from the well in the south side of Moulder in Deyja."
		evt.Add{"AutonotesBits", Value = 273}         -- "10 points of temporary Fire resistance from the well in the south side of Moulder in Deyja."
	end
	evt.Add{"FireResBonus", Value = 10}
	evt.Add{"PlayerBits", Value = 12}
	evt.StatusText{Str = 74}         -- "+10 Fire Resistance (Temporary)"
end

Timer(function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	evt.Subtract{"PlayerBits", Value = 12}
end, const.Day, 1*const.Hour)

evt.hint[206] = evt.str[4]  -- "Drink from the Well"
Game.MapEvtLines:RemoveEvent(206)
evt.map[206] = function()
	local i
	if not evt.Cmp{"Drunk", Value = 0} then
		evt.Set{"Drunk", Value = 0}
		evt.StatusText{Str = 73}         -- "You Feel Great!!"
	else
		i = Game.Rand() % 2
		if i == 1 then
			evt.StatusText{Str = 75}         -- "Haven't you had enough ?"
		else
			evt.StatusText{Str = 76}         -- "Do you think that's such a good idea ?"
		end
	end
end

evt.hint[207] = evt.str[4]  -- "Drink from the Well"
Game.MapEvtLines:RemoveEvent(207)
evt.map[207] = function()
	if evt.Cmp{"FireResistance", Value = 5} then
		goto _8
	end
	if evt.Cmp{"PlayerBits", Value = 10} then
		goto _8
	end
	if not evt.Cmp{"AutonotesBits", Value = 271} then         -- "5 points of permanent Fire resistance from the well in the western village in Deyja."
		evt.Add{"AutonotesBits", Value = 271}         -- "5 points of permanent Fire resistance from the well in the western village in Deyja."
	end
	evt.Add{"FireResistance", Value = 5}
	evt.Add{"PlayerBits", Value = 10}
	evt.StatusText{Str = 71}         -- "+5 Fire Resistance (Permanent)"
	do return end
::_8::
	evt.StatusText{Str = 11}         -- "Refreshing!"
end

evt.hint[451] = evt.str[52]  -- "Shrine"
evt.hint[452] = evt.str[53]  -- "Altar"
Game.MapEvtLines:RemoveEvent(452)
evt.map[452] = function()
	if evt.Cmp{"PlayerBits", Value = 26} then
		evt.StatusText{Str = 54}         -- "You Pray"
	else
		evt.Add{"MindResistance", Value = 10}
		evt.Add{"EarthResistance", Value = 10}
		evt.Add{"BodyResistance", Value = 10}
		evt.Add{"PlayerBits", Value = 26}
		evt.StatusText{Str = 77}         -- "+10 Mind, Earth, and Body Resistance(Permanent)"
	end
end

evt.hint[453] = evt.str[50]  -- "Obelisk"
Game.MapEvtLines:RemoveEvent(453)
evt.map[453] = function()
	if not evt.Cmp{"QBits", Value = 679} then         -- Visited Obelisk in Area 5
		evt.StatusText{Str = 51}         -- " a_eetcoa"
		evt.Add{"AutonotesBits", Value = 312}         -- "Obelisk message #4: a_eetcoa"
		evt.ForPlayer(-- ERROR: Const not found
"All")
		evt.Add{"QBits", Value = 679}         -- Visited Obelisk in Area 5
	end
end

evt.hint[454] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(454)
evt.map[454] = function()
	local i
	if not evt.Cmp{"QBits", Value = 761} then         -- Don't get ambushed
		i = Game.Rand() % 2
		if i == 1 then
			evt.Set{"MapVar29", Value = 5}
		else
			evt.SpeakNPC{NPC = 461}         -- "Lunius Shador"
			evt.Set{"MapVar29", Value = 0}
		end
	end
end

evt.hint[455] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(455)
evt.map[455] = function()
	if not evt.Cmp{"MapVar29", Value = 5} then
		if evt.Cmp{"QBits", Value = 761} then         -- Don't get ambushed
			evt.Set{"MapVar29", Value = 5}
		else
			evt.Add{"QBits", Value = 761}         -- Don't get ambushed
			evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 10, X = -2760, Y = -15344, Z = 2464, NPCGroup = 66, unk = 0}         -- "Group walkers in the Tularean forest"
			evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 10, X = -4560, Y = -16632, Z = 2464, NPCGroup = 66, unk = 0}         -- "Group walkers in the Tularean forest"
			evt.SetMonGroupBit{NPCGroup = 66, Bit = const.MonsterBits.Hostile, On = true}         -- "Group walkers in the Tularean forest"
			evt.Set{"MapVar29", Value = 5}
		end
	end
	evt.SetNPCTopic{NPC = 461, Index = 0, Event = 1257}         -- "Lunius Shador" : "Pay 1000 Gold"
	evt.SetNPCTopic{NPC = 461, Index = 1, Event = 1258}         -- "Lunius Shador" : "Don't Pay"
end

evt.hint[456] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(456)
evt.map[456] = function()
	if not evt.Cmp{"MapVar29", Value = 5} then
		if evt.Cmp{"QBits", Value = 761} then         -- Don't get ambushed
			evt.Set{"MapVar29", Value = 5}
		else
			evt.Add{"QBits", Value = 761}         -- Don't get ambushed
			evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 10, X = 19336, Y = -13040, Z = 2464, NPCGroup = 66, unk = 0}         -- "Group walkers in the Tularean forest"
			evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 10, X = 17150, Y = -13555, Z = 2464, NPCGroup = 66, unk = 0}         -- "Group walkers in the Tularean forest"
			evt.SetMonGroupBit{NPCGroup = 66, Bit = const.MonsterBits.Hostile, On = true}         -- "Group walkers in the Tularean forest"
			evt.Set{"MapVar29", Value = 5}
		end
	end
	evt.SetNPCTopic{NPC = 461, Index = 0, Event = 1257}         -- "Lunius Shador" : "Pay 1000 Gold"
	evt.SetNPCTopic{NPC = 461, Index = 1, Event = 1258}         -- "Lunius Shador" : "Don't Pay"
end

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

evt.hint[501] = evt.str[30]  -- "Enter the Hall of the Pit"
Game.MapEvtLines:RemoveEvent(501)
evt.map[501] = function()
	evt.MoveToMap{X = 512, Y = -3156, Z = 1, Direction = 545, LookAngle = 0, SpeedZ = 0, HouseId = 396, Icon = 2, Name = "T04.blv"}         -- "Hall of the Pit"
end

evt.hint[502] = evt.str[31]  -- "Enter Watchtower 6"
Game.MapEvtLines:RemoveEvent(502)
evt.map[502] = function()
	evt.MoveToMap{X = -416, Y = -1033, Z = 1, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 397, Icon = 9, Name = "7D15.blv"}         -- "Watchtower 6"
end

Game.MapEvtLines:RemoveEvent(503)
evt.map[503] = function()
	if not evt.Cmp{"QBits", Value = 874} then         -- " Enter the Treasury in Deja, find the key and enter the Vault, retrieve the Control Cube, and return to Robert the Wise in Celeste."
		evt.StatusText{Str = 18}         -- "The Treasury is locked"
	else
		if evt.Cmp{"QBits", Value = 890} then         -- Vilx
			evt.MoveToMap{X = 442, Y = -1112, Z = 1, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 9, Name = "MDT10.blv"}
		else
			if evt.Cmp{"QBits", Value = 889} then         -- Bimbasto
				evt.SpeakNPC{NPC = 374}         -- "Sir Vilx of Stone City"
				evt.Set{"QBits", Value = 890}         -- Vilx
				evt.Set{"NPCs", Value = 374}         -- "Sir Vilx of Stone City"
			else
				evt.SpeakNPC{NPC = 373}         -- "Duke Bimbasto"
				evt.Set{"QBits", Value = 889}         -- Bimbasto
				evt.Set{"NPCs", Value = 373}         -- "Duke Bimbasto"
			end
		end
	end
end

evt.hint[504] = evt.str[31]  -- "Enter Watchtower 6"
Game.MapEvtLines:RemoveEvent(504)
evt.map[504] = function()
	if not evt.Cmp{"QBits", Value = 708} then         -- Find second entrance to Watchtower6
		evt.Add{"QBits", Value = 708}         -- Find second entrance to Watchtower6
	end
	evt.MoveToMap{X = 190, Y = 4946, Z = -511, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 397, Icon = 9, Name = "7d15.blv"}         -- "Watchtower 6"
end



--[[ MMMerge additions ]]--

-- Deyja

function events.AfterLoadMap()
	Party.QBits[940] = true	-- DDMapBuff, changed for rev4 for merge

	LocalHostileTxt()
	Game.HostileTxt[91][0] = 0

	evt.SetMonGroupBit {56,  const.MonsterBits.Hostile,  true}
	evt.SetMonGroupBit {55,  const.MonsterBits.Hostile,  Party.QBits[611]}
end

function events.ExitNPC(i)
	if i == 461 and not Party.QBits[761] then
		evt.SummonMonsters{3, 3, 5, Party.X, Party.Y, Party.Z + 400, 59}
		evt.SetMonGroupBit{59, const.MonsterBits.Hostile, true}
	end
end
