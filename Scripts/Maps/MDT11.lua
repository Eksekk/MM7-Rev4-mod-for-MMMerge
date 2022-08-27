local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave the Hidden tomb",
	[3] = "Chest",
	[4] = "Button",
	[5] = "Lever",
	[6] = "Vault",
	[7] = "Cabinet",
	[8] = "Switch",
	[9] = "Sarcophagus",
	[10] = "Bookcase",
	[11] = "",
	[12] = "",
	[13] = "",
	[14] = "You Successfully disarm the trap",
	[15] = "",
	[16] = "Take a Drink",
	[17] = "Not Very Refreshing",
	[18] = "Refreshing",
}
table.copy(TXT, evt.str, true)



Game.MapEvtLines:RemoveEvent(1)
evt.map[1] = function()  -- function events.LoadMap()
	evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
end

events.LoadMap = evt.map[1].last

evt.hint[176] = evt.str[9]  -- "Sarcophagus"
Game.MapEvtLines:RemoveEvent(176)
evt.map[176] = function()
	evt.OpenChest(1)
end

evt.hint[177] = evt.str[9]  -- "Sarcophagus"
Game.MapEvtLines:RemoveEvent(177)
evt.map[177] = function()
	evt.OpenChest(2)
end

evt.hint[178] = evt.str[9]  -- "Sarcophagus"
Game.MapEvtLines:RemoveEvent(178)
evt.map[178] = function()
	evt.OpenChest(3)
end

evt.hint[179] = evt.str[9]  -- "Sarcophagus"
Game.MapEvtLines:RemoveEvent(179)
evt.map[179] = function()
	evt.OpenChest(4)
end

evt.hint[180] = evt.str[9]  -- "Sarcophagus"
Game.MapEvtLines:RemoveEvent(180)
evt.map[180] = function()
	evt.OpenChest(5)
end

evt.hint[181] = evt.str[9]  -- "Sarcophagus"
Game.MapEvtLines:RemoveEvent(181)
evt.map[181] = function()
	evt.OpenChest(6)
	evt.Add("QBits", 754)         -- Opened chest with shadow mask
end

evt.hint[182] = evt.str[9]  -- "Sarcophagus"
Game.MapEvtLines:RemoveEvent(182)
evt.map[182] = function()
	evt.OpenChest(7)
end

evt.hint[183] = evt.str[9]  -- "Sarcophagus"
Game.MapEvtLines:RemoveEvent(183)
evt.map[183] = function()
	evt.OpenChest(8)
end

evt.hint[184] = evt.str[9]  -- "Sarcophagus"
Game.MapEvtLines:RemoveEvent(184)
evt.map[184] = function()
	evt.OpenChest(9)
end

evt.hint[185] = evt.str[9]  -- "Sarcophagus"
Game.MapEvtLines:RemoveEvent(185)
evt.map[185] = function()
	evt.OpenChest(10)
end

evt.hint[186] = evt.str[9]  -- "Sarcophagus"
Game.MapEvtLines:RemoveEvent(186)
evt.map[186] = function()
	evt.OpenChest(11)
end

evt.hint[187] = evt.str[9]  -- "Sarcophagus"
Game.MapEvtLines:RemoveEvent(187)
evt.map[187] = function()
	evt.OpenChest(12)
end

evt.hint[188] = evt.str[9]  -- "Sarcophagus"
Game.MapEvtLines:RemoveEvent(188)
evt.map[188] = function()
	evt.OpenChest(13)
end

evt.hint[189] = evt.str[9]  -- "Sarcophagus"
Game.MapEvtLines:RemoveEvent(189)
evt.map[189] = function()
	evt.OpenChest(14)
end

evt.hint[190] = evt.str[9]  -- "Sarcophagus"
Game.MapEvtLines:RemoveEvent(190)
evt.map[190] = function()
	evt.OpenChest(15)
end

evt.hint[191] = evt.str[9]  -- "Sarcophagus"
Game.MapEvtLines:RemoveEvent(191)
evt.map[191] = function()
	evt.OpenChest(16)
end

evt.hint[192] = evt.str[9]  -- "Sarcophagus"
Game.MapEvtLines:RemoveEvent(192)
evt.map[192] = function()
	evt.OpenChest(17)
end

evt.hint[193] = evt.str[9]  -- "Sarcophagus"
Game.MapEvtLines:RemoveEvent(193)
evt.map[193] = function()
	evt.OpenChest(18)
end

evt.hint[194] = evt.str[9]  -- "Sarcophagus"
Game.MapEvtLines:RemoveEvent(194)
evt.map[194] = function()
	evt.OpenChest(19)
end

evt.hint[195] = evt.str[9]  -- "Sarcophagus"
Game.MapEvtLines:RemoveEvent(195)
evt.map[195] = function()
	evt.OpenChest(0)
end

evt.hint[501] = evt.str[2]  -- "Leave the Hidden tomb"
Game.MapEvtLines:RemoveEvent(501)
evt.map[501] = function()
	evt.MoveToMap{X = 14207, Y = -21526, Z = 0, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 1, Name = "7out03.odm"}
end

