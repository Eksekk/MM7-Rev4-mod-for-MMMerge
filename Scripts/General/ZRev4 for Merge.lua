if Merge.ModSettings.Rev4ForMergeDuplicateModdedDungeons == 1 then
	-- Temple in a bottle
	evt.UseItemEffects[1452] = function(Target, Item, PlayerId)
		ExitCurrentScreen(false, true)
		evt.MoveToMap{0,0,0,0,0,0,0,0,"7nwcorig.blv"}
		return 0
	end
end