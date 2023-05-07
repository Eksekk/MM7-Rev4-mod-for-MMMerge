-- Ravenshore
local MF = Merge.Functions

function events.AfterLoadMap()
	Party.QBits[922] = true	-- DDMapBuff, changed for rev4 for merge
end

-- Town Portal fountain
evt.map[104] = function()
	Party.QBits[302] = true	-- TP Buff Ravenshore
	MF.SetLastFountain()
end

-- Final part of Cross continents quest
local QSet = vars.Quest_CrossContinents
if QSet and QSet.GotFinalQuest then

	function events.CanCastTownPortal(t)
		if 600 > math.sqrt((15103-Party.X)^2 + (-9759-Party.Y)^2) then
			t.CanCast = false
			evt.MoveToMap{0,0,0,0,0,0,0,0, QSet.QuestFinished and "Breach.odm" or "BrAlvar.odm"}
		end
	end

end

function events.BeforeLoadMap()
	if vars.Quest_CrossContinents and Party.QBits[56] then
		vars.Quest_CrossContinents.ContinentFinished[1] = true
	end
end
