local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Exit to the Coding Fortress",
	[3] = "Chest",
	[4] = "Button",
	[5] = "Lever",
	[6] = "Vault",
	[7] = "Cabinet",
	[8] = "Switch",
	[9] = "The Killing Zone",
	[10] = "Bookcase",
	[11] = "Phasing Brazier of Succor ",
	[12] = "Ore Vein",
	[13] = "Cave In !",
	[14] = "You Successfully disarm the trap",
	[15] = "",
	[16] = "Take a Drink",
	[17] = "Not Very Refreshing",
	[18] = "Refreshing",
	[19] = "",
	[20] = "You need a key to unlock this door",
	[21] = "",
	[22] = "",
	[23] = "",
	[24] = "",
	[25] = "Phasing Brazier  of  Succor",
}
table.copy(TXT, evt.str, true)

-- REMOVED BY REV4 FOR MERGE
-- Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.hint[1] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(1)
evt.map[1] = function()  -- function events.LoadMap()
	evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
	if evt.Cmp("MapVar1", 1) then
		evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Untouchable, On = true}
		evt.SetFacetBit{Id = 1, Bit = const.FacetBits.IsWater, On = true}
		evt.SetTexture{Facet = 1, Name = "trim11_16"}
	end
end

events.LoadMap = evt.map[1].last

evt.hint[2] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(2)
evt.map[2] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	if evt.Cmp("QBits", 2030) then         -- Three Use
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 10, X = -4721, Y = -10652, Z = 833, -- ERROR: Not found
NPCGroup = 563, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 10, X = -5159, Y = -10152, Z = 833, -- ERROR: Not found
NPCGroup = 563, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = -4934, Y = -6884, Z = 833, -- ERROR: Not found
NPCGroup = 563, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 10, X = -4268, Y = -3983, Z = 833, -- ERROR: Not found
NPCGroup = 563, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 10, X = -5525, Y = -5947, Z = 833, -- ERROR: Not found
NPCGroup = 563, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = -4606, Y = -1643, Z = 833, -- ERROR: Not found
NPCGroup = 563, unk = 0}
	else
		evt.SetNPCGreeting{NPC = 355, Greeting = 155}         -- "BDJ the Coding Wizard" : "BDJ�s the name, coding wizard�s the Game! And I do trust that you are enjoying the �game�."
		Game.NPC[355].Events[0] = 0         -- "BDJ the Coding Wizard"
		Game.NPC[355].Events[1] = 0         -- "BDJ the Coding Wizard"
		Game.NPC[355].Events[2] = 0         -- "BDJ the Coding Wizard"
		evt.SpeakNPC(355)         -- "BDJ the Coding Wizard"
		evt.Set("QBits", 2030)         -- Three Use
		evt.Subtract("NPCs", 357)         -- "Lord Godwinson"
		Game.NPC[357].Events[1] = 1172         -- "Lord Godwinson" : "Now that's what I call 'fun'!"
		evt.SetMonGroupBit{NPCGroup = 58, Bit = const.MonsterBits.Hostile, On = false}         -- "Group fo M2"
		evt.Subtract("QBits", 2035)         -- 0
	end
end

events.LoadMap = evt.map[2].last

evt.hint[3] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(3)
evt.map[3] = function()
	evt.SetDoorState{Id = 12, State = 2}         -- switch state
end

evt.hint[4] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(4)
evt.map[4] = function()
	evt.SetDoorState{Id = 4, State = 2}         -- switch state
end

evt.hint[5] = evt.str[11]  -- "Phasing Brazier of Succor "
Game.MapEvtLines:RemoveEvent(5)
evt.map[5] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 2045) then         -- 0
		evt.Add("HP", 300)
		evt.Set("QBits", 2045)         -- 0
	end
end

Game.MapEvtLines:RemoveEvent(151)
evt.map[151] = function()  -- Timer(<function>, 2*const.Minute)
	evt.SetDoorState{Id = 9, State = 2}         -- switch state
end

Timer(evt.map[151].last, 2*const.Minute)

Game.MapEvtLines:RemoveEvent(152)
evt.map[152] = function()  -- Timer(<function>, 2.5*const.Minute)
	evt.SetDoorState{Id = 10, State = 2}         -- switch state
end

Timer(evt.map[152].last, 2.5*const.Minute)

Game.MapEvtLines:RemoveEvent(153)
evt.map[153] = function()  -- Timer(<function>, 2*const.Minute)
	evt.SetDoorState{Id = 11, State = 2}         -- switch state
end

Timer(evt.map[153].last, 2*const.Minute)

Game.MapEvtLines:RemoveEvent(154)
evt.map[154] = function()  -- Timer(<function>, 1.5*const.Minute)
	evt.SetDoorState{Id = 1, State = 2}         -- switch state
end

Timer(evt.map[154].last, 1.5*const.Minute)

Game.MapEvtLines:RemoveEvent(155)
evt.map[155] = function()  -- Timer(<function>, 2*const.Minute)
	evt.SetDoorState{Id = 2, State = 2}         -- switch state
end

Timer(evt.map[155].last, 2*const.Minute)

Game.MapEvtLines:RemoveEvent(156)
evt.map[156] = function()  -- Timer(<function>, 1*const.Minute)
	evt.SetDoorState{Id = 3, State = 2}         -- switch state
end

Timer(evt.map[156].last, 1*const.Minute)

Game.MapEvtLines:RemoveEvent(157)
evt.map[157] = function()
	evt.MoveToMap{X = -5248, Y = -7552, Z = 768, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

Game.MapEvtLines:RemoveEvent(158)
evt.map[158] = function()
	evt.MoveToMap{X = -4640, Y = -7901, Z = 768, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

Game.MapEvtLines:RemoveEvent(159)
evt.map[159] = function()
	evt.MoveToMap{X = -5248, Y = -8320, Z = 768, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

Game.MapEvtLines:RemoveEvent(160)
evt.map[160] = function()
	evt.MoveToMap{X = -6912, Y = 14592, Z = -576, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

Game.MapEvtLines:RemoveEvent(161)
evt.map[161] = function()
	evt.SetDoorState{Id = 8, State = 2}         -- switch state
	evt.Set("MapVar1", 1)
	evt.Add("MapVar2", 1)
	evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Untouchable, On = true}
	evt.SetFacetBit{Id = 1, Bit = const.FacetBits.IsWater, On = true}
	evt.SetTexture{Facet = 1, Name = "trim11_16"}
end

Game.MapEvtLines:RemoveEvent(162)
evt.map[162] = function()
	if evt.Cmp("MapVar1", 1) then
		evt.MoveToMap{X = 2353, Y = 6856, Z = 288, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	end
end

Game.MapEvtLines:RemoveEvent(163)
evt.map[163] = function()
	local i
	if evt.Cmp("MapVar1", 1) then
		i = Game.Rand() % 3
		if i == 1 then
			evt.MoveToMap{X = 256, Y = -128, Z = 1, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
		elseif i == 2 then
			evt.MoveToMap{X = -10624, Y = 2304, Z = -832, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
		else
			evt.MoveToMap{X = -4096, Y = -10624, Z = 832, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
		end
	end
end

Game.MapEvtLines:RemoveEvent(164)
evt.map[164] = function()
	if evt.Cmp("MapVar1", 1) then
		evt.MoveToMap{X = 6016, Y = 6528, Z = 1528, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	end
end

Game.MapEvtLines:RemoveEvent(165)
evt.map[165] = function()
	evt.MoveToMap{X = 2816, Y = 7552, Z = 288, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[176] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(176)
evt.map[176] = function()
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

evt.hint[196] = evt.str[12]  -- "Ore Vein"
Game.MapEvtLines:RemoveEvent(196)
evt.map[196] = function()
	local i
	if evt.Cmp("MapVar14", 1) then
		return
	end
	i = Game.Rand() % 6
	if i == 3 then
		evt.Add("Inventory", 1489)         -- "Siertal-laced ore"
		goto _9
	elseif i == 4 then
		evt.DamagePlayer{Player = "All", DamageType = const.Damage.Fire, Damage = 50}
		evt.StatusText(13)         -- "Cave In !"
		goto _8
	elseif i == 5 then
		goto _8
	end
	evt.Add("Inventory", 1488)         -- "Iron-laced ore"
::_9::
	evt.Set("MapVar14", 1)
	evt.SetTexture{Facet = 2, Name = "cwb1"}
	do return end
::_8::
	evt.Add("Inventory", 1490)         -- "Phylt-laced ore"
	goto _9
end

function events.LoadMap()
	if evt.Cmp("MapVar14", 1) then
		evt.SetTexture{Facet = 2, Name = "cwb1"}
	end
end

evt.hint[197] = evt.str[12]  -- "Ore Vein"
Game.MapEvtLines:RemoveEvent(197)
evt.map[197] = function()
	local i
	if evt.Cmp("MapVar15", 1) then
		return
	end
	i = Game.Rand() % 6
	if i == 3 then
		evt.Add("Inventory", 1489)         -- "Siertal-laced ore"
		goto _9
	elseif i == 4 then
		evt.DamagePlayer{Player = "All", DamageType = const.Damage.Fire, Damage = 50}
		evt.StatusText(13)         -- "Cave In !"
		goto _8
	elseif i == 5 then
		goto _8
	end
	evt.Add("Inventory", 1488)         -- "Iron-laced ore"
::_9::
	evt.Set("MapVar15", 1)
	evt.SetTexture{Facet = 3, Name = "cwb1"}
	do return end
::_8::
	evt.Add("Inventory", 1490)         -- "Phylt-laced ore"
	goto _9
end

function events.LoadMap()
	if evt.Cmp("MapVar15", 1) then
		evt.SetTexture{Facet = 3, Name = "cwb1"}
	end
end

evt.hint[376] = evt.str[1]  -- "Door"
Game.MapEvtLines:RemoveEvent(376)
evt.map[376] = function()
	evt.ForPlayer("All")
	if evt.Cmp("QBits", 2031) then         -- Four Use
		goto _22
	end
	evt.Set("QBits", 2031)         -- Four Use
::_3::
	evt.Subtract("Inventory", 223)         -- "Magic Potion"
	if evt.Cmp("Inventory", 223) then         -- "Magic Potion"
		goto _3
	end
::_5::
	for _, scroll in ipairs({332, 1134, 1834}) do
		while evt.Cmp("Inventory", scroll) do
			evt.Subtract("Inventory", scroll)
		end
	end
	evt.SetNPCGreeting{NPC = 355, Greeting = 165}         --[[ "BDJ the Coding Wizard" : "I see you�ve found the key to the Coding Fortress. Well done! You�ve probably had a few elemental �misunderstandings� in findings this key, but I assure you that they were minor disputes compared to what you now face.

It�s finally time to �run the Gauntlet� all the way back to the beginning!  Good luck!!" ]]
	Game.NPC[355].Events[0] = 0         -- "BDJ the Coding Wizard"
	Game.NPC[355].Events[1] = 0         -- "BDJ the Coding Wizard"
	Game.NPC[355].Events[2] = 0         -- "BDJ the Coding Wizard"
	evt.SpeakNPC(355)         -- "BDJ the Coding Wizard"
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = -4176, Y = -10981, Z = 833, -- ERROR: Not found
NPCGroup = 563, unk = 0}
	evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = -4824, Y = -9884, Z = 833, -- ERROR: Not found
NPCGroup = 563, unk = 0}
	evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 5, X = -4996, Y = -3556, Z = 780, -- ERROR: Not found
NPCGroup = 563, unk = 0}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = -4992, Y = -2175, Z = 780, -- ERROR: Not found
NPCGroup = 563, unk = 0}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = 12012, Y = 3590, Z = 200, -- ERROR: Not found
NPCGroup = 563, unk = 0}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 8, X = 10588, Y = 2888, Z = 0, -- ERROR: Not found
NPCGroup = 563, unk = 0}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 8, X = 10084, Y = 2258, Z = 0, -- ERROR: Not found
NPCGroup = 563, unk = 0}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = 7932, Y = 2156, Z = 144, -- ERROR: Not found
NPCGroup = 563, unk = 0}
	evt.ForPlayer("Current")
	evt.Add("Inventory", 962)         -- "Coding Fortress Key"
::_22::
	for pl = 0, Party.High do
		evt.ForPlayer(pl)
		if evt.Cmp("FireSkill", 1) then
			evt.Set("SP", 0)
		end
	end
	evt.SetMonGroupBit{NPCGroup = 66, Bit = const.MonsterBits.Hostile, On = true}         -- "Group walkers in the Tularean forest"
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 8, X = -668, Y = 6965, Z = -384, -- ERROR: Not found
	NPCGroup = 563, unk = 0}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 5, X = -4721, Y = -10652, Z = 833, -- ERROR: Not found
	NPCGroup = 563, unk = 0}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 5, X = -5159, Y = -10152, Z = 833, -- ERROR: Not found
	NPCGroup = 563, unk = 0}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = -4934, Y = -6884, Z = 833, -- ERROR: Not found
	NPCGroup = 563, unk = 0}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 5, X = -4268, Y = -3983, Z = 833, -- ERROR: Not found
	NPCGroup = 563, unk = 0}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 5, X = -5525, Y = -5947, Z = 833, -- ERROR: Not found
	NPCGroup = 563, unk = 0}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = -4606, Y = -1643, Z = 833, -- ERROR: Not found
	NPCGroup = 563, unk = 0}
	evt.Subtract("QBits", 2045)         -- 0
end

evt.hint[501] = evt.str[9]  -- "The Killing Zone"
Game.MapEvtLines:RemoveEvent(501)
evt.map[501] = function()
	evt.MoveToMap{X = -10624, Y = 2304, Z = -832, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[502] = evt.str[2]  -- "Exit to the Coding Fortress"
Game.MapEvtLines:RemoveEvent(502)
evt.map[502] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 962) then         -- "Coding Fortress Key"
		evt.MoveToMap{X = 0, Y = -709, Z = 1, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 395, Icon = 9, Name = "7D12.blv"}         -- "Clanker's Laboratory"
	else
		evt.CastSpell{Spell = 1, Mastery = const.GM, Skill = 10, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Torch Light"
		evt.StatusText(20)         -- "You need a key to unlock this door"
	end
end