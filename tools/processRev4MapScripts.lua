-- below functions are taken from MMExtension repo, as they're not released yet and I don't feel like writing my own saving function, because I might screw something up

-- Saves a string into a file (overwrites it)
function io.save(path, s, translate)
	local f = assert(io.open(path, translate and "wt" or "wb"))
	f:setvbuf("no")
	f:write(s)
	f:close()
end

local path_noslash = _G.path.noslash
local path_dir = _G.path.dir
local CreateDirectoryPtr = internal.CreateDirectory

local function DoCreateDir(dir)
	-- 183 = already exists
	return mem.call(CreateDirectoryPtr, 0, dir, 0) ~= 0
end

local function CreateDirectory(dir)
	dir = path_noslash(dir)
	if dir == "" or #dir == 2 and string_sub(dir, -1) == ":" or DoCreateDir(dir) then
		return true
	end
	local dir1 = path_dir(dir)
	if dir1 ~= dir then
		CreateDirectory(dir1)
	end
	return true
end
_G.os.mkdir = CreateDirectory
--!- backwards compatibility
_G.os.CreateDirectory = CreateDirectory
--!- backwards compatibility
_G.path.CreateDirectory = CreateDirectory

local oldSave = _G.io.save
--!-
function _G.io.save(path, ...)
	CreateDirectory(path_dir(path))
	return oldSave(path, ...)
end

local function WriteBasicTextTable(t, fname)
	if fname then
		return io.save(fname, WriteBasicTextTable(t))
	end
	local q, s = {}, ''
	for i = 1, #t do
		s = (type(t[i]) == "table" and table.concat(t[i], "\t") or t[i])
		q[i] = s
	end
	if s ~= '' then
		q[#q + 1] = ''
	end
	return table.concat(q, "\r\n")
end
_G.WriteBasicTextTable = WriteBasicTextTable

-- end of functions taken from MMExtension repo

local currentFile
local doNotRemoveTheseEvents =
{
	["d27.lua"] = {501, 376} -- 376 because MMMerge overwrites this event and it cleans up, 501 to fix a bug where game crashes after killing Xenofex
}

local firstGlobalLuaFreeEntry = 2000 -- that we will use
local eventNumberReplacements = function(str)
	local noMappingEvents = {{501, 506}, {513, 515}} -- for some reason these events from MM7 are put in the middle of MM8 events and require no numeric change
	local lastOriginalMM7Event = 572
	return function(num)
		num = tonumber(num)
		local add
		if (num >= noMappingEvents[1][1] and num <= noMappingEvents[1][2]) or (num >= noMappingEvents[2][1] and num <= noMappingEvents[2][2]) then
			add = 0
		else
			if num > lastOriginalMM7Event then -- new rev4 event, moved to end
				add = firstGlobalLuaFreeEntry - (lastOriginalMM7Event + 1)
			elseif num > noMappingEvents[2][2] then
				add = 750 - (515 - 513 + 2) - (506 - 501 + 1) + 1
			elseif num > noMappingEvents[1][2] then
				add = 750 - (506 - 501 + 1)
			else
				add = 750
			end
		end
		-- make it disable standard events, so generated lua file can be used without copy pasting into decompiled global.lua
		if str:find("global") ~= nil and num <= lastOriginalMM7Event then
			return ("Game.GlobalEvtLines:RemoveEvent(%d)\n"):format(num + add) .. str:format(num + add)
		end
		return str:format(num + add)
	end
end

local function getQuestBit(questBit)
	return questBit + 512
end

local function getNPC(npc)
	-- entries from 447 onwards are added at the end due to lack of space
	local npcAdd = 339
	if npc >= 447 then
		npcAdd = 1240 - 447
	end
	return npc + npcAdd
end

local function getMessage(message)
	local add = 938
	-- entries from 768 onwards are added at the end due to lack of space
	if message >= 768 then
		add = 2714 - 768
	end
	return message + add
end

local function getEvent(event)
	if event == 0 then return 0 end
	local eventAdd = 750
	if event >= 573 then
		eventAdd = firstGlobalLuaFreeEntry - 573
	-- skill teaching events
	elseif event >= 200 and event <= 262 then
		eventAdd = 300 - 200
	elseif event >= 263 and event <= 280 then
		eventAdd = 372 - 263
	elseif event >= 287 and event <= 310 then
		eventAdd = 393 - 287
	end
	return event + eventAdd
end

local function getAward(award)
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

local function getGreeting(greeting)
	if greeting == 0 then return 0 end
	local greetingAdd = 115
	if greeting >= 195 then
		greetingAdd = 356 - 195
	end
	return greeting + greetingAdd
end

local function getItem(item)
	if item >= 220 and item <= 271 then -- potions
		return item
	end
	return item + 802
end

local function getNpcGroup(npcgroup)
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

local function getHouseID(houseid)
	if houseid == 0 then return 0 end
	if houseid == nil or houseid == "" then return "" end
	local overrideMappings =
	{
		[428] = 1065, [427] = 1064, [426] = 1063, [425] = 1062, [423] = 1060, [432] = 1069, [431] = 1068, [434] = 1071, [433] = 1070, [444] = 1081 , [442] = 1079, [441] = 1078, [439] = 1076, [438] = 1075, [174] = 1169, [176] = 217, [178] = 218, [421] = 216, [184] = 221, [180] = 219, [182] = 220, -- 423 = morningstar residence
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

local function getAutonote(autonote)
	local autonoteAdd = 256
	if autonote <= 52 then
		
	elseif autonote >= 114 then
		autonoteAdd = 309 - 114
	else
		print("This shouldn't ever happen")
	end
	return autonote + autonoteAdd
end

local function getFileName(name)
	local name2 = name
	local name = name:lower()
	if name:sub(1, 1) == "d" then -- dungeon
		local m = tonumber(name:match("%d+"), 10)
		if m >= 5 then
			name2 = "7" .. name2
		end
	elseif name == "nwc.blv" then
		name2 = "7nwc.blv"
	elseif name:sub(1, 3) == "out" then
		local m = tonumber(name:match("%d+"), 10)
		if m <= 6 or m == 13 or m == 15 then
			name2 = "7" .. name2
		end
	end
	return name2
end

local function getMonster(monster)
	return monster + 198
end

local replacements =
{
	["evt%.CanShowTopic%[(%d+)%]"] = eventNumberReplacements("evt.CanShowTopic[%d]"),
	["evt%.global%[(%d+)%]"] = eventNumberReplacements("evt.global[%d]"),
	["evt%.Cmp%(\"QBits\", (%d+)%)"] = function(num) return ("evt.Cmp(\"QBits\", %d)"):format(getQuestBit(num)) end,
	["evt%.Set%(\"QBits\", (%d+)%)"] = function(num) return ("evt.Set(\"QBits\", %d)"):format(getQuestBit(num)) end,
	["evt%.Add%(\"QBits\", (%d+)%)"] = function(num) return ("evt.Add(\"QBits\", %d)"):format(getQuestBit(num)) end,
	["evt%.Subtract%(\"QBits\", (%d+)%)"] = function(num) return ("evt.Subtract(\"QBits\", %d)"):format(getQuestBit(num)) end,
	["evt%.SetMessage%((%d+)%)"] =
	function(message)
		message = tonumber(message)
		return ("evt.SetMessage(%d)"):format(getMessage(message))
	end,
	["evt%.SetNPCTopic%{NPC = (%d+), Index = (%d+), Event = (%d+)%}"] =
	function(npc, index, event)
		npc = tonumber(npc)
		index = tonumber(index)
		event = tonumber(event)
		local indexes = {[0] = "A", "B", "C", "D", "E", "F"}
		return ("evt.SetNPCTopic{NPC = %d, Index = %d, Event = %d}"):format(getNPC(npc), index, getEvent(event))
		-- return ("Game.NPC[%d].Event%s = %d"):format(getNPC(npc), indexes[index], getEvent(event))
	end,
	["evt%.Subtract%(\"NPCs\", (%d+)%)"] =
	function(npc)
		npc = tonumber(npc)
		return ("evt.Subtract(\"NPCs\", %d)"):format(getNPC(npc))
	end,
	["evt%.Add%(\"NPCs\", (%d+)%)"] =
	function(npc)
		npc = tonumber(npc)
		return ("evt.Add(\"NPCs\", %d)"):format(getNPC(npc))
	end,
	["evt%.Set%(\"NPCs\", (%d+)%)"] =
	function(npc)
		npc = tonumber(npc)
		return ("evt.Set(\"NPCs\", %d)"):format(getNPC(npc))
	end,
	["evt%.Cmp%(\"NPCs\", (%d+)%)"] =
	function(npc)
		npc = tonumber(npc)
		return ("evt.Cmp(\"NPCs\", %d)"):format(getNPC(npc))
	end,
	["evt%.Add%(\"Awards\", (%d+)%)"] =
	function(award)
		award = tonumber(award)
		local mappingsFromMM7PromotionAwardsToMergeQBits = -- generated with generateMappingsFromMM7PromotionAwardsToMergeQBits
		{
			[10] = 1560, [11] = 1561, [12] = 1562, [13] = 1563, [16] = 1566, [17] = 1567, [18] = 1568, [19] = 1569, [22] = 1572, [23] = 1573, [24] = 1574, [25] = 1575, [27] = 1577, [28] = 1578, [29] = 1579, [30] = 1580, [31] = 1581, [34] = 1584, [35] = 1585, [36] = 1586, [37] = 1587, [38] = 1588, [39] = 1589, [40] = 1590, [41] = 1591, [42] = 1592, [43] = 1593, [44] = 1594, [45] = 1595, [50] = 1596, [51] = 1597, [52] = 1598, [53] = 1599, [54] = 1600, [55] = 1601, [56] = 1602, [57] = 1603, [58] = 1604, [59] = 1605, [60] = 1606, [62] = 1607, [63] = 1608, [64] = 1609, [65] = 1610, [66] = 1611, [67] = 1612, [68] = 1613, [69] = 1614, [70] = 1615, [71] = 1616, [72] = 1617, [73] = 1618, [74] = 1619, [75] = 1620, [76] = 1621, [77] = 1622, [78] = 1623, [79] = 1624
		}
		if mappingsFromMM7PromotionAwardsToMergeQBits[award] ~= nil then
			-- promotion award, special processing
			return ("evt.Add(\"QBits\", %d)"):format(mappingsFromMM7PromotionAwardsToMergeQBits[award])
		else
			--local awards = LoadBasicTextTable("tab\\AWARDS rev4.txt", 0)
			--print("Not promotion award: " .. awards[award + 1][2])
		end
		local a2 = award
		award = getAward(award)
		if award == -1 then return ("--" .. " evt.Add(\"Awards\", %d)"):format(a2) end
		return ("evt.Add(\"Awards\", %d)"):format(award)
	end,
	["evt%.Set%(\"Awards\", (%d+)%)"] =
	function(award)
		award = tonumber(award)
		local mappingsFromMM7PromotionAwardsToMergeQBits = -- generated with generateMappingsFromMM7PromotionAwardsToMergeQBits
		{
			[10] = 1560, [11] = 1561, [12] = 1562, [13] = 1563, [16] = 1566, [17] = 1567, [18] = 1568, [19] = 1569, [22] = 1572, [23] = 1573, [24] = 1574, [25] = 1575, [27] = 1577, [28] = 1578, [29] = 1579, [30] = 1580, [31] = 1581, [34] = 1584, [35] = 1585, [36] = 1586, [37] = 1587, [38] = 1588, [39] = 1589, [40] = 1590, [41] = 1591, [42] = 1592, [43] = 1593, [44] = 1594, [45] = 1595, [50] = 1596, [51] = 1597, [52] = 1598, [53] = 1599, [54] = 1600, [55] = 1601, [56] = 1602, [57] = 1603, [58] = 1604, [59] = 1605, [60] = 1606, [62] = 1607, [63] = 1608, [64] = 1609, [65] = 1610, [66] = 1611, [67] = 1612, [68] = 1613, [69] = 1614, [70] = 1615, [71] = 1616, [72] = 1617, [73] = 1618, [74] = 1619, [75] = 1620, [76] = 1621, [77] = 1622, [78] = 1623, [79] = 1624
		}
		if mappingsFromMM7PromotionAwardsToMergeQBits[award] ~= nil then
			-- promotion award, special processing
			return ("evt.Set(\"QBits\", %d)"):format(mappingsFromMM7PromotionAwardsToMergeQBits[award])
		else
			--local awards = LoadBasicTextTable("tab\\AWARDS rev4.txt", 0)
			--print("Not promotion award: " .. awards[award + 1][2])
		end
		local a2 = award
		award = getAward(award)
		if award == -1 then return ("--" .. " evt.Set(\"Awards\", %d)"):format(a2) end
		return ("evt.Set(\"Awards\", %d)"):format(award)
	end,
	["evt%.Cmp%(\"Awards\", (%d+)%)"] =
	function(award)
		award = tonumber(award)
		local mappingsFromMM7PromotionAwardsToMergeQBits = -- generated with generateMappingsFromMM7PromotionAwardsToMergeQBits
		{
			[10] = 1560, [11] = 1561, [12] = 1562, [13] = 1563, [16] = 1566, [17] = 1567, [18] = 1568, [19] = 1569, [22] = 1572, [23] = 1573, [24] = 1574, [25] = 1575, [27] = 1577, [28] = 1578, [29] = 1579, [30] = 1580, [31] = 1581, [34] = 1584, [35] = 1585, [36] = 1586, [37] = 1587, [38] = 1588, [39] = 1589, [40] = 1590, [41] = 1591, [42] = 1592, [43] = 1593, [44] = 1594, [45] = 1595, [50] = 1596, [51] = 1597, [52] = 1598, [53] = 1599, [54] = 1600, [55] = 1601, [56] = 1602, [57] = 1603, [58] = 1604, [59] = 1605, [60] = 1606, [62] = 1607, [63] = 1608, [64] = 1609, [65] = 1610, [66] = 1611, [67] = 1612, [68] = 1613, [69] = 1614, [70] = 1615, [71] = 1616, [72] = 1617, [73] = 1618, [74] = 1619, [75] = 1620, [76] = 1621, [77] = 1622, [78] = 1623, [79] = 1624
		}
		if mappingsFromMM7PromotionAwardsToMergeQBits[award] ~= nil then
			-- promotion award, special processing
			return ("evt.Cmp(\"QBits\", %d)"):format(mappingsFromMM7PromotionAwardsToMergeQBits[award])
		else
			--local awards = LoadBasicTextTable("tab\\AWARDS rev4.txt", 0)
			--print("Not promotion award: " .. awards[award + 1][2])
		end
		local a2 = award
		award = getAward(award)
		if award == -1 then return ("--" .. " evt.Cmp(\"Awards\", %d)"):format(a2) end
		return ("evt.Cmp(\"Awards\", %d)"):format(award)
	end,
	["evt%.Subtract%(\"Awards\", (%d+)%)"] =
	function(award)
		award = tonumber(award)
		local mappingsFromMM7PromotionAwardsToMergeQBits = -- generated with generateMappingsFromMM7PromotionAwardsToMergeQBits
		{
			[10] = 1560, [11] = 1561, [12] = 1562, [13] = 1563, [16] = 1566, [17] = 1567, [18] = 1568, [19] = 1569, [22] = 1572, [23] = 1573, [24] = 1574, [25] = 1575, [27] = 1577, [28] = 1578, [29] = 1579, [30] = 1580, [31] = 1581, [34] = 1584, [35] = 1585, [36] = 1586, [37] = 1587, [38] = 1588, [39] = 1589, [40] = 1590, [41] = 1591, [42] = 1592, [43] = 1593, [44] = 1594, [45] = 1595, [50] = 1596, [51] = 1597, [52] = 1598, [53] = 1599, [54] = 1600, [55] = 1601, [56] = 1602, [57] = 1603, [58] = 1604, [59] = 1605, [60] = 1606, [62] = 1607, [63] = 1608, [64] = 1609, [65] = 1610, [66] = 1611, [67] = 1612, [68] = 1613, [69] = 1614, [70] = 1615, [71] = 1616, [72] = 1617, [73] = 1618, [74] = 1619, [75] = 1620, [76] = 1621, [77] = 1622, [78] = 1623, [79] = 1624
		}
		if mappingsFromMM7PromotionAwardsToMergeQBits[award] ~= nil then
			-- promotion award, special processing
			return ("evt.Subtract(\"QBits\", %d)"):format(mappingsFromMM7PromotionAwardsToMergeQBits[award])
		else
			--local awards = LoadBasicTextTable("tab\\AWARDS rev4.txt", 0)
			--print("Not promotion award: " .. awards[award + 1][2])
		end
		local a2 = award
		award = getAward(award)
		if award == -1 then return ("--" .. " evt.Subtract(\"Awards\", %d)"):format(a2) end
		return ("evt.Subtract(\"Awards\", %d)"):format(award)
	end,
	["evt%.SetNPCGroupNews%{NPCGroup = (%d+), NPCNews = (%d+)%}"] = 
	function(group, news)
		group = tonumber(group)
		news = tonumber(news)
		return ("evt.SetNPCGroupNews{NPCGroup = %d, NPCNews = %d}"):format(getNpcGroup(group), news + 51)
	end,
	["evt%.SetNPCGreeting%{NPC = (%d+), Greeting = (%d+)%}"] =
	function (npc, greeting)
		npc = tonumber(npc)
		greeting = tonumber(greeting)
		return ("evt.SetNPCGreeting{NPC = %d, Greeting = %d}"):format(getNPC(npc), getGreeting(greeting))
	end,
	["evt%.Cmp%(\"Inventory\", (%d+)%)"] =
	function(item)
		item = tonumber(item)
		return ("evt.Cmp(\"Inventory\", %d)"):format(getItem(item))
	end,
	["evt%.Add%(\"Inventory\", (%d+)%)"] =
	function(item)
		item = tonumber(item)
		return ("evt.Add(\"Inventory\", %d)"):format(getItem(item))
	end,
	["evt%.Subtract%(\"Inventory\", (%d+)%)"] =
	function(item)
		item = tonumber(item)
		return ("evt.Subtract(\"Inventory\", %d)"):format(getItem(item))
	end,
	["evt%.Set%(\"Inventory\", (%d+)%)"] =
	function(item)
		item = tonumber(item)
		-- apparently evt.Set("Inventory", num) makes character diseased...
		return ("evt.Add(\"Inventory\", %d)"):format(getItem(item))
	end,
	["evt%.MoveNPC%{NPC = (%d+), HouseId = (%d+)%}"] =
	function(npc, houseid)
		npc = tonumber(npc)
		houseid = tonumber(houseid)
		return ("evt.MoveNPC{NPC = %d, HouseId = %d}"):format(getNPC(npc), getHouseID(houseid))
	end,
	["evt%.SetNPCItem%{NPC = (%d+), Item = (%d+), On = (%w+)%}"] =
	function(npc, item, on)
		npc = tonumber(npc)
		item = tonumber(item)
		return ("evt.SetNPCItem{NPC = %d, Item = %d, On = %s}"):format(getNPC(npc), getItem(item), on)
	end,
	--[[["evt%.Add%(\"History(%d+)\", (%d+)%)"] =
	function(historyid, dummy)
		historyid = tonumber(historyid)
		dummy = tonumber(dummy)
		return ("--" .. " evt.Add(\"History%d\", %d)"):format(historyid, dummy)
	end,]]--
	["evt%.SetMonGroupBit%{NPCGroup = (%d+), Bit = ([%w%.]+), On = (%w+)%}"]
	= function(npcgroup, bit, on)
		npcgroup = tonumber(npcgroup)
		return ("evt.SetMonGroupBit{NPCGroup = %d, Bit = %s, On = %s}"):format(getNpcGroup(npcgroup), bit, on)
	end,
	["evt%.Set%(\"AutonotesBits\", (%d+)%)"] =
	function(autonote)
		autonote = tonumber(autonote)
		return ("evt.Set(\"AutonotesBits\", %d)"):format(getAutonote(autonote))
	end,
	["evt%.ChangeEvent%((%d+)%)"] = 
	function(event)
		event = tonumber(event)
		return ("evt.ChangeEvent(%d)"):format(getEvent(event))
	end,
	["evt%.StatusText%((%d+)%)"] = 
	function(message)
		message = tonumber(message)
		return ("evt.StatusText(%d)"):format(getMessage(message))
	end,
	["evt%.CheckMonstersKilled%{CheckType = (%d+), Id = (%d+), Count = (%d+)%}"] =
	function(checktype, id, count)
		checktype = tonumber(checktype)
		id = tonumber(id)
		count = tonumber(count)
		if checktype == 1 then
			return ("evt.CheckMonstersKilled{CheckType = %d, Id = %d, Count = %d}"):format(checktype, id + 51, count)
		elseif checktype == 2 then
			return ("evt.CheckMonstersKilled{CheckType = %d, Id = %d, Count = %d}"):format(checktype, getMonster(id), count)
		elseif checktype == 4 then
			print("While processing scripts encountered evt.CheckMonstersKilled with CheckType of 4, need to take care of that")
		end
		return ("evt.CheckMonstersKilled{CheckType = %d, Id = %d, Count = %d}"):format(checktype, id, count)
	end
}

local replacements2 = -- replacements specific to map scripts
{
	["evt%.house%[(%d+)%] = (%d+)"] =
	function(idx, house)
		idx = tonumber(idx)
		house = tonumber(house)
		return ("evt.house[%d] = %d"):format(idx, getHouseID(house))
	end,
	["evt%.EnterHouse%((%d+)%)"] =
	function(house)
		house = tonumber(house)
		return ("evt.EnterHouse(%d)"):format(getHouseID(house))
	end,
	["evt%.EnterHouse%{Id = (%d+)%}"] =
	function(house)
		house = tonumber(house)
		return ("evt.EnterHouse{Id = %d}"):format(getHouseID(house))
	end,
	["evt%.MoveToMap%{X = (%-?%d+), Y = (%-?%d+), Z = (%-?%d+), Direction = (%-?%d+), LookAngle = (%-?%d+), SpeedZ = (%-?%d+), HouseId = (%-?%d+), Icon = (%-?%d+), Name = \"([%w%.]+)\"%}"]
	= function(x, y, z, direction, lookangle, speedz, houseid, icon, name)
		x = tonumber(x)
		y = tonumber(y)
		z = tonumber(z)
		direction = tonumber(direction)
		lookangle = tonumber(lookangle)
		speedz = tonumber(speedz)
		houseid = tonumber(houseid)
		icon = tonumber(icon)
			
		return ("evt.MoveToMap{X = %d, Y = %d, Z = %d, Direction = %d, LookAngle = %d, SpeedZ = %d, HouseId = %d, Icon = %d, Name = \"%s\"}")
		:format(x, y, z, direction, lookangle, speedz, getHouseID(houseid), icon, getFileName(name))
	end,
	["evt%.SpeakNPC%{NPC = (%d+)%}"] =
	function(npc)
		npc = tonumber(npc)
		return ("evt.SpeakNPC{NPC = %d}"):format(getNPC(npc))
	end,
	["evt%.SetMonsterItem%{Monster = (%d+), Item = (%d+), Has = (%w+)%}"] =
	function(monster, item, has)
		monster = tonumber(monster)
		item = tonumber(item)
		return ("evt.SetMonsterItem{Monster = %d, Item = %d, Has = %s}"):format(monster, getItem(item), has)
	end,
	--[[["evt%.SetNPCGreeting%{NPC = (%d+), Greeting = (%d+)%}"] =
	function(npc, greeting)
		npc = tonumber(npc)
		greeting = tonumber(greeting)
		return ("evt.SetNPCGreeting{NPC = %d, Greeting = %d}"):format(getNPC(npc), getGreeting(greeting))
	end--]]
	["evt%.Cmp%{\"QBits\", Value = (%d+)%}"] = function(num) return ("evt.Cmp{\"QBits\", Value = %d}"):format(getQuestBit(num)) end,
	["evt%.Set%{\"QBits\", Value = (%d+)%}"] = function(num) return ("evt.Set{\"QBits\", Value = %d}"):format(getQuestBit(num)) end,
	["evt%.Add%{\"QBits\", Value = (%d+)%}"] = function(num) return ("evt.Add{\"QBits\", Value = %d}"):format(getQuestBit(num)) end,
	["evt%.Subtract%{\"QBits\", Value = (%d+)%}"] = function(num) return ("evt.Subtract{\"QBits\", Value = %d}"):format(getQuestBit(num)) end,
	["evt%.Subtract%{\"NPCs\", Value = (%d+)%}"] =
	function(npc)
		npc = tonumber(npc)
		return ("evt.Subtract{\"NPCs\", Value = %d}"):format(getNPC(npc))
	end,
	["evt%.Add%{\"NPCs\", Value = (%d+)%}"] =
	function(npc)
		npc = tonumber(npc)
		return ("evt.Add{\"NPCs\", Value = %d}"):format(getNPC(npc))
	end,
	["evt%.Set%{\"NPCs\", Value = (%d+)%}"] =
	function(npc)
		npc = tonumber(npc)
		return ("evt.Set{\"NPCs\", Value = %d}"):format(getNPC(npc))
	end,
	["evt%.Cmp%{\"NPCs\", Value = (%d+)%}"] =
	function(npc)
		npc = tonumber(npc)
		return ("evt.Cmp{\"NPCs\", Value = %d}"):format(getNPC(npc))
	end,
	["evt%.Cmp%{\"Awards\", Value = (%d+)%}"] =
	function(award)
		award = tonumber(award)
		local mappingsFromMM7PromotionAwardsToMergeQBits = -- generated with generateMappingsFromMM7PromotionAwardsToMergeQBits
		{
			[10] = 1560, [11] = 1561, [12] = 1562, [13] = 1563, [16] = 1566, [17] = 1567, [18] = 1568, [19] = 1569, [22] = 1572, [23] = 1573, [24] = 1574, [25] = 1575, [27] = 1577, [28] = 1578, [29] = 1579, [30] = 1580, [31] = 1581, [34] = 1584, [35] = 1585, [36] = 1586, [37] = 1587, [38] = 1588, [39] = 1589, [40] = 1590, [41] = 1591, [42] = 1592, [43] = 1593, [44] = 1594, [45] = 1595, [50] = 1596, [51] = 1597, [52] = 1598, [53] = 1599, [54] = 1600, [55] = 1601, [56] = 1602, [57] = 1603, [58] = 1604, [59] = 1605, [60] = 1606, [62] = 1607, [63] = 1608, [64] = 1609, [65] = 1610, [66] = 1611, [67] = 1612, [68] = 1613, [69] = 1614, [70] = 1615, [71] = 1616, [72] = 1617, [73] = 1618, [74] = 1619, [75] = 1620, [76] = 1621, [77] = 1622, [78] = 1623, [79] = 1624
		}
		if mappingsFromMM7PromotionAwardsToMergeQBits[award] ~= nil then
			-- promotion award, special processing
			return ("evt.Cmp{\"QBits\", Value = %d}"):format(mappingsFromMM7PromotionAwardsToMergeQBits[award])
		else
			--local awards = LoadBasicTextTable("tab\\AWARDS rev4.txt", 0)
			--print("Not promotion award: " .. awards[award + 1][2])
		end
		local a2 = award
		award = getAward(award)
		if award == -1 then return ("--" .. " evt.Cmp{\"Awards\", Value = %d}"):format(a2) end
		return ("evt.Cmp{\"Awards\", Value = %d}"):format(award)
	end,
	["evt%.Cmp%{\"Inventory\", Value = (%d+)%}"] =
	function(item)
		item = tonumber(item)
		return ("evt.Cmp{\"Inventory\", Value = %d}"):format(getItem(item))
	end,
	["evt%.Add%{\"Inventory\", Value = (%d+)%}"] =
	function(item)
		item = tonumber(item)
		return ("evt.Add{\"Inventory\", Value = %d}"):format(getItem(item))
	end,
	["evt%.Subtract%{\"Inventory\", Value = (%d+)%}"] =
	function(item)
		item = tonumber(item)
		return ("evt.Subtract{\"Inventory\", Value = %d}"):format(getItem(item))
	end,
	["evt%.Set%{\"Inventory\", Value = (%d+)%}"] =
	function(item)
		item = tonumber(item)
		-- apparently evt.Set("Inventory", num) makes character diseased...
		return ("evt.Add{\"Inventory\", %d}"):format(getItem(item))
	end,
	["evt%.Add%{\"AutonotesBits\", Value = (%d+)%}"] =
	function(autonote)
		autonote = tonumber(autonote)
		return ("evt.Add{\"AutonotesBits\", Value = %d}"):format(getAutonote(autonote))
	end,
	["evt%.map%[(%d+)%] = function"] =
	function(event)
		event = tonumber(event)
		local doNotRemoveEntry = doNotRemoveTheseEvents[currentFile]
		if doNotRemoveEntry then
			if table.find(doNotRemoveEntry, event) then
				return ("evt.map[%d] = function"):format(event)
			end
		end
		return ("Game.MapEvtLines:RemoveEvent(%d)\nevt.map[%d] = function"):format(event, event)
	end
}

-- WARNING: decompiled scripts downloaded from GrayFace's website are bugged, need to decompile them by yourself from Rev4 installation

local replacementsafter =
{
	--[["evt%.HouseDoor%((%d+), (%d+)%)([^\"]-\"[^\"]-\")"] =
	function(event, house, comment)
		event = tonumber(event)
		house = tonumber(house)
		-- apparently this is not working, need to replace with different function
		return (

evt.map[%d] = function()
	evt.EnterHouse(%d)%s
end		):format(event, getHouseID(house), comment)
	end,--]]
}

--[[ TODO
* out01.lua - house226?
--]]

-- 7d08: delete items, lights, torches have decName = nil, they are invisible
--[[evt.Set{"QBits", Value = 868}
evt.MoveToMap{Name = "out02.odm"}

https://discord.com/channels/296507109997019137/795807513924075540/885284417893957633
--]]
-- lord godwinson
-- brazier should phase
-- inspect event 376

-- 7d12: genies, light elementals, air elementals, probably spawns, promotion brazier, coding wizard appears after killing monsters

local patches =
{
	["d06.lua"] = {[[evt.map[5] = function()  -- function events.LoadMap()
	evt.SetMonsterItem{Monster = 1, Item = 658, Has = true}         -- "Contestant's Shield"
	evt.SetMonsterItem{Monster = 1, Item = 64, Has = true}         -- "Blaster"
	evt.SetMonGroupBit{NPCGroup = 4, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
end]],
	[[evt.map[5] = function()  -- function events.LoadMap()
	local changed = false
	for idx, m in Map.Monsters do
		if m.Id == 403 then -- green adventurer
			changed = true
			evt.SetMonsterItem{Monster = idx, Item = 1460, Has = true}         -- "Contestant's Shield"
			evt.SetMonsterItem{Monster = idx, Item = 866, Has = true}         -- "Blaster"
			break
		end
	end
	if not changed then
		for idx, m in Map.Monsters do
			if m.Id == 404 or m.Id == 405 then
				changed = true
				evt.SetMonsterItem{Monster = idx, Item = 1460, Has = true}         -- "Contestant's Shield"
				evt.SetMonsterItem{Monster = idx, Item = 866, Has = true}         -- "Blaster"
				break
			end
		end
	end
	if not changed then
		MessageBox("Error: script giving items to monsters in temple of the moon is not working as expected, this should be reported to mod author so he can fix it")
	end
	evt.SetMonGroupBit{NPCGroup = 4, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
end]],
[[evt.map[10] = function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if not evt.Cmp{"QBits", Value = 330} then         -- 1-time EI temple
		evt.Set{"QBits", Value = 330}         -- 1-time EI temple
		evt.Set{"MerchantSkill", Value = 70}
		evt.SetSprite{SpriteId = 15, Visible = 1, Name = "sp57"}
	end
end]],
[[evt.map[10] = function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if not evt.Cmp{"QBits", Value = 330} then         -- 1-time EI temple
		evt.Set{"QBits", Value = 330}         -- 1-time EI temple
		evt.ForPlayer("All").Add("Experience", 0) -- make sparkle sound and animation
		for _, pl in Party do
			local s, m = SplitSkill(pl.Skills[const.Skills.Merchant])
			pl.Skills[const.Skills.Merchant] = JoinSkill(math.max(s, 6), math.max(m, const.Expert))
		end
		evt.SetSprite{SpriteId = 15, Visible = 1, Name = "sp57"}
	end
end]]}
}

local patchesAfter =
{
	-- different table because I failed and edited a processed script
	["d12.lua"] = {[[evt.map[12] = function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if not evt.Cmp{"QBits", Value = 861} then         -- One Use
		evt.StatusText{Str = 20}         -- "Only BDJ can activate this Brazier."
		return
	end
	evt.Subtract{"QBits", Value = 861}         -- One Use
	if evt.Cmp{"QBits", Value = 850} then         -- BDJ Final
		evt.Set{"QBits", Value = 860}         -- Final
		evt.ForPlayer(-- ERROR: Const not found
3)
	else
		if evt.Cmp{"QBits", Value = 849} then         -- BDJ 3
			evt.Set{"QBits", Value = 850}         -- BDJ Final
			evt.ForPlayer(-- ERROR: Const not found
2)
		else
			if evt.Cmp{"QBits", Value = 848} then         -- BDJ 2
				evt.Set{"QBits", Value = 849}         -- BDJ 3
				evt.ForPlayer(-- ERROR: Const not found
1)
			else
				evt.Set{"QBits", Value = 848}         -- BDJ 2
				evt.ForPlayer(-- ERROR: Const not found
0)
			end
		end
	end
	if evt.Cmp{"QBits", Value = 851} then         -- Sorcerer
		evt.Add{"BaseIntellect", Value = 20}
		evt.Set{"ClassIs", Value = const.Class.ArchMage}
		evt.Subtract{"QBits", Value = 851}         -- Sorcerer
	else
		if evt.Cmp{"QBits", Value = 852} then         -- Cleric
			evt.Add{"BasePersonality", Value = 20}
			evt.Set{"ClassIs", Value = const.Class.PriestLight}
			evt.Subtract{"QBits", Value = 852}         -- Cleric
			goto _78
		end
		if evt.Cmp{"QBits", Value = 853} then         -- Fighter
			evt.Add{"BaseEndurance", Value = 15}
			evt.Add{"BaseMight", Value = 5}
			evt.Set{"ClassIs", Value = const.Class.Champion}
			evt.Subtract{"QBits", Value = 853}         -- Fighter
			goto _78
		end
		if evt.Cmp{"QBits", Value = 854} then         -- Paladin
			evt.Add{"BasePersonality", Value = 5}
			evt.Add{"BaseEndurance", Value = 10}
			evt.Add{"BaseMight", Value = 5}
			evt.Set{"ClassIs", Value = const.Class.Hero}
			evt.Subtract{"QBits", Value = 854}         -- Paladin
			goto _78
		end
		if evt.Cmp{"QBits", Value = 855} then         -- Monk
			evt.Add{"BaseEndurance", Value = 10}
			evt.Add{"BaseMight", Value = 10}
			evt.Set{"ClassIs", Value = const.Class.Master}
			evt.Subtract{"QBits", Value = 855}         -- Monk
			goto _78
		end
		if evt.Cmp{"QBits", Value = 856} then         -- Thief
			evt.Add{"BaseLuck", Value = 20}
			evt.Set{"ClassIs", Value = const.Class.Spy}
			evt.Subtract{"QBits", Value = 856}         -- Thief
			goto _78
		end
		if evt.Cmp{"QBits", Value = 857} then         -- Ranger
			evt.Add{"BaseEndurance", Value = 10}
			evt.Add{"BaseMight", Value = 10}
			evt.Set{"ClassIs", Value = const.Class.RangerLord}
			evt.Subtract{"QBits", Value = 857}         -- Ranger
		else
			if evt.Cmp{"QBits", Value = 858} then         -- Archer
				evt.Add{"BaseSpeed", Value = 15}
				evt.Add{"BaseIntellect", Value = 5}
				evt.Set{"ClassIs", Value = const.Class.MasterArcher}
				evt.Subtract{"QBits", Value = 858}         -- Archer
			else
				evt.Add{"BaseIntellect", Value = 10}
				evt.Add{"BasePersonality", Value = 10}
				evt.Set{"ClassIs", Value = const.Class.ArchDruid}
				evt.Subtract{"QBits", Value = 859}         -- Druid
			end
		end
	end
	if not evt.Cmp{"FireSkill", Value = 8} then
		evt.Set{"FireSkill", Value = 72}
	end
::_78::
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if evt.Cmp{"QBits", Value = 860} then         -- Final
		evt.SetNPCTopic{NPC = 1234, Index = 0, Event = 837}         -- "The Coding Wizard" : "Let's Continue."
	else
		evt.StatusText{Str = 21}         -- "Return to the Coding Wizard."
		evt.SetNPCTopic{NPC = 1234, Index = 0, Event = 800}         -- "The Coding Wizard" : "New Profession."
	end
end]],

[[evt.map[12] = function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if not evt.Cmp{"QBits", Value = 861} then         -- One Use
		evt.StatusText{Str = 20}         -- "Only BDJ can activate this Brazier."
		return
	end
	evt.Subtract{"QBits", Value = 861}         -- One Use
	if evt.Cmp{"QBits", Value = 869} then         -- BDJ Final
		evt.Set{"QBits", Value = 860}         -- Final
		evt.ForPlayer(-- ERROR: Const not found
	4)
	else
		if evt.Cmp{"QBits", Value = 850} then         -- BDJ 4
			evt.Set{"QBits", Value = 869}         -- BDJ Final
			evt.ForPlayer(-- ERROR: Const not found
	3)
		else
			if evt.Cmp{"QBits", Value = 849} then         -- BDJ 3
				evt.Set{"QBits", Value = 850}         -- BDJ 4
				evt.ForPlayer(-- ERROR: Const not found
	2)
			else
				if evt.Cmp{"QBits", Value = 848} then         -- BDJ 2
					evt.Set{"QBits", Value = 849}         -- BDJ 3
					evt.ForPlayer(-- ERROR: Const not found
	1)
				else
					evt.Set{"QBits", Value = 848}         -- BDJ 2
					evt.ForPlayer(-- ERROR: Const not found
	0)
				end
			end
		end
	end
	if evt.Cmp{"QBits", Value = 851} then         -- Sorcerer
		evt.Add{"BaseIntellect", Value = 20}
		evt.Set{"ClassIs", Value = const.Class.ArchMage}
		evt.Subtract{"QBits", Value = 851}         -- Sorcerer
	else
		if evt.Cmp{"QBits", Value = 852} then         -- Cleric
			evt.Add{"BasePersonality", Value = 20}
			evt.Set{"ClassIs", Value = const.Class.PriestLight}
			evt.Subtract{"QBits", Value = 852}         -- Cleric
			goto _78
		end
		if evt.Cmp{"QBits", Value = 853} then         -- Fighter
			evt.Add{"BaseEndurance", Value = 15}
			evt.Add{"BaseMight", Value = 5}
			evt.Set{"ClassIs", Value = const.Class.Champion}
			evt.Subtract{"QBits", Value = 853}         -- Fighter
			goto _78
		end
		if evt.Cmp{"QBits", Value = 854} then         -- Paladin
			evt.Add{"BasePersonality", Value = 5}
			evt.Add{"BaseEndurance", Value = 10}
			evt.Add{"BaseMight", Value = 5}
			evt.Set{"ClassIs", Value = const.Class.Hero}
			evt.Subtract{"QBits", Value = 854}         -- Paladin
			goto _78
		end
		if evt.Cmp{"QBits", Value = 855} then         -- Monk
			evt.Add{"BaseEndurance", Value = 10}
			evt.Add{"BaseMight", Value = 10}
			evt.Set{"ClassIs", Value = const.Class.Master}
			evt.Subtract{"QBits", Value = 855}         -- Monk
			goto _78
		end
		if evt.Cmp{"QBits", Value = 856} then         -- Thief
			evt.Add{"BaseLuck", Value = 20}
			evt.Set{"ClassIs", Value = const.Class.Spy}
			evt.Subtract{"QBits", Value = 856}         -- Thief
			goto _78
		end
		if evt.Cmp{"QBits", Value = 857} then         -- Ranger
			evt.Add{"BaseEndurance", Value = 10}
			evt.Add{"BaseMight", Value = 10}
			evt.Set{"ClassIs", Value = const.Class.RangerLord}
			evt.Subtract{"QBits", Value = 857}         -- Ranger
		else
			if evt.Cmp{"QBits", Value = 858} then         -- Archer
				evt.Add{"BaseSpeed", Value = 15}
				evt.Add{"BaseIntellect", Value = 5}
				evt.Set{"ClassIs", Value = const.Class.MasterArcher}
				evt.Subtract{"QBits", Value = 858}         -- Archer
			else
				evt.Add{"BaseIntellect", Value = 10}
				evt.Add{"BasePersonality", Value = 10}
				evt.Set{"ClassIs", Value = const.Class.ArchDruid}
				evt.Subtract{"QBits", Value = 859}         -- Druid
			end
		end
	end
	if not evt.Cmp{"FireSkill", Value = 8} then
		local s, m = SplitSkill(Party[evt.CurrentPlayer].Skills[const.Skills.Fire])
		Party[evt.CurrentPlayer].Skills[const.Skills.Fire] = JoinSkill(math.max(s, 8), math.max(m, const.Expert))
	end
::_78::
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if evt.Cmp{"QBits", Value = 860} then         -- Final
		evt.SetNPCTopic{NPC = 1234, Index = 0, Event = 837}         -- "The Coding Wizard" : "Let's Continue."
	else
		evt.StatusText{Str = 21}         -- "Return to the Coding Wizard."
		evt.SetNPCTopic{NPC = 1234, Index = 0, Event = 800}         -- "The Coding Wizard" : "New Profession."
	end
end]]},
	-- btw in following patch evt.Cmp should have item number updated, but since Merge handles that event differently and I patch the only check of this VarNum, I'm ignoring it
	["d23.lua"] = {[[

evt.hint[501] = evt.str[2]  -- "Leave the Lincoln"
evt.map[501] = function()
	evt.ForPlayer(-- ERROR: Const not found
0)
	if evt.Cmp{"IsWearingItem", Value = 604} then
		evt.ForPlayer(-- ERROR: Const not found
1)
		if evt.Cmp{"IsWearingItem", Value = 604} then
			evt.ForPlayer(-- ERROR: Const not found
2)
			if evt.Cmp{"IsWearingItem", Value = 604} then
				evt.ForPlayer(-- ERROR: Const not found
3)
				if evt.Cmp{"IsWearingItem", Value = 604} then
					evt.MoveToMap{X = -7005, Y = 7856, Z = 225, Direction = 128, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "7out15.odm"}
					return
				end
			end
		end
	end
	evt.StatusText{Str = 20}         -- "You must all be wearing your wetsuits to exit the ship"
end]], ""},
	["d24.lua"] = {[[evt.map[10] = function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if not evt.Cmp{"QBits", Value = 846} then         -- 1-time stone city
		evt.Set{"QBits", Value = 846}         -- 1-time stone city
		evt.Set{"PerceptionSkill", Value = 70}
	end
end]], [[evt.map[10] = function()
	if not evt.Cmp{"QBits", Value = 846} then         -- 1-time stone city
		evt.Set{"QBits", Value = 846}         -- 1-time stone city
		evt.ForPlayer("All").Add("Experience", 0) -- make sparkle sound and animation
		for _, pl in Party do
			local s, m = SplitSkill(pl.Skills[const.Skills.Perception])
			pl.Skills[const.Skills.Perception] = JoinSkill(math.max(s, 6), math.max(m, const.Expert))
		end
	end
end]]},
	-- Harmondale teleportal hub
	["out02.lua"] =
	{
		[[evt.map[218] = function()
	evt.ForPlayer(-- ERROR: Const not found
0)
	if evt.Cmp{"Inventory", Value = 1467} then         -- "Tatalia Teleportal Key"
		evt.MoveToMap{X = 6604, Y = -8941, Z = 0, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 1172, Icon = 4, Name = "7Out13.odm"}         -- "Harmondale Teleportal Hub"
		goto _9
	end
	if evt.Cmp{"Inventory", Value = 1469} then         -- "Avlee Teleportal Key"
		goto _9
	end
	if evt.Cmp{"Inventory", Value = 1468} then         -- "Deja Teleportal Key"
		goto _10
	end
	if evt.Cmp{"Inventory", Value = 1471} then         -- "Bracada Teleportal Key"
		goto _11
	end
	if not evt.Cmp{"Inventory", Value = 1470} then         -- "Evenmorn Teleportal Key"
		evt.StatusText{Str = 20}         -- "You need a key to use this hub!"
		return
	end
::_12::
	evt.MoveToMap{X = 17161, Y = -10827, Z = 0, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 1172, Icon = 4, Name = "Out09.odm"}         -- "Harmondale Teleportal Hub"
	do return end
::_9::
	evt.MoveToMap{X = 14414, Y = 12615, Z = 0, Direction = 768, LookAngle = 0, SpeedZ = 0, HouseId = 1172, Icon = 4, Name = "Out14.odm"}         -- "Harmondale Teleportal Hub"
::_10::
	evt.MoveToMap{X = 4586, Y = -12681, Z = 0, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 1172, Icon = 4, Name = "7Out05.odm"}         -- "Harmondale Teleportal Hub"
::_11::
	evt.MoveToMap{X = 8832, Y = 18267, Z = 0, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 1172, Icon = 4, Name = "7Out06.odm"}         -- "Harmondale Teleportal Hub"
	goto _12
end]], [[evt.map[218] = function()
	local hasKey = false
	for i = 0, 4 do
		if evt.All.Cmp("Inventory", 1467 + i) then
			hasKey = true
			break
		end
	end
	if not hasKey then
		Game.ShowStatusText(evt.str[20])
	else
		evt.EnterHouse(925)
	end
end]]
	},
	["d27.lua"] = {[[evt.map[376] = function()
	evt.SpeakNPC{NPC = 626}         -- "Roland Ironfist"
	evt.SetSprite{SpriteId = 20, Visible = 1, Name = "dec05"}
	evt.Add{"Inventory", Value = 1463}         -- "Colony Zod Key"
	evt.Add{"QBits", Value = 752}         -- Talked to Roland
	evt.Add{"History24", Value = 0}
	evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Untouchable, On = true}
	evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Invisible, On = true}
end
]], "", [[evt.hint[501] = evt.str[2]  -- "Leave the Hive"
evt.map[501] = function()
	evt.MoveToMap{X = -18246, Y = -11910, Z = 3201, Direction = 128, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "Out12.odm"}
end
]], ""},
	["d29.lua"] = {[[evt.map[37] = function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if not evt.Cmp{"QBits", Value = 829} then         -- 1-time Castle Harm
		evt.Set{"QBits", Value = 829}         -- 1-time Castle Harm
		evt.Set{"BodybuildingSkill", Value = 71}
	end
end]], [[evt.map[37] = function()
	if not evt.Cmp{"QBits", Value = 829} then         -- 1-time Castle Harm
		evt.Set{"QBits", Value = 829}         -- 1-time Castle Harm
		evt.All.Add("Experience", 0)
		for _, pl in Party do
			local s, m = SplitSkill(pl.Skills[const.Skills.Bodybuilding])
			pl.Skills[const.Skills.Bodybuilding] = JoinSkill(math.max(s, 7), math.max(m, const.Expert))
		end
	end
end]], [[evt.SetMonGroupBit{NPCGroup = 5, -- ERROR: Const not found
Bit = 0x0, On = false}]], [[evt.SetMonGroupBit{NPCGroup = 56, -- ERROR: Const not found
Bit = 0x0, On = false}]]}
}

local additions =
{
	["out01.lua"] = {[[

evt.map[100] = function()  -- function events.LoadMap()
	if not evt.Cmp{"QBits", Value = 519} then         -- Finished Scavenger Hunt
		if not evt.Cmp{"QBits", Value = 518} then         -- "Return a wealthy hat to the Judge on Emerald Island."
			if not evt.Cmp{"QBits", Value = 517} then         -- "Return a musical instrument to the Judge on Emerald Island."
				if not evt.Cmp{"QBits", Value = 516} then         -- "Return a floor tile to the Judge on Emerald Island."
					if not evt.Cmp{"QBits", Value = 515} then         -- "Return a longbow to the Judge on Emerald Island."
						if not evt.Cmp{"QBits", Value = 514} then         -- "Return a seashell to the Judge on Emerald Island."
							if not evt.Cmp{"QBits", Value = 513} then         -- "Return a red potion to the Judge on Emerald Island."
								evt.Add{"QBits", Value = 518}         -- "Return a wealthy hat to the Judge on Emerald Island."
								evt.Add{"QBits", Value = 517}         -- "Return a musical instrument to the Judge on Emerald Island."
								evt.Add{"QBits", Value = 516}         -- "Return a floor tile to the Judge on Emerald Island."
								evt.Add{"QBits", Value = 515}         -- "Return a longbow to the Judge on Emerald Island."
								evt.Add{"QBits", Value = 514}         -- "Return a seashell to the Judge on Emerald Island."
								evt.Add{"QBits", Value = 513}         -- "Return a red potion to the Judge on Emerald Island."
								evt.ShowMovie{DoubleSize = 1, Name = "\"intro post\""}
							end
						end
					end
				end
			end
		end
	end
end

events.LoadMap = evt.map[100].last]]}
}

local ignoreMergeAdditions =
{
	["d08.lua"] = true
}

for i in path.find("rev4 map scripts\\*.lua") do
	print("Current file: " .. path.name(i))
	local file = io.open(i)
	local content = file:read("*a")
	file:close()
	local name = path.name(i):lower()
	currentFile = name
	if patches[name] ~= nil then
		for i = 1, #patches[name], 2 do
			content = content:replace(patches[name][i], patches[name][i + 1])
		end
	end
	for regex, fun in pairs(replacements) do
		content = content:gsub(regex, fun)
	end
	for regex, fun in pairs(replacements2) do
		content = content:gsub(regex, fun)
	end
	for regex, fun in pairs(replacementsafter) do
		content = content:gsub(regex, fun)
	end
	
	if additions[name] ~= nil then
		for i, v in ipairs(additions[name]) do
			content = content .. v
		end
	end
	
	if patchesAfter[name] ~= nil then
		for i = 1, #patchesAfter[name], 2 do
			content = content:replace(patchesAfter[name][i], patchesAfter[name][i + 1])
		end
	end
	-- preserve MMMerge script additions
	if ignoreMergeAdditions[name] == nil then
		local file = io.open("merge map scripts\\" .. getFileName(path.name(i)), "r")
		if file then
			local content2 = file:read("*a")
			content = content .. "\n\n--[[ MMMerge additions --]]\n\n" .. content2
			file:close()
		end
	end
	content = content:replace([[
-- Deactivate all standard events
Game.MapEvtLines.Count = 0

]], "")
	io.save("rev4 map scripts\\processed\\" .. getFileName(path.name(i)), content)
end