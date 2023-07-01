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