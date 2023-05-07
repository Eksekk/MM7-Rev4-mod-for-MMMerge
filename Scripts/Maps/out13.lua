-- Regna
local MF = Merge.Functions

function events.AfterLoadMap()
	Party.QBits[933] = true	-- DDMapBuff, changed for rev4 for merge
end

-- Town Portal fountain
evt.map[104] = function()
	Party.QBits[304] = true	-- TP Buff Regna
	MF.SetLastFountain()
end
