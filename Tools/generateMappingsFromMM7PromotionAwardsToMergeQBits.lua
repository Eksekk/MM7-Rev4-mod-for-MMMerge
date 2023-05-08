local awards = LoadBasicTextTable("tab\\AWARDS rev4.txt", 0)
local quests = LoadBasicTextTable("tab\\Quests merge.txt", 0)

local noteToQBit = {}
for i = 2, #quests do
	noteToQBit[quests[i][3]] = tonumber(quests[i][1])
end

local mappings = {}

for i = 2, #awards do
	if tonumber(awards[i][3]) == 4 -- sort used by promotion awards
	and awards[i][2] ~= "Promoted to Master Courier" then
		local qBit = noteToQBit[awards[i][2]]
		if qBit == nil then
			print(("Couldn't find Merge QBit for award %s"):format(awards[i][2]))
		end
		mappings[i - 1] = qBit
	end
end

for i = 50, 60 do
	-- guild join awards, I know light/dark are used, not sure about others, including them anyways
	mappings[i] = 1596 + (i - 50)
end

return mappings