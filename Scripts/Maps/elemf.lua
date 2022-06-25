-- Plane of Fire

function events.AfterLoadMap()
	Party.QBits[931] = true	-- DDMapBuff, changed for rev4 for merge
	if Party.QBits[1720] and evt.All.Cmp("Inventory", 667) then
		Party.QBits[1721] = true
	end
end
