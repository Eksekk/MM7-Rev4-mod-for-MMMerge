local u1, u2, u4, i1, i2, i4 = mem.u1, mem.u2, mem.u4, mem.i1, mem.i2, mem.i4
local hook, autohook, autohook2, asmpatch = mem.hook, mem.autohook, mem.autohook2, mem.asmpatch
local max, min, floor, ceil, round, random = math.max, math.min, math.floor, math.ceil, math.round, math.random
local format = string.format
local MS = Merge.ModSettings

local function Randoms(min, max, count)
	local r = 0
	for i = 1, count do
		r = r + random(min, max)
	end
	return r
end

-- INTELLECT & PERSONALITY --

local function calcStatSpellPowerMul(pl)
	local stats = pl:GetIntellect() + pl:GetPersonality()
	return 0.01 * (stats / 10) -- every 10 points gives extra 1% effect
end

local function calcStatSpellEffectBonus(pl, effectValue)
	if MS.Rev4ForMergeIntellectPersonalityIncreaseSpellEffect == 1 then
		effectValue = effectValue + round(effectValue * calcStatSpellPowerMul(pl))
	end
	return effectValue
end

if MS.Rev4ForMergeIntellectPersonalityIncreaseSpellEffect == 1 then
	table.insert(tget(rev4m, "addTextFunctions"), function(pl)
		local percentage = calcStatSpellPowerMul(pl) * 100
		return string.format("Extra spell effect from personality\r\n and intellect: %.1f%%", percentage)
	end)
end

-- INCREASED DAMAGE --
if MS.Rev4ForMergeChangeSpellDamage == 1 then
	local spellsDamage =
	{
		[2] = -- Fire Bolt
		{
			DamageBase = 6,
			DamagePerSkill = "1-4"
		},
		[6] = -- Fireball
		{
			DamagePerSkill = "1-7"
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

	local function getSpellMasteryDamageData(spell, mastery)
		local entry = spellsDamage[spell]
		if not entry then return end
		local masteryIndependentDamage = true
		if not entry.DamagePerSkill then -- is split into mastery-dependent damage
			masteryIndependentDamage = false
			local entry2 = nil
			while m <= const.GM and not entry2 do
				entry2 = entry[m]
				m = m + 1
			end
			assert(entry2)
			entry = entry2
		end
		local base, smin, smax = (entry.DamageBase or 0), _G.getRange(entry.DamagePerSkill)
		smin, smax = smin or 0, smax or 0
		return base, smin, smax, masteryIndependentDamage
	end

	function events.CalcSpellDamage(t)
		local entry = spellsDamage[t.Spell]
		if entry then
			local s, m = SplitSkill(t.Skill)
			local base, smin, smax = getSpellMasteryDamageData(t.Spell, m)
			t.Result = base + Randoms(smin, smax, s)
		end

		-- stat damage bonus
		local data = WhoHitMonster()
		if data and data.Player then
			t.Result = calcStatSpellEffectBonus(data.Player, t.Result)
		end
	end

	local function spellMinimumMastery(spell)
		local level = (spell - 1) % 11
		for m, req in ipairs{1, 4, 7, 10} do
			if level <= req then
				return m
			end
		end
		assert(false, format("Couldn't find which mastery is minimum for spell %d", spell))
	end

	local function tryReplace(str, base, smin, smax)
		--[[
			1-x points of damage -> x + 1-x points of damage
			1-x -> y-z
			x + 1-x points -> y + 1-z points
			x + y points per skill -> z + y points per skill
		]]
		if base ~= 0 and (smin ~= 0 or smax ~= 0) then
			local fullM, baseM, minM, maxM = str:match("((%d+)[%w%+ ]-(%d+)%-?(%d-))[%D]")

		end
	end

	-- spell descriptions
	function events.GameInitialized2()
		for i, spell in Game.SpellsTxt do
			for m = const.Novice, const.GM do
				--tryReplace()
				--spellMinimumMastery()
			end
		end
	end
end

-- MODIFIED HEALING --
-- idea from MAW mod for MM6 --

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
		if type(targetPtr) == "number" then
			t.TargetRosterId, t.Target = internal.GetPlayer(targetPtr)
		else
			t.TargetRosterId, t.Target = targetPtr:GetIndex(), targetPtr
		end
	else
		local pl = Party[i2[spellQueuePtr + 4]]
		t.TargetRosterId, t.Target = pl:GetIndex(), pl
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
		if type(def) == "function" then -- autohook passes code address (number) as second argument
			def(type(targetPtr) == "table" and targetPtr["?ptr"] or targetPtr, t.Amount)
		else
			t.Target:AddHP(t.Amount)
		end
	end
end

mem.hookcall(0x42AF62, 1, 1, callHealingEvent)
mem.hookcall(0x42B494, 1, 1, callHealingEvent)

local castSuccessfulAddr = 0x42C200

-- don't skip cure insanity code and don't add weakness if char is not insane
-- also remaining resurrection and raise dead and maybe others
do
	local addWeakness = mem.StaticAlloc(1)
	local hooks = HookManager{addWeakness = addWeakness, castSuccessful = castSuccessfulAddr, cureInsanity = const.Spells.CureInsanity}
	
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
		cmp word [ebx + 2], %cureInsanity%
		jne @notCureInsanity
		test byte [%addWeakness%], 1
		jz absolute %castSuccessful%
		@notCureInsanity:
	]])
end

-- SHARED LIFE OVERFLOW FIX --
-- TODO: replace original code with new function, also call healing event and modify total pool

local function getPartyIndex(player)
	for i, pl in Party do
		if pl == player then
			return i
		end
	end
end

if MS.Rev4ForMergeFixSharedLifeOverflow == 1 then
	function randomizeHP()
		for i, pl in Party do
			pl.HP = random(1, pl:GetFullHP())
		end
	end

	-- TODO: test very negative amounts (like -50000), they asserted previously
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
				part = amount:div(#activePlayers)
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
		return affectedPlayers
		--debug.Message(format("%d HP left", amount))
	end

	-- replace shared life code with my own
	hook(0x42A171, function(d)
		local amount = u4[d.ebp - 4]
		local t = getSpellQueueData(d.ebx)
		t.Amount = amount
		events.call("HealingSpellPower", t)
		local affectedPlayers = doSharedLife(t.Amount)
		for i, pl in ipairs(affectedPlayers) do
			mem.call(0x4A6FCE, 1, mem.call(0x42D747, 1, u4[0x75CE00]), const.Spells.SharedLife, getPartyIndex(pl)) -- show animation
		end
	end)
	asmpatch(0x42A176, "jmp absolute " .. castSuccessfulAddr)
else
	autohook(0x42A158, function(d)
		local t = getSpellQueueData(d.ebx)
		t.Amount = d.edi
		events.call("HealingSpellPower", t)
		d.edi = t.Amount
	end)
end

if MS.Rev4ForMergeChangeSpellHealing == 1 then
	local healingSpellPowers =
	{
		[const.Spells.CureInsanity] =
		{
			[const.Master] =
			{
				FixedMin = 10, FixedMax = 30, VariableMin = 2, VariableMax = 4,
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
				FixedMin = 25, FixedMax = 45, VariableMin = 1, VariableMax = 2,
			},
			[const.GM] = 
			{
				FixedMin = 25, FixedMax = 45, VariableMin = 2, VariableMax = 3,
			},
		},
		[const.Spells.CurePoison] =
		{
			[const.Expert] = 
			{
				FixedMin = 5, FixedMax = 8, VariableMin = 1, VariableMax = 1,
			},
			[const.Master] = 
			{
				FixedMin = 7, FixedMax = 10, VariableMin = 1, VariableMax = 2,
			},
			[const.GM] = 
			{
				FixedMin = 8, FixedMax = 13, VariableMin = 2, VariableMax = 3,
			},
		},
		[const.Spells.CureParalysis] =
		{
			[const.Expert] = 
			{
				FixedMin = 5, FixedMax = 5, VariableMin = 1, VariableMax = 1,
			},
			[const.Master] = 
			{
				FixedMin = 5, FixedMax = 10, VariableMin = 1, VariableMax = 2,
			},
			[const.GM] = 
			{
				FixedMin = 10, FixedMax = 15, VariableMin = 2, VariableMax = 3,
			},
		}
	}

	-- stuff to make event work for GM status cures
	-- cure paralysis
	mem.nop(0x42A4C2) -- always call the code
	autohook(0x42A4CE, callHealingEvent) -- call healing event for GM

	-- cure poison
	asmpatch(0x42AFC8, "mov edi, 0xB20E90\njmp short " .. 0x42B00D - 0x42AFC8) -- always call the code
	autohook(0x42B013, callHealingEvent)

	-- cure disease
	asmpatch(0x42B342, "mov edi, 0xB20E90\njmp short " .. 0x42B387 - 0x42B342)
	autohook(0x42B38D, callHealingEvent)

	local function getSpellMasteryHealingData(spell, mastery)
		local entry = healingSpellPowers[spell]
		if not entry then return end
		entry = entry[mastery]
		if not entry then return end
		local vmin, vmax, fmin, fmax = (entry.VariableMin or 0), (entry.VariableMax or 0), (entry.FixedMin or 0), (entry.FixedMax or 0)
		return vmin, vmax, fmin, fmax
	end

	-- returns [string or nil if both params are 0], [whether single or none parameter was used]
	local function getRangeStr(min, max)
		if min ~= 0 and max ~= 0 and min ~= max then
			return format("%d-%d", min, max)
		elseif min ~= 0 or max ~= 0 then
			return tostring(min ~= 0 and min or max), true
		end
	end

	function events.GameInitialized2()
		local txt = Game.SpellsTxt
		for spellId in Game.SpellsTxt do
			local spellTxt = txt[spellId]
			local addedAny
			for mastery = const.Novice, const.GM do
				local vmin, vmax, fmin, fmax = getSpellMasteryHealingData(spellId, mastery)
				if vmin then
					local variableStr, variableSingle = getRangeStr(vmin, vmax)
					local fixedStr, fixedSingle = getRangeStr(fmin, fmax)

					local finalStr = ""
					if fixedStr and variableStr then
						finalStr = format(". Heals %s points + %s per skill", fixedStr, variableStr)
					elseif fixedStr then
						finalStr = format(". Heals %s points", fixedStr)
					elseif variableStr then
						finalStr = format(". Heals %s points per skill", variableStr)
					end
					if finalStr then
						local key = select(mastery, "Normal", "Expert", "Master", "GM")
						spellTxt[key] = spellTxt[key] .. finalStr
						addedAny = true
					end
				end
			end
			if addedAny then
				spellTxt.Description = spellTxt.Description .. " The spell also heals some hit points."
			end
		end
	end

	local function calcHealingSpellPower(spell, caster, skill, mastery, amount)
		local vmin, vmax, fmin, fmax = getSpellMasteryHealingData(spell, mastery)
		if not vmin then
			amount = calcStatSpellEffectBonus(caster, amount)
			return amount
		end
		assert(vmin >= 0 and vmin <= vmax)
		amount = Randoms(vmin, vmax, skill)
		assert(fmin >= 0 and fmin <= fmax)
		amount = amount + random(fmin or 0, fmax or 0) -- or 0 to satisfy my vscode lua extension
		amount = calcStatSpellEffectBonus(caster, amount)
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
		--[[ hardcoded values, because const.Spells is wrong here in current mmext
		[cs.Glamour] = 40,
		[cs.TravelersBoon] = 40,
		[cs.Levitate] = 40,
		[cs.Mistform] = 40,
		]]
		[100] = 40, -- order same as above
		[101] = 40,
		[112] = 40,
		[114] = 40,
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

	-- cure weakness and remove fear affect whole party on GM --

	mem.nop(0x42AE5B) -- disable skipping if target is not weak
	mem.nop(0x42A57E) -- like above, but afraid

	-- remove fear and cure weakness: skip select on GM
	-- TODO: if max time to cure is 0 from SpellsExtra.txt, spell will be treated as GM by code, but target selection will still be required
	HookManager{skillBeforeFirstMagic = const.Skills.Plate, removeFear = const.Spells.RemoveFear, cureWeakness = const.Spells.CureWeakness,
		getSkillMastery0 = Merge.Offsets.GetSkillMastery0, getSkill = 0x48EF4F}.asmhook(0x425C5F, [[
		push ebx
		mov ebx, eax ; player ptr

		; get school of currently casted spell
		movzx eax, word [ebp - 0x14] ; id
		xor edx, edx
		cmp eax, %removeFear%
		sete cl
		or dl, cl
		cmp eax, %cureWeakness%
		sete cl
		or dl, cl
		je @end ; not spell which affects whole party on GM

		; just found out there's Merge.Offsets.GetSpellSkillId as well, but I'm gonna write my own version for fun
		mov ecx, 11
		cdq
		idiv ecx
		test edx, edx ; math.ceil - if remainder > 0 then increment
		jz @noIncrement
		inc eax
		@noIncrement:
		add eax, %skillBeforeFirstMagic%

		; test mastery
		mov ecx, ebx
		push eax
		call absolute %getSkill%
		mov ecx, eax
		call absolute %getSkillMastery0%
		cmp eax, 4
		jb @end

		; disable select target flag
		xor dword [ebp + 0xC], 2

		@end:
		pop ebx
	]])

	local function callHealingEventWrapper(d)
		callHealingEvent(d, nil, Party[d.edi])
	end

	-- replace gm code with one that acts on all players
	local spellHookManager = HookManager{rosterIds = 0xB7CA4C, partySize = 0xB7CA60, getPlayerPtr = 0x4026F4, removeCond = 0x48FA06,
	spell = 0x51D820, caster = 0x51D822, target = 0x51D824, getSkillMastery = 0x455B09, cureWeakness = 0x43, party = 0xB20E90, showAnimation = 0x4A6FCE}

	-- show animation
	local animationPatch = [[
		push edi
		xor edi, edi
		%gmCheck%
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
		%gmCheck%
		jne @exit ; not GM
		inc edi
		cmp edi, dword [%partySize%]
		jb @call

		@exit:
		pop edi
	]]

	-- cure
	local curePatch = [[
		push edi
		push esi
		xor esi, esi

		@cure:
		push esi
		mov ecx, %party%
		call absolute %getPlayerPtr%
		xor ecx, ecx
		mov dword ptr [eax+%condOffset%], ecx
		mov dword ptr [eax+%condOffset% + 4], ecx
		
		; place for hook to call healing event
		mov edi, esi
		nop
		nop
		nop
		nop
		nop

		inc esi
		cmp esi, dword[%partySize%]
		jb @cure

		pop esi
		pop edi
	]]

	local NOP = string.char(0x90)

	-- animation
	spellHookManager.ref.gmCheck = "cmp dword [ebp - 4], esi"
	spellHookManager.asmpatch(0x42AE25, animationPatch, 0x1F)

	-- cure
	spellHookManager.ref.condOffset = 8
	local addr = spellHookManager.asmpatch(0x42AE67, curePatch, 0x12)
	hook(mem.findcode(addr, NOP), callHealingEventWrapper)

	-- same for remove fear
	spellHookManager.ref.gmCheck = "test dword [ebp - 4], 0xFFFFFFFF"
	spellHookManager.asmpatch(0x42A54A, animationPatch, 0x1F)
	spellHookManager.ref.condOffset = 0x18
	addr = spellHookManager.asmpatch(0x42A58A, curePatch, 0x15)
	hook(mem.findcode(addr, NOP), callHealingEventWrapper)

	function events.GameInitialized2()
		Game.SpellsTxt[const.Spells.CureWeakness].GM = Game.SpellsTxt[const.Spells.CureWeakness].GM .. ". Affects whole party with single cast"
		Game.SpellsTxt[const.Spells.RemoveFear].GM = Game.SpellsTxt[const.Spells.RemoveFear].GM .. ". Affects whole party with single cast"

		local count
		local spellEntry = Game.SpellsTxt[const.Spells.StoneSkin]
		spellEntry.Description, count = spellEntry.Description:gsub("5 %+ 1 point", "5 %+ 2 points")
		assert(count == 1, "Couldn't change stone skin spell description")

		spellEntry = Game.SpellsTxt[const.Spells.Paralyze]
		spellEntry.Description, count = spellEntry.Description:gsub("3 minutes", "1 minute")
		assert(count == 1, "Couldn't change paralyze spell description")
	end
end