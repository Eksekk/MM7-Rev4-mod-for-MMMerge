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
	evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Invisible, On = false}         -- "Generic Monster Group for Dungeons"
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

evt.hint[376] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(376)
evt.map[376] = function()  -- Timer(<function>, 3.5*const.Minute)
	if evt.Cmp{"QBits", Value = 534} then         -- "Find the map that shows the location of Sir BunGleau's panoply and return it to the Massenger of the Saints.."
		if not evt.Cmp{"QBits", Value = 535} then         -- Found map when on Crusader quest
			if evt.CheckMonstersKilled{CheckType = 1, Id = 56, Count = 1} then
				evt.ForPlayer(-- ERROR: Const not found
"All")
				evt.Set{"QBits", Value = 535}         -- Found map when on Crusader quest
				evt.SetNPCGreeting{NPC = 356, Greeting = 0}         -- "Sally" : ""
				evt.SpeakNPC{NPC = 356}         -- "Sally"
			end
		end
	end
end

Timer(evt.map[376].last, 3.5*const.Minute)

evt.hint[501] = evt.str[2]  -- "Leave the Cave"
Game.MapEvtLines:RemoveEvent(501)
evt.map[501] = function()
	evt.MoveToMap{X = 12409, Y = 4917, Z = -64, Direction = 1040, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "7Out01.Odm"}
end

