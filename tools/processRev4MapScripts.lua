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

local firstGlobalLuaFreeEntry = 1817 -- that we will use

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
		[4] = 3, [101] = 55, [5] = 4, [80] = 24, [32] = 113, [110] = 121, [81] = 25, [7] = 106, [33] = 114, [100] = 53, [14] = 109, [82] = 26, [92] = 30, [83] = 27, [9] = 108, [6] = 105, [93] = 32, [94] = 34, [46] = 6, [84] = 28, [47] = 19, [95] = 38, [96] = 39, [107] = 118, [97] = 40, [98] = 51, [87] = 115, [99] = 52, [48] = 21, [106] = 117, [49] = 22, [109] = 120, [102] = 41, [108] = 119, [105] = 116, [21] = 112, [3] = 2, [15] = 110, [2] = 1, [8] = 107, [61] = 23, [20] = 111
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
		greetingAdd = 333 - 195
	end
	return greeting + greetingAdd
end

local function getItem(item)
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
		
	elseif autonote >= 128 then
		autonoteAdd = 323 - 128
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

local replacements =
{
	["evt%.Cmp%(\"QBits\", (%d+)%)"] = function(num) return ("evt.Cmp(\"QBits\", %d)"):format(getQuestBit(num)) end,
	["evt%.Set%(\"QBits\", (%d+)%)"] = function(num) return ("evt.Set(\"QBits\", %d)"):format(getQuestBit(num)) end,
	["evt%.Add%(\"QBits\", (%d+)%)"] = function(num) return ("evt.Add(\"QBits\", %d)"):format(getQuestBit(num)) end,
	["evt%.Subtract%(\"QBits\", (%d+)%)"] = function(num) return ("evt.Subtract(\"QBits\", %d)"):format(getQuestBit(num)) end,
	["evt%.Subtract%{\"QBits\", Value = (%d+)%}"] = function(num) return ("evt.Subtract{\"QBits\", Value = %d}"):format(getQuestBit(num)) end,
	["evt%.Add%{\"QBits\", Value = (%d+)%}"] = function(num) return ("evt.Add{\"QBits\", Value = %d}"):format(getQuestBit(num)) end,
	["evt%.Cmp%{\"QBits\", Value = (%d+)%}"] = function(num) return ("evt.Cmp{\"QBits\", Value = %d}"):format(getQuestBit(num)) end,
	["evt%.Set%{\"QBits\", Value = (%d+)%}"] = function(num) return ("evt.Set{\"QBits\", Value = %d}"):format(getQuestBit(num)) end,
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
		return ("evt.SetNPCTopic{NPC = %d, Index = %d, Event = %d}"):format(getNPC(npc), index, getEvent(event))
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
		return ("evt.Set(\"Inventory\", %d)"):format(getItem(item))
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

for i in path.find("rev4 map scripts\\*.lua") do
	print("Current file: " .. path.name(i))
	local file = io.open(i)
	local content = file:read("*a")
	file:close()
	for regex, fun in pairs(replacements) do
		content = content:gsub(regex, fun)
	end
	for regex, fun in pairs(replacements2) do
		content = content:gsub(regex, fun)
	end
	for regex, fun in pairs(replacementsafter) do
		content = content:gsub(regex, fun)
	end
	-- preserve MMMerge script additions
	local file = io.open("merge map scripts\\" .. getFileName(path.name(i)), "r")
	if file then
		local content2 = file:read("*a")
		content = content .. "\n\n--[[ MMMerge additions --]]\n\n" .. content2
		file:close()
	end
	if path.name(i):lower() == "out01.lua" then
	content = content .. [[

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

events.LoadMap = evt.map[100].last]]
`	end
	io.save("rev4 map scripts\\processed\\" .. getFileName(path.name(i)), content)
end