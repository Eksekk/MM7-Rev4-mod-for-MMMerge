local TXT = Localize{
	[0] = " ",
	[1] = "Crate",
	[2] = "Barrel",
	[3] = "Well",
	[4] = "Drink from the Well",
	[5] = "Fountain",
	[6] = "Drink from the Fountain",
	[7] = "House",
	[8] = "Trash Heap",
	[9] = "Keg",
	[10] = "Cart",
	[11] = "Refreshing!",
	[12] = "Boat",
	[13] = "Dock",
	[14] = "Anvil",
	[15] = "Button",
	[16] = "Chest",
	[17] = "Event 46",
	[18] = "Event 1",
	[19] = "Fruit Tree",
	[20] = "Door",
	[21] = "This Door is Locked",
	[22] = "+50 Fire Resistance temporary.",
	[23] = "+5 Hit points restored.",
	[24] = "+5 Spell points restored.",
	[25] = "+2 Luck permanent",
	[26] = "Event 15",
	[27] = "Event 29",
	[28] = "Event 42",
	[29] = "Event 74",
	[30] = "Enter The Temple of the Moon",
	[31] = "Enter the Dragon's Cave",
	[32] = "Event 89",
	[33] = "Event 107",
	[34] = "Event 139",
	[35] = "Temple",
	[36] = "Guilds",
	[37] = "Stables",
	[38] = "Docks",
	[39] = "Shops",
	[40] = "Lord Markham",
	[41] = "This cave is sealed by a powerful magical ward.",
	[42] = "Enjoy 'The Game'",
	[43] = "",
	[44] = "",
	[45] = "",
	[46] = "Welcome to Emerald Isle",
	[47] = "",
	[48] = "",
	[49] = "",
	[50] = "Obelisk",
	[51] = "Nothing Seems to have happened",
	[52] = "Shrine",
	[53] = "Alter",
	[54] = "You Pray",
}
table.copy(TXT, evt.str, true)

-- REMOVED BY REV4 FOR MERGE
-- Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.hint[1] = evt.str[46]  -- "Welcome to Emerald Isle"
Game.MapEvtLines:RemoveEvent(2)
evt.HouseDoor(2, 8)  -- "The Knight's Blade"
evt.house[3] = 8  -- "The Knight's Blade"
Game.MapEvtLines:RemoveEvent(4)
evt.HouseDoor(4, 43)  -- "Erik's Armory"
evt.house[5] = 43  -- "Erik's Armory"
Game.MapEvtLines:RemoveEvent(6)
evt.HouseDoor(6, 84)  -- "Emerald Enchantments"
evt.house[7] = 84  -- "Emerald Enchantments"
Game.MapEvtLines:RemoveEvent(8)
evt.HouseDoor(8, 116)  -- "The Blue Bottle"
evt.house[9] = 116  -- "The Blue Bottle"
Game.MapEvtLines:RemoveEvent(10)
evt.HouseDoor(10, 310)  -- "Healer's Tent"
evt.house[11] = 310  -- "Healer's Tent"
Game.MapEvtLines:RemoveEvent(12)
evt.HouseDoor(12, 1570)  -- "Island Training Grounds"
evt.house[13] = 1570  -- "Island Training Grounds"
Game.MapEvtLines:RemoveEvent(14)
evt.HouseDoor(14, 239)  -- "Two Palms Tavern"
evt.house[15] = 239  -- "Two Palms Tavern"
Game.MapEvtLines:RemoveEvent(16)
evt.HouseDoor(16, 128)  -- "Initiate Guild of Fire"
evt.house[17] = 128  -- "Initiate Guild of Fire"
Game.MapEvtLines:RemoveEvent(18)
evt.HouseDoor(18, 134)  -- "Initiate Guild of Air"
evt.house[19] = 134  -- "Initiate Guild of Air"
Game.MapEvtLines:RemoveEvent(20)
evt.HouseDoor(20, 152)  -- "Initiate Guild of Spirit"
evt.house[21] = 152  -- "Initiate Guild of Spirit"
Game.MapEvtLines:RemoveEvent(22)
evt.HouseDoor(22, 164)  -- "Initiate Guild of Body"
evt.house[23] = 164  -- "Initiate Guild of Body"
Game.MapEvtLines:RemoveEvent(24)
evt.HouseDoor(24, 1168)  -- "The Lady Margaret"
evt.house[25] = 485  -- "Lady Margaret"
evt.hint[26] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(26)
evt.map[26] = function()  -- function events.LoadMap()
	evt.Subtract("NPCs", 342)         -- "Big Daddy Jim"
end

events.LoadMap = evt.map[26].last

evt.hint[37] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(37)
evt.map[37] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 806) then         -- Return to EI
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 10, X = 3244, Y = 9265, Z = 900, -- ERROR: Not found
NPCGroup = 563, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = 4406, Y = 8851, Z = 900, -- ERROR: Not found
NPCGroup = 563, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 8, X = 500, Y = 8191, Z = 700, -- ERROR: Not found
NPCGroup = 563, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 8, X = 5893, Y = 8379, Z = 400, -- ERROR: Not found
NPCGroup = 563, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 10, X = 6758, Y = 8856, Z = 0, -- ERROR: Not found
NPCGroup = 563, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = 7738, Y = 7005, Z = 0, -- ERROR: Not found
NPCGroup = 563, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 6, X = 8402, Y = 7527, Z = 0, -- ERROR: Not found
NPCGroup = 563, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 5, X = 9881, Y = 7481, Z = 0, -- ERROR: Not found
NPCGroup = 563, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 4, X = 11039, Y = 7117, Z = 0, -- ERROR: Not found
NPCGroup = 563, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 7, X = 12360, Y = 6764, Z = 0, -- ERROR: Not found
NPCGroup = 563, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 4, X = 13389, Y = 6797, Z = 0, -- ERROR: Not found
NPCGroup = 563, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = 14777, Y = 6911, Z = 0, -- ERROR: Not found
NPCGroup = 563, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 7, X = 12560, Y = 5717, Z = 0, -- ERROR: Not found
NPCGroup = 563, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 5, X = 12438, Y = 4787, Z = 170, -- ERROR: Not found
NPCGroup = 563, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = 12481, Y = 3299, Z = 0, -- ERROR: Not found
NPCGroup = 563, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 7, X = 12674, Y = 2105, Z = 0, -- ERROR: Not found
NPCGroup = 563, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 4, X = 11248, Y = 2852, Z = 0, -- ERROR: Not found
NPCGroup = 563, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 6, X = 9585, Y = 5015, Z = 0, -- ERROR: Not found
NPCGroup = 563, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 3, X = 12205, Y = 4919, Z = 170, -- ERROR: Not found
NPCGroup = 2098, unk = 0}
		evt.Subtract("QBits", 806)         -- Return to EI
		evt.SpeakNPC(356)         -- "Sally"
	end
end

events.LoadMap = evt.map[37].last

evt.hint[49] = evt.str[7]  -- "House"
Game.MapEvtLines:RemoveEvent(50)
evt.HouseDoor(50, 1167)  -- "Donna Wyrith's Residence"
Game.MapEvtLines:RemoveEvent(51)
evt.HouseDoor(51, 1170)  -- "Mia Lucille' Home"
Game.MapEvtLines:RemoveEvent(52)
evt.HouseDoor(52, 1171)  -- "Zedd's Place"
Game.MapEvtLines:RemoveEvent(53)
evt.HouseDoor(53, 1608)  -- "House 227"
Game.MapEvtLines:RemoveEvent(54)
evt.HouseDoor(54, 1173)  -- "House 228"
Game.MapEvtLines:RemoveEvent(55)
evt.HouseDoor(55, 1174)  -- "House 229"
Game.MapEvtLines:RemoveEvent(56)
evt.HouseDoor(56, 1183)  -- "Carolyn Weathers' House"
Game.MapEvtLines:RemoveEvent(57)
evt.HouseDoor(57, 1184)  -- "Tellmar Residence"
Game.MapEvtLines:RemoveEvent(58)
evt.HouseDoor(58, 1185)  -- "House 241"
Game.MapEvtLines:RemoveEvent(59)
evt.HouseDoor(59, 1186)  -- "House 242"
Game.MapEvtLines:RemoveEvent(60)
evt.HouseDoor(60, 1198)  -- "House 254"
Game.MapEvtLines:RemoveEvent(61)
evt.HouseDoor(61, 1199)  -- "House 255"
Game.MapEvtLines:RemoveEvent(62)
evt.HouseDoor(62, 1199)  -- "House 255"
evt.hint[63] = evt.str[14]  -- "Anvil"
evt.hint[64] = evt.str[10]  -- "Cart"
evt.hint[65] = evt.str[9]  -- "Keg"
Game.MapEvtLines:RemoveEvent(66)
evt.HouseDoor(66, 1163)  -- "Markham's Headquarters"
evt.house[67] = 1163  -- "Markham's Headquarters"
evt.hint[68] = evt.str[36]  -- "Guilds"
evt.hint[69] = evt.str[39]  -- "Shops"
evt.hint[70] = evt.str[40]  -- "Lord Markham"
evt.hint[101] = evt.str[30]  -- "Enter The Temple of the Moon"
Game.MapEvtLines:RemoveEvent(101)
evt.map[101] = function()
	evt.MoveToMap{X = -1208, Y = -4225, Z = 366, Direction = 320, LookAngle = 0, SpeedZ = 0, HouseId = 387, Icon = 3, Name = "7D06.blv"}         -- "Temple of the Moon"
end

evt.hint[102] = evt.str[31]  -- "Enter the Dragon's Cave"
Game.MapEvtLines:RemoveEvent(102)
evt.map[102] = function()
	if evt.Cmp("Inventory", 1364) then         -- "Ring of UnWarding"
		evt.MoveToMap{X = 752, Y = 2229, Z = 1, Direction = 1012, LookAngle = 0, SpeedZ = 0, HouseId = 389, Icon = 3, Name = "7D28.Blv"}         -- "Dragon's Lair"
	else
		evt.StatusText(41)         -- "This cave is sealed by a powerful magical ward."
	end
end

evt.hint[109] = evt.str[3]  -- "Well"
evt.hint[110] = evt.str[4]  -- "Drink from the Well"
Game.MapEvtLines:RemoveEvent(110)
evt.map[110] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 828) then         -- 1-time EI Well
		evt.Set("QBits", 828)         -- 1-time EI Well
		evt.Add("BaseEndurance", 32)
		evt.Add("SkillPoints", 5)
	elseif evt.Cmp("FireResBonus", 50) then
		evt.StatusText(11)         -- "Refreshing!"
	else
		evt.Set("FireResBonus", 50)
		evt.StatusText(22)         -- "+50 Fire Resistance temporary."
		evt.Add("AutonotesBits", 258)         -- "50 points of temporary Fire resistance from the central town well on Emerald Island."
	end
end

Game.MapEvtLines:RemoveEvent(111)
evt.map[111] = function()  -- RefillTimer(<function>, const.Day)
	evt.Set("MapVar0", 30)
	evt.Set("MapVar1", 30)
end

RefillTimer(evt.map[111].last, const.Day)

evt.hint[112] = evt.str[4]  -- "Drink from the Well"
Game.MapEvtLines:RemoveEvent(112)
evt.map[112] = function()
	if evt.Cmp("MapVar0", 1) then
		evt.Subtract("MapVar0", 1)
		evt.Add("HP", 5)
		evt.Add("AutonotesBits", 259)         -- "5 Hit Points regained from the well east of the Temple on Emerald Island."
		evt.StatusText(23)         -- "+5 Hit points restored."
	else
		evt.StatusText(11)         -- "Refreshing!"
	end
end

evt.hint[113] = evt.str[4]  -- "Drink from the Well"
Game.MapEvtLines:RemoveEvent(113)
evt.map[113] = function()
	if evt.Cmp("MapVar1", 1) then
		evt.Subtract("MapVar1", 1)
		evt.Add("SP", 5)
		evt.StatusText(24)         -- "+5 Spell points restored."
	else
		evt.StatusText(11)         -- "Refreshing!"
	end
	evt.Set("AutonotesBits", 260)         -- "5 Spell Points regained from the well west of the Temple on Emerald Island."
end

evt.hint[114] = evt.str[4]  -- "Drink from the Well"
Game.MapEvtLines:RemoveEvent(114)
evt.map[114] = function()
	if evt.Cmp("QBits", 536) then         -- "Find the Blessed Panoply of Sir BunGleau and return to the Angel in Castle Harmondale""
		goto _15
	end
	if evt.Cmp("QBits", 538) then         -- "Find the Blessed Panoply of Sir BunGleau and return  to William Setag in the Deyja Moors."
		goto _15
	end
	if not evt.Cmp("BaseLuck", 15) then
		if evt.Cmp("MapVar2", 1) then
			evt.Subtract("MapVar2", 1)
			evt.Add("BaseLuck", 2)
			evt.StatusText(25)         -- "+2 Luck permanent"
			return
		end
	end
	evt.StatusText(11)         -- "Refreshing!"
	do return end
::_15::
	evt.MoveToMap{X = 9828, Y = 6144, Z = 97, Direction = 2047, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "mdt09.blv"}
end

RefillTimer(function()
	evt.Set("MapVar2", 8)
end, const.Month)

evt.hint[115] = evt.str[4]  -- "Drink from the Well"
Game.MapEvtLines:RemoveEvent(115)
evt.map[115] = function()
	if not evt.Cmp("MapVar4", 3) then
		if not evt.Cmp("MapVar3", 1) then
			if not evt.Cmp("Gold", 201) then
				if evt.Cmp("BaseLuck", 15) then
					evt.Add("MapVar3", 1)
					evt.Add("Gold", 1000)
					evt.Add("MapVar4", 1)
					return
				end
			end
		end
	end
	evt.StatusText(11)         -- "Refreshing!"
end

RefillTimer(function()
	evt.Set("MapVar3", 0)
end, const.Week)

evt.hint[118] = evt.str[1]  -- "Crate"
Game.MapEvtLines:RemoveEvent(118)
evt.map[118] = function()
	evt.OpenChest(1)
end

evt.hint[119] = evt.str[1]  -- "Crate"
Game.MapEvtLines:RemoveEvent(119)
evt.map[119] = function()
	evt.OpenChest(2)
end

evt.hint[120] = evt.str[1]  -- "Crate"
Game.MapEvtLines:RemoveEvent(120)
evt.map[120] = function()
	evt.OpenChest(3)
end

evt.hint[121] = evt.str[1]  -- "Crate"
Game.MapEvtLines:RemoveEvent(121)
evt.map[121] = function()
	evt.OpenChest(4)
end

evt.hint[122] = evt.str[1]  -- "Crate"
Game.MapEvtLines:RemoveEvent(122)
evt.map[122] = function()
	evt.OpenChest(5)
end

evt.hint[123] = evt.str[1]  -- "Crate"
Game.MapEvtLines:RemoveEvent(123)
evt.map[123] = function()
	evt.OpenChest(6)
end

evt.hint[124] = evt.str[16]  -- "Chest"
Game.MapEvtLines:RemoveEvent(124)
evt.map[124] = function()
	evt.OpenChest(7)
end

Game.MapEvtLines:RemoveEvent(200)
evt.map[200] = function()
	if not evt.Cmp("QBits", 529) then         -- No more docent babble
		evt.SpeakNPC(342)         -- "Big Daddy Jim"
	end
	evt.Set("QBits", 529)         -- No more docent babble
end

Game.MapEvtLines:RemoveEvent(201)
evt.map[201] = function()
	if not evt.Cmp("QBits", 529) then         -- No more docent babble
		evt.SpeakNPC(359)         -- "Baron BunGleau"
	end
end

Game.MapEvtLines:RemoveEvent(202)
evt.map[202] = function()
	if not evt.Cmp("QBits", 529) then         -- No more docent babble
		evt.SpeakNPC(360)         -- "Zedd True Shot"
	end
end

Game.MapEvtLines:RemoveEvent(203)
evt.map[203] = function()
	if not evt.Cmp("QBits", 529) then         -- No more docent babble
		evt.SpeakNPC(361)         -- "Alex the Mentor"
	end
end

Game.MapEvtLines:RemoveEvent(204)
evt.map[204] = function()
	if not evt.Cmp("QBits", 529) then         -- No more docent babble
		evt.SpeakNPC(362)         -- "Alex the Mentor"
	end
end

Game.MapEvtLines:RemoveEvent(205)
evt.map[205] = function()
	if not evt.Cmp("QBits", 529) then         -- No more docent babble
		evt.SpeakNPC(363)         -- "Alex the Mentor"
	end
end

Game.MapEvtLines:RemoveEvent(206)
evt.map[206] = function()
	if not evt.Cmp("QBits", 529) then         -- No more docent babble
		evt.SpeakNPC(364)         -- "Operator"
	end
end

Game.MapEvtLines:RemoveEvent(207)
evt.map[207] = function()
	if not evt.Cmp("QBits", 529) then         -- No more docent babble
		evt.SpeakNPC(365)         -- "Count ZERO"
	end
end

Game.MapEvtLines:RemoveEvent(208)
evt.map[208] = function()
	if not evt.Cmp("QBits", 529) then         -- No more docent babble
		evt.SpeakNPC(366)         -- "Messenger"
	end
end

Game.MapEvtLines:RemoveEvent(209)
evt.map[209] = function()
	if not evt.Cmp("QBits", 529) then         -- No more docent babble
		evt.SpeakNPC(367)         -- "Alex the Mentor"
	end
end

Game.MapEvtLines:RemoveEvent(210)
evt.map[210] = function()
	if not evt.Cmp("QBits", 529) then         -- No more docent babble
		evt.SpeakNPC(368)         -- "Alex the Mentor"
	end
end

Game.MapEvtLines:RemoveEvent(211)
evt.map[211] = function()
	if not evt.Cmp("QBits", 529) then         -- No more docent babble
		evt.SpeakNPC(369)         -- "Doom Bearer"
	end
end

Game.MapEvtLines:RemoveEvent(212)
evt.map[212] = function()
	if not evt.Cmp("QBits", 529) then         -- No more docent babble
		evt.SpeakNPC(370)         -- "Alex the Mentor"
	end
end

Game.MapEvtLines:RemoveEvent(213)
evt.map[213] = function()
	if not evt.Cmp("QBits", 529) then         -- No more docent babble
		evt.SpeakNPC(371)         -- "Myrta Bumblebee"
	end
end

Game.MapEvtLines:RemoveEvent(214)
evt.map[214] = function()
	if not evt.Cmp("QBits", 529) then         -- No more docent babble
		evt.SpeakNPC(372)         -- "Alex the Mentor"
	end
end

Game.MapEvtLines:RemoveEvent(215)
evt.map[215] = function()
	if not evt.Cmp("QBits", 529) then         -- No more docent babble
		evt.SpeakNPC(373)         -- "Duke Bimbasto"
	end
end

Game.MapEvtLines:RemoveEvent(216)
evt.map[216] = function()
	if not evt.Cmp("QBits", 529) then         -- No more docent babble
		evt.SpeakNPC(374)         -- "Sir Vilx of Stone City"
	end
end

Game.MapEvtLines:RemoveEvent(217)
evt.map[217] = function()
	if not evt.Cmp("QBits", 529) then         -- No more docent babble
		evt.SpeakNPC(375)         -- "Alex the Mentor"
	end
end

Game.MapEvtLines:RemoveEvent(218)
evt.map[218] = function()
	if not evt.Cmp("QBits", 529) then         -- No more docent babble
		evt.SpeakNPC(376)         -- "Pascal the Mad Mage"
	end
end

evt.hint[219] = evt.str[15]  -- "Button"
Game.MapEvtLines:RemoveEvent(219)
evt.map[219] = function()
	evt.CastSpell{Spell = 43, Mastery = const.GM, Skill = 10, FromX = 10495, FromY = 17724, FromZ = 2370, ToX = 10495, ToY = 24144, ToZ = 4500}         -- "Death Blossom"
end

evt.hint[220] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(220)
evt.map[220] = function()  -- RefillTimer(<function>, const.Day)
	if evt.CheckMonstersKilled{CheckType = 1, Id = 71, Count = 0} then
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 10, X = -336, Y = 14512, Z = 0, NPCGroup = 71, unk = 0}         -- "Ridge walkers in Bracada"
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 5, X = 16, Y = 16352, Z = 90, NPCGroup = 71, unk = 0}         -- "Ridge walkers in Bracada"
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 10, X = 480, Y = 18288, Z = 6, NPCGroup = 71, unk = 0}         -- "Ridge walkers in Bracada"
	end
end

RefillTimer(evt.map[220].last, const.Day)

Game.MapEvtLines:RemoveEvent(573)
evt.map[573] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 1540) then         -- "Lost Scroll of Wonka"
		evt.SetMessage(2850)
		return
	end
	evt.SetMessage(2851)
	evt.ForPlayer(3)
	if evt.Cmp("FireSkill", 1) then
		evt.Set("FireSkill", 49152)
		evt.Set("FireSkill", 8)
	end
	evt.ForPlayer(2)
	if evt.Cmp("FireSkill", 1) then
		evt.Set("FireSkill", 49152)
		evt.Set("FireSkill", 8)
	end
	evt.ForPlayer(1)
	if evt.Cmp("FireSkill", 1) then
		evt.Set("FireSkill", 49152)
		evt.Set("FireSkill", 8)
	end
	evt.ForPlayer(0)
	if evt.Cmp("FireSkill", 1) then
		evt.Set("FireSkill", 49152)
		evt.Set("FireSkill", 8)
	end
	evt.ForPlayer("All")
	evt.Subtract("QBits", 784)         -- "Find the Lost Scroll of Wonka and return it to Blayze on Emerald Island."
	evt.Subtract("Inventory", 1540)         -- "Lost Scroll of Wonka"
	evt.Add("Awards", 129)         -- "Recovered the Lost Scroll of  Wonka"
	Game.NPC[478].Events[1] = 0         -- "Blayze "
	evt.Add("Experience", 40000)
end

Game.MapEvtLines:RemoveEvent(574)
evt.map[574] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 1361) then         -- "Watcher's Ring of Elemental Water"
		evt.SetMessage(2854)
		Game.NPC[483].Events[0] = 2002         -- "Tobren Rainshield" : "The Greatest Hero"
		return
	end
	if not evt.Cmp("Inventory", 1128) then         -- "Water Walk"
		evt.ForPlayer("Current")
		evt.Add("Inventory", 1128)         -- "Water Walk"
	end
	evt.SetMessage(2853)
end

Game.MapEvtLines:RemoveEvent(575)
evt.map[575] = function()
	evt.ForPlayer("Current")
	if evt.Cmp("WaterSkill", 136) then
		evt.SetMessage(1068)
	elseif not evt.Cmp("WaterSkill", 72) then
		evt.SetMessage(1064)
	elseif evt.Cmp("Gold", 3000) then
		evt.Add("WaterSkill", 128)
		evt.Subtract("Gold", 3000)
		evt.SetMessage(1071)
	else
		evt.SetMessage(1063)
	end
end

	-- starting QBits
	evt.map[100] = function()  -- function events.LoadMap()
		local add = true
		for qb = 513, 519 do
			if Party.QBits[qb] then
				add = false
				break
			end
		end
		if add then
			for qb = 513, 518 do
				evt.Add("QBits", qb) -- evt to show flash on PC faces
			end
			evt.ShowMovie{DoubleSize = 1, Name = "\"intro post\""}
		end
	end

	events.LoadMap = evt.map[100].last

--[[ MMMerge additions ]]--

-- Emerald Island

function events.AfterLoadMap()
	Party.QBits[936] = true	-- DDMapBuff, changed for rev4 for merge
end

-- Remove arcomage from Emerald Island's taverns
function events.DrawShopTopics(t)
	if t.HouseType == const.HouseType.Tavern then
		t.Handled = true
		t.NewTopics[1] = const.ShopTopics.RentRoom
		t.NewTopics[2] = const.ShopTopics.BuyFood
		t.NewTopics[3] = const.ShopTopics.Learn
	end
end
