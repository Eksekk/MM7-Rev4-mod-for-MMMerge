local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave the Red Dwarf Mines",
	[3] = "Chest",
	[4] = "Button",
	[5] = "Lever",
	[6] = "Vault",
	[7] = "Cabinet",
	[8] = "Switch",
	[9] = "Mine Car",
	[10] = "Bookcase",
	[11] = "Statue",
	[12] = "Ore Vein",
	[13] = "Cave In !",
	[14] = "You Successfully disarm the trap",
	[15] = "Professor Dumbledore’s Grog ",
	[16] = "Take a Drink",
	[17] = "Not Very Refreshing",
	[18] = "Refreshing",
}
table.copy(TXT, evt.str, true)


evt.hint[1] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(1)
evt.map[1] = function()  -- function events.LoadMap()
	if evt.Cmp{"QBits", Value = 570} then         -- Destroyed critter generator in dungeon.  Warrior Mage promo quest.
		evt.Set{"MapVar0", Value = 1}
	end
	if evt.Cmp{"QBits", Value = 610} then         -- Built Castle to Level 2 (rescued dwarf guy)
		evt.SetSprite{SpriteId = 1, Visible = 0, Name = "0"}
		evt.SetSprite{SpriteId = 2, Visible = 0, Name = "0"}
		evt.SetSprite{SpriteId = 3, Visible = 0, Name = "0"}
		evt.SetSprite{SpriteId = 4, Visible = 0, Name = "0"}
		evt.SetSprite{SpriteId = 5, Visible = 0, Name = "0"}
		evt.SetSprite{SpriteId = 6, Visible = 0, Name = "0"}
		evt.SetSprite{SpriteId = 7, Visible = 0, Name = "0"}
	end
end

events.LoadMap = evt.map[1].last

-- ERROR: Invalid command size: 2565:0 (Cmd00)
evt.hint[10] = evt.str[15]  -- "Professor Dumbledore’s Grog "
Game.MapEvtLines:RemoveEvent(10)
evt.map[10] = function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if not evt.Cmp{"QBits", Value = 847} then         -- BDJ 1
		evt.Set{"QBits", Value = 847}         -- BDJ 1
		evt.Set{"LearningSkill", Value = 70}
	end
end

Game.MapEvtLines:RemoveEvent(151)
evt.map[151] = function()
	if not evt.Cmp{"Counter4", Value = 1} then
		evt.SetDoorState{Id = 1, State = 2}         -- switch state
		evt.SetDoorState{Id = 2, State = 2}         -- switch state
	end
end

evt.hint[176] = evt.str[9]  -- "Mine Car"
Game.MapEvtLines:RemoveEvent(176)
evt.map[176] = function()
	evt.OpenChest{Id = 1}
end

evt.hint[177] = evt.str[9]  -- "Mine Car"
Game.MapEvtLines:RemoveEvent(177)
evt.map[177] = function()
	evt.OpenChest{Id = 2}
end

evt.hint[178] = evt.str[9]  -- "Mine Car"
Game.MapEvtLines:RemoveEvent(178)
evt.map[178] = function()
	evt.OpenChest{Id = 3}
end

evt.hint[179] = evt.str[9]  -- "Mine Car"
Game.MapEvtLines:RemoveEvent(179)
evt.map[179] = function()
	evt.OpenChest{Id = 4}
end

evt.hint[180] = evt.str[9]  -- "Mine Car"
Game.MapEvtLines:RemoveEvent(180)
evt.map[180] = function()
	evt.OpenChest{Id = 5}
end

evt.hint[181] = evt.str[9]  -- "Mine Car"
Game.MapEvtLines:RemoveEvent(181)
evt.map[181] = function()
	evt.OpenChest{Id = 6}
end

evt.hint[182] = evt.str[9]  -- "Mine Car"
Game.MapEvtLines:RemoveEvent(182)
evt.map[182] = function()
	evt.OpenChest{Id = 7}
end

evt.hint[183] = evt.str[9]  -- "Mine Car"
Game.MapEvtLines:RemoveEvent(183)
evt.map[183] = function()
	evt.OpenChest{Id = 8}
end

evt.hint[184] = evt.str[9]  -- "Mine Car"
Game.MapEvtLines:RemoveEvent(184)
evt.map[184] = function()
	evt.OpenChest{Id = 9}
end

evt.hint[185] = evt.str[9]  -- "Mine Car"
Game.MapEvtLines:RemoveEvent(185)
evt.map[185] = function()
	evt.OpenChest{Id = 10}
end

evt.hint[186] = evt.str[9]  -- "Mine Car"
Game.MapEvtLines:RemoveEvent(186)
evt.map[186] = function()
	evt.OpenChest{Id = 11}
end

evt.hint[187] = evt.str[9]  -- "Mine Car"
Game.MapEvtLines:RemoveEvent(187)
evt.map[187] = function()
	evt.OpenChest{Id = 12}
end

evt.hint[188] = evt.str[9]  -- "Mine Car"
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
		evt.Add{"Inventory", Value = 1489}         -- "Siertal-laced ore"
		goto _9
	elseif i == 4 then
		evt.DamagePlayer{-- ERROR: Const not found
Player = "All", DamageType = const.Damage.Fire, Damage = 50}
		evt.StatusText{Str = 13}         -- "Cave In !"
		goto _8
	elseif i == 5 then
		goto _8
	end
	evt.Add{"Inventory", Value = 1488}         -- "Iron-laced ore"
::_9::
	evt.Set{"MapVar14", Value = 1}
	evt.SetTexture{Facet = 1, Name = "c2b"}
	do return end
::_8::
	evt.Add{"Inventory", Value = 1490}         -- "Phylt-laced ore"
	goto _9
end

function events.LoadMap()
	if evt.Cmp{"MapVar14", Value = 1} then
		evt.SetTexture{Facet = 1, Name = "c2b"}
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
		evt.Add{"Inventory", Value = 1489}         -- "Siertal-laced ore"
		goto _9
	elseif i == 4 then
		evt.DamagePlayer{-- ERROR: Const not found
Player = "All", DamageType = const.Damage.Fire, Damage = 50}
		evt.StatusText{Str = 13}         -- "Cave In !"
		goto _8
	elseif i == 5 then
		goto _8
	end
	evt.Add{"Inventory", Value = 1488}         -- "Iron-laced ore"
::_9::
	evt.Set{"MapVar15", Value = 1}
	evt.SetTexture{Facet = 5, Name = "c2b"}
	do return end
::_8::
	evt.Add{"Inventory", Value = 1490}         -- "Phylt-laced ore"
	goto _9
end

function events.LoadMap()
	if evt.Cmp{"MapVar15", Value = 1} then
		evt.SetTexture{Facet = 5, Name = "c2b"}
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
	evt.SetTexture{Facet = 6, Name = "c2b"}
	do return end
::_8::
	evt.Add{"Inventory", Value = 1491}         -- "Kergar-laced ore"
	goto _9
end

function events.LoadMap()
	if evt.Cmp{"MapVar16", Value = 1} then
		evt.SetTexture{Facet = 6, Name = "c2b"}
	end
end

evt.hint[376] = evt.str[11]  -- "Statue"
Game.MapEvtLines:RemoveEvent(376)
evt.map[376] = function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if evt.Cmp{"Inventory", Value = 1431} then         -- "Elixir"
		evt.SetSprite{SpriteId = 1, Visible = 0, Name = "0"}
		evt.Set{"NPCs", Value = 400}         -- "Jaycen Keldin"
		evt.SpeakNPC{NPC = 400}         -- "Jaycen Keldin"
	end
end

evt.hint[377] = evt.str[11]  -- "Statue"
Game.MapEvtLines:RemoveEvent(377)
evt.map[377] = function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if evt.Cmp{"Inventory", Value = 1431} then         -- "Elixir"
		evt.SetSprite{SpriteId = 2, Visible = 0, Name = "0"}
		evt.Set{"NPCs", Value = 401}         -- "Yarrow Keldin"
		evt.SpeakNPC{NPC = 401}         -- "Yarrow Keldin"
	end
end

evt.hint[378] = evt.str[11]  -- "Statue"
Game.MapEvtLines:RemoveEvent(378)
evt.map[378] = function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if evt.Cmp{"Inventory", Value = 1431} then         -- "Elixir"
		evt.SetSprite{SpriteId = 3, Visible = 0, Name = "0"}
		evt.Set{"NPCs", Value = 402}         -- "Fausil Keldin"
		evt.SpeakNPC{NPC = 402}         -- "Fausil Keldin"
	end
end

evt.hint[379] = evt.str[11]  -- "Statue"
Game.MapEvtLines:RemoveEvent(379)
evt.map[379] = function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if evt.Cmp{"Inventory", Value = 1431} then         -- "Elixir"
		evt.SetSprite{SpriteId = 4, Visible = 0, Name = "0"}
		evt.Set{"NPCs", Value = 403}         -- "Red Keldin"
		evt.SpeakNPC{NPC = 403}         -- "Red Keldin"
	end
end

evt.hint[380] = evt.str[11]  -- "Statue"
Game.MapEvtLines:RemoveEvent(380)
evt.map[380] = function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if evt.Cmp{"Inventory", Value = 1431} then         -- "Elixir"
		evt.SetSprite{SpriteId = 5, Visible = 0, Name = "0"}
		evt.Set{"NPCs", Value = 404}         -- "Thom Keldin"
		evt.SpeakNPC{NPC = 404}         -- "Thom Keldin"
	end
end

evt.hint[381] = evt.str[11]  -- "Statue"
Game.MapEvtLines:RemoveEvent(381)
evt.map[381] = function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if evt.Cmp{"Inventory", Value = 1431} then         -- "Elixir"
		evt.SetSprite{SpriteId = 6, Visible = 0, Name = "0"}
		evt.Set{"NPCs", Value = 405}         -- "Arvin Keldin"
		evt.SpeakNPC{NPC = 405}         -- "Arvin Keldin"
	end
end

evt.hint[382] = evt.str[11]  -- "Statue"
Game.MapEvtLines:RemoveEvent(382)
evt.map[382] = function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if evt.Cmp{"Inventory", Value = 1431} then         -- "Elixir"
		evt.SetSprite{SpriteId = 7, Visible = 0, Name = "0"}
		evt.Set{"NPCs", Value = 399}         -- "Drathen Keldin"
		evt.SpeakNPC{NPC = 399}         -- "Drathen Keldin"
	end
end

Game.MapEvtLines:RemoveEvent(383)
evt.map[383] = function()
	if evt.Cmp{"QBits", Value = 543} then         -- "Sabotage the lift in the Red Dwarf Mines in the Bracada Desert then return to Zedd True Shot on Emerald Island."
		if not evt.Cmp{"QBits", Value = 570} then         -- Destroyed critter generator in dungeon.  Warrior Mage promo quest.
			evt.ForPlayer(-- ERROR: Const not found
"All")
			if evt.Cmp{"Inventory", Value = 1451} then         -- "Worn Belt"
				evt.Set{"QBits", Value = 570}         -- Destroyed critter generator in dungeon.  Warrior Mage promo quest.
				evt.Subtract{"Inventory", Value = 1451}         -- "Worn Belt"
				evt.Subtract{"QBits", Value = 728}         -- Worn Belt - I lost it
				evt.Set{"Counter4", Value = 0}
				evt.FaceAnimation{-- ERROR: Const not found
Player = "Current", Animation = 47}
			end
		end
	end
end

Game.MapEvtLines:RemoveEvent(51)
evt.map[51] = function()  -- Timer(<function>, 0.5*const.Minute)
	if not evt.Cmp{"Counter4", Value = 1} then
		evt.SetDoorState{Id = 3, State = 2}         -- switch state
		evt.SetDoorState{Id = 4, State = 2}         -- switch state
	end
end

Timer(evt.map[51].last, 0.5*const.Minute)

evt.hint[501] = evt.str[2]  -- "Leave the Red Dwarf Mines"
Game.MapEvtLines:RemoveEvent(501)
evt.map[501] = function()
	evt.MoveToMap{X = 20980, Y = 14802, Z = 1, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 4, Name = "7Out06.odm"}
end



--[[ MMMerge additions --]]


-- Rescue dwarfs quest (mm7)

for i = 0, 5 do
	evt.Map[376+i] = function()
		if evt.ForPlayer("All").Cmp{"Inventory", Value = 1431} then
			NPCFollowers.Add(400+i)
		end
	end
end

evt.Map[382] = function()
	if evt.ForPlayer("All").Cmp{"Inventory", Value = 1431} then
		NPCFollowers.Add(399)
	end
end
