local function getMappings(rev4file, mergefile)
	local awardsrev4 = LoadBasicTextTable(rev4file, 1)
	local awardsmerge = LoadBasicTextTable(mergefile, 1)
	
	local function areEntriesSame(e1, e2)
		return e1[2] == e2[2]
	end
	
	local mappingTable = {}
	
	for i = 1, #awardsrev4 do
		local entryrev4 = awardsrev4[i]
		local entrymerge = nil
		for j = 1, #awardsmerge do
			if areEntriesSame(entryrev4, awardsmerge[j]) then
				entrymerge = awardsmerge[j]
				break
			end
		end
		if entrymerge == nil then
			print("Couldn't find merge award for award title \"" .. (entryrev4[2] or "") .. "\".")
		else
			mappingTable[tonumber(entryrev4[1])] = tonumber(entrymerge[1])
		end
	end
	return mappingTable, awardsrev4, awardsmerge
end



local mappingTable, _, newMergeTable = getMappings("tab\\AWARDS rev4.txt", "tab\\Awards merge.txt")

local mappingTableOld, _, oldMergeTable = getMappings("tab\\AWARDS rev4.txt", "tab\\Awards merge 2022.08.02.txt")

local oldToNew = {}
print("differences in old and new awards:")
for rev4, old in pairs(mappingTableOld) do
	local textOld, textNew = (oldMergeTable[old] or {})[2], (newMergeTable[mappingTable[rev4] ] or {})[2]
	assert(textOld == textNew, string.format("Award text doesn't match: %q -> %q", tostring(textOld), tostring(textNew)))
	oldToNew[old] = mappingTable[rev4]
end

mappingTable[102] = 50 -- arcomage champion -> arcomage champion of antagarich
oldToNew[41] = 50 -- arcomage champion

return mappingTable, oldToNew