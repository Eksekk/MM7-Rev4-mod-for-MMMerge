local vanilla = LoadBasicTextTable("tab\\NPCText vanilla.txt", 0)
local merge = LoadBasicTextTable("tab\\NPCText merge.txt", 0)

local noMappingTexts = {{200, 201}, {205, 205}, {270, 299}, {549, 549}}

--[[for i = 2, #vanilla do
	if merge[i + 938] == nil then break end
	if vanilla[i][2]:gsub("%s", "") ~= merge[i + 938][2]:gsub("%s", "") then
		print(("Found a mismatch at positions %d vanilla, %d merge"):format(tonumber(vanilla[i][1]), tonumber(merge[i + 938][1])))
	end
end--]]

for i = 2, #vanilla do
	if merge[i] == nil then break end
	if vanilla[i][2]:gsub("%s", "") == merge[i][2]:gsub("%s", "") then
		print(("Found a match at positions %d vanilla, %d merge"):format(tonumber(vanilla[i][1]), tonumber(merge[i][1])))
	end
end