rev4m = rev4m or {}
function rev4m.globalScripts()
	local file = io.load(rev4m.path.rev4GlobalLua)

	-- note: there is event skip at event 511 in rev4

	local replacements = table.copy(rev4m.scriptReplacements)

	--[[ Script files to move to github folder
	* Quest_MM7Lich.lua
	* Rev4 for Merge.lua
	* map and global scripts (incl. MM6/MM8 ones - changed ddmapbuffs)
	* Rev4 for Merge change spell damage.lua
	* Quest_FortRiverstride.lua
	--]]

	--[[ TODOs completed
	* <del>fix getHouseID (create table of overriding mappings from rev4 to merge in case of for example hostels) - both here and in parseNpcData.lua</del>
	* <del>promoted awards checks are changed into qbits in merge</del>
	* <del>check if class consts (const.Class.Thief for example) is good for merge</del>
	* <del>check if setMonGroupBit works correctly</del>
	* <del>check strange avlee teachers greetings ("Help me!")</del>
	* <del>BDJ goodbye topic giving wrong message</del>
	* <del>sort entries in mapstats</del>
	* <del>process npctext</del>
	* <del>fix adventurers in temple of the moon not dropping items: iterate through monsters after loading map, find adventurer index and give item to him</del>
	* <del>fix skill barrels code</del>
	* <del>fix mm7 barrels to give +5</del>
	* <del>the gauntlet: lord godwinson, the coding fortress: BDJ the coding wizard, fix him (move to correct location)</del>
	* <del>inspect map d16.blv for what's changed (couldn't find anything in the first pass) - vampire cloak</del>
	* <del>stone city check chests</del>
	* <del>check chests in 7d12.blv</del>
	* <del>five rings in chests in stone city</del>
	* <del>getItem() fixes (potions etc.)</del>
	* <del>d29.blv - angel messenger</del>
	* <del>7d28.lua - map editor stuff</del>
	* <del>check ancient weapons in items.txt</del>
	* <del>check d08.blv for crashes relating to Lord Godwinson placemon id</del>
	* <del>BDJ should become hostile on game load/move into 7d12 with lloyd's beacon - use vars table</del>, same thing with 7d08.blv (monsters reappearing)
	* <del>castle harmondale locked if not finished scavenger hunt, also messenger about scavenger hunt</del>
	* <del>process summon monsters npcgroup</del>
	* <del>inspect EI event 575 (where is it located) - answer: nowhere</del>
	* <del>castle harmondale respawn -1</del>
	* <del>leane shadowrunner in deyja strange message on master stealing</del> - strange in vanilla Merge too
	* <del>move npcs in mdt12.blv</del>
	* <del>check if after arriving in harmondale death map is set as harmondale</del>
	* <del>d16 vampire cloak in prison</del - vampire has it
	* <del>check other qbits past 512 * 3, for things that might break with conversion</del>
	* <del>phasing cauldron and brazier of succor</del> - idk how to fix this
	* <del>judas in colony zod?</del> - nope, though make sure to play fully through rev4
	* <del>realign evenmorn island titans</del>
	* <del>check d08.blv Lord Godwinson stats - they get affected by bolster monster</del>
	* <del>trees in tularean looked strange - possible not changed file name in evt.CheckSeason checks</del>
	* <del>the small house entrance text</del>
	* <del>resolve docent talking in emerald island - workaround is to walk into BDJ radius again, second time it sets the QBit</del>
	* <del>antagarichan gems have changed descriptions in Merge, maybe preserve them?</del>
	* <del>consider restoring original behavior of blasters - currently they benefit from bow skill</del>
	* <del>check evt.ShowMovie file names</del>
	* <del>https://gitlab.com/cthscr/mmmerge/-/wikis/Cluebook/DimensionDoor</del>
	* <del>fix other ddmapbuffs in MM6/MM8 maps</del>
	* <del>check wtf at line 2595</del>
	* <del>check if blayze's quest and saving erathia quest give correct mastery - they probably don't, fix them</del>
	* <del>check awards missing mappings</del>
	* <del>check Elgar Fellmoon</del>
	* <del>Zokarr's tomb fix coordinates on teleport to Barrow VI</del>
	* <del>restore qbits on leaving the gauntlet only if they were set originally</del>
	* <del>fix the gauntlet scripts to subtract MM8/MM6 scrolls/potions as well and remove SPs from all party members</del>
	* <del>restore original pics & descriptions of items taken from MM8/MM6</del>
	* <del>mdt, mdk, mdr test</del>
	* <del>check evt.SpeakNPC commands if they won't break</del>
	* <del>check test of friendship - probably need to disable monster pathfinding there/increase HP of NPCs</del>
	* <del>check search for "ERROR: " and check if everything is ok near it</del>
	** <del>do this in map scripts too</del>
	* <del>integrate changes from revamp.T.lod (incl. scripts)</del>
	* <del>integrate latest cthscr's commits</del>
	* <del>boost mapstats spawns</del>
	* <del>boost spells damage</del>
	* <del>find where judas the geek is in rev4 and put him there in merge (maybe he is as spawn)</del>
	* <del>tunnels to eofol changed (deleted) spawns at the end?</del> - no, just monster limit is hit easily in this map
	--]]

	--[[ USEFUL STUFF
	shows event id when event is triggered on the map
	function events.EvtMap(evtId, seq)
		Message(tostring(evtId))
	end

	for m, id in pairs(Editor.State.Monsters) do if id == 1 then XYZ(m, XYZ(Party)) end end

	t1 = nil
	for v, k in pairs(Editor.State.Monsters) do
	if k == 0 then t1 = v end end

	local file = io.open("Monster data.txt", "w")
	for k, v in Map.Monsters do if v.NameId ~= 0 then file:write("Monster " .. k .. "\n\n" .. dump(v, 1):gsub("NameId = (%d+)", function(nameid) return ("NameId = %d (%s)"):format(tonumber(nameid), Game.PlaceMonTxt[tonumber(nameid)]) end) .. "\n\n\n") end end
	file:close()
	--]]

	for regex, fun in pairs(replacements) do
		content = content:gsub(regex, fun)
	end

	content = content:replace([[Game.GlobalEvtLines.Count = 0  -- Deactivate all standard events

	]], "")

	local patches =
	{[ [[evt.ForPlayer("All")
		if evt.Cmp("QBits", 850) then         -- BDJ Final
			evt.SetMessage(1024)         -- "Adventurer 4, select your new profession."
			evt.ForPlayer(3)
		elseif evt.Cmp("QBits", 849) then         -- BDJ 3
			evt.SetMessage(1023)         -- "Adventurer 3, select your new profession."
			evt.ForPlayer(2)
		elseif evt.Cmp("QBits", 848) then         -- BDJ 2
			evt.SetMessage(1022)         -- "Adventurer 2, select your new profession."
			evt.ForPlayer(1)
		else
			evt.SetMessage(1021)         -- "Adventurer 1, select your new profession."
			evt.ForPlayer(0)
		end]] ]
		=
		[[evt.ForPlayer("All")
		if evt.Cmp("QBits", 869) then         -- BDJ Final
			evt.SetMessage(2822)         -- "Adventurer 5, select your new profession."
			evt.ForPlayer(4)
		elseif evt.Cmp("QBits", 850) then         -- BDJ 4
			evt.SetMessage(1024)         -- "Adventurer 4, select your new profession."
			evt.ForPlayer(3)
		elseif evt.Cmp("QBits", 849) then         -- BDJ 3
			evt.SetMessage(1023)         -- "Adventurer 3, select your new profession."
			evt.ForPlayer(2)
		elseif evt.Cmp("QBits", 848) then         -- BDJ 2
			evt.SetMessage(1022)         -- "Adventurer 2, select your new profession."
			evt.ForPlayer(1)
		else
			evt.SetMessage(1021)         -- "Adventurer 1, select your new profession."
			evt.ForPlayer(0)
		end]],
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
	[ [[if not evt.Cmp("QBits", 807) then         -- Water
			if not evt.Cmp("QBits", 808) then         -- Fire
				if not evt.Cmp("QBits", 809) then         -- Air
					if not evt.Cmp("QBits", 810) then         -- Earth
						return
					end
				end
			end
		end]] ] = [[if not evt.Cmp("QBits", 807) or not evt.Cmp("QBits", 808) or not evt.Cmp("QBits", 809) or not evt.Cmp("QBits", 810) then
			return
		end]],
		[ [[evt.Set("DarkSkill", 136)]] ] = [[-- evt.Set("DarkSkill", 136) -- given in "global/ZRev4 for Merge.lua" file]],
		[ [[evt.Set("LightSkill", 136)]] ] = [[-- evt.Set("LightSkill", 136)]],
		-- [ [[evt.Subtract("QBits", 811)         -- "Clear out the Strange Temple,  retrieve the ancient weapons, and return to Maximus in The Pit"]] ] =
		-- [[evt.SetNPCGreeting{NPC = 388, Greeting = 370} -- Halfgild Wynac
		-- evt.Subtract("QBits", 811)         -- "Clear out the Strange Temple,  retrieve the ancient weapons, and return to Maximus in The Pit"]],
		--
		
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
		content, done = content:replace(from, to)
		if done == 0 then
			print("Error! Replacement not performed! Part of what to replace:\n" .. from:sub(1, math.min(from:len(), 100)))
		end
	end

	local genericEvtRegex = "evt%.%w-[%(%{].-[%)%}]"

	local exclusions =
	{
		"evt%.Add%(\"Experience\", %d+%)"
	}

	local i, j = content:find(genericEvtRegex, 1)
	repeat
		local text = content:sub(i, j)
		local matched = false
		for regex, fun in pairs(replacements) do
			if text:match("(" .. regex .. ")") == text then -- need full capture group, as match returns only first capture group
				matched = true
				break
			end
		end
		if not matched then
			for k, regex in ipairs(exclusions) do
				if text:match("(" .. regex .. ")") == text then
					matched = true
					break
				end
			end
		end
		if not matched then
			--print("Found unfixed evt command: " .. text)
		end
		i, j = content:find(genericEvtRegex, i + 1)
	until i == nil

	local file2 = io.open("GLOBAL rev4 processed.lua", "w")
	file2:write(content)
	io.close(file2)
end