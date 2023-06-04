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
    Game.MapEvtLines:RemoveEvent(num)
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

    -- THOSE BELOW ARE NOT TESTED --
    
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
	["7d29.blv"] = function()
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
    ["7d34.blv"] = function()
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
	["7out01.odm"] = function()
		replaceMapEvent(200, function()
            if not evt.Cmp("QBits", getQuestBit(17)) then         -- No more docent babble
                evt.Set("QBits", getQuestBit(17))         -- No more docent babble
                evt.SpeakNPC(getNPC(3))         -- "Big Daddy Jim"
            end
        end)
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

        -- fix the Gauntlet script to subtract MM6/MM8 scrolls as well, and remove SP from all party members, and set QBits in vars to restore later
		replaceMapEvent(221, function()
            evt.ForPlayer("All")
            if not evt.Cmp("QBits", getQuestBit(356)) then         -- 0
                evt.StatusText(54)         -- "You Pray"
                return
            end
            vars.TheGauntletQBits = {}
            for i = 0, 2 do
                vars.TheGauntletQBits[i + getQuestBit(206)] = Party.QBits[i + getQuestBit(206)]
            end
            evt.Subtract("QBits", getQuestBit(206))         -- Harmondale - Town Portal
            evt.Subtract("QBits", getQuestBit(207))         -- Erathia - Town Portal
            evt.Subtract("QBits", getQuestBit(208))         -- Tularean Forest - Town Portal
            while evt.Cmp("Inventory", getItem(223)) do         -- "Magic Potion"
                evt.Subtract("Inventory", getItem(223))         -- "Magic Potion"
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
            dispelMagic()
            evt.Subtract("QBits", getQuestBit(206))         -- Harmondale - Town Portal
            evt.MoveToMap{X = -3257, Y = -12544, Z = 833, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 3, Name = getFileName("D08.blv")}
        end)
        -- some evt.speakNPC fixes
        replaceMapEvent(39, function()  -- function events.LoadMap()
            evt.ForPlayer("All")
            if not evt.Cmp("Awards", getAward(15)) then         -- "Completed the MM7Rev4mod Game!!"
                if evt.Cmp("QBits", getQuestBit(374)) then         -- End Game
                    evt.SetNPCGreeting{NPC = getNPC(26), Greeting = getGreeting(32)}         -- "Count ZERO" : "Magic Shop"
                    evt.Set("Awards", getAward(15))         -- "Completed the MM7Rev4mod Game!!"
                    evt.Subtract("QBits", getQuestBit(130))         -- "Go to the Lincoln in the sea west of Avlee and retrieve the Oscillation Overthruster and return it to Resurectra in Celeste."
                    evt.SpeakNPC(getNPC(26))         -- "Count ZERO"
                end
            end
        end, true)
        replaceMapEvent(52, function()  -- function events.LoadMap()
            if not evt.Cmp("QBits", getQuestBit(376)) then         -- LG 1-time
                if evt.Cmp("QBits", getQuestBit(356)) then         -- 0
                    evt.SetNPCGreeting{NPC = getNPC(18), Greeting = getGreeting(148)}         -- "Lord Godwinson" : "Let us press on,my friends!"
                    evt.Set("NPCs", getNPC(18))         -- "Lord Godwinson"
                    evt.MoveNPC{NPC = getNPC(460), HouseId = 0}         -- "Lord Godwinson"
                    evt.SetNPCTopic{NPC = getNPC(18), Index = 0, Event = getGlobalEvent(96)}         -- "Lord Godwinson" : "Coding Wizard Quest"
                    evt.Set("QBits", getQuestBit(376))         -- LG 1-time
                    evt.SpeakNPC(getNPC(18))         -- "Lord Godwinson"
                end
            end
        end, true)
        replaceMapEvent(211, function()  -- function events.LoadMap()
            if not evt.Cmp("QBits", getQuestBit(134)) then         -- Arbiter Messenger only happens once
                if evt.Cmp("Counter3", 2272) then
                    evt.SpeakNPC(getNPC(91))         -- "Messenger"
                    evt.Add("QBits", getQuestBit(153))         -- "Choose a judge to succeed Judge Grey as Arbiter in Harmondale."
                    evt.Add("History6", 0)
                    evt.MoveNPC{NPC = getNPC(67), HouseId = 0}         -- "Ellen Rockway"
                    evt.MoveNPC{NPC = getNPC(68), HouseId = 0}         -- "Alain Hani"
                    evt.MoveNPC{NPC = getNPC(75), HouseId = getHouseID(174)}         -- "Ambassador Wright" -> "Throne Room"
                    evt.MoveNPC{NPC = getNPC(77), HouseId = getHouseID(112)}         -- "Judge Fairweather" -> "Familiar Place"
                    evt.Set("QBits", getQuestBit(134))         -- Arbiter Messenger only happens once
                end
            end
        end, true)
    end,
    	-- Erathia
		-- fix small bug in town portal code
    ["7out03.odm"] = function()
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
}