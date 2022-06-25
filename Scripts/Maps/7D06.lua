local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave the Temple of the Moon",
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
	[15] = "Antonio’s Venetian Tea",
	[16] = "Take a Drink",
	[17] = "Not Very Refreshing",
	[18] = "Refreshing",
}
table.copy(TXT, evt.str, true)

-- ERROR: Duplicate label: 10:3
-- ERROR: Duplicate label: 10:5

evt.hint[1] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(1)
evt.map[1] = function()
	evt.SetDoorState{Id = 3, State = 2}         -- switch state
	evt.SetDoorState{Id = 1, State = 2}         -- switch state
	evt.SetDoorState{Id = 2, State = 2}         -- switch state
end

evt.hint[2] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(2)
evt.map[2] = function()
	evt.SetDoorState{Id = 9, State = 1}
	evt.SetDoorState{Id = 5, State = 0}
	evt.SetDoorState{Id = 6, State = 0}
end

evt.hint[3] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(3)
evt.map[3] = function()
	evt.SetDoorState{Id = 10, State = 1}
	evt.SetDoorState{Id = 7, State = 0}
	evt.SetDoorState{Id = 8, State = 0}
end

evt.hint[4] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(4)
evt.map[4] = function()
	evt.SetDoorState{Id = 4, State = 0}
end

Game.MapEvtLines:RemoveEvent(5)
evt.map[5] = function()  -- function events.LoadMap()
	local changed = false
	for idx, m in Map.Monsters do
		if m.Id == 403 then -- green adventurer
			changed = true
			evt.SetMonsterItem{Monster = idx, Item = 1460, Has = true}         -- "Contestant's Shield"
			evt.SetMonsterItem{Monster = idx, Item = 866, Has = true}         -- "Blaster"
			break
		end
	end
	if not changed then
		for idx, m in Map.Monsters do
			if m.Id == 404 or m.Id == 405 then
				changed = true
				evt.SetMonsterItem{Monster = idx, Item = 1460, Has = true}         -- "Contestant's Shield"
				evt.SetMonsterItem{Monster = idx, Item = 866, Has = true}         -- "Blaster"
				break
			end
		end
	end
	if not changed then
		MessageBox("Error: script giving items to monsters in temple of the moon is not working as expected, this should be reported to mod author so he can fix it and give you a command to get these items")
	end
	evt.SetMonGroupBit{NPCGroup = 55, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
end

events.LoadMap = evt.map[5].last

evt.hint[10] = evt.str[15]  -- "Antonio’s Venetian Tea"
Game.MapEvtLines:RemoveEvent(10)
evt.map[10] = function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if not evt.Cmp{"QBits", Value = 842} then         -- 1-time EI temple
		evt.Set{"QBits", Value = 842}         -- 1-time EI temple
		giveFreeSkill(const.Skills.Merchant, 6, const.Expert)
		evt.SetSprite{SpriteId = 15, Visible = 1, Name = "sp57"}
	end
end

Game.MapEvtLines:RemoveEvent(16)
evt.map[16] = function()  -- function events.LoadMap()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if evt.Cmp{"QBits", Value = 842} then         -- 1-time EI temple
		evt.SetSprite{SpriteId = 15, Visible = 1, Name = "sp57"}
	end
end

events.LoadMap = evt.map[16].last

evt.hint[21] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(21)
evt.map[21] = function()
	evt.OpenChest{Id = 1}
end

evt.hint[22] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(22)
evt.map[22] = function()
	evt.OpenChest{Id = 2}
end

evt.hint[23] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(23)
evt.map[23] = function()
	evt.OpenChest{Id = 3}
end

evt.hint[24] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(24)
evt.map[24] = function()
	evt.OpenChest{Id = 4}
end

evt.hint[25] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(25)
evt.map[25] = function()
	evt.OpenChest{Id = 5}
end

evt.hint[26] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(26)
evt.map[26] = function()
	evt.OpenChest{Id = 6}
end

evt.hint[27] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(27)
evt.map[27] = function()
	evt.OpenChest{Id = 7}
end

evt.hint[28] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(28)
evt.map[28] = function()
	evt.OpenChest{Id = 8}
end

evt.hint[29] = evt.str[10]  -- "Bookcase"
Game.MapEvtLines:RemoveEvent(29)
evt.map[29] = function()
	if not evt.Cmp{"MapVar0", Value = 1} then
		evt.Set{"MapVar0", Value = 1}
		evt.Add{"Inventory", Value = 1202}         -- "Torch Light"
	end
end

evt.hint[30] = evt.str[10]  -- "Bookcase"
Game.MapEvtLines:RemoveEvent(30)
evt.map[30] = function()
	if not evt.Cmp{"MapVar1", Value = 1} then
		evt.Set{"MapVar1", Value = 1}
		evt.Add{"Inventory", Value = 1224}         -- "Awaken"
	end
end

evt.hint[31] = evt.str[10]  -- "Bookcase"
Game.MapEvtLines:RemoveEvent(31)
evt.map[31] = function()
	if not evt.Cmp{"MapVar2", Value = 1} then
		evt.Set{"MapVar2", Value = 1}
		evt.Add{"Inventory", Value = 1104}         -- "Fire Resistance"
	end
end

evt.hint[32] = evt.str[10]  -- "Bookcase"
Game.MapEvtLines:RemoveEvent(32)
evt.map[32] = function()
	if not evt.Cmp{"MapVar3", Value = 1} then
		evt.Set{"MapVar3", Value = 1}
		evt.Add{"Inventory", Value = 1113}         -- "Wizard Eye"
	end
end

evt.hint[33] = evt.str[10]  -- "Bookcase"
Game.MapEvtLines:RemoveEvent(33)
evt.map[33] = function()
	if not evt.Cmp{"MapVar4", Value = 1} then
		evt.Set{"MapVar4", Value = 1}
		evt.Add{"Inventory", Value = 1103}         -- "Fire Bolt"
	end
end

evt.hint[34] = evt.str[10]  -- "Bookcase"
Game.MapEvtLines:RemoveEvent(34)
evt.map[34] = function()
	if not evt.Cmp{"MapVar5", Value = 1} then
		evt.Set{"MapVar5", Value = 1}
		evt.Add{"Inventory", Value = 1125}         -- "Poison Spray"
	end
end

evt.hint[35] = evt.str[10]  -- "Bookcase"
Game.MapEvtLines:RemoveEvent(35)
evt.map[35] = function()
	if not evt.Cmp{"MapVar6", Value = 1} then
		evt.Set{"MapVar6", Value = 1}
		evt.Add{"Inventory", Value = 1102}         -- "Torch Light"
	end
end

evt.hint[36] = evt.str[10]  -- "Bookcase"
Game.MapEvtLines:RemoveEvent(36)
evt.map[36] = function()
	if not evt.Cmp{"MapVar7", Value = 1} then
		evt.Set{"MapVar7", Value = 1}
		evt.Add{"Inventory", Value = 1102}         -- "Torch Light"
	end
end

evt.hint[37] = evt.str[10]  -- "Bookcase"
Game.MapEvtLines:RemoveEvent(37)
evt.map[37] = function()
	if not evt.Cmp{"MapVar8", Value = 1} then
		evt.Set{"MapVar8", Value = 1}
		evt.Add{"Inventory", Value = 1102}         -- "Torch Light"
	end
end

evt.hint[38] = evt.str[10]  -- "Bookcase"
Game.MapEvtLines:RemoveEvent(38)
evt.map[38] = function()
	if not evt.Cmp{"MapVar9", Value = 1} then
		evt.Set{"MapVar9", Value = 1}
		evt.Add{"Inventory", Value = 1102}         -- "Torch Light"
	end
end

evt.hint[39] = evt.str[10]  -- "Bookcase"
Game.MapEvtLines:RemoveEvent(39)
evt.map[39] = function()
	if not evt.Cmp{"MapVar10", Value = 1} then
		evt.Set{"MapVar10", Value = 1}
		evt.Add{"Inventory", Value = 1102}         -- "Torch Light"
	end
end

evt.hint[40] = evt.str[10]  -- "Bookcase"
Game.MapEvtLines:RemoveEvent(40)
evt.map[40] = function()
	if not evt.Cmp{"MapVar11", Value = 1} then
		evt.Set{"MapVar11", Value = 1}
		evt.Add{"Inventory", Value = 1113}         -- "Wizard Eye"
	end
end

evt.hint[41] = evt.str[10]  -- "Bookcase"
Game.MapEvtLines:RemoveEvent(41)
evt.map[41] = function()
	if not evt.Cmp{"MapVar12", Value = 1} then
		evt.Set{"MapVar12", Value = 1}
		evt.Add{"Inventory", Value = 1113}         -- "Wizard Eye"
	end
end

evt.hint[42] = evt.str[10]  -- "Bookcase"
Game.MapEvtLines:RemoveEvent(42)
evt.map[42] = function()
	if not evt.Cmp{"MapVar13", Value = 1} then
		evt.Set{"MapVar13", Value = 1}
		evt.Add{"Inventory", Value = 1113}         -- "Wizard Eye"
	end
end

evt.hint[43] = evt.str[10]  -- "Bookcase"
Game.MapEvtLines:RemoveEvent(43)
evt.map[43] = function()
	if not evt.Cmp{"MapVar14", Value = 1} then
		evt.Set{"MapVar14", Value = 1}
		evt.Add{"Inventory", Value = 1113}         -- "Wizard Eye"
	end
end

Game.MapEvtLines:RemoveEvent(51)
evt.map[51] = function()  -- Timer(<function>, 2.5*const.Minute)
	evt.CastSpell{Spell = 2, Mastery = const.Novice, Skill = 2, FromX = -2619, FromY = 7850, FromZ = -95, ToX = -2619, ToY = 4008, ToZ = -95}         -- "Fire Bolt"
	evt.CastSpell{Spell = 2, Mastery = const.Novice, Skill = 2, FromX = -2619, FromY = 4050, FromZ = -95, ToX = -2619, ToY = 7896, ToZ = -95}         -- "Fire Bolt"
end

Timer(evt.map[51].last, 2.5*const.Minute)

evt.hint[100] = evt.str[2]  -- "Leave the Temple of the Moon"
Game.MapEvtLines:RemoveEvent(100)
evt.map[100] = function()
	evt.MoveToMap{X = 15816, Y = 12161, Z = 1133, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 4, Name = "7Out01.Odm"}
end



--[[ MMMerge additions ]]--


function events.LoadMap()
	for i = 5, 8 do
		evt.SetDoorState(i, 1)
	end
	for i = 9, 10 do
		evt.SetDoorState(i, 0)
	end
end

--Game.MapEvtLines:RemoveEvent(51)
