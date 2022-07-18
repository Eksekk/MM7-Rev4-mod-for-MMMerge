local spellsDamage =
{
	[2] = -- Fire Bolt
	{
		DamageBase = 6,
		DamagePerSkill = "1-4"
	},
	[6] = -- Fireball
	{
		DamagePerSkill = "1-8"
	},
	[7] = -- Fire Spike
	{
		[const.GM] = {DamagePerSkill = "1-12"},
		[const.Master] = {DamagePerSkill = "1-10"},
		[const.Expert] = {DamagePerSkill = "1-8"},
		[const.Novice] = {DamagePerSkill = "1-8"}
	},
	[8] = -- Immolation
	{
		DamagePerSkill = "1-7"
	},
	[10] = -- Inferno
	{
		DamageBase = 17,
		DamagePerSkill = "2-2"
	},
	[11] = -- Incinerate
	{
		DamageBase = 25,
		DamagePerSkill = "5-20"
	},
	[15] = -- Sparks
	{
		DamageBase = 2,
		DamagePerSkill = "1-2"
	},
	[18] = -- Lightning Bolt
	{
		DamagePerSkill = "1-10"
	},
	[20] = -- Implosion
	{
		DamageBase = 20,
		DamagePerSkill = "1-13"
	},
	[24] = -- Poison Spray
	{
		DamageBase = 5,
		DamagePerSkill = "1-3"
	},
	[26] = -- Ice Bolt
	{
		DamageBase = 10,
		DamagePerSkill = "1-5"
	},
	[29] = -- Acid Burst
	{
		DamageBase = 12,
		DamagePerSkill = "1-11"
	},
	[32] = -- Ice Blast
	{
		DamageBase = 15,
		DamagePerSkill = "1-7"
	},
	[37] = -- Deadly Swarm
	{
		DamageBase = 10,
		DamagePerSkill = "1-5"
	},
	[39] = -- Blades
	{
		DamagePerSkill = "1-10"
	},
	[41] = -- Rock Blast
	{
		DamageBase = 20,
		DamagePerSkill = "1-10"
	},
	[43] = -- Death Blossom
	{
		DamageBase = 20,
		DamagePerSkill = "2-5"
	},
	[52] = -- Spirit Lash
	{
		DamageBase = 15,
		DamagePerSkill = "3-10"
	},
	[59] = -- Mind Blast
	{
		DamageBase = 6,
		DamagePerSkill = "1-4"
	},
	[65] = -- Psychic Shock
	{
		DamageBase = 20,
		DamagePerSkill = "1-14"
	},
	[70] = -- Harm
	{
		DamageBase = 15,
		DamagePerSkill = "1-3"
	},
	[76] = -- Flying Fist
	{
		DamageBase = 40,
		DamagePerSkill = "1-10"
	},
	[78] = -- Light Bolt
	{
		DamagePerSkill = "1-6"
	},
	[79] = -- Destroy Undead
	{
		DamageBase = 20,
		DamagePerSkill = "1-20"
	},
	[84] = -- Prismatic Light
	{
		DamageBase = 25,
		DamagePerSkill = "1-2"
	},
	[87] = -- Sunray
	{
		DamageBase = 40,
		DamagePerSkill = "10-22"
	},
	[90] = -- Toxic Cloud
	{
		DamageBase = 35,
		DamagePerSkill = "1-12"
	},
	[93] = -- Shrapmetal
	{
		DamagePerSkill = "1-7"
	},
	[97] = -- Dragon Breath
	{
		DamageBase = 25,
		DamagePerSkill = "10-25"
	},
	[103] = -- Darkfire Bolt
	{
		DamagePerSkill = "5-19"
	},
	[111] = -- Life Drain
	{
		[const.GM] = {DamagePerSkill = "1-8", DamageBase = 15},
		[const.Master] = {DamagePerSkill = "1-6", DamageBase = 10},
		[const.Expert] = {DamagePerSkill = "1-4", DamageBase = 6},
		[const.Novice] = {DamagePerSkill = "1-4", DamageBase = 6}
	}
}

local function Randoms(min, max, count)
	local r = 0
	for i = 1, count do
		r = r + math.random(min, max)
	end
	return r
end

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

function events.CalcSpellDamage(t)
	local entry = spellsDamage[t.Spell]
	if not entry then return end
	local s, m = SplitSkill(t.Skill)
	if entry.DamagePerSkill then -- isn't split into mastery-dependent damage
		local min, max = getRange(entry.DamagePerSkill)
		t.Result = (entry.DamageBase or 0) + Randoms(min, max, s)
	else
		local entry2 = nil
		while m <= const.GM and not entry2 do
			entry2 = entry[m]
			m = m + 1
		end
		assert(entry2)
		entry = entry2
		local min, max = getRange(entry.DamagePerSkill)
		t.Result = (entry.DamageBase or 0) + Randoms(min, max, s)
	end
end