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
	[9] = "",
	[10] = "",
	[11] = "Refreshing!",
	[12] = "Boat",
	[13] = "Dock",
	[14] = "",
	[15] = "Button",
	[16] = "",
	[17] = "",
	[18] = "",
	[19] = "",
	[20] = "",
	[21] = "",
	[22] = "",
	[23] = "",
	[24] = "",
	[25] = "The Lincoln",
	[26] = "",
	[27] = "",
	[28] = "",
	[29] = "",
	[30] = "Enter the Lincoln",
	[31] = "",
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
	[51] = "Nothing Seems to have happened",
	[52] = "Shrine",
	[53] = "Altar",
	[54] = "You Pray",
}
table.copy(TXT, evt.str, true)


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

evt.hint[451] = evt.str[52]  -- "Shrine"
evt.hint[452] = evt.str[53]  -- "Altar"
Game.MapEvtLines:RemoveEvent(452)
evt.map[452] = function()
	evt.StatusText{Str = 54}         -- "You Pray"
end

evt.hint[453] = evt.str[50]  -- "Obelisk"
Game.MapEvtLines:RemoveEvent(453)
evt.map[453] = function()
	evt.StatusText{Str = 51}         -- "Nothing Seems to have happened"
end

evt.hint[501] = evt.str[30]  -- "Enter the Lincoln"
Game.MapEvtLines:RemoveEvent(501)
evt.map[501] = function()
	evt.MoveToMap{X = 524, Y = 1463, Z = 225, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 416, Icon = 9, Name = "7D23.blv"}         -- "The Lincoln"
end



--[[ MMMerge additions ]]--


function events.LoadMap()
	for i,v in Party do
		SetCharFace(i, 30)
	end
end

function events.LeaveMap()
	for i,v in Party do
		SetCharFace(i, v.Face)
	end
end

function events.Action(t)
	if t.Action == 133 or Mouse.Item.Number == 1406 and not (t.Action == 120 or t.Action == 12) or t.Action == 105 then
		t.Handled = true
		evt.PlaySound{27}
		Game.ShowStatusText(Game.GlobalTxt[652])
	end
end

local LastAt = true
function events.Tick()
	if Party.Z > 3900 then
		if LastAt and Game.CurrentScreen == 0 then
			LastAt = false
			evt.MoveToMap{-18584, -16562, 1, 290, 0, 0, 0, 8, "out14.odm"}
		end
	else
		LastAt = true
	end
end
