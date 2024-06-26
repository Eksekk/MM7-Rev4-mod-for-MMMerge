local TXT = Localize{
	[0] = " ",
	[1] = "Chest ",
	[2] = "Barrel",
	[3] = "Well",
	[4] = "Jump into the Well",
	[5] = "Fountain",
	[6] = "Drink from the Fountain",
	[7] = "House",
	[8] = "The Pirate Ship Revenge",
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
	[25] = "The Grand Temple of the Moon",
	[26] = "The Grand Temple of the Sun",
	[27] = "",
	[28] = "",
	[29] = "",
	[30] = "Enter the Grand Temple of the Moon",
	[31] = "Enter the Grand Temple of the Sun",
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
	[51] = " _vehlgpe",
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
	[70] = "",
	[71] = "",
	[72] = "",
	[73] = "",
	[74] = "",
	[75] = "",
	[76] = "+10 Accuracy and Speed(Permanent)",
}
table.copy(TXT, evt.str, true)

-- REMOVED BY REV4 FOR MERGE
-- Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.hint[1] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(1)
evt.map[1] = function()  -- function events.LoadMap()
	evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
	evt.ForPlayer("All")
	if evt.Cmp("QBits", 2053) then         -- End Game
		evt.SetMonGroupBit{NPCGroup = 60, Bit = const.MonsterBits.Invisible, On = false}         -- "Group for Malwick's Assc."
	end
end

events.LoadMap = evt.map[1].last

Game.MapEvtLines:RemoveEvent(3)
evt.HouseDoor(3, 247)  -- "The Laughing Monk"
evt.house[4] = 247  -- "The Laughing Monk"
Game.MapEvtLines:RemoveEvent(5)
evt.HouseDoor(5, 143)  -- "Paramount Guild of Water"
evt.house[6] = 143  -- "Paramount Guild of Water"
Game.MapEvtLines:RemoveEvent(7)
evt.HouseDoor(7, 489)  -- "Sacred Sails"
evt.house[8] = 489  -- "Sacred Sails"
evt.hint[30] = evt.str[55]  -- "Home Portal"
Game.MapEvtLines:RemoveEvent(30)
evt.map[30] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 1472) then         -- "Home Key"
		evt.MoveToMap{X = -9909, Y = 8614, Z = -1024, Direction = 2047, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "7Out03.Odm"}
	else
		evt.StatusText(22)         -- "You need the Home Key to use this teleporter."
	end
end

evt.hint[51] = evt.str[7]  -- "House"
Game.MapEvtLines:RemoveEvent(52)
evt.HouseDoor(52, 987)  -- "Crane Residence"
Game.MapEvtLines:RemoveEvent(53)
evt.HouseDoor(53, 988)  -- "Smithson Residence"
Game.MapEvtLines:RemoveEvent(54)
evt.HouseDoor(54, 986)  -- "Caverhill Residence"
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

evt.hint[170] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(170)
evt.map[170] = function()
	if not evt.Cmp("QBits", 690) then         -- Open final Obelisk Chest
		evt.OpenChest(0)
		evt.Add("Gold", 100000)
		evt.ForPlayer("All")
		evt.Set("QBits", 690)         -- Open final Obelisk Chest
	end
end

evt.hint[201] = evt.str[3]  -- "Well"
evt.hint[202] = evt.str[25]  -- "The Grand Temple of the Moon"
evt.hint[203] = evt.str[26]  -- "The Grand Temple of the Sun"
evt.hint[204] = evt.str[55]  -- "Home Portal"
evt.hint[205] = evt.str[4]  -- "Jump into the Well"
Game.MapEvtLines:RemoveEvent(205)
evt.map[205] = function()
	evt.MoveToMap{X = 4234, Y = -8993, Z = 384, Direction = 1216, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[206] = evt.str[4]  -- "Jump into the Well"
Game.MapEvtLines:RemoveEvent(206)
evt.map[206] = function()
	evt.MoveToMap{X = -13860, Y = -5350, Z = 256, Direction = 192, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[401] = evt.str[53]  -- "Altar"
Game.MapEvtLines:RemoveEvent(401)
evt.map[401] = function()
	if evt.Cmp("QBits", 561) then         -- "Visit the three stonehenge monoliths in Tatalia, the Evenmorn Islands, and Avlee, then return to Anthony Green in the Tularean Forest."
		if not evt.Cmp("QBits", 562) then         -- Visited all stonehenges
			if not evt.Cmp("QBits", 563) then         -- Visited stonehenge 1 (area 9)
				evt.StatusText(56)         -- ""
				evt.ForPlayer("All")
				evt.Set("QBits", 563)         -- Visited stonehenge 1 (area 9)
				evt.ForPlayer("All")
				evt.Add("QBits", 757)         -- "Congratulations"
				evt.Subtract("QBits", 757)         -- "Congratulations"
				if evt.Cmp("QBits", 564) then         -- Visited stonehenge 2 (area 13)
					if evt.Cmp("QBits", 565) then         -- Visited stonehenge 3 (area 14)
						evt.ForPlayer("All")
						evt.Set("QBits", 562)         -- Visited all stonehenges
					end
				end
				return
			end
		end
	end
	if evt.Cmp("QBits", 758) then         -- Visited The Land of the giants
		evt.MoveToMap{X = 4221, Y = 17840, Z = 769, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "out12.odm"}
	end
end

evt.hint[451] = evt.str[52]  -- "Shrine"
evt.hint[452] = evt.str[53]  -- "Altar"
Game.MapEvtLines:RemoveEvent(452)
evt.map[452] = function()
	if evt.Cmp("PlayerBits", 27) then
		evt.StatusText(54)         -- "You Pray"
	else
		evt.Add("BaseAccuracy", 10)
		evt.Add("BaseSpeed", 10)
		evt.Set("PlayerBits", 27)
		evt.StatusText(76)         -- "+10 Accuracy and Speed(Permanent)"
	end
end

evt.hint[453] = evt.str[50]  -- "Obelisk"
Game.MapEvtLines:RemoveEvent(453)
evt.map[453] = function()
	if not evt.Cmp("QBits", 683) then         -- Visited Obelisk in Area 9
		evt.StatusText(51)         -- " _vehlgpe"
		evt.Add("AutonotesBits", 316)         -- "Obelisk message #8: _vehlgpe"
		evt.ForPlayer("All")
		evt.Add("QBits", 683)         -- Visited Obelisk in Area 9
	end
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

evt.hint[501] = evt.str[30]  -- "Enter the Grand Temple of the Moon"
Game.MapEvtLines:RemoveEvent(501)
evt.map[501] = function()
	evt.MoveToMap{X = 3136, Y = 2053, Z = 1, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 404, Icon = 1, Name = "7D19.blv"}         -- "Grand Temple of the Moon"
end

evt.hint[502] = evt.str[31]  -- "Enter the Grand Temple of the Sun"
Game.MapEvtLines:RemoveEvent(502)
evt.map[502] = function()
	evt.MoveToMap{X = 0, Y = -3179, Z = 161, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 405, Icon = 1, Name = "T03.blv"}         -- "Grand Temple of the Sun"
end



--[[ MMMerge additions ]]--

-- Evenmorn Island

-- Show obelisk treasure
local Treasure
for i,v in Map.Sprites do
	if v.Event == 170 then
		Treasure = v
		break
	end
end

local Av = true
for i = 676, 689 do
	Av = Av and Party.QBits[i]
end

if Av and Treasure then

	local function SetTrViz()
		Treasure.Invisible = Game.Hour ~= 0
	end

	Timer(SetTrViz, const.Hour/2, true)

end

-- Dimension door

evt.map[6] = TownPortalControls.DimDoorEvent

function events.AfterLoadMap()
	Party.QBits[824] = true	-- DDMapBuff

	local function DimDoor()
		if 1500 > math.sqrt((-5121-Party.X)^2 + (98-Party.Y)^2) then
			TownPortalControls.DimDoorEvent()
		end
	end
	Timer(DimDoor, false, const.Minute*3)

end
