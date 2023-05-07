-- Alvar
local MF = Merge.Functions

function events.AfterLoadMap()
	Party.QBits[923] = true	-- DDMapBuff, changed for rev4 for merge
end

-- Town Portal fountain
evt.map[104] = function()
	Party.QBits[301] = true	-- TP Buff Alvar
	MF.SetLastFountain()
end
