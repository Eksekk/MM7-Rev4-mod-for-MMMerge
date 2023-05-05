-- will contain various consts which were previously in separate scripts
rev4 = rev4 or {}
rev4.const = rev4.const or {}

-- doing comparison of old revamp files with new, integrating where needed
-- current stage: map scripts are different - update those from merge and regenerate modded with script
-- after finishing comparison, update game files with new both in game folder and rev4 github folder, then compare with newest revamp
-- also compare old files with current, to make sure I did not lose anything while integrating
-- also mark mmmerge-master as newest revamp files!