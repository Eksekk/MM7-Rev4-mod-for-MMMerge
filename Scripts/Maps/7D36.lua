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
	[12] = "Ore Vein",
	[13] = "Cave In !",
	[14] = "You Successfully disarm the trap",
	[15] = "",
	[16] = "Take a Drink",
	[17] = "Not Very Refreshing",
	[18] = "Refreshing",
}
table.copy(TXT, evt.str, true)


evt.hint[3] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(3)
evt.map[3] = function()
	evt.SetDoorState{Id = 1, State = 0}
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

evt.hint[196] = evt.str[12]  -- "Ore Vein"
Game.MapEvtLines:RemoveEvent(196)
evt.map[196] = function()
	local i
	if evt.Cmp{"MapVar14", Value = 1} then
		return
	end
	i = Game.Rand() % 6
	if i == 3 then
		evt.Add{"Inventory", Value = 1491}         -- "Kergar-laced ore"
		goto _9
	elseif i == 4 then
		evt.DamagePlayer{-- ERROR: Const not found
Player = "All", DamageType = const.Damage.Fire, Damage = 50}
		evt.StatusText{Str = 13}         -- "Cave In !"
		goto _8
	elseif i == 5 then
		goto _8
	end
	evt.Add{"Inventory", Value = 1490}         -- "Phylt-laced ore"
::_9::
	evt.Set{"MapVar14", Value = 1}
	evt.SetTexture{Facet = 2, Name = "cwb1"}
	do return end
::_8::
	evt.Add{"Inventory", Value = 1492}         -- "Erudine-laced ore"
	goto _9
end

function events.LoadMap()
	if evt.Cmp{"MapVar14", Value = 1} then
		evt.SetTexture{Facet = 2, Name = "cwb1"}
	end
end

evt.hint[197] = evt.str[12]  -- "Ore Vein"
Game.MapEvtLines:RemoveEvent(197)
evt.map[197] = function()
	local i
	if evt.Cmp{"MapVar15", Value = 1} then
		return
	end
	i = Game.Rand() % 6
	if i == 3 then
		evt.Add{"Inventory", Value = 1491}         -- "Kergar-laced ore"
		goto _9
	elseif i == 4 then
		evt.DamagePlayer{-- ERROR: Const not found
Player = "All", DamageType = const.Damage.Fire, Damage = 50}
		evt.StatusText{Str = 13}         -- "Cave In !"
		goto _8
	elseif i == 5 then
		goto _8
	end
	evt.Add{"Inventory", Value = 1490}         -- "Phylt-laced ore"
::_9::
	evt.Set{"MapVar15", Value = 1}
	evt.SetTexture{Facet = 3, Name = "cwb1"}
	do return end
::_8::
	evt.Add{"Inventory", Value = 1492}         -- "Erudine-laced ore"
	goto _9
end

function events.LoadMap()
	if evt.Cmp{"MapVar15", Value = 1} then
		evt.SetTexture{Facet = 3, Name = "cwb1"}
	end
end

evt.hint[198] = evt.str[12]  -- "Ore Vein"
Game.MapEvtLines:RemoveEvent(198)
evt.map[198] = function()
	local i
	if evt.Cmp{"MapVar16", Value = 1} then
		return
	end
	i = Game.Rand() % 6
	if i == 3 then
		evt.Add{"Inventory", Value = 1491}         -- "Kergar-laced ore"
		goto _9
	elseif i == 4 then
		evt.DamagePlayer{-- ERROR: Const not found
Player = "All", DamageType = const.Damage.Fire, Damage = 50}
		evt.StatusText{Str = 13}         -- "Cave In !"
		goto _8
	elseif i == 5 then
		goto _8
	end
	evt.Add{"Inventory", Value = 1490}         -- "Phylt-laced ore"
::_9::
	evt.Set{"MapVar16", Value = 1}
	evt.SetTexture{Facet = 4, Name = "cwb1"}
	do return end
::_8::
	evt.Add{"Inventory", Value = 1492}         -- "Erudine-laced ore"
	goto _9
end

function events.LoadMap()
	if evt.Cmp{"MapVar16", Value = 1} then
		evt.SetTexture{Facet = 4, Name = "cwb1"}
	end
end

Game.MapEvtLines:RemoveEvent(451)
evt.map[451] = function()
	evt.MoveToMap{X = 1664, Y = 6336, Z = 1, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

Game.MapEvtLines:RemoveEvent(452)
evt.map[452] = function()
	evt.MoveToMap{X = 992, Y = 8544, Z = -320, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[501] = evt.str[2]  -- "Leave the Cave"
Game.MapEvtLines:RemoveEvent(501)
evt.map[501] = function()
	evt.MoveToMap{X = 20890, Y = -3119, Z = 1, Direction = 896, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 3, Name = "Out12.odm"}
end

evt.hint[502] = evt.str[2]  -- "Leave the Cave"
Game.MapEvtLines:RemoveEvent(502)
evt.map[502] = function()
	evt.MoveToMap{X = 2324, Y = 7371, Z = 1644, Direction = 1428, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 3, Name = "7D07.blv"}
end



--[[ MMMerge additions ]]--


-- Correct coordinates of travel to Land of giants.
Game.MapEvtLines:RemoveEvent(501)
evt.Map[501] = function()
	evt.MoveToMap{20890, -3119, 5, 896, 0, 0, 0, 3, "out12.odm"}
end
