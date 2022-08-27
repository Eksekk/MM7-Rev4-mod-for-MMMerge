local TXT = Localize{
	[0] = " ",
	[1] = "",
	[2] = "",
	[3] = "",
	[4] = "",
	[5] = "",
	[6] = "",
	[7] = "",
	[8] = "",
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
}
table.copy(TXT, evt.str, true)



evt.hint[1] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(1)
evt.map[1] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 876) then         -- 0
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 10, X = -3290, Y = 2529, Z = -96, -- ERROR: Not found
NPCGroup = 563, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 2, X = -3328, Y = 2529, Z = -96, -- ERROR: Not found
NPCGroup = 563, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 6, X = -3290, Y = 2389, Z = -96, -- ERROR: Not found
NPCGroup = 563, unk = 0}
	elseif evt.Cmp("QBits", 877) then         -- 0
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 10, X = -3290, Y = 2529, Z = -96, -- ERROR: Not found
NPCGroup = 563, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 2, X = -3328, Y = 2529, Z = -96, -- ERROR: Not found
NPCGroup = 563, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 6, X = -3290, Y = 2389, Z = -96, -- ERROR: Not found
NPCGroup = 563, unk = 0}
	else
		evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Invisible, On = false}         -- "Generic Monster Group for Dungeons"
	end
end

events.LoadMap = evt.map[1].last

evt.hint[101] = evt.str[1]  -- ""
Game.MapEvtLines:RemoveEvent(101)
evt.map[101] = function()
	if evt.Cmp("QBits", 876) then         -- 0
		evt.MoveToMap{X = -13812, Y = 16974, Z = 6656, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "out12.odm"}
	elseif evt.Cmp("QBits", 877) then         -- 0
		evt.MoveToMap{X = -7747, Y = 15880, Z = 6977, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "out12.odm"}
	else
		evt.MoveToMap{X = 13839, Y = 16367, Z = 169, Direction = 1, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 4, Name = "7Out01.Odm"}
	end
end

Game.MapEvtLines:RemoveEvent(201)
evt.map[201] = function()
	if not evt.Cmp("MapVar0", 1) then
		evt.Add("Inventory", 845)         -- "Recurve Bow"
		evt.Set("MapVar0", 1)
	end
end

Game.MapEvtLines:RemoveEvent(202)
evt.map[202] = function()
	if not evt.Cmp("MapVar1", 1) then
		evt.Add("Inventory", 1460)         -- "Contestant's Shield"
		evt.Set("MapVar1", 1)
	end
end



--[[ MMMerge additions ]]--

-- The Dragon's Lair

function events.LoadMap()
	Log(Merge.Log.Info, "7d28: LoadMap")
	--Map.Monsters[0].NameId = 113	-- Morcarack
end
