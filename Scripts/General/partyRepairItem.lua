function events.CanRepairItem(t)
	-- NPCs repairing items are handled automatically by the game, we only handle player repairs
	local maxSkill = 0
	for _, player in Party do
		if mem.call(0x491514, 1, player["?ptr"]) ~= 1 then --IsConscious
			goto continue
		end
		local skill, mastery = SplitSkill(player.Skills[const.Skills.Repair])
		if mastery == const.GM then
			maxSkill = 500
			break
		else
			maxSkill = math.max(maxSkill, skill * mastery)
		end
		::continue::
	end
	local required = Game.ItemsTxt[t.Item.Number].IdRepSt
	if maxSkill >= required then
		t.CanRepair = true
	end
end