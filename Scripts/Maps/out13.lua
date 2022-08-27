-- Regna

function events.AfterLoadMap()
	Party.QBits[933] = true	-- DDMapBuff, changed for rev4 for merge
end

evt.map[104] = function()
	Party.QBits[304] = true	-- TP Buff Regna
end
