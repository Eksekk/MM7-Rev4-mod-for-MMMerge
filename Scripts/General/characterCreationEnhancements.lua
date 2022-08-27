-- reset stats to default
local DEFAULT_FREE_POINTS = 15

function resetStatsToDefault()
	local pl = Party[0]
	local race = GetRace(pl)
	local statsData = Game.Classes.StartingStats[race]
	
	for stat = 0, 6 do
		pl[Game.StatsNames[stat] .. "Base"] = statsData[stat].Base
	end
	
	assert(mem.call(0x48FA68) == DEFAULT_FREE_POINTS, "Invalid stat reset")
	mem.call(0x4C681A, 0, mem.u4[0x51E330 + 0x8])
end