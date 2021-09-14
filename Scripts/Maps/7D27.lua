local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave the Hive",
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
	[20] = "The Door is Locked",
}
table.copy(TXT, evt.str, true)


Game.MapEvtLines:RemoveEvent(2)
evt.map[2] = function()  -- function events.LeaveMap()
	if evt.CheckMonstersKilled{CheckType = 3, Id = 0, Count = 0} then
		evt.Set{"QBits", Value = 617}         -- Slayed Xenofex
		evt.ShowMovie{DoubleSize = 1, ExitCurrentScreen = true, Name = "\"family reunion\" "}
		evt.Add{"History25", Value = 0}
	end
end

events.LeaveMap = evt.map[2].last

Game.MapEvtLines:RemoveEvent(3)
evt.map[3] = function()
	evt.SetDoorState{Id = 5, State = 2}         -- switch state
	evt.SetDoorState{Id = 6, State = 2}         -- switch state
end

Game.MapEvtLines:RemoveEvent(4)
evt.map[4] = function()
	evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Untouchable, On = true}
	evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Invisible, On = true}
	evt.SetFacetBit{Id = 2, Bit = const.FacetBits.Untouchable, On = false}
	evt.SetFacetBit{Id = 2, Bit = const.FacetBits.Invisible, On = false}
end

Game.MapEvtLines:RemoveEvent(5)
evt.map[5] = function()
	evt.SetDoorState{Id = 7, State = 2}         -- switch state
	evt.SetDoorState{Id = 8, State = 2}         -- switch state
end

Game.MapEvtLines:RemoveEvent(6)
evt.map[6] = function()
	evt.SetDoorState{Id = 9, State = 2}         -- switch state
	evt.SetDoorState{Id = 10, State = 2}         -- switch state
	evt.SetDoorState{Id = 11, State = 2}         -- switch state
end

Game.MapEvtLines:RemoveEvent(7)
evt.map[7] = function()
	evt.SetDoorState{Id = 12, State = 2}         -- switch state
	evt.SetDoorState{Id = 13, State = 2}         -- switch state
end

Game.MapEvtLines:RemoveEvent(8)
evt.map[8] = function()
	if evt.Cmp{"MapVar0", Value = 3} then
		evt.SetDoorState{Id = 14, State = 2}         -- switch state
		evt.SetLight{Id = 1, On = false}
		evt.SetFacetBit{Id = 3, Bit = const.FacetBits.Untouchable, On = true}
	else
		evt.SetDoorState{Id = 14, State = 2}         -- switch state
		evt.Add{"MapVar0", Value = 1}
	end
end

Game.MapEvtLines:RemoveEvent(9)
evt.map[9] = function()
	if not evt.Cmp{"MapVar0", Value = 3} then
		evt.SetDoorState{Id = 15, State = 2}         -- switch state
		evt.Add{"MapVar0", Value = 1}
	end
end

Game.MapEvtLines:RemoveEvent(10)
evt.map[10] = function()
	if evt.Cmp{"MapVar0", Value = 3} then
		evt.SetDoorState{Id = 16, State = 2}         -- switch state
		evt.SetLight{Id = 1, On = false}
		evt.SetFacetBit{Id = 3, Bit = const.FacetBits.Untouchable, On = true}
	else
		evt.SetDoorState{Id = 16, State = 2}         -- switch state
		evt.Add{"MapVar0", Value = 1}
	end
end

Game.MapEvtLines:RemoveEvent(11)
evt.map[11] = function()
	if evt.Cmp{"MapVar0", Value = 3} then
		evt.SetDoorState{Id = 17, State = 2}         -- switch state
		evt.SetLight{Id = 1, On = false}
		evt.SetFacetBit{Id = 3, Bit = const.FacetBits.Untouchable, On = true}
	else
		evt.SetDoorState{Id = 17, State = 2}         -- switch state
		evt.Add{"MapVar0", Value = 1}
	end
end

Game.MapEvtLines:RemoveEvent(12)
evt.map[12] = function()
	evt.SetDoorState{Id = 18, State = 2}         -- switch state
	evt.SetDoorState{Id = 19, State = 2}         -- switch state
end

Game.MapEvtLines:RemoveEvent(13)
evt.map[13] = function()
	evt.SetDoorState{Id = 20, State = 2}         -- switch state
	evt.SetDoorState{Id = 21, State = 2}         -- switch state
end

Game.MapEvtLines:RemoveEvent(14)
evt.map[14] = function()
	evt.SetDoorState{Id = 22, State = 2}         -- switch state
	evt.SetDoorState{Id = 23, State = 2}         -- switch state
end

Game.MapEvtLines:RemoveEvent(15)
evt.map[15] = function()
	evt.SetDoorState{Id = 24, State = 0}
	evt.SetDoorState{Id = 25, State = 0}
end

Game.MapEvtLines:RemoveEvent(16)
evt.map[16] = function()
	evt.SetDoorState{Id = 26, State = 2}         -- switch state
	evt.SetDoorState{Id = 27, State = 2}         -- switch state
end

Game.MapEvtLines:RemoveEvent(17)
evt.map[17] = function()
	evt.SetDoorState{Id = 28, State = 2}         -- switch state
	evt.SetDoorState{Id = 29, State = 2}         -- switch state
end

Game.MapEvtLines:RemoveEvent(18)
evt.map[18] = function()
	if evt.Cmp{"MapVar1", Value = 2} then
		evt.SetDoorState{Id = 30, State = 2}         -- switch state
		evt.SetDoorState{Id = 31, State = 2}         -- switch state
	end
end

Game.MapEvtLines:RemoveEvent(21)
evt.map[21] = function()
	if evt.Cmp{"Inventory", Value = 1089} then         -- "_potion/reagent287"
		evt.SetDoorState{Id = 32, State = 2}         -- switch state
		evt.SetDoorState{Id = 33, State = 2}         -- switch state
	end
end

Game.MapEvtLines:RemoveEvent(19)
evt.map[19] = function()
	evt.SetDoorState{Id = 34, State = 2}         -- switch state
	evt.SetDoorState{Id = 35, State = 2}         -- switch state
	evt.SetDoorState{Id = 36, State = 2}         -- switch state
	evt.SetDoorState{Id = 26, State = 1}
	evt.SetDoorState{Id = 27, State = 1}
end

Game.MapEvtLines:RemoveEvent(20)
evt.map[20] = function()
	evt.SetDoorState{Id = 37, State = 2}         -- switch state
	evt.SetDoorState{Id = 38, State = 2}         -- switch state
	evt.SetDoorState{Id = 39, State = 2}         -- switch state
	evt.SetDoorState{Id = 30, State = 1}
	evt.SetDoorState{Id = 31, State = 1}
end

Game.MapEvtLines:RemoveEvent(23)
evt.map[23] = function()
	if not evt.Cmp{"MapVar2", Value = 1} then
		evt.SetDoorState{Id = 40, State = 2}         -- switch state
		evt.Add{"MapVar1", Value = 1}
		evt.Add{"MapVar2", Value = 1}
	end
end

Game.MapEvtLines:RemoveEvent(24)
evt.map[24] = function()
	if not evt.Cmp{"MapVar3", Value = 1} then
		evt.SetDoorState{Id = 41, State = 2}         -- switch state
		evt.Add{"MapVar1", Value = 1}
		evt.Add{"MapVar3", Value = 1}
	end
end

Game.MapEvtLines:RemoveEvent(25)
evt.map[25] = function()
	evt.SetDoorState{Id = 1, State = 2}         -- switch state
	evt.SetDoorState{Id = 2, State = 2}         -- switch state
end

Game.MapEvtLines:RemoveEvent(26)
evt.map[26] = function()
	evt.SetDoorState{Id = 3, State = 2}         -- switch state
	evt.SetDoorState{Id = 4, State = 2}         -- switch state
end

evt.hint[27] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(27)
evt.map[27] = function()
	evt.SetDoorState{Id = 42, State = 2}         -- switch state
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

evt.hint[376] = evt.str[100]  -- ""

evt.hint[377] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(377)
evt.map[377] = function()
	if evt.Cmp{"Inventory", Value = 1463} then         -- "Colony Zod Key"
		evt.Subtract{"Inventory", Value = 1463}         -- "Colony Zod Key"
		evt.SetDoorState{Id = 32, State = 0}
		evt.SetDoorState{Id = 33, State = 0}
	else
		evt.FaceAnimation{-- ERROR: Const not found
Player = "Current", Animation = 18}
		evt.StatusText{Str = 20}         -- "The Door is Locked"
	end
end




--[[ MMMerge additions --]]


Game.MapEvtLines:RemoveEvent(376)
evt.map[376] = function()
	if not evt.ForPlayer("All").Cmp{"Inventory", 1463} and Mouse.Item.Number ~= 1463 then
		evt.ForPlayer(0).Add{"Inventory", 1463}
		evt.SetSprite{20, 1, "0"}
		evt.Add{"QBits", 752}
		evt.SetFacetBit{1, const.FacetBits.Untouchable, true}
		evt.SetFacetBit{1, const.FacetBits.Invisible, true}
	end
	evt.SpeakNPC{626}
end
