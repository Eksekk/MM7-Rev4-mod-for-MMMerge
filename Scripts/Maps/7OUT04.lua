local TXT = Localize{
	[0] = " ",
	[1] = "Chest ",
	[2] = "Barrel",
	[3] = "Well",
	[4] = "Drink from the Well",
	[5] = "Fountain",
	[6] = "Drink from the Fountain",
	[7] = "House",
	[8] = "Trash Heap",
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
	[25] = "Castle Navan",
	[26] = "Tularean Caves",
	[27] = "Clanker's Laboratory",
	[28] = "",
	[29] = "",
	[30] = "Enter Castle Navan",
	[31] = "Enter the Tularean Caves",
	[32] = "Enter Clanker's Laboratory",
	[33] = "",
	[34] = "The entrance has been sealed by a rockslide",
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
	[51] = "redditoh",
	[52] = "Shrine",
	[53] = "Altar",
	[54] = "You Pray",
	[55] = "",
	[56] = "",
	[57] = "",
	[58] = "",
	[59] = "",
	[60] = "Fruit Tree",
	[61] = "You received an apple",
	[62] = "",
	[63] = "",
	[64] = "",
	[65] = "",
	[66] = "",
	[67] = "",
	[68] = "",
	[69] = "",
	[70] = "+50 Earth Resistance (Temporary)",
	[71] = "",
	[72] = "",
	[73] = "",
	[74] = "",
	[75] = "",
	[76] = "+10 Water, Fire, and Air Resistance(Permanent)",
}
table.copy(TXT, evt.str, true)

-- REMOVED BY REV4 FOR MERGE
-- Game.MapEvtLines.Count = 0  -- Deactivate all standard events


Game.MapEvtLines:RemoveEvent(1)
evt.map[1] = function()  -- function events.LoadMap()
	evt.MoveNPC{NPC = 527, HouseId = 959}         -- "Gretchin Fiddlebone" -> "Fiddlebone Residence"
	if not evt.Cmp("QBits", 553) then         -- Solved Tree quest
		evt.SetMonGroupBit{NPCGroup = 61, Bit = const.MonsterBits.Hostile, On = true}         -- "Southern Village Group in Harmondy"
	end
	evt.SetMonGroupBit{NPCGroup = 61, Bit = const.MonsterBits.Hostile, On = false}         -- "Southern Village Group in Harmondy"
end

events.LoadMap = evt.map[1].last

Game.MapEvtLines:RemoveEvent(3)
evt.HouseDoor(3, 51)  -- "Buckskins and Bucklers"
evt.house[4] = 51  -- "Buckskins and Bucklers"
Game.MapEvtLines:RemoveEvent(5)
evt.HouseDoor(5, 87)  -- "Natural Magic"
evt.house[6] = 87  -- "Natural Magic"
Game.MapEvtLines:RemoveEvent(7)
evt.HouseDoor(7, 119)  -- "The Bubbling Cauldron"
evt.house[8] = 119  -- "The Bubbling Cauldron"
Game.MapEvtLines:RemoveEvent(9)
evt.HouseDoor(9, 463)  -- "Hu's Stallions"
evt.house[10] = 463  -- "Hu's Stallions"
Game.MapEvtLines:RemoveEvent(11)
evt.HouseDoor(11, 487)  -- "Sea Sprite"
evt.house[12] = 487  -- "Sea Sprite"
Game.MapEvtLines:RemoveEvent(13)
evt.HouseDoor(13, 313)  -- "Nature's Remedies"
evt.house[14] = 313  -- "Nature's Remedies"
Game.MapEvtLines:RemoveEvent(15)
evt.HouseDoor(15, 1573)  -- "The Proving Grounds"
evt.house[16] = 1573  -- "The Proving Grounds"
Game.MapEvtLines:RemoveEvent(17)
evt.HouseDoor(17, 205)  -- "Pierpont Townhall"
evt.house[18] = 205  -- "Pierpont Townhall"
Game.MapEvtLines:RemoveEvent(19)
evt.HouseDoor(19, 242)  -- "Emerald Inn"
evt.house[20] = 242  -- "Emerald Inn"
Game.MapEvtLines:RemoveEvent(21)
evt.HouseDoor(21, 288)  -- "Nature's Stockpile"
evt.house[22] = 288  -- "Nature's Stockpile"
Game.MapEvtLines:RemoveEvent(23)
evt.HouseDoor(23, 130)  -- "Master Guild of Fire"
evt.house[24] = 130  -- "Master Guild of Fire"
Game.MapEvtLines:RemoveEvent(25)
evt.HouseDoor(25, 136)  -- "Master Guild of Air"
evt.house[26] = 136  -- "Master Guild of Air"
Game.MapEvtLines:RemoveEvent(27)
evt.HouseDoor(27, 141)  -- "Adept Guild of Water"
evt.house[28] = 141  -- "Adept Guild of Water"
Game.MapEvtLines:RemoveEvent(29)
evt.HouseDoor(29, 147)  -- "Adept Guild of Earth"
evt.house[30] = 147  -- "Adept Guild of Earth"
Game.MapEvtLines:RemoveEvent(32)
evt.HouseDoor(32, 11)  -- "Hunter's Lodge"
evt.house[33] = 11  -- "Hunter's Lodge"
evt.hint[51] = evt.str[7]  -- "House"
Game.MapEvtLines:RemoveEvent(52)
evt.HouseDoor(52, 946)  -- "Bith Residence"
Game.MapEvtLines:RemoveEvent(53)
evt.HouseDoor(53, 947)  -- "Suretrail Home"
Game.MapEvtLines:RemoveEvent(54)
evt.HouseDoor(54, 948)  -- "Silverpoint Residence"
Game.MapEvtLines:RemoveEvent(55)
evt.HouseDoor(55, 949)  -- "Miyon's Home"
Game.MapEvtLines:RemoveEvent(56)
evt.HouseDoor(56, 950)  -- "Green House"
Game.MapEvtLines:RemoveEvent(57)
evt.HouseDoor(57, 951)  -- "Warlin Residence"
Game.MapEvtLines:RemoveEvent(58)
evt.HouseDoor(58, 952)  -- "Dotes Residence"
Game.MapEvtLines:RemoveEvent(59)
evt.HouseDoor(59, 953)  -- "Blueswan Home"
Game.MapEvtLines:RemoveEvent(60)
evt.HouseDoor(60, 954)  -- "Temper Residence"
Game.MapEvtLines:RemoveEvent(61)
evt.HouseDoor(61, 955)  -- "Windsong House"
Game.MapEvtLines:RemoveEvent(62)
evt.HouseDoor(62, 956)  -- "Whitecap Residence"
Game.MapEvtLines:RemoveEvent(63)
evt.HouseDoor(63, 957)  -- "Ottin House"
Game.MapEvtLines:RemoveEvent(64)
evt.HouseDoor(64, 958)  -- "Black House"
Game.MapEvtLines:RemoveEvent(65)
evt.HouseDoor(65, 959)  -- "Fiddlebone Residence"
Game.MapEvtLines:RemoveEvent(66)
evt.HouseDoor(66, 960)  -- "Kerrid Residence"
Game.MapEvtLines:RemoveEvent(67)
evt.HouseDoor(67, 961)  -- "Willowbark's Home"
Game.MapEvtLines:RemoveEvent(68)
evt.HouseDoor(68, 962)  -- "House 324"
Game.MapEvtLines:RemoveEvent(69)
evt.HouseDoor(69, 963)  -- "House 325"
Game.MapEvtLines:RemoveEvent(70)
evt.HouseDoor(70, 964)  -- "House 326"
Game.MapEvtLines:RemoveEvent(71)
evt.HouseDoor(71, 965)  -- "Benjamin's Home"
Game.MapEvtLines:RemoveEvent(72)
evt.HouseDoor(72, 966)  -- "Stonewright Residence"
Game.MapEvtLines:RemoveEvent(73)
evt.HouseDoor(73, 967)  -- "Weatherson's House"
Game.MapEvtLines:RemoveEvent(74)
evt.HouseDoor(74, 968)  -- "Sower Residence"
evt.hint[75] = evt.str[9]  -- "Tent"
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
	if not evt.Cmp("BankGold", 99) then
		if not evt.Cmp("Gold", 199) then
			if not evt.Cmp("MapVar19", 1) then
				evt.Add("Gold", 200)
				evt.Set("MapVar19", 1)
			end
		end
	end
	evt.StatusText(11)         -- "Refreshing!"
end

RefillTimer(function()
	evt.Set("MapVar19", 0)
end, const.Week)

evt.hint[203] = evt.str[5]  -- "Fountain"
evt.hint[204] = evt.str[6]  -- "Drink from the Fountain"
Game.MapEvtLines:RemoveEvent(204)
evt.map[204] = function()
	if evt.Cmp("PlayerBits", 8) then
		evt.StatusText(11)         -- "Refreshing!"
		return
	end
	if not evt.Cmp("AutonotesBits", 269) then         -- "50 points of temporary Earth resistance from the central fountain in Pierpont."
		evt.Add("AutonotesBits", 269)         -- "50 points of temporary Earth resistance from the central fountain in Pierpont."
	end
	evt.Add("EarthResBonus", 50)
	evt.Add("PlayerBits", 8)
	evt.StatusText(70)         -- "+50 Earth Resistance (Temporary)"
end

RefillTimer(function()
	evt.ForPlayer("All")
	evt.Subtract("PlayerBits", 8)
end, const.Day)

evt.hint[205] = evt.str[25]  -- "Castle Navan"
evt.hint[401] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(401)
evt.map[401] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 649) then         -- Artifact Messenger only happens once
		if evt.Cmp("Counter3", 1344) then
			if not evt.Cmp("Counter3", 2016) then
				evt.Add("Inventory", 1502)         -- "Message from Erathia"
				evt.Set("QBits", 649)         -- Artifact Messenger only happens once
				evt.Set("QBits", 591)         -- "Retrieve Gryphonheart's Trumpet from the battle in the Tularean Forest and return it to whichever side you choose."
				evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Untouchable, On = false}
				evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Invisible, On = false}
				evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 3, X = -15752, Y = 21272, Z = 3273, NPCGroup = 51, unk = 0}
				evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 5, X = -14000, Y = 18576, Z = 4250, NPCGroup = 51, unk = 0}
				evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 10, X = -16016, Y = 19280, Z = 3284, NPCGroup = 51, unk = 0}
				evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 30, X = -15752, Y = 21272, Z = 3273, NPCGroup = 51, unk = 0}
				evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 9, X = -14000, Y = 18576, Z = 4250, NPCGroup = 51, unk = 0}
				evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 10, X = -16016, Y = 19280, Z = 3284, NPCGroup = 51, unk = 0}
				evt.SpeakNPC(412)         -- "Messenger"
			end
		end
	end
end

events.LoadMap = evt.map[401].last

evt.hint[402] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(402)
evt.map[402] = function()
	evt.SpeakNPC(392)         -- "The Oldest Tree"
end

evt.hint[403] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(403)
evt.map[403] = function()  -- Timer(<function>, 5*const.Minute)
	if evt.Cmp("QBits", 553) then         -- Solved Tree quest
		evt.SetMonGroupBit{NPCGroup = 61, Bit = const.MonsterBits.Hostile, On = false}         -- "Southern Village Group in Harmondy"
	end
end

Timer(evt.map[403].last, 5*const.Minute)

evt.hint[451] = evt.str[52]  -- "Shrine"
evt.hint[452] = evt.str[53]  -- "Altar"
Game.MapEvtLines:RemoveEvent(452)
evt.map[452] = function()
	if evt.Cmp("PlayerBits", 25) then
		evt.StatusText(54)         -- "You Pray"
	else
		evt.Add("WaterResistance", 10)
		evt.Add("FireResistance", 10)
		evt.Add("AirResistance", 10)
		evt.Add("PlayerBits", 25)
		evt.StatusText(76)         -- "+10 Water, Fire, and Air Resistance(Permanent)"
	end
end

evt.hint[453] = evt.str[50]  -- "Obelisk"
Game.MapEvtLines:RemoveEvent(453)
evt.map[453] = function()
	if not evt.Cmp("QBits", 678) then         -- Visited Obelisk in Area 4
		evt.StatusText(51)         -- "redditoh"
		evt.Add("AutonotesBits", 311)         -- "Obelisk message #3: redditoh"
		evt.ForPlayer("All")
		evt.Add("QBits", 678)         -- Visited Obelisk in Area 4
	end
end

evt.hint[500] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(500)
evt.map[500] = function()  -- function events.LoadMap()
	if evt.CheckSeason(2) then
		evt.SetSprite{SpriteId = 5, Visible = 1, Name = "7tree08"}
		evt.SetSprite{SpriteId = 6, Visible = 1, Name = "7tree26"}
		evt.StatusText(62)         -- ""
		goto _23
	end
	if evt.CheckSeason(3) then
		evt.SetSprite{SpriteId = 5, Visible = 1, Name = "7tree09"}
		evt.SetSprite{SpriteId = 6, Visible = 1, Name = "7tree27"}
		evt.StatusText(63)         -- ""
		goto _23
	end
	evt.SetSprite{SpriteId = 5, Visible = 1, Name = "7tree07"}
	evt.SetSprite{SpriteId = 6, Visible = 1, Name = "7tree25"}
	evt.SetSprite{SpriteId = 7, Visible = 1, Name = "tree38"}
	evt.SetSprite{SpriteId = 10, Visible = 1, Name = "0"}
	if evt.Cmp("MapVar50", 1) then
		evt.SetSprite{SpriteId = 51, Visible = 1, Name = "tree37"}
	else
		evt.SetSprite{SpriteId = 51, Visible = 1, Name = "tree38"}
	end
	if evt.Cmp("MapVar51", 1) then
		evt.SetSprite{SpriteId = 52, Visible = 1, Name = "tree37"}
	else
		evt.SetSprite{SpriteId = 52, Visible = 1, Name = "tree38"}
	end
	if evt.Cmp("MapVar52", 1) then
		evt.SetSprite{SpriteId = 53, Visible = 1, Name = "tree37"}
	else
		evt.SetSprite{SpriteId = 53, Visible = 1, Name = "tree38"}
	end
	if evt.Cmp("MapVar53", 1) then
		evt.SetSprite{SpriteId = 54, Visible = 1, Name = "tree37"}
	else
		evt.SetSprite{SpriteId = 54, Visible = 1, Name = "tree38"}
	end
	if evt.Cmp("MapVar54", 1) then
		evt.SetSprite{SpriteId = 55, Visible = 1, Name = "tree37"}
	else
		evt.SetSprite{SpriteId = 55, Visible = 1, Name = "tree38"}
	end
	if evt.Cmp("MapVar55", 1) then
		evt.SetSprite{SpriteId = 56, Visible = 1, Name = "tree"}
	else
		evt.SetSprite{SpriteId = 56, Visible = 1, Name = "tree38"}
	end
	if evt.Cmp("MapVar56", 1) then
		evt.SetSprite{SpriteId = 57, Visible = 1, Name = "tree37"}
	else
		evt.SetSprite{SpriteId = 57, Visible = 1, Name = "tree38"}
	end
	if evt.Cmp("MapVar57", 1) then
		evt.SetSprite{SpriteId = 58, Visible = 1, Name = "tree37"}
	else
		evt.SetSprite{SpriteId = 58, Visible = 1, Name = "tree38"}
	end
	if evt.Cmp("MapVar58", 1) then
		evt.SetSprite{SpriteId = 59, Visible = 1, Name = "tree37"}
	else
		evt.SetSprite{SpriteId = 59, Visible = 1, Name = "tree38"}
	end
	if evt.Cmp("MapVar59", 1) then
		evt.SetSprite{SpriteId = 60, Visible = 1, Name = "tree37"}
	else
		evt.SetSprite{SpriteId = 60, Visible = 1, Name = "tree38"}
	end
	if evt.Cmp("MapVar60", 1) then
		evt.SetSprite{SpriteId = 61, Visible = 1, Name = "tree"}
	else
		evt.SetSprite{SpriteId = 61, Visible = 1, Name = "tree38"}
	end
	if evt.CheckSeason(1) then
		evt.StatusText(61)         -- "You received an apple"
	elseif evt.CheckSeason(0) then
		evt.StatusText(60)         -- "Fruit Tree"
	else
		evt.StatusText(64)         -- ""
	end
	do return end
::_23::
	evt.SetSprite{SpriteId = 7, Visible = 1, Name = "tree40"}
	evt.SetSprite{SpriteId = 10, Visible = 0, Name = "0"}
	evt.SetSprite{SpriteId = 51, Visible = 1, Name = "7tree30"}
	evt.SetSprite{SpriteId = 52, Visible = 1, Name = "7tree30"}
	evt.SetSprite{SpriteId = 53, Visible = 1, Name = "7tree30"}
	evt.SetSprite{SpriteId = 54, Visible = 1, Name = "7tree30"}
	evt.SetSprite{SpriteId = 55, Visible = 1, Name = "7tree30"}
	evt.SetSprite{SpriteId = 56, Visible = 1, Name = "7tree30"}
	evt.SetSprite{SpriteId = 57, Visible = 1, Name = "7tree30"}
	evt.SetSprite{SpriteId = 58, Visible = 1, Name = "7tree30"}
	evt.SetSprite{SpriteId = 59, Visible = 1, Name = "7tree30"}
	evt.SetSprite{SpriteId = 60, Visible = 1, Name = "7tree30"}
	evt.SetSprite{SpriteId = 61, Visible = 1, Name = "7tree30"}
end

events.LoadMap = evt.map[500].last

evt.hint[251] = evt.str[60]  -- "Fruit Tree"
Game.MapEvtLines:RemoveEvent(251)
evt.map[251] = function()
	if not evt.CheckSeason(3) then
		if not evt.CheckSeason(2) then
			if not evt.Cmp("MapVar50", 1) then
				evt.Add("Inventory", 1432)         -- "Red Delicious Apple"
				evt.Set("MapVar50", 1)
				evt.StatusText(61)         -- "You received an apple"
				evt.SetSprite{SpriteId = 51, Visible = 1, Name = "tree37"}
			end
		end
	end
end

evt.hint[252] = evt.str[60]  -- "Fruit Tree"
Game.MapEvtLines:RemoveEvent(252)
evt.map[252] = function()
	if not evt.CheckSeason(3) then
		if not evt.CheckSeason(2) then
			if not evt.Cmp("MapVar51", 1) then
				evt.Add("Inventory", 1432)         -- "Red Delicious Apple"
				evt.Set("MapVar51", 1)
				evt.StatusText(61)         -- "You received an apple"
				evt.SetSprite{SpriteId = 52, Visible = 1, Name = "tree37"}
			end
		end
	end
end

evt.hint[253] = evt.str[60]  -- "Fruit Tree"
Game.MapEvtLines:RemoveEvent(253)
evt.map[253] = function()
	if not evt.CheckSeason(3) then
		if not evt.CheckSeason(2) then
			if not evt.Cmp("MapVar52", 1) then
				evt.Add("Inventory", 1432)         -- "Red Delicious Apple"
				evt.Set("MapVar52", 1)
				evt.StatusText(61)         -- "You received an apple"
				evt.SetSprite{SpriteId = 53, Visible = 1, Name = "tree37"}
			end
		end
	end
end

evt.hint[254] = evt.str[60]  -- "Fruit Tree"
Game.MapEvtLines:RemoveEvent(254)
evt.map[254] = function()
	if not evt.CheckSeason(3) then
		if not evt.CheckSeason(2) then
			if not evt.Cmp("MapVar53", 1) then
				evt.Add("Inventory", 1432)         -- "Red Delicious Apple"
				evt.Set("MapVar53", 1)
				evt.StatusText(61)         -- "You received an apple"
				evt.SetSprite{SpriteId = 54, Visible = 1, Name = "tree37"}
			end
		end
	end
end

evt.hint[255] = evt.str[60]  -- "Fruit Tree"
Game.MapEvtLines:RemoveEvent(255)
evt.map[255] = function()
	if not evt.CheckSeason(3) then
		if not evt.CheckSeason(2) then
			if not evt.Cmp("MapVar54", 1) then
				evt.Add("Inventory", 1432)         -- "Red Delicious Apple"
				evt.Set("MapVar54", 1)
				evt.StatusText(61)         -- "You received an apple"
				evt.SetSprite{SpriteId = 55, Visible = 1, Name = "tree37"}
			end
		end
	end
end

evt.hint[256] = evt.str[60]  -- "Fruit Tree"
Game.MapEvtLines:RemoveEvent(256)
evt.map[256] = function()
	if not evt.CheckSeason(3) then
		if not evt.CheckSeason(2) then
			if not evt.Cmp("MapVar55", 1) then
				evt.Add("Inventory", 1432)         -- "Red Delicious Apple"
				evt.Set("MapVar55", 1)
				evt.StatusText(61)         -- "You received an apple"
				evt.SetSprite{SpriteId = 56, Visible = 1, Name = "tree37"}
			end
		end
	end
end

evt.hint[257] = evt.str[60]  -- "Fruit Tree"
Game.MapEvtLines:RemoveEvent(257)
evt.map[257] = function()
	if not evt.CheckSeason(3) then
		if not evt.CheckSeason(2) then
			if not evt.Cmp("MapVar56", 1) then
				evt.Add("Inventory", 1432)         -- "Red Delicious Apple"
				evt.Set("MapVar56", 1)
				evt.StatusText(61)         -- "You received an apple"
				evt.SetSprite{SpriteId = 57, Visible = 1, Name = "tree37"}
			end
		end
	end
end

evt.hint[258] = evt.str[60]  -- "Fruit Tree"
Game.MapEvtLines:RemoveEvent(258)
evt.map[258] = function()
	if not evt.CheckSeason(3) then
		if not evt.CheckSeason(2) then
			if not evt.Cmp("MapVar57", 1) then
				evt.Add("Inventory", 1432)         -- "Red Delicious Apple"
				evt.Set("MapVar57", 1)
				evt.StatusText(61)         -- "You received an apple"
				evt.SetSprite{SpriteId = 58, Visible = 1, Name = "tree37"}
			end
		end
	end
end

evt.hint[259] = evt.str[60]  -- "Fruit Tree"
Game.MapEvtLines:RemoveEvent(259)
evt.map[259] = function()
	if not evt.CheckSeason(3) then
		if not evt.CheckSeason(2) then
			if not evt.Cmp("MapVar58", 1) then
				evt.Add("Inventory", 1432)         -- "Red Delicious Apple"
				evt.Set("MapVar58", 1)
				evt.StatusText(61)         -- "You received an apple"
				evt.SetSprite{SpriteId = 59, Visible = 1, Name = "tree37"}
			end
		end
	end
end

evt.hint[260] = evt.str[60]  -- "Fruit Tree"
Game.MapEvtLines:RemoveEvent(260)
evt.map[260] = function()
	if not evt.CheckSeason(3) then
		if not evt.CheckSeason(2) then
			if not evt.Cmp("MapVar59", 1) then
				evt.Add("Inventory", 1432)         -- "Red Delicious Apple"
				evt.Set("MapVar59", 1)
				evt.StatusText(61)         -- "You received an apple"
				evt.SetSprite{SpriteId = 60, Visible = 1, Name = "tree37"}
			end
		end
	end
end

evt.hint[261] = evt.str[60]  -- "Fruit Tree"
Game.MapEvtLines:RemoveEvent(261)
evt.map[261] = function()
	if not evt.CheckSeason(3) then
		if not evt.CheckSeason(2) then
			if not evt.Cmp("MapVar60", 1) then
				evt.Add("Inventory", 1432)         -- "Red Delicious Apple"
				evt.Set("MapVar60", 1)
				evt.StatusText(61)         -- "You received an apple"
				evt.SetSprite{SpriteId = 61, Visible = 1, Name = "tree37"}
			end
		end
	end
end

evt.hint[501] = evt.str[30]  -- "Enter Castle Navan"
Game.MapEvtLines:RemoveEvent(501)
evt.map[501] = function()
	evt.MoveToMap{X = 0, Y = -1589, Z = 225, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 384, Icon = 1, Name = "7D32.blv"}         -- "Castle Navan"
end

evt.hint[502] = evt.str[31]  -- "Enter the Tularean Caves"
Game.MapEvtLines:RemoveEvent(502)
evt.map[502] = function()
	evt.StatusText(34)         -- "The entrance has been sealed by a rockslide"
end

evt.hint[503] = evt.str[32]  -- "Enter Clanker's Laboratory"
Game.MapEvtLines:RemoveEvent(503)
evt.map[503] = function()
	evt.StatusText(21)         -- "This Door is Locked"
end

--[[ MMMerge additions ]]--

-- The Tularean Forest
local MF = Merge.Functions

function events.AfterLoadMap()
	Party.QBits[719] = true	-- TP Buff Tularean Forest
	Party.QBits[939] = true	-- DDMapBuff, changed for rev4 for merge
end

-- Town Portal fountain
evt.map[204] = function()
	MF.SetLastFountain()
end

-- Dimension door
function events.TileSound(t)
	if t.X == 84 and t.Y == 94 then
		TownPortalControls.DimDoorEvent()
	end
end

evt.map[504] = function()
	TownPortalControls.DimDoorEvent()
end

function events.AfterLoadMap()
	local model
	for i,v in Map.Models do
		if v.Name == "ClL1_W" then
			model = v
		end
	end
	
	if model then
		for i,v in model.Facets do
			v.Event = 504
		end
	end
end

