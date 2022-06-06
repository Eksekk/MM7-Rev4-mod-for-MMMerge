-- intended to be run from editor in Rev4

function persistUpdatedRev4()
	for v, k in pairs(Editor.State.Monsters) do
		v.Id = getMonster(v.Id)
		v.Group = v.Group + 51
		if v.NameId ~= 0 and v.NameId ~= nil then
			v.NameId = getPlacemonId(v.NameId)
		end
		if v.Item ~= 0 and v.Item ~= nil then
			v.Item = getItem(v.Item)
		end
		if v.NPC_ID ~= 0 and v.NPC_ID ~= nil then
			v.NPC_ID = getNPC(v.NPC_ID)
		end
		-- thanks to cthscr for spell skill changing code
		local ConvertMastery = {[0] = 0, [1] = 0, [2] = 0x400, [3] = 0x800, [4] = 0x1000}
		if v.SpellSkill then
			local s, m = SplitSkill(v.SpellSkill)
			v.SpellSkill = s + (ConvertMastery[m] or 0)
		end
		if v.Spell2Skill then
			local s, m = SplitSkill(v.Spell2Skill)
			v.Spell2Skill = s + (ConvertMastery[m] or 0)
		end
		for k2 in pairs(const.Damage) do
			if v[k2 .. "Resistance"] == const.MonsterImmune then
				v[k2 .. "Resistance"] = 65000
			end
		end
	end
	local str = internal.persist(Editor.State.Monsters)
	local file = assert(io.open("Editor.State.Monsters rev4.bin", "wb"), "Cannot open file for writing")
	file:write(str)
	file:close()
end

persistUpdatedRev4()

-- intended to be run in editor from Merge

function unpersistFromRev4()
	local file = assert(io.open("Editor.State.Monsters rev4.bin", "rb"), "Cannot open file for reading")
	local content = file:read("*a")
	file:close()
	Editor.State.Monsters = internal.unpersist(content)
	Editor.StateSync = false
	Editor.ClearUndoStack()
	Editor.NeedStateSync()
end

unpersistFromRev4()

--[[
for v, k in pairs(Editor.State.Monsters) do
	local x, y = math.random(-2500, 2500), math.random(-2500, 2500)
	XYZ(v, Party.X + x, Party.Y + y, v.Z)
end
Editor.NeedStateSync()
--]]