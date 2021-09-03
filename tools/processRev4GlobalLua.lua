local file = io.open("GLOBAL rev4.lua")
local content = file:read("*a")
io.close(file)

local firstGlobalLuaFreeEntry = 1817 -- that we will use
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
		return str:format(num + add)
	end
end
-- note: there is event skip at event 511 in rev4

local replacements =
{
	["evt%.CanShowTopic%[(%d+)%]"] = eventNumberReplacements("evt.CanShowTopic[%d]"),
	["evt%.global%[(%d+)%]"] = eventNumberReplacements("evt.global[%d]"),
	["evt%.Cmp%(\"QBits\", (%d+)%)"] = function(num) return ("evt.Cmp(\"QBits\", %d)"):format(tonumber(num) + 512) end,
	["evt%.Set%(\"QBits\", (%d+)%)"] = function(num) return ("evt.Set(\"QBits\", %d)"):format(tonumber(num) + 512) end,
	["evt%.Add%(\"QBits\", (%d+)%)"] = function(num) return ("evt.Add(\"QBits\", %d)"):format(tonumber(num) + 512) end,
	["evt%.Subtract%(\"QBits\", (%d+)%)"] = function(num) return ("evt.Subtract(\"QBits\", %d)"):format(tonumber(num) + 512) end,
	["evt%.SetMessage%((%d+)%)"] =
	function(num)
		-- entries from 768 onwards are added at the end due to lack of space
		num = tonumber(num)
		local add = 938
		if num >= 768 then
			add = 2714 - 768
		end
		return ("evt.SetMessage(%d)"):format(tonumber(num) + add)
	end,
	["evt%.SetNPCTopic%{NPC = (%d+), Index = (%d+), Event = (%d+)%}"] =
	function(npc, index, event)
		npc = tonumber(npc)
		event = tonumber(event)
		-- entries from 447 onwards are added at the end due to lack of space
		local npcAdd = 339
		if npc >= 447 then
			npcAdd = 1225 - 447
		end
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
		
		return ("evt.SetNPCTopic{NPC = %d, Index = %d, Event = %d}"):format(npc + npcAdd, index, event ~= 0 and (event + eventAdd) or 0)
	end,
	["evt%.Subtract%(\"NPCs\", (%d+)%)"] =
	function(npc)
		npc = tonumber(npc)
		-- entries from 447 onwards are added at the end due to lack of space
		local npcAdd = 339
		if npc >= 447 then
			npcAdd = 1225 - 447
		end
		return ("evt.Subtract(\"NPCs\", %d)"):format(npc + npcAdd)
	end,
	["evt%.Add%(\"Awards\", (%d+)%)"] =
	function(award)
		award = tonumber(award)
		local translationTableFromRev4ToMerge = -- generated with generateAwardsTranslationTable
		-- awards.txt in merge is a shitshow (interspersed MM7/MM8 awards), that's why I'm using a translation table
		{
			[4] = 3, [101] = 55, [21] = 111, [80] = 24, [61] = 23, [110] = 119, [81] = 25, [7] = 106, [33] = 112, [100] = 53, [82] = 26, [8] = 107, [83] = 27, [9] = 108, [6] = 105, [93] = 32, [94] = 34, [46] = 6, [84] = 28, [47] = 19, [95] = 38, [96] = 39, [107] = 116, [97] = 40, [98] = 51, [87] = 113, [99] = 52, [48] = 21, [106] = 115, [49] = 22, [109] = 118, [108] = 117, [105] = 114, [3] = 2, [5] = 4, [2] = 1, [15] = 109, [92] = 30, [20] = 110
		}
		local ret
		if translationTableFromRev4ToMerge[award] ~= nil then
			ret = translationTableFromRev4ToMerge[award]
		else
			print("Couldn't find award in merge for number " .. award)
			return "" -- delete this, as promoted awards apparently are not in Merge
		end
		return ("evt.Add(\"Awards\", %d)"):format(ret)
	end,
	["evt%.SetNPCGroupNews%{NPCGroup = (%d+), NPCNews = (%d+)%}"] = 
	function(group, news)
		return ("evt.SetNPCGroupNews{NPCGroup = %d, NPCNews = %d}"):format(group + 51, news + 51)
	end
}
--[[ THINGS TO FIX MANUALLY
* blayze's quest change to work with 5 players
* BDJ's class change code to work with 5 players
--]]

--[[ TODO
* fix evt.(something)("NPCs") (probably requires special treatment in Merge)
* fix evt.SetNPCTopic to work with skill mastery change topics (like master sword)
--]]

for regex, fun in pairs(replacements) do
	content = content:gsub(regex, fun)
end

local file2 = io.open("GLOBAL rev4 processed.lua", "w")
file2:write(content)
io.close(file2)