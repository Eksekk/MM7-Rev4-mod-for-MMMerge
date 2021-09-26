local currentFile
local doNotRemoveTheseEvents =
{
	["d27.lua"] = {501, 376} -- 376 because MMMerge overwrites this event and it cleans up, 501 to fix a bug where game crashes after killing Xenofex
}

local mappingsFromMM7PromotionAwardsToMergeQBits = -- generated with generateMappingsFromMM7PromotionAwardsToMergeQBits
{
	[10] = 1560, [11] = 1561, [12] = 1562, [13] = 1563, [16] = 1566, [17] = 1567, [18] = 1568, [19] = 1569, [22] = 1572, [23] = 1573, [24] = 1574, [25] = 1575, [27] = 1577, [28] = 1578, [29] = 1579, [30] = 1580, [31] = 1581, [34] = 1584, [35] = 1585, [36] = 1586, [37] = 1587, [38] = 1588, [39] = 1589, [40] = 1590, [41] = 1591, [42] = 1592, [43] = 1593, [44] = 1594, [45] = 1595, [50] = 1596, [51] = 1597, [52] = 1598, [53] = 1599, [54] = 1600, [55] = 1601, [56] = 1602, [57] = 1603, [58] = 1604, [59] = 1605, [60] = 1606, [62] = 1607, [63] = 1608, [64] = 1609, [65] = 1610, [66] = 1611, [67] = 1612, [68] = 1613, [69] = 1614, [70] = 1615, [71] = 1616, [72] = 1617, [73] = 1618, [74] = 1619, [75] = 1620, [76] = 1621, [77] = 1622, [78] = 1623, [79] = 1624
}

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
	["evt%.Set%{\"Awards\", Value = (%d+)%}"] =
	function(award)
		award = tonumber(award)
		if mappingsFromMM7PromotionAwardsToMergeQBits[award] ~= nil then
			-- promotion award, special processing
			return ("evt.Set{\"QBits\", Value = %d}"):format(mappingsFromMM7PromotionAwardsToMergeQBits[award])
		else
			--local awards = LoadBasicTextTable("tab\\AWARDS rev4.txt", 0)
			--print("Not promotion award: " .. awards[award + 1][2])
		end
		local a2 = award
		award = getAward(award)
		if award == -1 then return ("--" .. " evt.Set{\"Awards\", Value = %d}"):format(a2) end
		return ("evt.Set{\"Awards\", Value = %d}"):format(award)
	end,
	["evt%.Add%{\"Awards\", Value = (%d+)%}"] =
	function(award)
		award = tonumber(award)
		if mappingsFromMM7PromotionAwardsToMergeQBits[award] ~= nil then
			-- promotion award, special processing
			return ("evt.Add{\"QBits\", Value = %d}"):format(mappingsFromMM7PromotionAwardsToMergeQBits[award])
		else
			--local awards = LoadBasicTextTable("tab\\AWARDS rev4.txt", 0)
			--print("Not promotion award: " .. awards[award + 1][2])
		end
		local a2 = award
		award = getAward(award)
		if award == -1 then return ("--" .. " evt.Add{\"Awards\", Value = %d}"):format(a2) end
		return ("evt.Add{\"Awards\", Value = %d}"):format(award)
	end,
	["evt%.Subtract%{\"Awards\", Value = (%d+)%}"] =
	function(award)
		award = tonumber(award)
		if mappingsFromMM7PromotionAwardsToMergeQBits[award] ~= nil then
			-- promotion award, special processing
			return ("evt.Subtract{\"QBits\", Value = %d}"):format(mappingsFromMM7PromotionAwardsToMergeQBits[award])
		else
			--local awards = LoadBasicTextTable("tab\\AWARDS rev4.txt", 0)
			--print("Not promotion award: " .. awards[award + 1][2])
		end
		local a2 = award
		award = getAward(award)
		if award == -1 then return ("--" .. " evt.Subtract{\"Awards\", Value = %d}"):format(a2) end
		return ("evt.Subtract{\"Awards\", Value = %d}"):format(award)
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
	["evt%.Cmp%{\"AutonotesBits\", Value = (%d+)%}"] =
	function(autonote)
		autonote = tonumber(autonote)
		return ("evt.Cmp{\"AutonotesBits\", Value = %d}"):format(getAutonote(autonote))
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
	end,
	["evt%.SummonMonsters%{TypeIndexInMapStats = (%d+), Level = (%d+), Count = (%d+), X = (%-?%d+), Y = (%-?%d+), Z = (%-?%d+), (%-%- ERROR: Not found%s+)NPCGroup = (%d+), unk = (%d+)%}"] =
	function(tiims, level, count, x, y, z, comment, npcgroup, unk)
		tiims = tonumber(tiims)
		level = tonumber(level)
		count = tonumber(count)
		x = tonumber(x)
		y = tonumber(y)
		z = tonumber(z)
		npcgroup = tonumber(npcgroup)
		unk = tonumber(unk)
		return ("evt.SummonMonsters{TypeIndexInMapStats = %d, Level = %d, Count = %d, X = %d, Y = %d, Z = %d, %sNPCGroup = %d, unk = %d}")
		:format(tiims, level, count, x, y, z, comment or "", npcgroup + 51, unk)
	end,
	["evt%.SummonMonsters%{TypeIndexInMapStats = (%d+), Level = (%d+), Count = (%d+), X = (%-?%d+), Y = (%-?%d+), Z = (%-?%d+), NPCGroup = (%d+), unk = (%d+)%}"] =
	function(tiims, level, count, x, y, z, npcgroup, unk)
		tiims = tonumber(tiims)
		level = tonumber(level)
		count = tonumber(count)
		x = tonumber(x)
		y = tonumber(y)
		z = tonumber(z)
		npcgroup = tonumber(npcgroup)
		unk = tonumber(unk)
		return ("evt.SummonMonsters{TypeIndexInMapStats = %d, Level = %d, Count = %d, X = %d, Y = %d, Z = %d, NPCGroup = %d, unk = %d}")
		:format(tiims, level, count, x, y, z, npcgroup + 51, unk)
	end,
	["evt%.SetSprite%{SpriteId = (%d+), Visible = (%d+), Name = \"(%w*)\"%}"] =
	function(spriteid, visible, name)
		spriteid = tonumber(spriteid)
		visible = tonumber(visible)
		if name:match("^tree") then
			local num = tonumber(name:match("%d+")) or 99
			if num <= 30 or num == 63 or num == 64 then
				return ("evt.SetSprite{SpriteId = %d, Visible = %d, Name = \"%s\"}"):format(spriteid, visible, "7" .. name)
			end
		end
		return ("evt.SetSprite{SpriteId = %d, Visible = %d, Name = \"%s\"}"):format(spriteid, visible, name)
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

for k, v in Map.Monsters do if v.NPC_ID ~= 0 then print(k, Game.NPC[v.NPC_ID].Name) end end
--]]

--[[evt.Set{"QBits", Value = 868}
evt.MoveToMap{Name = "out02.odm"}

https://discord.com/channels/296507109997019137/795807513924075540/885284417893957633
--]]
-- lord godwinson
-- brazier should phase
-- inspect event 376

--for k, v in Map.Monsters do if v.NameId ~= 0 then print (v.NameId) end end

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
	-- Coding Fortress
	-- promotion brazier support for 5 players
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
	-- Hall Under the Hill
	-- fix one tree setSprite
	["d22.lua"] = {"evt.SetSprite{SpriteId = 56, Visible = 1, Name = \"tree\"}", "evt.SetSprite{SpriteId = 56, Visible = 1, Name = \"tree37\"}"
	},
	-- Lincoln
	-- delegate exit event to Merge script
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
	-- Stone City
	-- perception skill barrel
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
	-- Colony Zod
	-- remove buggy script which is replaced in Merge anyways
	["d27.lua"] = {[[evt.map[376] = function()
	evt.SpeakNPC{NPC = 626}         -- "Roland Ironfist"
	evt.SetSprite{SpriteId = 20, Visible = 1, Name = "dec05"}
	evt.Add{"Inventory", Value = 1463}         -- "Colony Zod Key"
	evt.Add{"QBits", Value = 752}         -- Talked to Roland
	evt.Add{"History24", Value = 0}
	evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Untouchable, On = true}
	evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Invisible, On = true}
end
]], "",
	-- delegate exit event to EVT file so it doesn't crash the game (bugfix)
	[[evt.hint[501] = evt.str[2]  -- "Leave the Hive"
evt.map[501] = function()
	evt.MoveToMap{X = -18246, Y = -11910, Z = 3201, Direction = 128, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "Out12.odm"}
end
]], ""},
	-- Castle Harmondale
	-- bodybuilding skill barrel
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
end]],
	-- script processing fix
	[[evt.SetMonGroupBit{NPCGroup = 5, -- ERROR: Const not found
Bit = 0x0, On = false}]], [[evt.SetMonGroupBit{NPCGroup = 56, -- ERROR: Const not found
Bit = 0x0, On = false}]]},

	-- Red Dwarf Mines
	-- Learning skill barrel
	["d34.lua"] = {[[evt.map[10] = function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if not evt.Cmp{"QBits", Value = 847} then         -- BDJ 1
		evt.Set{"QBits", Value = 847}         -- BDJ 1
		evt.Set{"LearningSkill", Value = 70}
	end
end]], [[evt.map[10] = function()
	if not evt.Cmp{"QBits", Value = 847} then         -- BDJ 1
		evt.Set{"QBits", Value = 847}         -- BDJ 1
		evt.All.Add("Experience", 0)
		for _, pl in Party do
			local s, m = SplitSkill(pl.Skills[const.Skills.Learning])
			pl.Skills[const.Skills.Learning] = JoinSkill(math.max(s, 6), math.max(m, const.Expert))
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
end]],
	-- remove original castle harmondale enter event, as it's replaced in Merge
	[[

evt.hint[301] = evt.str[30]  -- "Enter Castle Harmondale"
Game.MapEvtLines:RemoveEvent(301)
evt.map[301] = function()
	if evt.Cmp{"QBits", Value = 610} then         -- Built Castle to Level 2 (rescued dwarf guy)
		evt.MoveToMap{X = -5073, Y = -2842, Z = 1, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 382, Icon = 9, Name = "7D29.Blv"}         -- "Castle Harmondale"
	else
		if evt.Cmp{"QBits", Value = 644} then         -- Butler only shows up once (area 2)
			evt.MoveToMap{X = -5073, Y = -2842, Z = 1, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 390, Icon = 9, Name = "7D29.Blv"}         -- "Castle Harmondale"
		else
			evt.Add{"History3", Value = 0}
			evt.SpeakNPC{NPC = 397}         -- "Butler"
			evt.MoveNPC{NPC = 397, HouseId = 240}         -- "Butler" -> "On the House"
			evt.ForPlayer(-- ERROR: Const not found
"All")
			evt.Set{"QBits", Value = 587}         -- "Clean out Castle Harmondale and return to the Butler in the tavern, On the House, in Harmondale."
			evt.Set{"QBits", Value = 644}         -- Butler only shows up once (area 2)
		end
	end
end]], "",	[[
function events.AfterLoadMap()
	Party.QBits[817] = true	-- DDMapBuff
end]], ""},
	-- Erathia
	-- fix small bug in town portal code
	["out03.lua"] = {[[evt.map[35] = function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if evt.Cmp{"Inventory", Value = 1539} then         -- "Town Portal Pass"
		evt.Subtract{"Inventory", Value = 1539}         -- "Town Portal Pass"
		evt.MoveToMap{X = -6731, Y = 14045, Z = -512, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "7Out02.Odm"}
	else
		evt.StatusText{Str = 22}         -- "You need a town portal pass!"
	end
end]], [[evt.map[35] = function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if evt.Cmp{"Inventory", Value = 1539} then         -- "Town Portal Pass"
		evt.MoveToMap{X = -6731, Y = 14045, Z = -512, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "7Out02.Odm"}
		evt.Subtract{"Inventory", Value = 1539}         -- "Town Portal Pass"
	else
		evt.StatusText{Str = 22}         -- "You need a town portal pass!"
	end
end]], [[evt.map[36] = function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if evt.Cmp{"Inventory", Value = 1539} then         -- "Town Portal Pass"
		evt.Subtract{"Inventory", Value = 1539}         -- "Town Portal Pass"
		evt.MoveToMap{X = -15148, Y = -10240, Z = 1312, Direction = 40, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "7Out04.odm"}
	else
		evt.StatusText{Str = 22}         -- "You need a town portal pass!"
	end
end]], [[evt.map[36] = function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if evt.Cmp{"Inventory", Value = 1539} then         -- "Town Portal Pass"
		evt.MoveToMap{X = -15148, Y = -10240, Z = 1312, Direction = 40, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "7Out04.odm"}
		evt.Subtract{"Inventory", Value = 1539}         -- "Town Portal Pass"
	else
		evt.StatusText{Str = 22}         -- "You need a town portal pass!"
	end
end]],
	-- brianna's brandy (identify item tea)
	[[evt.map[37] = function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if not evt.Cmp{"QBits", Value = 843} then         -- 1-time Erathia
		evt.Set{"QBits", Value = 843}         -- 1-time Erathia
		evt.Set{"IdentifyItemSkill", Value = 70}
		evt.SetSprite{SpriteId = 16, Visible = 1, Name = "sp57"}
	end
end]], [[evt.map[37] = function()
	if not evt.Cmp{"QBits", Value = 843} then         -- 1-time Erathia
		evt.Set{"QBits", Value = 843}         -- 1-time Erathia
		evt.All.Add("Experience", 0)
		for _, pl in Party do
			local s, m = SplitSkill(pl.Skills[const.Skills.IdentifyItem])
			pl.Skills[const.Skills.IdentifyItem] = JoinSkill(math.max(s, 6), math.max(m, const.Expert))
		end
		evt.SetSprite{SpriteId = 16, Visible = 1, Name = "sp57"}
	end
end]]},
	-- Bracada Desert
	-- fix dock teleporter to teleport you on the ground
	["out06.lua"] =
	{
		[[evt.MoveToMap{X = 17656, Y = -20704, Z = 800, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}]],
		[[evt.MoveToMap{X = 17656, Y = -20704, Z = 326, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}]]
	},
	-- Barrow Downs
	-- repair tea
	["out11.lua"] = {[[evt.map[10] = function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if not evt.Cmp{"QBits", Value = 833} then         -- Gepetto's Thermos
		evt.Set{"QBits", Value = 833}         -- Gepetto's Thermos
		evt.Set{"RepairSkill", Value = 71}
	end
end]], [[evt.map[10] = function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if not evt.Cmp{"QBits", Value = 833} then         -- Gepetto's Thermos
		evt.Set{"QBits", Value = 833}         -- Gepetto's Thermos
		evt.All.Add("Experience", 0)
		for _, pl in Party do
			local s, m = SplitSkill(pl.Skills[const.Skills.Repair])
			pl.Skills[const.Skills.Repair] = JoinSkill(math.max(s, 7), math.max(m, const.Expert))
		end
	end
end]]}

}

local patchesMerge =
{
	-- Tularean Forest
	-- remove event which is replaced in rev4
	["out04.lua"] = {[[

-- Clanker's Laboratory
Game.MapEvtLines:RemoveEvent(503)
evt.map[503] = function()

	if Party.QBits[710] then
		evt.MoveNPC{427, 395}
		Game.Houses[395].ExitMap = 86
		Game.Houses[395].ExitPic = 1
		evt.EnterHouse{395}
	else
		evt.MoveToMap{0,-709,1,512,0,0,395,9,"7d12.blv"}
	end

end]], ""}
}

local additions =
{
	["out01.lua"] =
	{
	-- Emerald Island
	-- add QBits and show movie on arrival
	[[

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

events.LoadMap = evt.map[100].last]]},
	-- Coding Fortress
	-- make BDJ invisible by default
	-- make BDJ hostile on save game reload/lloyd back to dungeon
	["d12.lua"] = {[[
function events.AfterLoadMap()
	-- make BDJ invisible by default
	if (not vars["BDJ hidden"]) and Game.Map.Name == "7d12.blv" then
		evt.SetMonGroupBit{NPCGroup = 60, Bit = const.MonsterBits.Invisible, On = true}
		vars["BDJ hidden"] = true
	end
	-- make BDJ hostile on save game reload/lloyd back to dungeon
	if vars["make BDJ hostile"] and Game.Map.Name == "7d12.blv" then
		evt.SetMonGroupBit{NPCGroup = 60, Bit = const.MonsterBits.Hostile, On = true}
	end
	vars["make BDJ hostile"] = true
end]]},
	-- Castle Harmondale
	-- fix for a bug where golem and messenger of the saints are visible by default
	["d29.lua"] = {[[
-- fix for a bug where golem and messenger of the saints are visible by default
function events.AfterLoadMap()
	if (not vars["Castle Harmondale NPCs hidden"]) and Game.Map.Name == "7d29.blv" then
		if not (Party.QBits[585] or Party.QBits[586]) then
			evt.SetMonGroupBit{NPCGroup = 57, Bit = const.MonsterBits.Invisible, On = true}
		end
		if not Party.QBits[647] then
			evt.SetMonGroupBit{NPCGroup = 61, Bit = const.MonsterBits.Invisible, On = true}
		end
		vars["Castle Harmondale NPCs hidden"] = true
	end
end]]},
	-- Bracada Desert
	-- fix teleporters so one of two teleporting to temple teleports to shops instead
	["out06.lua"] = {
		[[evt.hint[318] = evt.str[100]  -- ""
evt.map[318] = function()
	evt.MoveToMap{X = -14125, Y = -7638, Z = 1345, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end]]
	}
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
			content = content .. "\n\n--[[ MMMerge additions ]]--\n\n" .. content2
			file:close()
		end
	end
	
	if patchesMerge[name] ~= nil then
		for i = 1, #patchesMerge[name], 2 do
			content = content:replace(patchesMerge[name][i], patchesMerge[name][i + 1])
		end
	end
	-- convert DDMapBuffs
	local function getDDMapBuff(buff)
		local add = 921 - 801 -- 120
		return buff + add
	end
	local done
	content, done = content:gsub("Party%.QBits%[(%d+)%] = true	%-%- DDMapBuff", function(buff)
		buff = tonumber(buff)
		return ("Party.QBits[%d] = true	-- DDMapBuff, changed for rev4 for merge"):format(getDDMapBuff(buff))
	end)
	if done ~= 1 and name:find("out") ~= nil then
		print("Outdoor map " .. name .. ", no DDMapBuff replacement made - check this")
	end
	content = content:replace([[
-- Deactivate all standard events
Game.MapEvtLines.Count = 0

]], "")
	io.save("rev4 map scripts\\processed\\" .. getFileName(path.name(i)), content)
end