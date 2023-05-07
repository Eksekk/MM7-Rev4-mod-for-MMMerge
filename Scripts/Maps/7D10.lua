local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave the Breeding Zone",
	[3] = "Chest",
	[4] = "Button",
	[5] = "Lever",
	[6] = "Vault",
	[7] = "Cabinet",
	[8] = "Switch",
	[9] = "",
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

-- REMOVED BY REV4 FOR MERGE
-- Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.hint[3] = evt.str[4]  -- "Button"
Game.MapEvtLines:RemoveEvent(3)
evt.map[3] = function()
	evt.SetDoorState{Id = 11, State = 2}         -- switch state
	evt.SetDoorState{Id = 14, State = 2}         -- switch state
end

evt.hint[4] = evt.str[4]  -- "Button"
Game.MapEvtLines:RemoveEvent(4)
evt.map[4] = function()
	evt.SetDoorState{Id = 13, State = 2}         -- switch state
	evt.SetDoorState{Id = 15, State = 2}         -- switch state
end

evt.hint[5] = evt.str[4]  -- "Button"
Game.MapEvtLines:RemoveEvent(5)
evt.map[5] = function()
	evt.SetDoorState{Id = 12, State = 2}         -- switch state
	evt.SetDoorState{Id = 16, State = 2}         -- switch state
end

evt.hint[6] = evt.str[16]  -- "Take a Drink"
Game.MapEvtLines:RemoveEvent(6)
evt.map[6] = function()
	evt.SetDoorState{Id = 31, State = 2}         -- switch state
end

evt.hint[7] = evt.str[4]  -- "Button"
Game.MapEvtLines:RemoveEvent(7)
evt.map[7] = function()
	evt.SetDoorState{Id = 32, State = 2}         -- switch state
	evt.SetDoorState{Id = 33, State = 2}         -- switch state
end

evt.hint[8] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(8)
evt.map[8] = function()
	evt.SetDoorState{Id = 40, State = 2}         -- switch state
end

evt.hint[9] = evt.str[4]  -- "Button"
Game.MapEvtLines:RemoveEvent(9)
evt.map[9] = function()
	evt.SetDoorState{Id = 53, State = 2}         -- switch state
	evt.SetDoorState{Id = 50, State = 2}         -- switch state
end

evt.hint[10] = evt.str[4]  -- "Button"
Game.MapEvtLines:RemoveEvent(10)
evt.map[10] = function()
	evt.SetDoorState{Id = 52, State = 2}         -- switch state
	evt.SetDoorState{Id = 51, State = 2}         -- switch state
end

evt.hint[11] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(11)
evt.map[11] = function()
	evt.SetDoorState{Id = 2, State = 2}         -- switch state
end

evt.hint[12] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(12)
evt.map[12] = function()
	evt.SetDoorState{Id = 1, State = 2}         -- switch state
end

evt.hint[176] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(176)
evt.map[176] = function()
	evt.OpenChest(1)
end

evt.hint[177] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(177)
evt.map[177] = function()
	evt.OpenChest(2)
end

evt.hint[178] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(178)
evt.map[178] = function()
	evt.OpenChest(3)
end

evt.hint[179] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(179)
evt.map[179] = function()
	evt.OpenChest(4)
end

evt.hint[180] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(180)
evt.map[180] = function()
	evt.OpenChest(5)
end

evt.hint[181] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(181)
evt.map[181] = function()
	evt.OpenChest(6)
end

evt.hint[182] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(182)
evt.map[182] = function()
	evt.OpenChest(7)
end

evt.hint[183] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(183)
evt.map[183] = function()
	evt.OpenChest(8)
end

evt.hint[184] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(184)
evt.map[184] = function()
	evt.OpenChest(9)
end

evt.hint[185] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(185)
evt.map[185] = function()
	evt.OpenChest(10)
end

evt.hint[186] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(186)
evt.map[186] = function()
	evt.OpenChest(11)
end

evt.hint[187] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(187)
evt.map[187] = function()
	evt.OpenChest(12)
end

evt.hint[188] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(188)
evt.map[188] = function()
	evt.OpenChest(13)
end

evt.hint[189] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(189)
evt.map[189] = function()
	evt.OpenChest(14)
end

evt.hint[190] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(190)
evt.map[190] = function()
	evt.OpenChest(15)
end

evt.hint[191] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(191)
evt.map[191] = function()
	evt.OpenChest(16)
end

evt.hint[192] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(192)
evt.map[192] = function()
	evt.OpenChest(17)
end

evt.hint[193] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(193)
evt.map[193] = function()
	evt.OpenChest(18)
end

evt.hint[195] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(195)
evt.map[195] = function()
	if not evt.Cmp("MapVar0", 1) then
		if evt.Cmp("QBits", 751) then         -- Got the Divine Intervention
			evt.OpenChest(19)
			return
		end
	end
	evt.OpenChest(0)
	evt.Add("QBits", 751)         -- Got the Divine Intervention
	evt.Add("QBits", 738)         -- Book of Divine Intervention - I lost it
	evt.Set("MapVar0", 1)
end

evt.hint[451] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(451)
evt.map[451] = function()
	evt.CastSpell{Spell = 39, Mastery = const.GM, Skill = 7, FromX = -4686, FromY = 3674, FromZ = -447, ToX = -4686, ToY = 1445, ToZ = -447}         -- "Blades"
	evt.CastSpell{Spell = 39, Mastery = const.GM, Skill = 7, FromX = -4686, FromY = 1445, FromZ = -447, ToX = -4686, ToY = 3674, ToZ = -447}         -- "Blades"
end

evt.hint[452] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(452)
evt.map[452] = function()
	evt.CastSpell{Spell = 6, Mastery = const.GM, Skill = 8, FromX = -768, FromY = 2432, FromZ = 257, ToX = 1664, ToY = 2432, ToZ = 257}         -- "Fireball"
end

evt.hint[501] = evt.str[2]  -- "Leave the Breeding Zone"
Game.MapEvtLines:RemoveEvent(501)
evt.map[501] = function()
	evt.MoveToMap{X = -5376, Y = 474, Z = -415, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "7D26.blv"}
end

evt.hint[502] = evt.str[2]  -- "Leave the Breeding Zone"
Game.MapEvtLines:RemoveEvent(502)
evt.map[502] = function()
	evt.Set("QBits", 641)         -- Completed Breeding Pit.
	evt.MoveToMap{X = -5376, Y = 474, Z = -415, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "7D26.blv"}
end

