-- Dagger Wound Island
local MF = Merge.Functions

-- Dimension door
function events.TileSound(t)
	if t.X == 63 and t.Y == 59 then
		TownPortalControls.DimDoorEvent()
	end
end

-- Move [MM8] area one init stuff into AfterLoadMap
Game.MapEvtLines:RemoveEvent(3)

function events.AfterLoadMap()
	if not Party.QBits[226] then	-- game Init stuff in area one
		Party.QBits[226] = true	-- game Init stuff in area one
		Party.QBits[185] = true	-- Blood Drop Town Portal
		Party.QBits[401] = true	-- Roster Character In Party 2
		Party.QBits[407] = true	-- Roster Character In Party 8
		MF.QBitAdd(85)	--[[
			"Find Dadeross, the Minotaur in charge of your merchant caravan.
			When you saw him last, he was going to talk to the village clan leader."
			]]
	end
	Party.QBits[921] = true	-- DDMapBuff, changed for rev4 for merge
end
