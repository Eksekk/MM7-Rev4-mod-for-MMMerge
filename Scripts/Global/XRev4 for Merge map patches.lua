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
    if func then -- allow removing only lua event by passing "false"
        Game.MapEvtLines:RemoveEvent(num)
        if onload then
            func()
        else
            evt.map[num] = func
            if hint then
                evt.hint[num] = hint
            end
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
            dispelMagic()
        end, true)
    end,

    -- Coding Fortress
    -- modify BDJ summon event to not mess with the quest
    ["7d12.blv"] = function()
       replaceMapEvent(376, function()
            evt.ForPlayer("All")
            if not evt.Cmp("QBits", getQuestBit(350)) then         -- Two Use
                evt.SetTexture{Facet = 1, Name = "solid01"}
                evt.SetMonGroupBit{NPCGroup = getNpcGroup(9), Bit = const.MonsterBits.Invisible, On = false}         -- "Group for Malwick's Assc."
                evt.SetMonGroupBit{NPCGroup = getNpcGroup(9), Bit = const.MonsterBits.Hostile, On = false}         -- "Group for Malwick's Assc."
                -- REMOVED BELOW
                -- evt.SetNPCTopic{NPC = getNPC(456), Index = 0, Event = getGlobalEvent(48)}         -- "The Coding Wizard" : "Greetings from BDJ!"
                evt.SetNPCGreeting{NPC = getNPC(456), Greeting = getGreeting(23)}         --[[ "The Coding Wizard" : "BDJ's the name, Coding Wizard's The Game
        
        Now what can I do for you?" ]]
            end
            evt.Set("QBits", getQuestBit(350))         -- Two Use
        end)
    end,

    -- Zokarr's Tomb
    -- fix barrow VI enter coordinates
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
    -- require actually killing the vampire (don't unconditionally set QBit on map leave)
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
        replaceMapEvent(501, false)
    end,

    -- Castle Harmondale
	-- bodybuilding skill barrel
	["7d29.blv"] = function()
        replaceMapEvent(37, function()
            if not evt.Cmp("QBits", getQuestBit(317)) then         -- 1-time Castle Harm
                evt.Set("QBits", getQuestBit(317))         -- 1-time Castle Harm
                giveFreeSkill(const.Skills.Bodybuilding, 7, const.Expert)
            end
        end)
    end,
    
    -- Red Dwarf Mines
    -- Learning skill barrel
    ["7d34.blv"] = function()
        replaceMapEvent(10, function()
            if not evt.Cmp("QBits", getQuestBit(335)) then         -- BDJ 1
                evt.Set("QBits", getQuestBit(335))         -- BDJ 1
                giveFreeSkill(const.Skills.Learning, 6, const.Expert)
            end
        end)
    end,

    -- barrow IV, fix npc group not found error
    ["mdk02.blv"] = function()
        replaceMapEvent(1, function()  -- function events.LoadMap()
            if evt.Cmp("QBits", getQuestBit(192)) then         -- Turn on map in mdkXX(Dwarven Barrow)
                evt.SetDoorState{Id = 25, State = 0}
                evt.SetDoorState{Id = 26, State = 0}
            end
            evt.SetMonGroupBit{NPCGroup = getNpcGroup(5), Bit = const.MonsterBits.Hostile + 0x40000 + const.MonsterBits.NoFlee + const.MonsterBits.Invisible, On = false}         -- "Generic Monster Group for Dungeons"
        end, true)
    end,
    
	-- The Vault
    ["mdt12.blv"] = function()
        -- fix so that friends will fight with dragons & hydras
        -- simply make any monster classes with name ids hostile to all others, and vice versa
        function events.AfterLoadMap()
            LocalHostileTxt()
            local nameids = {}
            for k, v in Map.Monsters do
                if v.NameId ~= 0 then
                    table.insert(nameids, (v.Id + 2):div(3))
                end
            end
            for _, m in ipairs(nameids) do
                for i, v in Game.HostileTxt do
                    if not table.find(nameids, i) then
                        Game.HostileTxt[m][i] = 4
                        Game.HostileTxt[i][m] = 4
                    end
                end
            end
            events.Remove("AfterLoadMap", 1) -- just in case
        end
    end,

    -- OUTDOOR --

    -- Emerald Island
	-- fix for different NPCs talking (QBit wasn't set originally)
	["7out01.odm"] = function()
		replaceMapEvent(200, function()
            if not evt.Cmp("QBits", getQuestBit(17)) then         -- No more docent babble
                evt.Set("QBits", getQuestBit(17))         -- No more docent babble
                evt.SpeakNPC(getNPC(3))         -- "Big Daddy Jim"
            end
        end)

		-- add QBits and show movie on arrival
		replaceMapEvent(100, function()  -- function events.LoadMap()
                local add = true
                for qb = getQuestBit(1), getQuestBit(7) do
                    if Party.QBits[qb] then
                        add = false
                        break
                    end
                end
                if add then
                    for qb = getQuestBit(1), getQuestBit(6) do
                        evt.Add("QBits", qb) -- evt to show flash on PC faces
                    end
                    evt.ShowMovie{DoubleSize = 1, Name = "\"intro post\""}
                end
            end
        , true)
    end,

    -- Harmondale
    -- Harmondale teleportal hub
    ["7out02.odm"] = function()
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
    
    -- THOSE BELOW ARE NOT TESTED --

        -- fix the Gauntlet script to subtract MM6/MM8 scrolls as well, and remove SP from all party members
        local eventAdded -- don't add multiple times
		replaceMapEvent(221, function()
            evt.ForPlayer("All")
            if not evt.Cmp("QBits", getQuestBit(356)) then         -- 0
                evt.StatusText(54)         -- "You Pray"
                return
            end
            if not eventAdded then
                eventAdded = true
                -- wrapping in load map because doesn't work without it (code below moveToMap isn't ever executed), and if it were at the bottom, other code
                -- (in this case removing some stuff and dispel) would be run even if player declines move. In original Rev4 it ran every time, but I find that annoying
                function events.LoadMap()
                    events.Remove("LoadMap", 1)
                    if Map.Name ~= "7d08.blv" then return end
                    for _, potion in ipairs{getItem(223), 1767} do        -- "Magic Potion"
                        while evt.Cmp("Inventory", potion) do
                            evt.Subtract("Inventory", potion)
                        end
                    end
                    for _, scroll in ipairs({332, getItem(332), 1834}) do
                        while evt.Cmp("Inventory", scroll) do
                            evt.Subtract("Inventory", scroll)
                        end
                    end
                    for _, pl in Party do
                        if pl.Skills[const.Skills.Fire] ~= 0 then
                            pl.SP = 0
                        end
                    end
                    evt.ForPlayer("All")
                    -- doesn't work -- evt.CastSpell{Spell = 80, Mastery = const.GM, Skill = 53, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Dispel Magic"
                    -- dispel magic
                    dispelMagic(true) -- for now unblockable, not sure if should be blockable
                    -- handled in Global/VRev4 for Merge.lua
                    -- evt.Subtract("QBits", getQuestBit(206))         -- Harmondale - Town Portal
                end
            end
            evt.MoveToMap{X = -3257, Y = -12544, Z = 833, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 3, Name = getFileName("D08.blv")}
        end)
    end,
    -- Erathia
    ["7out03.odm"] = function()
        -- fix small bug in town portal code (scroll was subtracted before autosave, so if you loaded it you still lost the scroll)
        replaceMapEvent(35, function()
            evt.ForPlayer("All")
            if evt.Cmp("Inventory", getItem(737)) then         -- "Town Portal Pass"
                evt.MoveToMap{X = -6731, Y = 14045, Z = -512, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = getFileName("Out02.Odm")}
                evt.Subtract("Inventory", getItem(737))         -- "Town Portal Pass"
            else
                evt.StatusText(22)         -- "You need a town portal pass!"
            end
        end)
        replaceMapEvent(36, function()
            evt.ForPlayer("All")
            if evt.Cmp("Inventory", getItem(737)) then         -- "Town Portal Pass"
                evt.MoveToMap{X = -15148, Y = -10240, Z = 1312, Direction = 40, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = getFileName("Out04.odm")}
                evt.Subtract("Inventory", getItem(737))         -- "Town Portal Pass"
            else
                evt.StatusText(22)         -- "You need a town portal pass!"
            end
        end)
        -- brianna's brandy (identify item tea)
        replaceMapEvent(37, function()
            evt.ForPlayer("All")
            if not evt.Cmp("QBits", getQuestBit(331)) then         -- 1-time Erathia
                evt.Set("QBits", getQuestBit(331))         -- 1-time Erathia
                giveFreeSkill(const.Skills.IdentifyItem, 6, const.Expert)
                evt.SetSprite{SpriteId = 16, Visible = 1, Name = "sp57"}
            end
        end)
    end,
    -- Bracada Desert
	["7out06.odm"] = function()
        -- fix dock teleporter to teleport you on the ground
        replaceMapEvent(312, function()
			evt.MoveToMap{X = 17656, Y = -20704, Z = 326, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
        end)
		-- fix teleporters so one of two teleporting to temple teleports to shops instead
        -- this is actually an additional event
        replaceMapEvent(318, function()
            evt.MoveToMap{X = -14125, Y = -7638, Z = 1345, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
        end, nil, evt.str[100])
    end,
    -- Barrow Downs
	-- repair tea
	["out11.odm"] = function()
        replaceMapEvent(10, function()
            evt.ForPlayer("All")
            if not evt.Cmp("QBits", getQuestBit(321)) then         -- Gepetto's Thermos
                evt.Set("QBits", getQuestBit(321))         -- Gepetto's Thermos
                giveFreeSkill(const.Skills.Repair, 7, const.Expert)
            end
        end)
    end,
}