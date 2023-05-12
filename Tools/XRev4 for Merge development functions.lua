function getQuestBit(questBit)
	return questBit + 512
end

function getNPC(npc)
	-- entries from 447 onwards are added at the end due to lack of space
	local npcAdd = 339
	if npc >= 447 then
		npcAdd = 1270 - 447
	end
	return npc + npcAdd
end

function getMessage(message)
	local noMappingTexts = {{200, 201}, {205, 205}, {270, 299}, {549, 549}}
	local isNoMapping = false
	for _, t in ipairs(noMappingTexts) do
		if message >= t[1] and message <= t[2] then
			isNoMapping = true
			break
		end
	end
	if isNoMapping then
		return message
	end
	if message >= 768 then -- new rev4 message
		return message + (2850 - 768)
	end
	local add = 938
	local i = 1
	while i <= #noMappingTexts and message > noMappingTexts[i][2] do
		add = add - (noMappingTexts[i][2] - noMappingTexts[i][1] + 1)
		i = i + 1
	end
	return message + add
end

function getGlobalEvent(event)
	if event == 0 then return 0 end
	local eventAdd = 750
	if event >= 573 then
		eventAdd = rev4m.const.firstGlobalLuaFreeEntry - 573
	-- skill teaching events
	-- blaster
	elseif event >= 221 and event <= 223 then
		eventAdd = 971 - 221
	elseif event >= 200 and event <= 262 then
		eventAdd = 300 - 200
	elseif event >= 263 and event <= 280 then
		eventAdd = 372 - 263
	elseif event >= 287 and event <= 310 then
		eventAdd = 393 - 287
	else
		local noMappingEvents = {{501, 506}, {513, 515}}
		local i = 1
		while i <= #noMappingEvents and event > noMappingEvents[i][2] do
			eventAdd = eventAdd - (noMappingEvents[i][2] - noMappingEvents[i][1] + 1)
			i = i + 1
		end
	end
	return event + eventAdd
end

function getAward(award)
	local translationTableFromRev4ToMerge = -- generated with generateAwardsTranslationTable
	-- awards.txt in merge is a shitshow (interspersed MM7/MM8 awards), that's why I'm using a translation table
	{
		[4] = 3, [101] = 55, [5] = 4, [80] = 24, [32] = 127, [110] = 135, [81] = 25, [7] = 119, [33] = 128, [100] = 53, [14] = 122, [82] = 26, [92] = 30, [111] = 105, [83] = 27, [9] = 121, [15] = 123, [93] = 32, [94] = 34, [46] = 6, [84] = 28, [26] = 126, [47] = 19, [95] = 38, [96] = 39, [107] = 132, [97] = 40, [98] = 51, [87] = 129, [99] = 52, [48] = 21, [106] = 131, [49] = 22, [109] = 134, [113] = 105, [115] = 105, [114] = 105, [112] = 105, [102] = 41, [108] = 133, [105] = 130, [21] = 125, [3] = 2, [6] = 118, [2] = 1, [61] = 23, [8] = 120, [20] = 124
	}
	if translationTableFromRev4ToMerge[award] ~= nil then
		return translationTableFromRev4ToMerge[award]
	else
		--print("Couldn't find award in merge for number " .. award)
		return -1 -- delete this entry, as promoted awards apparently are not in Merge
	end
end

function getGreeting(greeting)
	if greeting == 0 then return 0 end
	local greetingAdd = 115
	if greeting >= 195 then
		greetingAdd = 356 - 195
	end
	return greeting + greetingAdd
end

function getItem(item)
	if item >= 220 and item <= 271 then -- potions
		return item
	end
	return item + 802
end

function getNpcGroup(npcgroup)
	return npcgroup + 51
end

local drev4 = LoadBasicTextTable("tab\\2DEvents rev4.txt", 0)
local dmerge = LoadBasicTextTable("tab\\2DEvents merge.txt", 0)

local rev4names = {}
local mergeids = {}

for i = 3, #drev4 do
	rev4names[tonumber(drev4[i][1]) or -1] = drev4[i][6] -- or -1 is because there is empty line at the end...
end

for i = 3, #dmerge do
	if dmerge[i][6] ~= nil then
		mergeids[dmerge[i][6]] = mergeids[dmerge[i][6]] or {}
		table.insert(mergeids[dmerge[i][6]], tonumber(dmerge[i][1]))
	end
end

function getHouseID(houseid)
	if houseid == 0 then return 0 end
	if houseid == nil or houseid == "" then return "" end
	local overrideMappings =
	{
		[428] = 1065, [427] = 1064, [426] = 1063, [425] = 1062, [423] = 1060, [432] = 1069, [431] = 1068, [434] = 1071, [433] = 1070, [444] = 1081 , [442] = 1079, [441] = 1078, [439] = 1076, [438] = 1075, [174] = 1169, [176] = 217, [178] = 218, [421] = 216, [184] = 221, [180] = 219, [182] = 220,
		[189] = 1165, [79] = 315, [80] = 316, [78] = 314, [81] = 317, [413] = 1051, [367] = 1005, [485] = 1121, [495] = 1131, [504] = 1140, [477] = 1113, [480] = 1116, [333] = 971,
		[405] = 1043, [368] = 1006, [469] = 1105, [435] = 1072, [408] = 1046, [453] = 1089, [443] = 1080, [440] = 1077, [74] = 310, [190] = 1166, [188] = 1164, [226] = 1172, [324] = 962,
		[345] = 983, [21] = 54, [37] = 92, [133] = 291, [280] = 380, [281] = 381, [191] = 387, [173] = 382, [193] = 390, [217] = 414
	}
	if overrideMappings[houseid] ~= nil then
		return overrideMappings[houseid]
	end
	local rev4name = rev4names[houseid]
	if rev4name == nil then
		print("Couldn't find rev4name for 2d location " .. houseid)
		return -1
	end
	local mergeid = mergeids[rev4name]
	if rev4name:lower():find("guild") ~= nil and type(mergeid) == "table" and #mergeid > 1 then
		-- magic guilds, look by proprieter name in addition to name
		for _, id in ipairs(mergeid) do
			local proprieterName = dmerge[id + 2][7]
			if proprieterName == drev4[houseid + 2][7] then
				return id
			end
		end
	end
	if mergeid == nil then
		print(("Couldn't find merge ids table for 2d location %d (name: %s)"):format(houseid, rev4name))
		return -1
	elseif #mergeid > 1 then
		print(("Found multiple merge locations for 2d location %d (name: %s)"):format(houseid, rev4name))
		print("The locations:")
		for k, v in ipairs(mergeid) do
			print(v)
		end
		if rev4name == "" then return mergeid[1] end -- shouldn't cause any problems, as empty houses are not used
		return -1
	end
	return mergeid[1]
end

function getAutonote(autonote)
	local autonoteAdd = 256
	if autonote <= 52 then
		
	elseif autonote >= 114 then
		autonoteAdd = 309 - 114
	else
		print("This shouldn't ever happen")
	end
	return autonote + autonoteAdd
end

function getFileName(name)
	local name2 = name
	local name = name:lower()
	if name:sub(1, 1) == "d" then -- dungeon
		local m = tonumber(name:match("%d+"), 10)
		if m >= 5 then
			name2 = "7" .. name2
		end
	elseif name:sub(1, 3) == "nwc" then
		name2 = "7" .. name
	elseif name:sub(1, 3) == "out" then
		local m = tonumber(name:match("%d+"), 10)
		if m <= 6 or m == 13 or m == 15 then
			name2 = "7" .. name2
		end
	end
	return name2
end

function getMonster(monster)
	return monster + 198
end

--[[
local t = {}
for i = 1, 67 do
	local row = {}
	table.insert(row, 2755 + i)
	for j = 1, 3 do
		table.insert(row, "")
	end
	table.insert(t, row)
end
WriteBasicTextTable(t, "temp.txt")
--]]

--[[local rev4 = LoadBasicTextTable("tab\\Placemon rev4.txt", 0)
local merge = LoadBasicTextTable("tab\\Placemon merge.txt", 0)
local placemonMappings = {}

local mapIdsToNamesMerge = {}
for i = 2, #merge do
	local row = merge[i]
	if row[2] == nil then print (row[1]) end
	mapIdsToNamesMerge[row[2] ] = tonumber(row[1])
end

for i = 2, #rev4 do
	local row = rev4[i]
	local name = row[2]
	if mapIdsToNamesMerge[name] == nil then
		print(("Couldn't find placemon entry in Merge for %s (id: %d)"):format(name, i))
		goto continue
	end
	placemonMappings[tonumber(row[1])] = mapIdsToNamesMerge[name]
	::continue::
end--]]

--[[for i = 2, #rev4 do
	local row = rev4[i]
	local name = row[2]
	print(name, merge[placemonMappings[tonumber(row[1])] + 1][2])
end]]--

function getPlacemonId(id)
	return assert(placemonMappings[id], "Invalid placemon id: " .. id)
end

function getDDMapBuff(buff)
	local add = 921 - 801 -- 120
	return buff + add
end

function kill()
	for k, v in Map.Monsters do
		if v.Hostile then
			v.HP = 0
		end
	end
end

_G.g = getItem

GameState_Quests = {}
GameState_NPCs = {}
--[[tempq = {}
	for k, v in Party.QBits do
		if type(v) ~= "function" and type(v) ~= "userdata" then
			tempq[k] = v
		end
	end
	local file = assert(io.open("GameDataQuests.bin", "wb"))
	local str = internal.persist(tempq)
	file:write(str)
	file:close()
	
	tempn = {}
	local function dumpbasic(t)
		local temp = {}
		local meta = getmetatable(t)
		if meta and meta.__call and type(meta.__call) == "function" then
			for k, v in t do
				if type(v) == "table" then
					temp[k] = dumpbasic(v)
				elseif type(v) ~= "function" and type(v) ~= "userdata" then
					temp[k] = v
				end
			end
		else
			for k, v in pairs(t) do
				if type(v) == "table" then
					temp[k] = dumpbasic(v)
				elseif type(v) ~= "function" and type(v) ~= "userdata" then
					temp[k] = v
				end
			end
		end
		if meta.members ~= nil then
			for k in pairs(meta.members) do
				local v = t[k]
				if type(v) == "table" then
					temp[k] = dumpbasic(v)
				elseif type(v) ~= "function" and type(v) ~= "userdata" then
					temp[k] = v
				end
			end
		end
		return temp
	end
	tempn = dumpbasic(Game.NPC)
	--print(dump(tempn, 3, true))
	local file = assert(io.open("GameDataNPCs.bin", "wb"))
	file:write((internal.persist(tempn)))
	file:close()
--]]

function loadGameState()
	local fileq = assert(io.open("GameDataQuests.bin", "rb"))
	GameState_Quests = internal.unpersist(fileq:read("*a"))
	local filen = assert(io.open("GameDataNPCs.bin", "rb"))
	GameState_NPCs = internal.unpersist(filen:read("*a"))
	--dump(GameState_Quests, 1, true)
	--dump(GameState_NPCs, 3, true)
	if #GameState_Quests == 0 or #GameState_NPCs == 0 then
		print("Can't restore game state, need to fill out the tables first")
		return
	end
	for i, v in ipairs(GameState_Quests) do
		Party.QBits[getQuestBit(i)] = v
	end
	for i, v in ipairs(GameState_NPCs) do
		if i >= 462 then break end
		Game.NPC[getNPC(i)].Greet = getGreeting(v.Greet)
		local indexes = {[0] = "A", "B", "C", "D", "E", "F"}
		for j = 0, 5 do
			Game.NPC[getNPC(i)]["Event" .. indexes[j] ] = getGlobalEvent(v["Event" .. indexes[j] ])
		end
	end
end

local mapIdsToItemNames = {}

for i, entry in Game.ItemsTxt do
	mapIdsToItemNames[entry.Name:lower()] = i
end

function item(id)
	evt.GiveItem{Id = mapIdsToItemNames[id] or id}
end

function increaseSpawnsInMapstats(infile, outfile, s, e, howMuch)
	local t = LoadBasicTextTable(infile, 0)
	for i = s, e do
		local index = i + 3
		local row = t[index]
		for j = 20, 28, 4 do
			local min, max = row[j]:match("(%d+)%-(%d+)")
			min = tonumber(min) or 0
			max = tonumber(max) or 0
			if max - min <= 0 then goto continue end
			min = min + howMuch
			max = max + howMuch
			row[j] = " " .. min .. "-" .. max
			::continue::
		end
	end
	WriteBasicTextTable(t, outfile)
end

function idm(pl, level, mastery)
	Party[pl].Skills[const.Skills.IdentifyMonster] = JoinSkill(level, mastery)
end