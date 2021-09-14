local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave Castle Lambent",
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
	[19] = "",
	[20] = "Enter the Throne Room",
	[21] = "The Door is Locked",
	[22] = "",
	[23] = "",
	[24] = "",
	[25] = "",
	[26] = "",
	[27] = "",
	[28] = "",
	[29] = "",
	[30] = "Tapestry",
}
table.copy(TXT, evt.str, true)


evt.hint[1] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(1)
evt.map[1] = function()  -- function events.LoadMap()
	if not evt.Cmp{"QBits", Value = 611} then         -- Chose the path of Light
		goto _6
	end
	if evt.Cmp{"QBits", Value = 782} then         -- Your friends are mad at you 
		if evt.Cmp{"Counter10", Value = 720} then
			evt.Subtract{"QBits", Value = 782}         -- Your friends are mad at you 
			evt.Set{"MapVar4", Value = 0}
			evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = false}         -- "Generic Monster Group for Dungeons"
			evt.SetMonGroupBit{NPCGroup = 55, Bit = const.MonsterBits.Hostile, On = false}         -- "Guards"
			return
		end
		goto _6
	end
	if not evt.Cmp{"MapVar4", Value = 2} then
		return
	end
::_7::
	evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
	evt.SetMonGroupBit{NPCGroup = 55, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	do return end
::_6::
	evt.Set{"MapVar4", Value = 2}
	goto _7
end

events.LoadMap = evt.map[1].last

Game.MapEvtLines:RemoveEvent(3)
evt.map[3] = function()
	evt.SetDoorState{Id = 3, State = 0}
end

Game.MapEvtLines:RemoveEvent(4)
evt.map[4] = function()
	evt.SetDoorState{Id = 4, State = 0}
end

Game.MapEvtLines:RemoveEvent(5)
evt.map[5] = function()
	evt.SetDoorState{Id = 5, State = 0}
end

Game.MapEvtLines:RemoveEvent(6)
evt.map[6] = function()
	if evt.Cmp{"MapVar0", Value = 1} then
		evt.SetDoorState{Id = 6, State = 2}         -- switch state
		evt.SetDoorState{Id = 7, State = 2}         -- switch state
		evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Invisible, On = false}
		evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Untouchable, On = false}
		evt.Set{"MapVar0", Value = 0}
	else
		evt.SetDoorState{Id = 6, State = 2}         -- switch state
		evt.SetDoorState{Id = 7, State = 2}         -- switch state
		evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Invisible, On = true}
		evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Untouchable, On = true}
		evt.SetDoorState{Id = 12, State = 0}
		evt.SetDoorState{Id = 13, State = 0}
		evt.Set{"MapVar0", Value = 1}
	end
end

Game.MapEvtLines:RemoveEvent(7)
evt.map[7] = function()
	evt.SetDoorState{Id = 8, State = 2}         -- switch state
end

Game.MapEvtLines:RemoveEvent(8)
evt.map[8] = function()
	evt.SetDoorState{Id = 9, State = 2}         -- switch state
end

evt.hint[9] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(9)
evt.map[9] = function()
	evt.SetDoorState{Id = 10, State = 2}         -- switch state
	evt.SetDoorState{Id = 11, State = 2}         -- switch state
end

evt.hint[10] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(10)
evt.map[10] = function()
	evt.SetDoorState{Id = 2, State = 0}
end

Game.MapEvtLines:RemoveEvent(11)
evt.map[11] = function()
	evt.SetDoorState{Id = 14, State = 2}         -- switch state
	if not evt.Cmp{"MapVar0", Value = 1} then
		evt.SetDoorState{Id = 12, State = 2}         -- switch state
		evt.SetDoorState{Id = 13, State = 2}         -- switch state
	end
end

evt.hint[12] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(12)
evt.map[12] = function()
	evt.SetDoorState{Id = 1, State = 0}
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
	if evt.Cmp{"QBits", Value = 611} then         -- Chose the path of Light
		if evt.Cmp{"QBits", Value = 642} then         -- "Go to the Lincoln in the sea west of Avlee and retrieve the Oscillation Overthruster and return it to Resurectra in Celeste."
			evt.SetChestBit{ChestId = 7, Bit = const.ChestBits.Trapped, On = false}
			evt.OpenChest{Id = 7}
			evt.Add{"QBits", Value = 747}         -- Wetsuit - I lost it
			return
		end
		goto _7
	end
	if evt.Cmp{"MapVar4", Value = 2} then
		goto _7
	end
	evt.Set{"MapVar4", Value = 2}
	evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
	evt.SetMonGroupBit{NPCGroup = 55, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
::_8::
	evt.OpenChest{Id = 19}
	do return end
::_7::
	evt.SetChestBit{ChestId = 19, Bit = const.ChestBits.Trapped, On = false}
	goto _8
end

evt.hint[183] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(183)
evt.map[183] = function()
	if evt.Cmp{"QBits", Value = 611} then         -- Chose the path of Light
		if evt.Cmp{"QBits", Value = 642} then         -- "Go to the Lincoln in the sea west of Avlee and retrieve the Oscillation Overthruster and return it to Resurectra in Celeste."
			evt.SetChestBit{ChestId = 8, Bit = const.ChestBits.Trapped, On = false}
			evt.OpenChest{Id = 8}
			evt.Add{"QBits", Value = 747}         -- Wetsuit - I lost it
			return
		end
		goto _7
	end
	if evt.Cmp{"MapVar4", Value = 2} then
		goto _7
	end
	evt.Set{"MapVar4", Value = 2}
	evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
	evt.SetMonGroupBit{NPCGroup = 55, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
::_8::
	evt.OpenChest{Id = 0}
	do return end
::_7::
	evt.SetChestBit{ChestId = 0, Bit = const.ChestBits.Trapped, On = false}
	goto _8
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

evt.hint[376] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(376)
evt.map[376] = function()
	if not evt.Cmp{"QBits", Value = 711} then         -- Take the Associate's Tapestry
		if evt.Cmp{"QBits", Value = 611} then         -- Chose the path of Light
			if evt.Cmp{"QBits", Value = 694} then         -- "Steal the Tapestry from your associate's Castle and return it to Niles Stantley in the Mercenary Guild in Tatalia."
				evt.SetTexture{Facet = 10, Name = "cwb"}
				evt.Add{"Inventory", Value = 1422}         -- "Big Tapestry"
				evt.Add{"QBits", Value = 711}         -- Take the Associate's Tapestry
				evt.SetMonGroupBit{NPCGroup = 55, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
				evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
				evt.Set{"MapVar4", Value = 2}
			end
		end
	end
end

evt.hint[377] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(377)
evt.map[377] = function()  -- function events.LoadMap()
	if evt.Cmp{"QBits", Value = 711} then         -- Take the Associate's Tapestry
		evt.SetTexture{Facet = 15, Name = "cwb"}
	end
end

events.LoadMap = evt.map[377].last

evt.house[416] = 220  -- "Throne Room"
Game.MapEvtLines:RemoveEvent(416)
evt.map[416] = function()
	if evt.Cmp{"MapVar4", Value = 2} then
		evt.StatusText{Str = 21}         -- "The Door is Locked"
	else
		evt.EnterHouse{Id = 220}         -- "Throne Room"
	end
end

evt.hint[451] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(451)
evt.map[451] = function()
	if not evt.Cmp{"Invisible", Value = 0} then
		if not evt.Cmp{"MapVar4", Value = 1} then
			evt.SpeakNPC{NPC = 618}         -- "Castle Guard"
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
			evt.Set{"Counter10", Value = 0}
			evt.Set{"QBits", Value = 782}         -- Your friends are mad at you 
		end
	end
end

evt.hint[453] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(453)
evt.map[453] = function()
	if not evt.Cmp{"MapVar4", Value = 2} then
		evt.Set{"MapVar4", Value = 0}
	end
end

evt.hint[501] = evt.str[2]  -- "Leave Castle Lambent"
Game.MapEvtLines:RemoveEvent(501)
evt.map[501] = function()
	evt.MoveToMap{X = -1264, Y = 19718, Z = 225, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "7D25.blv"}
end



--[[ MMMerge additions --]]


-- Enter Throne Room

Game.MapEvtLines:RemoveEvent(416)
evt.Hint[416] = evt.str[20]
evt.Map[416] = function()
	if Party.QBits[612] or not Party.QBits[611]
		or Party.EnemyDetectorYellow
		or Party.EnemyDetectorRed then

		Game.ShowStatusText(evt.str[21])
	else
		evt.EnterHouse{220}
	end
end
