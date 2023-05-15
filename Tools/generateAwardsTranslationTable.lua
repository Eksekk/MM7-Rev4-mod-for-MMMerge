local awardsrev4 = LoadBasicTextTable("tab\\AWARDS rev4.txt", 0)
local awardsmerge = LoadBasicTextTable("tab\\Awards merge.txt", 0)

local function areEntriesSame(e1, e2)
	return e1[2] == e2[2] and e1[3] == e2[3]
end

local mappingTable = {}

for i = 2, #awardsrev4 do
	local entryrev4 = awardsrev4[i]
	local entrymerge = nil
	for j = 2, #awardsmerge do
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

mappingTable[102] = 41 -- arcomage champion

return mappingTable