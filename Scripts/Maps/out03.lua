-- Alvar

function events.AfterLoadMap()
	Party.QBits[923] = true	-- DDMapBuff, changed for rev4 for merge
end

evt.map[104] = function()
	Party.QBits[301] = true	-- TP Buff Alvar
end
