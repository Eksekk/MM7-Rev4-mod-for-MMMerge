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
	[16] = "Brianna's Brandy",
	[17] = "",
	[18] = "",
	[19] = "",
	[20] = "Door",
	[21] = "This Door is Locked",
	[22] = "You need a town portal pass!",
	[23] = "",
	[24] = "",
	[25] = "Sewer",
	[26] = "Castle Gryphonheart",
	[27] = "Fort Riverstride",
	[28] = "",
	[29] = "",
	[30] = "Enter The Erathian Sewer",
	[31] = "Enter Castle Gryphonheart",
	[32] = "Enter Fort Riverstride",
	[33] = "Enter",
	[34] = "Shops",
	[35] = "Temple",
	[36] = "Guilds",
	[37] = "Stables",
	[38] = "Docks",
	[39] = "Plaza",
	[40] = "Fort Riverstride",
	[41] = "Castle Gryphonheart",
	[42] = "East to Harmondale",
	[43] = "North to Deyja Moors",
	[44] = "West to Tatalia",
	[45] = "South to the Bracada Desert",
	[46] = "City of Steadwick",
	[47] = "",
	[48] = "",
	[49] = "",
	[50] = "Obelisk",
	[51] = "ininhil_",
	[52] = "Shrine",
	[53] = "Altar",
	[54] = "You Pray",
	[55] = "Harmondale Town Portal",
	[56] = "Pierpont Town Portal",
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
	[70] = "+10 Accuracy (Temporary)",
	[71] = "+2 Might (Permanent)",
	[72] = "+20 Body Resistance (Temporary)",
	[73] = "Disease Cured",
	[74] = "+50 Might (Temporary)",
	[75] = "+5 Personality (Temporary)",
	[76] = "+10 Luck(Permanent)",
}
table.copy(TXT, evt.str, true)

-- REMOVED BY REV4 FOR MERGE
-- Game.MapEvtLines.Count = 0  -- Deactivate all standard events

Game.LoadSound(509)
Game.LoadSound(510)
Game.LoadSound(511)
Game.LoadSound(512)
Game.LoadSound(513)

evt.hint[1] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(1)
evt.map[1] = function()  -- function events.LoadMap()
	evt.MoveNPC{NPC = 719, HouseId = 241}         -- "Tony Tunes" -> "Griffin's Rest"
	evt.SetMonGroupBit{NPCGroup = 57, Bit = const.MonsterBits.Hostile, On = true}         -- "Group for M1"
	evt.SetMonGroupBit{NPCGroup = 58, Bit = const.MonsterBits.Hostile, On = true}         -- "Group fo M2"
end

events.LoadMap = evt.map[1].last

Game.MapEvtLines:RemoveEvent(2)
evt.map[2] = function()  -- function events.LeaveMap()
	if not evt.Cmp("QBits", 700) then         -- Killed all Erathian Griffins
		if evt.CheckMonstersKilled{CheckType = 2, Id = 279, Count = 0} then
			if evt.CheckMonstersKilled{CheckType = 2, Id = 280, Count = 0} then
				if evt.CheckMonstersKilled{CheckType = 2, Id = 281, Count = 0} then
					evt.ForPlayer("All")
					evt.Set("QBits", 700)         -- Killed all Erathian Griffins
				end
			end
		end
	end
end

events.LeaveMap = evt.map[2].last

Game.MapEvtLines:RemoveEvent(3)
evt.HouseDoor(3, 49)  -- "Queen Catherine's Smithy"
evt.house[4] = 49  -- "Queen Catherine's Smithy"
Game.MapEvtLines:RemoveEvent(5)
evt.HouseDoor(5, 86)  -- "Her Majesty's Magics"
evt.house[6] = 86  -- "Her Majesty's Magics"
Game.MapEvtLines:RemoveEvent(7)
evt.HouseDoor(7, 118)  -- "Lead Transformations"
evt.house[8] = 118  -- "Lead Transformations"
Game.MapEvtLines:RemoveEvent(9)
evt.HouseDoor(9, 462)  -- "Royal Steeds"
evt.house[10] = 462  -- "Royal Steeds"
Game.MapEvtLines:RemoveEvent(11)
evt.HouseDoor(11, 486)  -- "Lady Catherine"
evt.house[12] = 486  -- "Lady Catherine"
Game.MapEvtLines:RemoveEvent(13)
evt.HouseDoor(13, 312)  -- "House of Solace"
evt.house[14] = 312  -- "House of Solace"
Game.MapEvtLines:RemoveEvent(15)
evt.HouseDoor(15, 1572)  -- "In Her Majesty's Service"
evt.house[16] = 1572  -- "In Her Majesty's Service"
Game.MapEvtLines:RemoveEvent(17)
evt.HouseDoor(17, 204)  -- "Steadwick Townhall"
evt.house[18] = 204  -- "Steadwick Townhall"
Game.MapEvtLines:RemoveEvent(19)
evt.HouseDoor(19, 241)  -- "Griffin's Rest"
evt.house[20] = 241  -- "Griffin's Rest"
Game.MapEvtLines:RemoveEvent(21)
evt.HouseDoor(21, 287)  -- "Bank of Erathia"
evt.house[22] = 287  -- "Bank of Erathia"
Game.MapEvtLines:RemoveEvent(23)
evt.HouseDoor(23, 155)  -- "Paramount Guild of Spirit"
evt.house[24] = 155  -- "Paramount Guild of Spirit"
Game.MapEvtLines:RemoveEvent(25)
evt.HouseDoor(25, 159)  -- "Adept Guild of Mind"
evt.house[26] = 159  -- "Adept Guild of Mind"
Game.MapEvtLines:RemoveEvent(27)
evt.HouseDoor(27, 166)  -- "Master Guild of Body"
evt.house[28] = 166  -- "Master Guild of Body"
Game.MapEvtLines:RemoveEvent(29)
evt.HouseDoor(29, 10)  -- "The Queen's Forge"
evt.house[30] = 10  -- "The Queen's Forge"
evt.hint[32] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(32)
evt.map[32] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	if not evt.CheckSeason(1) then
		evt.MoveNPC{NPC = 1281, HouseId = 0}         -- "EAO the Lector"
	elseif evt.Cmp("QBits", 2033) then         -- 0
		evt.MoveNPC{NPC = 1281, HouseId = 940}         -- "EAO the Lector" -> "Lector's Retreat"
		Game.NPC[1281].Events[0] = 852         -- "EAO the Lector" : "Can you tell us about The Gauntlet?"
	end
end

events.LoadMap = evt.map[32].last

evt.hint[33] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(33)
evt.map[33] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 2050) then         -- Dwarven Messenger Once
		if evt.Cmp("Awards", 120) then         -- "Completed Coding Wizard Quest"
			evt.SetNPCGreeting{NPC = 366, Greeting = 142}         -- "Messenger" : ""
			evt.SpeakNPC(366)         -- "Messenger"
			evt.Set("QBits", 2048)         -- "Raise the siege of Stone City by killing all creatures in the Barrow Downs within one week and then proceed to King Hothffar for your reward."
			evt.Set("QBits", 2050)         -- Dwarven Messenger Once
			evt.Subtract("QBits", 2047)         -- Barrow Normal
			evt.Set("Counter2", 0)
		end
	end
end

events.LoadMap = evt.map[33].last

evt.hint[34] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(34)
evt.map[34] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 2049) then         -- "Obtain Plague Elixir from Lucid Apple in Avlee and deliver it to King Hothffar in Stone City within two days."
		Game.NPC[371].Events[1] = 1173         -- "Myrta Bumblebee" : "Buy Speed Boost Potent"
		evt.SetMonGroupBit{NPCGroup = 66, Bit = const.MonsterBits.Invisible, On = false}         -- "Group walkers in the Tularean forest"
	else
		Game.NPC[371].Events[1] = 0         -- "Myrta Bumblebee"
	end
end

events.LoadMap = evt.map[34].last

evt.hint[35] = evt.str[55]  -- "Harmondale Town Portal"
Game.MapEvtLines:RemoveEvent(35)
evt.map[35] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 1539) then         -- "Town Portal Pass"
		evt.Subtract("Inventory", 1539)         -- "Town Portal Pass"
		evt.MoveToMap{X = -6731, Y = 14045, Z = -512, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "7Out02.Odm"}
	else
		evt.StatusText(22)         -- "You need a town portal pass!"
	end
end

evt.hint[36] = evt.str[56]  -- "Pierpont Town Portal"
Game.MapEvtLines:RemoveEvent(36)
evt.map[36] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 1539) then         -- "Town Portal Pass"
		evt.Subtract("Inventory", 1539)         -- "Town Portal Pass"
		evt.MoveToMap{X = -15148, Y = -10240, Z = 1312, Direction = 40, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "7Out04.odm"}
	else
		evt.StatusText(22)         -- "You need a town portal pass!"
	end
end

evt.hint[37] = evt.str[16]  -- "Brianna's Brandy"
Game.MapEvtLines:RemoveEvent(37)
evt.map[37] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 2010) then         -- 1-time Erathia
		evt.Set("QBits", 2010)         -- 1-time Erathia
		evt.Set("IdentifyItemSkill", 70)
		evt.SetSprite{SpriteId = 16, Visible = 1, Name = "sp57"}
	end
end

evt.hint[38] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(38)
evt.map[38] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	if evt.Cmp("QBits", 2010) then         -- 1-time Erathia
		evt.SetSprite{SpriteId = 16, Visible = 1, Name = "sp57"}
	end
end

events.LoadMap = evt.map[38].last

evt.hint[39] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(39)
evt.map[39] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 2040) then         -- mESSENGER ONE-TIME
		if evt.Cmp("QBits", 719) then         -- Erathia - Town Portal
			evt.SetNPCGreeting{NPC = 412, Greeting = 133}         -- "Messenger" : "Welcome to Emerald Island.  I will be your guide during your stay here.  From time to time I will appear to tell you about something you're about to see to help you understand your New World.  If you tire of my messages (I won't be offended if you do), just click on my portrait to talk to me then click on 'Tour Off' to silence me.  "
			evt.SpeakNPC(412)         -- "Messenger"
			Game.NPC[408].Events[0] = 946         -- "Queen Catherine" : "The Kennel"
			evt.SetNPCGreeting{NPC = 408, Greeting = 134}         -- "Queen Catherine" : "Have you returned with the Journal of Experiments?"
			evt.Set("QBits", 2040)         -- mESSENGER ONE-TIME
		end
	end
end

events.LoadMap = evt.map[39].last

evt.hint[51] = evt.str[7]  -- "House"
Game.MapEvtLines:RemoveEvent(52)
evt.HouseDoor(52, 910)  -- "Guthwulf's Home"
Game.MapEvtLines:RemoveEvent(53)
evt.HouseDoor(53, 911)  -- "Wolverton Residence"
Game.MapEvtLines:RemoveEvent(54)
evt.HouseDoor(54, 912)  -- "House 271"
Game.MapEvtLines:RemoveEvent(55)
evt.HouseDoor(55, 913)  -- "House 272"
Game.MapEvtLines:RemoveEvent(56)
evt.HouseDoor(56, 914)  -- "House 273"
Game.MapEvtLines:RemoveEvent(57)
evt.HouseDoor(57, 915)  -- "Castro's House"
Game.MapEvtLines:RemoveEvent(59)
evt.HouseDoor(59, 916)  -- "Laraselle Residence"
Game.MapEvtLines:RemoveEvent(60)
evt.HouseDoor(60, 917)  -- "Sourbrow Home"
Game.MapEvtLines:RemoveEvent(62)
evt.HouseDoor(62, 919)  -- "Agraynel Residence"
Game.MapEvtLines:RemoveEvent(65)
evt.HouseDoor(65, 920)  -- "House 282"
Game.MapEvtLines:RemoveEvent(66)
evt.HouseDoor(66, 921)  -- "Tish Residence"
Game.MapEvtLines:RemoveEvent(67)
evt.HouseDoor(67, 922)  -- "Talion House"
Game.MapEvtLines:RemoveEvent(68)
evt.HouseDoor(68, 923)  -- "Ravenhill Residence"
Game.MapEvtLines:RemoveEvent(69)
evt.HouseDoor(69, 924)  -- "Cardrin Residence"
Game.MapEvtLines:RemoveEvent(71)
evt.HouseDoor(71, 926)  -- "Gareth's Home"
Game.MapEvtLines:RemoveEvent(72)
evt.HouseDoor(72, 927)  -- "Forgewright Residence"
Game.MapEvtLines:RemoveEvent(73)
evt.HouseDoor(73, 928)  -- "Pretty House"
Game.MapEvtLines:RemoveEvent(74)
evt.HouseDoor(74, 929)  -- "Lotts Familly Home"
Game.MapEvtLines:RemoveEvent(76)
evt.HouseDoor(76, 931)  -- "Julian's Home"
Game.MapEvtLines:RemoveEvent(77)
evt.HouseDoor(77, 932)  -- "Eversmyle Residence"
Game.MapEvtLines:RemoveEvent(78)
evt.HouseDoor(78, 933)  -- "Dirthmoore Residence"
Game.MapEvtLines:RemoveEvent(81)
evt.HouseDoor(81, 936)  -- "Heartsworn Home"
Game.MapEvtLines:RemoveEvent(82)
evt.HouseDoor(82, 937)  -- "Cardron Residence"
Game.MapEvtLines:RemoveEvent(84)
evt.HouseDoor(84, 939)  -- "Thrush Residence"
Game.MapEvtLines:RemoveEvent(85)
evt.HouseDoor(85, 940)  -- "Lector's Retreat"
Game.MapEvtLines:RemoveEvent(86)
evt.HouseDoor(86, 941)  -- "Courier Guild"
Game.MapEvtLines:RemoveEvent(87)
evt.HouseDoor(87, 942)  -- "Org House"
Game.MapEvtLines:RemoveEvent(88)
evt.HouseDoor(88, 943)  -- "Talreish Residence"
Game.MapEvtLines:RemoveEvent(89)
evt.HouseDoor(89, 944)  -- "Temper Summer Home"
Game.MapEvtLines:RemoveEvent(90)
evt.HouseDoor(90, 945)  -- "Havest Residence"
evt.hint[91] = evt.str[9]  -- "Tent"
evt.hint[92] = evt.str[10]  -- "Hut"
Game.MapEvtLines:RemoveEvent(93)
evt.HouseDoor(93, 1128)  -- "Ravenswood Residence"
Game.MapEvtLines:RemoveEvent(94)
evt.HouseDoor(94, 1129)  -- "Blayze's"
Game.MapEvtLines:RemoveEvent(95)
evt.HouseDoor(95, 1130)  -- "Norris' House"
Game.MapEvtLines:RemoveEvent(495)
evt.HouseDoor(495, 1131)  -- "Dreamwright Residence"
Game.MapEvtLines:RemoveEvent(496)
evt.HouseDoor(496, 1132)  -- "Wain Manor"
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

evt.hint[169] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(169)
evt.map[169] = function()
	if evt.Cmp("QBits", 756) then         -- Finished ArcoMage Quest - Get the treasure
		evt.OpenChest(19)
	else
		evt.OpenChest(18)
	end
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

evt.hint[203] = evt.str[4]  -- "Drink from the Well"
Game.MapEvtLines:RemoveEvent(203)
evt.map[203] = function()
	if evt.Cmp("PlayerBits", 3) then
		evt.StatusText(11)         -- "Refreshing!"
		return
	end
	if not evt.Cmp("AutonotesBits", 264) then         -- "2 points of permanent Might from the well in the northwest section of Steadwick."
		evt.Add("AutonotesBits", 264)         -- "2 points of permanent Might from the well in the northwest section of Steadwick."
	end
	evt.Add("BaseMight", 2)
	evt.Add("PlayerBits", 3)
	evt.StatusText(71)         -- "+2 Might (Permanent)"
end

evt.hint[204] = evt.str[4]  -- "Drink from the Well"
Game.MapEvtLines:RemoveEvent(204)
evt.map[204] = function()
	if evt.Cmp("PlayerBits", 5) then
		evt.StatusText(11)         -- "Refreshing!"
		return
	end
	if not evt.Cmp("AutonotesBits", 266) then         -- "20 points of temporary Body Resistance from the well south of the Steadwick Town Hall."
		evt.Add("AutonotesBits", 266)         -- "20 points of temporary Body Resistance from the well south of the Steadwick Town Hall."
	end
	evt.Add("BodyResBonus", 20)
	evt.Add("PlayerBits", 5)
	evt.StatusText(72)         -- "+20 Body Resistance (Temporary)"
end

RefillTimer(function()
	evt.ForPlayer("All")
	evt.Subtract("PlayerBits", 5)
end, const.Day)

evt.hint[205] = evt.str[4]  -- "Drink from the Well"
Game.MapEvtLines:RemoveEvent(205)
evt.map[205] = function()
	if not evt.Cmp("DiseasedGreen", 0) then
		if not evt.Cmp("DiseasedYellow", 0) then
			if not evt.Cmp("DiseasedRed", 0) then
				evt.StatusText(11)         -- "Refreshing!"
				return
			end
		end
	end
	if not evt.Cmp("AutonotesBits", 265) then         -- "Disease cured at the eastern well in Steadwick."
		evt.Add("AutonotesBits", 265)         -- "Disease cured at the eastern well in Steadwick."
	end
	evt.Set("MainCondition", const.Condition.Cursed)
	evt.StatusText(73)         -- "Disease Cured"
end

evt.hint[207] = evt.str[5]  -- "Fountain"
evt.hint[208] = evt.str[6]  -- "Drink from the Fountain"
Game.MapEvtLines:RemoveEvent(208)
evt.map[208] = function()
	if evt.Cmp("PlayerBits", 6) then
		evt.StatusText(11)         -- "Refreshing!"
		return
	end
	if not evt.Cmp("AutonotesBits", 267) then         -- "50 points of temporary Might from the central fountain in Steadwick."
		evt.Add("AutonotesBits", 267)         -- "50 points of temporary Might from the central fountain in Steadwick."
	end
	evt.Add("MightBonus", 50)
	evt.Add("PlayerBits", 6)
	evt.StatusText(74)         -- "+50 Might (Temporary)"
end

RefillTimer(function()
	evt.ForPlayer("All")
	evt.Subtract("PlayerBits", 6)
end, const.Day)

evt.hint[209] = evt.str[4]  -- "Drink from the Well"
Game.MapEvtLines:RemoveEvent(209)
evt.map[209] = function()
	if evt.Cmp("PlayerBits", 4) then
		evt.StatusText(11)         -- "Refreshing!"
		return
	end
	if not evt.Cmp("AutonotesBits", 263) then         -- "10 points of temporary Accuracy from the well in the village northeast of Steadwick."
		evt.Add("AutonotesBits", 263)         -- "10 points of temporary Accuracy from the well in the village northeast of Steadwick."
	end
	evt.Add("AccuracyBonus", 10)
	evt.Add("PlayerBits", 4)
	evt.StatusText(70)         -- "+10 Accuracy (Temporary)"
end

RefillTimer(function()
	evt.ForPlayer("All")
	evt.Subtract("PlayerBits", 4)
end, const.Day)

evt.hint[210] = evt.str[6]  -- "Drink from the Fountain"
Game.MapEvtLines:RemoveEvent(210)
evt.map[210] = function()
	if evt.Cmp("PlayerBits", 7) then
		evt.StatusText(11)         -- "Refreshing!"
		return
	end
	if not evt.Cmp("AutonotesBits", 268) then         -- "5 points of temporary Personality from the trough in front of the Steadwick Town Hall."
		evt.Add("AutonotesBits", 268)         -- "5 points of temporary Personality from the trough in front of the Steadwick Town Hall."
	end
	evt.Add("PersonalityBonus", 5)
	evt.Add("PlayerBits", 7)
	evt.StatusText(75)         -- "+5 Personality (Temporary)"
end

RefillTimer(function()
	evt.ForPlayer("All")
	evt.Subtract("PlayerBits", 7)
end, const.Day)

evt.hint[401] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(401)
evt.map[401] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 541) then         -- "Kill the creatures in the Kennel and return to Queen Catherine with the Journal of Experiments.."
		evt.SetFacetBit{Id = 10, Bit = const.FacetBits.Untouchable, On = true}
		evt.SetFacetBit{Id = 10, Bit = const.FacetBits.Invisible, On = true}
	end
end

events.LoadMap = evt.map[401].last

evt.hint[402] = evt.str[15]  -- "Button"
Game.MapEvtLines:RemoveEvent(402)
evt.map[402] = function()
	evt.Set("MapVar9", 1)
	evt.PlaySound{Id = 509, X = 14328, Y = -21624}
end

evt.hint[403] = evt.str[15]  -- "Button"
Game.MapEvtLines:RemoveEvent(403)
evt.map[403] = function()
	if evt.Cmp("MapVar9", 1) then
		evt.Set("MapVar9", 2)
	else
		evt.Set("MapVar9", 0)
	end
	evt.PlaySound{Id = 510, X = 14328, Y = -21624}
end

evt.hint[404] = evt.str[15]  -- "Button"
Game.MapEvtLines:RemoveEvent(404)
evt.map[404] = function()
	if evt.Cmp("MapVar9", 2) then
		evt.Set("MapVar9", 3)
	else
		evt.Set("MapVar9", 0)
	end
	evt.PlaySound{Id = 511, X = 14328, Y = -21624}
end

evt.hint[405] = evt.str[15]  -- "Button"
Game.MapEvtLines:RemoveEvent(405)
evt.map[405] = function()
	if evt.Cmp("MapVar9", 3) then
		evt.Set("MapVar9", 4)
	else
		evt.Set("MapVar9", 0)
	end
	evt.PlaySound{Id = 512, X = 14328, Y = -21624}
end

evt.hint[406] = evt.str[15]  -- "Button"
Game.MapEvtLines:RemoveEvent(406)
evt.map[406] = function()
	if evt.Cmp("MapVar9", 5) then
		return
	end
	if evt.Cmp("MapVar9", 4) then
		evt.Set("MapVar9", 5)
		evt.ForPlayer("All")
		evt.Set("QBits", 569)         -- Solved the code puzzle.  Ninja promo quest
		evt.SetFacetBit{Id = 16, Bit = const.FacetBits.Untouchable, On = true}
		evt.SetFacetBit{Id = 17, Bit = const.FacetBits.Invisible, On = false}
		evt.SetFacetBit{Id = 16, Bit = const.FacetBits.Invisible, On = true}
		evt.Subtract("QBits", 726)         -- Scroll of Waves - I lost it
		evt.Subtract("QBits", 727)         -- Cipher - I lost it
	else
		evt.Set("MapVar9", 0)
	end
	evt.PlaySound{Id = 513, X = 14328, Y = -21624}
end

evt.hint[451] = evt.str[52]  -- "Shrine"
evt.hint[452] = evt.str[53]  -- "Altar"
Game.MapEvtLines:RemoveEvent(452)
evt.map[452] = function()
	if evt.Cmp("PlayerBits", 24) then
		evt.StatusText(54)         -- "You Pray"
	else
		evt.Add("BaseLuck", 10)
		evt.StatusText(76)         -- "+10 Luck(Permanent)"
		evt.Add("PlayerBits", 24)
	end
end

evt.hint[453] = evt.str[50]  -- "Obelisk"
Game.MapEvtLines:RemoveEvent(453)
evt.map[453] = function()
	if not evt.Cmp("QBits", 677) then         -- Visited Obelisk in Area 3
		evt.StatusText(51)         -- "ininhil_"
		evt.Add("AutonotesBits", 310)         -- "Obelisk message #2: ininhil_"
		evt.ForPlayer("All")
		evt.Add("QBits", 677)         -- Visited Obelisk in Area 3
	end
end

evt.hint[454] = evt.str[38]  -- "Docks"
evt.hint[455] = evt.str[39]  -- "Plaza"
evt.hint[456] = evt.str[41]  -- "Castle Gryphonheart"
evt.hint[457] = evt.str[40]  -- "Fort Riverstride"
evt.hint[458] = evt.str[42]  -- "East to Harmondale"
evt.hint[459] = evt.str[43]  -- "North to Deyja Moors"
evt.hint[460] = evt.str[44]  -- "West to Tatalia"
evt.hint[461] = evt.str[45]  -- "South to the Bracada Desert"
evt.hint[462] = evt.str[46]  -- "City of Steadwick"
evt.hint[463] = evt.str[35]  -- "Temple"
evt.hint[464] = evt.str[36]  -- "Guilds"
evt.hint[465] = evt.str[37]  -- "Stables"
evt.hint[466] = evt.str[25]  -- "Sewer"
evt.hint[500] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(500)
evt.map[500] = function()  -- function events.LoadMap()
	if evt.CheckSeason(2) then
		evt.SetSprite{SpriteId = 5, Visible = 1, Name = "7tree20"}
		evt.SetSprite{SpriteId = 6, Visible = 1, Name = "7tree26"}
		evt.StatusText(62)         -- ""
		goto _23
	end
	if evt.CheckSeason(3) then
		evt.SetSprite{SpriteId = 5, Visible = 1, Name = "7tree21"}
		evt.SetSprite{SpriteId = 6, Visible = 1, Name = "7tree27"}
		evt.StatusText(63)         -- ""
		goto _23
	end
	evt.SetSprite{SpriteId = 5, Visible = 1, Name = "7tree19"}
	evt.SetSprite{SpriteId = 6, Visible = 1, Name = "7tree25"}
	evt.SetSprite{SpriteId = 7, Visible = 1, Name = "7tree28"}
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
	if evt.CheckSeason(1) then
		evt.StatusText(61)         -- "You received an apple"
	elseif evt.CheckSeason(0) then
		evt.StatusText(60)         -- "Fruit Tree"
	else
		evt.StatusText(64)         -- ""
	end
	do return end
::_23::
	evt.SetSprite{SpriteId = 7, Visible = 1, Name = "7tree30"}
	evt.SetSprite{SpriteId = 10, Visible = 0, Name = "0"}
	evt.SetSprite{SpriteId = 51, Visible = 1, Name = "7tree30"}
	evt.SetSprite{SpriteId = 52, Visible = 1, Name = "7tree30"}
	evt.SetSprite{SpriteId = 53, Visible = 1, Name = "7tree30"}
	evt.SetSprite{SpriteId = 54, Visible = 1, Name = "7tree30"}
	evt.SetSprite{SpriteId = 55, Visible = 1, Name = "7tree30"}
	evt.SetSprite{SpriteId = 56, Visible = 1, Name = "7tree30"}
	evt.SetSprite{SpriteId = 57, Visible = 1, Name = "7tree30"}
	evt.SetSprite{SpriteId = 58, Visible = 1, Name = "7tree30"}
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

evt.hint[501] = evt.str[30]  -- "Enter The Erathian Sewer"
Game.MapEvtLines:RemoveEvent(501)
evt.map[501] = function()
	evt.MoveToMap{X = 28, Y = -217, Z = 1, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 392, Icon = 5, Name = "D01.blv"}         -- "Erathian Sewer"
end

evt.hint[502] = evt.str[32]  -- "Enter Fort Riverstride"
Game.MapEvtLines:RemoveEvent(502)
evt.map[502] = function()
	evt.MoveToMap{X = 64, Y = -448, Z = 1, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 393, Icon = 9, Name = "7D31.blv"}         -- "Fort Riverstride"
end

evt.hint[503] = evt.str[31]  -- "Enter Castle Gryphonheart"
Game.MapEvtLines:RemoveEvent(503)
evt.map[503] = function()
	evt.MoveToMap{X = 768, Y = 0, Z = 1, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 383, Icon = 9, Name = "7D33.blv"}         -- "Castle Gryphonheart"
end

evt.hint[504] = evt.str[20]  -- "Door"
Game.MapEvtLines:RemoveEvent(504)
evt.map[504] = function()
	if evt.Cmp("Inventory", 1462) then         -- "Catherine's Key"
		evt.MoveToMap{X = -6314, Y = -618, Z = 1873, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 383, Icon = 9, Name = "7D33.blv"}         -- "Castle Gryphonheart"
	else
		evt.StatusText(21)         -- "This Door is Locked"
		evt.FaceAnimation{Player = "Current", Animation = 18}
	end
end

evt.hint[505] = evt.str[32]  -- "Enter Fort Riverstride"
Game.MapEvtLines:RemoveEvent(505)
evt.map[505] = function()
	evt.MoveToMap{X = -1262, Y = 587, Z = -1215, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 393, Icon = 9, Name = "7D31.blv"}         -- "Fort Riverstride"
end

evt.hint[506] = evt.str[30]  -- "Enter The Erathian Sewer"
Game.MapEvtLines:RemoveEvent(506)
evt.map[506] = function()
	evt.MoveToMap{X = 6647, Y = 3511, Z = -511, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 392, Icon = 5, Name = "D01.blv"}         -- "Erathian Sewer"
end

evt.hint[507] = evt.str[30]  -- "Enter The Erathian Sewer"
Game.MapEvtLines:RemoveEvent(507)
evt.map[507] = function()
	evt.MoveToMap{X = -6507, Y = 10205, Z = -383, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 392, Icon = 5, Name = "D01.blv"}         -- "Erathian Sewer"
end

evt.hint[508] = evt.str[33]  -- "Enter"
Game.MapEvtLines:RemoveEvent(508)
evt.map[508] = function()
	evt.MoveToMap{X = -111, Y = -25, Z = 1, Direction = 640, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 2, Name = "mdt11.blv"}
end

evt.hint[509] = evt.str[33]  -- "Enter"
Game.MapEvtLines:RemoveEvent(509)
evt.map[509] = function()
	evt.MoveToMap{X = -104, Y = 128, Z = 1, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 3, Name = "mdt14.blv"}
end

Game.MapEvtLines:RemoveEvent(510)
evt.map[510] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Gold", 117440712) then
		evt.Add(-- ERROR: Not found
"Inventory", 83886817)
	else
		evt.SetMessage(1063)
	end
end

-- ERROR: Invalid command size: 510:1 (Cmp)
-- ERROR: Invalid command size: 510:4 (Subtract)
-- ERROR: Invalid command size: 510:5 (Add)


--[[ MMMerge additions ]]--

-- Erathia
local MF = Merge.Functions

-- Travel to Emerald Isle if Player was not there before.

if Party.QBits[519] then
	Game.TransportIndex[34][4] = 44
else
	Game.TransportIndex[34][4] = 101
end

-- Give "Scavenger hunt" advertisment

local CCTimers = {}

function events.AfterLoadMap()
	-- Party.QBits[720] = true	-- TP Buff Erathia
	Party.QBits[818] = true	-- DDMapBuff
	if not (mapvars.GotAdvertisment or Party.QBits[519]) then

		CCTimers.Catch = function()
			if not (Party.Flying or Party.EnemyDetectorRed or Party.EnemyDetectorYellow)
				and 4000 > math.sqrt((-10511-Party.X)^2 + (6119-Party.Y)^2) then

				mapvars.GotAdvertisment = true
				RemoveTimer(CCTimers.Catch)
				evt.ForPlayer(0).Add{"Inventory", 774}
				evt.SetNPCGreeting(649, 332)
				evt.SpeakNPC{649}

			end
		end
		Timer(CCTimers.Catch, false, const.Minute*3)

	end
end

-- Town Portal fountain
evt.map[208] = function()
	MF.SetLastFountain()
end