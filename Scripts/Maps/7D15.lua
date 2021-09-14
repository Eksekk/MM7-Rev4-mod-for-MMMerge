local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave Watchtower 6",
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


Game.MapEvtLines:RemoveEvent(1)
evt.map[1] = function()  -- function events.LoadMap()
	if evt.Cmp{"QBits", Value = 532} then         -- Watchtower 6.  Weight in the appropriate box.  Important for Global event 47 (Spy promotion)
		evt.SetDoorState{Id = 13, State = 1}
		evt.SetDoorState{Id = 12, State = 1}
	end
	evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
end

events.LoadMap = evt.map[1].last

Game.MapEvtLines:RemoveEvent(3)
evt.map[3] = function()
	evt.SetDoorState{Id = 11, State = 0}
end

Game.MapEvtLines:RemoveEvent(4)
evt.map[4] = function()
	evt.SetDoorState{Id = 10, State = 0}
end

Game.MapEvtLines:RemoveEvent(151)
evt.map[151] = function()
	evt.SetDoorState{Id = 1, State = 2}         -- switch state
	evt.SetDoorState{Id = 2, State = 2}         -- switch state
end

Game.MapEvtLines:RemoveEvent(152)
evt.map[152] = function()
	evt.SetDoorState{Id = 5, State = 0}
	evt.SetDoorState{Id = 6, State = 0}
	evt.SetDoorState{Id = 7, State = 0}
	evt.SetDoorState{Id = 8, State = 0}
	evt.SetDoorState{Id = 3, State = 2}         -- switch state
	evt.SetDoorState{Id = 4, State = 2}         -- switch state
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

Game.MapEvtLines:RemoveEvent(376)
evt.map[376] = function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	evt.Set{"QBits", Value = 532}         -- Watchtower 6.  Weight in the appropriate box.  Important for Global event 47 (Spy promotion)
	evt.SetDoorState{Id = 13, State = 1}
	evt.SetDoorState{Id = 12, State = 1}
end

Game.MapEvtLines:RemoveEvent(451)
evt.map[451] = function()
	local i
	i = Game.Rand() % 6
	if i == 1 then
		evt.SetDoorState{Id = 5, State = 2}         -- switch state
		evt.SetDoorState{Id = 9, State = 2}         -- switch state
	elseif i == 2 then
		evt.SetDoorState{Id = 6, State = 2}         -- switch state
		evt.SetDoorState{Id = 9, State = 2}         -- switch state
	elseif i == 3 then
		evt.SetDoorState{Id = 7, State = 2}         -- switch state
		evt.SetDoorState{Id = 9, State = 2}         -- switch state
	elseif i == 4 then
		evt.SetDoorState{Id = 8, State = 2}         -- switch state
		evt.SetDoorState{Id = 9, State = 2}         -- switch state
	elseif i == 5 then
		evt.SetDoorState{Id = 5, State = 0}
		evt.SetDoorState{Id = 9, State = 2}         -- switch state
		evt.SetDoorState{Id = 6, State = 0}
		evt.SetDoorState{Id = 7, State = 0}
		evt.SetDoorState{Id = 8, State = 0}
	else
		evt.SetDoorState{Id = 5, State = 1}
		evt.SetDoorState{Id = 9, State = 2}         -- switch state
	end
	evt.Set{"MapVar1", Value = 1}
	i = Game.Rand() % 6
	if i == 1 or i == 2 then
		return
	elseif i == 3 then
		goto _27
	elseif i == 4 then
		goto _29
	elseif i == 5 then
		goto _31
	end
	evt.CastSpell{Spell = 6, Mastery = const.GM, Skill = 10, FromX = -3584, FromY = 9984, FromZ = 2721, ToX = -376, ToY = 7228, ToZ = 2721}         -- "Fireball"
	if evt.Cmp{"MapVar1", Value = 1} then
		return
	end
::_27::
	evt.CastSpell{Spell = 6, Mastery = const.GM, Skill = 10, FromX = 2560, FromY = 4096, FromZ = 2721, ToX = -376, ToY = 7228, ToZ = 2721}         -- "Fireball"
	if evt.Cmp{"MapVar1", Value = 1} then
		return
	end
::_29::
	evt.CastSpell{Spell = 6, Mastery = const.GM, Skill = 10, FromX = 2816, FromY = 9984, FromZ = 2721, ToX = -376, ToY = 7228, ToZ = 2721}         -- "Fireball"
	if evt.Cmp{"MapVar1", Value = 1} then
		return
	end
::_31::
	evt.CastSpell{Spell = 6, Mastery = const.GM, Skill = 10, FromX = -3584, FromY = 4352, FromZ = 2721, ToX = -376, ToY = 7228, ToZ = 2721}         -- "Fireball"
end

evt.hint[452] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(452)
evt.map[452] = function()
	if not evt.Cmp{"MapVar4", Value = 1} then
		evt.SpeakNPC{NPC = 613}         -- "Guard"
		evt.Set{"MapVar4", Value = 1}
	end
end

evt.hint[453] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(453)
evt.map[453] = function()
	if not evt.Cmp{"MapVar4", Value = 2} then
		evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.Set{"MapVar4", Value = 2}
	end
end

evt.hint[454] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(454)
evt.map[454] = function()
	evt.Set{"MapVar4", Value = 0}
end

evt.hint[455] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(455)
evt.map[455] = function()  -- function events.LoadMap()
	if not evt.Cmp{"MapVar4", Value = 2} then
		if not evt.Cmp{"QBits", Value = 612} then         -- Chose the path of Dark
			return
		end
		evt.Set{"MapVar4", Value = 2}
	end
	evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
end

events.LoadMap = evt.map[455].last

evt.hint[501] = evt.str[2]  -- "Leave Watchtower 6"
Game.MapEvtLines:RemoveEvent(501)
evt.map[501] = function()
	evt.MoveToMap{X = -16449, Y = -18181, Z = 6401, Direction = 1664, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "7Out05.odm"}
end

evt.hint[502] = evt.str[2]  -- "Leave Watchtower 6"
Game.MapEvtLines:RemoveEvent(502)
evt.map[502] = function()
	evt.MoveToMap{X = -20388, Y = -17503, Z = 4193, Direction = 1828, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "7out05.odm"}
end

