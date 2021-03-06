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
end

--------------------------- WROMTHRAX'S CAVE QUEST

-- There is portal which is spawning ether knights (maybe only if previous spawns are killed)
-- in addition to one-time spawns
-- Wromthrax is buffed and holds "ether gem"
-- after getting ether gem you can interact with the portal to close it
-- now ether knights stop spawning
-- if you clear the entire cave now, the quest is completed
-- add chests?

-- boost spiders level/experience/hit radius?

sharedSpawnpoint = {}
sharedSpawnpoints = {}
local function monClass(Id)
	if not Id then return end
	return (Id + 2):div(3)
end
function sharedSpawnpoint.new(mapname, spawnpointId, monster, max)
	if not mapname or not spawnpointId then error("Invalid parameters passed to sharedSpawnpoint.new function") end
	local MAX_SPAWNED_AT_ONCE = diffsel(4, 6, 8)
	local ret = {}
	local spawns = {}
	local maxSpawnByType = {}
	local spawned = {}
	local settings = {}
	local transforms = {}
	local class = monClass(monster)
	if class and max then
		maxSpawnByType[class] = max
	end
	function ret.setSpawnSettings(s)
		settings = table.copy(s)
	end
	function ret.saveSpawnedMonsters()
		if Map.Name ~= mapname then return end
		mapvars.SharedSpawnpointMonsters = mapvars.SharedSpawnpointMonsters or {}
		mapvars.SharedSpawnpointMonsters[spawnpointId] = {}
		for class, monArray in pairs(spawned) do
			mapvars.SharedSpawnpointMonsters[spawnpointId][class] = mapvars.SharedSpawnpointMonsters[spawnpointId][class] or {}
			for _, mon in ipairs(monArray) do
				table.insert(mapvars.SharedSpawnpointMonsters[spawnpointId][class], mon:GetIndex())
			end
		end
	end
	function ret.loadSpawnedMonsters()
		if Map.Name ~= mapname then return end
		mapvars.SharedSpawnpointMonsters = mapvars.SharedSpawnpointMonsters or {}
		local entry = mapvars.SharedSpawnpointMonsters[spawnpointId]
		if not entry then
			return
		elseif Map.Refilled then
			mapvars.SharedSpawnpointMonsters[spawnpointId] = {}
			return
		end
		for class, mapMonIds in pairs(entry) do
			for _, mapMonId in ipairs(mapMonIds) do
				if mapMonId < Map.Monsters["count"] then
					local mon = Map.Monsters[mapMonId]
					spawned[class] = spawned[class] or {}
					table.insert(spawned[class], mon)
				end
			end
		end
	end
	function ret.addSpawnpoint(data)
		if type(data) ~= "table" then error("Argument passed to sharedSpawnpoint.addSpawnpoint() isn't a table") end
		local class = monClass(data.monster)
		spawns[class] = spawns[class] or {}
		table.insert(spawns[class], data)
	end
	function ret.setMax(mon, max)
		maxSpawnByType[monClass(mon)] = max
	end
	function ret.setDefaultMax(max)
		MAX_SPAWNED_AT_ONCE = max
	end
	function ret.spawn()
		local monsterSpawnpoints, class
		local function spawn2()
			if Map.Name ~= mapname then
				error(string.format("Tried to spawn monsters while on different map. Destination map: %s, current map: %s", mapname, Map.Name))
			end
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
				local canSpawn = (maxSpawnByType[class] or MAX_SPAWNED_AT_ONCE) - #(spawned[class] or {})
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
				if max <= 0 then return end
				local oldC = spawn.count
				spawn.count = tostring(minInOneSpawn) .. "-" .. tostring(max)
				local mons = pseudoSpawnpoint(spawn)
				spawn.count = oldC
				for i, v in ipairs(mons) do
					local class = monClass(v.Id)
					spawned[class] = spawned[class] or {}
					table.insert(spawned[class], mons[i])
					if transforms[class] then
						mons[i] = transforms[class](mons[i])
					end
				end
				canSpawn = canSpawn - #mons
			end
		end
		for k, v in pairs(spawns) do
			class = k
			monsterSpawnpoints = v
			spawn2()
		end
	end
	function ret.getSpawnedMonsters(monster)
		local class = monClass(monster)
		return class and spawned[class] or spawned
	end
	function ret.tryRemoveSpawnedMonster(mon)
		if mapname ~= Map.Name then return end
		if mon then
			local class = monClass(mon.Id)
			spawned[class] = spawned[class] or {}
			local index = table.find(spawned[class], mon)
			if index then
				table.remove(spawned[class], index)
			end
		else
			spawned = {}
		end
	end
	ret.tryRemoveAllSpawnedMonsters = ret.tryRemoveSpawnedMonster
	function ret.clearSpawns(monster)
		local class = monClass(monster)
		if class then
			spawns[class] = {}
		else
			spawns = {}
		end
	end
	ret.clearAllSpawns = ret.clearSpawns
	function ret.getMap()
		return mapname
	end
	function ret.setTransform(mon, fn)
		transforms[monClass(mon)] = fn
	end
	function ret.clearSpawnedTable()
		spawned = {}
	end
	
	table.insert(sharedSpawnpoints, ret)
	return ret
end

local cleared -- needed to not save twice on leaving map (first time from LeaveMap, clearing table,
			  -- and second time from BeforeSaveGame, overriding correct table with empty one)
function events.LoadMap()
	cleared = false
	for _, ss in ipairs(sharedSpawnpoints) do
		ss.loadSpawnedMonsters()
		--debug.Message(dump(ss.getSpawnedMonsters(), 2))
	end
end

local save = function(clear)
	return function()
		if cleared then return end
		for _, ss in ipairs(sharedSpawnpoints) do
			ss.saveSpawnedMonsters()
			if clear then
				cleared = true
				ss.clearSpawnedTable()
			end
		end
	end
end

events.LeaveMap = save(true)
events.BeforeSaveGame = save(false)

function events.MonsterKilled(mon, index, handler)
	for _, ss in ipairs(sharedSpawnpoints) do
		ss.tryRemoveSpawnedMonster(mon)
	end
end
if MS.Rev4ForMergeActivateExtraQuests == 1 and MS.Rev4ForMergeDuplicateModdedDungeons == 1 then
	-- chests, ground items?
	-- randomized monster spells, monster bonuses
	function events.GameInitialized2()
		Game.MapStats[238].Tres = 7
	end
	
	local function boostResistances(mon, amount)
		local i = 1
		for k, v in pairs(const.Damage) do
			if v ~= 12 and v ~= 50 and v ~= 5 and mon.Resistances[v] < const.MonsterImmune then -- Energy, Dragon, Magic
				mon.Resistances[v] = math.min(const.MonsterImmune, mon.Resistances[v] + (type(amount) == "table" and amount[i] or amount))
			end
			i = i + 1
		end
	end
	
	local spells =
	{
		{Spell = 2, Skill = 12, Mastery = const.GM, Chance = 50}, -- Fire Bolt
		{Spell = 11, Skill = 4, Mastery = const.GM, Chance = 30}, -- Incinerate
		{Spell = 18, Skill = 7, Mastery = const.GM, Chance = 40}, -- Lightning Bolt
		{Spell = 24, Skill = 12, Mastery = const.Master, Chance = 50}, -- Poison Spray
		{Spell = 37, Skill = 10, Mastery = const.GM, Chance = 50}, -- Deadly Swarm
		{Spell = 39, Skill = 10, Mastery = const.GM, Chance = 40}, -- Blades
		{Spell = 59, Skill = 7, Mastery = const.GM, Chance = 50}, -- Mind Blast
		{Spell = 65, Skill = 7, Mastery = const.GM, Chance = 30}, -- Psychic Shock
		{Spell = 76, Skill = 4, Mastery = const.GM, Chance = 30}, -- Flying Fist
	}
	
	local function randomGiveSpell(mon)
		-- TODO: add more spells
		local roll = math.random(0, 2)
		if roll == 0 or (mon.Spell ~= 0 and mon.Spell2 ~= 0) then
			return
		end
		local i = math.random(1, #spells)
		local firstSpell = spells[i]
		local addedFirst = false
		if not mon.Spell then
			mon.Spell, mon.SpellChance, mon.SpellSkill = firstSpell.Spell, firstSpell.Chance or 30, JoinSkill(firstSpell.Skill, firstSpell.Mastery)
			addedFirst = true
		end
		if (roll <= 1 and addedFirst) or mon.Spell2 ~= 0 then
			return
		end
		if not addedFirst then
			local j
			repeat
				j = math.random(1, #spells)
			until mon.Spell ~= spells[j].Spell
			mon.Spell2, mon.Spell2Chance, mon.Spell2Skill = firstSpell.Spell, firstSpell.Chance or 30, JoinSkill(firstSpell.Skill, firstSpell.Mastery)
			return
		end
		local j
		repeat
			j = math.random(1, #spells)
		until firstSpell.Spell ~= spells[j].Spell
		local secondSpell = spells[j]
		mon.Spell2, mon.Spell2Chance, mon.Spell2Skill = secondSpell.Spell, secondSpell.Chance or 30, JoinSkill(secondSpell.Skill, secondSpell.Mastery)
	end
	
	local function randomGiveElementalAttack(mon)
		local a1, a2 = mon.Attack1, mon.Attack2
		if a1 then
			if a2 then
				return
			end
			a2.Type = math.random(0, 7)
			if a2.Type > 3 then
				a2.Type = math.random(9, 10)
			end
			a2.DamageDiceCount, a2.DamageDiceSides, a2.DamageAdd, a2.Missile = math.random(3, diffsel(3, 4, 5)), math.random(3, diffsel(3, 4, 5)), math.random(2, diffsel(5, 7, 10)) * 3, a2.Type + 3
			mon.Attack2Chance = 50
			return
		end
		a1.DamageDiceCount, a1.DamageDiceSides, a1.DamageAdd, a1.Missile = math.random(3, diffsel(3, 4, 5)), math.random(3, diffsel(3, 4, 5)), math.random(2, diffsel(5, 7, 10)) * 3, a2.Type + 3
	end
	
	local function randomBoostResists(mon)
		boostResistances(mon, math.random(3, diffsel(6, 8, 10)) * 5)
	end
	
	local sp = sharedSpawnpoint.new("mdt09orig.blv", "WromthraxCaveQuest")
	sp.setSpawnSettings{["RandomSpawnpointOrder"] = 1, ["DivideAcrossAllSpawnpoints"] = 1}
	sp.addSpawnpoint{monster = 154, x = 18285, y = 7348, z = -127, powerChances = diffsel({70, 20, 10}, {50, 25, 25}, {30, 30, 40}), radius = 512}
	sp.addSpawnpoint{monster = 154, x = 15760, y = 3873, z = -127, powerChances = diffsel({70, 20, 10}, {50, 25, 25}, {30, 30, 40}), radius = 512}
	sp.addSpawnpoint{monster = 154, x = 15002, y = 6179, z = -127, powerChances = diffsel({70, 20, 10}, {50, 25, 25}, {30, 30, 40}), radius = 512}
	sp.setMax(154, diffsel(8, 10, 12))
	sp.setTransform(154, function(mon) randomBoostResists(mon); randomGiveSpell(mon); mon.TreasureDiceCount = mon.TreasureDiceCount * 3; return mon end)
	
	sp.addSpawnpoint{monster = 151, x = 16058, y = 8317, z = -127, powerChances = diffsel({70, 20, 10}, {50, 25, 25}, {30, 30, 40}), radius = 512}
	sp.addSpawnpoint{monster = 151, x = 16913, y = 4169, z = -127, powerChances = diffsel({70, 20, 10}, {50, 25, 25}, {30, 30, 40}), radius = 512}
	sp.setMax(151, diffsel(3, 5, 7))
	sp.setTransform(151, function(mon) randomBoostResists(mon); mon.PhysResistance = 100; randomGiveElementalAttack(mon); mon.TreasureDiceCount = mon.TreasureDiceCount * 3 return mon end)
	
	sp.addSpawnpoint({monster = 145, x = 13493, y = 2928, z = -127, powerChances = diffsel({70, 20, 10}, {50, 25, 25}, {30, 30, 40}), radius = 1024})
	sp.setMax(145, diffsel(3, 4, 6))
	sp.setTransform(145, function(mon) randomBoostResists(mon); return mon end)
	
	local questID = "WromthraxCaveDisablePortalAndClear"
	local PORTAL_FACET_INDEX = 10
	local DARK_TALISMAN_ID = 981
	vars.WromthraxCaveQuest = vars.WromthraxCaveQuest or {}
	function events.AfterLoadMap() -- need to execute after binding map monsters with spawnpoints that spawned them
		if Map.Name ~= "mdt09orig.blv" then return end
		if not vars.WromthraxCaveQuest.Setup then
			vars.WromthraxCaveQuest.Setup = true
			for i, v in Map.FacetData do
				if v.Id == PORTAL_FACET_INDEX then
					vars.WromthraxCaveQuest.OldBitmapIds = vars.WromthraxCaveQuest.OldBitmapIds or {}
					local f = Map.Facets[v.FacetIndex]
					vars.WromthraxCaveQuest.OldBitmapIds[v.FacetIndex] = f.BitmapId
				end
			end
			
			--[[local function randomizeAndSetCorrectType(obj, level, typ) -- override general function, because we don't want to remove items
				debug.Message(obj.Item.Number)
				obj.Item:Randomize(level, typ)
				debug.Message(obj.Item.Number)
				obj.Type = Game.ItemsTxt[obj.Item.Number].SpriteIndex
				obj.TypeIndex = Game.ItemsTxt[obj.Item.Number].SpriteIndex
			end
			for i, v in Map.Objects do
				if v.Item and v.Item.Number ~= 0 then
					randomizeAndSetCorrectType(v, 6)
				end
			end]]
			
			local WromthraxId -- could be assumed 0 because he is the only monster on the map, but just in case I'll do a loop
			for k, v in Map.Monsters do
				if v.NameId == 117 then
					WromthraxId = k
					break
				end
			end
			if WromthraxId then
				local wrom = Map.Monsters[WromthraxId]
				XYZ(wrom, 17477, 6215, -127) -- move him deeper into the cave, where he'll be protected by his legions of monsters
				wrom.StartX, wrom.StartY, wrom.StartZ, wrom.GuardX, wrom.GuardY, wrom.GuardZ = XYZ(wrom), XYZ(wrom)
				wrom.HP, wrom.FullHP = math.round(wrom.FullHP * diffsel(1.2, 1.6, 2.1)), math.round(wrom.FullHP * diffsel(1.2, 1.6, 2.1))
				wrom.Group = 255
				wrom.Spell, wrom.SpellChance, wrom.SpellSkill = const.Spells.IceBlast, (difficulty + 1) * 10, JoinSkill((difficulty + 1) * 5, const.GM)
				wrom.Spell2, wrom.Spell2Chance, wrom.Spell2Skill = const.Spells.PowerCure, (difficulty + 1) * 15, JoinSkill((difficulty + 1) * 8, const.GM)
				boostResistances(wrom, diffsel(10, 30, 50))
				wrom.Attack1.DamageAdd = diffsel(20, 25, 30)
				wrom.TreasureDiceCount = wrom.TreasureDiceCount * 3
				evt.SetMonsterItem{Monster = WromthraxId, Item = DARK_TALISMAN_ID, Has = true}
			else
				-- killed before enabling extra quests
				SummonItem(DARK_TALISMAN_ID, 17477, 6215, -127)
			end
			
			-- no chests, so let's just scatter a bunch of highest-lvl items
			pseudoSpawnpointItem{item = 1, x = 14557, y = 5769, z = -127, count = 35, radius = 4096, level = 6}
			
			-- one-time spawnpoints
			-- knights
			local n = pseudoSpawnpoint{monster = 154, x = 9418, y = 9879, z = -127, count = diffsel("3-6", "5-9", "8-13"), powerChances = diffsel({60, 30, 10}, {50, 25, 25},  {34, 33, 33}), radius = 4096}
			n = table.join(n, pseudoSpawnpoint{monster = 154, x = 10281, y = 2911, z = -127, count = diffsel("3-6", "5-9", "8-13"), powerChances = diffsel({60, 30, 10}, {50, 25, 25},  {34, 33, 33}), radius = 4096})
			for i, v in ipairs(n) do
				randomBoostResists(v)
				randomGiveSpell(v)
				v.TreasureDiceCount = v.TreasureDiceCount * 3
				--randomGiveElementalAttack(v)
			end
			
			-- nightmares
			n = pseudoSpawnpoint{monster = 151, x = 7073, y = 3927, z = -127, count = diffsel("2-4", "4-7", "6-10"), powerChances = diffsel({60, 30, 10}, {50, 25, 25},  {34, 33, 33}), radius = 4096}
			for i, v in ipairs(n) do
				randomBoostResists(v)
				v.PhysResistance = 150
				randomGiveElementalAttack(v)
				v.TreasureDiceCount = v.TreasureDiceCount * 3
			end
			
			-- "MM8 behemoths"
			n = pseudoSpawnpoint{monster = 145, x = 11704, y = 6109, z = 65, count = diffsel("2-4", "4-7", "7-11"), powerChances = diffsel({60, 30, 10}, {50, 25, 25},  {34, 33, 33}), radius = 4096}
			for i, v in ipairs(n) do
				randomBoostResists(v)
				--randomGiveElementalAttack(v)
			end
		end
		
		if not vars.WromthraxCaveQuest.PortalDeactivated then
			Timer(sp.spawn, const.Minute * 30, Game.Time, true)
			function rem()
				RemoveTimer(sp.spawn)
				events.Remove("LeaveMap", rem)
				events.Remove("LeaveGame", rem)
			end
			events.LeaveMap = rem
			events.LeaveGame = rem
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
				if evt.All.Cmp("Inventory", DARK_TALISMAN_ID) then
					for i, v in Map.FacetData do
						if v.Id == PORTAL_FACET_INDEX then
							v.Event = 0
							local f = Map.Facets[v.FacetIndex]
							f.ScrollUp = false
							f.TriggerByClick = false
							v.BitmapId = vars.WromthraxCaveQuest.OldBitmapIds[f.FacetIndex]
						end
					end
					vars.WromthraxCaveQuest.PortalDeactivated = true
					evt.All.Subtract("Inventory", DARK_TALISMAN_ID)
					evt.map[200].clear()
					RemoveTimer(sp.spawn)
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
		CheckDone = function() return vars.WromthraxCaveQuest.PortalDeactivated end, -- kill monsters part is handled by MMExt
		NPC = 779, -- Rawn Talreish in Erathia (house with a pillar in front of it)
		Slot = 3,
		Experience = 200000,
		Gold = 30000,
		Done = function() for i = 0, 2 do for j = 1, 3 + (2 - i) do evt.Add("Inventory", 1491 + i) end end end, --  5 Kergar, 4 Erudine, 3 Stalt
		Texts = {
			Topic = "Quest",
			TopicDone = false,
			Give = [[For a long time, we had thought that, after many battles, we finally settled on peace with Wromthrax, Tatalia's blue dragon. We had to not disturb him and give him monthly tributes, both in food and gold, and in return he didn't attack or anyhow damage humans. But recently, several people went into his cave and they all reported seeing the dragon inside to work with forces not belonging to this world. He even managed to open a portal and summon new ones through it!

We're afraid they're preparing an invasion into our world. Can you help us? If you manage to somehow close the portal and kill all creatures inside, you'll have done all of us a great favor. But don't go there unprepared. The creatures are really intimidating and it's best that you prepare everything you can before venturing there.]],
			Undone = "Did you fail to counter the dragon's plans? You have to help us, you're our only hope!",
			Done = "Well done! Now we will feel much safer, thanks to you. Take these pieces of ore I've found in my travels. Hope they will help you.",
			
			Quest = "Deal with the dangerous forces in Wromthrax's Cave in Tatalia and return to Rawn Talreish in Erathia.",
			Award = "Stopped Wromthrax's evil plans"
		}
	}
	
	
	
	-- CLANKER'S LAB QUEST
	-- quest giver: Elzbet Winterspoon (Nighon, master alchemy trainer)
	-- could be alchemy GM, but he already manages one quest in Rev4
	-- bring back pristine Phoenix Feather, pristine Dragon Turtle Fang and pristine Unicorn Horn
	local rewardItem = 1394 -- Mog'Draxar
	local itemIDs = {982, 983, 984}
	local questID = "ClankersLabCollectPowerfulReagents"
	Quest{
		questID,
		NPC = 546, -- Elzbet Winterspoon in Nighon
		Slot = 2,
		Experience = 125000,
		Gold = 25000,
		CheckDone = function()
			for i = 1, 3 do
				if not evt.Cmp("Inventory", itemIDs[i]) then
					return false
				end
			end
			return true
		end,
		Done = function()
			for i = 1, 3 do
				evt.Subtract("Inventory", itemIDs[i])
			end
			
			-- give 5 of each MM7 strongest reagent
			for i = 0, 4 do
				for j = 0, 15, 5 do
					evt.GiveItem{Id = 1006 + j}
				end
			end
			evt.GiveItem{Id = rewardItem}
		end,
		Texts = {
			Topic = "Quest",
			TopicDone = false,
			Give = [[I've always had dreams of becoming the greatest alchemist in the world. They have been made impossible by Clanker's and Lucid Apple's success, obviously. But I still can be much better than I am right now.
			
I've read about an old concoction, appropriately named Potion of the Swift Mind, which reportedly greatly enhances the imbiber's intelligence. I don't believe it is as good as it sounds, but still, something is better than nothing, right?

Unfortunately, it requires three magic reagents I don't have: Pristine Phoenix Feather, Pristine Dragon Turtle Fang and Pristine Unicorn Horn. They're so powerful that the alchemists have used up all of them long time ago. Except... Yes, maybe my greatest adversary could prove useful for once. There's a sliver of chance that Clanker has them in his old lab in Tularean forest. Will you help an old woman pursue her dream? You'll be greatly rewarded for your support.

But beware, this place attracts magic like crazy. I wouldn't be surprised if Clanker used this aura to create some powerful magical guardians to assist in defending his place. He won't give away his secrets so easily.]],
			Undone = "Did you not find them? Please search the lab thoroughly, knowing Clanker he hid them in most obscure locations.",
			Done = "YOU HAVE DONE IT? Found them? I don't know why he hadn't used them all. But yes, finally some of his character paid off. You will receive your reward as promised. Thanks again for doing the impossible.",
			
			Quest = "Find three alchemical reagents of immense power in Clanker's Laboratory and deliver them to Elzbet Winterspoon in Nighon",
			Award = "Assisted in creation of the ancient Potion of the Swift Mind."
		}
	}
	
	local manaRing = 985
	function events.LoadMap()
		if Map.Name ~= "7d12orig.blv" then return end
		
		if not mapvars.ClankersLabSetup then
			mapvars.ClankersLabSetup = true
			-- genies
			pseudoSpawnpoint{monster = 265, x = 14, y = 179, z = 1, count = diffsel("1-3", "2-4", "4-5"), powerChances = diffsel({70, 20, 10}, {50, 30, 20}, {34, 33, 33}), radius = 512, group = 56}
			pseudoSpawnpoint{monster = 265, x = 677, y = 2844, z = 385, count = diffsel("1-3", "2-4", "4-5"), powerChances = diffsel({70, 20, 10}, {50, 30, 20}, {34, 33, 33}), radius = 512, group = 56}
			pseudoSpawnpoint{monster = 265, x = 2969, y = 673, z = 193, count = diffsel("1-3", "2-4", "4-5"), powerChances = diffsel({70, 20, 10}, {50, 30, 20}, {34, 33, 33}), radius = 256, group = 56}
			
			-- liches
			pseudoSpawnpoint{monster = 289, x = 2641, y = 2434, z = 385, count = diffsel("1-3", "2-4", "4-5"), powerChances = diffsel({70, 20, 10}, {50, 30, 20}, {34, 33, 33}), radius = 512, group = 56}
			pseudoSpawnpoint{monster = 289, x = -2412, y = 2073, z = 385, count = diffsel("1-3", "2-4", "4-5"), powerChances = diffsel({70, 20, 10}, {50, 30, 20}, {34, 33, 33}), radius = 512, group = 56}
			
			-- manticores
			pseudoSpawnpoint{monster = 295, x = -699, y = 3672, z = 385, count = diffsel("1-2", "2-3", "3-4"), powerChances = diffsel({70, 20, 10}, {50, 30, 20}, {34, 33, 33}), radius = 256, group = 56}
			pseudoSpawnpoint{monster = 295, x = 638, y = 3674, z = 385, count = diffsel("1-2", "2-3", "3-4"), powerChances = diffsel({70, 20, 10}, {50, 30, 20}, {34, 33, 33}), radius = 256, group = 56}
			
			-- miniboss: Clanker's Puppet, mage
			local wiz = pseudoSpawnpoint{monster = 292, x = 321, y = 1735, z = 385, count = "1-1", powerChances = {0, 100, 0}, radius = 32, group = 56, exactZ = true}
			wiz = wiz[1]
			wiz.FullHP = wiz.FullHP * diffsel(3, 4, 5)
			wiz.HP = wiz.FullHP
			boostResistances(wiz, diffsel(40, 60, 80))
			wiz.ArmorClass = wiz.ArmorClass * 2
			wiz.Attack1.DamageDiceCount = wiz.Attack1.DamageDiceCount * 2
			wiz.NameId = 196
			wiz.Experience = wiz.Experience * 25
			wiz.Special = 1 -- shoot
			wiz.SpecialC = 5 -- x5
			
			-- reward: Enchanter's Ring of Mana Flows
			wiz.Item = manaRing
			
			-- f##k dispel magic, also he needs a damage spell and healing ability
			wiz.Spell, wiz.SpellSkill, wiz.SpellChance = const.Spells.PsychicShock, JoinSkill(diffsel(10, 13, 16), const.GM), 50
			wiz.Spell2, wiz.Spell2Skill, wiz.Spell2Chance = const.Spells.PowerCure, JoinSkill(diffsel(20, 25, 30), const.GM), 30
			
			-- additional random items in chests
			
			for chestID = 1, 14 do
				local fifth, sixth = false, false
				for i, item in Map.Chests[chestID].Items do
					if item.Number == 0 and not sixth then
						item:Randomize(6)
						sixth = true
						if fifth then
							break
						end
					elseif item.Number == 0 and not fifth then
						item:Randomize(5)
						fifth = true
						if sixth then
							break
						end
					end
				end
			end
			
			-- put quest items
			-- shelf near evil eye with clanker's amulet
			pseudoSpawnpointItem{item = itemIDs[1], x = 1930, y = -830, z = 289, count = 1, radius = 16, exactZ = true}
			-- on the ground in left reagents storage
			pseudoSpawnpointItem{item = itemIDs[2], x = -2500, y = 2398, z = 385, count = 1, radius = 16, exactZ = true}
			
			-- in chest, left room at the top of minimap
			for i, item in Map.Chests[10].Items do
				if item.Number == 0 then
					item.Number = itemIDs[3]
					break
				end
			end
		end
	end
	
	function events.RegenTick(pl)
		if pl:WearsItem(manaRing) then
			local FSP = pl:GetFullSP()
			pl.SP = math.min(math.max(FSP, pl.SP), pl.SP + 10)
		end
	end
	
	function events.CalcStatBonusByItems(t)
		if not t.Player:WearsItem(rewardItem) then return end
		if t.Stat == const.Stats.HP or t.Stat == const.Stats.SP then
			t.Result = t.Result + 100
		end
	end
	
	function events.GetSkill(t)
		if not t.Player:WearsItem(rewardItem) then return end
		if (t.Skill >= const.Skills.Staff and t.Skill <= const.Skills.Blaster) or (t.Skill >= const.Skills.Fire and t.Skill <= const.Skills.Dark) or t.Skill == const.Skills.Armsmaster then
			local s, m = SplitSkill(t.Result)
			t.Result = JoinSkill(s + 3, m)
		end
	end
	
	
	-- TULAREAN CAVERNS QUEST
	-- similar to original, rescue a prisoner, but you have to use a key and have to kill custom guards
	
	local cellKey = 979
	local jailerNameId = 197
	local NpcToRescue = 1286
	local questGiverHouseId = 1105
	
	local questId = "TulareanCavesRescuePrisoner"
	
	-- imprisoned and in party topic
	NPCTopic{
		NPC = NpcToRescue,
		Slot = 0,
		CanShow = function() return vars.Quests[questID] ~= "Done" end,
		"Rescue",
		"Thanks again for rescuing me! You are true heroes."
	}
	
	-- thank you topic & greeting
	NPCTopic{
		NPC = NpcToRescue,
		Slot = 0,
		CanShow = function() return vars.Quests[questID] == "Done" end,
		"The rescue",
		"Thanks again for rescuing me! You are true heroes and have done your people a great favor."
	}
	Greeting{
		NPC = NpcToRescue,
		CanShow = function() return vars.Quests[questID] == "Done" end,
		""
	}
	Quest{
		questId,
		NPC = 588, -- Matric Bowes in Harmondale (he's kinda hidden, he resides in house behind weapon/armor shop),
		-- I always wanted his location to be starting point of an amazing quest
		Slot = 2,
		Experience = 75000,
		Gold = 10000,
		CheckDone = function()
			return NPCFollowers.NPCInGroup(NpcToRescue)
		end,
		Done = function()
			NPCFollowers.Remove(NpcToRescue)
			evt.MoveNPC{NPC = NpcToRescue, HouseId = questGiverHouseId}
			ReloadHouse()
		end,
		Texts = {
			Topic = "Quest",
			TopicDone = false,
			Give = [[I'm glad you've come here. I need your help desperately. See, my best friend Bradley Clark is also a very important person (he is one of human ambassadors who have dealt with elves). That's not as fortunate as it might seem, because elves have kidnapped and imprisoned him! Since then, I've fallen into deep sorrow. I can't take the fact my best friend is no longer here with me, and what's worse, he suffers or maybe even is tortured for information!
			
I've had a private spy hired to investigate this kidnapping, and he reported he's almost sure my friend is kept in Tularean Caves in the forest. There's a connection with the caves from Elvish castle, but our spy was unable to open the way. We have theorized that maybe you need to arrive from the other side. Whatever, even if the locked door can be bypassed, you shouldn't take this route. You'll have entire legion of elves mad at you.

The rescue still won't be easy. You can't escape with him until the route is mostly safe, and I'm almost positive you'll need to find a key first (they probably don't keep such important prisoners unlocked).

Can you do it? You'll be greatly rewarded for your services.]],
			Undone = "",
			Done = "YOU HAVE DONE IT? Found them? I don't know why he hadn't used them all. But yes, finally some of his character paid off. You will receive your reward as promised. Thanks again for doing the impossible.",
			
			Quest = "Find three alchemical reagents of immense power in Clanker's Laboratory and deliver them to Elzbet Winterspoon in Nighon",
			Award = "Assisted in creation of the ancient Potion of the Swift Mind."
		}
	}
end

-- RESTORE TRUMPET QUEST

-- for k, v in Map.Monsters do if Map.RoomFromPoint(XYZ(v)) == 0 then print(k) end end