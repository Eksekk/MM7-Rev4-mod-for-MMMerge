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
	[16] = "Geppetto’s thermos",
	[17] = "",
	[18] = "",
	[19] = "",
	[20] = "The Gates are Locked",
	[21] = "This Door is Locked",
	[22] = "",
	[23] = "",
	[24] = "",
	[25] = "Stone City",
	[26] = "Dwarven Barrow",
	[27] = "Mansion",
	[28] = "",
	[29] = "",
	[30] = "Enter Stone City",
	[31] = "Enter Dwarven Barrow",
	[32] = "Enter Mansion",
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
	[51] = "ivg_whn_",
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
	[70] = "+25 Fire Resistance (Temporary)",
	[71] = "Paralysis Relieved",
	[72] = "",
	[73] = "",
	[74] = "",
	[75] = "",
	[76] = "+10 Endurance and Might(Permanent)",
}
table.copy(TXT, evt.str, true)

-- REMOVED BY REV4 FOR MERGE
-- Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.hint[1] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(1)
evt.map[1] = function()  -- function events.LoadMap()
	evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
end

events.LoadMap = evt.map[1].last

Game.MapEvtLines:RemoveEvent(3)
evt.HouseDoor(3, 249)  -- "Miner's Only"
evt.house[4] = 249  -- "Miner's Only"
evt.hint[5] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(5)
evt.map[5] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 884) then         -- Barrow Create Monsters Once
		if evt.Cmp("QBits", 881) then         -- "Raise the siege of Stone City by killing all creatures in the Barrow Downs within one week and then proceed to King Hothffar for your reward."
			evt.Set("QBits", 884)         -- Barrow Create Monsters Once
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 10, X = -22146, Y = 5899, Z = 0, -- ERROR: Not found
NPCGroup = 563, unk = 0}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 10, X = -16576, Y = 11844, Z = 0, -- ERROR: Not found
NPCGroup = 563, unk = 0}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 10, X = -1783, Y = 3048, Z = 1760, -- ERROR: Not found
NPCGroup = 563, unk = 0}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 10, X = -3068, Y = 1129, Z = 1760, -- ERROR: Not found
NPCGroup = 563, unk = 0}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 10, X = -4682, Y = 2962, Z = 1760, -- ERROR: Not found
NPCGroup = 563, unk = 0}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 10, X = -21412, Y = -8748, Z = 0, -- ERROR: Not found
NPCGroup = 563, unk = 0}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 10, X = 4213, Y = 17510, Z = 0, -- ERROR: Not found
NPCGroup = 563, unk = 0}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 10, X = 12751, Y = 17073, Z = 0, -- ERROR: Not found
NPCGroup = 563, unk = 0}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 10, X = 16651, Y = 12446, Z = 0, -- ERROR: Not found
NPCGroup = 563, unk = 0}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 10, X = 17875, Y = 6342, Z = 0, -- ERROR: Not found
NPCGroup = 563, unk = 0}
		else
			evt.Set("QBits", 880)         -- Barrow Normal
		end
	end
end

events.LoadMap = evt.map[5].last

evt.hint[10] = evt.str[16]  -- "Geppetto’s thermos"
Game.MapEvtLines:RemoveEvent(10)
evt.map[10] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 833) then         -- Gepetto's Thermos
		evt.Set("QBits", 833)         -- Gepetto's Thermos
		giveFreeSkill(const.Skills.Repair, 7, const.Expert)
	end
end

evt.hint[100] = evt.str[7]  -- "House"
Game.MapEvtLines:RemoveEvent(101)
evt.HouseDoor(101, 1151)  -- "Dallia's Home"
Game.MapEvtLines:RemoveEvent(102)
evt.HouseDoor(102, 1152)  -- "Gemstone Residence"
Game.MapEvtLines:RemoveEvent(103)
evt.HouseDoor(103, 1153)  -- "Feldspar's Home"
Game.MapEvtLines:RemoveEvent(104)
evt.HouseDoor(104, 1154)  -- "Fissure Residence"
Game.MapEvtLines:RemoveEvent(105)
evt.HouseDoor(105, 1155)  -- "Garnet House"
Game.MapEvtLines:RemoveEvent(106)
evt.HouseDoor(106, 1156)  -- "The House of Remedies"
evt.hint[201] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(201)
evt.map[201] = function()
	evt.OpenChest(1)
end

evt.hint[202] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(202)
evt.map[202] = function()
	evt.OpenChest(2)
end

evt.hint[203] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(203)
evt.map[203] = function()
	evt.OpenChest(3)
end

evt.hint[204] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(204)
evt.map[204] = function()
	evt.OpenChest(4)
end

evt.hint[205] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(205)
evt.map[205] = function()
	evt.OpenChest(5)
end

evt.hint[206] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(206)
evt.map[206] = function()
	evt.OpenChest(6)
end

evt.hint[207] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(207)
evt.map[207] = function()
	evt.OpenChest(7)
end

evt.hint[208] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(208)
evt.map[208] = function()
	evt.OpenChest(8)
	evt.MoveToMap{X = 3072, Y = -416, Z = 0, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[209] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(209)
evt.map[209] = function()
	evt.OpenChest(9)
end

evt.hint[210] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(210)
evt.map[210] = function()
	evt.OpenChest(10)
end

evt.hint[211] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(211)
evt.map[211] = function()
	evt.OpenChest(11)
end

evt.hint[212] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(212)
evt.map[212] = function()
	evt.OpenChest(12)
end

evt.hint[213] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(213)
evt.map[213] = function()
	evt.OpenChest(13)
end

evt.hint[214] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(214)
evt.map[214] = function()
	evt.OpenChest(14)
end

evt.hint[215] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(215)
evt.map[215] = function()
	evt.OpenChest(15)
end

evt.hint[216] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(216)
evt.map[216] = function()
	evt.OpenChest(16)
end

evt.hint[217] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(217)
evt.map[217] = function()
	evt.OpenChest(17)
end

evt.hint[218] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(218)
evt.map[218] = function()
	evt.OpenChest(18)
end

evt.hint[219] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(219)
evt.map[219] = function()
	evt.OpenChest(19)
end

evt.hint[220] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(220)
evt.map[220] = function()
	evt.OpenChest(0)
	if not evt.Cmp("QBits", 578) then         -- Placed Golem torso
		if not evt.Cmp("QBits", 737) then         -- Torso - I lost it
			evt.Add("QBits", 737)         -- Torso - I lost it
		end
	end
end

evt.hint[317] = evt.str[25]  -- "Stone City"
evt.hint[318] = evt.str[26]  -- "Dwarven Barrow"
evt.hint[319] = evt.str[27]  -- "Mansion"
evt.hint[320] = evt.str[3]  -- "Well"
evt.hint[321] = evt.str[4]  -- "Drink from the Well"
Game.MapEvtLines:RemoveEvent(321)
evt.map[321] = function()
	if evt.Cmp("PlayerBits", 18) then
		evt.StatusText(11)         -- "Refreshing!"
		return
	end
	if not evt.Cmp("AutonotesBits", 282) then         -- "25 points of temporary Fire resistance from the well in the southwestern village in the Barrow Downs."
		evt.Add("AutonotesBits", 282)         -- "25 points of temporary Fire resistance from the well in the southwestern village in the Barrow Downs."
	end
	evt.Add("FireResBonus", 25)
	evt.Add("PlayerBits", 18)
	evt.StatusText(70)         -- "+25 Fire Resistance (Temporary)"
end

RefillTimer(function()
	evt.ForPlayer("All")
	evt.Subtract("PlayerBits", 18)
end, const.Day)

evt.hint[322] = evt.str[4]  -- "Drink from the Well"
Game.MapEvtLines:RemoveEvent(322)
evt.map[322] = function()
	if evt.Cmp("Paralysed", 0) then
		evt.Set("MainCondition", const.Condition.Cursed)
		evt.StatusText(71)         -- "Paralysis Relieved"
	else
		evt.StatusText(11)         -- "Refreshing!"
	end
end

evt.hint[451] = evt.str[52]  -- "Shrine"
evt.hint[452] = evt.str[53]  -- "Altar"
Game.MapEvtLines:RemoveEvent(452)
evt.map[452] = function()
	if evt.Cmp("PlayerBits", 29) then
		evt.StatusText(54)         -- "You Pray"
	else
		evt.Add("BaseEndurance", 10)
		evt.Add("BaseMight", 10)
		evt.Add("PlayerBits", 29)
		evt.StatusText(76)         -- "+10 Endurance and Might(Permanent)"
	end
end

evt.hint[453] = evt.str[50]  -- "Obelisk"
Game.MapEvtLines:RemoveEvent(453)
evt.map[453] = function()
	if not evt.Cmp("QBits", 685) then         -- Visited Obelisk in Area 11
		evt.StatusText(51)         -- "ivg_whn_"
		evt.Add("AutonotesBits", 318)         -- "Obelisk message #10: ivg_whn_"
		evt.ForPlayer("All")
		evt.Add("QBits", 685)         -- Visited Obelisk in Area 11
	end
end

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

evt.hint[501] = evt.str[30]  -- "Enter Stone City"
Game.MapEvtLines:RemoveEvent(501)
evt.map[501] = function()
	evt.ForPlayer("All")
	if evt.Cmp("QBits", 880) then         -- Barrow Normal
		goto _5
	end
	if evt.Cmp("Counter2", 180) then
		goto _18
	end
	if evt.Cmp("QBits", 882) then         -- "Obtain Plague Elixir from Lucid Apple in Avlee and deliver it to King Hothffar in Stone City within two days."
		if evt.Cmp("Counter2", 304) then
			goto _18
		end
		if evt.Cmp("Inventory", 1075) then         -- "Plague Elixir"
			goto _5
		end
	elseif not evt.Cmp("QBits", 881) then         -- "Raise the siege of Stone City by killing all creatures in the Barrow Downs within one week and then proceed to King Hothffar for your reward."
		goto _5
	elseif evt.CheckMonstersKilled{CheckType = 1, Id = 56, Count = 0} then
		evt.SetNPCGreeting{NPC = 398, Greeting = 143}         -- "Hothfarr IX" : "Have you brought a cure yet?"
		evt.Set("QBits", 882)         -- "Obtain Plague Elixir from Lucid Apple in Avlee and deliver it to King Hothffar in Stone City within two days."
		evt.Subtract("QBits", 881)         -- "Raise the siege of Stone City by killing all creatures in the Barrow Downs within one week and then proceed to King Hothffar for your reward."
		evt.ForPlayer("All")
		evt.Set("Counter2", 0)
		evt.SpeakNPC(398)         -- "Hothfarr IX"
		return
	end
	evt.StatusText(20)         -- "The Gates are Locked"
	do return end
::_5::
	evt.MoveToMap{X = 256, Y = -4992, Z = 33, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 408, Icon = 2, Name = "7D24.blv"}         -- "Stone City"
	do return end
::_18::
	evt.Set("Awards", 124)         -- "Inducted into the Erathian Hall of Shame!
	evt.SpeakNPC(369)         -- "Doom Bearer
end

evt.hint[502] = evt.str[32]  -- "Enter Mansion"
Game.MapEvtLines:RemoveEvent(502)
evt.map[502] = function()
	evt.MoveToMap{X = 2, Y = -1096, Z = -31, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 9, Name = "7D37.blv"}
end

evt.hint[503] = evt.str[31]  -- "Enter Dwarven Barrow"
Game.MapEvtLines:RemoveEvent(503)
evt.map[503] = function()
	evt.MoveToMap{X = 7, Y = 4944, Z = -525, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "MDK02.blv"}
end

evt.hint[504] = evt.str[31]  -- "Enter Dwarven Barrow"
Game.MapEvtLines:RemoveEvent(504)
evt.map[504] = function()
	evt.MoveToMap{X = -21, Y = -2122, Z = 0, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "MDT02.blv"}
end

evt.hint[505] = evt.str[31]  -- "Enter Dwarven Barrow"
Game.MapEvtLines:RemoveEvent(505)
evt.map[505] = function()
	evt.MoveToMap{X = -1045, Y = 1249, Z = 0, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "MDK03.blv"}
end

--[[ MMMerge additions ]]--

-- The Barrow Downs

function events.AfterLoadMap()
	Party.QBits[946] = true	-- DDMapBuff, changed for rev4 for merge
end

