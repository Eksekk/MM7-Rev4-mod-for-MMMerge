local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave the Temple of Baa",
	[3] = "Chest",
	[4] = "Button",
	[5] = "Lever",
	[6] = "Vault",
	[7] = "Cabinet",
	[8] = "Switch",
	[9] = "Lift",
	[10] = "Bookcase",
	[11] = "",
	[12] = "",
	[13] = "Cleric's Totem",
	[14] = "You Successfully disarm the trap",
	[15] = "Cleric's Totem",
	[16] = "Take a Drink",
	[17] = "Not Very Refreshing",
	[18] = "Refreshing",
}
table.copy(TXT, evt.str, true)

-- ERROR: Duplicate label: 4357:0

evt.hint[1] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(1)
evt.map[1] = function()  -- function events.LoadMap()
	evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
end

events.LoadMap = evt.map[1].last

evt.hint[2] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(2)
evt.map[2] = function()  -- function events.LeaveMap()
	if evt.CheckMonstersKilled{CheckType = 3, Id = 34, Count = 1} then
		evt.Set{"QBits", Value = 755}         -- Killed High Preist of Baa
	end
end

events.LeaveMap = evt.map[2].last

evt.hint[3] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(3)
evt.map[3] = function()
	evt.SetDoorState{Id = 3, State = 2}         -- switch state
end

evt.hint[4] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(4)
evt.map[4] = function()
	evt.SetDoorState{Id = 4, State = 2}         -- switch state
end

evt.hint[5] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(5)
evt.map[5] = function()
	evt.SetDoorState{Id = 5, State = 2}         -- switch state
end

evt.hint[6] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(6)
evt.map[6] = function()
	evt.SetDoorState{Id = 6, State = 2}         -- switch state
end

evt.hint[7] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(7)
evt.map[7] = function()
	evt.SetDoorState{Id = 7, State = 2}         -- switch state
end

evt.hint[8] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(8)
evt.map[8] = function()
	evt.SetDoorState{Id = 8, State = 2}         -- switch state
end

evt.hint[9] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(9)
evt.map[9] = function()
	evt.SetDoorState{Id = 9, State = 2}         -- switch state
end

evt.hint[10] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(10)
evt.map[10] = function()
	evt.SetDoorState{Id = 2, State = 2}         -- switch state
	evt.SetDoorState{Id = 13, State = 2}         -- switch state
end

evt.hint[11] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(11)
evt.map[11] = function()
	evt.SetDoorState{Id = 10, State = 2}         -- switch state
	evt.SetDoorState{Id = 12, State = 2}         -- switch state
end

evt.hint[12] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(12)
evt.map[12] = function()
	evt.SetDoorState{Id = 11, State = 2}         -- switch state
	evt.SetDoorState{Id = 14, State = 2}         -- switch state
end

evt.hint[15] = evt.str[13]  -- "Cleric's Totem"
Game.MapEvtLines:RemoveEvent(15)
evt.map[15] = function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if not evt.Cmp{"QBits", Value = 844} then         -- 1-time baa
		evt.Set{"QBits", Value = 844}         -- 1-time baa
		evt.Add{"MindResistance", Value = 20}
		evt.Add{"BodyResistance", Value = 20}
		evt.Add{53, Value = 20}
		evt.SetSprite{SpriteId = 13, Visible = 1, Name = "torch07"}
	end
end

-- ERROR: Invalid command size: 3845:0 (OpenChest)
Game.MapEvtLines:RemoveEvent(3845)
evt.map[3845] = function()
	evt.OpenChest{Id = 1}
end

evt.hint[16] = evt.str[15]  -- "Cleric's Totem"
Game.MapEvtLines:RemoveEvent(16)
evt.map[16] = function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if not evt.Cmp{"QBits", Value = 845} then         -- 1-time baa
		evt.Set{"QBits", Value = 845}         -- 1-time baa
		evt.Add{"MindResistance", Value = 20}
		evt.Add{"BodyResistance", Value = 20}
		evt.Add{53, Value = 20}
		evt.SetSprite{SpriteId = 15, Visible = 1, Name = "torch07"}
	end
	evt.Add{1280, Value = 67108881}
end

-- ERROR: Invalid command size: 4101:0 (OpenChest)
Game.MapEvtLines:RemoveEvent(4101)
evt.map[4101] = function()
	evt.OpenChest{Id = 16}
end

-- ERROR: Invalid command size: 16:7 (Add)
evt.hint[17] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(17)
evt.map[17] = function()  -- function events.LoadMap()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if evt.Cmp{"QBits", Value = 844} then         -- 1-time baa
		evt.SetSprite{SpriteId = 13, Visible = 1, Name = "torch07"}
	end
	if evt.Cmp{"QBits", Value = 845} then         -- 1-time baa
		evt.SetSprite{SpriteId = 15, Visible = 1, Name = "torch07"}
	end
end

events.LoadMap = evt.map[17].last

-- ERROR: Invalid command size: 4357:0 (MoveToMap)
Game.MapEvtLines:RemoveEvent(4357)
evt.map[4357] = function()
	evt.MoveToMap{X = 286262052, Y = 252512000, Z = 16777216, Direction = 1668444020, LookAngle = 3616872, SpeedZ = 134222085, HouseId = 1, Icon = 0, Name = "\5—"}         -- "The Knight's Blade"
end

-- ERROR: Invalid command size: 4357:0 (FaceExpression)
evt.hint[151] = evt.str[9]  -- "Lift"
Game.MapEvtLines:RemoveEvent(151)
evt.map[151] = function()
	evt.SetDoorState{Id = 1, State = 2}         -- switch state
end

evt.hint[176] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(176)
evt.map[176] = function()
	evt.OpenChest{Id = 1}
end

evt.hint[177] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(177)
evt.map[177] = function()
	evt.OpenChest{Id = 2}
end

evt.hint[178] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(178)
evt.map[178] = function()
	evt.OpenChest{Id = 3}
end

evt.hint[179] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(179)
evt.map[179] = function()
	evt.OpenChest{Id = 4}
end

evt.hint[180] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(180)
evt.map[180] = function()
	evt.OpenChest{Id = 5}
end

evt.hint[181] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(181)
evt.map[181] = function()
	evt.OpenChest{Id = 6}
end

evt.hint[182] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(182)
evt.map[182] = function()
	evt.OpenChest{Id = 7}
end

evt.hint[183] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(183)
evt.map[183] = function()
	evt.OpenChest{Id = 8}
end

evt.hint[184] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(184)
evt.map[184] = function()
	evt.OpenChest{Id = 9}
end

evt.hint[185] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(185)
evt.map[185] = function()
	evt.OpenChest{Id = 10}
end

evt.hint[186] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(186)
evt.map[186] = function()
	evt.OpenChest{Id = 11}
end

evt.hint[187] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(187)
evt.map[187] = function()
	evt.OpenChest{Id = 12}
end

evt.hint[188] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(188)
evt.map[188] = function()
	evt.OpenChest{Id = 13}
end

evt.hint[189] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(189)
evt.map[189] = function()
	evt.OpenChest{Id = 14}
end

evt.hint[190] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(190)
evt.map[190] = function()
	evt.OpenChest{Id = 15}
end

evt.hint[191] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(191)
evt.map[191] = function()
	evt.OpenChest{Id = 16}
end

evt.hint[192] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(192)
evt.map[192] = function()
	evt.OpenChest{Id = 17}
end

evt.hint[193] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(193)
evt.map[193] = function()
	evt.OpenChest{Id = 18}
end

evt.hint[194] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(194)
evt.map[194] = function()
	evt.OpenChest{Id = 19}
end

evt.hint[195] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(195)
evt.map[195] = function()
	evt.OpenChest{Id = 0}
end

Game.MapEvtLines:RemoveEvent(501)
evt.map[501] = function()
	evt.MoveToMap{X = -9306, Y = -19451, Z = 3361, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "Out14.odm"}
end

