local patches
-- very important to use AddFirst("LoadMap") to remove all original handlers
-- "BeforeLoadMap()" wouldn't remove them (because they aren't loaded yet), and normal "LoadMap()" (not AddFirst("LoadMap")) would allow "OnLoadMap" events to run
events.AddFirst("LoadMap", function()
    local patch = patches[Map.Name]
    patch = patch and patch()
end)

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

patches = {
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
    ["7d09.blv"] = function()
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
    end,

    -- THOSE BELOW ARE NOT TESTED --

    -- Zokarr's Tomb
    -- fix barrow IV enter coordinates
    ["7d13.blv"] = function()
        replaceMapEvent(501, function()
            local i
            i = Game.Rand() % 6
            if i >= 3 and i <= 5 then
                evt.MoveToMap{X = 335, Y = -1064, Z = 1, Direction = 768, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = getFileName("MDK02.blv")}
            else
                evt.MoveToMap{X = -21, Y = -2122, Z = 0, Direction = 1408, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = getFileName("MDT02.blv")}
            end
        end)
    end,
    -- Wine Cellar
    -- require actually killing the vampire (don't set QBit on map leave)
    ["7d16.blv"] = function()
        replaceMapEvent(501, function()
            evt.MoveToMap{X = 8216, Y = -10619, Z = 289, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 1, Name = getFileName("Out13.odm")}
        end)
    end,
    -- Hall Under the Hill
    -- fix one tree setSprite
    ["7d22.blv"] = function()
        replaceMapEvent(460, function()  -- function events.LoadMap()
            if evt.Cmp("MapVar50", 1) then
                evt.SetSprite{SpriteId = 51, Visible = 1, Name = "tree37"}
            else
                evt.SetSprite{SpriteId = 51, Visible = 1, Name = "tree38"}
            end
            if evt.Cmp("MapVar51", 1) then
                evt.SetSprite{SpriteId = 52, Visible = 1, Name = "tree37"}
            else
                evt.SetSprite{SpriteId = 52, Visible = 1, Name = "tree38"}
            end
            if evt.Cmp("MapVar52", 1) then
                evt.SetSprite{SpriteId = 53, Visible = 1, Name = "tree37"}
            else
                evt.SetSprite{SpriteId = 53, Visible = 1, Name = "tree38"}
            end
            if evt.Cmp("MapVar53", 1) then
                evt.SetSprite{SpriteId = 54, Visible = 1, Name = "tree37"}
            else
                evt.SetSprite{SpriteId = 54, Visible = 1, Name = "tree38"}
            end
            if evt.Cmp("MapVar54", 1) then
                evt.SetSprite{SpriteId = 55, Visible = 1, Name = "tree37"}
            else
                evt.SetSprite{SpriteId = 55, Visible = 1, Name = "tree38"}
            end
            if evt.Cmp("MapVar55", 1) then
                evt.SetSprite{SpriteId = 56, Visible = 1, Name = "tree37"}
            else
                evt.SetSprite{SpriteId = 56, Visible = 1, Name = "tree38"}
            end
        end, true)
    end,
    -- Stone City
    -- perception skill barrel
    ["7d24.blv"] = function()
        replaceMapEvent(10, function()
            if not evt.Cmp("QBits", getQuestBit(334)) then         -- 1-time stone city
                evt.Set("QBits", getQuestBit(334))         -- 1-time stone city
                giveFreeSkill(const.Skills.Perception, 6, const.Expert)
            end
        end)
    end,
    -- Colony Zod
    -- delegate exit event to EVT file so it doesn't crash the game (bugfix)
    ["7d27.blv"] = function()
        replaceMapEvent(501, function() end)
    end,
    -- Castle Harmondale
		-- bodybuilding skill barrel
	["7d29.lua"] = function()
        replaceMapEvent(37, function()
            if not evt.Cmp("QBits", getQuestBit(317)) then         -- 1-time Castle Harm
                evt.Set("QBits", getQuestBit(317))         -- 1-time Castle Harm
                giveFreeSkill(const.Skills.Bodybuilding, 7, const.Expert)
            end
        end)
        -- script processing fix
        replaceMapEvent(35, function()  -- function events.LoadMap()
            evt.ForPlayer("All")
            if not evt.Cmp("QBits", getQuestBit(371)) then         -- Dwarven Messenger Once
                if evt.Cmp("Awards", getAward(8)) then         -- "Completed Coding Wizard Quest"
                    evt.SetNPCGreeting{NPC = getNPC(27), Greeting = getGreeting(27)}         -- "Messenger" : ""
                    evt.Set("QBits", getQuestBit(369))         -- "Raise the siege of Stone City by killing all creatures in the Barrow Downs within one week and then proceed to King Hothffar for your reward."
                    evt.Set("QBits", getQuestBit(371))         -- Dwarven Messenger Once
                    evt.Subtract("QBits", getQuestBit(368))         -- Barrow Normal
                    evt.Set("Counter2", 0)
                    evt.SpeakNPC(getNPC(27))         -- "Messenger"
                end
            end
        end)
    end,
    
    -- Red Dwarf Mines
    -- Learning skill barrel
    ["7d34.lua"] = function()
        replaceMapEvent(10, function()
            if not evt.Cmp("QBits", getQuestBit(335)) then         -- BDJ 1
                evt.Set("QBits", getQuestBit(335))         -- BDJ 1
                giveFreeSkill(const.Skills.Learning, 6, const.Expert)
            end
        end)
    end,

    -- OUTDOOR --

    -- Emerald Island
	-- fix for different NPCs talking (QBit wasn't set originally)
	["7out01.lua"] = function()
		replaceMapEvent(200, function()
            if not evt.Cmp("QBits", getQuestBit(17)) then         -- No more docent babble
                evt.Set("QBits", getQuestBit(17))         -- No more docent babble
                evt.SpeakNPC(getNPC(3))         -- "Big Daddy Jim"
            end
        end)
    end,

    -- Harmondale
    -- Harmondale teleportal hub
    ["out02.lua"] = function()
        replaceMapEvent(218, function()
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
        end)
    end,
}