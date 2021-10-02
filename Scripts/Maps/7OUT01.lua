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


evt.hint[1] = evt.str[46]  -- "Welcome to Emerald Isle"
evt.house[2] = 8  -- "The Knight's Blade"
Game.MapEvtLines:RemoveEvent(2)
evt.map[2] = function()
	evt.EnterHouse{Id = 8}         -- "The Knight's Blade"
end

evt.house[3] = 8  -- "The Knight's Blade"
Game.MapEvtLines:RemoveEvent(3)
evt.map[3] = function()
end

evt.house[4] = 43  -- "Erik's Armory"
Game.MapEvtLines:RemoveEvent(4)
evt.map[4] = function()
	evt.EnterHouse{Id = 43}         -- "Erik's Armory"
end

evt.house[5] = 43  -- "Erik's Armory"
Game.MapEvtLines:RemoveEvent(5)
evt.map[5] = function()
end

evt.house[6] = 84  -- "Emerald Enchantments"
Game.MapEvtLines:RemoveEvent(6)
evt.map[6] = function()
	evt.EnterHouse{Id = 84}         -- "Emerald Enchantments"
end

evt.house[7] = 84  -- "Emerald Enchantments"
Game.MapEvtLines:RemoveEvent(7)
evt.map[7] = function()
end

evt.house[8] = 116  -- "The Blue Bottle"
Game.MapEvtLines:RemoveEvent(8)
evt.map[8] = function()
	evt.EnterHouse{Id = 116}         -- "The Blue Bottle"
end

evt.house[9] = 116  -- "The Blue Bottle"
Game.MapEvtLines:RemoveEvent(9)
evt.map[9] = function()
end

evt.house[10] = 310  -- "Healer's Tent"
Game.MapEvtLines:RemoveEvent(10)
evt.map[10] = function()
	evt.EnterHouse{Id = 310}         -- "Healer's Tent"
end

evt.house[11] = 310  -- "Healer's Tent"
Game.MapEvtLines:RemoveEvent(11)
evt.map[11] = function()
end

evt.house[12] = 1570  -- "Island Training Grounds"
Game.MapEvtLines:RemoveEvent(12)
evt.map[12] = function()
	evt.EnterHouse{Id = 1570}         -- "Island Training Grounds"
end

evt.house[13] = 1570  -- "Island Training Grounds"
Game.MapEvtLines:RemoveEvent(13)
evt.map[13] = function()
end

evt.house[14] = 239  -- "Two Palms Tavern"
Game.MapEvtLines:RemoveEvent(14)
evt.map[14] = function()
	evt.EnterHouse{Id = 239}         -- "Two Palms Tavern"
end

evt.house[15] = 239  -- "Two Palms Tavern"
Game.MapEvtLines:RemoveEvent(15)
evt.map[15] = function()
end

evt.house[16] = 128  -- "Initiate Guild of Fire"
Game.MapEvtLines:RemoveEvent(16)
evt.map[16] = function()
	evt.EnterHouse{Id = 128}         -- "Initiate Guild of Fire"
end

evt.house[17] = 128  -- "Initiate Guild of Fire"
Game.MapEvtLines:RemoveEvent(17)
evt.map[17] = function()
end

evt.house[18] = 134  -- "Initiate Guild of Air"
Game.MapEvtLines:RemoveEvent(18)
evt.map[18] = function()
	evt.EnterHouse{Id = 134}         -- "Initiate Guild of Air"
end

evt.house[19] = 134  -- "Initiate Guild of Air"
Game.MapEvtLines:RemoveEvent(19)
evt.map[19] = function()
end

evt.house[20] = 152  -- "Initiate Guild of Spirit"
Game.MapEvtLines:RemoveEvent(20)
evt.map[20] = function()
	evt.EnterHouse{Id = 152}         -- "Initiate Guild of Spirit"
end

evt.house[21] = 152  -- "Initiate Guild of Spirit"
Game.MapEvtLines:RemoveEvent(21)
evt.map[21] = function()
end

evt.house[22] = 164  -- "Initiate Guild of Body"
Game.MapEvtLines:RemoveEvent(22)
evt.map[22] = function()
	evt.EnterHouse{Id = 164}         -- "Initiate Guild of Body"
end

evt.house[23] = 164  -- "Initiate Guild of Body"
Game.MapEvtLines:RemoveEvent(23)
evt.map[23] = function()
end

evt.house[24] = 1168  -- "The Lady Margaret"
Game.MapEvtLines:RemoveEvent(24)
evt.map[24] = function()
	evt.EnterHouse{Id = 1168}         -- "The Lady Margaret"
end

evt.house[25] = 485  -- "Lady Margaret"
Game.MapEvtLines:RemoveEvent(25)
evt.map[25] = function()
end

evt.hint[26] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(26)
evt.map[26] = function()  -- function events.LoadMap()
	evt.Subtract{"NPCs", Value = 342}         -- "Big Daddy Jim"
end

events.LoadMap = evt.map[26].last

evt.hint[37] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(37)
evt.map[37] = function()  -- function events.LoadMap()
	if evt.Cmp{"QBits", Value = 806} then         -- Return to EI
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
		evt.SpeakNPC{NPC = 356}         -- "Sally"
		evt.Subtract{"QBits", Value = 806}         -- Return to EI
	end
end

events.LoadMap = evt.map[37].last

evt.hint[49] = evt.str[7]  -- "House"
evt.house[50] = 1167  -- "Donna Wyrith's Residence"
Game.MapEvtLines:RemoveEvent(50)
evt.map[50] = function()
	evt.EnterHouse{Id = 1167}         -- "Donna Wyrith's Residence"
end

evt.house[51] = 1170  -- "Mia Lucille' Home"
Game.MapEvtLines:RemoveEvent(51)
evt.map[51] = function()
	evt.EnterHouse{Id = 1170}         -- "Mia Lucille' Home"
end

evt.house[52] = 1171  -- "Zedd's Place"
Game.MapEvtLines:RemoveEvent(52)
evt.map[52] = function()
	evt.EnterHouse{Id = 1171}         -- "Zedd's Place"
end

evt.house[53] = 1608  -- "House 227"
Game.MapEvtLines:RemoveEvent(53)
evt.map[53] = function()
	evt.EnterHouse{Id = 1608}         -- "House 227"
end

evt.house[54] = 1173  -- "House 228"
Game.MapEvtLines:RemoveEvent(54)
evt.map[54] = function()
	evt.EnterHouse{Id = 1173}         -- "House 228"
end

evt.house[55] = 1174  -- "House 229"
Game.MapEvtLines:RemoveEvent(55)
evt.map[55] = function()
	evt.EnterHouse{Id = 1174}         -- "House 229"
end

evt.house[56] = 1183  -- "Carolyn Weathers' House"
Game.MapEvtLines:RemoveEvent(56)
evt.map[56] = function()
	evt.EnterHouse{Id = 1183}         -- "Carolyn Weathers' House"
end

evt.house[57] = 1184  -- "Tellmar Residence"
Game.MapEvtLines:RemoveEvent(57)
evt.map[57] = function()
	evt.EnterHouse{Id = 1184}         -- "Tellmar Residence"
end

evt.house[58] = 1185  -- "House 241"
Game.MapEvtLines:RemoveEvent(58)
evt.map[58] = function()
	evt.EnterHouse{Id = 1185}         -- "House 241"
end

evt.house[59] = 1186  -- "House 242"
Game.MapEvtLines:RemoveEvent(59)
evt.map[59] = function()
	evt.EnterHouse{Id = 1186}         -- "House 242"
end

evt.house[60] = 1198  -- "House 254"
Game.MapEvtLines:RemoveEvent(60)
evt.map[60] = function()
	evt.EnterHouse{Id = 1198}         -- "House 254"
end

evt.house[61] = 1199  -- "House 255"
Game.MapEvtLines:RemoveEvent(61)
evt.map[61] = function()
	evt.EnterHouse{Id = 1199}         -- "House 255"
end

evt.house[62] = 1199  -- "House 255"
Game.MapEvtLines:RemoveEvent(62)
evt.map[62] = function()
	evt.EnterHouse{Id = 1199}         -- "House 255"
end

evt.hint[63] = evt.str[14]  -- "Anvil"
evt.hint[64] = evt.str[10]  -- "Cart"
evt.hint[65] = evt.str[9]  -- "Keg"
evt.house[66] = 1163  -- "Markham's Headquarters"
Game.MapEvtLines:RemoveEvent(66)
evt.map[66] = function()
	evt.EnterHouse{Id = 1163}         -- "Markham's Headquarters"
end

evt.house[67] = 1163  -- "Markham's Headquarters"
Game.MapEvtLines:RemoveEvent(67)
evt.map[67] = function()
end

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
	if evt.Cmp{"Inventory", Value = 1364} then         -- "Ring of UnWarding"
		evt.MoveToMap{X = 752, Y = 2229, Z = 1, Direction = 1012, LookAngle = 0, SpeedZ = 0, HouseId = 389, Icon = 3, Name = "7D28.Blv"}         -- "Dragon's Lair"
	else
		evt.StatusText{Str = 41}         -- "This cave is sealed by a powerful magical ward."
	end
end

evt.hint[109] = evt.str[3]  -- "Well"
evt.hint[110] = evt.str[4]  -- "Drink from the Well"
Game.MapEvtLines:RemoveEvent(110)
evt.map[110] = function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if not evt.Cmp{"QBits", Value = 828} then         -- 1-time EI Well
		evt.Set{"QBits", Value = 828}         -- 1-time EI Well
		evt.Add{"BaseEndurance", Value = 32}
		evt.Add{"SkillPoints", Value = 5}
	else
		if evt.Cmp{"FireResBonus", Value = 50} then
			evt.StatusText{Str = 11}         -- "Refreshing!"
		else
			evt.Set{"FireResBonus", Value = 50}
			evt.StatusText{Str = 22}         -- "+50 Fire Resistance temporary."
			evt.Add{"AutonotesBits", Value = 258}         -- "50 points of temporary Fire resistance from the central town well on Emerald Island."
		end
	end
end

Game.MapEvtLines:RemoveEvent(111)
evt.map[111] = function()  -- Timer(<function>, const.Day, 1*const.Second)
	evt.Set{"MapVar0", Value = 30}
	evt.Set{"MapVar1", Value = 30}
end

Timer(evt.map[111].last, const.Day, 1*const.Second)

evt.hint[112] = evt.str[4]  -- "Drink from the Well"
Game.MapEvtLines:RemoveEvent(112)
evt.map[112] = function()
	if evt.Cmp{"MapVar0", Value = 1} then
		evt.Subtract{"MapVar0", Value = 1}
		evt.Add{"HP", Value = 5}
		evt.Add{"AutonotesBits", Value = 259}         -- "5 Hit Points regained from the well east of the Temple on Emerald Island."
		evt.StatusText{Str = 23}         -- "+5 Hit points restored."
	else
		evt.StatusText{Str = 11}         -- "Refreshing!"
	end
end

evt.hint[113] = evt.str[4]  -- "Drink from the Well"
Game.MapEvtLines:RemoveEvent(113)
evt.map[113] = function()
	if evt.Cmp{"MapVar1", Value = 1} then
		evt.Subtract{"MapVar1", Value = 1}
		evt.Add{"SP", Value = 5}
		evt.StatusText{Str = 24}         -- "+5 Spell points restored."
	else
		evt.StatusText{Str = 11}         -- "Refreshing!"
	end
	evt.Set{"AutonotesBits", Value = 4}         -- "5 Spell Points regained from the well west of the Temple on Emerald Island."
end

evt.hint[114] = evt.str[4]  -- "Drink from the Well"
Game.MapEvtLines:RemoveEvent(114)
evt.map[114] = function()
	if evt.Cmp{"QBits", Value = 536} then         -- "Find the Blessed Panoply of Sir BunGleau and return to the Angel in Castle Harmondale""
		goto _15
	end
	if evt.Cmp{"QBits", Value = 538} then         -- "Find the Blessed Panoply of Sir BunGleau and return  to William Setag in the Deyja Moors."
		goto _15
	end
	if not evt.Cmp{"BaseLuck", Value = 15} then
		if evt.Cmp{"MapVar2", Value = 1} then
			evt.Subtract{"MapVar2", Value = 1}
			evt.Add{"BaseLuck", Value = 2}
			evt.StatusText{Str = 25}         -- "+2 Luck permanent"
			return
		end
	end
	evt.StatusText{Str = 11}         -- "Refreshing!"
	do return end
::_15::
	evt.MoveToMap{X = 9828, Y = 6144, Z = 97, Direction = 2047, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "mdt09.blv"}
end

RefillTimer(function()
	evt.Set{"MapVar2", Value = 8}
end, const.Month, true)

evt.hint[115] = evt.str[4]  -- "Drink from the Well"
Game.MapEvtLines:RemoveEvent(115)
evt.map[115] = function()
	if not evt.Cmp{"MapVar4", Value = 3} then
		if not evt.Cmp{"MapVar3", Value = 1} then
			if not evt.Cmp{"Gold", Value = 201} then
				if evt.Cmp{"BaseLuck", Value = 15} then
					evt.Add{"MapVar3", Value = 1}
					evt.Add{"Gold", Value = 1000}
					evt.Add{"MapVar4", Value = 1}
					return
				end
			end
		end
	end
	evt.StatusText{Str = 11}         -- "Refreshing!"
end

RefillTimer(function()
	evt.Set{"MapVar3", Value = 0}
end, const.Week, true)

evt.hint[118] = evt.str[1]  -- "Crate"
Game.MapEvtLines:RemoveEvent(118)
evt.map[118] = function()
	evt.OpenChest{Id = 1}
end

evt.hint[119] = evt.str[1]  -- "Crate"
Game.MapEvtLines:RemoveEvent(119)
evt.map[119] = function()
	evt.OpenChest{Id = 2}
end

evt.hint[120] = evt.str[1]  -- "Crate"
Game.MapEvtLines:RemoveEvent(120)
evt.map[120] = function()
	evt.OpenChest{Id = 3}
end

evt.hint[121] = evt.str[1]  -- "Crate"
Game.MapEvtLines:RemoveEvent(121)
evt.map[121] = function()
	evt.OpenChest{Id = 4}
end

evt.hint[122] = evt.str[1]  -- "Crate"
Game.MapEvtLines:RemoveEvent(122)
evt.map[122] = function()
	evt.OpenChest{Id = 5}
end

evt.hint[123] = evt.str[1]  -- "Crate"
Game.MapEvtLines:RemoveEvent(123)
evt.map[123] = function()
	evt.OpenChest{Id = 6}
end

evt.hint[124] = evt.str[16]  -- "Chest"
Game.MapEvtLines:RemoveEvent(124)
evt.map[124] = function()
	evt.OpenChest{Id = 7}
end

Game.MapEvtLines:RemoveEvent(200)
evt.map[200] = function()
	if not evt.Cmp{"QBits", Value = 529} then         -- No more docent babble
		evt.Set{"QBits", Value = 529}        -- No more docent babble
		evt.SpeakNPC{NPC = 342}         -- "Big Daddy Jim"
	end
end

Game.MapEvtLines:RemoveEvent(201)
evt.map[201] = function()
	if not evt.Cmp{"QBits", Value = 529} then         -- No more docent babble
		evt.SpeakNPC{NPC = 359}         -- "Baron BunGleau"
	end
end

Game.MapEvtLines:RemoveEvent(202)
evt.map[202] = function()
	if not evt.Cmp{"QBits", Value = 529} then         -- No more docent babble
		evt.SpeakNPC{NPC = 360}         -- "Zedd True Shot"
	end
end

Game.MapEvtLines:RemoveEvent(203)
evt.map[203] = function()
	if not evt.Cmp{"QBits", Value = 529} then         -- No more docent babble
		evt.SpeakNPC{NPC = 361}         -- "Alex the Mentor"
	end
end

Game.MapEvtLines:RemoveEvent(204)
evt.map[204] = function()
	if not evt.Cmp{"QBits", Value = 529} then         -- No more docent babble
		evt.SpeakNPC{NPC = 362}         -- "Alex the Mentor"
	end
end

Game.MapEvtLines:RemoveEvent(205)
evt.map[205] = function()
	if not evt.Cmp{"QBits", Value = 529} then         -- No more docent babble
		evt.SpeakNPC{NPC = 363}         -- "Alex the Mentor"
	end
end

Game.MapEvtLines:RemoveEvent(206)
evt.map[206] = function()
	if not evt.Cmp{"QBits", Value = 529} then         -- No more docent babble
		evt.SpeakNPC{NPC = 364}         -- "Operator"
	end
end

Game.MapEvtLines:RemoveEvent(207)
evt.map[207] = function()
	if not evt.Cmp{"QBits", Value = 529} then         -- No more docent babble
		evt.SpeakNPC{NPC = 365}         -- "Count ZERO"
	end
end

Game.MapEvtLines:RemoveEvent(208)
evt.map[208] = function()
	if not evt.Cmp{"QBits", Value = 529} then         -- No more docent babble
		evt.SpeakNPC{NPC = 366}         -- "Messenger"
	end
end

Game.MapEvtLines:RemoveEvent(209)
evt.map[209] = function()
	if not evt.Cmp{"QBits", Value = 529} then         -- No more docent babble
		evt.SpeakNPC{NPC = 367}         -- "Alex the Mentor"
	end
end

Game.MapEvtLines:RemoveEvent(210)
evt.map[210] = function()
	if not evt.Cmp{"QBits", Value = 529} then         -- No more docent babble
		evt.SpeakNPC{NPC = 368}         -- "Alex the Mentor"
	end
end

Game.MapEvtLines:RemoveEvent(211)
evt.map[211] = function()
	if not evt.Cmp{"QBits", Value = 529} then         -- No more docent babble
		evt.SpeakNPC{NPC = 369}         -- "Doom Bearer"
	end
end

Game.MapEvtLines:RemoveEvent(212)
evt.map[212] = function()
	if not evt.Cmp{"QBits", Value = 529} then         -- No more docent babble
		evt.SpeakNPC{NPC = 370}         -- "Alex the Mentor"
	end
end

Game.MapEvtLines:RemoveEvent(213)
evt.map[213] = function()
	if not evt.Cmp{"QBits", Value = 529} then         -- No more docent babble
		evt.SpeakNPC{NPC = 371}         -- "Myrta Bumblebee"
	end
end

Game.MapEvtLines:RemoveEvent(214)
evt.map[214] = function()
	if not evt.Cmp{"QBits", Value = 529} then         -- No more docent babble
		evt.SpeakNPC{NPC = 372}         -- "Alex the Mentor"
	end
end

Game.MapEvtLines:RemoveEvent(215)
evt.map[215] = function()
	if not evt.Cmp{"QBits", Value = 529} then         -- No more docent babble
		evt.SpeakNPC{NPC = 373}         -- "Duke Bimbasto"
	end
end

Game.MapEvtLines:RemoveEvent(216)
evt.map[216] = function()
	if not evt.Cmp{"QBits", Value = 529} then         -- No more docent babble
		evt.SpeakNPC{NPC = 374}         -- "Sir Vilx of Stone City"
	end
end

Game.MapEvtLines:RemoveEvent(217)
evt.map[217] = function()
	if not evt.Cmp{"QBits", Value = 529} then         -- No more docent babble
		evt.SpeakNPC{NPC = 375}         -- "Alex the Mentor"
	end
end

Game.MapEvtLines:RemoveEvent(218)
evt.map[218] = function()
	if not evt.Cmp{"QBits", Value = 529} then         -- No more docent babble
		evt.SpeakNPC{NPC = 376}         -- "Pascal the Mad Mage"
	end
end

evt.hint[219] = evt.str[15]  -- "Button"
Game.MapEvtLines:RemoveEvent(219)
evt.map[219] = function()
	evt.CastSpell{Spell = 43, Mastery = const.GM, Skill = 10, FromX = 10495, FromY = 17724, FromZ = 2370, ToX = 10495, ToY = 24144, ToZ = 4500}         -- "Death Blossom"
end

evt.hint[220] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(220)
evt.map[220] = function()  -- Timer(<function>, const.Day, 1*const.Hour)
	if evt.CheckMonstersKilled{CheckType = 1, Id = 71, Count = 0} then
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 10, X = -336, Y = 14512, Z = 0, NPCGroup = 71, unk = 0}         -- "Ridge walkers in Bracada"
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 5, X = 16, Y = 16352, Z = 90, NPCGroup = 71, unk = 0}         -- "Ridge walkers in Bracada"
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 10, X = 480, Y = 18288, Z = 6, NPCGroup = 71, unk = 0}         -- "Ridge walkers in Bracada"
	end
end

Timer(evt.map[220].last, const.Day, 1*const.Hour)

Game.MapEvtLines:RemoveEvent(573)
evt.map[573] = function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if not evt.Cmp{"Inventory", Value = 1540} then         -- "Lost Scroll of Wonka"
		evt.SetMessage{Str = 768}
		return
	end
	evt.SetMessage{Str = 769}
	evt.ForPlayer(-- ERROR: Const not found
3)
	if evt.Cmp{"FireSkill", Value = 1} then
		evt.Set{"FireSkill", Value = 49152}
		evt.Set{"FireSkill", Value = 8}
	end
	evt.ForPlayer(-- ERROR: Const not found
2)
	if evt.Cmp{"FireSkill", Value = 1} then
		evt.Set{"FireSkill", Value = 49152}
		evt.Set{"FireSkill", Value = 8}
	end
	evt.ForPlayer(-- ERROR: Const not found
1)
	if evt.Cmp{"FireSkill", Value = 1} then
		evt.Set{"FireSkill", Value = 49152}
		evt.Set{"FireSkill", Value = 8}
	end
	evt.ForPlayer(-- ERROR: Const not found
0)
	if evt.Cmp{"FireSkill", Value = 1} then
		evt.Set{"FireSkill", Value = 49152}
		evt.Set{"FireSkill", Value = 8}
	end
	evt.ForPlayer(-- ERROR: Const not found
"All")
	evt.Subtract{"QBits", Value = 784}         -- "Find the Lost Scroll of Wonka and return it to Blayze on Emerald Island."
	evt.Subtract{"Inventory", Value = 1540}         -- "Lost Scroll of Wonka"
	evt.Add{"Awards", Value = 129}         -- "Recovered the Lost Scroll of  Wonka"
	evt.SetNPCTopic{NPC = 478, Index = 1, Event = 0}         -- "Blayze "
	evt.Add{"Experience", Value = 40000}
end

Game.MapEvtLines:RemoveEvent(574)
evt.map[574] = function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if evt.Cmp{"Inventory", Value = 1361} then         -- "Watcher's Ring of Elemental Water"
		evt.SetMessage{Str = 772}
		evt.SetNPCTopic{NPC = 483, Index = 0, Event = 2002}         -- "Tobren Rainshield" : "The Greatest Hero"
		return
	end
	if not evt.Cmp{"Inventory", Value = 1128} then         -- "Water Walk"
		evt.ForPlayer(-- ERROR: Const not found
"Current")
		evt.Add{"Inventory", 1128}         -- "Water Walk"
	end
	evt.SetMessage{Str = 771}
end

Game.MapEvtLines:RemoveEvent(575)
evt.map[575] = function()
	evt.ForPlayer(-- ERROR: Const not found
"Current")
	if evt.Cmp{"WaterSkill", Value = 136} then
		evt.SetMessage{Str = 130}
	else
		if not evt.Cmp{"WaterSkill", Value = 72} then
			evt.SetMessage{Str = 126}
		else
			if evt.Cmp{"Gold", Value = 3000} then
				evt.Add{"WaterSkill", Value = 128}
				evt.Subtract{"Gold", Value = 3000}
				evt.SetMessage{Str = 133}
			else
				evt.SetMessage{Str = 125}
			end
		end
	end
end


evt.map[100] = function()  -- function events.LoadMap()
	if not evt.Cmp{"QBits", Value = 519} then         -- Finished Scavenger Hunt
		if not evt.Cmp{"QBits", Value = 518} then         -- "Return a wealthy hat to the Judge on Emerald Island."
			if not evt.Cmp{"QBits", Value = 517} then         -- "Return a musical instrument to the Judge on Emerald Island."
				if not evt.Cmp{"QBits", Value = 516} then         -- "Return a floor tile to the Judge on Emerald Island."
					if not evt.Cmp{"QBits", Value = 515} then         -- "Return a longbow to the Judge on Emerald Island."
						if not evt.Cmp{"QBits", Value = 514} then         -- "Return a seashell to the Judge on Emerald Island."
							if not evt.Cmp{"QBits", Value = 513} then         -- "Return a red potion to the Judge on Emerald Island."
								evt.Add{"QBits", Value = 518}         -- "Return a wealthy hat to the Judge on Emerald Island."
								evt.Add{"QBits", Value = 517}         -- "Return a musical instrument to the Judge on Emerald Island."
								evt.Add{"QBits", Value = 516}         -- "Return a floor tile to the Judge on Emerald Island."
								evt.Add{"QBits", Value = 515}         -- "Return a longbow to the Judge on Emerald Island."
								evt.Add{"QBits", Value = 514}         -- "Return a seashell to the Judge on Emerald Island."
								evt.Add{"QBits", Value = 513}         -- "Return a red potion to the Judge on Emerald Island."
								evt.ShowMovie{DoubleSize = 1, Name = "\"intro post\""}
							end
						end
					end
				end
			end
		end
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
