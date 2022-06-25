local mmver = Game.Version

local function mmv(...)
	local ret = select(mmver - 5, ...)
	assert(ret ~= nil)
	return ret
end

local isRecursive = false

function events.GetSkill(t)
	if isRecursive or t.Skill ~= const.Skills.IdentifyItem then
		return
	end
	isRecursive = true
	for _, player in Party do
		if mem.call(mmv(nil, 0x492C03, 0x491514), 1, player["?ptr"]) ~= 1 then --IsConscious
			goto continue
		end
		
		local skill, mastery = SplitSkill(player.Skills[const.Skills.IdentifyItem])
		if skill == 0 then
			goto continue
		end
		
		if mastery == const.GM then
			t.Result = JoinSkill(10, const.GM)
			isRecursive = false
			return
		end
		
		local maxBonus = 0
		for item, slot in player:EnumActiveItems(false) do
			if item.Bonus == 20 then -- 20 = identify item
				maxBonus = math.max(maxBonus, item.BonusStrength)
			end
		end
		
		local rs, rm = SplitSkill(t.Result)
		if (math.min(60, skill * mastery + maxBonus) > rs * rm) then
			t.Result = JoinSkill(math.min(60, skill * mastery + maxBonus), const.Novice)
		end
		::continue::
	end
	isRecursive = false
end