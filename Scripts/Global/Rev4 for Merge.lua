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

function mtm(str)
	return evt.MoveToMap{Name = str}
end

local firstGlobalLuaFreeEntry = 2000 -- that we will use
eventNumberReplacements = function(str)
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

function getQuestBit(questBit)
	return questBit + 512
end

function getNPC(npc)
	-- entries from 447 onwards are added at the end due to lack of space
	local npcAdd = 339
	if npc >= 447 then
		npcAdd = 1240 - 447
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

function getEvent(event)
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
	elseif name == "nwc.lua" then
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

function kill()
	for k, v in Map.Monsters do
		if v.Hostile then
			v.HP = 0
		end
	end
end