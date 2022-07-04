local MS = Merge.ModSettings
local questID = "ClearFortRiverstride"
if MS.Rev4ForMergeActivateExtraQuests == 1 then
	KillMonstersQuest {
		questID,
		{Map = "7d31.blv", Group = {56, 57, 58}},
		Gold = 10000,
		Experience = 35000,
		NPC = 771,
		Slot = 2,
		Done = function()
			for i = 1, 3 do
				evt.Add("Inventory", 1418)
			end
		end,
		Texts =
		{
			Topic = "Quest",
			TopicDone = false,
			Give = [[So you consider yourself good fighters? Let's put your skills into test. There's an old fort in Erathia, which guards the river against entry by us. If you are able to kill all creatures inside, we'll have much easier time invading Erathia.
			
Oh, one more warning. We've heard gossips that necromancers tried to take over the location by force, and Bracada sent its wizards to curb them. Be careful.]],
			Undone = "Our scouts have reported that they sighted guards inside the fort. Go on and kill them!",
			Done = "Well done! Now conquering Erathia will be a piece of cake. Take these genie lamps as your reward. I've inherited them from my mother, and we both were too afraid to use them. Maybe you'll be able to somehow overpower the genies' wrath.",
			
			Quest = "Kill everything inside Fort Riverstride and return to Rainyn Rivencrest in Tularean Forest.",
			Award = "Cleared out Fort Riverstride"
		}
	}
	
	function events.AfterLoadMap()
		if Map.Name == "7d31.blv" then -- Fort Riverstride
			Game.MapEvtLines:RemoveEvent(451)
			evt.map[451].clear()
			if not mapvars.MonstersCreated then
				mapvars.MonstersCreated = true
				-- plate fighters
				SummonMonster(259, 160, 1029, 0, true)
				SummonMonster(259, 448, 1092, 0, true)
				SummonMonster(260, -1050, -520, -448, true)
				
				SummonMonster(261, -3982, 1957, -896, true)
				
				pseudoSpawnpoint(259, 36, -786, -448, "2-3", {100, 0, 0})
				
				-- wizards
				pseudoSpawnpoint(292, -525, 199, 0, "2-3")
				
				pseudoSpawnpoint(292, -3259, 181, -896, "2-4", {50, 30, 20})
				
				pseudoSpawnpoint(292, -2629, 1311, -896, "2-4", {50, 30, 20})
				
				pseudoSpawnpoint(292, -1686, -111, -896, "2-4")
				
				
				-- leather fighters in main hallway
				for i = 0, 8 do
					SummonMonster(258, -1064 + 250 * i, -193, -448, true)
				end
				
				-- oozes
				for i = 0, 8 do
					SummonMonster(311, -1002 + 250 * i, 137, -448, true)
				end
				
				-- necromancers in one of the rooms
				pseudoSpawnpoint(307, 801, -740, -448, "2-3", {60, 40, 0})
				
				-- golems
				pseudoSpawnpoint(277, -2382, -422, -896, "2-3", {70, 20, 10})
				pseudoSpawnpoint(277, -4348, 2281, -896, "2-3", {70, 20, 10})
				
				-- liches
				pseudoSpawnpoint(289, -4533, 988, -896, "2-3", {70, 30, 0})
				
				-- ghasts
				pseudoSpawnpoint(454, -2194, 1846, -896, "5-10")
			end
			local function isWizardOrGolem(id)
				return (id + 2):div(3) == 98 or (id + 2):div(3) == 93
			end
			local function isUndeadOrNecro(id)
				return Game.IsMonsterOfKind(id, const.MonsterKind.Undead) or (id + 2):div(3) == 103
			end
			for k, v in Map.Monsters do
				if isWizardOrGolem(v.Id) then
					v.Group = 58
				elseif isUndeadOrNecro(v.Id) then
					v.Group = 57
				else
					v.Group = 56
				end
				v.ShowOnMap = false
			end
			for i = 56, 58 do
				evt.SetMonGroupBit(i, const.MonsterBits.Hostile, true)
			end
		end
	end
	
	function events.LeaveMap()
		if Map.Name == "7d31.blv" then
			summoned = {}
		end
	end
end

--------------------------- WROMTHRAX'S CAVE QUEST

-- There is portal which is spawning ether knights (maybe only if previous spawns are killed)
-- in addition to one-time spawns
-- Wromthrax is buffed and holds "ether gem"
-- after getting ether gem you can interact with the portal to close it
-- now ether knights stop spawning
-- if you clear the entire cave now, the quest is completed
-- add chests?

-- SHOW EXACT SPELL INFORMATION ON RIGHT CLICK (reverse engineering)
-- boost spiders level/experience/hit radius?

sharedSpawnpoint = {}
vars.SharedSpawnpoints = vars.SharedSpawnpoints or {}
sharedSpawnpoints = {}
function sharedSpawnpoint.new(monster, max)
	local MAX_SPAWNED_AT_ONCE = diffsel(4, 6, 8)
	local ret = {}
	local spawns = {}
	local maxSpawnByType = {}
	local spawned = {}
	if max then
		maxSpawnByType[monster] = max
	end
	function ret.add(data)
		if type(data) ~= "table" then error("Argument passed to sharedSpawnpoint.add() isn't a table") end
		spawns[data.monster] = spawns[data.monster] or {}
		table.insert(spawns[data.monster], data)
	end
	function ret.setMax(mon, max)
		maxSpawnByType[mon] = max
	end
	function ret.setDefaultMax(max)
		MAX_SPAWNED_AT_ONCE = max
	end
	function ret.spawn(monster, settings)
		settings = settings or {}
		local monsterSpawnpoints = spawns[monster]
		local function spawn2()
			if #monsterSpawnpoints == 0 then return end
			local randOrder = {}
			if settings.RandomSpawnpointOrder then
				while #randOrder < #monsterSpawnpoints do
					local i = math.random(1, #monsterSpawnpoints)
					if not table.find(randOrder, i) then
						table.insert(randOrder, i)
					end
				end
			else
				for i = 1, #monsterSpawnpoints do
					randOrder[i] = i
				end
			end
			for _, index in ipairs(randOrder) do
				local spawn = monsterSpawnpoints[index]
				local canSpawn = (maxSpawnByType[monster] or DEFAULT_SPAWN_AMOUNT) - #(spawned[monster] or {})
				local maxInOneSpawn = canSpawn
				local minInOneSpawn = 1
				if settings.ExactSpawnMin then
					local min, max = getRange(spawn.count)
					minInOneSpawn = min
				end
				if settings.ExactSpawnMax then
					local min, max = getRange(spawn.count)
					maxInOneSpawn = max
				end
				if settings.DivideAcrossAllSpawnpoints then
					maxInOneSpawn = math.ceil(canSpawn / #monsterSpawnpoints)
				end
				local max = math.min(canSpawn, maxInOneSpawn)
				if max <= 0 then break end
				local oldC = spawn.count
				spawn.count = tostring(minInOneSpawn) .. "-" .. tostring(maxInOneSpawn)
				local mons = pseudoSpawnpoint(spawn)
				spawn.count = oldC
				spawned = table.join(spawned, mons)
				canSpawn = canSpawn - #mons
			end
		end
		if monster then
			spawn2()
		else
			for k, v in pairs(spawns) do
				monster = v.monster
				monsterSpawnpoints = spawns[k]
				spawn2()
			end
		end
	end
	function ret.getSpawnedMonsters(monster)
		return spawned[monster] or spawned
	end
	function ret.clear(monster)
		if monster then
			spawns[monster] = {}
		else
			spawns = {}
		end
	end
	ret.clearAll = ret.clear
	table.insert(vars.SharedSpawnpoints[Map.Name:lower()], ret)
	return ret
end

function events.LoadMap()
	local n = Map.Name:lower()
	if Map.Refilled then
		vars.SharedSpawnpoints[n] = {}
		return
	end
	if vars.SharedSpawnpoints[n] then
		sharedSpawnpoints = vars.SharedSpawnpoints[n]
	end
	for i, v in ipairs(sharedSpawnpoints) do
		sharedSpawnpoints[i] = Map.Monsters[v]
	end
end

function events.LeaveMap()
	
end

if MS.Rev4ForMergeActivateExtraQuests == 1 and MS.Rev4ForMergeDuplicateModdedDungeons == 1 then
	-- chests, ground items?
	-- randomized monster spells, monster bonuses
	local questID = "WromthraxCaveDisablePortalAndClear"
	local PORTAL_FACET_INDEX = 10
	local ETHER_GEM_ID = 2500
	vars.WromthraxCaveQuest = vars.WromthraxCaveQuest or {}
	function events.LoadMap()
		if Map.Name ~= "mdt09orig.blv" then return end
		local function boostResistances(mon, amount)
			local i = 1
			for k, v in pairs(const.Damage) do
				if v ~= 12 and v ~= 50 and v ~= 5 and mon.Resistances[v] < const.MonsterImmune then -- Energy, Dragon, Magic
					mon.Resistances[v] = math.min(const.MonsterImmune, mon.Resistances[v] + (type(amount) == "table" and amount[i] or amount))
				end
				i = i + 1
			end
		end
		if not vars.WromthraxCaveQuest.Setup then
			vars.WromthraxCaveQuest.Setup = true
			for i, v in Map.FacetData do
				if v.Id == PORTAL_FACET_INDEX then
					vars.WromthraxCaveQuest.OldBitmapIds = vars.WromthraxCaveQuest.OldBitmapIds or {}
					local f = Map.Facets[v.FacetIndex]
					vars.WromthraxCaveQuest.OldBitmapIds[v.FacetIndex] = f.BitmapId
				end
			end
			local WromthraxId -- could be assumed 0 because he is the only monster on the map, but just in case I'll do a loop
			for k, v in Map.Monsters do
				if v.NameId == 117 then
					WromthraxId = k
					break
				end
			end
			if not WromthraxId then error("Couldn't locate Wromthrax in Map.Monsters array") end
			local wrom = Map.Monsters[WromthraxId]
			XYZ(wrom, 17477, 6215, -127) -- move him deeper into the cave, where he'll be protected by his legions of monsters
			wrom.StartX, wrom.StartY, wrom.StartZ, wrom.GuardX, wrom.GuardY, wrom.GuardZ = 17477, 6215, -127, 17477, 6215, -127
			wrom.HP, wrom.FullHP = math.round(wrom.FullHP * diffsel(1.3, 1.8, 2.5)), math.round(wrom.FullHP * diffsel(1.3, 1.8, 2.5))
			wrom.Group = 255
			wrom.Spell, wrom.SpellChance, wrom.SpellSkill = const.Spells.IceBlast, (difficulty + 1) * 10, JoinSkill((difficulty + 1) * 5, const.GM)
			wrom.Spell2, wrom.Spell2Chance, wrom.Spell2Skill = const.Spells.PowerCure, (difficulty + 1) * 15, JoinSkill((difficulty + 1) * 10, const.GM)
			boostResistances(wrom, diffsel(20, 40, 60))
			wrom.Attack1.DamageAdd = diffsel(20, 25, 30)
			wrom.TreasureDiceCount = wrom.TreasureDiceCount * 3
		end
		local spawnKnights = function()
			local canSpawn = MAX_SPAWNED_AT_ONCE - #spawnedEtherKnightIds[1]
			local max = math.min(math.floor(MAX_SPAWNED_AT_ONCE / 2), m)
			if max > 0 then
				local mons = pseudoSpawnpoint{monster = 154, x = 18285, y = 7348, z = -127, "1-" .. max , powerChances = diffsel({70, 20, 10}, {50, 25, 25}, {30, 30, 40}), radius = 512}
				spawnedEtherKnightIds[1] = table.join(spawnedEtherKnightIds[1] or {}, map(mons))
				m = m - #mons
			end
			max = math.min(math.floor(MAX_SPAWNED_AT_ONCE / 2), m)
			if max <= 0 then return end
			mons = pseudoSpawnpoint{monster = 154, x = 15760, y = 3873, z = -127, "1-" .. max , powerChances = diffsel({70, 20, 10}, {50, 25, 25}, {30, 30, 40}), radius = 512}
			spawnedEtherKnightIds[2] = table.join(spawnedEtherKnightIds[2] or {}, map(mons))
		end
		if not vars.WromthraxCaveQuest.PortalDeactivated then
			--Timer(spawnKnights, const.Minute * 15, Game.Time, true)
			for i, v in Map.FacetData do
				if v.Id == PORTAL_FACET_INDEX then
					v.Event = 200
					local f = Map.Facets[v.FacetIndex]
					f.ScrollUp = true
					f.TriggerByClick = true
				end
			end
			evt.SetTexture{Facet = PORTAL_FACET_INDEX, Name = "sgSTARS"}
			evt.map[200] = function()
				if evt.All.Cmp("Inventory", ETHER_GEM_ID) then
					for i, v in Map.FacetData do
						if v.Id == PORTAL_FACET_INDEX then
							v.Event = 0
							local f = Map.Facets[v.FacetIndex]
							f.ScrollUp = false
							f.TriggerByClick = false
							v.BitmapId = vars.WromthraxCaveQuest.OldBitmapIds[v.FacetIndex]
						end
					end
					vars.WromthraxCaveQuest.PortalDeactivated = true
					evt.All.Subtract("Inventory", ETHER_GEM_ID)
					evt.map[200].clear()
					evt.hint[200].clear()
					RemoveTimer(spawnKnights)
					Game.ShowStatusText("Portal deactivated!")
				else
					Game.ShowStatusText("You need something to close the portal with!")
				end
			end
			evt.hint[200] = "Strange portal"
		else
			-- I don't know if facets changed directly (not by evt command) will have their bitmap IDs saved
			-- on map reload, putting this code just in case
			for i, v in Map.FacetData do
				if v.Id == PORTAL_FACET_INDEX then
					v.BitmapId = vars.WromthraxCaveQuest.OldBitmapIds[v.FacetIndex]
				end
			end
		end
	end
	
	KillMonstersQuest{
		questID,
		{Map = "mdt09orig.blv", Group = 255},
		CheckDone = function() return vars.WromthraxCaveQuest.PortalDeactivated end, -- kill monsters part is handled by MMext?
		Texts = {
			Topic = "Quest",
			TopicDone = false,
			Give = [[For a long time, we had thought that, after many battles, we finally settled on peace with Wromthrax, Tatalia's blue dragon. We had to not disturb him and give him monthly tributes, both in food and gold, and in return he didn't attack or anyhow damage humans. But recently, several people went into his cave and they all reported seeing the dragon inside to work with forces not belonging to this world. He even managed to open a portal and summon new ones through it!
			
			We're afraid they're preparing an invasion into our world. Can you help us? If you manage to somehow close the portal and kill all creatures inside, you'll have done all of us a great favor. But don't go there unprepared. The creatures are really intimidating and it's best that you prepare everything you can before venturing there.]],
			Undone = "Did you fail to counter the dragon's plans? You have to help us, you're our only hope!",
			Done = "Well done! Now conquering Erathia will be a piece of cake. Take these genie lamps as your reward. I've inherited them from my mother, and we both were too afraid to use them. Maybe you'll be able to somehow overpower the genies' wrath.",
			
			Quest = "Deal with the dangerous forces in Wromthrax's Cave in Tatalia and return to [X] in [Y].",
			Award = "Stopped Wromthrax's evil plans"
		}
	}
end