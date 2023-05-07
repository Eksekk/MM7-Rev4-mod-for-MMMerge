-- will contain various consts which were previously in separate scripts
rev4m = rev4m or {}
rev4m.const = rev4m.const or {}
rev4m.path = rev4m.path or {}
-- all paths are relative to game folder
rev4m.path.mergeMapScripts = "merge map scripts\\" -- not decompiled, but found in Scripts/Maps only
rev4m.path.originalRev4Scripts = "rev4 map scripts\\" -- only those changed in rev4, decompiled
rev4m.path.processedRev4Scripts = "rev4 map scripts\\processed\\"
rev4m.path.originalOtherMapScripts = "other map scripts\\" -- other existing map scripts from Merge
rev4m.path.processedOtherMapScripts = "other map scripts\\processed\\"

-- temporary, for testing
rev4m.path.processedRev4Scripts = "combined processed scripts\\"
rev4m.path.processedOtherMapScripts = "combined processed scripts\\"


-- doing comparison of old revamp files with new, integrating where needed
-- current stage: map scripts are different - update those from merge and regenerate modded with script
-- after finishing comparison, update game files with new both in game folder and rev4 github folder, then compare with newest revamp
-- also compare old files with current, to make sure I did not lose anything while integrating
-- also mark mmmerge-master as newest revamp files!