local u1, u2, u4, i1, i2, i4 = mem.u1, mem.u2, mem.u4, mem.i1, mem.i2, mem.i4
local hook, autohook, autohook2, asmpatch = mem.hook, mem.autohook, mem.autohook2, mem.asmpatch
local max, min, floor, ceil, round, random = math.max, math.min, math.floor, math.ceil, math.round, math.random
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

-- HEALING HOOKS --

local function getSpellQueueData(spellQueuePtr, targetPtr)
	local t = {Spell = i2[spellQueuePtr], Caster = Party.PlayersArray[i2[spellQueuePtr + 2]]}
	t.SpellSchool = ceil(t.Spell / 11)
	local flags = u2[spellQueuePtr + 8]
	if flags:And(0x10) ~= 0 then -- caster is target
		t.Caster = Party.PlayersArray[i2[spellQueuePtr + 4]]
	end
	if flags:And(1) ~= 0 then
		t.FromScroll = true
		t.Skill, t.Mastery = SplitSkill(u2[spellQueuePtr + 0xA])
	else
		t.Skill, t.Mastery = SplitSkill(t.Caster:GetSkill(const.Skills.Fire + t.SpellSchool - 1))
	end
	if targetPtr then
		-- roster id, not index in party
		t.TargetIndex, t.Target = internal.GetPlayer(targetPtr)
	else
		local pl = Party[i2[spellQueuePtr + 4]]
		t.TargetIndex, t.Target = pl:GetIndex(), pl
	end
	return t
end

mem.hookfunction(0x48FA06, 1, 3, function(d, def, targetPtr, cond, timeLow, timeHigh)
	local t = getSpellQueueData(d.ebx, targetPtr)
	events.call("RemoveConditionBySpell", t)
	def(targetPtr, cond, timeLow, timeHigh)
	events.call("AfterRemoveConditionBySpell", t)
end)

function events.AfterRemoveConditionBySpell(t) -- after to allow to add hp when curing eradication/dead (before wouldn't work)
	local t1 = table.copy(t)
	t1.Amount = 0
	events.call("HealingSpellPower", t1)
	if t1.Amount > 0 then
		t1.Target:AddHP(t1.Amount)
	end
end

-- call def or method
-- use player ptr or target in queue

-- either def and use player ptr, or method and index in queue

local function callHealingEvent(d, def, targetPtr, amount)
	local t = getSpellQueueData(d.ebx, targetPtr)
	t.Amount = amount or 0
	events.call("HealingSpellPower", t)
	if t.Amount > 0 then
		if type(def) == "function" then -- autohook passes code address as second argument
			def(targetPtr, t.Amount)
		else
			t.Target:AddHP(t.Amount)
		end
	end
end
--[[
local function spellAddHpHook(d, def, playerPtr, amount)
	callHealingEvent(d, def, playerPtr, amount)
end]]

mem.hookcall(0x42AF62, 1, 1, callHealingEvent)
mem.hookcall(0x42B494, 1, 1, callHealingEvent)

-- don't skip cure insanity code and don't add weakness if char is not insane
-- also remaining resurrection and raise dead and maybe others
do
	local addWeakness = mem.StaticAlloc(1)
	local hooks = HookManager{addWeakness = addWeakness, castSuccessful = 0x42C200}
	
	-- don't skip the code
	hooks.asmpatch(0x42ABC1, [[
		setne cl
		mov byte [%addWeakness%], cl
	]])

	-- don't show animation if not needed
	hooks.asmpatch(0x42ABD9, [[
		test byte [%addWeakness%], 1
		jz absolute 0x42ABF1
		movsx eax,word ptr [ebx+4]
	]], 6)

	-- call healing event if mastery is GM
	autohook(0x42ABF7, callHealingEvent)

	-- don't add weakness if mastery is GM
	hooks.asmhook2(0x42AC03, [[
		test byte [%addWeakness%], 1
		jz absolute %castSuccessful%
	]])

	-- don't add weakness if mastery is below GM (also check for right spell, because iirc resurrection also causes weakness and might also use this code)
	hooks.asmhook(0x42A128, [[
		cmp word [ebx + 2], 0x40
		jne @notCureInsanity
		test byte [%addWeakness%], 1
		jz absolute %castSuccessful%
		@notCureInsanity:
	]])
end

-- SHARED LIFE OVERFLOW FIX --
-- TODO: call healing event and modify total pool

function randomizeHP()
	for i, pl in Party do
		pl.HP = math.random(1, pl:GetFullHP())
	end
end

function doSharedLife(amount)
	-- for each iteration, try to top up lowest HP deficit party member, increasing others' HP along the way
	local function shouldParticipate(pl)
		return pl.Dead == 0 and pl.Eradicated == 0 and pl.Stoned == 0 -- as in default code
	end

	local activePlayers = {}
	local fullHPs = {}
	amount = amount or 0
	for i, pl in Party do
		if shouldParticipate(pl) then
			table.insert(activePlayers, pl)
			fullHPs[pl:GetIndex()] = pl:GetFullHP()
			amount = amount + pl.HP
			pl.HP = 0
		end
	end
	local affectedPlayers = table.copy(activePlayers)
	local pool = amount
	local steps = 0
	while amount > 0 and #activePlayers > 0 do
		steps = steps + 1
		local minDeficit = math.huge
		for i, pl in ipairs(activePlayers) do
			local def = fullHPs[pl:GetIndex()] - pl.HP
			if def > 0 then
				minDeficit = min(minDeficit, def)
			end
		end

		local part = minDeficit
		if minDeficit * #activePlayers > amount then
			part = floor(amount / #activePlayers)
		end

		amount = amount - part * #activePlayers

		local newPlayers = {}
		for i, pl in ipairs(activePlayers) do
			pl.HP = pl.HP + part
			if part == 0 and amount > 0 then
				pl.HP = pl.HP + 1
				amount = amount - 1
			end
			if pl.HP ~= fullHPs[pl:GetIndex()] then
				table.insert(newPlayers, pl)
			end
			--if free and pl.HP < fullHPs[i] then
			--	pl.HP = pl.HP + 1
			--end
		end
		activePlayers = newPlayers
	end
	local result = 0
	local everyoneFull = true
	for i, pl in ipairs(affectedPlayers) do
		result = result + pl.HP
		if pl.HP > 0 then
			pl.Unconscious = 0
		end
		if pl.HP ~= pl:GetFullHP() then
			everyoneFull = false
		end
	end
	assert((pool == result) or everyoneFull, format("Pool %d, result %d, everyoneFull: %s", pool, result, everyoneFull))
	printf("Steps: %d", steps)
	--debug.Message(format("%d HP left", amount))
end

if MS.Rev4ForMergeChangeHealingSpells == 1 then

	local healingSpellPowers =
	{
		[const.Spells.CureInsanity] =
		{
			[const.Master] =
			{
				FixedMin = 10, FixedMax = 30, VariableMin = 3, VariableMax = 5,
			},
			[const.GM] =
			{
				FixedMin = 10, FixedMax = 30, VariableMin = 3, VariableMax = 5,
			}
		},
		[const.Spells.CureDisease] =
		{
			[const.Master] = 
			{
				FixedMin = 25, FixedMax = 45, VariableMin = 2, VariableMax = 4,
			},
			[const.GM] = 
			{
				FixedMin = 25, FixedMax = 45, VariableMin = 2, VariableMax = 4,
			},
		}
	}

	-- SPELL DESCRIPTIONS

	local function calcHealingSpellPower(spell, caster, skill, mastery, amount)
		local entry = healingSpellPowers[spell]
		if not entry then return amount end
		entry = entry[mastery]
		if not entry then return amount end
		local vmin, vmax, fmin, fmax = (entry.VariableMin or 0), (entry.VariableMax or 0), (entry.FixedMin or 0), (entry.FixedMax or 0)
		assert(vmin >= 0 and vmin <= vmax)
		amount = Randoms(vmin, vmax, skill)
		assert(fmin >= 0 and fmin <= fmax)
		amount = amount + math.random(fmin, fmax)
		-- TODO: intellect & personality bonus
		return amount
	end

	function events.HealingSpellPower(t)
		t.Amount = calcHealingSpellPower(t.Spell, t.Caster, t.Skill, t.Mastery, t.Amount)
	end
end

-- OTHER CHANGES --

-- reduce buffs recovery if out of combat
if MS.Rev4ForMergeReduceBuffsRecoveryOutOfCombat == 1 then
	local cs = const.Spells
	local newRecoveryValues = {
		[cs.FireResistance] = 40,
		[cs.AirResistance] = 40,
		[cs.WaterResistance] = 40,
		[cs.EarthResistance] = 40,
		[cs.MindResistance] = 40,
		[cs.BodyResistance] = 40,
		[cs.FireAura] = 40,
		[cs.Haste] = 40,
		[cs.FireResistance] = 40,
		[cs.Immolation] = 40,
		[cs.FeatherFall] = 40,
		[cs.Shield] = 40,
		[cs.Invisibility] = 60,
		-- fly and water walk skipped intentionally
		[cs.EnchantItem] = 60,
		[cs.StoneSkin] = 40,
		[cs.Bless] = 40,
		[cs.Preservation] = 40,
		[cs.Heroism] = 40,
		[cs.Regeneration] = 40,
		[cs.Hammerhands] = 40,
		[cs.ProtectionFromMagic] = 40,
		[cs.DayOfTheGods] = 120,
		[cs.DayOfProtection] = 120,
		[cs.HourOfPower] = 120,
		[cs.PainReflection] = 40,
		[cs.Glamour] = 40,
		[cs.TravelersBoon] = 40,
		[cs.Levitate] = 40,
		[cs.Mistform] = 40,
		-- dragon flight skipped intentionally
	}

	function events.SpellCostRecovery(t)
		--local t = {Spell = d.ecx, SkillMastery = d.edx, Caster = d.eax, Cost = d.esi, Recovery = d.edi}
		if not Party.EnemyDetectorRed and not Party.EnemyDetectorYellow then
			t.Recovery = newRecoveryValues[t.Spell] or t.Recovery
		end
	end
	
	-- regeneration and some other spells apparently have hardcoded recovery delay which is applied after target is selected, but before spell is casted
	local patched = {}
	for _, addr in ipairs{0x430A8E, 0x430B49} do
		table.insert(patched, asmpatch(addr, [[
			nop
			nop
			nop
			nop
			nop
			push ecx
		]]))
	end

	local function recoveryHook(d)
		local val = 0x12C
		if not Party.EnemyDetectorRed and not Party.EnemyDetectorYellow then
			val = newRecoveryValues[u2[0x51D820]] or val
		end
		d.ecx = val
	end
	for _, addr in ipairs(patched) do
		hook(addr, recoveryHook)
	end
end

-- buff single-element resistance spells (5 fixed + 2/3/4/5 per skill point)
function events.GameInitialized2()
	-- changed resistance spell descriptions
	for i, v in ipairs({3, 14, 25, 36, 58, 69}) do
		local sp = Game.SpellsTxt[v]
		sp.Description = sp.Description:gsub("(your skill)", format("%d + %d * %%1", 5, 2))
		for i, idx in ipairs({"Normal", "Expert", "Master", "GM"}) do
			sp[idx] = sp[idx]:gsub("%d point", format("%d + %d point", 5, i + 1))
		end
	end
end

local resistanceSpells = {3, 14, 25, 36, 58, 69}

function events.PlayerSpellVar(t)
	if table.find(resistanceSpells, t.Spell) then
		if t.VarNum == 3 then
			t.Value = t.Value + 1 -- per level
		elseif t.VarNum == 4 then
			t.Value = 5 -- bonus
		end
	end
end

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