local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave Castle Gryphonheart",
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
	[15] = "Portrait",
	[16] = "Take a Drink",
	[17] = "Not Very Refreshing",
	[18] = "Refreshing",
	[19] = "",
	[20] = "Enter the Throne Room",
	[21] = "The Door is Locked",
}
table.copy(TXT, evt.str, true)


evt.hint[1] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(1)
evt.map[1] = function()  -- function events.LoadMap()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if evt.Cmp{"QBits", Value = 873} then         -- mESSENGER ONE-TIME
		evt.Set{"MapVar4", Value = 0}
		evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = false}         -- "Generic Monster Group for Dungeons"
		evt.SetMonGroupBit{NPCGroup = 55, Bit = const.MonsterBits.Hostile, On = false}         -- "Guards"
		return
	end
	if not evt.Cmp{"MapVar4", Value = 2} then
		if not evt.Cmp{"QBits", Value = 612} then         -- Chose the path of Dark
			return
		end
		evt.Set{"MapVar4", Value = 2}
	end
	evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
	evt.SetMonGroupBit{NPCGroup = 55, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
end

events.LoadMap = evt.map[1].last

evt.hint[2] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(2)
evt.map[2] = function()  -- function events.LeaveMap()
	if not evt.CheckMonstersKilled{CheckType = 1, Id = 56, Count = 1} then
		if not evt.CheckMonstersKilled{CheckType = 1, Id = 55, Count = 1} then
			return
		end
	end
	evt.Set{"MapVar4", Value = 2}
end

events.LeaveMap = evt.map[2].last

evt.hint[3] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(3)
evt.map[3] = function()
	evt.SetDoorState{Id = 4, State = 0}
	evt.SetDoorState{Id = 5, State = 0}
end

Game.MapEvtLines:RemoveEvent(4)
evt.map[4] = function()
	evt.SetDoorState{Id = 6, State = 0}
end

evt.hint[5] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(5)
evt.map[5] = function()
	evt.SetDoorState{Id = 7, State = 0}
end

evt.hint[6] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(6)
evt.map[6] = function()
	evt.SetDoorState{Id = 8, State = 0}
end

evt.hint[7] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(7)
evt.map[7] = function()
	evt.SetDoorState{Id = 9, State = 0}
end

evt.hint[8] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(8)
evt.map[8] = function()
	evt.SetDoorState{Id = 10, State = 0}
end

Game.MapEvtLines:RemoveEvent(9)
evt.map[9] = function()
	evt.SetDoorState{Id = 11, State = 0}
end

evt.hint[10] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(10)
evt.map[10] = function()
	evt.SetDoorState{Id = 12, State = 0}
end

Game.MapEvtLines:RemoveEvent(11)
evt.map[11] = function()
	evt.SetDoorState{Id = 1, State = 0}
end

evt.hint[12] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(12)
evt.map[12] = function()
	evt.SetDoorState{Id = 2, State = 0}
	evt.SetDoorState{Id = 3, State = 0}
end

evt.hint[176] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(176)
evt.map[176] = function()
	if not evt.Cmp{"MapVar4", Value = 2} then
		evt.Set{"MapVar4", Value = 2}
		evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.SetMonGroupBit{NPCGroup = 55, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	end
	evt.OpenChest{Id = 1}
end

evt.hint[177] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(177)
evt.map[177] = function()
	if not evt.Cmp{"MapVar4", Value = 2} then
		evt.Set{"MapVar4", Value = 2}
		evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.SetMonGroupBit{NPCGroup = 55, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	end
	evt.OpenChest{Id = 2}
end

evt.hint[178] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(178)
evt.map[178] = function()
	if not evt.Cmp{"MapVar4", Value = 2} then
		evt.Set{"MapVar4", Value = 2}
		evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.SetMonGroupBit{NPCGroup = 55, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	end
	evt.OpenChest{Id = 3}
end

evt.hint[179] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(179)
evt.map[179] = function()
	if not evt.Cmp{"MapVar4", Value = 2} then
		evt.Set{"MapVar4", Value = 2}
		evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.SetMonGroupBit{NPCGroup = 55, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	end
	evt.OpenChest{Id = 4}
end

evt.hint[180] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(180)
evt.map[180] = function()
	if not evt.Cmp{"MapVar4", Value = 2} then
		evt.Set{"MapVar4", Value = 2}
		evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.SetMonGroupBit{NPCGroup = 55, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	end
	evt.OpenChest{Id = 5}
end

evt.hint[181] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(181)
evt.map[181] = function()
	if not evt.Cmp{"MapVar4", Value = 2} then
		evt.Set{"MapVar4", Value = 2}
		evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.SetMonGroupBit{NPCGroup = 55, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	end
	evt.OpenChest{Id = 6}
end

evt.hint[182] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(182)
evt.map[182] = function()
	if not evt.Cmp{"MapVar4", Value = 2} then
		evt.Set{"MapVar4", Value = 2}
		evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.SetMonGroupBit{NPCGroup = 55, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	end
	evt.OpenChest{Id = 7}
end

evt.hint[183] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(183)
evt.map[183] = function()
	if not evt.Cmp{"MapVar4", Value = 2} then
		evt.Set{"MapVar4", Value = 2}
		evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.SetMonGroupBit{NPCGroup = 55, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	end
	evt.OpenChest{Id = 8}
end

evt.hint[184] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(184)
evt.map[184] = function()
	if not evt.Cmp{"MapVar4", Value = 2} then
		evt.Set{"MapVar4", Value = 2}
		evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.SetMonGroupBit{NPCGroup = 55, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	end
	evt.OpenChest{Id = 9}
end

evt.hint[185] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(185)
evt.map[185] = function()
	if not evt.Cmp{"MapVar4", Value = 2} then
		evt.Set{"MapVar4", Value = 2}
		evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.SetMonGroupBit{NPCGroup = 55, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	end
	evt.OpenChest{Id = 10}
end

evt.hint[186] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(186)
evt.map[186] = function()
	if not evt.Cmp{"MapVar4", Value = 2} then
		evt.Set{"MapVar4", Value = 2}
		evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.SetMonGroupBit{NPCGroup = 55, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	end
	evt.OpenChest{Id = 11}
end

evt.hint[187] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(187)
evt.map[187] = function()
	if not evt.Cmp{"MapVar4", Value = 2} then
		evt.Set{"MapVar4", Value = 2}
		evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.SetMonGroupBit{NPCGroup = 55, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	end
	evt.OpenChest{Id = 12}
end

evt.hint[188] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(188)
evt.map[188] = function()
	if not evt.Cmp{"MapVar4", Value = 2} then
		evt.Set{"MapVar4", Value = 2}
		evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.SetMonGroupBit{NPCGroup = 55, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	end
	evt.OpenChest{Id = 13}
end

evt.hint[189] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(189)
evt.map[189] = function()
	if not evt.Cmp{"MapVar4", Value = 2} then
		evt.Set{"MapVar4", Value = 2}
		evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.SetMonGroupBit{NPCGroup = 55, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	end
	evt.OpenChest{Id = 14}
end

evt.hint[190] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(190)
evt.map[190] = function()
	if not evt.Cmp{"MapVar4", Value = 2} then
		evt.Set{"MapVar4", Value = 2}
		evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.SetMonGroupBit{NPCGroup = 55, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	end
	evt.OpenChest{Id = 15}
end

evt.hint[191] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(191)
evt.map[191] = function()
	if not evt.Cmp{"MapVar4", Value = 2} then
		evt.Set{"MapVar4", Value = 2}
		evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.SetMonGroupBit{NPCGroup = 55, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	end
	evt.OpenChest{Id = 16}
end

evt.hint[192] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(192)
evt.map[192] = function()
	if not evt.Cmp{"MapVar4", Value = 2} then
		evt.Set{"MapVar4", Value = 2}
		evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.SetMonGroupBit{NPCGroup = 55, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	end
	evt.OpenChest{Id = 17}
end

evt.hint[193] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(193)
evt.map[193] = function()
	if not evt.Cmp{"MapVar4", Value = 2} then
		evt.Set{"MapVar4", Value = 2}
		evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.SetMonGroupBit{NPCGroup = 55, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	end
	evt.OpenChest{Id = 18}
end

evt.hint[194] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(194)
evt.map[194] = function()
	if not evt.Cmp{"MapVar4", Value = 2} then
		evt.Set{"MapVar4", Value = 2}
		evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.SetMonGroupBit{NPCGroup = 55, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	end
	evt.OpenChest{Id = 19}
end

evt.hint[195] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(195)
evt.map[195] = function()
	if not evt.Cmp{"MapVar4", Value = 2} then
		evt.Set{"MapVar4", Value = 2}
		evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.SetMonGroupBit{NPCGroup = 55, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	end
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
	evt.StatusText{Str = 19}         -- ""
end

evt.house[376] = 1158  -- "Alice Hargreaves"
Game.MapEvtLines:RemoveEvent(376)
evt.map[376] = function()
	if not evt.Cmp{"QBits", Value = 537} then         -- Mini-dungeon Area 5.  Rescued/Captured Alice Hargreaves.
		if not evt.Cmp{"NPCs", Value = 393} then         -- "Alice Hargreaves"
			if evt.Cmp{"QBits", Value = 538} then         -- "Find the Blessed Panoply of Sir BunGleau and return  to William Setag in the Deyja Moors."
				evt.EnterHouse{Id = 1158}         -- "Alice Hargreaves"
				return
			end
		end
	end
	evt.StatusText{Str = 21}         -- "The Door is Locked"
	evt.FaceAnimation{-- ERROR: Const not found
Player = "Current", Animation = 18}
end

evt.hint[377] = evt.str[15]  -- "Portrait"
Game.MapEvtLines:RemoveEvent(377)
evt.map[377] = function()
	if not evt.Cmp{"QBits", Value = 776} then         -- Took Roland Painting
		evt.SetTexture{Facet = 15, Name = "chb1"}
		evt.Add{"Inventory", Value = 1425}         -- "Roland Ironfist Painting"
		evt.Add{"QBits", Value = 776}         -- Took Roland Painting
	end
end

evt.hint[378] = evt.str[15]  -- "Portrait"
Game.MapEvtLines:RemoveEvent(378)
evt.map[378] = function()
	if not evt.Cmp{"QBits", Value = 777} then         -- Took Archi Painting
		evt.SetTexture{Facet = 16, Name = "chb1"}
		evt.Add{"Inventory", Value = 1424}         -- "Archibald Ironfist Painting"
		evt.Add{"QBits", Value = 777}         -- Took Archi Painting
	end
end

evt.house[416] = 217  -- "Throne Room"
Game.MapEvtLines:RemoveEvent(416)
evt.map[416] = function()
	if evt.Cmp{"QBits", Value = 873} then         -- mESSENGER ONE-TIME
		evt.EnterHouse{Id = 217}         -- "Throne Room"
	else
		evt.FaceAnimation{-- ERROR: Const not found
Player = "Current", Animation = 18}
		evt.StatusText{Str = 21}         -- "The Door is Locked"
	end
end

evt.hint[451] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(451)
evt.map[451] = function()
	if not evt.Cmp{"Invisible", Value = 0} then
		if not evt.Cmp{"MapVar4", Value = 1} then
			evt.SpeakNPC{NPC = 616}         -- "Castle Guard"
			evt.Set{"MapVar4", Value = 1}
		end
	end
end

evt.hint[452] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(452)
evt.map[452] = function()
	if not evt.Cmp{"Invisible", Value = 0} then
		if not evt.Cmp{"MapVar4", Value = 2} then
			evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
			evt.SetMonGroupBit{NPCGroup = 55, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
			evt.Set{"MapVar4", Value = 2}
		end
	end
end

evt.hint[453] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(453)
evt.map[453] = function()
	if not evt.Cmp{"Invisible", Value = 0} then
		if not evt.Cmp{"MapVar4", Value = 2} then
			evt.Set{"MapVar4", Value = 0}
		end
	end
end

evt.hint[454] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(454)
evt.map[454] = function()  -- RefillTimer(<function>, const.Month, true)
	evt.Set{"MapVar4", Value = 0}
end

RefillTimer(evt.map[454].last, const.Month, true)

evt.hint[501] = evt.str[2]  -- "Leave Castle Gryphonheart"
Game.MapEvtLines:RemoveEvent(501)
evt.map[501] = function()
	evt.MoveToMap{X = -486, Y = 9984, Z = 2401, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "7Out03.odm"}
end

evt.hint[502] = evt.str[2]  -- "Leave Castle Gryphonheart"
Game.MapEvtLines:RemoveEvent(502)
evt.map[502] = function()
	if evt.Cmp{"Inventory", Value = 1462} then         -- "Catherine's Key"
		evt.MoveToMap{X = 1050, Y = 9991, Z = 2913, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "7Out03.odm"}
	else
		evt.StatusText{Str = 21}         -- "The Door is Locked"
		evt.FaceAnimation{-- ERROR: Const not found
Player = "Current", Animation = 18}
	end
end

