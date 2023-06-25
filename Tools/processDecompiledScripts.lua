rev4m = rev4m or {}
function rev4m.mapScripts()
	local replacements = table.copy(rev4m.scriptReplacements)

	--[[ TODO
	* out01.lua - house226?
	

	https://discord.com/channels/296507109997019137/795807513924075540/885284417893957633
	--]]

	local patches =
	{
		
	}

	local patchesAfter =
	{
		-- different table because I failed and edited a processed script
		-- The Gauntlet
		["d08.lua"] = 
		{
			
			[[evt.Subtract("Inventory", 1134)         -- "Lloyd's Beacon"
		if evt.Cmp("Inventory", 1134) then         -- "Lloyd's Beacon"
			goto _5
		end]],
		[[for _, scroll in ipairs({332, 1134, 1834}) do
			while evt.Cmp("Inventory", scroll) do
				evt.Subtract("Inventory", scroll)
			end
		end]],
		-- fix bug in BDJ's code
		[[evt.ForPlayer(Party.High)
		if evt.Cmp("FireSkill", 1) then
			evt.Set("SP", 0)
			evt.SetMonGroupBit{NPCGroup = 66, Bit = const.MonsterBits.Hostile, On = true}         -- "Group walkers in the Tularean forest"
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 8, X = -668, Y = 6965, Z = -384, -- ERROR: Not found
	NPCGroup = 563, unk = 0}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 5, X = -4721, Y = -10652, Z = 833, -- ERROR: Not found
	NPCGroup = 563, unk = 0}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 5, X = -5159, Y = -10152, Z = 833, -- ERROR: Not found
	NPCGroup = 563, unk = 0}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = -4934, Y = -6884, Z = 833, -- ERROR: Not found
	NPCGroup = 563, unk = 0}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 5, X = -4268, Y = -3983, Z = 833, -- ERROR: Not found
	NPCGroup = 563, unk = 0}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 5, X = -5525, Y = -5947, Z = 833, -- ERROR: Not found
	NPCGroup = 563, unk = 0}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = -4606, Y = -1643, Z = 833, -- ERROR: Not found
	NPCGroup = 563, unk = 0}
			evt.Subtract("QBits", 2045)         -- 0
		end]],
		[[evt.SetMonGroupBit{NPCGroup = 66, Bit = const.MonsterBits.Hostile, On = true}         -- "Group walkers in the Tularean forest"
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 8, X = -668, Y = 6965, Z = -384, -- ERROR: Not found
	NPCGroup = 563, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 5, X = -4721, Y = -10652, Z = 833, -- ERROR: Not found
	NPCGroup = 563, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 5, X = -5159, Y = -10152, Z = 833, -- ERROR: Not found
	NPCGroup = 563, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = -4934, Y = -6884, Z = 833, -- ERROR: Not found
	NPCGroup = 563, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 5, X = -4268, Y = -3983, Z = 833, -- ERROR: Not found
	NPCGroup = 563, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 5, X = -5525, Y = -5947, Z = 833, -- ERROR: Not found
	NPCGroup = 563, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = -4606, Y = -1643, Z = 833, -- ERROR: Not found
	NPCGroup = 563, unk = 0}
		evt.Subtract("QBits", 2045)         -- 0]]
		},
		-- Lincoln
		-- delegate exit event to Merge script
		-- btw in following patch evt.Cmp should have item number updated, but since Merge handles that event differently and I patch the only check of this VarNum, I'm ignoring it
		-- memo: can't be standalone patch
		["d23.lua"] = {[[

	evt.hint[501] = evt.str[2]  -- "Leave the Lincoln"
	Game.MapEvtLines:RemoveEvent(501)
	evt.map[501] = function()
		evt.ForPlayer(0)
		if evt.Cmp("IsWearingItem", 604) then
			evt.ForPlayer(1)
			if evt.Cmp("IsWearingItem", 604) then
				evt.ForPlayer(2)
				if evt.Cmp("IsWearingItem", 604) then
					evt.ForPlayer(3)
					if evt.Cmp("IsWearingItem", 604) then
						evt.MoveToMap{X = -7005, Y = 7856, Z = 225, Direction = 128, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "7out15.odm"}
						return
					end
				end
			end
		end
		evt.StatusText(20)         -- "You must all be wearing your wetsuits to exit the ship"
	end]], ""},
		-- Colony Zod
		-- remove buggy script which is replaced in Merge anyways
		["d27.lua"] = {[[evt.map[376] = function()
		if not evt.Cmp("QBits", 752) then         -- Talked to Roland
			evt.SpeakNPC(626)         -- "Roland Ironfist"
			evt.SetSprite{SpriteId = 20, Visible = 1, Name = "dec05"}
			evt.Add("Inventory", 1463)         -- "Colony Zod Key"
			evt.Add("QBits", 752)         -- Talked to Roland
			evt.Add("History24", 0)
			evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Untouchable, On = true}
			evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Invisible, On = true}
		end
	end
	]], ""},
		-- Harmondale
		["out02.lua"] =
		{
		-- remove original castle harmondale enter event, as it's replaced in Merge
		-- note: if I used separate file, it would probably remove merge event too
		[[

	evt.hint[301] = evt.str[30]  -- "Enter Castle Harmondale"
	Game.MapEvtLines:RemoveEvent(301)
	evt.map[301] = function()
		if evt.Cmp("QBits", 610) then         -- Built Castle to Level 2 (rescued dwarf guy)
			evt.MoveToMap{X = -5073, Y = -2842, Z = 1, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 382, Icon = 9, Name = "7D29.Blv"}         -- "Castle Harmondale"
		elseif evt.Cmp("QBits", 644) then         -- Butler only shows up once (area 2)
			evt.MoveToMap{X = -5073, Y = -2842, Z = 1, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 390, Icon = 9, Name = "7D29.Blv"}         -- "Castle Harmondale"
		else
			evt.Add("History3", 0)
			evt.SpeakNPC(397)         -- "Butler"
			evt.MoveNPC{NPC = 397, HouseId = 240}         -- "Butler" -> "On the House"
			evt.ForPlayer("All")
			evt.Set("QBits", 587)         -- "Clean out Castle Harmondale and return to the Butler in the tavern, On the House, in Harmondale."
			evt.Set("QBits", 644)         -- Butler only shows up once (area 2)
		end
	end]], "",
		},

		-- The Strange Temple
		-- remove unfinished Rev4 script which will interfere with my own quest
		["nwc.lua"] = {[[
		Game.NPC[388].Events[0] = 847         -- "Halfgild Wynac" : "Lord Godwinson sent us!"]], ""
		},
		
		-- The Vault
		["mdt12.lua"] = 
		{
			-- KEEPING AS A COMMENT FOR APOSTROPH INFO
			-- need ansi encoding (windows 1252 for vscode) to correctly represent these funny apostrophes
			-- "detect encoding" in settings needs to be on
			--[=[
			[[evt.SpeakNPC(1279)         -- "The Coding Wizard"
			evt.Set("Awards", 128)         -- "Hall of Shame Award ‘Unfaithful Friends’"
			evt.Subtract("Inventory", 1477)         -- "Control Cube"
			evt.Set("Eradicated", 0)]],
			
			[[evt.Set("Awards", 128)         -- "Hall of Shame Award ‘Unfaithful Friends’"
			evt.Subtract("Inventory", 1477)         -- "Control Cube"
			evt.Set("Eradicated", 0)
			evt.SpeakNPC(1279)         -- "The Coding Wizard"]]
			]=]
		},
	}

	local patchesMerge =
	{
		-- Castle Harmondale
		-- don't set TP buffs automatically
		["d29.lua"] = {
			"Party.QBits[718] = true	-- TP Buff Harmondale",
			"-- Party.QBits[718] = true	-- TP Buff Harmondale"
		},
		-- Erathia
		["out03.lua"] = {
			-- disable auto town portal buff
			"Party.QBits[720] = true	-- TP Buff Erathia",
			"-- Party.QBits[720] = true	-- TP Buff Erathia"
		},
		-- Tularean Forest
		-- remove event which is replaced in rev4
		["out04.lua"] = {[[

	-- Clanker's Laboratory
Game.MapEvtLines:RemoveEvent(503)
evt.map[503] = function()

	if Party.QBits[710] then
		evt.MoveNPC{427, 395}
		Game.Houses[395].ExitMap = 86
		Game.Houses[395].ExitPic = 1
		evt.EnterHouse{395}
	else
		evt.MoveToMap{0,-709,1,512,0,0,395,9,"7d12.blv"}
	end

end]], "",
	-- don't set TP QBit
	"Party.QBits[719] = true	-- TP Buff Tularean Forest", "-- Party.QBits[719] = true	-- TP Buff Tularean Forest"},
		-- Barrow Downs
		-- remove conflicting Stone City enter event
		["out11.lua"] = {
		[[Game.MapEvtLines:RemoveEvent(501)
	evt.hint[501] = evt.str[30]
	evt.map[501] = function()
		evt.MoveToMap {179, -5386, 33, 240, 0, 0, 408, 2, "7d24.blv"}
		--evt.MoveToMap {245, -5362, 34, 512, 0, 0, 408, 2, "7d24.blv"}
	end]], ""
		},
		-- remove original event from script to allow Merge replacement to work correctly
		["out12.lua"] = {
		[[-- Correct load map event.
	Game.MapEvtLines:RemoveEvent(1)]],
		[[-- Correct load map event.
	Game.MapEvtLines:RemoveEvent(1)
	evt.map[1].clear()]]},
	}

	local additions =
	{
		-- Coding Fortress
		-- make BDJ invisible by default
		-- make BDJ hostile on save game reload/lloyd back to dungeon
		--[=[ ["d12.lua"] = {[[
	function events.AfterLoadMap()
		if Map.Name == "7d12.blv" then
			-- make BDJ invisible by default
			if not vars["BDJ hidden"] then
				evt.SetMonGroupBit{NPCGroup = 60, Bit = const.MonsterBits.Invisible, On = true}
				vars["BDJ hidden"] = true
			end
			-- make BDJ hostile on save game reload/lloyd back to dungeon
			if vars["make BDJ hostile"] then
				evt.SetMonGroupBit{NPCGroup = 60, Bit = const.MonsterBits.Hostile, On = true}
			end
			vars["make BDJ hostile"] = true
		end
	end]]},]=]
		-- Castle Harmondale
		-- fix for a bug where golem and messenger of the saints are visible by default
		["d29.lua"] = {[[
	-- fix for a bug where golem and messenger of the saints are visible by default
	function events.AfterLoadMap()
		if (not vars["Castle Harmondale NPCs hidden"]) and Game.Map.Name == "7d29.blv" then
			if not (Party.QBits[585] or Party.QBits[586]) then
				evt.SetMonGroupBit{NPCGroup = 57, Bit = const.MonsterBits.Invisible, On = true}
			end
			if not Party.QBits[647] then
				evt.SetMonGroupBit{NPCGroup = 61, Bit = const.MonsterBits.Invisible, On = true}
			end
			vars["Castle Harmondale NPCs hidden"] = true
		end
	end]]},
	}

	local ignoreMergeAdditions =
	{
		["d08.lua"] = true
	}

	local function patchFailure(what, patch)
		printf("Error (%s): replacement not made: %s", what, patch:sub(1, math.min(300, patch:len())))
		error("breakpoint")
	end
	rev4m.f = rev4m.f or {}
	rev4m.f.patchFailure = patchFailure

	for i in path.find(rev4m.path.originalRev4Scripts .. "*.lua") do
		print("Current file: " .. path.name(i))
		local file = io.open(i)
		local content = file:read("*a")
		file:close()
		local name = path.name(i):lower()
		rev4m.currentlyProcessedScript = name
		local done = nil
		if patches[name] ~= nil then
			for i = 1, #patches[name], 2 do
				content, done = content:replaceIndent(patches[name][i], patches[name][i + 1])
				if done == 0 then
					patchFailure("Patches before", patches[name][i])
				end
			end
		end
		for regex, fun in pairs(replacements) do
			if regex ~= "evt%.StatusText%((%d+)%)" then
				content = content:gsub(regex, fun)
			end
		end
		
		if additions[name] ~= nil then
			for i, v in ipairs(additions[name]) do
				content = content .. v
			end
		end
		
		if patchesAfter[name] ~= nil then
			for i = 1, #patchesAfter[name], 2 do
				content, done = content:replaceIndent(patchesAfter[name][i], patchesAfter[name][i + 1])
				if done == 0 then
					patchFailure("patchesAfter", patchesAfter[name][i])
				end
			end
		end
		
		-- preserve MMMerge script additions
		if ignoreMergeAdditions[name] == nil then
			local file = io.open(rev4m.path.mergeMapScripts .. getFileName(path.name(i)), "r")
			if file then
				local content2 = file:read("*a")
				content = content .. "\n\n--[[ MMMerge additions ]]--\n\n" .. content2
				file:close()
			end
		end
		
		if patchesMerge[name] ~= nil then
			for i = 1, #patchesMerge[name], 2 do
				content, done = content:replaceIndent(patchesMerge[name][i], patchesMerge[name][i + 1])
				if done == 0 then
					patchFailure("patchesMerge", patchesMerge[name][i])
				end
			end
		end
		content = content:replace("Game.MapEvtLines.Count = 0  -- Deactivate all standard events", "-- REMOVED BY REV4 FOR MERGE\n-- Game.MapEvtLines.Count = 0  -- Deactivate all standard events")
		io.save(rev4m.path.processedRev4Scripts .. getFileName(path.name(i)), content)
	end
end

rev4m = rev4m or {}
function rev4m.globalScripts()
	local content = io.load(rev4m.path.rev4GlobalLua)

	local replacements = table.copy(rev4m.scriptReplacements)

	for regex, fun in pairs(replacements) do
		content = content:gsub(regex, fun)
	end

	local patches =
	{
		[ [[Game.GlobalEvtLines.Count = 0  -- Deactivate all standard events

		]] ] = "",

		[ [[evt.ForPlayer(3)
		if evt.Cmp("FireSkill", 1) then
			evt.Set("FireSkill", 49152)
			evt.Set("FireSkill", 72)
		end
		evt.ForPlayer(2)
		if evt.Cmp("FireSkill", 1) then
			evt.Set("FireSkill", 49152)
			evt.Set("FireSkill", 72)
		end
		evt.ForPlayer(1)
		if evt.Cmp("FireSkill", 1) then
			evt.Set("FireSkill", 49152)
			evt.Set("FireSkill", 72)
		end
		evt.ForPlayer(0)
		if evt.Cmp("FireSkill", 1) then
			evt.Set("FireSkill", 49152)
			evt.Set("FireSkill", 72)
		end]] ] = [[giveFreeSkill(const.Skills.Fire, 8, const.Expert, function(pl) return pl.Skills[const.Skills.Fire] ~= 0 end)]],
	-- don't need sparkles, as later there's evt.Add("Experience")
	[ [[if not evt.Cmp("QBits", 1974) then         -- Water
			if not evt.Cmp("QBits", 1975) then         -- Fire
				if not evt.Cmp("QBits", 1976) then         -- Air
					if not evt.Cmp("QBits", 1977) then         -- Earth
						return
					end
				end
			end
		end]] ] = [[if not evt.Cmp("QBits", 1974) or not evt.Cmp("QBits", 1975) or not evt.Cmp("QBits", 1976) or not evt.Cmp("QBits", 1977) then
			return
		end]],
		[ [[evt.Set("DarkSkill", 136)]] ] = [[-- evt.Set("DarkSkill", 136) -- given in "global/ZRev4 for Merge.lua" file]],
		[ [[evt.Set("LightSkill", 136)]] ] = [[-- evt.Set("LightSkill", 136)]],
		
		[ [[evt.MoveNPC{NPC = 60, -- ERROR: Not found
	HouseId = 999}         -- "Drathen Keldin"]] ] = "",

		[ [[evt.Add(-- ERROR: Not found
	"Awards", 83886128)]] ] = [[evt.Add(-- ERROR: Not found
	"Awards", 21)]],
		[ [[evt.global[42397] = function()
		evt.SetSnow{EffectId = 18, On = true}
	end]] ] = "",
		[ [[evt.Set(-- ERROR: Award index outside of normal range
	"Awards", 108)         -- "Inducted into the Erathian Hall of Shame!"
			evt.EnterHouse(600)         -- Win Good]] ] =
		[[evt.Set(-- ERROR: Award index outside of normal range
	"Awards", 133)         -- "Inducted into the Erathian Hall of Shame!]]
	}

	for from, to in pairs(patches) do
		local done = 0
		content, done = content:replaceIndent(from, to)
		if done == 0 then
			rev4m.f.patchFailure("global patches", from)
		end
	end

	io.save(rev4m.path.processedRev4GlobalLua, content)
end

function rev4m.processScripts()
	rev4m.mapScripts()
	rev4m.globalScripts()
end