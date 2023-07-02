local u1, u2, u4, i1, i2, i4 = mem.u1, mem.u2, mem.u4, mem.i1, mem.i2, mem.i4
local hook, autohook, autohook2, asmpatch = mem.hook, mem.autohook, mem.autohook2, mem.asmpatch
local max, min, round, random = math.max, math.min, math.round, math.random
local format = string.format
local MS = Merge.ModSettings

-- INCREASED DAMAGE --

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

local function calcStatDamageMul(pl)
	local stats = pl:GetIntellect() + pl:GetPersonality()
	return 0.01 * (stats / 10) -- every 10 points gives extra 1% damage
end

local function calcStatDamageBonus(pl, damage)
	if MS.Rev4ForMergeIntellectPersonalityIncreaseSpellDamage == 1 then
		damage = damage + math.round(damage * calcStatDamageMul(pl))
	end
	return damage
end

if MS.Rev4ForMergeIntellectPersonalityIncreaseSpellDamage == 1 then
	table.insert(tget(rev4m, "addTextFunctions"), function(pl)
		local percentage = calcStatDamageMul(pl) * 100
		return string.format("Extra spell damage from personality\r\n and intellect: %.1f%%", percentage)
	end)
end

function events.CalcSpellDamage(t)
	local entry = spellsDamage[t.Spell]
	if entry then
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

	-- stat damage bonus
	local data = WhoHitMonster()
	if data and data.Player then
		t.Result = calcStatDamageBonus(data.Player, t.Result)
	end
end

-- OTHER CHANGES --

if MS.Rev4ForMergeMiscSpellChanges == 1 then
	function events.PlayerSpellVar(t)
		-- buff stoneskin
		if t.Spell == const.Spells.StoneSkin and t.VarNum == 3 then -- armor per skill
			t.Value = 2
		-- nerf paralyze
		elseif t.Spell == const.Spells.Paralyze and t.VarNum == 1 then -- duration per skill
			t.Value = 60 -- 1 minute instead of 3
		end
	end

	-- cure weakness affects whole party on GM --

	mem.nop(0x42AE5B) -- disable skipping if target is not weak

	-- skip select target screen on GM
	mem.prot(true)
	u1[0x425EE2] = 8 -- tweak jumptable
	mem.prot()

	-- replace gm code with one that acts on all players
	local spellHookManager = HookManager{rosterIds = 0xB7CA4C, partySize = 0xB7CA60, getPlayerPtr = 0x4026F4, removeCond = 0x48FA06,
	spell = 0x51D820, caster = 0x51D822, target = 0x51D824, getSkillMastery = 0x455B09, cureWeakness = 0x43, party = 0xB20E90, showAnimation = 0x4A6FCE}

	-- show animation
	spellHookManager.asmpatch(0x42AE25, [[
		push edi
		xor edi, edi
		cmp dword [ebp - 4], esi
		je @call
		mov di, word [ebx + 4] ; if not GM, affect only actual target

		@call:
		mov ecx,dword ptr [0x75CE00]
		push edi
		xor eax,eax
		mov ax,word ptr [ebx]
		push eax
		call absolute 0x42D747
		mov ecx,eax
		call absolute %showAnimation%

		; exit conditions
		cmp dword [ebp - 4], esi
		jne @exit ; not GM
		inc edi
		cmp edi, dword [%partySize%]
		jb @call

		@exit:
		pop edi
	]], 0x1F)

	-- cure
	spellHookManager.asmpatch(0x42AE67, [[
		push esi
		xor esi, esi

		@cure:
		push esi
		mov ecx, edi
		call absolute %getPlayerPtr%
		xor ecx, ecx
		mov dword ptr [eax+8], ecx
		mov dword ptr [eax+0xC], ecx

		inc esi
		cmp esi, dword[%partySize%]
		jb @cure

		pop esi
	]], 0x12)

	function events.GameInitialized2()
		Game.SpellsTxt[const.Spells.CureWeakness].GM = Game.SpellsTxt[const.Spells.CureWeakness].GM .. ". Affects whole party with single cast"

		local count
		local spellEntry = Game.SpellsTxt[const.Spells.StoneSkin]
		spellEntry.Description, count = spellEntry.Description:gsub("5 %+ 1 point", "5 %+ 2 points")
		assert(count == 1, "Couldn't change stone skin spell description")

		spellEntry = Game.SpellsTxt[const.Spells.Paralyze]
		spellEntry.Description, count = spellEntry.Description:gsub("3 minutes", "1 minute")
		assert(count == 1, "Couldn't change paralyze spell description")
	end
end