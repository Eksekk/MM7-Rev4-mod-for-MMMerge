local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave the Dwarven Barrow",
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


evt.hint[1] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(1)
evt.map[1] = function()  -- function events.LoadMap()
	if evt.Cmp{"QBits", Value = 704} then         -- Turn on map in mdkXX(Dwarven Barrow)
		evt.SetDoorState{Id = 25, State = 0}
		evt.SetDoorState{Id = 26, State = 0}
	end
	evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
end

events.LoadMap = evt.map[1].last

evt.hint[176] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(176)
evt.map[176] = function()
	evt.OpenChest{Id = 1}
end

evt.hint[177] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(177)
evt.map[177] = function()
	evt.OpenChest{Id = 2}
end

evt.hint[178] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(178)
evt.map[178] = function()
	evt.OpenChest{Id = 3}
end

evt.hint[179] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(179)
evt.map[179] = function()
	evt.OpenChest{Id = 4}
end

evt.hint[180] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(180)
evt.map[180] = function()
	evt.OpenChest{Id = 5}
end

evt.hint[181] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(181)
evt.map[181] = function()
	evt.OpenChest{Id = 6}
end

evt.hint[182] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(182)
evt.map[182] = function()
	evt.OpenChest{Id = 7}
end

evt.hint[183] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(183)
evt.map[183] = function()
	evt.OpenChest{Id = 8}
end

evt.hint[184] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(184)
evt.map[184] = function()
	evt.OpenChest{Id = 9}
end

evt.hint[185] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(185)
evt.map[185] = function()
	evt.OpenChest{Id = 10}
end

evt.hint[186] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(186)
evt.map[186] = function()
	evt.OpenChest{Id = 11}
end

evt.hint[187] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(187)
evt.map[187] = function()
	evt.OpenChest{Id = 12}
end

evt.hint[188] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(188)
evt.map[188] = function()
	evt.OpenChest{Id = 13}
end

evt.hint[189] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(189)
evt.map[189] = function()
	evt.OpenChest{Id = 14}
end

evt.hint[190] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(190)
evt.map[190] = function()
	evt.OpenChest{Id = 15}
end

evt.hint[191] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(191)
evt.map[191] = function()
	evt.OpenChest{Id = 16}
end

evt.hint[192] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(192)
evt.map[192] = function()
	evt.OpenChest{Id = 17}
end

evt.hint[193] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(193)
evt.map[193] = function()
	evt.OpenChest{Id = 18}
end

evt.hint[194] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(194)
evt.map[194] = function()
	evt.OpenChest{Id = 19}
end

evt.hint[195] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(195)
evt.map[195] = function()
	evt.OpenChest{Id = 0}
end

evt.hint[451] = evt.str[5]  -- "Lever"
Game.MapEvtLines:RemoveEvent(451)
evt.map[451] = function()
	if evt.Cmp{"MapVar0", Value = 2} then
		evt.SetDoorState{Id = 20, State = 1}
		evt.Set{"MapVar0", Value = 1}
	else
		evt.SetDoorState{Id = 20, State = 0}
		evt.Set{"MapVar0", Value = 2}
	end
end

evt.hint[452] = evt.str[5]  -- "Lever"
Game.MapEvtLines:RemoveEvent(452)
evt.map[452] = function()
	if evt.Cmp{"MapVar1", Value = 2} then
		evt.SetDoorState{Id = 21, State = 1}
		evt.Set{"MapVar1", Value = 1}
	else
		evt.SetDoorState{Id = 21, State = 0}
		evt.Set{"MapVar1", Value = 2}
	end
end

evt.hint[501] = evt.str[2]  -- "Leave the Dwarven Barrow"
Game.MapEvtLines:RemoveEvent(501)
evt.map[501] = function()
	if evt.Cmp{"MapVar1", Value = 2} then
		evt.MoveToMap{X = 7, Y = 4944, Z = -525, Direction = 256, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "MDK02.blv"}
	else
		evt.MoveToMap{X = 1998, Y = 1975, Z = 0, Direction = 776, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "MDR01.blv"}
	end
end

evt.hint[502] = evt.str[2]  -- "Leave the Dwarven Barrow"
Game.MapEvtLines:RemoveEvent(502)
evt.map[502] = function()
	if evt.Cmp{"MapVar0", Value = 2} then
		evt.MoveToMap{X = 534, Y = -2658, Z = 1, Direction = 1792, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "MDT04.blv"}
	else
		evt.MoveToMap{X = -409, Y = 471, Z = -128, Direction = 1280, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "MDR02.blv"}
	end
end

