local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave the Cave",
	[3] = "Chest",
	[4] = "Button",
	[5] = "Lever",
	[6] = "Vault",
	[7] = "Cabinet",
	[8] = "Switch",
	[9] = "",
	[10] = "Bookcase",
	[11] = "",
	[12] = "Strange Torch",
	[13] = "The exit is sealed!",
	[14] = "You Successfully disarm the trap",
	[15] = "The chest is locked",
	[16] = "Take a Drink",
	[17] = "Not Very Refreshing",
	[18] = "Refreshing",
}
table.copy(TXT, evt.str, true)


Game.MapEvtLines:RemoveEvent(1)
evt.map[1] = function()  -- function events.LoadMap()
	if not evt.Cmp{"QBits", Value = 815} then         -- Reward
		if not evt.Cmp{"QBits", Value = 814} then         -- Small House only Once
			if evt.Cmp{"QBits", Value = 611} then         -- Chose the path of Light
				evt.Set{"QBits", Value = 814}         -- Small House only Once
				evt.SpeakNPC{NPC = 762}         -- "Maximus"
				evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 10, X = 3, Y = 3042, Z = 0, -- ERROR: Not found
NPCGroup = 1536, unk = 0}
				evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 10, X = 718, Y = 2956, Z = 0, -- ERROR: Not found
NPCGroup = 1536, unk = 0}
				evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 10, X = -646, Y = 2889, Z = 0, -- ERROR: Not found
NPCGroup = 1536, unk = 0}
				evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 10, X = 0, Y = 3500, Z = 0, -- ERROR: Not found
NPCGroup = 1536, unk = 0}
				evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 10, X = -31, Y = 1900, Z = 0, -- ERROR: Not found
NPCGroup = 1536, unk = 0}
				evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 10, X = 597, Y = 1900, Z = 0, -- ERROR: Not found
NPCGroup = 1536, unk = 0}
				evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 10, X = -624, Y = 1900, Z = 0, -- ERROR: Not found
NPCGroup = 1536, unk = 0}
			else
				if evt.Cmp{"QBits", Value = 612} then         -- Chose the path of Dark
					evt.Set{"QBits", Value = 814}         -- Small House only Once
					evt.SpeakNPC{NPC = 724}         -- "Sir Carneghem"
					evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 10, X = 3, Y = 3042, Z = 0, -- ERROR: Not found
NPCGroup = 1536, unk = 0}
					evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 10, X = 718, Y = 2956, Z = 0, -- ERROR: Not found
NPCGroup = 1536, unk = 0}
					evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 10, X = -646, Y = 2889, Z = 0, -- ERROR: Not found
NPCGroup = 1536, unk = 0}
					evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 10, X = 0, Y = 3500, Z = 0, -- ERROR: Not found
NPCGroup = 1536, unk = 0}
					evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 10, X = -31, Y = 1900, Z = 0, -- ERROR: Not found
NPCGroup = 1536, unk = 0}
					evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 10, X = 597, Y = 1900, Z = 0, -- ERROR: Not found
NPCGroup = 1536, unk = 0}
					evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 10, X = -624, Y = 1900, Z = 0, -- ERROR: Not found
NPCGroup = 1536, unk = 0}
				end
			end
		end
	end
end

events.LoadMap = evt.map[1].last

Game.MapEvtLines:RemoveEvent(2)
evt.map[2] = function()
	if evt.CheckMonstersKilled{CheckType = 3, Id = 0, Count = 0} then
		evt.Set{"QBits", Value = 630}         -- Killed Good MM3 Person
	else
		if evt.CheckMonstersKilled{CheckType = 3, Id = 1, Count = 0} then
			evt.Set{"QBits", Value = 631}         -- Killed Evil MM3 Person
		end
	end
	evt.Add{"QBits", Value = 746}         -- Control Cube - I lost it
end

evt.hint[5] = evt.str[12]  -- "Strange Torch"
Game.MapEvtLines:RemoveEvent(5)
evt.map[5] = function()
	evt.MoveToMap{X = 0, Y = 0, Z = 0, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "nwc.blv"}
end

evt.hint[176] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(176)
evt.map[176] = function()
	if evt.Cmp{"QBits", Value = 815} then         -- Reward
		evt.OpenChest{Id = 1}
	else
		evt.StatusText{Str = 15}         -- "The chest is locked"
	end
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
	if evt.Cmp{"QBits", Value = 815} then         -- Reward
		evt.OpenChest{Id = 0}
	else
		evt.StatusText{Str = 15}         -- "The chest is locked"
	end
end

Game.MapEvtLines:RemoveEvent(501)
evt.map[501] = function()
	evt.StatusText{Str = 13}         -- "The exit is sealed!"
end

Game.MapEvtLines:RemoveEvent(502)
evt.map[502] = function()
	if not evt.Cmp{"QBits", Value = 879} then         -- 0
		evt.MoveNPC{NPC = 424, HouseId = 1071}         -- "Maximus" -> "Hostel"
		evt.SetNPCTopic{NPC = 424, Index = 0, Event = 0}         -- "Maximus"
		evt.SetNPCTopic{NPC = 424, Index = 1, Event = 878}         -- "Maximus" : "Congratulations!"
		evt.Set{"QBits", Value = 879}         -- 0
	end
	evt.MoveToMap{X = -7745, Y = -6673, Z = 65, Direction = 2047, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "7D26.blv"}
end

