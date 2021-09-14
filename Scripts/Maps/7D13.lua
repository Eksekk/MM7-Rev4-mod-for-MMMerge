local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "",
	[3] = "",
	[4] = "Button",
	[5] = "Lever",
	[6] = "Vault",
	[7] = "Cabinet",
	[8] = "Switch",
	[9] = "Pillar",
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
	evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
end

events.LoadMap = evt.map[1].last

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
	evt.SetDoorState{Id = 1, State = 2}         -- switch state
end

evt.hint[6] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(6)
evt.map[6] = function()
	evt.SetDoorState{Id = 2, State = 2}         -- switch state
end

evt.hint[176] = evt.str[3]  -- ""
Game.MapEvtLines:RemoveEvent(176)
evt.map[176] = function()
	evt.OpenChest{Id = 1}
end

evt.hint[177] = evt.str[3]  -- ""
Game.MapEvtLines:RemoveEvent(177)
evt.map[177] = function()
	evt.OpenChest{Id = 2}
end

evt.hint[178] = evt.str[3]  -- ""
Game.MapEvtLines:RemoveEvent(178)
evt.map[178] = function()
	evt.OpenChest{Id = 3}
end

evt.hint[179] = evt.str[3]  -- ""
Game.MapEvtLines:RemoveEvent(179)
evt.map[179] = function()
	evt.OpenChest{Id = 4}
end

evt.hint[180] = evt.str[3]  -- ""
Game.MapEvtLines:RemoveEvent(180)
evt.map[180] = function()
	evt.OpenChest{Id = 5}
end

evt.hint[181] = evt.str[3]  -- ""
Game.MapEvtLines:RemoveEvent(181)
evt.map[181] = function()
	evt.OpenChest{Id = 6}
end

evt.hint[182] = evt.str[3]  -- ""
Game.MapEvtLines:RemoveEvent(182)
evt.map[182] = function()
	evt.OpenChest{Id = 7}
end

evt.hint[183] = evt.str[3]  -- ""
Game.MapEvtLines:RemoveEvent(183)
evt.map[183] = function()
	evt.OpenChest{Id = 8}
end

evt.hint[184] = evt.str[3]  -- ""
Game.MapEvtLines:RemoveEvent(184)
evt.map[184] = function()
	evt.OpenChest{Id = 9}
end

evt.hint[185] = evt.str[3]  -- ""
Game.MapEvtLines:RemoveEvent(185)
evt.map[185] = function()
	evt.OpenChest{Id = 10}
end

evt.hint[186] = evt.str[3]  -- ""
Game.MapEvtLines:RemoveEvent(186)
evt.map[186] = function()
	evt.OpenChest{Id = 11}
end

evt.hint[187] = evt.str[3]  -- ""
Game.MapEvtLines:RemoveEvent(187)
evt.map[187] = function()
	evt.OpenChest{Id = 12}
end

evt.hint[188] = evt.str[3]  -- ""
Game.MapEvtLines:RemoveEvent(188)
evt.map[188] = function()
	evt.OpenChest{Id = 13}
end

evt.hint[189] = evt.str[3]  -- ""
Game.MapEvtLines:RemoveEvent(189)
evt.map[189] = function()
	evt.OpenChest{Id = 14}
end

evt.hint[190] = evt.str[3]  -- ""
Game.MapEvtLines:RemoveEvent(190)
evt.map[190] = function()
	evt.OpenChest{Id = 15}
end

evt.hint[191] = evt.str[3]  -- ""
Game.MapEvtLines:RemoveEvent(191)
evt.map[191] = function()
	evt.OpenChest{Id = 16}
end

evt.hint[192] = evt.str[3]  -- ""
Game.MapEvtLines:RemoveEvent(192)
evt.map[192] = function()
	evt.OpenChest{Id = 17}
end

evt.hint[193] = evt.str[3]  -- ""
Game.MapEvtLines:RemoveEvent(193)
evt.map[193] = function()
	evt.OpenChest{Id = 18}
end

evt.hint[194] = evt.str[3]  -- ""
Game.MapEvtLines:RemoveEvent(194)
evt.map[194] = function()
	evt.OpenChest{Id = 19}
end

evt.hint[195] = evt.str[3]  -- ""
Game.MapEvtLines:RemoveEvent(195)
evt.map[195] = function()
	evt.OpenChest{Id = 0}
end

Game.MapEvtLines:RemoveEvent(376)
evt.map[376] = function()
	if evt.Cmp{"QBits", Value = 539} then         -- "Find the lost meditation spot in the Dwarven Barrows."
		evt.SpeakNPC{NPC = 394}         -- "Bartholomew Hume"
	end
end

Game.MapEvtLines:RemoveEvent(377)
evt.map[377] = function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if not evt.Cmp{"QBits", Value = 577} then         -- Barrow downs.   Returned the bones of the Dwarf King.  Arch Druid promo quest.
		if evt.Cmp{"QBits", Value = 566} then         -- "Retrieve the bones of the Dwarf King from the tunnels between Stone City and Nighon and place them in their proper resting place in the Barrow Downs, then return to Anthony Green in the Tularean Forest."
			if evt.Cmp{"Inventory", Value = 1428} then         -- "Zokarr IV's Skull"
				evt.Subtract{"Inventory", Value = 1428}         -- "Zokarr IV's Skull"
				evt.Set{"QBits", Value = 577}         -- Barrow downs.   Returned the bones of the Dwarf King.  Arch Druid promo quest.
				evt.ForPlayer(-- ERROR: Const not found
"All")
				evt.Add{"QBits", Value = 757}         -- "Congratulations"
				evt.Subtract{"QBits", Value = 757}         -- "Congratulations"
				evt.Subtract{"QBits", Value = 740}         -- Dwarf Bones - I lost it
			end
		end
	end
end

evt.hint[451] = evt.str[9]  -- "Pillar"
Game.MapEvtLines:RemoveEvent(451)
evt.map[451] = function()
	evt.Set{"MapVar0", Value = 1}
end

evt.hint[452] = evt.str[9]  -- "Pillar"
Game.MapEvtLines:RemoveEvent(452)
evt.map[452] = function()
	evt.Set{"MapVar1", Value = 1}
end

evt.hint[453] = evt.str[9]  -- "Pillar"
Game.MapEvtLines:RemoveEvent(453)
evt.map[453] = function()
	evt.Set{"MapVar2", Value = 1}
end

evt.hint[454] = evt.str[9]  -- "Pillar"
Game.MapEvtLines:RemoveEvent(454)
evt.map[454] = function()
	evt.Set{"MapVar3", Value = 1}
end

evt.hint[455] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(455)
evt.map[455] = function()
	evt.SetDoorState{Id = 5, State = 2}         -- switch state
end

Game.MapEvtLines:RemoveEvent(456)
evt.map[456] = function()
	evt.SetDoorState{Id = 7, State = 0}
	evt.SetDoorState{Id = 6, State = 0}
end

evt.hint[501] = evt.str[2]  -- ""
Game.MapEvtLines:RemoveEvent(501)
evt.map[501] = function()
	local i
	i = Game.Rand() % 6
	if i >= 3 and i <= 5 then
		evt.MoveToMap{X = 335, Y = -1064, Z = 1, Direction = 768, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "MDK02.blv"}
	else
		evt.MoveToMap{X = -426, Y = 281, Z = -15, Direction = 1664, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "MDT02.blv"}
	end
end

