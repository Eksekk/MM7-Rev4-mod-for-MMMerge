local file = io.open("GLOBAL rev4.lua")
local content = file:read("*a")
io.close(file)

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
-- note: there is event skip at event 511 in rev4

local function getQuestBit(questBit)
	return questBit + 512
end

local function getNPC(npc)
	-- entries from 447 onwards are added at the end due to lack of space
	local npcAdd = 339
	if npc >= 447 then
		npcAdd = 1225 - 447
	end
	return npc + npcAdd
end

local function getMessage(message)
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
		return message + (2732 - 768)
	end
	local add = 938
	local i = 1
	while i <= #noMappingTexts and message > noMappingTexts[i][2] do
		add = add - (noMappingTexts[i][2] - noMappingTexts[i][1] + 1)
		i = i + 1
	end
	return message + add
end

local lastOriginalMM8Event = 750
local firstOriginalMM6Event = 1314

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

local function getMonster(monster)
	return monster + 198
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
	if mergeid == nil then
		print(("Couldn't find merge ids table for 2d location %d (name: %s)"):format(houseid, rev4name))
		return -1
	elseif #mergeid > 1 then
		print(("Found multiple merge locations for 2d location %d (name: %s)"):format(houseid, rev4name))
		print("The locations:")
		for k, v in pairs(mergeid) do
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
		
	elseif autonote >= 128 then
		autonoteAdd = 323 - 128
	else
		print("This shouldn't ever happen")
	end
	return autonote + autonoteAdd
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
		--return ("Game.NPC[%d].Event%s = %d"):format(getNPC(npc), indexes[index], getEvent(event))
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
--[[ THINGS TO FIX MANUALLY (or create a script to fix them)
* blayze's quest change to work with 5 players
* BDJ's class change code to work with 5 players
* erathian town portal pedestals small fix
* GLOBAL
* fix event 833, line 1231 - probably this line is not required
* event 858, line 1827 - fix npc number
* event 869 - fix the returns
* GLOBAL END
* 7d08 - event 376
* 7out02 - event 221
--]]

--[[ TODO
* <del>fix getHouseID (create table of overriding mappings from rev4 to merge in case of for example hostels) - both here and in parseNpcData.lua</del>
* check awards missing mappings
* <del>promoted awards checks are changed into qbits in merge</del>
* check other qbits past 512 * 3, for things that might break with conversion
* check if after arriving in harmondale death map is set as harmondale
* <del>check if class consts (const.Class.Thief for example) is good for merge</del>
* check if setMonGroupBit works correctly
* check search for "ERROR: Not found" and check if everything is ok near it
* check if blayze's quest and saving erathia quest give correct mastery
* check evt.ShowMovie file names
* check wtf at line 2595
* <del>check strange avlee teachers greetings ("Help me!")</del>
* resolve docent talking in emerald island - workaround is to walk into BDJ radius again, second time it sets the QBit
* <del>BDJ goodbye topic giving wrong message</del>
* sort entries in mapstats
* check icons for evt.MoveToMap
* integrate changes from revamp.T.lod ( incl. scripts)
* check unfixed evt commands in each script file
* move entries from processRev4GlobalLua into proper Merge decompiled global.lua
* check Elgar Fellmoon
* <del>process npctext</del>
* <del>fix adventurers in temple of the moon not dropping items: iterate through monsters after loading map, find adventurer index and give item to him</del>
* <del>fix skill barrels code</del>
* different sparkles for skill barrels: https://discord.com/channels/296507109997019137/296508593744773120/885066444071645245
* <del>fix mm7 barrels to give +5</del>
* fix the gauntlet scripts to subtract MM8/MM6 scrolls/potions as well and remove SPs from all party members
* <del>the gauntlet: lord godwinson, the coding fortress: BDJ the coding wizard, fix him (move to correct location)</del>
* inspect map d16.blv for what's changed (couldn't find anything in the first pass)
* <del>stone city check chests</del>
* trees in tularean looked strange - possible not changed file name in evt.CheckSeason checks
* <del>check chests in 7d12.blv</del>
* <del>five rings in chests in stone city</del>
* quest giving dark magic fix skills given
* duplicated items - remove them from rnditems.txt?
* <del>getItem() fixes (potions etc.)</del>
* check celeste&the pit
* d29.blv - angel messenger
* 7d28.lua - map editor stuff
* check ancient weapons in items.txt
--]]

--[[ USEFUL STUFF
shows event id when event is triggered on the map
function events.EvtMap(evtId, seq)
	Message(tostring(evtId))
end

for m, id in pairs(Editor.State.Monsters) do if id == 1 then XYZ(m, XYZ(Party)) end end
--]]

for regex, fun in pairs(replacements) do
	content = content:gsub(regex, fun)
end

content = content:replace([[Game.GlobalEvtLines.Count = 0  -- Deactivate all standard events

]], "")

local patches =
{[ [[evt.ForPlayer("All")
	if evt.Cmp("QBits", 850) then         -- BDJ Final
		evt.SetMessage(1024)         -- "Adventurer 4, select your new profession."
		evt.ForPlayer(3)
	elseif evt.Cmp("QBits", 849) then         -- BDJ 3
		evt.SetMessage(1023)         -- "Adventurer 3, select your new profession."
		evt.ForPlayer(2)
	elseif evt.Cmp("QBits", 848) then         -- BDJ 2
		evt.SetMessage(1022)         -- "Adventurer 2, select your new profession."
		evt.ForPlayer(1)
	else
		evt.SetMessage(1021)         -- "Adventurer 1, select your new profession."
		evt.ForPlayer(0)
	end]] ]
	=
	[[evt.ForPlayer("All")
	if evt.Cmp("QBits", 869) then         -- BDJ Final
		evt.SetMessage(2754)         -- "Adventurer 5, select your new profession."
		evt.ForPlayer(4)
	elseif evt.Cmp("QBits", 850) then         -- BDJ 4
		evt.SetMessage(1024)         -- "Adventurer 4, select your new profession."
		evt.ForPlayer(3)
	elseif evt.Cmp("QBits", 849) then         -- BDJ 3
		evt.SetMessage(1023)         -- "Adventurer 3, select your new profession."
		evt.ForPlayer(2)
	elseif evt.Cmp("QBits", 848) then         -- BDJ 2
		evt.SetMessage(1022)         -- "Adventurer 2, select your new profession."
		evt.ForPlayer(1)
	else
		evt.SetMessage(1021)         -- "Adventurer 1, select your new profession."
		evt.ForPlayer(0)
	end]]
}

for from, to in pairs(patches) do
	content = content:replace(from, to)
end

local genericEvtRegex = "evt%.%w-[%(%{].-[%)%}]"

local exclusions =
{
	"evt%.Add%(\"Experience\", %d+%)"
}

local i, j = content:find(genericEvtRegex, 1)
repeat
	local text = content:sub(i, j)
	local matched = false
	for regex, fun in pairs(replacements) do
		if text:match("(" .. regex .. ")") == text then -- need full capture group, as match returns only first capture group
			matched = true
			break
		end
	end
	if not matched then
		for k, regex in ipairs(exclusions) do
			if text:match("(" .. regex .. ")") == text then
				matched = true
				break
			end
		end
	end
	if not matched then
		--print("Found unfixed evt command: " .. text)
	end
	i, j = content:find(genericEvtRegex, i + 1)
until i == nil

-- Harmondale teleportal hub
content = content:replace([[-- "Challenges"
Game.GlobalEvtLines:RemoveEvent(1313)
evt.global[1313] = function()
	evt.SetMessage(1671)         -- "Scattered around the land are the Challenges.  If your ability is great enough, and you best the challenge, you will be award skill points to do with as you wish!"
end]], [[-- "Challenges"
Game.GlobalEvtLines:RemoveEvent(1313)
evt.global[1313] = function()
	evt.SetMessage(1671)         -- "Scattered around the land are the Challenges.  If your ability is great enough, and you best the challenge, you will be award skill points to do with as you wish!"
end

-- HARMONDALE TELEPORTAL HUB --

local indexes = {[0] = "A", "B", "C", "D", "E", "F"}
-- "Go back"
evt.global[1993] = function()
	for i = 0, 2 do
		Game.NPC[1255]["Event" .. indexes[i] ] = 1995 + i
	end
	Game.NPC[1255]["Event" .. indexes[3] ] = 1994
end

-- "More destinations"
evt.global[1994] = function()
	for i = 0, 1 do
		Game.NPC[1255]["Event" .. indexes[i] ] = 1998 + i
	end
	Game.NPC[1255]["Event" .. indexes[2] ] = 1993
	Game.NPC[1255]["Event" .. indexes[3] ] = 0
end

evt.CanShowTopic[1995] = function()
	return evt.All.Cmp("Inventory", 1467)
end

-- "Tatalia"
evt.global[1995] = function()
	evt.MoveToMap{X = 6604, Y = -8941, Z = 0, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "7Out13.odm"}
end

evt.CanShowTopic[1996] = function()
	return evt.All.Cmp("Inventory", 1469)
end

-- "Avlee"
evt.global[1996] = function()
	evt.MoveToMap{X = 14414, Y = 12615, Z = 0, Direction = 768, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "Out14.odm"}
end

evt.CanShowTopic[1997] = function()
	return evt.All.Cmp("Inventory", 1468)
end

-- "Deyja"
evt.global[1997] = function()
	evt.MoveToMap{X = 4586, Y = -12681, Z = 0, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "7Out05.odm"}
end

evt.CanShowTopic[1998] = function()
	return evt.All.Cmp("Inventory", 1471)
end

-- "Bracada Desert"
evt.global[1998] = function()
	evt.MoveToMap{X = 8832, Y = 18267, Z = 0, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "7Out06.odm"}
end

evt.CanShowTopic[1999] = function()
	return evt.All.Cmp("Inventory", 1470)
end

-- "Evenmorn Island"
evt.global[1999] = function()
	evt.MoveToMap{X = 17161, Y = -10827, Z = 0, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "Out09.odm"}
end]])

local file2 = io.open("GLOBAL rev4 processed.lua", "w")
file2:write(content)
io.close(file2)