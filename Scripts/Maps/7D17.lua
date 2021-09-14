local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave the Tidewater Caverns",
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


evt.hint[1] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(1)
evt.map[1] = function()  -- function events.LoadMap()
	evt.Set{"MapVar0", Value = 1}
	evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
end

events.LoadMap = evt.map[1].last

Game.MapEvtLines:RemoveEvent(3)
evt.map[3] = function()
	evt.SetDoorState{Id = 3, State = 2}         -- switch state
end

evt.hint[4] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(4)
evt.map[4] = function()
	if evt.Cmp{"MapVar0", Value = 1} then
		return
	end
	evt.SetDoorState{Id = 4, State = 2}         -- switch state
	if evt.CheckSkill{const.Skills.Perception, Mastery = const.GM, Level = 40} then
		if evt.CheckSkill{const.Skills.DisarmTraps, Mastery = const.GM, Level = 40} then
			evt.StatusText{Str = 14}         -- "You Successfully disarm the trap"
			return
		end
	end
	evt.CastSpell{Spell = 32, Mastery = const.GM, Skill = 15, FromX = -512, FromY = 3936, FromZ = 246, ToX = 608, ToY = 3936, ToZ = 246}         -- "Ice Blast"
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

evt.hint[7] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(7)
evt.map[7] = function()
	evt.SetDoorState{Id = 5, State = 0}
	evt.Set{"MapVar0", Value = 0}
end

evt.hint[8] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(8)
evt.map[8] = function()
	evt.Set{"MapVar0", Value = 1}
	evt.SetDoorState{Id = 5, State = 1}
end

evt.hint[176] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(176)
evt.map[176] = function()
	if not evt.Cmp{"QBits", Value = 2119} then         -- "Promoted to Priest"
		if not evt.Cmp{"QBits", Value = 2120} then         -- "Promoted to Honorary Priest"
			evt.OpenChest{Id = 1}
			evt.Add{"QBits", Value = 730}         -- Map to Evenmorn - I lost it
			return
		end
	end
	evt.OpenChest{Id = 0}
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
		evt.Add{"Inventory", Value = 1490}         -- "Phylt-laced ore"
		goto _9
	elseif i == 4 then
		evt.DamagePlayer{-- ERROR: Const not found
Player = "All", DamageType = const.Damage.Fire, Damage = 50}
		evt.StatusText{Str = 13}         -- "Cave In !"
		goto _8
	elseif i == 5 then
		goto _8
	end
	evt.Add{"Inventory", Value = 1489}         -- "Siertal-laced ore"
::_9::
	evt.Set{"MapVar14", Value = 1}
	evt.SetTexture{Facet = 2, Name = "c2b"}
	do return end
::_8::
	evt.Add{"Inventory", Value = 1491}         -- "Kergar-laced ore"
	goto _9
end

function events.LoadMap()
	if evt.Cmp{"MapVar14", Value = 1} then
		evt.SetTexture{Facet = 2, Name = "c2b"}
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
		evt.Add{"Inventory", Value = 1490}         -- "Phylt-laced ore"
		goto _9
	elseif i == 4 then
		evt.DamagePlayer{-- ERROR: Const not found
Player = "All", DamageType = const.Damage.Fire, Damage = 50}
		evt.StatusText{Str = 13}         -- "Cave In !"
		goto _8
	elseif i == 5 then
		goto _8
	end
	evt.Add{"Inventory", Value = 1489}         -- "Siertal-laced ore"
::_9::
	evt.Set{"MapVar15", Value = 1}
	evt.SetTexture{Facet = 3, Name = "c2b"}
	do return end
::_8::
	evt.Add{"Inventory", Value = 1491}         -- "Kergar-laced ore"
	goto _9
end

function events.LoadMap()
	if evt.Cmp{"MapVar15", Value = 1} then
		evt.SetTexture{Facet = 3, Name = "c2b"}
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
		evt.Add{"Inventory", Value = 1490}         -- "Phylt-laced ore"
		goto _9
	elseif i == 4 then
		evt.DamagePlayer{-- ERROR: Const not found
Player = "All", DamageType = const.Damage.Fire, Damage = 50}
		evt.StatusText{Str = 13}         -- "Cave In !"
		goto _8
	elseif i == 5 then
		goto _8
	end
	evt.Add{"Inventory", Value = 1489}         -- "Siertal-laced ore"
::_9::
	evt.Set{"MapVar16", Value = 1}
	evt.SetTexture{Facet = 4, Name = "c2b"}
	do return end
::_8::
	evt.Add{"Inventory", Value = 1491}         -- "Kergar-laced ore"
	goto _9
end

function events.LoadMap()
	if evt.Cmp{"MapVar16", Value = 1} then
		evt.SetTexture{Facet = 4, Name = "c2b"}
	end
end

evt.hint[416] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(416)
evt.map[416] = function()
	evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 4, FromX = -7008, FromY = 4352, FromZ = 850, ToX = 0, ToY = 0, ToZ = 0}         -- "Sparks"
end

evt.hint[501] = evt.str[2]  -- "Leave the Tidewater Caverns"
Game.MapEvtLines:RemoveEvent(501)
evt.map[501] = function()
	evt.MoveToMap{X = -19112, Y = 2248, Z = 49, Direction = 896, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "7Out13.odm"}
end

