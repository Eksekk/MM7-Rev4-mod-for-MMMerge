local npctopic = LoadBasicTextTable("tab\\NPCTopic.txt", 0)

local lastID = tonumber(npctopic[#npctopic][1])

while lastID < 2050 do
	lastID = lastID + 1
	table.insert(npctopic, {})
	for j = 1, 7 do
		table.insert(npctopic[#npctopic], "")
	end
	npctopic[#npctopic][1] = tostring(lastID)
end

WriteBasicTextTable(npctopic, "tab\\NPCTopic.txt")