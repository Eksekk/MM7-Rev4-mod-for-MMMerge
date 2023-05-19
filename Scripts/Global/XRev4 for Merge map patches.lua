-- runs as one of first handlers for "LoadMap" event
local function replaceMapEvent(num, func, onload, hint)
    events.Remove("LoadMap", evt.map[num].last)
    evt.map[num].clear()
    if onload then
        func()
    else
        evt.map[num] = func
        if hint then
            evt.hint[num] = hint
        end
    end
end

local patches = {
    -- Temple of the Moon on Emerald Island
    ["7d06.blv"] = function()
        -- give adventurer items
        replaceMapEvent(5, function()
            if not cmpSetMapvarBool("blasterShieldGiven") then
                local changed = false
                local low, mid, high = getMonster(205), getMonster(206), getMonster(207)
                local midHigh
                for idx, m in Map.Monsters do
                    if m.Id == low then -- green adventurer
                        changed = true
                        evt.SetMonsterItem{Monster = idx, Item = getItem(658), Has = true}         -- "Contestant's Shield"
                        evt.SetMonsterItem{Monster = idx, Item = getItem(64), Has = true}         -- "Blaster"
                        break
                    elseif m.Id == mid or m.Id == high and not midHigh then
                        midHigh = idx
                    end
                end
                if not changed then
                    if midHigh then
                        evt.SetMonsterItem{Monster = midHigh, Item = getItem(658), Has = true}         -- "Contestant's Shield"
                        evt.SetMonsterItem{Monster = midHigh, Item = getItem(64), Has = true}         -- "Blaster"
                    else
                        MessageBox("Error: script giving items to monsters in temple of the moon is not working as expected, this should be reported to mod author so he can fix it and give you a command to get these items")
                    end
                end
                evt.SetMonGroupBit{NPCGroup = 4, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
            end
        end, true)

        --[[
            evt.MoveToMap{X = -3970, Y =
  5025, Z = 
  -95, Name = "7d06.blv"}
  ]]
        -- merchant barrel
        replaceMapEvent(10, function()
            evt.ForPlayer("All")
            if not evt.Cmp("QBits", getQuestBit(330)) then         -- 1-time EI temple
                evt.Set("QBits", getQuestBit(330))         -- 1-time EI temple
                giveFreeSkill(const.Skills.Merchant, 6, const.Expert)
                evt.SetSprite{SpriteId = 15, Visible = 1, Name = "sp57"}
            end
        end)
    end,
    -- Titan's Stronghold
    -- correct dispel magic on map load (asshole mechanic, but let's preserve it)
    ["7d09.lua"] = function()
        replaceMapEvent(1, function()
            -- doesn't work -- evt.CastSpell{Spell = 80, Mastery = const.GM, Skill = 21, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Dispel Magic"
            -- dispel magic
            for i, pl in Party do
                for buffid, buff in pl.SpellBuffs do
                    mem.call(0x455E3C, 1, buff["?ptr"])
                end
            end
            for i, buff in Party.SpellBuffs do
                mem.call(0x455E3C, 1, buff["?ptr"])
            end
        end, true)
    end
}

-- very important to use AddFirst("LoadMap") to remove all original handlers
-- "BeforeLoadMap()" wouldn't remove them (because they aren't loaded yet), and normal "LoadMap()" (not AddFirst("LoadMap")) would allow "OnLoadMap" events to run
events.AddFirst("LoadMap", function()
    local patch = patches[Map.Name]
    patch = patch and patch()
end)