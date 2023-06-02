-- this script processes rev4 npc table for copy pasting into mmmerge table after fixing 2d locations
function rev4m.npcData()
	_G.t = LoadBasicTextTable("tab\\NPCData rev4.txt", 0)
	local npcdataRev4Limit = 463

	--[[ FINDING PICTURE MAPPINGS ]]--
	local pictureMappings = {}

	local rev4pics, mergepics = {}, {}

	for i in path.find("npc pictures rev4\\*.bmp") do
		local file = io.open(i)
		local content = file:read("*a")
		
		local name = path.setext(path.name(i), ""):sub(4)
		local j = 1
		while j < #name and name:sub(j, j) == "0" do
			j = j + 1
		end
		j = j - 1
		name = name:sub(j + 1)
		rev4pics[content] = rev4pics[content] or {}
		table.insert(rev4pics[content], name)
		io.close(file)
	end

	for i in path.find("npc pictures merge\\*.bmp") do
		local file = io.open(i)
		local content = file:read("*a")
		mergepics[content] = path.setext(path.name(i), ""):sub(4)
		io.close(file)
	end

	local skips = {}
	skips["116"] = true -- because it has assigned "0" picture in merge, idk why

	for i = 3, npcdataRev4Limit do
		local npcPicContent = nil
		local rev4name = t[i][3]
		if rev4name == "0" or skips[rev4name] ~= nil then
			goto continue
		end
		for content, names in pairs(rev4pics) do
			local index = table.find(names, rev4name)
			if index ~= nil then
				npcPicContent = content
				break
			end
		end
		if npcPicContent == nil then
			print("Couldn't find picture for name " .. rev4name)
			break
		end
		
		local mergename = mergepics[npcPicContent]
		
		if mergename == nil then
			print("Couldn't find merge picture for name " .. rev4name)
			break
		end
		
		--print("Found a pair: ", rev4name, mergename)
		pictureMappings[rev4name] = mergename
		::continue::
	end

	--[[ PROCESSING THE TABLE ]]--

	local counterAdd = 339 -- MM7 entries in Merge start at 340
	local greetingAdd = 115 -- MM7 entries in Merge start at 116

	local counterFromThisMovedToEnd = 447
	local firstCounterEntryAfterMM6InMerge = 1270 -- that we will use

	--[[local newRev4NPCs = 15
	-- need to add additional 15 columns, as there are 15 new npcs in rev4
	for i = 1, newRev4NPCs do
		t[#t] = t[#t - 1]
	end]]

	-- events
	local eventAdd = 750 -- MM7 entries in global.lua start at 751
	local additionalRev4Events = 3 -- there are so little because most of them replace old ones (for example malwick's code, brent filiant's red potion exchange code)
	local noMappingEvents = {{501, 506}, {513, 515}} -- for some reason these events from MM7 are put in the middle of MM8 events and require no numeric change
	local MM6EventsStart = 1314
	local firstGlobalLuaFreeEntry = 2000

	local drev4 = LoadBasicTextTable("tab\\2DEvents rev4.txt", 0)
	local dmerge = LoadBasicTextTable("tab\\2DEvents merge.txt", 0)

	local rev4names = {}
	local mergeids = {}

	for i = 3, #drev4 do
		rev4names[tonumber(drev4[i][1]) or -1] = drev4[i][6]
	end

	for i = 3, #dmerge do
		if dmerge[i][6] ~= nil then
			mergeids[dmerge[i][6]] = mergeids[dmerge[i][6]] or {}
			table.insert(mergeids[dmerge[i][6]], tonumber(dmerge[i][1]))
		end
	end

	local noMappingEvents = {{501, 506}, {513, 515}} -- for some reason these events from MM7 are put in the middle of MM8 events and require no numeric change
	local lastOriginalMM7Event = 572
	local lastOriginalMM8Event = 750
	local firstOriginalMM6Event = 1314

	-- fix string instead of event
	t[450][18] = t[450][17]
	t[450][17] = t[450][16]
	t[450][16] = "0"

	for i = 3, npcdataRev4Limit do
		-- index
		if tonumber(t[i][1]) < counterFromThisMovedToEnd then
			t[i][1] = tostring(tonumber(t[i][1]) + counterAdd)
		else
			local index = tonumber(t[i][1]) - counterFromThisMovedToEnd
			t[i][1] = tostring(firstCounterEntryAfterMM6InMerge + index)
		end
		-- picture
		t[i][3] = tostring(pictureMappings[t[i][3]])
		
		-- 2d location
		if t[i][7] ~= "0" and t[i][7] ~= "" then
			t[i][7] = tostring(getHouseID(tonumber(t[i][7]) or ""))
		end
		
		-- greeting
		if t[1][9] ~= "0" then
			t[i][9] = tostring(getGreeting(tonumber(t[i][9])))
		end
		-- events
		local eventBase = 11
		for j = 0, 5 do
			local event = tonumber(t[i][eventBase + j])
			if event == nil then goto continue2 end -- for npc entry 448 (450 in lua), which has "Expert Body_Magic (3)" in his event #F field for some reason
			if event == 0 then goto continue2 end -- skipping unassigned events
			local isNoMapping = false
			for _, t in pairs(noMappingEvents) do
				if event >= t[1] and event <= t[2] then
					isNoMapping = true
					break
				end
			end
			if not isNoMapping then
				if event >= 573 then -- is additional Rev4 event
					t[i][eventBase + j] = tostring(firstGlobalLuaFreeEntry + (event - 573))
				elseif event > noMappingEvents[1][1] then
					local add = 750
					local k = 1
					while k <= #noMappingEvents and event > noMappingEvents[k][2] do
						add = add - (noMappingEvents[k][2] - noMappingEvents[k][1] + 1)
						k = k + 1
					end
					t[i][eventBase + j] = tostring(event + add)
					--t[i][eventBase + j] = tostring(event + 750 - (515 - 513 + 1) - (506 - 501 + 1))
				--[[elseif event > noMappingEvents[1][2] then
					t[i][eventBase + j] = tostring(event + 750 - (506 - 501 + 1))]]
				-- skill teaching events
				elseif event >= 200 and event <= 262 then
					t[i][eventBase + j] = tostring(event + (300 - 200))
				elseif event >= 263 and event <= 280 then
					t[i][eventBase + j] = tostring(event + (372 - 263))
				elseif event >= 287 and event <= 310 then
					t[i][eventBase + j] = tostring(event + (393 - 287))
				else
					t[i][eventBase + j] = tostring(event + eventAdd)
				end
			end
			::continue2::
		end
	end

	-- Harmondale Teleportal Hub
	local newNpcLocation = 464
	local row = t[newNpcLocation]
	local index = tonumber(row[1]) - counterFromThisMovedToEnd
	row[1] = tostring(firstCounterEntryAfterMM6InMerge + index) -- counter
	row[2] = "Harmondale Teleportal Hub" -- name
	row[3] = "1561" -- pic
	row[7] = 925 -- 2d location
	row[9] = 368 -- greeting
	local newNpcLocation = 465
	local row = t[newNpcLocation]
	local index = tonumber(row[1]) - counterFromThisMovedToEnd
	row[1] = tostring(firstCounterEntryAfterMM6InMerge + index) -- counter
	row[2] = "Bradley Clark" -- name
	row[3] = "0595" -- pic

	-- Halfgild Wynac
	--[[local halfgildId = 49
	local row = t[halfgildId + 2]
	assert(row[2] == "Halfgild Wynac", "Error while parsing NPC data: trying to modify Halfgild Wynac, but used wrong row")

	-- 2d location
	row[7] = 1073

	-- greeting
	row[9] = 369
	--]]

	-- remove coding wizard event
	t[458][11] = "0"

	local merge = LoadBasicTextTable("tab\\NPCData merge.txt", 0)

	local Boob = table.copy(t[500])
	for i = 3, #t do
		if t[i][2] == "Boob" then break end
		local id = tonumber(t[i][1])
		while #merge < id + 2 do
			local temp = table.copy(Boob)
			temp[1] = tostring(#merge - 2 + 1)
			table.insert(merge, temp)
		end
		merge[id + 2] = table.copy(t[i])
	end
	WriteBasicTextTable(merge, "NPCDATA processed.txt")

	--[[local revamp = LoadBasicTextTable("tab\\NPCData revamp.txt", 0)
	local merge = LoadBasicTextTable("tab\\NPCData merge.txt", 0)

	local changedEntries = {17, 19, 42, 44, 45, 61, 63}

	for i, entry in ipairs(changedEntries) do
		for i2, v2 in ipairs(revamp[entry]) do
			merge[entry][i2] = revamp[entry][i2]
		end
	end

	WriteBasicTextTable(merge, "NPCDATA merge.txt")--]]
end