local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave the Haunted Mansion",
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
	[15] = "Portrait",
	[16] = "Take a Drink",
	[17] = "Not Very Refreshing",
	[18] = "Refreshing",
	[19] = "There are no items that interest you",
}
table.copy(TXT, evt.str, true)


evt.hint[1] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(1)
evt.map[1] = function()  -- function events.LoadMap()
	evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
end

events.LoadMap = evt.map[1].last

Game.MapEvtLines:RemoveEvent(2)
evt.map[2] = function()  -- function events.LeaveMap()
	if evt.CheckMonstersKilled{CheckType = 0, Id = 0, Count = 0} then
		evt.ForPlayer(-- ERROR: Const not found
"All")
		evt.Set{"QBits", Value = 652}         -- Cleaned out the haunted mansion (Cavalier promo)
	end
end

events.LeaveMap = evt.map[2].last

evt.hint[3] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(3)
evt.map[3] = function()
	evt.SetDoorState{Id = 1, State = 0}
	evt.SetDoorState{Id = 2, State = 0}
end

evt.hint[4] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(4)
evt.map[4] = function()
	evt.SetDoorState{Id = 3, State = 0}
	evt.SetDoorState{Id = 4, State = 0}
end

evt.hint[5] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(5)
evt.map[5] = function()
	evt.SetDoorState{Id = 5, State = 0}
	evt.SetDoorState{Id = 6, State = 0}
end

evt.hint[6] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(6)
evt.map[6] = function()
	evt.SetDoorState{Id = 7, State = 0}
	evt.SetDoorState{Id = 8, State = 0}
end

evt.hint[7] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(7)
evt.map[7] = function()
	evt.SetDoorState{Id = 9, State = 0}
	evt.SetDoorState{Id = 10, State = 0}
end

evt.hint[8] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(8)
evt.map[8] = function()
	evt.SetDoorState{Id = 11, State = 0}
	evt.SetDoorState{Id = 12, State = 0}
end

evt.hint[9] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(9)
evt.map[9] = function()
	evt.SetDoorState{Id = 13, State = 0}
	evt.SetDoorState{Id = 14, State = 0}
end

evt.hint[10] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(10)
evt.map[10] = function()
	evt.SetDoorState{Id = 15, State = 0}
	evt.SetDoorState{Id = 16, State = 1}
end

evt.hint[12] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(12)
evt.map[12] = function()
	evt.SetDoorState{Id = 17, State = 1}
	evt.SetDoorState{Id = 18, State = 0}
end

evt.hint[13] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(13)
evt.map[13] = function()
	evt.SetDoorState{Id = 19, State = 0}
end

evt.hint[14] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(14)
evt.map[14] = function()
	evt.SetDoorState{Id = 20, State = 0}
end

evt.hint[15] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(15)
evt.map[15] = function()
	evt.SetDoorState{Id = 21, State = 0}
	evt.SetDoorState{Id = 22, State = 1}
end

evt.hint[16] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(16)
evt.map[16] = function()
	evt.SetDoorState{Id = 23, State = 2}         -- switch state
	evt.CastSpell{Spell = 2, Mastery = const.Master, Skill = 20, FromX = 0, FromY = 3488, FromZ = 576, ToX = 0, ToY = 2588, ToZ = 576}         -- "Fire Bolt"
end

evt.hint[177] = evt.str[7]  -- "Cabinet"
Game.MapEvtLines:RemoveEvent(177)
evt.map[177] = function()
	evt.OpenChest{Id = 1}
end

evt.hint[178] = evt.str[7]  -- "Cabinet"
Game.MapEvtLines:RemoveEvent(178)
evt.map[178] = function()
	evt.OpenChest{Id = 2}
end

evt.hint[179] = evt.str[7]  -- "Cabinet"
Game.MapEvtLines:RemoveEvent(179)
evt.map[179] = function()
	evt.OpenChest{Id = 3}
end

evt.hint[180] = evt.str[7]  -- "Cabinet"
Game.MapEvtLines:RemoveEvent(180)
evt.map[180] = function()
	evt.OpenChest{Id = 4}
end

evt.hint[181] = evt.str[7]  -- "Cabinet"
Game.MapEvtLines:RemoveEvent(181)
evt.map[181] = function()
	evt.OpenChest{Id = 5}
end

evt.hint[182] = evt.str[7]  -- "Cabinet"
Game.MapEvtLines:RemoveEvent(182)
evt.map[182] = function()
	evt.OpenChest{Id = 6}
end

evt.hint[183] = evt.str[7]  -- "Cabinet"
Game.MapEvtLines:RemoveEvent(183)
evt.map[183] = function()
	evt.OpenChest{Id = 7}
end

evt.hint[184] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(184)
evt.map[184] = function()
	evt.OpenChest{Id = 8}
end

evt.hint[185] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(185)
evt.map[185] = function()
	evt.OpenChest{Id = 9}
end

evt.hint[186] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(186)
evt.map[186] = function()
	evt.OpenChest{Id = 10}
end

evt.hint[187] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(187)
evt.map[187] = function()
	evt.OpenChest{Id = 11}
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

evt.hint[196] = evt.str[10]  -- "Bookcase"
Game.MapEvtLines:RemoveEvent(196)
evt.map[196] = function()
	local i
	if evt.Cmp{"MapVar49", Value = 1} then
		return
	end
	i = Game.Rand() % 6
	if i == 3 then
		return
	elseif i == 4 then
		i = Game.Rand() % 6
		if i == 1 then
			evt.Add{"Inventory", Value = 1203}         -- "Fire Bolt"
		elseif i == 2 then
			evt.Add{"Inventory", Value = 1214}         -- "Feather Fall"
		elseif i == 3 then
			evt.Add{"Inventory", Value = 1216}         -- "Sparks"
		elseif i == 4 then
			evt.Add{"Inventory", Value = 1281}         -- "Dispel Magic"
		elseif i == 5 then
			evt.Add{"Inventory", Value = 1269}         -- "Heal"
		end
		goto _14
	elseif i == 5 then
		goto _15
	end
	evt.GiveItem{Strength = 5, Type = const.ItemType.Scroll_, Id = 0}
::_14::
	i = Game.Rand() % 6
	if i == 4 or i == 5 then
		return
	end
::_15::
	evt.Add{"MapVar49", Value = 1}
end

evt.hint[197] = evt.str[10]  -- "Bookcase"
Game.MapEvtLines:RemoveEvent(197)
evt.map[197] = function()
	local i
	if evt.Cmp{"MapVar50", Value = 1} then
		return
	end
	i = Game.Rand() % 6
	if i == 3 then
		return
	elseif i == 4 then
		i = Game.Rand() % 6
		if i == 1 then
			evt.Add{"Inventory", Value = 1203}         -- "Fire Bolt"
		elseif i == 2 then
			evt.Add{"Inventory", Value = 1214}         -- "Feather Fall"
		elseif i == 3 then
			evt.Add{"Inventory", Value = 1216}         -- "Sparks"
		elseif i == 4 then
			evt.Add{"Inventory", Value = 1281}         -- "Dispel Magic"
		elseif i == 5 then
			evt.Add{"Inventory", Value = 1269}         -- "Heal"
		end
		goto _14
	elseif i == 5 then
		goto _15
	end
	evt.GiveItem{Strength = 5, Type = const.ItemType.Scroll_, Id = 0}
::_14::
	i = Game.Rand() % 6
	if i == 4 or i == 5 then
		return
	end
::_15::
	evt.Add{"MapVar50", Value = 1}
end

evt.hint[198] = evt.str[10]  -- "Bookcase"
Game.MapEvtLines:RemoveEvent(198)
evt.map[198] = function()
	local i
	if evt.Cmp{"MapVar51", Value = 1} then
		return
	end
	i = Game.Rand() % 6
	if i == 3 then
		return
	elseif i == 4 then
		i = Game.Rand() % 6
		if i == 1 then
			evt.Add{"Inventory", Value = 1203}         -- "Fire Bolt"
		elseif i == 2 then
			evt.Add{"Inventory", Value = 1214}         -- "Feather Fall"
		elseif i == 3 then
			evt.Add{"Inventory", Value = 1216}         -- "Sparks"
		elseif i == 4 then
			evt.Add{"Inventory", Value = 1281}         -- "Dispel Magic"
		elseif i == 5 then
			evt.Add{"Inventory", Value = 1269}         -- "Heal"
		end
		goto _14
	elseif i == 5 then
		goto _15
	end
	evt.GiveItem{Strength = 5, Type = const.ItemType.Scroll_, Id = 0}
::_14::
	i = Game.Rand() % 6
	if i == 4 or i == 5 then
		return
	end
::_15::
	evt.Add{"MapVar51", Value = 1}
end

evt.hint[199] = evt.str[10]  -- "Bookcase"
Game.MapEvtLines:RemoveEvent(199)
evt.map[199] = function()
	local i
	if evt.Cmp{"MapVar52", Value = 1} then
		return
	end
	i = Game.Rand() % 6
	if i == 3 then
		return
	elseif i == 4 then
		i = Game.Rand() % 6
		if i == 1 then
			evt.Add{"Inventory", Value = 1203}         -- "Fire Bolt"
		elseif i == 2 then
			evt.Add{"Inventory", Value = 1214}         -- "Feather Fall"
		elseif i == 3 then
			evt.Add{"Inventory", Value = 1216}         -- "Sparks"
		elseif i == 4 then
			evt.Add{"Inventory", Value = 1281}         -- "Dispel Magic"
		elseif i == 5 then
			evt.Add{"Inventory", Value = 1269}         -- "Heal"
		end
		goto _14
	elseif i == 5 then
		goto _15
	end
	evt.GiveItem{Strength = 5, Type = const.ItemType.Scroll_, Id = 0}
::_14::
	i = Game.Rand() % 6
	if i == 4 or i == 5 then
		return
	end
::_15::
	evt.Add{"MapVar52", Value = 1}
end

evt.hint[200] = evt.str[10]  -- "Bookcase"
Game.MapEvtLines:RemoveEvent(200)
evt.map[200] = function()
	evt.StatusText{Str = 19}         -- "There are no items that interest you"
end

evt.hint[376] = evt.str[15]  -- "Portrait"
Game.MapEvtLines:RemoveEvent(376)
evt.map[376] = function()
	if not evt.Cmp{"QBits", Value = 778} then         -- Took Angel Painting
		evt.SetTexture{Facet = 15, Name = "t2bs"}
		evt.Add{"Inventory", Value = 1423}         -- "Angel Statue Painting"
		evt.Add{"QBits", Value = 778}         -- Took Angel Painting
	end
end

evt.hint[501] = evt.str[2]  -- "Leave the Haunted Mansion"
Game.MapEvtLines:RemoveEvent(501)
evt.map[501] = function()
	evt.MoveToMap{X = -19207, Y = 12339, Z = 33, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "Out11.odm"}
end



--[[ MMMerge additions ]]--


-- Pick portrait
Game.MapEvtLines:RemoveEvent(376)
evt.Hint[376] = mapvars.PortraitTaken and "" or evt.str[15]

evt.Map[376] = function()
	if mapvars.PortraitTaken then
		return
	end

	evt.SetTexture{15,"t2bs"}
	evt[0].Add{"Inventory", 1423}
	Party.QBits[778] = true

	evt.Hint[376] = ""
	mapvars.PortraitTaken = true
end
