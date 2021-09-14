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
	[18] = "",
	[19] = "",
	[20] = "",
	[21] = "This Door is Locked",
	[22] = "",
	[23] = "",
	[24] = "",
	[25] = "Thunderfist Mountain",
	[26] = "The Maze",
	[27] = "",
	[28] = "",
	[29] = "",
	[30] = "Enter Thunderfist Mountain",
	[31] = "Enter The Maze",
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
	[51] = "fi_eo_od",
	[52] = "Shrine",
	[53] = "Altar",
	[54] = "You Pray",
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
	[70] = "+50 Intellect and Personality (Temporary)",
	[71] = "+2 Skill Points",
	[72] = "+2 Personality (Permanent)",
	[73] = "+20 All Resistances (Temporary)",
	[74] = "+50 Spell Points",
	[75] = "+50 Hit Points",
	[76] = "+10 Personality and Intellect(Permanent)",
}
table.copy(TXT, evt.str, true)


evt.hint[1] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(1)
evt.map[1] = function()  -- function events.LoadMap()
	if not evt.Cmp{"QBits", Value = 723} then         -- Nighon - Town Portal
		evt.Add{"QBits", Value = 723}         -- Nighon - Town Portal
	end
	evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
end

events.LoadMap = evt.map[1].last

evt.house[3] = 54  -- "The Tannery"
Game.MapEvtLines:RemoveEvent(3)
evt.map[3] = function()
	evt.EnterHouse{Id = 54}         -- "The Tannery"
end

evt.house[4] = 54  -- "The Tannery"
Game.MapEvtLines:RemoveEvent(4)
evt.map[4] = function()
end

evt.house[5] = 92  -- "Arcane Items"
Game.MapEvtLines:RemoveEvent(5)
evt.map[5] = function()
	evt.EnterHouse{Id = 92}         -- "Arcane Items"
end

evt.house[6] = 92  -- "Arcane Items"
Game.MapEvtLines:RemoveEvent(6)
evt.map[6] = function()
end

evt.house[7] = 318  -- "Offerings and Blessings"
Game.MapEvtLines:RemoveEvent(7)
evt.map[7] = function()
	evt.EnterHouse{Id = 318}         -- "Offerings and Blessings"
end

evt.house[8] = 318  -- "Offerings and Blessings"
Game.MapEvtLines:RemoveEvent(8)
evt.map[8] = function()
end

evt.house[9] = 1576  -- "Applied Instruction"
Game.MapEvtLines:RemoveEvent(9)
evt.map[9] = function()
	evt.EnterHouse{Id = 1576}         -- "Applied Instruction"
end

evt.house[10] = 1576  -- "Applied Instruction"
Game.MapEvtLines:RemoveEvent(10)
evt.map[10] = function()
end

evt.house[11] = 248  -- "Fortune's Folly"
Game.MapEvtLines:RemoveEvent(11)
evt.map[11] = function()
	evt.EnterHouse{Id = 248}         -- "Fortune's Folly"
end

evt.house[12] = 248  -- "Fortune's Folly"
Game.MapEvtLines:RemoveEvent(12)
evt.map[12] = function()
end

evt.house[13] = 131  -- "Paramount Guild of Fire"
Game.MapEvtLines:RemoveEvent(13)
evt.map[13] = function()
	evt.EnterHouse{Id = 131}         -- "Paramount Guild of Fire"
end

evt.house[14] = 131  -- "Paramount Guild of Fire"
Game.MapEvtLines:RemoveEvent(14)
evt.map[14] = function()
end

evt.house[15] = 14  -- "The Blooded Dagger"
Game.MapEvtLines:RemoveEvent(15)
evt.map[15] = function()
	evt.EnterHouse{Id = 14}         -- "The Blooded Dagger"
end

evt.house[16] = 14  -- "The Blooded Dagger"
Game.MapEvtLines:RemoveEvent(16)
evt.map[16] = function()
end

evt.hint[51] = evt.str[7]  -- "House"
evt.house[52] = 990  -- "Whitesky Residence"
Game.MapEvtLines:RemoveEvent(52)
evt.map[52] = function()
	evt.EnterHouse{Id = 990}         -- "Whitesky Residence"
end

evt.house[53] = 995  -- "Evander's Home"
Game.MapEvtLines:RemoveEvent(53)
evt.map[53] = function()
	evt.EnterHouse{Id = 995}         -- "Evander's Home"
end

evt.house[54] = 996  -- "Anwyn Residence"
Game.MapEvtLines:RemoveEvent(54)
evt.map[54] = function()
	evt.EnterHouse{Id = 996}         -- "Anwyn Residence"
end

evt.house[55] = 997  -- "Silk's Home"
Game.MapEvtLines:RemoveEvent(55)
evt.map[55] = function()
	evt.EnterHouse{Id = 997}         -- "Silk's Home"
end

evt.house[56] = 1002  -- "Dusk's Home"
Game.MapEvtLines:RemoveEvent(56)
evt.map[56] = function()
	evt.EnterHouse{Id = 1002}         -- "Dusk's Home"
end

evt.house[57] = 991  -- "Elmo's House"
Game.MapEvtLines:RemoveEvent(57)
evt.map[57] = function()
	evt.EnterHouse{Id = 991}         -- "Elmo's House"
end

evt.house[58] = 1143  -- "Roggen Residence"
Game.MapEvtLines:RemoveEvent(58)
evt.map[58] = function()
	evt.EnterHouse{Id = 1143}         -- "Roggen Residence"
end

evt.house[59] = 1144  -- "Elzbet's House"
Game.MapEvtLines:RemoveEvent(59)
evt.map[59] = function()
	evt.EnterHouse{Id = 1144}         -- "Elzbet's House"
end

evt.house[60] = 1145  -- "Aznog's Place"
Game.MapEvtLines:RemoveEvent(60)
evt.map[60] = function()
	evt.EnterHouse{Id = 1145}         -- "Aznog's Place"
end

evt.house[61] = 1146  -- "Hollis' Home"
Game.MapEvtLines:RemoveEvent(61)
evt.map[61] = function()
	evt.EnterHouse{Id = 1146}         -- "Hollis' Home"
end

evt.house[62] = 1147  -- "Lanshee's House"
Game.MapEvtLines:RemoveEvent(62)
evt.map[62] = function()
	evt.EnterHouse{Id = 1147}         -- "Lanshee's House"
end

evt.house[63] = 1148  -- "Neldon Residence"
Game.MapEvtLines:RemoveEvent(63)
evt.map[63] = function()
	evt.EnterHouse{Id = 1148}         -- "Neldon Residence"
end

evt.house[64] = 1149  -- "Hawthorne Residence"
Game.MapEvtLines:RemoveEvent(64)
evt.map[64] = function()
	evt.EnterHouse{Id = 1149}         -- "Hawthorne Residence"
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
end

evt.hint[201] = evt.str[3]  -- "Well"
evt.hint[202] = evt.str[4]  -- "Drink from the Well"
Game.MapEvtLines:RemoveEvent(202)
evt.map[202] = function()
	if evt.Cmp{"PlayerBits", Value = 15} then
		evt.StatusText{Str = 11}         -- "Refreshing!"
		return
	end
	if not evt.Cmp{"AutonotesBits", Value = 21} then         -- "2 Skill Points from the well near Offerings and Blessings in Damocles in Mount Nighon. "
		evt.Add{"AutonotesBits", Value = 277}         -- "2 Skill Points from the well near Offerings and Blessings in Damocles in Mount Nighon. "
	end
	evt.Add{"SkillPoints", Value = 2}
	evt.Add{"PlayerBits", Value = 15}
	evt.StatusText{Str = 71}         -- "+2 Skill Points"
end

evt.hint[203] = evt.str[4]  -- "Drink from the Well"
Game.MapEvtLines:RemoveEvent(203)
evt.map[203] = function()
	if evt.Cmp{"PlayerBits", Value = 16} then
		evt.StatusText{Str = 11}         -- "Refreshing!"
		return
	end
	if not evt.Cmp{"AutonotesBits", Value = 22} then         -- "2 points of permanent Personality from the well near Fortune's Folly in Damocles in Mount Nighon."
		evt.Add{"AutonotesBits", Value = 278}         -- "2 points of permanent Personality from the well near Fortune's Folly in Damocles in Mount Nighon."
	end
	evt.Add{"BasePersonality", Value = 2}
	evt.Add{"PlayerBits", Value = 16}
	evt.StatusText{Str = 72}         -- "+2 Personality (Permanent)"
end

evt.hint[204] = evt.str[4]  -- "Drink from the Well"
Game.MapEvtLines:RemoveEvent(204)
evt.map[204] = function()
	if evt.Cmp{"PlayerBits", Value = 17} then
		evt.StatusText{Str = 11}         -- "Refreshing!"
		return
	end
	if not evt.Cmp{"AutonotesBits", Value = 23} then         -- "20 points of temporary Air, Earth, Fire, Water, Body, and Mind resistances from the well near the Fire Guild in Damocles in Mount Nighon."
		evt.Add{"AutonotesBits", Value = 279}         -- "20 points of temporary Air, Earth, Fire, Water, Body, and Mind resistances from the well near the Fire Guild in Damocles in Mount Nighon."
	end
	evt.Add{"FireResBonus", Value = 20}
	evt.Add{"WaterResBonus", Value = 20}
	evt.Add{"BodyResBonus", Value = 20}
	evt.Add{"AirResBonus", Value = 20}
	evt.Add{"EarthResBonus", Value = 20}
	evt.Add{"MindResBonus", Value = 20}
	evt.Add{"PlayerBits", Value = 17}
	evt.StatusText{Str = 73}         -- "+20 All Resistances (Temporary)"
end

Timer(function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	evt.Subtract{"PlayerBits", Value = 17}
end, const.Day, 1*const.Hour)

evt.hint[205] = evt.str[5]  -- "Fountain"
evt.hint[206] = evt.str[6]  -- "Drink from the Fountain"
Game.MapEvtLines:RemoveEvent(206)
evt.map[206] = function()
	if evt.Cmp{"PlayerBits", Value = 14} then
		evt.StatusText{Str = 11}         -- "Refreshing!"
		return
	end
	if not evt.Cmp{"AutonotesBits", Value = 20} then         -- "50 points of temporary Intellect and Personality from the central fountain in Damocles in Mount Nighon."
		evt.Add{"AutonotesBits", Value = 276}         -- "50 points of temporary Intellect and Personality from the central fountain in Damocles in Mount Nighon."
	end
	evt.Add{"PersonalityBonus", Value = 50}
	evt.Add{"IntellectBonus", Value = 50}
	evt.Add{"PlayerBits", Value = 14}
	evt.StatusText{Str = 70}         -- "+50 Intellect and Personality (Temporary)"
end

Timer(function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	evt.Subtract{"PlayerBits", Value = 14}
end, const.Day, 1*const.Hour)

evt.hint[207] = evt.str[4]  -- "Drink from the Well"
Game.MapEvtLines:RemoveEvent(207)
evt.map[207] = function()
	if evt.Cmp{"HasFullSP", Value = 0} then
		evt.StatusText{Str = 11}         -- "Refreshing!"
	else
		evt.Add{"SP", Value = 25}
		evt.StatusText{Str = 74}         -- "+50 Spell Points"
		evt.Add{"AutonotesBits", Value = 280}         -- "50 Spell Points recovered from the well in the eastern village in Mount Nighon."
	end
end

evt.hint[208] = evt.str[4]  -- "Drink from the Well"
Game.MapEvtLines:RemoveEvent(208)
evt.map[208] = function()
	if evt.Cmp{"HasFullHP", Value = 0} then
		evt.StatusText{Str = 11}         -- "Refreshing!"
	else
		evt.Add{"HP", Value = 25}
		evt.StatusText{Str = 75}         -- "+50 Hit Points"
		evt.Add{"AutonotesBits", Value = 281}         -- "50 Hit Points recovered from the well in the western village in Mount Nighon."
	end
end

evt.hint[209] = evt.str[25]  -- "Thunderfist Mountain"
evt.hint[210] = evt.str[26]  -- "The Maze"
evt.hint[451] = evt.str[52]  -- "Shrine"
evt.hint[452] = evt.str[53]  -- "Altar"
Game.MapEvtLines:RemoveEvent(452)
evt.map[452] = function()
	if evt.Cmp{"PlayerBits", Value = 28} then
		evt.StatusText{Str = 54}         -- "You Pray"
	else
		evt.Add{"BasePersonality", Value = 10}
		evt.Add{"BaseIntellect", Value = 10}
		evt.Add{"PlayerBits", Value = 28}
		evt.StatusText{Str = 76}         -- "+10 Personality and Intellect(Permanent)"
	end
end

evt.hint[453] = evt.str[50]  -- "Obelisk"
Game.MapEvtLines:RemoveEvent(453)
evt.map[453] = function()
	if not evt.Cmp{"QBits", Value = 684} then         -- Visited Obelisk in Area 10
		evt.StatusText{Str = 51}         -- "fi_eo_od"
		evt.Add{"AutonotesBits", Value = 317}         -- "Obelisk message #9: fi_eo_od"
		evt.ForPlayer(-- ERROR: Const not found
"All")
		evt.Add{"QBits", Value = 684}         -- Visited Obelisk in Area 10
	end
end

evt.hint[454] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(454)
evt.map[454] = function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	evt.Set{"Dead", Value = 0}
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

evt.hint[501] = evt.str[30]  -- "Enter Thunderfist Mountain"
Game.MapEvtLines:RemoveEvent(501)
evt.map[501] = function()
	evt.MoveToMap{X = -1024, Y = 768, Z = 4097, Direction = 1792, LookAngle = 0, SpeedZ = 0, HouseId = 406, Icon = 9, Name = "7D07.blv"}         -- "Thunderfist Mountain"
end

evt.hint[502] = evt.str[31]  -- "Enter The Maze"
Game.MapEvtLines:RemoveEvent(502)
evt.map[502] = function()
	evt.MoveToMap{X = 1536, Y = -8614, Z = 1, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 407, Icon = 2, Name = "D02.blv"}         -- "The Maze"
end

evt.hint[503] = evt.str[30]  -- "Enter Thunderfist Mountain"
Game.MapEvtLines:RemoveEvent(503)
evt.map[503] = function()
	evt.MoveToMap{X = -11058, Y = 4858, Z = 3969, Direction = 1936, LookAngle = 0, SpeedZ = 0, HouseId = 406, Icon = 9, Name = "7D07.blv"}         -- "Thunderfist Mountain"
end

evt.hint[504] = evt.str[30]  -- "Enter Thunderfist Mountain"
Game.MapEvtLines:RemoveEvent(504)
evt.map[504] = function()
	evt.MoveToMap{X = 9960, Y = 1443, Z = 390, Direction = 148, LookAngle = 0, SpeedZ = 0, HouseId = 406, Icon = 9, Name = "7D07.blv"}         -- "Thunderfist Mountain"
end

evt.hint[505] = evt.str[30]  -- "Enter Thunderfist Mountain"
Game.MapEvtLines:RemoveEvent(505)
evt.map[505] = function()
	evt.MoveToMap{X = 11471, Y = -3498, Z = 2814, Direction = 414, LookAngle = 0, SpeedZ = 0, HouseId = 406, Icon = 9, Name = "7D07.blv"}         -- "Thunderfist Mountain"
end



--[[ MMMerge additions --]]

-- Mount Nighon

function events.AfterLoadMap()
	Party.QBits[825] = true	-- DDMapBuff
end
