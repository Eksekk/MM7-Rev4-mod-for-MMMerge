-- Hermit's Isle

local TileSounds = {
[0] = {[0] = 91, 	[1] = 52},
[6] = {[0] = 90, 	[1] = 51}}

function events.TileSound(t)
	local Grp = TileSounds[Game.CurrentTileBin[Map.TileMap[t.X][t.Y]].TileSet]
	if Grp then
		t.Sound = Grp[t.Run]
	end
end

function events.AfterLoadMap()
	Party.QBits[953] = true	-- DDMapBuff, changed for rev4 for merge
end
