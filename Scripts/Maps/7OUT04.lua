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


Game.MapEvtLines:RemoveEvent(1)
evt.map[1] = function()  -- function events.LoadMap()
	evt.MoveNPC{NPC = 527, HouseId = 959}         -- "Gretchin Fiddlebone" -> "Fiddlebone Residence"
	if not evt.Cmp{"QBits", Value = 553} then         -- Solved Tree quest
		evt.SetMonGroupBit{NPCGroup = 61, Bit = const.MonsterBits.Hostile, On = true}         -- "Southern Village Group in Harmondy"
	end
	evt.SetMonGroupBit{NPCGroup = 61, Bit = const.MonsterBits.Hostile, On = false}         -- "Southern Village Group in Harmondy"
end

events.LoadMap = evt.map[1].last

evt.house[3] = 51  -- "Buckskins and Bucklers"
Game.MapEvtLines:RemoveEvent(3)
evt.map[3] = function()
	evt.EnterHouse{Id = 51}         -- "Buckskins and Bucklers"
end

evt.house[4] = 51  -- "Buckskins and Bucklers"
Game.MapEvtLines:RemoveEvent(4)
evt.map[4] = function()
end

evt.house[5] = 87  -- "Natural Magic"
Game.MapEvtLines:RemoveEvent(5)
evt.map[5] = function()
	evt.EnterHouse{Id = 87}         -- "Natural Magic"
end

evt.house[6] = 87  -- "Natural Magic"
Game.MapEvtLines:RemoveEvent(6)
evt.map[6] = function()
end

evt.house[7] = 119  -- "The Bubbling Cauldron"
Game.MapEvtLines:RemoveEvent(7)
evt.map[7] = function()
	evt.EnterHouse{Id = 119}         -- "The Bubbling Cauldron"
end

evt.house[8] = 119  -- "The Bubbling Cauldron"
Game.MapEvtLines:RemoveEvent(8)
evt.map[8] = function()
end

evt.house[9] = 463  -- "Hu's Stallions"
Game.MapEvtLines:RemoveEvent(9)
evt.map[9] = function()
	evt.EnterHouse{Id = 463}         -- "Hu's Stallions"
end

evt.house[10] = 463  -- "Hu's Stallions"
Game.MapEvtLines:RemoveEvent(10)
evt.map[10] = function()
end

evt.house[11] = 487  -- "Sea Sprite"
Game.MapEvtLines:RemoveEvent(11)
evt.map[11] = function()
	evt.EnterHouse{Id = 487}         -- "Sea Sprite"
end

evt.house[12] = 487  -- "Sea Sprite"
Game.MapEvtLines:RemoveEvent(12)
evt.map[12] = function()
end

evt.house[13] = 313  -- "Nature's Remedies"
Game.MapEvtLines:RemoveEvent(13)
evt.map[13] = function()
	evt.EnterHouse{Id = 313}         -- "Nature's Remedies"
end

evt.house[14] = 313  -- "Nature's Remedies"
Game.MapEvtLines:RemoveEvent(14)
evt.map[14] = function()
end

evt.house[15] = 1573  -- "The Proving Grounds"
Game.MapEvtLines:RemoveEvent(15)
evt.map[15] = function()
	evt.EnterHouse{Id = 1573}         -- "The Proving Grounds"
end

evt.house[16] = 1573  -- "The Proving Grounds"
Game.MapEvtLines:RemoveEvent(16)
evt.map[16] = function()
end

evt.house[17] = 205  -- "Pierpont Townhall"
Game.MapEvtLines:RemoveEvent(17)
evt.map[17] = function()
	evt.EnterHouse{Id = 205}         -- "Pierpont Townhall"
end

evt.house[18] = 205  -- "Pierpont Townhall"
Game.MapEvtLines:RemoveEvent(18)
evt.map[18] = function()
end

evt.house[19] = 242  -- "Emerald Inn"
Game.MapEvtLines:RemoveEvent(19)
evt.map[19] = function()
	evt.EnterHouse{Id = 242}         -- "Emerald Inn"
end

evt.house[20] = 242  -- "Emerald Inn"
Game.MapEvtLines:RemoveEvent(20)
evt.map[20] = function()
end

evt.house[21] = 288  -- "Nature's Stockpile"
Game.MapEvtLines:RemoveEvent(21)
evt.map[21] = function()
	evt.EnterHouse{Id = 288}         -- "Nature's Stockpile"
end

evt.house[22] = 288  -- "Nature's Stockpile"
Game.MapEvtLines:RemoveEvent(22)
evt.map[22] = function()
end

evt.house[23] = 130  -- "Master Guild of Fire"
Game.MapEvtLines:RemoveEvent(23)
evt.map[23] = function()
	evt.EnterHouse{Id = 130}         -- "Master Guild of Fire"
end

evt.house[24] = 130  -- "Master Guild of Fire"
Game.MapEvtLines:RemoveEvent(24)
evt.map[24] = function()
end

evt.house[25] = 136  -- "Master Guild of Air"
Game.MapEvtLines:RemoveEvent(25)
evt.map[25] = function()
	evt.EnterHouse{Id = 136}         -- "Master Guild of Air"
end

evt.house[26] = 136  -- "Master Guild of Air"
Game.MapEvtLines:RemoveEvent(26)
evt.map[26] = function()
end

evt.house[27] = 141  -- "Adept Guild of Water"
Game.MapEvtLines:RemoveEvent(27)
evt.map[27] = function()
	evt.EnterHouse{Id = 141}         -- "Adept Guild of Water"
end

evt.house[28] = 141  -- "Adept Guild of Water"
Game.MapEvtLines:RemoveEvent(28)
evt.map[28] = function()
end

evt.house[29] = 147  -- "Adept Guild of Earth"
Game.MapEvtLines:RemoveEvent(29)
evt.map[29] = function()
	evt.EnterHouse{Id = 147}         -- "Adept Guild of Earth"
end

evt.house[30] = 147  -- "Adept Guild of Earth"
Game.MapEvtLines:RemoveEvent(30)
evt.map[30] = function()
end

evt.house[32] = 11  -- "Hunter's Lodge"
Game.MapEvtLines:RemoveEvent(32)
evt.map[32] = function()
	evt.EnterHouse{Id = 11}         -- "Hunter's Lodge"
end

evt.house[33] = 11  -- "Hunter's Lodge"
Game.MapEvtLines:RemoveEvent(33)
evt.map[33] = function()
end

evt.hint[51] = evt.str[7]  -- "House"
evt.house[52] = 946  -- "Bith Residence"
Game.MapEvtLines:RemoveEvent(52)
evt.map[52] = function()
	evt.EnterHouse{Id = 946}         -- "Bith Residence"
end

evt.house[53] = 947  -- "Suretrail Home"
Game.MapEvtLines:RemoveEvent(53)
evt.map[53] = function()
	evt.EnterHouse{Id = 947}         -- "Suretrail Home"
end

evt.house[54] = 948  -- "Silverpoint Residence"
Game.MapEvtLines:RemoveEvent(54)
evt.map[54] = function()
	evt.EnterHouse{Id = 948}         -- "Silverpoint Residence"
end

evt.house[55] = 949  -- "Miyon's Home"
Game.MapEvtLines:RemoveEvent(55)
evt.map[55] = function()
	evt.EnterHouse{Id = 949}         -- "Miyon's Home"
end

evt.house[56] = 950  -- "Green House"
Game.MapEvtLines:RemoveEvent(56)
evt.map[56] = function()
	evt.EnterHouse{Id = 950}         -- "Green House"
end

evt.house[57] = 951  -- "Warlin Residence"
Game.MapEvtLines:RemoveEvent(57)
evt.map[57] = function()
	evt.EnterHouse{Id = 951}         -- "Warlin Residence"
end

evt.house[58] = 952  -- "Dotes Residence"
Game.MapEvtLines:RemoveEvent(58)
evt.map[58] = function()
	evt.EnterHouse{Id = 952}         -- "Dotes Residence"
end

evt.house[59] = 953  -- "Blueswan Home"
Game.MapEvtLines:RemoveEvent(59)
evt.map[59] = function()
	evt.EnterHouse{Id = 953}         -- "Blueswan Home"
end

evt.house[60] = 954  -- "Temper Residence"
Game.MapEvtLines:RemoveEvent(60)
evt.map[60] = function()
	evt.EnterHouse{Id = 954}         -- "Temper Residence"
end

evt.house[61] = 955  -- "Windsong House"
Game.MapEvtLines:RemoveEvent(61)
evt.map[61] = function()
	evt.EnterHouse{Id = 955}         -- "Windsong House"
end

evt.house[62] = 956  -- "Whitecap Residence"
Game.MapEvtLines:RemoveEvent(62)
evt.map[62] = function()
	evt.EnterHouse{Id = 956}         -- "Whitecap Residence"
end

evt.house[63] = 957  -- "Ottin House"
Game.MapEvtLines:RemoveEvent(63)
evt.map[63] = function()
	evt.EnterHouse{Id = 957}         -- "Ottin House"
end

evt.house[64] = 958  -- "Black House"
Game.MapEvtLines:RemoveEvent(64)
evt.map[64] = function()
	evt.EnterHouse{Id = 958}         -- "Black House"
end

evt.house[65] = 959  -- "Fiddlebone Residence"
Game.MapEvtLines:RemoveEvent(65)
evt.map[65] = function()
	evt.EnterHouse{Id = 959}         -- "Fiddlebone Residence"
end

evt.house[66] = 960  -- "Kerrid Residence"
Game.MapEvtLines:RemoveEvent(66)
evt.map[66] = function()
	evt.EnterHouse{Id = 960}         -- "Kerrid Residence"
end

evt.house[67] = 961  -- "Willowbark's Home"
Game.MapEvtLines:RemoveEvent(67)
evt.map[67] = function()
	evt.EnterHouse{Id = 961}         -- "Willowbark's Home"
end

evt.house[68] = 962  -- "House 324"
Game.MapEvtLines:RemoveEvent(68)
evt.map[68] = function()
	evt.EnterHouse{Id = 962}         -- "House 324"
end

evt.house[69] = 963  -- "House 325"
Game.MapEvtLines:RemoveEvent(69)
evt.map[69] = function()
	evt.EnterHouse{Id = 963}         -- "House 325"
end

evt.house[70] = 964  -- "House 326"
Game.MapEvtLines:RemoveEvent(70)
evt.map[70] = function()
	evt.EnterHouse{Id = 964}         -- "House 326"
end

evt.house[71] = 965  -- "Benjamin's Home"
Game.MapEvtLines:RemoveEvent(71)
evt.map[71] = function()
	evt.EnterHouse{Id = 965}         -- "Benjamin's Home"
end

evt.house[72] = 966  -- "Stonewright Residence"
Game.MapEvtLines:RemoveEvent(72)
evt.map[72] = function()
	evt.EnterHouse{Id = 966}         -- "Stonewright Residence"
end

evt.house[73] = 967  -- "Weatherson's House"
Game.MapEvtLines:RemoveEvent(73)
evt.map[73] = function()
	evt.EnterHouse{Id = 967}         -- "Weatherson's House"
end

evt.house[74] = 968  -- "Sower Residence"
Game.MapEvtLines:RemoveEvent(74)
evt.map[74] = function()
	evt.EnterHouse{Id = 968}         -- "Sower Residence"
end

evt.hint[75] = evt.str[9]  -- "Tent"
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

evt.hint[203] = evt.str[5]  -- "Fountain"
evt.hint[204] = evt.str[6]  -- "Drink from the Fountain"
Game.MapEvtLines:RemoveEvent(204)
evt.map[204] = function()
	if evt.Cmp{"PlayerBits", Value = 8} then
		evt.StatusText{Str = 11}         -- "Refreshing!"
		return
	end
	if not evt.Cmp{"AutonotesBits", Value = 269} then         -- "50 points of temporary Earth resistance from the central fountain in Pierpont."
		evt.Add{"AutonotesBits", Value = 269}         -- "50 points of temporary Earth resistance from the central fountain in Pierpont."
	end
	evt.Add{"EarthResBonus", Value = 50}
	evt.Add{"PlayerBits", Value = 8}
	evt.StatusText{Str = 70}         -- "+50 Earth Resistance (Temporary)"
end

Timer(function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	evt.Subtract{"PlayerBits", Value = 8}
end, const.Day, 1*const.Hour)

evt.hint[205] = evt.str[25]  -- "Castle Navan"
evt.hint[401] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(401)
evt.map[401] = function()  -- function events.LoadMap()
	if not evt.Cmp{"QBits", Value = 649} then         -- Artifact Messenger only happens once
		if evt.Cmp{"Counter3", Value = 1344} then
			if not evt.Cmp{"Counter3", Value = 2016} then
				evt.SpeakNPC{NPC = 412}         -- "Messenger"
				evt.Add{"Inventory", Value = 1502}         -- "Message from Erathia"
				evt.Set{"QBits", Value = 649}         -- Artifact Messenger only happens once
				evt.Set{"QBits", Value = 591}         -- "Retrieve Gryphonheart's Trumpet from the battle in the Tularean Forest and return it to whichever side you choose."
				evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Untouchable, On = false}
				evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Invisible, On = false}
				evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 3, X = -15752, Y = 21272, Z = 3273, NPCGroup = 51, unk = 0}
				evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 5, X = -14000, Y = 18576, Z = 4250, NPCGroup = 51, unk = 0}
				evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 10, X = -16016, Y = 19280, Z = 3284, NPCGroup = 51, unk = 0}
				evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 30, X = -15752, Y = 21272, Z = 3273, NPCGroup = 51, unk = 0}
				evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 9, X = -14000, Y = 18576, Z = 4250, NPCGroup = 51, unk = 0}
				evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 10, X = -16016, Y = 19280, Z = 3284, NPCGroup = 51, unk = 0}
			end
		end
	end
end

events.LoadMap = evt.map[401].last

evt.hint[402] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(402)
evt.map[402] = function()
	evt.SpeakNPC{NPC = 392}         -- "The Oldest Tree"
end

evt.hint[403] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(403)
evt.map[403] = function()  -- Timer(<function>, 5*const.Minute)
	if evt.Cmp{"QBits", Value = 553} then         -- Solved Tree quest
		evt.SetMonGroupBit{NPCGroup = 61, Bit = const.MonsterBits.Hostile, On = false}         -- "Southern Village Group in Harmondy"
	end
end

Timer(evt.map[403].last, 5*const.Minute)

evt.hint[451] = evt.str[52]  -- "Shrine"
evt.hint[452] = evt.str[53]  -- "Altar"
Game.MapEvtLines:RemoveEvent(452)
evt.map[452] = function()
	if evt.Cmp{"PlayerBits", Value = 25} then
		evt.StatusText{Str = 54}         -- "You Pray"
	else
		evt.Add{"WaterResistance", Value = 10}
		evt.Add{"FireResistance", Value = 10}
		evt.Add{"AirResistance", Value = 10}
		evt.Add{"PlayerBits", Value = 25}
		evt.StatusText{Str = 76}         -- "+10 Water, Fire, and Air Resistance(Permanent)"
	end
end

evt.hint[453] = evt.str[50]  -- "Obelisk"
Game.MapEvtLines:RemoveEvent(453)
evt.map[453] = function()
	if not evt.Cmp{"QBits", Value = 678} then         -- Visited Obelisk in Area 4
		evt.StatusText{Str = 51}         -- "redditoh"
		evt.Add{"AutonotesBits", Value = 311}         -- "Obelisk message #3: redditoh"
		evt.ForPlayer(-- ERROR: Const not found
"All")
		evt.Add{"QBits", Value = 678}         -- Visited Obelisk in Area 4
	end
end

evt.hint[500] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(500)
evt.map[500] = function()  -- function events.LoadMap()
	if evt.CheckSeason{Season = 2} then
		evt.SetSprite{SpriteId = 5, Visible = 1, Name = "7tree08"}
		evt.SetSprite{SpriteId = 6, Visible = 1, Name = "7tree26"}
		evt.StatusText{Str = 62}         -- ""
		goto _23
	end
	if evt.CheckSeason{Season = 3} then
		evt.SetSprite{SpriteId = 5, Visible = 1, Name = "7tree09"}
		evt.SetSprite{SpriteId = 6, Visible = 1, Name = "7tree27"}
		evt.StatusText{Str = 63}         -- ""
		goto _23
	end
	evt.SetSprite{SpriteId = 5, Visible = 1, Name = "7tree07"}
	evt.SetSprite{SpriteId = 6, Visible = 1, Name = "7tree25"}
	evt.SetSprite{SpriteId = 7, Visible = 1, Name = "tree38"}
	evt.SetSprite{SpriteId = 10, Visible = 1, Name = "0"}
	if evt.Cmp{"MapVar50", Value = 1} then
		evt.SetSprite{SpriteId = 51, Visible = 1, Name = "tree37"}
	else
		evt.SetSprite{SpriteId = 51, Visible = 1, Name = "tree38"}
	end
	if evt.Cmp{"MapVar51", Value = 1} then
		evt.SetSprite{SpriteId = 52, Visible = 1, Name = "tree37"}
	else
		evt.SetSprite{SpriteId = 52, Visible = 1, Name = "tree38"}
	end
	if evt.Cmp{"MapVar52", Value = 1} then
		evt.SetSprite{SpriteId = 53, Visible = 1, Name = "tree37"}
	else
		evt.SetSprite{SpriteId = 53, Visible = 1, Name = "tree38"}
	end
	if evt.Cmp{"MapVar53", Value = 1} then
		evt.SetSprite{SpriteId = 54, Visible = 1, Name = "tree37"}
	else
		evt.SetSprite{SpriteId = 54, Visible = 1, Name = "tree38"}
	end
	if evt.Cmp{"MapVar54", Value = 1} then
		evt.SetSprite{SpriteId = 55, Visible = 1, Name = "tree37"}
	else
		evt.SetSprite{SpriteId = 55, Visible = 1, Name = "tree38"}
	end
	if evt.Cmp{"MapVar55", Value = 1} then
		evt.SetSprite{SpriteId = 56, Visible = 1, Name = "tree"}
	else
		evt.SetSprite{SpriteId = 56, Visible = 1, Name = "tree38"}
	end
	if evt.Cmp{"MapVar56", Value = 1} then
		evt.SetSprite{SpriteId = 57, Visible = 1, Name = "tree37"}
	else
		evt.SetSprite{SpriteId = 57, Visible = 1, Name = "tree38"}
	end
	if evt.Cmp{"MapVar57", Value = 1} then
		evt.SetSprite{SpriteId = 58, Visible = 1, Name = "tree37"}
	else
		evt.SetSprite{SpriteId = 58, Visible = 1, Name = "tree38"}
	end
	if evt.Cmp{"MapVar58", Value = 1} then
		evt.SetSprite{SpriteId = 59, Visible = 1, Name = "tree37"}
	else
		evt.SetSprite{SpriteId = 59, Visible = 1, Name = "tree38"}
	end
	if evt.Cmp{"MapVar59", Value = 1} then
		evt.SetSprite{SpriteId = 60, Visible = 1, Name = "tree37"}
	else
		evt.SetSprite{SpriteId = 60, Visible = 1, Name = "tree38"}
	end
	if evt.Cmp{"MapVar60", Value = 1} then
		evt.SetSprite{SpriteId = 61, Visible = 1, Name = "tree"}
	else
		evt.SetSprite{SpriteId = 61, Visible = 1, Name = "tree38"}
	end
	if evt.CheckSeason{Season = 1} then
		evt.StatusText{Str = 61}         -- "You received an apple"
	else
		if evt.CheckSeason{Season = 0} then
			evt.StatusText{Str = 60}         -- "Fruit Tree"
		else
			evt.StatusText{Str = 64}         -- ""
		end
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
	if not evt.CheckSeason{Season = 3} then
		if not evt.CheckSeason{Season = 2} then
			if not evt.Cmp{"MapVar50", Value = 1} then
				evt.Add{"Inventory", Value = 1432}         -- "Red Delicious Apple"
				evt.Set{"MapVar50", Value = 1}
				evt.StatusText{Str = 61}         -- "You received an apple"
				evt.SetSprite{SpriteId = 51, Visible = 1, Name = "tree37"}
			end
		end
	end
end

evt.hint[252] = evt.str[60]  -- "Fruit Tree"
Game.MapEvtLines:RemoveEvent(252)
evt.map[252] = function()
	if not evt.CheckSeason{Season = 3} then
		if not evt.CheckSeason{Season = 2} then
			if not evt.Cmp{"MapVar51", Value = 1} then
				evt.Add{"Inventory", Value = 1432}         -- "Red Delicious Apple"
				evt.Set{"MapVar51", Value = 1}
				evt.StatusText{Str = 61}         -- "You received an apple"
				evt.SetSprite{SpriteId = 52, Visible = 1, Name = "tree37"}
			end
		end
	end
end

evt.hint[253] = evt.str[60]  -- "Fruit Tree"
Game.MapEvtLines:RemoveEvent(253)
evt.map[253] = function()
	if not evt.CheckSeason{Season = 3} then
		if not evt.CheckSeason{Season = 2} then
			if not evt.Cmp{"MapVar52", Value = 1} then
				evt.Add{"Inventory", Value = 1432}         -- "Red Delicious Apple"
				evt.Set{"MapVar52", Value = 1}
				evt.StatusText{Str = 61}         -- "You received an apple"
				evt.SetSprite{SpriteId = 53, Visible = 1, Name = "tree37"}
			end
		end
	end
end

evt.hint[254] = evt.str[60]  -- "Fruit Tree"
Game.MapEvtLines:RemoveEvent(254)
evt.map[254] = function()
	if not evt.CheckSeason{Season = 3} then
		if not evt.CheckSeason{Season = 2} then
			if not evt.Cmp{"MapVar53", Value = 1} then
				evt.Add{"Inventory", Value = 1432}         -- "Red Delicious Apple"
				evt.Set{"MapVar53", Value = 1}
				evt.StatusText{Str = 61}         -- "You received an apple"
				evt.SetSprite{SpriteId = 54, Visible = 1, Name = "tree37"}
			end
		end
	end
end

evt.hint[255] = evt.str[60]  -- "Fruit Tree"
Game.MapEvtLines:RemoveEvent(255)
evt.map[255] = function()
	if not evt.CheckSeason{Season = 3} then
		if not evt.CheckSeason{Season = 2} then
			if not evt.Cmp{"MapVar54", Value = 1} then
				evt.Add{"Inventory", Value = 1432}         -- "Red Delicious Apple"
				evt.Set{"MapVar54", Value = 1}
				evt.StatusText{Str = 61}         -- "You received an apple"
				evt.SetSprite{SpriteId = 55, Visible = 1, Name = "tree37"}
			end
		end
	end
end

evt.hint[256] = evt.str[60]  -- "Fruit Tree"
Game.MapEvtLines:RemoveEvent(256)
evt.map[256] = function()
	if not evt.CheckSeason{Season = 3} then
		if not evt.CheckSeason{Season = 2} then
			if not evt.Cmp{"MapVar55", Value = 1} then
				evt.Add{"Inventory", Value = 1432}         -- "Red Delicious Apple"
				evt.Set{"MapVar55", Value = 1}
				evt.StatusText{Str = 61}         -- "You received an apple"
				evt.SetSprite{SpriteId = 56, Visible = 1, Name = "tree37"}
			end
		end
	end
end

evt.hint[257] = evt.str[60]  -- "Fruit Tree"
Game.MapEvtLines:RemoveEvent(257)
evt.map[257] = function()
	if not evt.CheckSeason{Season = 3} then
		if not evt.CheckSeason{Season = 2} then
			if not evt.Cmp{"MapVar56", Value = 1} then
				evt.Add{"Inventory", Value = 1432}         -- "Red Delicious Apple"
				evt.Set{"MapVar56", Value = 1}
				evt.StatusText{Str = 61}         -- "You received an apple"
				evt.SetSprite{SpriteId = 57, Visible = 1, Name = "tree37"}
			end
		end
	end
end

evt.hint[258] = evt.str[60]  -- "Fruit Tree"
Game.MapEvtLines:RemoveEvent(258)
evt.map[258] = function()
	if not evt.CheckSeason{Season = 3} then
		if not evt.CheckSeason{Season = 2} then
			if not evt.Cmp{"MapVar57", Value = 1} then
				evt.Add{"Inventory", Value = 1432}         -- "Red Delicious Apple"
				evt.Set{"MapVar57", Value = 1}
				evt.StatusText{Str = 61}         -- "You received an apple"
				evt.SetSprite{SpriteId = 58, Visible = 1, Name = "tree37"}
			end
		end
	end
end

evt.hint[259] = evt.str[60]  -- "Fruit Tree"
Game.MapEvtLines:RemoveEvent(259)
evt.map[259] = function()
	if not evt.CheckSeason{Season = 3} then
		if not evt.CheckSeason{Season = 2} then
			if not evt.Cmp{"MapVar58", Value = 1} then
				evt.Add{"Inventory", Value = 1432}         -- "Red Delicious Apple"
				evt.Set{"MapVar58", Value = 1}
				evt.StatusText{Str = 61}         -- "You received an apple"
				evt.SetSprite{SpriteId = 59, Visible = 1, Name = "tree37"}
			end
		end
	end
end

evt.hint[260] = evt.str[60]  -- "Fruit Tree"
Game.MapEvtLines:RemoveEvent(260)
evt.map[260] = function()
	if not evt.CheckSeason{Season = 3} then
		if not evt.CheckSeason{Season = 2} then
			if not evt.Cmp{"MapVar59", Value = 1} then
				evt.Add{"Inventory", Value = 1432}         -- "Red Delicious Apple"
				evt.Set{"MapVar59", Value = 1}
				evt.StatusText{Str = 61}         -- "You received an apple"
				evt.SetSprite{SpriteId = 60, Visible = 1, Name = "tree37"}
			end
		end
	end
end

evt.hint[261] = evt.str[60]  -- "Fruit Tree"
Game.MapEvtLines:RemoveEvent(261)
evt.map[261] = function()
	if not evt.CheckSeason{Season = 3} then
		if not evt.CheckSeason{Season = 2} then
			if not evt.Cmp{"MapVar60", Value = 1} then
				evt.Add{"Inventory", Value = 1432}         -- "Red Delicious Apple"
				evt.Set{"MapVar60", Value = 1}
				evt.StatusText{Str = 61}         -- "You received an apple"
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
	evt.StatusText{Str = 34}         -- "The entrance has been sealed by a rockslide"
end

evt.hint[503] = evt.str[32]  -- "Enter Clanker's Laboratory"
Game.MapEvtLines:RemoveEvent(503)
evt.map[503] = function()
	evt.StatusText{Str = 21}         -- "This Door is Locked"
end



--[[ MMMerge additions ]]--

-- The Tularean Forest

function events.AfterLoadMap()
	Party.QBits[939] = true	-- DDMapBuff, changed for rev4 for merge
end

-- Dimension door
function events.TileSound(t)
	if t.X == 84 and t.Y == 94 then
		TownPortalControls.DimDoorEvent()
	end
end

