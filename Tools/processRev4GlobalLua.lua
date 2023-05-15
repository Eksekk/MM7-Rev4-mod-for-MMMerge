rev4m = rev4m or {}
function rev4m.globalScripts()
	local content = io.load(rev4m.path.rev4GlobalLua)

	local replacements = table.copy(rev4m.scriptReplacements)

	--[[ USEFUL STUFF
	shows event id when event is triggered on the map
	function events.EvtMap(evtId, seq)
		Message(tostring(evtId))
	end
	--]]

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
		content, done = content:replaceIndent(from, to)
		if done == 0 then
			rev4m.f.patchFailure("global patches", from)
		end
	end

	io.save(rev4m.path.processedRev4GlobalLua, content)
end