local TXT = Localize{
	[0] = " ",
	[1] = "Chest ",
	[2] = "Barrel",
	[3] = "Well",
	[4] = "Drink from the Well",
	[5] = "Fountain",
	[6] = "Drink from the Fountain",
	[7] = "House",
	[8] = "Your packs are full!",
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
	[25] = "Titan Stronghold",
	[26] = "Temple of Baa",
	[27] = "Hall under the Hill",
	[28] = "",
	[29] = "",
	[30] = "Enter the The Titan Stronghold",
	[31] = "Enter the Temple of Baa",
	[32] = "Enter the Hall under the Hill",
	[33] = "",
	[34] = "",
	[35] = "Temple",
	[36] = "Guilds",
	[37] = "Stables",
	[38] = "Docks",
	[39] = "Shops",
	[40] = "",
	[41] = "",
	[42] = "East to the Tularean Forest",
	[43] = "North ",
	[44] = "West",
	[45] = "South ",
	[46] = "Avlee",
	[47] = "",
	[48] = "",
	[49] = "",
	[50] = "Obelisk",
	[51] = "__dn_r_n",
	[52] = "Shrine",
	[53] = "Altar",
	[54] = "You Pray",
	[55] = "Home Portal",
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
	[70] = "+2 Endurance (Permanent)",
	[71] = "+20 Water Resistance (Temporary)",
	[72] = "+25 Hit Points",
}
table.copy(TXT, evt.str, true)



evt.hint[1] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(1)
evt.map[1] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 882) then         -- "Obtain Plague Elixir from Lucid Apple in Avlee and deliver it to King Hothffar in Stone City within two days."
		evt.SetNPCTopic{NPC = 547, Index = 1, Event = 1202}         -- "Lucid Apple" : "We need your help!"
	end
end

events.LoadMap = evt.map[1].last

Game.MapEvtLines:RemoveEvent(3)
evt.HouseDoor(3, 56)  -- "Avlee Outpost"
evt.house[4] = 56  -- "Avlee Outpost"
Game.MapEvtLines:RemoveEvent(5)
evt.HouseDoor(5, 467)  -- "Plush Coaches"
evt.house[6] = 467  -- "Plush Coaches"
Game.MapEvtLines:RemoveEvent(7)
evt.HouseDoor(7, 492)  -- "Wind Runner"
evt.house[8] = 492  -- "Wind Runner"
Game.MapEvtLines:RemoveEvent(9)
evt.HouseDoor(9, 320)  -- "Temple of Tranquility"
evt.house[10] = 320  -- "Temple of Tranquility"
Game.MapEvtLines:RemoveEvent(11)
evt.HouseDoor(11, 1578)  -- "Avlee Gymnaisium"
evt.house[12] = 1578  -- "Avlee Gymnaisium"
Game.MapEvtLines:RemoveEvent(13)
evt.HouseDoor(13, 251)  -- "The Potted Pixie"
evt.house[14] = 251  -- "The Potted Pixie"
Game.MapEvtLines:RemoveEvent(15)
evt.HouseDoor(15, 292)  -- "Halls of Gold"
evt.house[16] = 292  -- "Halls of Gold"
Game.MapEvtLines:RemoveEvent(17)
evt.HouseDoor(17, 161)  -- "Paramount Guild of Mind"
evt.house[18] = 161  -- "Paramount Guild of Mind"
Game.MapEvtLines:RemoveEvent(19)
evt.HouseDoor(19, 167)  -- "Paramount Guild of Body"
evt.house[20] = 167  -- "Paramount Guild of Body"
Game.MapEvtLines:RemoveEvent(21)
evt.HouseDoor(21, 16)  -- "The Knocked Bow"
evt.house[22] = 16  -- "The Knocked Bow"
evt.hint[30] = evt.str[55]  -- "Home Portal"
Game.MapEvtLines:RemoveEvent(30)
evt.map[30] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 1472) then         -- "Home Key"
		evt.MoveToMap{X = -9853, Y = 8656, Z = -1024, Direction = 2047, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "7Out03.Odm"}
	else
		evt.StatusText(22)         -- "You need the Home Key to use this teleporter."
	end
end

evt.hint[51] = evt.str[7]  -- "House"
Game.MapEvtLines:RemoveEvent(52)
evt.HouseDoor(52, 1014)  -- "Featherwind Residence"
Game.MapEvtLines:RemoveEvent(53)
evt.HouseDoor(53, 1015)  -- "Ravenhair Residence"
Game.MapEvtLines:RemoveEvent(54)
evt.HouseDoor(54, 1020)  -- "Condemned Dwelling"
Game.MapEvtLines:RemoveEvent(55)
evt.HouseDoor(55, 1021)  -- "Alice's Restaurant"
Game.MapEvtLines:RemoveEvent(56)
evt.HouseDoor(56, 1022)  -- "Deerhunter Residence"
Game.MapEvtLines:RemoveEvent(57)
evt.HouseDoor(57, 1023)  -- "Swiftfoot's House"
Game.MapEvtLines:RemoveEvent(58)
evt.HouseDoor(58, 1140)  -- "Tempus' House"
Game.MapEvtLines:RemoveEvent(59)
evt.HouseDoor(59, 1141)  -- "Kaine's"
Game.MapEvtLines:RemoveEvent(60)
evt.HouseDoor(60, 1142)  -- "Apple Residence"
evt.hint[61] = evt.str[9]  -- "Tent"
Game.MapEvtLines:RemoveEvent(63)
evt.HouseDoor(63, 1016)  -- "Jillian's House"
Game.MapEvtLines:RemoveEvent(64)
evt.HouseDoor(64, 1017)  -- "Greenstorm Residence"
Game.MapEvtLines:RemoveEvent(67)
evt.HouseDoor(67, 1008)  -- "Brightspear Residence"
Game.MapEvtLines:RemoveEvent(68)
evt.HouseDoor(68, 1009)  -- "Holden Residence"
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
	if not evt.Cmp("QBits", 581) then         -- Placed Golem left arm
		if not evt.Cmp("QBits", 734) then         -- Left arm - I lost it
			evt.Add("QBits", 734)         -- Left arm - I lost it
		end
	end
end

evt.hint[201] = evt.str[3]  -- "Well"
evt.hint[202] = evt.str[4]  -- "Drink from the Well"
Game.MapEvtLines:RemoveEvent(202)
evt.map[202] = function()
	if evt.Cmp("HasFullHP", 0) then
		evt.StatusText(11)         -- "Refreshing!"
	else
		evt.Add("HP", 25)
		evt.StatusText(72)         -- "+25 Hit Points"
	end
end

evt.hint[203] = evt.str[4]  -- "Drink from the Well"
Game.MapEvtLines:RemoveEvent(203)
evt.map[203] = function()
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

evt.hint[204] = evt.str[4]  -- "Drink from the Well"
Game.MapEvtLines:RemoveEvent(204)
evt.map[204] = function()
	if evt.Cmp("PlayerBits", 23) then
		evt.StatusText(11)         -- "Refreshing!"
		return
	end
	if not evt.Cmp("AutonotesBits", 287) then         -- "20 points of temporary Water resistance from the well in the northwest section of Spaward in Avlee."
		evt.Add("AutonotesBits", 287)         -- "20 points of temporary Water resistance from the well in the northwest section of Spaward in Avlee."
	end
	evt.Add("WaterResBonus", 20)
	evt.Add("PlayerBits", 23)
	evt.StatusText(71)         -- "+20 Water Resistance (Temporary)"
end

RefillTimer(function()
	evt.ForPlayer("All")
	evt.Subtract("PlayerBits", 23)
end, const.Day)

evt.hint[205] = evt.str[4]  -- "Drink from the Well"
Game.MapEvtLines:RemoveEvent(205)
evt.map[205] = function()
	if evt.Cmp("PlayerBits", 22) then
		evt.StatusText(11)         -- "Refreshing!"
		return
	end
	if not evt.Cmp("AutonotesBits", 286) then         -- "2 points of permanent Endurance from the well in the northeast section of Spaward in Avlee."
		evt.Add("AutonotesBits", 286)         -- "2 points of permanent Endurance from the well in the northeast section of Spaward in Avlee."
	end
	evt.Add("BaseEndurance", 2)
	evt.Add("PlayerBits", 22)
	evt.StatusText(70)         -- "+2 Endurance (Permanent)"
end

evt.hint[206] = evt.str[26]  -- "Temple of Baa"
evt.hint[207] = evt.str[25]  -- "Titan Stronghold"
evt.hint[208] = evt.str[27]  -- "Hall under the Hill"
evt.hint[209] = evt.str[55]  -- "Home Portal"
evt.hint[401] = evt.str[53]  -- "Altar"
Game.MapEvtLines:RemoveEvent(401)
evt.map[401] = function()
	if evt.Cmp("QBits", 561) then         -- "Visit the three stonehenge monoliths in Tatalia, the Evenmorn Islands, and Avlee, then return to Anthony Green in the Tularean Forest."
		if not evt.Cmp("QBits", 562) then         -- Visited all stonehenges
			if not evt.Cmp("QBits", 565) then         -- Visited stonehenge 3 (area 14)
				evt.StatusText(56)         -- ""
				evt.ForPlayer("All")
				evt.Set("QBits", 565)         -- Visited stonehenge 3 (area 14)
				evt.ForPlayer("All")
				evt.Add("QBits", 757)         -- "Congratulations"
				evt.Subtract("QBits", 757)         -- "Congratulations"
				if evt.Cmp("QBits", 563) then         -- Visited stonehenge 1 (area 9)
					if evt.Cmp("QBits", 564) then         -- Visited stonehenge 2 (area 13)
						evt.ForPlayer("All")
						evt.Set("QBits", 562)         -- Visited all stonehenges
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
	if not evt.Cmp("QBits", 713) then         -- Placed item 617 in out14(statue)
		if evt.Cmp("QBits", 712) then         -- "Retrieve the three statuettes and place them on the shrines in the Bracada Desert, Tatalia, and Avlee, then return to Thom Lumbra in the Tularean Forest."
			evt.ForPlayer("All")
			if evt.Cmp("Inventory", 1419) then         -- "Knight Statuette"
				evt.SetSprite{SpriteId = 25, Visible = 1, Name = "0"}
				evt.Subtract("Inventory", 1419)         -- "Knight Statuette"
				evt.Set("QBits", 713)         -- Placed item 617 in out14(statue)
			end
		end
	end
end

evt.hint[453] = evt.str[50]  -- "Obelisk"
Game.MapEvtLines:RemoveEvent(453)
evt.map[453] = function()
	if not evt.Cmp("QBits", 688) then         -- Visited Obelisk in Area 14
		evt.StatusText(51)         -- "__dn_r_n"
		evt.Add("AutonotesBits", 321)         -- "Obelisk message #13: __dn_r_n"
		evt.ForPlayer("All")
		evt.Add("QBits", 688)         -- Visited Obelisk in Area 14
	end
end

evt.hint[454] = evt.str[46]  -- "Avlee"
evt.hint[455] = evt.str[42]  -- "East to the Tularean Forest"
evt.hint[456] = evt.str[38]  -- "Docks"
evt.hint[250] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(250)
evt.map[250] = function()  -- function events.LoadMap()
	if evt.CheckSeason(2) then
		evt.SetSprite{SpriteId = 5, Visible = 1, Name = "7tree14"}
		evt.SetSprite{SpriteId = 6, Visible = 1, Name = "7tree17"}
		evt.StatusText(62)         -- ""
		goto _23
	end
	if evt.CheckSeason(3) then
		evt.SetSprite{SpriteId = 5, Visible = 1, Name = "7tree15"}
		evt.SetSprite{SpriteId = 6, Visible = 1, Name = "7tree18"}
		evt.StatusText(63)         -- ""
		goto _23
	end
	evt.SetSprite{SpriteId = 5, Visible = 1, Name = "7tree13"}
	evt.SetSprite{SpriteId = 6, Visible = 1, Name = "7tree16"}
	evt.SetSprite{SpriteId = 7, Visible = 1, Name = "7tree22"}
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
	if evt.CheckSeason(1) then
		evt.StatusText(61)         -- "You received an apple"
	elseif evt.CheckSeason(0) then
		evt.StatusText(60)         -- "Fruit Tree"
	else
		evt.StatusText(64)         -- ""
	end
	do return end
::_23::
	evt.SetSprite{SpriteId = 7, Visible = 1, Name = "7tree24"}
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
end

events.LoadMap = evt.map[250].last

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

evt.hint[501] = evt.str[30]  -- "Enter the The Titan Stronghold"
Game.MapEvtLines:RemoveEvent(501)
evt.map[501] = function()
	evt.MoveToMap{X = -1707, Y = -21848, Z = -1007, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 413, Icon = 9, Name = "7D09.blv"}         -- "Titan's Stronghold"
end

evt.hint[502] = evt.str[31]  -- "Enter the Temple of Baa"
Game.MapEvtLines:RemoveEvent(502)
evt.map[502] = function()
	evt.MoveToMap{X = 1, Y = -2772, Z = 1, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 414, Icon = 9, Name = "D04.blv"}         -- "Temple of Baa"
end

evt.hint[503] = evt.str[32]  -- "Enter the Hall under the Hill"
Game.MapEvtLines:RemoveEvent(503)
evt.map[503] = function()
	evt.MoveToMap{X = -1114, Y = 2778, Z = 1, Direction = 1280, LookAngle = 0, SpeedZ = 0, HouseId = 415, Icon = 3, Name = "7D22.blv"}         -- "Hall under the Hill"
end



--[[ MMMerge additions ]]--

-- Avlee

function events.AfterLoadMap()
	Party.QBits[949] = true	-- DDMapBuff, changed for rev4 for merge
end

function events.WalkToMap(t)

	if t.LeaveSide == "left" then

		for i,v in Party do
			if v.ItemArmor == 0 or v.Items[v.ItemArmor].Number ~= 1406 then
				if not evt[i].Cmp{"Inventory", 1406} then
					if Party.QBits[642] or Party.QBits[643] or Party.QBits[980] then
						Game.ShowStatusText("You must all be wearing your wetsuits!")
					end
					return
				end
			end
		end

		evt.MoveToMap{20096,-16448,2404,1008,0,0,0,8,"7out15.odm"}
	end

end
