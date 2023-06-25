-- will contain various consts which were previously in separate scripts
rev4m = rev4m or {}
rev4m.const = rev4m.const or {}
rev4m.const.firstNewSpcBonus = 178
rev4m.const.spcBonuses = rev4m.const.spcBonuses or {}
rev4m.const.spcBonuses.permanence = rev4m.const.firstNewSpcBonus

rev4m.const.firstNewPlaceMon = 196
do
    local p = rev4m.const.firstNewPlaceMon
    rev4m.placeMon = {
        wromthrax = p,
        megaDragon = p + 1,
        clankerWizard = p + 2,
        tulareanJailer = p + 3,
        infernalTroglodyte = p + 4,
        deyjaNecro = p + 5,
        primordialBarrowWight = p + 6,
        derelictAdventurer = p + 7,
        unrelentingSoldier = p + 8,
        masterThiefAdvisor = p + 9,
        theOldestTitan = p + 10,
    }
end
rev4m.path = rev4m.path or {}
-- all paths are relative to game folder
rev4m.path.mergeMapScripts = "merge map scripts\\" -- not decompiled, but found in Scripts/Maps only
rev4m.path.originalRev4Scripts = "rev4 map scripts\\" -- only those changed in rev4, decompiled
rev4m.path.processedRev4Scripts = "rev4 map scripts\\processed\\"
rev4m.path.originalOtherMapScripts = "other map scripts\\" -- other existing map scripts from Merge
rev4m.path.processedOtherMapScripts = "other map scripts\\processed\\"
rev4m.path.rev4GlobalLua = "GLOBAL rev4.lua"
rev4m.path.processedRev4GlobalLua = "combined processed scripts\\GLOBAL.lua"

-- temporary, for testing
rev4m.path.processedRev4Scripts = "combined processed scripts\\"
rev4m.path.processedOtherMapScripts = "combined processed scripts\\"

-- relative to modules folder, for use in require
rev4m.modulePaths = rev4m.modulePaths or {}
rev4m.modulePaths.awardMappings = "rev4m\\generateMappingsFromMM7PromotionAwardsToMergeQBits"
rev4m.modulePaths.awardsTranslationTable = "rev4m\\generateAwardsTranslationTable"

-- SCRIPT REPLACEMENT FUNCTIONS

-- returns generic add/set/cmp/sub handler
local function actionReplacement(format, action, func)
    return function(num)
        num = tonumber(num)
        -- allow changing action by provided function (used by inventory set)
        -- or even entire format string
        local val, actionOverride, formatOverride = func(num, action)
        return (formatOverride or format):format(actionOverride or action, val)
    end
end

rev4m.f = rev4m.f or {}

rev4m.const.firstGlobalLuaFreeEntry = 2000 -- that we will use
local function globalEventNumberReplacements(str)
	local noMappingEvents = {{501, 506}, {513, 515}} -- for some reason these events from MM7 are put in the middle of MM8 events and require no numeric change
	local lastOriginalMM7Event = 572
	return function(num)
		num = tonumber(num)
		local add
		if (num >= noMappingEvents[1][1] and num <= noMappingEvents[1][2]) or (num >= noMappingEvents[2][1] and num <= noMappingEvents[2][2]) then
			add = 0
		else
			if num > lastOriginalMM7Event then -- new rev4 event, moved to end
				add = rev4m.const.firstGlobalLuaFreeEntry - (lastOriginalMM7Event + 1)
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

local function cmpAddSetSub(str, func)
    -- r = evt.%s("QBits", %s)
    -- regex = r:format("%s", "(%%d+)")
    -- format = r:format("%s", "%d")
    -- also maybe normal regex escape and then replacing double percent signs would work?
    --local regex, format = str:gsub("([^%w%%])", string.rep("%%", 4) .. "%1"):format("%s", "(%%d+)"), str:format("%s", "%d")
    --:format("%s", "(%%d+)"):format("Cmp")
    --('evt.%s("QBits", %s)'):gsub("([^%w%%])", "%%%%%1"):format("Cmp", "(%d+)")
    local regex, format = (str:gsub("([^%w%%])", "%%%%%1")), str:format("%s", "%d")
    for _, action in ipairs{"Cmp", "Add", "Set", "Sub", "Subtract"} do
        rev4m.scriptReplacements[regex:format(action, "(%d+)")] = actionReplacement(format, action, func)
    end
end

local mappingsFromMM7PromotionAwardsToMergeQBits = require(rev4m.modulePaths.awardMappings)

rev4m.scriptReplacements =
{
    ["evt%.CanShowTopic%[(%d+)%]"] = globalEventNumberReplacements("evt.CanShowTopic[%d]"),
    ["evt%.global%[(%d+)%]"] = globalEventNumberReplacements("evt.global[%d]"),
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
        --local indexes = {[0] = "A", "B", "C", "D", "E", "F"}
        --return ("evt.SetNPCTopic{NPC = %d, Index = %d, Event = %d}"):format(getNPC(npc), index, getGlobalEvent(event))
        return ("Game.NPC[%d].Events[%d] = %d"):format(getNPC(npc), index, getGlobalEvent(event))
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
    ["evt%.ChangeEvent%((%d+)%)"] = 
    function(event)
        event = tonumber(event)
        return ("evt.ChangeEvent(%d)"):format(getGlobalEvent(event))
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
    end,
    ["evt%.HouseDoor%((%d+),%s*(%d+)%)"] = function(event, house)
        event = tonumber(event)
        house = tonumber(house)
        return string.format("Game.MapEvtLines:RemoveEvent(%d)\nevt.HouseDoor(%d, %d)", event, event, getHouseID(house))
    end,
    ["for pl = 0, Party%.High %- 1 do"] = function()
        return "for pl = 0, Party.High do"
    end,
}

-- _G to make clear these are globals defined elsewhere (in this case in development functions script)
-- TODO: possible race condition if award replacement runs first, transforms award into qbit and then qbit replacement runs
cmpAddSetSub("evt.%s(\"QBits\", %s)", function(num) return _G.getQuestBit(num) end) -- wrap in function because getQuestBit is not defined yet
cmpAddSetSub("evt.%s(\"NPCs\", %s)", function(num) return _G.getNPC(num) end)
cmpAddSetSub("evt.%s(\"Awards\", %s)", function(award)
    if mappingsFromMM7PromotionAwardsToMergeQBits[award] ~= nil then
        -- promotion award, special processing
        return mappingsFromMM7PromotionAwardsToMergeQBits[award], nil, "evt.%s(\"QBits\", %d)"
    else
        --local awards = LoadBasicTextTable("tab\\AWARDS rev4.txt", 0)
        --print("Not promotion award: " .. awards[award + 1][2])
    end
    local a2 = award
    award = _G.getAward(award)
    if award == -1 then
        return a2, nil, "-- evt.%s(\"Awards\", %d)"
    end
    return award
end)

cmpAddSetSub("evt.%s(\"Inventory\", %s)", function(item, action)
    -- apparently evt.Set("Inventory", num) makes character diseased... (tested on Emerald Island ship, water master)
    return _G.getItem(item), action == "Set" and "Add" or action
end)

cmpAddSetSub("evt.%s(\"AutonotesBits\", %s)", function(num) return _G.getAutonote(num) end)

local doNotRemoveTheseEvents =
{
    ["d27.lua"] = {501, 376}, -- 376 because MMMerge overwrites this event and cleans it up, 501 to fix a bug where game crashes after killing Xenofex when exiting, only when using lua script
}

table.copy(-- replacements specific to map scripts
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
    ["evt%.SpeakNPC%((%d+)%)"] =
    function(npc)
        npc = tonumber(npc)
        return ("evt.SpeakNPC(%d)"):format(getNPC(npc))
    end,
    ["evt%.SetMonsterItem%{Monster = (%d+), Item = (%d+), Has = (%w+)%}"] =
    function(monster, item, has)
        monster = tonumber(monster)
        item = tonumber(item)
        return ("evt.SetMonsterItem{Monster = %d, Item = %d, Has = %s}"):format(monster, getItem(item), has)
    end,
    ["evt%.map%[(%d+)%] = function"] =
    function(event)
        event = tonumber(event)
        local doNotRemoveEntry = doNotRemoveTheseEvents[rev4m.currentlyProcessedScript]
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
    end,
}, rev4m.scriptReplacements, true)

-- difficulty
const.Difficulty =
{
	Easy = 0,
	Medium = 1,
	Normal = 1,
	Hard = 2
}

modSettingsDifficulty = Merge.ModSettings.Rev4ForMergeDifficulty
difficulty = modSettingsDifficulty and modSettingsDifficulty >= 0 and modSettingsDifficulty <= 2 and math.floor(modSettingsDifficulty) == modSettingsDifficulty and modSettingsDifficulty or const.Difficulty.Easy
isEasy = function() return difficulty == const.Difficulty.Easy end
isMedium = function() return difficulty == const.Difficulty.Medium end
isNormal = isMedium
isHard = function() return difficulty == const.Difficulty.Hard end

function diffsel(...)
	return assert(select(difficulty + 1, ...))
end

-- FIX EVENMORN ISLAND MERGE TILES bug
-- also need to swap grass and water tilesets
--[[
local s = Editor.State
local mapStr = s.TileMap
mapStr = mapStr:gsub("(.)", function(b)
    local val = b:byte()
    if val >= 90 and val <= 113 then
        return string.char(val + 36)
    elseif val >= 126 and val <= 149 then
        return string.char(val - 36)
    else
        return b
    end
end)
s.TileMap = mapStr
Editor.NeedStateSync()

-- tatalia
local s = Editor.State
local mapStr = s.TileMap
mapStr = mapStr:gsub("(.)", function(b)
    local val = b:byte()
    if val >= 198 and val <= 221 then
        return string.char(val - 72)
    elseif val >= 126 and val <= 149 then
        return string.char(val + 72)
    else
        return b
    end
end)
s.TileMap = mapStr
Editor.NeedStateSync()
]]

function updateMonsterIndexes(tbl, monsterTableKey, indexes)
    if tbl[monsterTableKey] then
        --debug.Message("Indexes to change:", dump(indexes))
        local changedIndexes = {}
        local c = 0
        for from, to in pairs(indexes) do
            if tbl[monsterTableKey][from] then
                changedIndexes[to] = tbl[monsterTableKey][from]
                c = c + 1
            end
        end
        -- don't assign directly to not break existing references to index table
        table.clear(tbl[monsterTableKey])
        table.copy(changedIndexes, tbl[monsterTableKey], true)
        --debug.Message(string.format("Changed monster indexes: %d, Map.Monsters size: %d, file: %q", c, Map.Monsters.Count, debug.FunctionFile(debug.getinfo(2, "f").func)))
    end
end