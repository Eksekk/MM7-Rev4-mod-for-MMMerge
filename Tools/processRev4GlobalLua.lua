local file = io.open("GLOBAL rev4.lua")
local content = file:read("*a")
io.close(file)

-- note: there is event skip at event 511 in rev4

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
* <del>check if setMonGroupBit works correctly</del>
* check search for "ERROR: Not found" and check if everything is ok near it
** do this in map scripts too
* check if blayze's quest and saving erathia quest give correct mastery - they probably don't, fix them
* check evt.ShowMovie file names
* check wtf at line 2595
* <del>check strange avlee teachers greetings ("Help me!")</del>
* resolve docent talking in emerald island - workaround is to walk into BDJ radius again, second time it sets the QBit
* <del>BDJ goodbye topic giving wrong message</del>
* <del>sort entries in mapstats</del>
* check icons for evt.MoveToMap
* integrate changes from revamp.T.lod ( incl. scripts)
* check unfixed evt commands in each script file
* check Elgar Fellmoon
* <del>process npctext</del>
* <del>fix adventurers in temple of the moon not dropping items: iterate through monsters after loading map, find adventurer index and give item to him</del>
* <del>fix skill barrels code</del>
* different sparkles for skill barrels: https://discord.com/channels/296507109997019137/296508593744773120/885066444071645245
* <del>fix mm7 barrels to give +5</del>
* fix the gauntlet scripts to subtract MM8/MM6 scrolls/potions as well and remove SPs from all party members
* <del>the gauntlet: lord godwinson, the coding fortress: BDJ the coding wizard, fix him (move to correct location)</del>
* <del>inspect map d16.blv for what's changed (couldn't find anything in the first pass)</del>
* <del>stone city check chests</del>
* trees in tularean looked strange - possible not changed file name in evt.CheckSeason checks
* <del>check chests in 7d12.blv</del>
* <del>five rings in chests in stone city</del>
* quest giving dark magic fix skills given
* duplicated items - remove them from rnditems.txt?
* <del>getItem() fixes (potions etc.)</del>
* check celeste&the pit
* <del>d29.blv - angel messenger</del>
* <del>7d28.lua - map editor stuff</del>
* <del>check ancient weapons in items.txt</del>
* <del>check d08.blv for crashes relating to Lord Godwinson placemon id</del>
* play "humming" sound when entering harmondale teleportal hub (function events.EnterNPC) (maybe looped to be longer)
* check d08.blv Lord Godwinson stats - they get affected by bolster monster
* https://gitlab.com/cthscr/mmmerge/-/wikis/Cluebook/DimensionDoor
* phasing cauldron and brazier of succor
* <del>BDJ should become hostile on game load/move into 7d12 with lloyd's beacon - use vars table</del>, same thing with 7d08.blv (monsters reappearing)
* <del>castle harmondale locked if not finished scavenger hunt, also messenger about scavenger hunt</del>
* <del>process summon monsters npcgroup</del>
* <del>inspect EI event 575 (where is it located) - answer: nowhere</del>
* <del>castle harmondale respawn -1</del>
* SBG's blessed items have red crossed circle icon when equipped
* antagarichan gems have changed descriptions in Merge, maybe preserve them?
* <del>leane shadowrunner in deyja strange message on master stealing</del> - strange in vanilla Merge too
--]]

--[[ USEFUL STUFF
shows event id when event is triggered on the map
function events.EvtMap(evtId, seq)
	Message(tostring(evtId))
end

for m, id in pairs(Editor.State.Monsters) do if id == 1 then XYZ(m, XYZ(Party)) end end

t1 = nil
for v, k in pairs(Editor.State.Monsters) do
if k == 0 then t1 = v end end
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