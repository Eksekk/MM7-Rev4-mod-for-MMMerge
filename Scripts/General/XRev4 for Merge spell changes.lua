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
	local r = def(targetPtr, cond, timeLow, timeHigh)
	events.call("AfterRemoveConditionBySpell", t)
	return r
end)

function events.AfterRemoveConditionBySpell(t) -- after to allow to add hp when curing eradication/dead (before wouldn't work)
	local t1 = table.copy(t)
	t1.Amount = 0
	events.call("HealingSpellPower", t1)
	if t1.Amount > 0 then
		t1.Target:AddHP(t1.Amount)
	end
end

local NOP = string.char(0x90)

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

local spellHookManager = HookManager{rosterIds = 0xB7CA4C, partySize = 0xB7CA60, getPlayerPtr = 0x4026F4, removeCond = 0x48FA06,
	spell = 0x51D820, caster = 0x51D822, target = 0x51D824, getSkillMastery = 0x455B09, party = 0xB20E90, showAnimation = 0x4A6FCE,
	castSuccessful = castSuccessfulAddr, cureInsanity = const.Spells.CureInsanity, gameTime = 0xB20EBC, erradOffset = 0x80, deadOffset = 0x70,
	currentHpOffset = 0x1BF8, ctrlPressed = 0x51930C, skillBeforeFirstMagic = const.Skills.Plate, removeFear = const.Spells.RemoveFear,
	cureWeakness = const.Spells.CureWeakness, getSkillMastery0 = Merge.Offsets.GetSkillMastery0, getSkill = 0x48EF4F, regeneration = const.Spells.Regeneration,
	checkAndSubtractMana = 0x425B1A, setBuff = 0x455D97}

-- SHARED LIFE OVERFLOW FIX --

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
	-- TEST SCROLLS?
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
		},
		[const.Spells.Resurrection] =
		{
			[const.GM] = 
			{
				FixedMin = 50, FixedMax = 50, VariableMin = 10, VariableMax = 15,
			},
		}
	}

	-- stuff to make event work for status cures

	local addWeakness = mem.StaticAlloc(2)
	local resurrectionRemoveUncon = addWeakness + 1
	spellHookManager.ref.addWeakness = addWeakness
	spellHookManager.ref.resurrectionRemoveUncon = resurrectionRemoveUncon

	-- CURE INSANITY
	
	-- don't skip the code
	spellHookManager.asmpatch(0x42ABC1, [[
		setne cl
		mov byte [%addWeakness%], cl
	]])

	-- don't show animation if not needed
	spellHookManager.asmpatch(0x42ABD9, [[
		test byte [%addWeakness%], 1
		jz absolute 0x42ABF1
		movsx eax,word ptr [ebx+4]
	]], 6)

	-- call healing event if mastery is GM
	autohook(0x42ABF7, callHealingEvent)

	-- don't add weakness if mastery is GM
	spellHookManager.asmhook2(0x42AC03, [[
		test byte [%addWeakness%], 1
		jz absolute %castSuccessful%
	]])

	-- don't add weakness if mastery is below GM (also check for right spell, because iirc resurrection also causes weakness and might also use this code)
	spellHookManager.asmhook(0x42A128, [[
		cmp word [ebx + 2], %cureInsanity%
		jne @notCureInsanity
		test byte [%addWeakness%], 1
		jz absolute %castSuccessful%
		@notCureInsanity:
	]])

	-- RESURRECTION
	-- if player is eradicated, add weakness, otherwise don't
	-- if eradication will be cured, before healing event make hp at least 1 (for GM and less than GM)

	-- if character is eradicated or dead, normal spell cost
	spellHookManager.asmhook2(0x42A2C4, [[
		push ecx
		movsx eax,word ptr [ebx+4]
		mov edi, %party%
		push eax
		mov ecx, edi
		call absolute %getPlayerPtr%
		mov edx, dword [eax + %erradOffset%]
		or edx, dword [eax + %erradOffset% + 4]
		or edx, dword [eax + %deadOffset%]
		or edx, dword [eax + %deadOffset% + 4]
		pop ecx
		je @normal
		mov dword [esp], 30
		@normal:
	]])

	-- show variable spell cost
	autohook(0x41218B, function(d)
		-- [ebp + 8] - spell index
		local spellId = u4[d.ebp + 8] + Party[Game.CurrentPlayer].SpellBookPage * 11 + 1
		if spellId == const.Spells.Resurrection then
			local str = mem.string(d.esi)
			local add = " or 30\0"
			mem.copy(d.esi + str:len(), add)
		end
	end)

	-- don't skip code, but skip weakness animation
	spellHookManager.asmpatch(0x42A2F4, [[
		setne cl
		mov byte [%addWeakness%], cl
		mov edi, %party%
		jmp absolute 0x42A338
	]], 20)

	-- call healing event for GM
	local addr = spellHookManager.asmhook2(0x42A374, [[
		; minimum HP is 1 (all conditions are cured unconditionally on GM)
		mov ecx, dword [eax+%currentHpOffset%]
		xor edx, edx
		cmp ecx, edx
		jg @skip
		xor ecx, ecx
		inc ecx
		@skip:
		mov dword [eax+%currentHpOffset%], ecx
		nop
		nop
		nop
		nop
		nop
	]])
	hook(mem.findcode(addr, NOP), callHealingEvent)

	-- make sure HP is at least 1 if errad is cured, and set flag deciding if unconsciousness should be removed
	spellHookManager.asmhook(0x42A3B4, [[
		; eax = player ptr
		; check if condition will be removed (will be if game time - time limit <= condition affect time)
		mov ecx, dword [%gameTime%]
		mov edx, dword [%gameTime% + 4]
		sub ecx, dword [esp + 0x4] ; time low
		sbb edx, dword [esp + 0x8] ; time high
		cmp edx, dword [eax + %erradOffset% + 4]
		jl @minHp
		jg @noMinHp
		cmp ecx, dword [eax + %erradOffset%]
		ja @noMinHp

		@minHp:
		mov byte [%resurrectionRemoveUncon%], 1
		mov ecx, dword [eax+%currentHpOffset%]
		xor edx, edx
		cmp ecx, edx
		jg @skip
		xor ecx, ecx
		inc ecx
		@skip:
		mov dword [eax+%currentHpOffset%], ecx
		jmp @exit
		@noMinHp:
		mov byte [%resurrectionRemoveUncon%], 0
		@exit:
		mov ecx, eax
	]])

	-- unconditionally remove death, even below GM
	spellHookManager.asmpatch(0x42A3C7, [[
		movsx eax,word ptr [ebx+4]
		push eax
		mov ecx, edi
		call absolute %getPlayerPtr% ; get player ptr

		and dword [eax + %deadOffset%], 0
		and dword [eax + %deadOffset% + 4], 0

	]], 0x17)

	-- don't unconditionally remove unconsciousness if errad is not removed
	spellHookManager.asmhook(0x42A3EC, [[
		test byte [%resurrectionRemoveUncon%], 1
		jz absolute 0x42A403
	]])

	-- don't add weakness -- if not needed
	spellHookManager.asmhook(0x42A40A, [[
		test byte [%addWeakness%], 1
		jmp absolute 0x42A42D ; jz absolute 0x42A42D - changed to eliminate weakness
	]])

	-- don't set HP to 1 (I take care of this myself)
	spellHookManager.asmpatch(0x42A41B, "jmp short " .. 0x42A42D - 0x42A41B)

	-- REMAINING: animation and maybe don't ever add weakness?

	spellHookManager.ref.addWeakness = nil
	spellHookManager.ref.resurrectionRemoveUncon = nil

	function events.GameInitialized2()
		local spell = Game.Spells[const.Spells.Resurrection]
		for m = const.Novice, const.GM do
			spell.Delay[m], spell.SpellPoints[m] = 150, 80 -- smaller recovery but higher cost
		end
	end

	-- CURE PARALYSIS
	mem.nop(0x42A4C2) -- always call the code
	autohook(0x42A4CE, callHealingEvent) -- call healing event for GM

	-- CURE POISON
	spellHookManager.asmpatch(0x42AFC8, "mov edi, %party%\njmp short " .. 0x42B00D - 0x42AFC8) -- always call the code
	autohook(0x42B013, callHealingEvent)

	-- CURE DISEASE
	spellHookManager.asmpatch(0x42B342, "mov edi, %party%\njmp short " .. 0x42B387 - 0x42B342)
	autohook(0x42B38D, callHealingEvent)

	-- SPELL DESCRIPTIONS

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
			if spellId == const.Spells.Resurrection then
				spellTxt.Description = "Resurrects a character whose body has been destroyed. Also heals him for 50 + 10-15 per point of skill in Spirit Magic. If character is in good condition, you'll need greater amount of magic energy to perform the heal."
			else
				local addedAny
				for mastery = const.Novice, const.GM do
					local vmin, vmax, fmin, fmax = getSpellMasteryHealingData(spellId, mastery)
					if vmin then
						local variableStr, variableSingle = getRangeStr(vmin, vmax)
						local fixedStr, fixedSingle = getRangeStr(fmin, fmax)

						local finalStr = ""
						local masteryName = select(mastery, "Normal", "Expert", "Master", "GM")
						local hasSentenceEndMark = spellTxt[masteryName]:sub(-1):match("[%.%?%!]") and true
						if fixedStr and variableStr then
							finalStr = format(" Heals %s points + %s per skill", fixedStr, variableStr)
						elseif fixedStr then
							finalStr = format(" Heals %s points", fixedStr)
						elseif variableStr then
							finalStr = format(" Heals %s points per skill", variableStr)
						end
						if finalStr then
							if not hasSentenceEndMark then
								finalStr = "." .. finalStr
							end
							spellTxt[masteryName] = spellTxt[masteryName] .. finalStr
							addedAny = true
						end
					end
				end
				if addedAny then
					spellTxt.Description = spellTxt.Description .. " The spell also heals some hit points."
				end
			end
		end
	end
	
	-- actual event handler

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

	-- NEED TO BE before regeneration ctrl-press mass casting handler to work correctly
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

	-- remove fear and cure weakness: skip select on GM, regeneration: skip select when ctrl-casting
	-- TODO: if max time to cure is 0 from SpellsExtra.txt, spell will be treated as GM by code, but target selection will still be required
	spellHookManager.asmhook(0x425C5F, [[
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
		cmp eax, %regeneration%
		jne @F
		or dl, byte [%ctrlPressed%]
		@@:
		test dl, dl
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

	-- show animation
	local animationPatch = [[
		push edi
		xor edi, edi
		%isMultiTargetCheck%
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
		%isMultiTargetCheck%
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

	-- animation
	spellHookManager.ref.isMultiTargetCheck = "cmp dword [ebp - 4], esi"
	spellHookManager.asmpatch(0x42AE25, animationPatch, 0x1F)

	-- cure
	spellHookManager.ref.condOffset = 8
	local addr = spellHookManager.asmpatch(0x42AE67, curePatch, 0x12)
	hook(mem.findcode(addr, NOP), callHealingEventWrapper)

	-- same for remove fear
	spellHookManager.ref.isMultiTargetCheck = "test dword [ebp - 4], 0xFFFFFFFF"
	spellHookManager.asmpatch(0x42A54A, animationPatch, 0x1F)
	spellHookManager.ref.condOffset = 0x18
	addr = spellHookManager.asmpatch(0x42A58A, curePatch, 0x15)
	hook(mem.findcode(addr, NOP), callHealingEventWrapper)

	-- REGENERATION
	-- affects whole party with ctrl pressed

	spellHookManager.ref.isMultiTargetCheck = [[
		test dword [0x51930C], 1 ; ctrl pressed, can't have recursive ref expansion in hook manager
		pushfd
		xor dword [esp], 0x40 ; toggle zero flag
		test byte [ebx + 8], 1 ; casted from scroll
		jz @F
			and dword [esp], 0xFFFFFFBF ; turn off zero flag
		@@:
		popfd
	]]

	-- recovery
	-- need to be after reduced spell cost recovery handler
	function events.SpellCostRecovery(t)
		if t.Spell == const.Spells.Regeneration and Game.CtrlPressed then
			t.Recovery = t.Recovery * Party.Count
		end
	end

	spellHookManager.ref.showStatusText = 0x4496C5
	spellHookManager.ref.notEnoughManaText = 0x601D70

	-- mana cost
	spellHookManager.asmhook2(0x4273C5, [[
		%isMultiTargetCheck%
		jne @F
			; multiply mana
			mov eax, [esp]
			imul eax, dword [%partySize%]
			mov [esp], eax
		@@:
		; jump to mana check
	]])

	-- show status text if not enough mana
	spellHookManager.asmpatch(0x4273D2, [[
		jne @F
		mov ecx, dword [%notEnoughManaText%]
		mov edx, 2
		call absolute %showStatusText%
		jmp absolute 0x42D3AB ; spell cast failed?
		@@:
		; check successful
	]])

	local buffPatch = [[
		push esi
		xor esi, esi
		%isMultiTargetCheck%
		je @buff
		mov si, word [ebx + 4]

		@buff:
		push esi
		mov ecx, %party%
		call absolute %getPlayerPtr%
		mov ecx, eax
		add ecx, %buffOffset%
		; push all arguments again
		; same offset in all of them since push subtracts 4 from esp, so you still get arguments in order
		push dword [esp + 0x18] ; caster
		push dword [esp + 0x18] ; overlay
		push dword [esp + 0x18] ; power
		push dword [esp + 0x18] ; skill
		push dword [esp + 0x18] ; time high
		push dword [esp + 0x18] ; time low
		call absolute %setBuff%

		%isMultiTargetCheck%
		jne @exit
		inc esi
		cmp esi, dword[%partySize%]
		jb @buff

		@exit:
		pop esi
		add esp, 6*4 ; pop original arguments from the stack
		jmp absolute %castSuccessful%
	]]
	
	-- animation
	spellHookManager.asmpatch(0x4273D8, animationPatch, 0x1F)

	-- buff
	spellHookManager.ref.buffOffset = 0x1AF4
	spellHookManager.asmpatch(0x42742B, buffPatch)

	-- REMAINING TODO: description and add info to readme + add info about healing changes

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