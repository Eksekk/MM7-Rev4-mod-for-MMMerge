do return end
-- allow changing mastery learning requirements

-- new scope ("do" block) to allow short local names without name clashes
do
    local requirements = {
        -- examples:
        --[[
        [const.Skills.Fire] = {
            [const.Expert] = {
                Rank = 12,
                -- once there is an entry for specific mastery, only requirements listed apply, vanilla ones
                -- are inactive even if not directly overridden
                -- so fire expert won't cost any gold
            },
            [const.Master] =
            {
                Gold = 500000,
                Stat = {[const.Stats.Intellect] = 500,},
                Rank = 60,
                -- set specific requirement/lore text for fire master
                Text = "Lol you need to have 60 skill, 500 intellect and 500k gold, good luck with that!"
            }
        },
        [const.Skills.Bodybuilding] = {
            [const.Expert] =
            {
                Gold = 15000,
                Rank = 6,
                -- Text = ""
            }
            -- master has normal requirements
        },
        [const.Skills.Body] = {
            [const.Expert] = {
                Gold = 50000,
                Rank = 5
            },
            [const.Master] = {
                Gold = 12,
                Text = "12 gold and you're set"
            }
        }
        ]]
    }

    local cs = const.Stats
    -- you can add additional stats if you wish
    local statToText = {
        Might = cs.Might,
        Personality = cs.Personality,
        Intellect = cs.Intellect,
        Endurance = cs.Endurance,
        Accuracy = cs.Accuracy,
        Speed = cs.Speed,
        Luck = cs.Luck,
    }
    local textToStat = table.invert(statToText)
    local invSkill = table.invert(const.Skills)
    local textToMastery = {[const.Expert] = "Expert", [const.Master] = "Master"}
    local canShowConsole = true -- don't flood console if error occurs
    function events.EnterNPC()
        canShowConsole = true -- only once per npc enter
    end
    local function msgf(...)
        if canShowConsole then
            debug.Message(string.format(...)) -- if you get this message, pass "Text" argument with custom requirements as in fire master example
        end
    end

    -- update npc text for specific mastery of specific skill
    local function processRequirementTexts(t, req)
        local newText = t.Text
        if req.Text then
            newText = req.Text
        else
            local replaced
            if req.Gold then
                newText, replaced = newText:gsub("%d*( [Gg]old)", req.Gold .. "%1")
                if replaced ~= 1 then
                    msgf("Couldn't find gold text to replace for skill %s", invSkill[t.Skill])
                end
            end
            if req.Rank then
                newText, replaced = newText:gsub("(%([Rr]ank )%d*%)", string.format("%%1%d%%)", req.Rank))
                if replaced ~= 1 then
                    msgf("Couldn't find rank text to replace for skill %s", invSkill[t.Skill])
                end
            end
            if req.Stat then
                local replacement = {}
                for id, val in pairs(req.Stat) do
                    replacement[#replacement + 1] = string.format("%s %d", textToStat[id], val)
                end
                local done
                replacement = table.concat(replacement, ", ")
                for name, value in pairs(statToText) do
                    newText, replaced = newText:gsub(
                        string.format("%s %%d*", name), replacement
                    )
                    if replaced == 1 then
                        done = true
                        break
                    end
                end
                if not done then
                    msgf("Couldn't find stat text to replace for skill %s", invSkill[t.Skill])
                end
            end
        end
        t.Text = newText
    end

    function events.GameInitialized2()
        for skillId, masteries in pairs(requirements) do
            for mastery, req in pairs(masteries) do
                local t = {Skill = skillId, Text = Game.NPCText[200 + skillId * 2 + (mastery - 2)]}
                processRequirementTexts(t, req)
                Game.NPCText[200 + skillId * 2 + (mastery - 2)] = t.Text
            end
        end
    end

    local cannotTrainTextIds = {
        gold = 260,
        other = 261,
        noSkill = 262,
        masterFromNovice = 263,
        unconscious = 264,
        alreadyExpert = 265,
        alreadyMaster = 266
    }
    
    function events.CanTeachSkillMastery(t)
        -- exit if no active player (idk if can happen)
        if Game.CurrentPlayer == -1 then return end
        local pl = Party[Game.CurrentPlayer]
        local req = (requirements[t.Skill] or {})[t.Mastery + 2]
        if req then -- custom requirements
            local allow = true
            local currentS, currentM = SplitSkill(pl.Skills[t.Skill])
            local trainM = t.Mastery + 2
            local cannotTrainReason -- nil by default
            if pl.Unconscious ~= 0 or pl.Eradicated ~= 0 or pl.Paralyzed ~= 0 or pl.Stoned ~= 0 or pl.Dead ~= 0 or pl.Asleep ~= 0 then
                allow = false
                cannotTrainReason = cannotTrainTextIds.unconscious
            elseif currentM == 0 then
                allow = false
                cannotTrainReason = cannotTrainTextIds.noSkill
            elseif currentM == const.Novice and trainM == const.Master then
                allow = false
                cannotTrainReason = cannotTrainTextIds.masterFromNovice
            elseif currentM == trainM then
                allow = false
                cannotTrainReason = currentM == const.Expert and cannotTrainTextIds.alreadyExpert or cannotTrainTextIds.alreadyMaster
            end

            t.Cost = req.Gold or 0
            if allow and req.Gold then
                if req.Gold > Party.Gold then
                    allow = false
                    cannotTrainReason = cannotTrainTextIds.gold
                end
            end
            if allow and req.Rank then
                if req.Rank > currentS then
                    allow = false
                    cannotTrainReason = cannotTrainTextIds.other
                end
            end
            if allow and req.Stat then
                for id, val in pairs(req.Stat) do
                    if val > pl.Stats[id].Base then
                        allow = false
                        cannotTrainReason = cannotTrainTextIds.other
                        break
                    end
                end
            end
            t.Allow = allow
            local newText = t.Text
            if allow then
                newText = string.format("Become %s in %s for %d gold", textToMastery[trainM], Game.GlobalTxt[271 + t.Skill], t.Cost)
            elseif cannotTrainReason then
                newText = Game.NPCText[cannotTrainReason]
            end
            t.Text = newText
            canShowConsole = false
        end
    end
end