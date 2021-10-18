local questID = "ClearFortRiverstride"
if Merge.ModSettings.Rev4ForMergeActivateExtraQuests == 1 then
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
	
	local lookupTable = {}
	local function getRange(str)
		if lookupTable[str] then return lookupTable[str][1], lookupTable[str][2] end
		local min, max = str:match("(%d+)%-(%d+)")
		min = tonumber(min)
		max = tonumber(max)
		assert(min ~= nil and max ~= nil)
		lookupTable[str] = {min, max}
		return min, max
	end
	
	local random = math.random
	local summoned = {}
	local function pseudoSpawnpoint(monster, x, y, z, count, powerChances, radius)
		count = count or "1-3"
		assert(type(count) == "string")
		powerChances = powerChances or {34, 33, 33}
		for i, v in ipairs(powerChances) do
			if v == 0 then
				powerChances[i] = nil
			end
		end
		radius = radius or 64
		assert(monster and x and y and z and true or nil)
		local class = (monster + 2):div(3)
		
		local min, max = getRange(count)
		local toCreate = random(min, max)
		
		for i = 1, toCreate do
			-- https://stackoverflow.com/questions/9879258/how-can-i-generate-random-points-on-a-circles-circumference-in-javascript
			local angle = random() * math.pi * 2
			local xadd = math.cos(angle) * radius
			local yadd = math.sin(angle) * radius
			
			local power = nil
			local rand = random(1, 100)
			if rand < powerChances[1] or (not powerChances[2] and not powerChances[3]) then
				power = 0
			elseif powerChances[2] and rand < powerChances[2] + powerChances[1] then
				power = 1
			elseif powerChances[3] then
				power = 2
			elseif powerChances[2] then
				power = 1
			else
				power = 0
			end
			
			table.insert(summoned, (SummonMonster(class * 3 - 2 + power, x + xadd, y + yadd, z, true)))
		end
	end
	
	function events.AfterLoadMap()
		if Map.Name == "7d31.blv" then -- Fort Riverstride
			Game.MapEvtLines:RemoveEvent(451)
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
					SummonMonster(258, -1064 + 250 * i, -193, -448)
				end
				
				-- oozes
				for i = 0, 8 do
					SummonMonster(311, -1002 + 250 * i, 137, -448)
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