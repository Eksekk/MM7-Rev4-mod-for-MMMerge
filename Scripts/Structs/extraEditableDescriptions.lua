local u1, u2, u4, i1, i2, i4 = mem.u1, mem.u2, mem.u4, mem.i1, mem.i2, mem.i4
local oldGame = structs.f.GameStructure
function structs.f.GameStructure(define, ...)
    oldGame(define, ...)
    local skillsHigh = 38
    define[0x5E4A30].array(0, skillsHigh + 1).EditPChar("SkillDescriptionsGM")
    define[0x5E4AD0].array(0, skillsHigh + 1).EditPChar("SkillDescriptionsMaster")
    define[0x5E4B70].array(0, skillsHigh + 1).EditPChar("SkillDescriptionsExpert")
    define[0x5E4C10].array(0, skillsHigh + 1).EditPChar("SkillDescriptionsNovice")
    --define[0x5E4CB0].array(0, skillsHigh + 1).EditPChar("SkillDescriptions")
    -- some stat descriptions: 0x5E4D50
end

-- build skill information box
local function tooltipHook(includesBonus)
    return function(d)
        local t = {ExtraText = "", IncludesBonus = true, Skill = u4[d.esp + 4]}
        events.call("BuildSkillInformationBox", t)
        local text = t.ExtraText
        if #text > 0 then
            local destination = d.esi
            if not includesBonus then
                text = "\f00000" .. text -- remove color, if bonus is not printed, "color tag" is not closed
            end
            mem.copy(destination + mem.string(destination):len(), text .. "\0")
        end
    end
end
--function events.BuildSkillInformationBox(t) if t.Skill == const.Skills.Armsmaster then t.ExtraText = "\n\nThis is armsmaster"; else t.ExtraText = "\n\nThis is not armsmaster" end end
mem.autohook2(0x4174C5, tooltipHook(true), 8)
mem.autohook2(0x417648, tooltipHook(false), 8)