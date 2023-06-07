local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave the Titan Stronghold",
	[3] = "Chest",
	[4] = "Button",
	[5] = "Lever",
	[6] = "Vault",
	[7] = "Cabinet",
	[8] = "Switch",
	[9] = "",
	[10] = "Bookcase",
	[11] = "Strange Torch",
	[12] = "Strange Torch",
	[13] = "Cleric's Totem",
	[14] = "You Successfully disarm the trap",
	[15] = "",
	[16] = "Take a Drink",
	[17] = "Not Very Refreshing",
	[18] = "Refreshing",
}
table.copy(TXT, evt.str, true)

-- REMOVED BY REV4 FOR MERGE
-- Game.MapEvtLines.Count = 0  -- Deactivate all standard events

evt.MazeInfo = evt.str[1]  -- "Door"
-- ERROR: Duplicate label: 4101:0
-- ERROR: Duplicate label: 4101:0

Game.MapEvtLines:RemoveEvent(1)
evt.map[1] = function()  -- function events.LoadMap()
	evt.CastSpell{Spell = 80, Mastery = const.GM, Skill = 21, FromX = -1707, FromY = -21848, FromZ = -1007, ToX = -1707, ToY = -21848, ToZ = -1007}         -- "Dispel Magic"
	evt.CastSpell{Spell = 80, Mastery = const.GM, Skill = 21, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Dispel Magic"
end

events.LoadMap = evt.map[1].last

Game.MapEvtLines:RemoveEvent(3)
evt.map[3] = function()
	evt.SetDoorState{Id = 1, State = 2}         -- switch state
end

Game.MapEvtLines:RemoveEvent(4)
evt.map[4] = function()
	evt.SetDoorState{Id = 2, State = 2}         -- switch state
end

Game.MapEvtLines:RemoveEvent(5)
evt.map[5] = function()
	evt.SetDoorState{Id = 3, State = 2}         -- switch state
end

Game.MapEvtLines:RemoveEvent(6)
evt.map[6] = function()
	evt.SetDoorState{Id = 4, State = 2}         -- switch state
end

evt.hint[10] = evt.str[12]  -- "Strange Torch"
Game.MapEvtLines:RemoveEvent(10)
evt.map[10] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 2007) then         -- Titan Sprite C
		evt.Add("AirResistance", 10)
		evt.Set("QBits", 2007)         -- Titan Sprite C
		evt.SetSprite{SpriteId = 12, Visible = 1, Name = "torch01"}
	end
end

-- ERROR: Invalid command size: 2565:0 (MazeInfo)
evt.hint[11] = evt.str[11]  -- "Strange Torch"
Game.MapEvtLines:RemoveEvent(11)
evt.map[11] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 2006) then         -- Titan Sprite B
		evt.Add("AirResistance", 10)
		evt.Set("QBits", 2006)         -- Titan Sprite B
		evt.SetSprite{SpriteId = 11, Visible = 1, Name = "torch01"}
	end
end

-- ERROR: Invalid command size: 2821:0 (MazeInfo)
evt.hint[12] = evt.str[13]  -- "Cleric's Totem"
Game.MapEvtLines:RemoveEvent(12)
evt.map[12] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 2008) then         -- Titan Sprite D
		evt.Add("MindResistance", 20)
		evt.Add("BodyResistance", 20)
		evt.Add("LightResistance", 20)
		evt.Set("QBits", 2008)         -- Titan Sprite D
		evt.SetSprite{SpriteId = 13, Visible = 1, Name = "torch01"}
	end
end

-- ERROR: Invalid command size: 3077:0 (OpenChest)
Game.MapEvtLines:RemoveEvent(3077)
evt.map[3077] = function()
	evt.OpenChest(1)
end

evt.hint[13] = evt.str[13]  -- "Cleric's Totem"
Game.MapEvtLines:RemoveEvent(13)
evt.map[13] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 2008) then         -- Titan Sprite D
		evt.Add("MindResistance", 20)
		evt.Add("BodyResistance", 20)
		evt.Add("LightResistance", 20)
		evt.Set("QBits", 2008)         -- Titan Sprite D
		evt.SetSprite{SpriteId = 13, Visible = 1, Name = "torch01"}
	end
end

-- ERROR: Invalid command size: 3333:0 (OpenChest)
Game.MapEvtLines:RemoveEvent(3333)
evt.map[3333] = function()
	evt.OpenChest(1)
end

evt.hint[14] = evt.str[13]  -- "Cleric's Totem"
Game.MapEvtLines:RemoveEvent(14)
evt.map[14] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 2008) then         -- Titan Sprite D
		evt.Add("MindResistance", 20)
		evt.Add("BodyResistance", 20)
		evt.Add("LightResistance", 20)
		evt.Set("QBits", 2008)         -- Titan Sprite D
		evt.SetSprite{SpriteId = 13, Visible = 1, Name = "torch01"}
	end
end

-- ERROR: Invalid command size: 3589:0 (OpenChest)
Game.MapEvtLines:RemoveEvent(3589)
evt.map[3589] = function()
	evt.OpenChest(1)
end

evt.hint[15] = evt.str[13]  -- "Cleric's Totem"
Game.MapEvtLines:RemoveEvent(15)
evt.map[15] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 2008) then         -- Titan Sprite D
		evt.Add("MindResistance", 20)
		evt.Add("BodyResistance", 20)
		evt.Add("LightResistance", 20)
		evt.Set("QBits", 2008)         -- Titan Sprite D
		evt.SetSprite{SpriteId = 13, Visible = 1, Name = "torch01"}
	end
end

-- ERROR: Invalid command size: 3845:0 (OpenChest)
Game.MapEvtLines:RemoveEvent(3845)
evt.map[3845] = function()
	evt.OpenChest(1)
end

evt.hint[16] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(16)
evt.map[16] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	if evt.Cmp("QBits", 2006) then         -- Titan Sprite B
		evt.SetSprite{SpriteId = 11, Visible = 1, Name = "torch01"}
	end
	if evt.Cmp("QBits", 2007) then         -- Titan Sprite C
		evt.SetSprite{SpriteId = 12, Visible = 1, Name = "torch01"}
	end
	if evt.Cmp("QBits", 2008) then         -- Titan Sprite D
		evt.SetSprite{SpriteId = 13, Visible = 1, Name = "torch01"}
	end
end

events.LoadMap = evt.map[16].last

-- ERROR: Invalid command size: 4101:0 (OpenChest)
Game.MapEvtLines:RemoveEvent(4101)
evt.map[4101] = function()
	evt.OpenChest(36)
end

-- ERROR: Invalid command size: 4101:0 (DamagePlayer)
-- ERROR: Invalid command size: 4101:0 (SetTexture)
evt.hint[176] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(176)
evt.map[176] = function()
	if not evt.Cmp("QBits", 1586) then         -- "Promoted to Master Archer"
		if not evt.Cmp("QBits", 1587) then         -- "Promoted to Honorary Master Archer"
			if not evt.Cmp("QBits", 1588) then         -- "Promoted to Sniper"
				if not evt.Cmp("QBits", 1589) then         -- "Promoted to Honorary Sniper"
					if evt.Cmp("QBits", 542) then         -- "Retrieve the Perfect Bow from the Titans' Stronghold in Avlee and return it to Lawrence Mark in Harmondale."
						goto _8
					end
					if evt.Cmp("QBits", 544) then         -- "Retrieve the Perfect Bow from the Titans' Stronghold in Avlee and return it to Steagal Snick in Avlee."
						goto _8
					end
				end
			end
		end
	end
	evt.OpenChest(0)
	do return end
::_8::
	evt.Set("QBits", 675)         -- Got perfect bow out of chest
	evt.OpenChest(1)
end

evt.hint[177] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(177)
evt.map[177] = function()
	evt.OpenChest(2)
end

evt.hint[178] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(178)
evt.map[178] = function()
	evt.OpenChest(3)
end

evt.hint[179] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(179)
evt.map[179] = function()
	evt.OpenChest(4)
end

evt.hint[180] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(180)
evt.map[180] = function()
	evt.OpenChest(5)
end

evt.hint[181] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(181)
evt.map[181] = function()
	evt.OpenChest(6)
end

evt.hint[182] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(182)
evt.map[182] = function()
	evt.OpenChest(7)
end

evt.hint[183] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(183)
evt.map[183] = function()
	evt.OpenChest(8)
end

evt.hint[184] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(184)
evt.map[184] = function()
	evt.OpenChest(9)
end

evt.hint[185] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(185)
evt.map[185] = function()
	evt.OpenChest(10)
end

evt.hint[186] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(186)
evt.map[186] = function()
	evt.OpenChest(11)
end

evt.hint[187] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(187)
evt.map[187] = function()
	evt.OpenChest(12)
end

evt.hint[188] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(188)
evt.map[188] = function()
	evt.OpenChest(13)
end

evt.hint[189] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(189)
evt.map[189] = function()
	evt.OpenChest(14)
end

evt.hint[190] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(190)
evt.map[190] = function()
	evt.OpenChest(15)
end

evt.hint[191] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(191)
evt.map[191] = function()
	evt.OpenChest(16)
end

evt.hint[192] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(192)
evt.map[192] = function()
	evt.OpenChest(17)
end

evt.hint[193] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(193)
evt.map[193] = function()
	evt.OpenChest(18)
end

evt.hint[194] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(194)
evt.map[194] = function()
	evt.OpenChest(19)
end

evt.hint[195] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(195)
evt.map[195] = function()
	evt.OpenChest(0)
end

Game.MapEvtLines:RemoveEvent(501)
evt.map[501] = function()
	evt.MoveToMap{X = 18754, Y = -17550, Z = 929, Direction = 768, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "out14.odm"}
end

