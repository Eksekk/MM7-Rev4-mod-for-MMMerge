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

-- REMOVED BY REV4 FOR MERGE
-- Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.hint[1] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(1)
evt.map[1] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 723) then         -- Nighon - Town Portal
		evt.Add("QBits", 723)         -- Nighon - Town Portal
	end
	evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
	evt.ChangeGroupAlly{NPCGroup = 26, Ally = 74}         -- "Peasents in main town of nighon"
	evt.ChangeGroupAlly{NPCGroup = 27, Ally = 74}         -- "Peasents in western town of Nighon"
end

events.LoadMap = evt.map[1].last

Game.MapEvtLines:RemoveEvent(3)
evt.HouseDoor(3, 54)  -- "The Tannery"
evt.house[4] = 54  -- "The Tannery"
Game.MapEvtLines:RemoveEvent(5)
evt.HouseDoor(5, 92)  -- "Arcane Items"
evt.house[6] = 92  -- "Arcane Items"
Game.MapEvtLines:RemoveEvent(7)
evt.HouseDoor(7, 318)  -- "Offerings and Blessings"
evt.house[8] = 318  -- "Offerings and Blessings"
Game.MapEvtLines:RemoveEvent(9)
evt.HouseDoor(9, 1576)  -- "Applied Instruction"
evt.house[10] = 1576  -- "Applied Instruction"
Game.MapEvtLines:RemoveEvent(11)
evt.HouseDoor(11, 248)  -- "Fortune's Folly"
evt.house[12] = 248  -- "Fortune's Folly"
Game.MapEvtLines:RemoveEvent(13)
evt.HouseDoor(13, 131)  -- "Paramount Guild of Fire"
evt.house[14] = 131  -- "Paramount Guild of Fire"
Game.MapEvtLines:RemoveEvent(15)
evt.HouseDoor(15, 14)  -- "The Blooded Dagger"
evt.house[16] = 14  -- "The Blooded Dagger"
evt.hint[51] = evt.str[7]  -- "House"
Game.MapEvtLines:RemoveEvent(52)
evt.HouseDoor(52, 990)  -- "Whitesky Residence"
Game.MapEvtLines:RemoveEvent(53)
evt.HouseDoor(53, 995)  -- "Evander's Home"
Game.MapEvtLines:RemoveEvent(54)
evt.HouseDoor(54, 996)  -- "Anwyn Residence"
Game.MapEvtLines:RemoveEvent(55)
evt.HouseDoor(55, 997)  -- "Silk's Home"
Game.MapEvtLines:RemoveEvent(56)
evt.HouseDoor(56, 1002)  -- "Dusk's Home"
Game.MapEvtLines:RemoveEvent(57)
evt.HouseDoor(57, 991)  -- "Elmo's House"
Game.MapEvtLines:RemoveEvent(58)
evt.HouseDoor(58, 1143)  -- "Roggen Residence"
Game.MapEvtLines:RemoveEvent(59)
evt.HouseDoor(59, 1144)  -- "Elzbet's House"
Game.MapEvtLines:RemoveEvent(60)
evt.HouseDoor(60, 1145)  -- "Aznog's Place"
Game.MapEvtLines:RemoveEvent(61)
evt.HouseDoor(61, 1146)  -- "Hollis' Home"
Game.MapEvtLines:RemoveEvent(62)
evt.HouseDoor(62, 1147)  -- "Lanshee's House"
Game.MapEvtLines:RemoveEvent(63)
evt.HouseDoor(63, 1148)  -- "Neldon Residence"
Game.MapEvtLines:RemoveEvent(64)
evt.HouseDoor(64, 1149)  -- "Hawthorne Residence"
evt.hint[151] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(151)
evt.map[151] = function()
	evt.OpenChest(1)
end

evt.hint[152] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(152)
evt.map[152] = function()
	evt.OpenChest(2)
end

evt.hint[153] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(153)
evt.map[153] = function()
	evt.OpenChest(3)
end

evt.hint[154] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(154)
evt.map[154] = function()
	evt.OpenChest(4)
end

evt.hint[155] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(155)
evt.map[155] = function()
	evt.OpenChest(5)
end

evt.hint[156] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(156)
evt.map[156] = function()
	evt.OpenChest(6)
end

evt.hint[157] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(157)
evt.map[157] = function()
	evt.OpenChest(7)
end

evt.hint[158] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(158)
evt.map[158] = function()
	evt.OpenChest(8)
end

evt.hint[159] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(159)
evt.map[159] = function()
	evt.OpenChest(9)
end

evt.hint[160] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(160)
evt.map[160] = function()
	evt.OpenChest(10)
end

evt.hint[161] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(161)
evt.map[161] = function()
	evt.OpenChest(11)
end

evt.hint[162] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(162)
evt.map[162] = function()
	evt.OpenChest(12)
end

evt.hint[163] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(163)
evt.map[163] = function()
	evt.OpenChest(13)
end

evt.hint[164] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(164)
evt.map[164] = function()
	evt.OpenChest(14)
end

evt.hint[165] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(165)
evt.map[165] = function()
	evt.OpenChest(15)
end

evt.hint[166] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(166)
evt.map[166] = function()
	evt.OpenChest(16)
end

evt.hint[167] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(167)
evt.map[167] = function()
	evt.OpenChest(17)
end

evt.hint[168] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(168)
evt.map[168] = function()
	evt.OpenChest(18)
end

evt.hint[169] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(169)
evt.map[169] = function()
	evt.OpenChest(19)
end

evt.hint[170] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(170)
evt.map[170] = function()
	evt.OpenChest(0)
end

evt.hint[201] = evt.str[3]  -- "Well"
evt.hint[202] = evt.str[4]  -- "Drink from the Well"
Game.MapEvtLines:RemoveEvent(202)
evt.map[202] = function()
	if evt.Cmp("PlayerBits", 15) then
		evt.StatusText(11)         -- "Refreshing!"
		return
	end
	if not evt.Cmp("AutonotesBits", 277) then         -- "2 Skill Points from the well near Offerings and Blessings in Damocles in Mount Nighon. "
		evt.Add("AutonotesBits", 277)         -- "2 Skill Points from the well near Offerings and Blessings in Damocles in Mount Nighon. "
	end
	evt.Add("SkillPoints", 2)
	evt.Add("PlayerBits", 15)
	evt.StatusText(71)         -- "+2 Skill Points"
end

evt.hint[203] = evt.str[4]  -- "Drink from the Well"
Game.MapEvtLines:RemoveEvent(203)
evt.map[203] = function()
	if evt.Cmp("PlayerBits", 16) then
		evt.StatusText(11)         -- "Refreshing!"
		return
	end
	if not evt.Cmp("AutonotesBits", 278) then         -- "2 points of permanent Personality from the well near Fortune's Folly in Damocles in Mount Nighon."
		evt.Add("AutonotesBits", 278)         -- "2 points of permanent Personality from the well near Fortune's Folly in Damocles in Mount Nighon."
	end
	evt.Add("BasePersonality", 2)
	evt.Add("PlayerBits", 16)
	evt.StatusText(72)         -- "+2 Personality (Permanent)"
end

evt.hint[204] = evt.str[4]  -- "Drink from the Well"
Game.MapEvtLines:RemoveEvent(204)
evt.map[204] = function()
	if evt.Cmp("PlayerBits", 17) then
		evt.StatusText(11)         -- "Refreshing!"
		return
	end
	if not evt.Cmp("AutonotesBits", 279) then         -- "20 points of temporary Air, Earth, Fire, Water, Body, and Mind resistances from the well near the Fire Guild in Damocles in Mount Nighon."
		evt.Add("AutonotesBits", 279)         -- "20 points of temporary Air, Earth, Fire, Water, Body, and Mind resistances from the well near the Fire Guild in Damocles in Mount Nighon."
	end
	evt.Add("FireResBonus", 20)
	evt.Add("WaterResBonus", 20)
	evt.Add("BodyResBonus", 20)
	evt.Add("AirResBonus", 20)
	evt.Add("EarthResBonus", 20)
	evt.Add("MindResBonus", 20)
	evt.Add("PlayerBits", 17)
	evt.StatusText(73)         -- "+20 All Resistances (Temporary)"
end

RefillTimer(function()
	evt.ForPlayer("All")
	evt.Subtract("PlayerBits", 17)
end, const.Day)

evt.hint[205] = evt.str[5]  -- "Fountain"
evt.hint[206] = evt.str[6]  -- "Drink from the Fountain"
Game.MapEvtLines:RemoveEvent(206)
evt.map[206] = function()
	if evt.Cmp("PlayerBits", 14) then
		evt.StatusText(11)         -- "Refreshing!"
		return
	end
	if not evt.Cmp("AutonotesBits", 276) then         -- "50 points of temporary Intellect and Personality from the central fountain in Damocles in Mount Nighon."
		evt.Add("AutonotesBits", 276)         -- "50 points of temporary Intellect and Personality from the central fountain in Damocles in Mount Nighon."
	end
	evt.Add("PersonalityBonus", 50)
	evt.Add("IntellectBonus", 50)
	evt.Add("PlayerBits", 14)
	evt.StatusText(70)         -- "+50 Intellect and Personality (Temporary)"
end

RefillTimer(function()
	evt.ForPlayer("All")
	evt.Subtract("PlayerBits", 14)
end, const.Day)

evt.hint[207] = evt.str[4]  -- "Drink from the Well"
Game.MapEvtLines:RemoveEvent(207)
evt.map[207] = function()
	if evt.Cmp("HasFullSP", 0) then
		evt.StatusText(11)         -- "Refreshing!"
	else
		evt.Add("SP", 25)
		evt.StatusText(74)         -- "+50 Spell Points"
		evt.Add("AutonotesBits", 280)         -- "50 Spell Points recovered from the well in the eastern village in Mount Nighon."
	end
end

evt.hint[208] = evt.str[4]  -- "Drink from the Well"
Game.MapEvtLines:RemoveEvent(208)
evt.map[208] = function()
	if evt.Cmp("HasFullHP", 0) then
		evt.StatusText(11)         -- "Refreshing!"
	else
		evt.Add("HP", 25)
		evt.StatusText(75)         -- "+50 Hit Points"
		evt.Add("AutonotesBits", 281)         -- "50 Hit Points recovered from the well in the western village in Mount Nighon."
	end
end

evt.hint[209] = evt.str[25]  -- "Thunderfist Mountain"
evt.hint[210] = evt.str[26]  -- "The Maze"
evt.hint[451] = evt.str[52]  -- "Shrine"
evt.hint[452] = evt.str[53]  -- "Altar"
Game.MapEvtLines:RemoveEvent(452)
evt.map[452] = function()
	if evt.Cmp("PlayerBits", 28) then
		evt.StatusText(54)         -- "You Pray"
	else
		evt.Add("BasePersonality", 10)
		evt.Add("BaseIntellect", 10)
		evt.Add("PlayerBits", 28)
		evt.StatusText(76)         -- "+10 Personality and Intellect(Permanent)"
	end
end

evt.hint[453] = evt.str[50]  -- "Obelisk"
Game.MapEvtLines:RemoveEvent(453)
evt.map[453] = function()
	if not evt.Cmp("QBits", 684) then         -- Visited Obelisk in Area 10
		evt.StatusText(51)         -- "fi_eo_od"
		evt.Add("AutonotesBits", 317)         -- "Obelisk message #9: fi_eo_od"
		evt.ForPlayer("All")
		evt.Add("QBits", 684)         -- Visited Obelisk in Area 10
	end
end

evt.hint[454] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(454)
evt.map[454] = function()
	evt.ForPlayer("All")
	evt.Set("Dead", 0)
end

evt.hint[500] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(500)
evt.map[500] = function()
	if not evt.CheckSeason(3) then
		if not evt.CheckSeason(2) then
			if not evt.CheckSeason(1) then
				evt.CheckSeason(0)
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
	evt.MoveToMap{X = 9960, Y = 1443, Z = 390, Direction = 1936, LookAngle = 0, SpeedZ = 0, HouseId = 406, Icon = 9, Name = "7D07.blv"}         -- "Thunderfist Mountain"
end

evt.hint[504] = evt.str[30]  -- "Enter Thunderfist Mountain"
Game.MapEvtLines:RemoveEvent(504)
evt.map[504] = function()
	evt.MoveToMap{X = -11058, Y = 4858, Z = 3969, Direction = 1920, LookAngle = 0, SpeedZ = 0, HouseId = 406, Icon = 9, Name = "7D07.blv"}         -- "Thunderfist Mountain"
end

evt.hint[505] = evt.str[30]  -- "Enter Thunderfist Mountain"
Game.MapEvtLines:RemoveEvent(505)
evt.map[505] = function()
	evt.MoveToMap{X = 11471, Y = -3498, Z = 2814, Direction = 414, LookAngle = 0, SpeedZ = 0, HouseId = 406, Icon = 9, Name = "7D07.blv"}         -- "Thunderfist Mountain"
end



--[[ MMMerge additions ]]--

-- Mount Nighon
local MF = Merge.Functions

function events.AfterLoadMap()
	Party.QBits[721] = true	-- TP Buff Nighon
	Party.QBits[945] = true	-- DDMapBuff, changed for rev4 for merge
end

-- Town Portal fountain
evt.map[206] = function()
	MF.SetLastFountain()
end
