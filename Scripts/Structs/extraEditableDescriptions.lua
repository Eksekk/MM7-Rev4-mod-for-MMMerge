local u1, u2, u4, i1, i2, i4 = mem.u1, mem.u2, mem.u4, mem.i1, mem.i2, mem.i4
local hook, autohook, autohook2, asmpatch, call = mem.hook, mem.autohook, mem.autohook2, mem.asmpatch, mem.call
local max, min, round, random = math.max, math.min, math.round, math.random
local format = string.format

-- malloc always returns 0 (not enough memory) in mm8 multiplayer if no win xp compatibility?
local alloc, free = mem.allocMM, mem.freeMM

local formatBuffer = mem.StaticAlloc(2500)
function StrFormatGame(str, ...)
    call(0x4D9F10, 0, formatBuffer, str, ...)
    return mem.string(formatBuffer)
end

--[[
function events.BuildItemInformationBox(t)
    parameters:
    Item
    either one of these groups will be set at once (they are texts you can modify; event handler will be called three times for single item):
        Type, Enchantment, BasicStat - enchantment is also charges etc., basic stat is "armor: +X" or "Damage: 1d1+1" etc.
        Description
        Name
]]

local skillsCount = 39
function structs.f.SkillMasteryDescriptions(define)
    local skipAmount = (skillsCount + 1) * 4
    define[0].EditPChar("GM")
    [skipAmount].EditPChar("Master")
    [skipAmount*2].EditPChar("Expert")
    [skipAmount*3].EditPChar("Novice")
    .size = 4
end

local oldGame = structs.f.GameStructure
function structs.f.GameStructure(define, ...)
    oldGame(define, ...)
    define[0x5E4A30].array(0, skillsCount).struct(structs.SkillMasteryDescriptions)("SkillMasteryDescriptions")
    define[0x5E4A30].array(0, skillsCount).EditPChar("SkillDescriptionsGM")
    define[0x5E4AD0].array(0, skillsCount).EditPChar("SkillDescriptionsMaster")
    define[0x5E4B70].array(0, skillsCount).EditPChar("SkillDescriptionsExpert")
    define[0x5E4C10].array(0, skillsCount).EditPChar("SkillDescriptionsNovice")
    --define[0x5E4CB0].array(0, skillsCount).EditPChar("SkillDescriptions")
    -- some stat descriptions: 0x5E4D50
end

-- build skill information box
local function tooltipHook(includesBonus)
    return function(d)
        local t = {ExtraText = "", IncludesBonus = includesBonus, Skill = u4[d.esp + 4]}
        t.PlayerIndex, t.Player = internal.GetPlayer(u4[d.ebp - 4])
        events.call("BuildSkillInformationBox", t)
        local text = t.ExtraText
        if #text > 0 then
            local destination = d.esi
            if not includesBonus then
                text = "\f00000" .. text -- remove color (if bonus is not printed, "color tag" is not closed)
            end
            mem.copy(destination + mem.string(destination):len(), text .. "\0")
        end
    end
end
--function events.BuildSkillInformationBox(t) if t.Skill == const.Skills.Armsmaster then t.ExtraText = "\n\nThis is armsmaster"; else t.ExtraText = "\n\nThis is not armsmaster" end end
mem.autohook2(0x4174C5, tooltipHook(true), 8)
mem.autohook2(0x417648, tooltipHook(false), 8)

-- build stat description box
mem.hookcall(0x417BA5, 2, 0, function(d, def, headerPtr, textPtr)
    local header, text = mem.string(headerPtr), mem.string(textPtr)
    local t = {Stat = u4[d.ebp - 8], Header = header, Text = text}
    assert(Game.CurrentPlayer ~= -1)
    t.Player = Party[Game.CurrentPlayer]
    events.call("BuildStatInformationBox", t)
    local changedHeader, changedText = t.Header ~= header, t.Text ~= text
    if changedHeader then
        local len = #t.Header
        headerPtr = mem.allocMM(len + 1)
        mem.copy(headerPtr, t.Header)
        u1[headerPtr + len] = 0
    end
    if changedText then
        local len = #t.Text
        textPtr = mem.allocMM(len + 1)
        mem.copy(textPtr, t.Text)
        u1[textPtr + len] = 0
    end

    def(headerPtr, textPtr)

    if changedHeader then
        mem.freeMM(headerPtr)
    end
    if changedText then
        mem.freeMM(textPtr)
    end
end)

-- adjust item values
mem.hookfunction(0x453CE7, 1, 0, function(d, def, itemPtr)
	local t = {Item = structs.Item:new(itemPtr), Value = def(itemPtr)}
	events.call("CalcItemValue", t)
	return t.Value
end)

local ROW_COUNT = 5 + 5 -- items + monsters
local dynamicTextRowAddresses = mem.StaticAlloc(ROW_COUNT*4)
local dynamicTextRowContentsByIndex = {}

local function getAddrByIndex(index)
    return u4[dynamicTextRowAddresses + index * 4]
end

local function prepareTableItem(d, rows)
    local t = {}
    for _, row in pairs(rows) do
        t[row.name] = mem.string(row.addr)
        row.text = t[row.name]
    end
    t.Item = structs.Item:new(u4[d.ebp - 4])
    return t
end

local reallocAndCopyIfNeeded
do
    local allocatedSizes = {}
    -- returns address of buffer where text is stored and length of that buffer in bytes
    function reallocAndCopyIfNeeded(addr, oldStr, newStr)
        if addr and oldStr == newStr then -- have allocated buffer and text is same, just copy it (in case it was changed externally) and return
            assert(allocatedSizes[addr] >= #newStr + 1, format("[realloc text] assertion failed! Text %q (length %d) is same as before, but allocated size is smaller (%d)", newStr, #newStr + 1, allocatedSizes[addr]))
            mem.copy(addr, newStr .. string.char(0))
            return addr, #newStr + 1
        end
        local newLen = #newStr + 1 -- +1 for null terminator
        local allocatedSize = allocatedSizes[addr] or 0
        local oldAddr = addr
        if not addr or allocatedSize < newLen then -- len is length of content with null terminator
            if addr then
                free(addr)
                allocatedSizes[addr] = nil
            end
            addr = alloc(newLen)
            allocatedSizes[addr] = newLen
        end
        mem.copy(addr, newStr .. string.char(0))
        return addr, newLen
    end
end

-- content data has fields: buf, len (full buffer length)
local function processNewTexts(t, rows)
    for _, rowData in pairs(rows) do
        assert(rowData.index < ROW_COUNT)
        local contentData = tget(dynamicTextRowContentsByIndex, rowData.index)
        local buf, name = contentData.buf, rowData.name
        local current = (buf and mem.string(buf, contentData.len or nil, contentData.len and true or nil) or "")
        local bufNew, newLen = reallocAndCopyIfNeeded(buf, current, t[name])
        contentData.buf, rowData.addr, contentData.len = bufNew, bufNew, newLen
        u4[dynamicTextRowAddresses + rowData.index * 4] = bufNew
    end
end

local function itemTooltipEvent(t)
    events.cocall("BuildItemInformationBox", t)
end
local INDEX_DESCRIPTION, INDEX_NAME = 3, 4
--function events.BuildItemInformationBox(t) for k, v in pairs(t) do t[k] = randomStr("abcde", 15) end end
autohook2(0x41D40E, function(d)
    --[[
        0x270 - item type str
        0x20C - basic stat (like "Armor: +50")
        0x1A8 - enchantment/charges/power
        0x74 - full item name (assigned later)
    ]]
    local rows = {
        Type = {
            addr = d.ebp - 0x270,
            index = 0,
            name = "Type",
        },
        BasicStat = {
            addr = d.ebp - 0x20C,
            index = 1,
            name = "BasicStat",
        },
        Enchantment = {
            addr = d.ebp - 0x1A8,
            index = 2,
            name = "Enchantment",
        }
    }
    local t = prepareTableItem(d, rows)
    itemTooltipEvent(t)
    processNewTexts(t, rows)
end)

local hooks = HookManager{addresses = dynamicTextRowAddresses}

-- calc text height

-- change address ptr to index
asmpatch(0x41D405, [[
    and dword ptr [ebp-8],0
]], 9)

hooks.asmpatch(0x41D415, [[
    mov eax, dword [ebp - 8]
    mov eax, dword [%addresses% + eax * 4]
    cmp [eax], bl
]])

asmpatch(0x41D41C, "mov edx, eax")

asmpatch(0x41D438, "inc dword [ebp - 8]")

-- write text

asmpatch(0x41D591, [[
    and dword [ebp - 0x14], 0
]], 9)

hooks.asmpatch(0x41D5A1, [[
    mov eax, dword [ebp - 0x14]
    mov eax, dword [%addresses% + eax * 4]
    cmp [eax], bl
]])

hooks.asmpatch(0x41D5BB, [[
    mov edx, [ebp - 0x14]
    mov edx, [%addresses% + edx * 4]
    mov ecx,dword ptr [ebp-0x10]
]])

asmpatch(0x41D5D1, "inc dword [ebp - 0x14]")

local code = asmpatch(0x41D441, [[
    nop
    nop
    nop
    nop
    nop
    cmp [edi], bl
]])

hook(code, function(d)
    local rows = {
        Description = {
            addr = u4[d.edi + 0xC],
            index = INDEX_DESCRIPTION,
            name = "Description",
        }
    }
    local t = prepareTableItem(d, rows)
    itemTooltipEvent(t)
    processNewTexts(t, rows)
    d.edi = getAddrByIndex(INDEX_DESCRIPTION)
end)

autohook(0x41D4BD, function(d)
    local rows = {
        Name = {
            addr = d.eax,
            index = INDEX_NAME,
            name = "Name",
        }
    }
    local t = prepareTableItem(d, rows)
    itemTooltipEvent(t)
    processNewTexts(t, rows)
    d.eax = getAddrByIndex(INDEX_NAME)
end)

hook(0x41D5DA, function(d)
    d.eax = getAddrByIndex(INDEX_DESCRIPTION)
end)

autohook(0x41D60C, function(d)
    d.eax = getAddrByIndex(INDEX_NAME)
end)

function randomStr(chars, len)
    local str = ""
    for i = 1, len do
        local idx = math.random(1, chars:len())
        str = str .. chars:sub(idx, idx)
    end
    return str
end

-- ITEM NAME HOOK --
-- there are two variations, one is for any item, second for only identified items. First one jumps to second if item is identified
-- any item variant requires asmpatch to hookfunction it, because it has short jump
-- since both variations are called by game code, I need two hooks here
-- however, I opted for using hook manager to disable second hook if first is entered and reenable after finishing, to avoid unnecessary double hook
-- so "identified items only" hook is called only if game calls precisely this address, and not "any item" address

addr = asmpatch(0x453D3E, [[
    test byte ptr [ecx+0x14],1
    je absolute 0x453D58
]], 0x6)

local function getOwnBufferHookFunction(identified)
    local itemNameBuf, itemNameBufLen
    return function(d, def, itemPtr)
        local defNamePtr = def(itemPtr)
        -- identified name only means that function should only set full item names, if it's false, when item is not identified, for example only "Chain Mail" may be set
        local t = {Item = structs.Item:new(d.ecx), Name = mem.string(defNamePtr), IdentifiedNameOnly = identified}
        local prevName = t.Name
        events.call("GetItemName", t)
        if t.Name ~= prevName then
            local len = t.Name:len()
            if len <= 0x63 then
                mem.copy(0x5E4888, t.Name .. string.char(0))
            else
                if not itemNameBuf or itemNameBufLen < len + 1 then
                    if itemNameBuf then
                        free(itemNameBuf)
                    end
                    itemNameBufLen = len + 1
                    itemNameBuf = alloc(itemNameBufLen)
                end
                mem.copy(itemNameBuf, t.Name .. string.char(0))
                return itemNameBuf
            end
        end
        return defNamePtr
    end
end

local identifiedItemNameHooks = HookManager()
identifiedItemNameHooks.hookfunction(0x453D58, 1, 0, getOwnBufferHookFunction(true))

local secondHookFunc = getOwnBufferHookFunction(false)
mem.hookfunction(addr, 1, 0, function(d, def, itemPtr)
    identifiedItemNameHooks.Switch(false)
    local r = secondHookFunc(d, def, itemPtr)
    identifiedItemNameHooks.Switch(true)
    return r
end)

-- IDENTIFY MONSTER TOOLTIP

-- in monster rightclick function:
-- u4[d.ebp - 8] = pointer to structs.Dlg that will be used
-- u4[u4[d.ebp - 8] + 8] = dialog width!
-- u4[u4[d.ebp - 8] + 12] = dialog height!

local textBufferPtr = 0x5DF0E0
local deferredTextCallParams = {} -- effects are drawn one-by-one, and I want event to encompass all of them, so need to defer actual draw calls
local CALL_PARAM_EFFECTS_FIRST, CALL_PARAM_NAME, CALL_PARAM_HP, CALL_PARAM_AC, CALL_PARAM_ATTACK, CALL_PARAM_DAMAGE, CALL_PARAM_SPELLS, CALL_PARAM_SPELL1, CALL_PARAM_SPELL2, CALL_PARAM_RESISTANCES -- index in above table
local effectTextRows -- will hold number of rows for individual effects or header, which would be written to tooltip

-- index ids
local MON_TOOLTIP_NAME_INDEX, MON_TOOLTIP_DAMAGE_INDEX, MON_TOOLTIP_SPELLS_INDEX, MON_TOOLTIP_RESISTANCES_INDEX, MON_TOOLTIP_EFFECTS_HEADER_INDEX, MON_TOOLTIP_EFFECTS_INDEX = 5, 6, 7, 8, 9, 10

local function setupVariables()
    table.clear(deferredTextCallParams)
    effectTextRows = 0
end

-- structs.Fnt.Draw()
--cl, str['?ptr'] or tostring(str), opaque, bottom, clShadow)
local function writeTextInTooltip(dlg, fontPtr, x, y, color, text, opaque, bottom, shadowColor)
    return call(0x44A50F, 2, dlg, fontPtr, x, y, color, text, opaque, bottom, shadowColor)
end

local function insertDeferredCallParams(d, identified, ...)
    identified = identified == nil and true or identified -- default true if not specified
    local par = {d:getparams(2, 7)}
    table.insert(par, identified)
    for i = 1, select("#", ...) do
        table.insert(par, (select(i, ...)))
    end
    table.insert(deferredTextCallParams, par)
    d:ret(7*4) -- pop 7 arguments
    -- copy text, because it will be overwritten
    local last = deferredTextCallParams[#deferredTextCallParams]
    local str = mem.string(last[6])
    local space = alloc(#str + 1)
    mem.copy(space, str .. string.char(0))
    last[6] = space
end

local function getCoordsFromDeferredCall(def)
    return def[3], def[4]
end

local function monsterTooltipEvent(t)
    events.cocall("BuildMonsterInformationBox", t)
end

--do return end -- tmp

local function prepareTableMonster(d, rows, identified)
    local t = {}
    for _, row in pairs(rows) do
        t[row.name] = mem.string(row.addr) -- actual field name, like "Resistances"
        row.text = t[row.name]
    end
    t.Monster = Game.DialogLogic.MonsterInfoMonster
    t.Identified = identified
    return t
end

local function genericMonsterTooltipHook(rows, identified)
    return function(d)
        -- recalc offset if possible, to allow both generic hooks and dynamic offsets at the same time
        for name, row in pairs(rows) do
            row.addr = row.calcOffset and row.calcOffset(d) or row.addr
        end
        local t = prepareTableMonster(d, rows, identified)
        monsterTooltipEvent(t)
        processNewTexts(t, rows)
        -- allow setting registers to new buffer addresses etc.
        for name, row in pairs(rows) do
            if row.customAfter then
                row.customAfter(d, t)
            end
        end
    end
end

-- name
-- can be from NPC_ID or monster id
hook(0x41E027, function(d)
    -- setup variables, because it's first and always called
    setupVariables()
    -- insert name
    insertDeferredCallParams(d, true)
    CALL_PARAM_NAME = #deferredTextCallParams
end)

-- Screen.Buffer
-- single pixel in order: blue, red, green; 5 bits each (single pixel 2 bytes)

-- HOOKCALL all draw text calls, increasing dialog size and drawing coordinates as needed (compare text height call of old text and new)

hook(0x41E1C5, function(d) -- replace "Effects:" text draw call; is always called, so setting variables here
    insertDeferredCallParams(d, u4[d.ebp - 0x28] ~= 0)
    CALL_PARAM_EFFECTS_FIRST = #deferredTextCallParams
end)
hook(0x41E345, function(d) -- replace draw text call for all effects
    insertDeferredCallParams(d, nil, u4[d.ebp - 0x2C]) -- last arg is effect id
    effectTextRows = effectTextRows + 1
end)
hook(0x41E393, function(d) -- "None" text
    insertDeferredCallParams(d, nil, -1)
    effectTextRows = effectTextRows + 1
end)

hook(0x41E3D1, function(d) -- HP text
    insertDeferredCallParams(d, true)
    CALL_PARAM_HP = #deferredTextCallParams
end)

hook(0x41E422, function(d) -- HP text, not identified
    insertDeferredCallParams(d, false)
    CALL_PARAM_HP = #deferredTextCallParams
end)

hook(0x41E460, function(d) -- AC, both identified and not (different params are passed)
    local identified = u4[d.ebp - 0x1C] ~= 0
    insertDeferredCallParams(d, identified)
    CALL_PARAM_AC = #deferredTextCallParams
end)

hook(0x41E530, function(d) -- Attack text
    insertDeferredCallParams(d, true)
    CALL_PARAM_ATTACK = #deferredTextCallParams
end)

hook(0x41E5CB, function(d) -- Attack text, not identified
    insertDeferredCallParams(d, false)
    CALL_PARAM_ATTACK = #deferredTextCallParams
end)

hook(0x41E60D, function(d) -- Damage text, both identified and not
    insertDeferredCallParams(d, u4[d.ebp - 0x24] ~= 0)
    CALL_PARAM_DAMAGE = #deferredTextCallParams
    -- set spell variables (always called before drawing spell text)
    CALL_PARAM_SPELL1, CALL_PARAM_SPELL2 = -1, -1
end)

hook(0x41E68A, function(d) -- first spell
    insertDeferredCallParams(d, true)
    CALL_PARAM_SPELL1 = #deferredTextCallParams
end)

hook(0x41E6D8, function(d) -- second spell
    insertDeferredCallParams(d, true)
    CALL_PARAM_SPELL2 = #deferredTextCallParams
end)

hook(0x41E73B, function(d) -- "None" spell
    insertDeferredCallParams(d, true)
    CALL_PARAM_SPELL1 = #deferredTextCallParams
end)

hook(0x41E76F, function(d) -- "Resistances" header
    insertDeferredCallParams(d, true)
    CALL_PARAM_RESISTANCES = #deferredTextCallParams
end)

hook(0x41E8B7, function(d) -- every resistance text, identified
    insertDeferredCallParams(d, true, u4[d.ebp - 0x14]:div(4))
end)

hook(0x41E90C, function(d) -- every resistance text, not identified
    insertDeferredCallParams(d, false, u4[d.ebp - 0x20])
end)

-- final hook, does all drawing
autohook(0x41E928, function(d)
    -- this one will be different - will have table of strings for effect names
    local effectsHeaderEntry = deferredTextCallParams[CALL_PARAM_EFFECTS_FIRST]
    local nameEntry = deferredTextCallParams[CALL_PARAM_NAME]
    local attackEntry = deferredTextCallParams[CALL_PARAM_ATTACK]
    local damageEntry = deferredTextCallParams[CALL_PARAM_DAMAGE]
    local armorClassEntry = deferredTextCallParams[CALL_PARAM_AC]
    local hitPointsEntry = deferredTextCallParams[CALL_PARAM_HP]
    local spellFirstEntry = deferredTextCallParams[CALL_PARAM_SPELL1]
    local spellSecondEntry = deferredTextCallParams[CALL_PARAM_SPELL2]
    local resistancesEntry = deferredTextCallParams[CALL_PARAM_RESISTANCES]
    local dlg, fontPtr, x, y, color, _, opaque, bottom, shadowColor, identifiedHeader = unpack(effectsHeaderEntry) -- TMP, remove later, use stored arguments

    local t = {}
    t.Monster = Game.DialogLogic.MonsterInfoMonster
    t.Tooltip = structs.Dlg:new(u4[d.ebp - 8])
    local function simpleParam(name, entry)
        t[name] = mem.string(entry[6])
        t["Identified" .. name] = entry[10]
    end
    simpleParam("Name", nameEntry)
    simpleParam("Attack", attackEntry)
    simpleParam("Damage", damageEntry)
    simpleParam("ArmorClass", armorClassEntry)
    simpleParam("HitPoints", hitPointsEntry)
    if spellFirstEntry then
        simpleParam("SpellFirst", spellFirstEntry)
    end
    if spellSecondEntry then
        simpleParam("SpellSecond", spellSecondEntry)
    end

    -- header and multiple lines, numRows excludes header
    local function complexParam(headerField, itemsField, identifiedField, firstEntryIndex, numRows)
        local entryHeader = deferredTextCallParams[firstEntryIndex]
        t[headerField] = mem.string(entryHeader[6])
        t[itemsField] = {}
        for i = firstEntryIndex + 1, firstEntryIndex + numRows do
            local entry = deferredTextCallParams[i]
            -- effects and resistances are in form of table {Text = "Fire", Id = 0} in original order, but finally only text is used
            -- Id is not present in case of effects "None" text entry
            local extra = entry[11] or -1
            table.insert(t[itemsField], {Text = mem.string(entry[6]), Id = extra > -1 and extra or nil}) -- extra param
        end
        t[identifiedField] = entryHeader[10] -- effects identify result is stored in header field
    end
    -- effects
    complexParam("EffectsHeader", "Effects", "IdentifiedEffects", CALL_PARAM_EFFECTS_FIRST, effectTextRows)
    -- t.EffectsHeader = mem.string(effectsHeaderEntry[6])
    -- t.Effects = {}
    -- for i = CALL_PARAM_EFFECTS_FIRST + 1, CALL_PARAM_EFFECTS_FIRST + effectTextRows do
    --     local entry = deferredTextCallParams[i]
    --     -- effects and resistances are in form of table {Text = "Fire", Id = 0} in original order, but finally only text is used
    --     table.insert(t.Effects, {Text = mem.string(entry[6]), Id = assert(entry[11])})) -- extra param
    -- end
    -- t.IdentifiedEffects = effectsHeaderEntry[10] -- effects identify result is stored in header field

    -- resistances
    complexParam("ResistancesHeader", "Resistances", "IdentifiedResistances", CALL_PARAM_RESISTANCES, 10)

    function t.drawCustomText(fontPtr, text, x, y) -- TODO: add font args etc.
        --writeTextInTooltip(dlg, fontPtr, x, y, color, text, opaque, bottom, shadowColor)
    end

    monsterTooltipEvent(t)

    -- free dynamically relocated texts (using only event args table entries from now on)
    for i, v in ipairs(deferredTextCallParams) do
        free(v[6])
    end

    -- draw text

    local function drawFromEntry(entry, text, x, y)
        local dlg, fontPtr, xx, yy, color, _, opaque, bottom, shadowColor = unpack(entry)
        x, y = x or xx, y or yy
        writeTextInTooltip(dlg, fontPtr, x, y, color, mem.topointer(text), opaque, bottom, shadowColor)
    end

    -- if nil or false, drawing is skipped for particular line
    local function drawOptional(entry, str)
        if entry and str then -- spells entry can be nil
            drawFromEntry(entry, str)
        end
    end
    -- name
    drawOptional(nameEntry, t.Name)
    drawOptional(damageEntry, t.Damage)
    drawOptional(armorClassEntry, t.ArmorClass)
    drawOptional(hitPointsEntry, t.HitPoints)
    drawOptional(spellFirstEntry, t.SpellFirst)
    drawOptional(spellSecondEntry, t.SpellSecond)

    drawOptional(deferredTextCallParams[CALL_PARAM_EFFECTS_FIRST], t.EffectsHeader)
    drawOptional(deferredTextCallParams[CALL_PARAM_RESISTANCES], t.ResistancesHeader)

    --[[
        simpleParam("Attack", attackEntry)
    simpleParam("Damage", damageEntry)
    simpleParam("ArmorClass", armorClassEntry)
    simpleParam("HitPoints", hitPointsEntry)
    if spellFirstEntry then
        simpleParam("SpellFirst", spellFirstEntry)
    end
    if spellSecondEntry then
        simpleParam("SpellSecond", spellSecondEntry)
    end
    ]]

    local function drawMultipleTexts(textEntries, deferredEntry, xadd, yadd)
        local dlg, fontPtr, x, y, color, _, opaque, bottom, shadowColor = unpack(deferredEntry)
        for i = 1, #textEntries do
            local mul = i - 1
            writeTextInTooltip(dlg, fontPtr, x + xadd * mul, y + yadd * mul, color, textEntries[i].Text, opaque, bottom, shadowColor)
        end
    end
    -- effects
    if t.Effects then
        drawMultipleTexts(t.Effects, assert(deferredTextCallParams[CALL_PARAM_EFFECTS_FIRST + 1]), 0, 10)
    end
    -- resistances
    if t.Resistances then
        drawMultipleTexts(t.Resistances, assert(deferredTextCallParams[CALL_PARAM_RESISTANCES + 1]), 0, 10)
    end
    -- x, y = getCoordsFromDeferredCall(effectsHeaderEntry)
    -- if t.EffectsHeader then
    --     drawFromEntry(effectsHeaderEntry, t.EffectsHeader, x, y)
    --     --writeTextInTooltip(dlg, fontPtr, x, y, color, mem.topointer(t.EffectsHeader), opaque, bottom, shadowColor)
    -- end
    -- y = y + 12 -- todo

    -- for i, effectStr in ipairs(t.Effects) do
    --     drawFromEntry(effectsHeaderEntry, effectStr, x + 13, y)
    --     --writeTextInTooltip(dlg, fontPtr, x + 13, y, color, mem.topointer(effectStr), opaque, bottom, shadowColor)
    --     y = y + 12
    -- end
end)
--function events.BuildMonsterInformationBox(t) if t.EffectsHeader then t.EffectsHeader = "lol"; table.insert(t.Effects, 1, "first"); table.insert(t.Effects, "second") end end

-- function events.BuildMonsterInformationBox(t) debug.Message(dump(t)) end
function events.BuildMonsterInformationBox(t)
    t.Damage = StrFormatGame("%s\f%05u\t080%s\n", "Damage:", "500-1000 (phys)")
    t.SpellSecond = nil
    t.SpellFirst = StrFormatGame("%s\f%05u\t060%s\n", "Spell:", "Fireball (100-200)")
end