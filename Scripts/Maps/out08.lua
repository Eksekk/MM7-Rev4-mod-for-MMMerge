-- Ravage Roaming
local MF, MM = Merge.Functions, Merge.ModSettings

function events.AfterLoadMap()
	Party.QBits[928] = true	-- DDMapBuff, changed for rev4 for merge
	if MF.GtSettingNum(MM.MM8EnableTier1Promo, 0) then
		if Party.QBits[291] then
			evt.SetSprite(-269, 1, "swrdstx")
		else
			evt.SetSprite(-269, 1, "0")
		end
	end
end

evt.map[451] = function()
	if Party.QBits[291] then return end
	if Party.QBits[290] and evt.Cmp("CurrentMight", 50) then
		Party.QBits[291] = true
		evt.Add("Inventory", 544)
		evt.SetSprite(-269, 1, "swrdstx")
	else
		Game.ShowStatusText("The Sword won't budge!")
	end
end
