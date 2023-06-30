local u1, u2, u4, i1, i2, i4, autohook, autohook2 = mem.u1, mem.u2, mem.u4, mem.i1, mem.i2, mem.i4, mem.autohook, mem.autohook2
local max, min, round = math.max, math.min, math.round
local format = string.format
local MS = Merge.ModSettings

-- Temple in a bottle
evt.UseItemEffects[1452] = function(Target, Item, PlayerId)
	ExitCurrentScreen(false, true)
	evt.MoveToMap{0,0,0,0,0,0,0,0,"7nwcorig.blv"}
	return 0
end

--[[ TODO
IMPORTANCE CATEGORIES:
---- very important ----
* if bolster is disabled, extra experience and gold won't be applied - probably will work, need to test
* bolster in general, two todos are there
* spawn something near tularean caverns
* turn undead is OP - maybe make 3/6/9/12 max targets per mastery? (skipping those that are affected, unless there are no other enemies in range)
* if drain sp nerf is enabled, slightly buff monsters with it like with stealing removal

playthrough notes:
* map NPCs have wrong topic names (like "Credits" instead of "Emerald Island"), possible culprit - General/NPCNewsTopics.lua
* rocs in tularean (obelisk) are not hostile - AFTER RELOAD, map script? or mm8 reload bug where attacking friendly monsters turns them friendly again after reload
* mortie ottin has "courier delivery" topic even when courier quests aren't started
* couldn't complete pipes quest on first visit to faerie king, walking into his radius second time worked
* hostile map npcs and crossbowmen in tatalia without doing anything
* castle harmondale door at the top to upper level is opened - missing doors?, also shadow bugs
* courier quests further bugged - some people you need to talk to behave as if you already visited objective giver. Perhaps lack of evt.Cmp("Inventory", ...)?
* barrow IV was very hard - teleport to deepest part of dungeon, reluctance to use turn undead (which is OP), bolstered bats of doom, boosted mapstats spawns
* other barrows as well, mainly those with literally hundreds of mobs in a small space due to mapstats boosts and of course bats
* barrow VIII has wrong textures
* too good items in chests in barrow II?
* barrow levers wrong textures?
* harmondale carnage bow was not removed - ??? works fine in new game
* travelling to harmondale from EI (second time) breaks interface

-- those below are not needed for "first release" --

* HIRE MYSTIC - +3 to all spell skills

---- important ----
* GM cure weakness should work on whole party
* optional extra requirements for learning masteries (like disarm trap requiring 40 accuracy)
* bolster is surprising, mainly for bosses - they get boosted based on their id, not stats
* avlee spawn two bosses: one on wyvern cliff, second on island where GM alchemy trainer is
* titans in bracada desert surrounded by dynamically spawned bones (sprites), as in mm7 reimagined?
* boost perception
* deal with literally all my changes except difficulty making game easier - on medium/hard it should still be harder, but easy will be walk in the park
* Bosses
* Boost weapon boosting potions
* Boost some of statistics' effects (if boosted breakpoints active, then less)
* spell damage opt-out
* redo rev4 promotion quests to use Quest{} and be able to freely promote after quest completion like in default Merge quests
* as above, but for free skill barrels and NPC free skills (dark master/fire expert)
* technical: move merge scripts into their own file (make sure that they load after normal script) and directly patch them instead of replacing text

---- good to have ----
* disable wands generating without any charges
* bdj doesn't turn hostile, also deal with angel in harmondale
* EASIER OPTION DONE: reduce buffs recovery if out of combat (better but harder option: allow ctrl-casting to affect whole party)
* Add diffsels for all extra monster spawns and then make option to always spawn monsters, even in easy mode (disabled by default)
* Extra spawns in dungeons
* Changed main questline?
* Restore trumpet quest
* Castle Navan quest (and make treasury door open after getting/completing light knight promo)
* School of Sorcery and Breeding Pit quests
* school of sorcery and castle navan quests connected?
* Create script for moving editor state from MM7 to Merge (using updated events, monsters, items etc.), then
	dry run it and see if I included all changes (almost everything was done manually)
* Make elemental/cleric totems affect dark/light resistances (possibly only cleric as it has only 2 res?)
* talismans like in diablo? (those that provide effect when they're kept in inventory)

---- minor ----
* Grayface patch introduces different transition text for nighon tunnels -> thunderfist mountain, include it?
* praying at tatalia altar displays message "home portal"
* fix event 502 in d08.lua (doesn't cast torch light)
* Extra data attribute text & button are in front of tooltips (for example rightclick over a character's ring) - tried to fix, didn't work, all layers tested and either
	button is in front or doesn't show at all
* Boost loot in the Gauntlet?
* Fort Riverstride delete plans item
* Day of Protection giving a bit of dark/light resistance
* make fire aura always work with permanent enchantments (elemental mod)
* Character creation screen enhancements
* Additional topics in service houses + USE THEM
* Check if all fruit trees work (I recall BDJ said the had to cut some of them out due to event limit)


IF I WANNA REALLY CHALLENGE MYSELF:
###. New spells (additional weapon enhancements).
     freeze, feeblemind, turn to stone
]]

monUtils = {}
function monUtils.hpMul(mon, mul)
	mon.FullHP = round(mon.FullHP * mul)
	mon.HP = mon.FullHP
end

function monUtils.hp(mon, hp)
	mon.FullHP, mon.HP = hp, hp
end

local function rItem(mon, item, chance, typ)
	if item then
		if item >= 0 then
			evt.SetMonsterItem{Monster = mon:GetIndex(), Item = item, Has = true}
		else
			mon.TreasureItemLevel, mon.TreasureItemPercent, mon.TreasureItemType = -item, chance or 100, typ or const.ItemType.Any
		end
	end
end

function monUtils.rewards(mon, expMul, item, moneyMul)
	mon.Experience = round(mon.Experience * expMul)
	if type(item) == "table" then
		rItem(mon, unpack(item))
	else
		rItem(mon, item)
	end
	mon.TreasureDiceCount = round(mon.TreasureDiceCount * moneyMul)
end

function monUtils.spells(mon, sp1, sk1, ch1, sp2, sk2, ch2)
	if sp1 then
		mon.Spell, mon.SpellSkill, mon.SpellChance = sp1, sk1, ch1
	end
	if sp2 then
		mon.Spell2, mon.Spell2Skill, mon.Spell2Chance = sp2, sk2, ch2
	end
end

do
	local cd = const.Damage
	function monUtils.boostResistances(mon, amount)
		for i, v in ipairs({cd.Fire, cd.Air, cd.Water, cd.Earth, cd.Spirit, cd.Mind,
			cd.Body, cd.Light, cd.Dark, cd.Phys}) do
			mon.Resistances[v] = min(const.MonsterImmune, mon.Resistances[v] + (type(amount) == "table" and amount[i] or amount))
		end
	end
	monUtils.resists = monUtils.boostResistances
end

do
	local spells =
	{
		{Spell = 2, Skill = 12, Mastery = const.GM, Chance = 50}, -- Fire Bolt
		{Spell = 11, Skill = 4, Mastery = const.GM, Chance = 30}, -- Incinerate
		{Spell = 15, Skill = 12, Mastery = const.Master, Chance = 40}, -- Sparks
		{Spell = 18, Skill = 7, Mastery = const.GM, Chance = 40}, -- Lightning Bolt
		{Spell = 24, Skill = 12, Mastery = const.Master, Chance = 50}, -- Poison Spray
		{Spell = const.Spells.IceBolt, Skill = 8, Mastery = const.GM, Chance = 50},
		{Spell = 32, Skill = 8, Mastery = const.Master, Chance = 20}, -- Ice Blast
		{Spell = 37, Skill = 10, Mastery = const.GM, Chance = 50}, -- Deadly Swarm
		{Spell = 39, Skill = 10, Mastery = const.GM, Chance = 40}, -- Blades
		{Spell = 59, Skill = 7, Mastery = const.GM, Chance = 50}, -- Mind Blast
		{Spell = 65, Skill = 7, Mastery = const.GM, Chance = 30}, -- Psychic Shock
		{Spell = 76, Skill = 4, Mastery = const.GM, Chance = 30}, -- Flying Fist
		{Spell = const.Spells.ToxicCloud, Skill = 6, Mastery = const.GM, Chance = 30},
	}

	function monUtils.randomGiveSpell(mon, useSpells)
		useSpells = useSpells or spells
		local roll = math.random(0, 2)
		if roll == 0 or (mon.Spell ~= 0 and mon.Spell2 ~= 0) then
			return
		end
		local i = math.random(1, #useSpells)
		local firstSpell = useSpells[i]
		local addedFirst = false
		if mon.Spell == 0 then
			mon.Spell, mon.SpellChance, mon.SpellSkill = firstSpell.Spell, firstSpell.Chance or 30, JoinSkill(firstSpell.Skill, firstSpell.Mastery)
			addedFirst = true
		end
		if (roll <= 1 and addedFirst) or mon.Spell2 ~= 0 then
			return
		end
		if not addedFirst then
			local j
			repeat
				j = math.random(1, #useSpells)
			until mon.Spell ~= useSpells[j].Spell
			mon.Spell2, mon.Spell2Chance, mon.Spell2Skill = firstSpell.Spell, firstSpell.Chance or 30, JoinSkill(firstSpell.Skill, firstSpell.Mastery)
			return
		end
		local j
		repeat
			j = math.random(1, #useSpells)
		until firstSpell.Spell ~= useSpells[j].Spell
		local secondSpell = useSpells[j]
		mon.Spell2, mon.Spell2Chance, mon.Spell2Skill = secondSpell.Spell, secondSpell.Chance or 30, JoinSkill(secondSpell.Skill, secondSpell.Mastery)
	end
end

local function randomGiveElementalAttack(mon)
	local a1, a2 = mon.Attack1, mon.Attack2
	if a1.DamageDiceCount ~= 0 then
		if a2.DamageDiceCount ~= 0 then
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
	a1.Type = math.random(0, 7)
	if a1.Type > 3 then
		a1.Type = math.random(9, 10)
	end
	a1.DamageDiceCount, a1.DamageDiceSides, a1.DamageAdd, a1.Missile = math.random(3, diffsel(3, 4, 5)), math.random(3, diffsel(3, 4, 5)), math.random(2, diffsel(5, 7, 10)) * 3, a1.Type + 3
end
monUtils.randomGiveElementalAttack = randomGiveElementalAttack

local function randomBoostResists(mon)
	boostResistances(mon, math.random(1, diffsel(3, 5, 7)) * 5)
end
monUtils.randomBoostResists = randomBoostResists

local function getDamageFromString(str)
	str = str:gsub(" ", "")
	local countStr, sidesStr = str:match("(%d+)[dD](%d+)")
	assert(countStr, "Couldn't find dice count")
	assert(sidesStr, "Couldn't find dice sides")
	local add
	local plusPos = str:find("%+")
	if plusPos then
		add = tonumber(str:match("(%d+)", plusPos + 1))
	end
	return tonumber(countStr), tonumber(sidesStr), add
end

function monUtils.damage(mon, s1, s2)
	if s1 then
		local count, sides, add = getDamageFromString(s1)
		mon.Attack1.DamageDiceCount, mon.Attack1.DamageDiceSides, mon.Attack1.DamageAdd = count, sides, add or 0
	end
	if s2 then
		local count, sides, add = getDamageFromString(s1)
		mon.Attack2.DamageDiceCount, mon.Attack2.DamageDiceSides, mon.Attack2.DamageAdd = count, sides, add or 0
	end
end

function monUtils.addDamage(mon, count1, sides1, add1, count2, sides2, add2)
	mon.Attack1.DamageDiceCount, mon.Attack1.DamageDiceSides, mon.Attack1.DamageAdd
		= mon.Attack1.DamageDiceCount + (count1 or 0), mon.Attack1.DamageDiceSides + (sides1 or 0), mon.Attack1.DamageAdd + (add1 or 0)
	
	if count2 then
		mon.Attack2.DamageDiceCount, mon.Attack2.DamageDiceSides, mon.Attack2.DamageAdd
			= mon.Attack2.DamageDiceCount + (count2 or 0), mon.Attack2.DamageDiceSides + (sides2 or 0), mon.Attack2.DamageAdd + (add2 or 0)
	end
end

function monUtils.acMul(mon, mul)
	mon.ArmorClass = round(mon.ArmorClass * mul)
end

-- contains functions f(pl), which receive player as argument and return text which is shown in "extra attributes" tooltip
local addTextFunctions = tget(rev4m, "addTextFunctions")

local strGreen = "\f02016" -- taken directly from debugger, I'm too dumb to understand StrColor
local strRed = "\f63488"
local strDefaultColor = "\f00000"

local extraAttributesText = CustomUI.CreateText{
	Text = "Extra attributes:",
	X =	110,
	Y =	33,
	--Width = 300,
	Screen = const.Screens.Inventory,
	Active = true,
	Condition = function(t)
		return Game.CurrentCharScreen == const.CharScreens.Stats
	end
}

extraDataText = CustomUI.CreateText{
	Text = "",
	X = 110,
	Y = 100,
	Width = 350,
	Screen = const.Screens.Inventory,
	Active = false,
	Condition = function(t)
		--[[if Keys.IsPressed(const.Keys.LBUTTON) or os.time() > t.Timeout then
			CustomUI.RemoveElement(t)
		else]]
		if Game.CurrentCharScreen ~= const.CharScreens.Stats then return false end
		CustomUI.ShowTooltip(t.Text, t.X, t.Y, t.Wt)
		--end
		return false
	end
}

local btnExtraData = CustomUI.CreateButton{
	IconUp = "TglXDataU",
	IconDown = "TglXDataD",
	Screen = const.Screens.Inventory,
	Layer = 1,
	DynLoad = true,
	X =	275,
	Y =	33,
	Masked = true,
	Condition = function(t)
		local show = Game.CurrentCharScreen == const.CharScreens.Stats
		if show and Game.CurrentPlayer >= 0 then
			local pl = Party[Game.CurrentPlayer]
			local text = ""
			for i, v in ipairs(addTextFunctions) do
				text = text .. v(pl) .. (i ~= #addTextFunctions and "\n\n" or "")
			end
			extraDataText.Text = text
			--debug.Message(format("%q", text))
			--local LinesCount = table.maxn(string.split(text, "\n"))
			--debug.Message(LinesCount)
			--extraDataText.Ht = 16*LinesCount*2
		else
			extraDataText.Active = false
		end
		return show
	end,
	Action = function()
		extraDataText.Active = not extraDataText.Active
	end,
}

function events.AfterLoadMap()
	if #addTextFunctions == 0 then
		extraAttributesText.Active = false
		extraDataText.Active = false
		btnExtraData.Active = false
	end
end

-- made thanks to Tomsod's Elemental Mod sources

-- shop sell item event, can be used to tweak amount of gold that player will receive
-- (it affects even merchant, so GM with 0.5 multiplier will get 250 gold
-- for 500 gold item)

-- disable short jump (it will be processed in event handler function)
mem.asmpatch(0x4B66C6, [[
	nop
	nop
	nop
	nop
	nop
	nop
]])
mem.hook(0x4B66C6, function(d)
	local t = {Multiplier = 1}
	events.call("GetShopSellPriceMul", t)
	local amount = d.esi
	if t.Multiplier ~= 1 then
		amount = round(amount * t.Multiplier)
	end
	d.eax = amount > 1 and amount or 0
end)

-- Celeste location near Walls of the Mist door can be used for another dungeon entrance (explained with "it's a portal")

local monsterRightclickDataBuf = 0x5DF0E0

local function moveLeft(amount)
	local buf = mem.string(monsterRightclickDataBuf)
	local pos = buf:find(string.char(9))
	if not pos then return end
	-- next 3 bytes describe shift to the right (in ascii), so we need to decrease it
	local replacement = tostring(tonumber(buf:sub(pos + 1, pos + 3)) - amount)
	if replacement:len() < 3 then
		replacement = string.rep("0", 3 - replacement:len()) .. replacement
	end
	mem.copy(monsterRightclickDataBuf + pos, replacement)
end

-- monster rightclick tooltip changes

-- show spell skill in monster right click info

local masteryLetters = {"N", "E", "M", "G"}
local showSpellSkill = function(skillOffset, lenOffset)
	return function(d)
		-- move spells info to the left
		moveLeft(10)
		local str = mem.string(monsterRightclickDataBuf)
		local newline = str:find(string.char(0xA))
		if newline then
			newline = newline - 1
		end
		local afterSpellName = monsterRightclickDataBuf + (newline or str:len())
		local monsterData = u4[d.ebp - 0x10]
		local skill = u2[monsterData + skillOffset]
		local s, m = SplitSkill(skill)
		local add = " " .. s .. (masteryLetters[m] or "None") .. "\n" -- "None" is for situations where monster had 0 spell skill so game doesn't crash, yes this happened during development (a bug obviously)
		mem.copy(afterSpellName, add)
		u1[afterSpellName + add:len()] = 0 -- null terminator
		-- fixme: maybe not needed?
		-- if we replace newline, not add it, subtract 1 character
		u4[0x19F93C + lenOffset] = u4[0x19F93C + lenOffset] + add:len() - (newline and 1 or 0) -- update length of row
	end
end
autohook(0x41E673, showSpellSkill(0x6E, 0))
autohook(0x41E6C7, showSpellSkill(0x70, 4))

-- show "spell" text if monster has only second spell
-- (if he has first one or both, text is shown automatically)
mem.asmpatch(0x41E6B6, [[
	cmp byte [ebp-0x2D],bl ; has first spell? (bl is 0)
	jne @normal
	push dword ptr [ebp-0x18] ; "spells" or "spell"
	push 0x4F407C ; format string with "spell"
	jmp @call
	@normal:
	push 0x4F406C ; format string without "spell"
	@call:
	push esi
	call absolute 0x4D9F10 ; process formatted string
	cmp byte [ebp-0x2D],bl
	jne @less
	add esp, 0x14
	jmp @end
	@less:
	add esp, 0x10
	@end:
	mov ecx,dword [ebp-0x8]
]], 0x11)

-- show level in monster right click info (requires novice ID monster)
autohook(0x41E3A3, function(d)
	local monsterData = u4[d.ebp - 0x10]
	local level = u1[monsterData + 0x34]
	local str = "Level\f00000\t046" .. level
	
	-- writeTextInTooltip, fastcall, args: ?, tooltip, x, y, ?, text, ?, ?, ?
	mem.call(0x44A50F, 2, u4[d.ebp - 0x8], d.edi, 86, 0xC4, u4[d.ebp - 0xC], mem.topointer(str), d.ebx, d.ebx, d.ebx)
end)

-- if you don't have required skill
autohook(0x41E40C, function(d)
	local str = "Level\f00000\t046?"
	
	mem.call(0x44A50F, 2, u4[d.ebp - 0x8], d.edi, 86, 0xC4, u4[d.ebp - 0xC], mem.topointer(str), d.ebx, d.ebx, d.ebx)
end)

-- show bonus in monster right click info (requires master ID monster)
local shift = tostring(MS.Rev4ForMergeAddResistancePenetration == 1 and 50 or 70)
shift = string.rep("0", 3 - shift:len()) .. shift
local invBonus = table.invert(const.MonsterBonus)
autohook(0x41E62D, function(d)
	local monsterData = u4[d.ebp - 0x10]
	local hasBothSpells = u2[monsterData + 0x6E] > 0 and u2[monsterData + 0x70] > 0
	local bonus, mul = u1[monsterData + 0x3F], u1[monsterData + 0x40]
	local str = "Bonus\f00000\t" .. shift .. (bonus > 0 and (invBonus[bonus] .. "x" .. mul) or "None")
	
	mem.call(0x44A50F, 2, u4[d.ebp - 0x8], d.edi, 0xAA, 0x110 + (hasBothSpells and 0xB or 0), u4[d.ebp - 0xC], mem.topointer(str), d.ebx, d.ebx, d.ebx)
end)

-- if you don't have required skill
autohook(0x41E70C, function(d)
	local monsterData = u4[d.ebp - 0x10]
	local hasBothSpells = u2[monsterData + 0x6E] > 0 and u2[monsterData + 0x70] > 0
	local str = "Bonus\f00000\t" .. shift .. "?"
	
	mem.call(0x44A50F, 2, u4[d.ebp - 0x8], d.edi, 0xAA, 0x110 + (hasBothSpells and 0xB or 0), u4[d.ebp - 0xC], mem.topointer(str), d.ebx, d.ebx, d.ebx)
end)

local function getSFTItem(p)
	local i = (p - Game.SFTBin.Frames["?ptr"]) / Game.SFTBin.Frames[0]["?size"]
	return Game.SFTBin.Frames[i]
end

-- cosmetic change: some monsters (mainly bosses) can be larger
local scaleHook = function(d)
	local t = {Scale = d.eax, Frame = getSFTItem(d.ebx)}
	t.MonsterIndex, t.Monster = internal.GetMonster(d.edi - 0x9A)
	events.call("MonsterSpriteScale", t)
	d.eax = t.Scale
end

autohook2(0x47AC26, scaleHook)
autohook2(0x47AC46, scaleHook)

-- dynamically change item bonuses frequency
do
	local stdChanceSumDataStart, spcChanceSumDataStart
	autohook(0x4547A8, function(d)
		stdChanceSumDataStart = d.esi
		-- for debugging
		--[[
		StdItemChances = mem.struct(function(define)
			define[stdChanceSumDataStart].array(9).u4("val")
		end):new(0)
		]]
	end)
	autohook(0x4549C9, function(d)
		spcChanceSumDataStart = d.esi
		--[[
		SpcItemChances = mem.struct(function(define)
			define[spcChanceSumDataStart].array(12).u4("val")
		end):new(0)
		]]
	end)

	local function changeItemsEnchantmentChances(t, spc, absolute)
		local addChances = {}
		local gameArray = spc and Game.SpcItemsTxt or Game.StdItemsTxt
		for bonus, data in pairs(t) do
			assert(#data == (spc and 12 or 9), format("Invalid number of %s items chances", spc and "spc" or "std"))
			for i, value in ipairs(data) do
				local old = gameArray[bonus].ChanceForSlot[i - 1]
				local base = absolute and 0 or old
				assert(base + value >= 0, format("Cannot have %s item chance below 0", spc and "spc" or "std"))
				gameArray[bonus].ChanceForSlot[i - 1] = base + value
				addChances[i - 1] = (addChances[i - 1] or 0) + value - old
			end
		end
		-- correct chance sums, otherwise items won't generate
		local dataStart = spc and spcChanceSumDataStart or stdChanceSumDataStart
		local limit = spc and 11 or 8
		for i = 0, limit do
			u4[dataStart + i * 4] = u4[dataStart + i * 4] + addChances[i]
		end
	end

	-- Arm	 Shld	 Helm	 Belt	 Cape	 Gaunt	 Boot	 Ring	 Amul
	function changeStdItemsChances(t, absolute)
		changeItemsEnchantmentChances(t, false, absolute)
	end

	-- W1	W2	Miss	Arm	Shld	Helm	Belt	Cape	Gaunt	Boot	Ring	Amul
	function changeSpcItemsChances(t, absolute)
		changeItemsEnchantmentChances(t, true, absolute)
	end
end

-- of course it is hardcoded
autohook2(0x453E32, function(d)
	local t = {ItemBonusId = d.eax, Result = false}
	events.call("SpcBonusIsPrefix", t)
	if t.Result then
		d:push(0x453EA2)
		return true
	end
end)

-- dark/light resistances!

function getLightRes(pl, temp)
	return i2[pl["?ptr"] + (temp and 0x1A30 or 0x1A1A)]
		+ (not temp and getItemBonusSum(pl, 69) or 0)
		+ (temp and getLightRes(pl, false) or 0)
end

function getDarkRes(pl, temp)
	return i2[pl["?ptr"] + (temp and 0x1A32 or 0x1A1C)]
		+ (not temp and getItemBonusSum(pl, 70) or 0)
		+ (temp and getDarkRes(pl, false) or 0)
end

function addLightRes(pl, amount, temp)
	local p = pl["?ptr"] + (temp and 0x1A30 or 0x1A1A)
	i2[p] = max(0, i2[p] + amount)
end

function addDarkRes(pl, amount, temp)
	local p = pl["?ptr"] + (temp and 0x1A32 or 0x1A1C)
	i2[p] = max(0, i2[p] + amount)
end

function addLightResAll(amount, temp)
	for _, pl in Party do
		addLightRes(pl, amount, temp)
	end
end

function addDarkResAll(amount, temp)
	for _, pl in Party do
		addDarkRes(pl, amount, temp)
	end
end

if MS.Rev4ForMergeAddDarkLightResistances == 1 then
	-- hook to make game respect item dark/light resistance bonuses
	autohook(0x48DF74, function(d)
		if d.edi == const.Damage.Light or d.edi == const.Damage.Dark then
			local i, pl = internal.GetPlayer(d.esi)
			if d.edi == const.Damage.Light then
				d.eax = d.eax + getItemBonusSum(pl, 69)
			elseif d.edi == const.Damage.Dark then
				d.eax = d.eax + getItemBonusSum(pl, 70)
			end
		end
	end)
	
	-- add sources of new resistances
	
    function events.AfterLoadMap()
		if Map.Name == "7out04.odm" then -- Tularean Forest
			-- altar also gives light resistance (my addition)
			replaceMapEvent(452, function()
				if evt.Cmp{"PlayerBits", Value = 25} then
					Game.ShowStatusText("You Pray")
				else
					evt.Add{"WaterResistance", Value = 10}
					evt.Add{"FireResistance", Value = 10}
					evt.Add{"AirResistance", Value = 10}
					addLightRes(Party[max(Game.CurrentPlayer, 0)], 10)
					evt.Add{"PlayerBits", Value = 25}
					Game.ShowStatusText("+10 Water, Fire, Air and Light resistances (permanent)")
				end
			end)
		elseif Map.Name == "7out05.odm" then -- Deyja
			-- altar also gives dark resistance (my addition)
			replaceMapEvent(452, function()
				if evt.Cmp{"PlayerBits", Value = 26} then
					Game.ShowStatusText("You Pray")
				else
					evt.Add{"MindResistance", Value = 10}
					evt.Add{"EarthResistance", Value = 10}
					evt.Add{"BodyResistance", Value = 10}
					addDarkRes(Party[max(Game.CurrentPlayer, 0)], 10)
					evt.Add{"PlayerBits", Value = 26}
					Game.ShowStatusText("+10 Mind, Earth, Body and Dark resistances (permanent)")
				end
			end)
		end
	end

	-- cauldrons are handled in Structs/After/GlobalEventsNewHandler.lua
	
	-- item bonuses
	function events.GameInitialized2()
		local values = {10, 10, 5, 0, 10, 15, 5, 10, 10}
		local change = {}
		for stdBonus = 68, 69 do
			change[stdBonus] = values
		end
		changeStdItemsChances(change, true)
	end
	
	-- add way to check new resistances
	local template = "\f30316Extra resistances\f00000\nLight resistance      %s%d%s / %d\nDark resistance      %s%d%s / %d"
	table.insert(addTextFunctions, function(pl)
		local tempL, permL, tempD, permD = getLightRes(pl, true), getLightRes(pl, false), getDarkRes(pl, true), getDarkRes(pl, false)
		local aboveBaseL, aboveBaseD = tempL > permL, tempD > permD
		return format(template, aboveBaseL and strGreen or "", tempL, aboveBaseL and strDefaultColor or "", permL,
									 aboveBaseD and strGreen or "", tempD, aboveBaseD and strDefaultColor or "", permD)
	end)
else
	-- Merge (Revamp?) default is to have fields in structs.Player for dark/light resists,
	-- but there's nothing in the game that raises them, so because I modify them in save game,
	-- I have to override them with 0, otherwise you could resist dark/light
	-- with ModSettings option turned off
	autohook2(0x48DF74, function(d)
		if d.edi == const.Damage.Light or d.edi == const.Damage.Dark then
			d.eax = 0
		end
	end)
end

function randomizeAndSetCorrectType(id, level, typ) -- just Randomize() leaves item look on map unchanged
	if MS.Rev4ForMergeRandomizeRemovedItems == 1 then
		local obj = Map.Objects[id]
		obj.Item:Randomize(level, typ)
		obj.Type = Game.ItemsTxt[obj.Item.Number].SpriteIndex
		obj.TypeIndex = obj.Type
	else
		Map.RemoveObject(id)
	end
end

-- QUESTS IN SCHOOL OF SORCERY AND BREEDING PIT (maybe make completing one a condition for completing other for extra variety?)

-- writing information about map objects to file
-- to use I launched the game and started new party on Antagarich
-- (you shouldn't load a saved game, because some items might be
-- missing, because they were collected (I was bitten by this)
function mergeMapItemsDump()
	local file = io.open("Output map items merge.txt", "wb")
	local prevI
	local i = 62
	local outT = {"Map name\tObject id\tItem number\tItem name\tX\tY\tZ"}
	local first = true
	function fn()
		if Game.CurrentScreen ~= const.Screens.Game then return end
		evt.MoveToMap{Name = i <= 207 and Game.MapStats[i].FileName or "7out01.odm"}
		--coroutine.resume(coroutine.create(Sleep), 3000))
		--local t = {}
		if not first and prevI <= 207 then
			for k, v in Map.Objects do
				if v.Item then
					--table.insert(t, {k, v.Item.Number, Game.ItemsTxt[v.Item.Number].Name})
					table.insert(outT, format("%s\t%d\t%d\t%s\t%d\t%d\t%d", Game.MapStats[prevI].FileName:lower(), k, v.Item.Number, Game.ItemsTxt[v.Item.Number].Name, v.X, v.Y, v.Z))
				end
			end
		else
			first = false
		end
		--[[for k, v in ipairs(t) do
			t[k] = v[1] .. "\t" .. v[2] .. "\t" .. v[3]
		end
		debug.Message("Map name: " .. sorted[i].Name .. "("  .. sorted[i].FileName .. ")", unpack(t))]]
		prevI = i
		i = i + 1
		if i == 137 then
			prevI = 136
			i = 207
		end
	end
	local once = true
	function events.LoadMap()
		if i > 207 + 1 then
			if once then
				once = false
				file:write(table.concat(outT, "\r\n"))
				file:close()
			end
			events.Remove(1)
			return
		end
		Timer(fn, 1, false) -- timer is removed on next map load
	end
end

function changeChestItem(chest, index, item)
	local chestItem = Map.Chests[chest].Items[index]
	if type(item) == "number" then
		chestItem.Number = item
		return true
	elseif type(item) == "table" and not item.level then
		for k, v in pairs(item) do
			chestItem[k] = v
		end
		return true
	elseif type(item) == "table" and item.level then
		chestItem:Randomize(item.level, item.type or const.ItemType.Any)
		return true
	end
	return false
end

function addChestItem(chest, item, count)
	count = count or 1
	local added = 0
	for i, chestItem in Map.Chests[chest].Items do
		if chestItem.Number == 0 then
			changeChestItem(chest, i, item)
			added = added + 1
			if added >= count then
				return true
			end
		end
	end
	return false
end

function removeChestItem(chest, index)
	local setZero = {"Number", "Bonus", "BonusStrength", "Bonus2", "Charges", "MaxCharges"}
	local setFalse = {"Identified", "Broken", "Hardened", "Stolen"}
	local item = Map.Chests[chest].Items[index]
	for i, v in ipairs(setZero) do
		item[v] = 0
	end
	for i, v in ipairs(setFalse) do
		item[v] = false
	end
	return true
end

function findAndRemoveChestItem(chest, itemNumber, all)
	local found = false
	for i, item in Map.Chests[chest].Items do
		if item.Number == itemNumber then
			removeChestItem(chest, i)
			found = true
			if not all then
				return true
			end
		end
	end
	return found
end

function dispelMagic(unblockable)
	for i, pl in Party do
		if unblockable or not isPlayerImmuneToDispel(pl) then
			for buffid, buff in pl.SpellBuffs do
				mem.call(0x455E3C, 1, buff["?ptr"])
			end
		end
	end
	if unblockable or not isPartyImmuneToDispel() then
		for i, buff in Party.SpellBuffs do
			mem.call(0x455E3C, 1, buff["?ptr"])
		end
	end
end

-- BALANCE CHANGES
-- restrict GM to 2nd promotion only, and M to 1st or 2nd (without promotion you can get at most expert)
if MS.Rev4ForMergeRestrictMasteries == 1 then
	function events.GameInitialized2()
		for classId, skills in Game.Classes.Skills do
			local tier = assert(Game.ClassesExtra[classId].Step)
			local maxMastery = tier + 2
			for skillId, val in skills do
				skills[skillId] = min(val, maxMastery)
			end
		end
		--events.Remove("BeforeLoadMap", 1)
	end
end

-- max NPCs hired at the same time
if MS.Rev4ForMergeDecreaseMaxHiredNpcAmount == 1 then
	local i, val = debug.findupvalue(NPCFollowers.HireNPC, "MaxHirelings")
	-- 4/3/2 by default
	debug.setupvalue(NPCFollowers.HireNPC, i, diffsel(val, max(val - 1, 1), max(val - 2, 1)))
end

-- dispel immunity enchantment

-- there is built-in function for that in game code, but I don't want to search for MM8 version
function playerHasSpcBonus(pl, bonus)
	for item, slot in pl:EnumActiveItems() do
		if item.Bonus2 == bonus then
			return true
		end
	end
end

function isPartyImmuneToDispel()
	if MS.Rev4ForMergeEnableDispelImmunityEnchantment ~= 1 then
		return false
	end
	local count = 0
	for i, pl in Party do
		if playerHasSpcBonus(pl, rev4m.const.spcBonuses.permanence + 1) then -- + 1 because first bonus is 1 (0 is no bonus)
			count = count + 1
		end
	end
	-- (bonus count / party size)% chance of being immune to dispel
	local roll = math.random(1, Party.Count)
	return roll <= count
end

function isPlayerImmuneToDispel(pl)
	if MS.Rev4ForMergeEnableDispelImmunityEnchantment ~= 1 then
		return false -- vanilla still applies roll for personality & intellect
	end
	return playerHasSpcBonus(pl, rev4m.const.spcBonuses.permanence + 1)
end

do
	local change = {} -- will contain enchantment chances to change

	if MS.Rev4ForMergeEnableDispelImmunityEnchantment == 1 then
		change[rev4m.const.spcBonuses.permanence] = {0, 0, 0, 10, 20, 5, 5, 5, 5, 5, 15, 15}
		
		autohook(0x40553A, function(d)
			if isPartyImmuneToDispel() then
				d:push(0x405551)
				return true
			end
		end)

		autohook(0x405560, function(d)
			if isPlayerImmuneToDispel(Party[u4[d.ebp + 0x10]]) then
				d:push(0x4055C9)
				return true
			end
		end)
	end

	-- curse immunity enchantment
	if MS.Rev4ForMergeEnableCurseImmunityEnchantment == 1 then
		change[rev4m.const.spcBonuses.blessed] = {5, 5, 0, 10, 10, 5, 5, 5, 5, 5, 10, 5}

		function events.DoBadThingToPlayer(t)
			if t.Thing == const.MonsterBonus.Curse and playerHasSpcBonus(t.Player, rev4m.const.spcBonuses.blessed + 1) then
				t.Allow = false
			end
		end

		function events.SpcBonusIsPrefix(t)
			if t.ItemBonusId == rev4m.const.spcBonuses.blessed + 1 then
				t.Result = true
			end
		end
	end

	-- item enchantment chances
	function events.GameInitialized2()
		--W1	W2	Miss	Arm	Shld	Helm	Belt	Cape	Gaunt	Boot	Ring	Amul
		changeSpcItemsChances(change, true)
	end
end

-- increase stat breakpoint rewards
if MS.Rev4ForMergeChangeStatisticBreakpoints == 1 then
	local vals = {
		500, 52,
		400, 42,
		350, 37,
		300, 32,
		275, 30,
		250, 28,
		225, 26,
		200, 24,
		180, 23,
		161, 22,
		146, 21,
		131, 20,
		116, 19,
		101, 18,
		91, 17,
		82, 16,
		74, 15,
		67, 14,
		61, 13,
		55, 12,
		50, 11,
		45, 10,
		40, 9,
		35, 8,
		31, 7,
		27, 6,
		24, 5,
		21, 4,
		19, 3,
		17, 2,
		15, 1,
		13, 0,
		11, -1,
		9, -2,
		7, -3,
		5, -4,
		3, -5,
		0, -6
	}
	
	function events.GetStatisticEffect(t)
		for i = 1, #vals - 2, 2 do
			if t.Value >= vals[i] then
				t.Result = vals[i + 1]
				return
			end
		end
		t.Result = vals[#vals]
	end

	-- nerf day of the gods
	local powers = {1, 2, 2, 3} -- per skill
	local bonuses = {3, 3, 15, 15}
	function events.PlayerSpellVar(t)
		--{Spell = 33, VarNum = 3, Value = d.eax, Mastery = u4[0x51791C]}
		if t.Spell == const.Spells.DayOfTheGods then
			if t.VarNum == 3 then -- per skill
				t.Value = assert(powers[t.Mastery])
			elseif t.VarNum == 4 then -- const
				t.Value = assert(bonuses[t.Mastery])
			end
		end
	end
end

-- always show full info if you have required skill, no matter the id monster mastery
-- identify monster gives ability to do critical hits
if MS.Rev4ForMergeRemakeIdentifyMonster == 1 then
	mem.nop2(0x41E07A, 0x41E0EF)
	mem.hook(0x41E07A, function(d)
		local maxS, maxM = 0, 0
		for _, pl in Party do
			if pl:IsConscious() then
				-- TODO: make skill and mastery joined together?
				-- TODO: doesn't take into account items "of Identifying". Use difference between pl:GetSkill() call and base value to auto calculate item and/or follower bonus?
				local s, m = SplitSkill(pl.Skills[const.Skills.IdentifyMonster])
				-- id monster bonus
				local maxBonus = 0
				for item, slot in pl:EnumActiveItems(false) do
					if item.Bonus == 21 then
						maxBonus = max(maxBonus, item.BonusStrength)
					end
				end
				if s * 4 + maxBonus > maxS then
					maxS = s * 4 + maxBonus
				end
				maxM = max(maxM, m)
			end
		end
		d.eax, d.ecx = maxS, maxM
	end)

	mem.asmpatch(0x41E07F, [[
		cmp ecx, 4
		jae @show
		mov ecx,dword [ss:ebp-0x10] ; monster
		movzx ecx,byte [ds:ecx+0x34] ; level
		cmp eax,ecx
		jb @dontshow
		@show:
		xor eax, eax
		inc eax
		mov dword [ss:ebp-0x1C],eax ; novice info
		mov dword [ss:ebp-0x24],eax ; expert info
		mov dword [ss:ebp-0x14],eax ; master info
		mov dword [ss:ebp-0x34],eax ; GM info
		mov dword [ss:ebp-0x28],eax ; spell effects (in vanilla shows if anyone in party has master ID monster or higher)
		@dontshow: 
		jmp absolute 0x41E0EF
	]], 0x70)
	
	-- skip small chunk of code taken care of by our hook function
	mem.asmpatch(0x41E164, "jmp " .. 0x41E1A4 - 0x41E164)
	
	local critAttackMsg = "%s critically hits %s for %lu damage!" .. string.char(0)
	local critShootMsg = "%s critically shoots %s for %lu points!" .. string.char(0)
	local critKillMsg = "%s critically inflicts %lu points killing %s!" .. string.char(0)
	
	local critChances = {2, 5, 10, 20}
	local skillDamageMultipliers = {1, 2, 3, 5}
	local function isCrit(pl, damage)
		local s, m = SplitSkill(pl.Skills[const.Skills.IdentifyMonster])
		if s == 0 then return false end
		local chance = critChances[m]
		local roll = math.random(1, 100)
		if roll <= chance then
			local skillDamageMul = assert(skillDamageMultipliers[m])
			local maxBonus = 0
			for item, slot in pl:EnumActiveItems(false) do
				if item.Bonus == 21 then
					maxBonus = max(maxBonus, item.BonusStrength)
				end
			end
			return true, round(damage * (1 + (s * skillDamageMul + 9 + maxBonus) / 100))
		else
			return false
		end
	end
	
	local crit, dmg = false
	local function critProcHook(d)
		local i, pl = internal.GetPlayer(u4[d.ebp - 0x8])
		crit, dmg = isCrit(pl, d.eax)
		if not crit then return end
		d.eax = dmg
	end
	autohook2(0x43703F, critProcHook) -- shoot (ranged)
	autohook2(0x437148, critProcHook) -- spell
	autohook2(0x437243, critProcHook) -- melee attack
	
	autohook(0x4376AC, function(d)
		if not crit then return end
		local addr, result = u4[d.esp + 4]
		if addr == u4[0x6016D8] then -- attack
			result = mem.topointer(critAttackMsg)
		elseif addr == u4[0x60173C] then -- shoot
			result = mem.topointer(critShootMsg)
		elseif addr == u4[0x601704] then -- kill
			result = mem.topointer(critKillMsg)
		else
			error("Unknown attack message type")
		end
		u4[d.esp + 4] = result
		crit = false
	end)
	
	local IdMonsterDescriptions =
	{
		"The identify monster skill is applied when you right-click on a monster. If you have high enough skill, all information about the monster will be revealed. It also allows you to perform critical hits with melee/ranged attacks and spells.",
		"Critical hit chance: 2%, extra damage: skill + 9%",
		"Critical hit chance: 5%, extra damage: skill*2 + 9%",
		"Critical hit chance: 10%, extra damage: skill*3 + 9%",
		"Critical hit chance: 20%, extra damage: skill*5 + 9%"
	}
	
	function events.GameInitialized2()
		for i, v in ipairs({0x5E4D38, 0x5E4C98, 0x5E4BF8, 0x5E4B58, 0x5E4AB8}) do
			u4[v] = mem.topointer(IdMonsterDescriptions[i])
		end
	end
else -- only makes identify monster shared skill, no other changes
	mem.nop2(0x41E07A, 0x41E086)
	mem.hook(0x41E07A, function(d)
		local maxS, maxM = 0, 0
		for _, pl in Party do
			if pl:IsConscious() then
				local s, m = SplitSkill(pl.Skills[const.Skills.IdentifyMonster])
				-- id monster bonus
				local maxBonus = 0
				for item, slot in pl:EnumActiveItems(false) do
					if item.Bonus == 21 then
						maxBonus = max(maxBonus, item.BonusStrength)
					end
				end
				if s + maxBonus > maxS then
					maxS = s + maxBonus
				end
				maxM = max(maxM, m)
			end
		end
		d.edi, d.eax = maxS, maxM
	end)
end

-- remove stealing and buff monster stats to compensate
if MS.Rev4ForMergeRemoveMonsterStealing == 1 then
	function events.GameInitialized2()
		for power = 1, 3 do
			-- mm7 thieves
			local mon = Game.MonstersTxt[406 + power - 1]
			assert(mon.Bonus == const.MonsterBonus.Steal)
			mon.Bonus = 0
			mon.FullHP = round(mon.FullHP * 1.1)
			mon.Attack1.DamageAdd = mon.Attack1.DamageAdd + power
			mon.ArmorClass = mon.ArmorClass + power
			
			-- cutpurses
			if power <= 2 then
				mon = Game.MonstersTxt[601 + power - 1]
				assert(mon.Bonus == const.MonsterBonus.Steal)
				mon.Bonus = 0
				mon.FullHP = mon.FullHP + power
				mon.Attack1.DamageAdd = mon.Attack1.DamageAdd + power
			end
			-- mm6 thieves
			mon = Game.MonstersTxt[637 + power - 1]
			assert(mon.Bonus == const.MonsterBonus.Steal)
			mon.Bonus = 0
			mon.FullHP = round(mon.FullHP * 1.1)
			mon.Attack1.DamageAdd = mon.Attack1.DamageAdd + power
			mon.ArmorClass = mon.ArmorClass + power
		end
	end
end

-- buff player-buffing potions (5 + floor(power / 4))
do
	local buffAddresses = {0x466C75, 0x466CA1, 0x466D29, } -- heroism, bless, stoneskin
	for _, addr in ipairs(buffAddresses) do
		mem.asmpatch(addr, [[
			fild dword [ebp-0xC]
			mov eax,dword [0xB7CA68] ; potion power
			shr eax, 2
			add eax, 5
			push eax
		]])
	end
end

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
end

if MS.Rev4ForMergeNerfDrainSp == 1 then
	-- remove maxMana / 4 per drainsp instead of zeroing
	-- no reason to use asm function over lua, except for increasing asm skills :)
	local nerfDrainsp = mem.asmproc([[
		push eax
		push ecx
		mov ecx, esi
		call absolute 0x48DA18 ; GetFullSP()
		shr eax, 2
		mov ecx, dword [ds:esi+0x1BFC] ; current mana
		test eax, eax
		jnz @notzero
		mov eax, 1
		@notzero:
		neg eax
		lea edi, dword [ecx + eax]
		cmp edi, 0
		jge @over
		xor edi, edi
		@over:
		mov dword [ds:esi+0x1BFC], edi
		pop ecx
		pop eax
		ret
	]])
	mem.asmpatch(0x48D501, "call absolute " .. nerfDrainsp)
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

-- remove multilooting "bug"
if MS.Rev4ForMergeRemoveMultilooting == 1 then
	mem.nop(0x4251F3)
end

-- spell resistance penetration! My dream idea is coming true :)

function getItemBonusSum(pl, bonus, customItems)
	local val = 0
	for item, slot in pl:EnumActiveItems(false) do
		if item.Bonus == bonus then
			val = val + item.BonusStrength
		end
		if customItems and customItems[item.Number] then
			val = val + customItems[item.Number]
		end
	end
	return val
end

if MS.Rev4ForMergeAddResistancePenetration == 1 then
	-- for i = 0, 137 do evt.GiveItem{Strength = 6, Type = const.ItemType.Ring} end
	
	local cd = const.Damage
	-- const.Damage
	local damageTypeToPenetrationBonus = {[cd.Fire] = 0, [cd.Air] = 1, [cd.Water] = 2, [cd.Earth] = 3,
		[cd.Spirit] = 4, [cd.Mind] = 5, [cd.Body] = 6, [cd.Light] = 7, [cd.Dark] = 8}
	
		local template = "\f43421Spell resistance penetration\f00000\r\n" .. [[
Fire      %d
Air      %d
Water      %d
Earth      %d
Spirit      %d
Mind      %d
Body      %d
Light      %d
Dark      %d]]
	table.insert(addTextFunctions, function(pl)
		local t = {}
		for bonus = 60, 68 do
			table.insert(t, getItemBonusSum(pl, bonus))
		end
		return format(template, unpack(t))
	end)

	-- allow res pen items to generate
	function events.GameInitialized2()
		local values = {0, 0, 5, 5, 10, 15, 5, 10, 10}
		local change = {}
		for stdBonus = 59, 67 do
			change[stdBonus] = values
		end
		changeStdItemsChances(change, true)
	end
	local invDamage = table.invert(const.Damage)
	
	local IMMUNE_MONSTER_RESISTANCE = 200
	function getEffectiveResistance(mon, pl, damageType)
		local res = mon.Resistances[damageType] or 0
		--local initial = res
		local immune = res == const.MonsterImmune
		local bonus = damageTypeToPenetrationBonus[damageType]
		if bonus then
			bonus = bonus + 59
			res = res - getItemBonusSum(pl, bonus + 1) -- +1 because of 1 -> 0 based array
		end
		if bonus and damageType <= const.Damage.Body then
			local buff = mon.SpellBuffs[const.MonsterBuff.DayOfProtection]
			if buff.ExpireTime > Game.Time then
				res = res + buff.Power
			end
		end
		if immune and max(res, 0) < const.MonsterImmune then
			local reduction = const.MonsterImmune - max(res, 0)
			res = IMMUNE_MONSTER_RESISTANCE - reduction
		end
		local val = max(min(res, const.MonsterImmune), 0)
		--debug.Message(format("Old: %d, new: %d, damage type: %q", initial, val, invDamage[damageType]))
		return val
	end

	-- CalcHitByEffect()
	do 
		local playerIdx, attackingPlayer

		local spellQueueHooks = {
			0x42A7FA, -- berserk
			0x42AB01, -- mass fear
			0x42A8F8, -- enslave
			0x42703A, -- charm
			0x426E91, -- paralyze
			0x42CF4C, -- dragon fear
		}

		local function h()
			attackingPlayer = Party.PlayersArray[u2[0x51D822]]
		end

		for _, addr in ipairs(spellQueueHooks) do
			autohook(addr, h)
		end

		local function objectHook(stackOffset)
			return function(d)
				local obj = u4[d.esp + stackOffset]
				local owner = i4[obj + 0x58]
				if owner % 8 == const.ObjectRefKind.Party then
					attackingPlayer = Party.PlayersArray[owner:div(8)]
				else
					attackingPlayer = nil
				end
			end
		end

		autohook(0x46AF51, objectHook(0xC)) -- dark grasp
		autohook(0x46A5C1, objectHook(0x8)) -- shrinking ray
		autohook(0x46B304, objectHook(0xC)) -- blind
		autohook(0x46B54D, objectHook(0xC)) -- vampire charm

		-- Snake (artifact sword)
		autohook(0x4373EC, function(d)
			playerIdx, attackingPlayer = internal.GetPlayer(u4[d.ebp - 0x8])
		end)

		-- stun, slow, mass distortion and control undead done in General/SpellsTweaks.lua

		autohook(0x425ABD, function(d)
			if attackingPlayer then
				local initial = d.eax
				local monsterAddr = u4[d.ebp + 0x8]
				local i, mon = internal.GetMonster(monsterAddr)
				d.eax = getEffectiveResistance(mon, attackingPlayer, u4[d.ebp + 0xC])
				attackingPlayer = nil
				--debug.Message(format("Old: %d, new: %d, damage type: %q", initial, val, u4[d.ebp + 0xC]))
			end
		end)
	end

	-- damage spells
	do
		local playerIdx, attackingPlayer, monsterIdx, attackedMonster
		-- get player&monster with another hook to not rely on assumption that MMExt stack addresses won't change (hookfunction buries old stack addresses)
		-- move mmextension hook elsewhere, because after hookfunction is entered I don't see a way to reliably get attacker (u4[d.ebp - 8]) anymore
		-- could patch about 10-12 places to get it without moving, but I'm too lazy
		autohook(0x425951, function(d)
			local aptr = u4[d.ebp - 0x8]
			if aptr >= Party.PlayersArray["?ptr"] and aptr <= Party.PlayersArray["?ptr"] + Party.PlayersArray["?size"] then
				playerIdx, attackingPlayer = internal.GetPlayer(aptr)
			else
				playerIdx, attackingPlayer = nil, nil
			end
			monsterIdx, attackedMonster = internal.GetMonster(u4[d.esp + 0x4])
		end)
		
		--[[
		0x4259C4: cmp eax,FDE8
				jl mm8.4259CF
				xor eax,eax
				jmp mm8.425A1E
				lea esi,dword ptr ds:[edx+eax+1E]
		--]]
		-- need to manually compute with our function because:
		-- 1) if resistance becomes less than 0xFDE8, it would count as simply very very high resistance
		-- 2) edx contains day of protection bonus, but if we didn't add it in our hook, we could have situation where
		-- monster was immune, reduced resistance is like FCE8 (const.MonsterBonus - 1), which is effective 199
		-- and after adding day of prot it would be for example 235, instead of full immunity
		-- 3) if we hooked last line only, immune monster would be immune no matter what (jump would be always taken, no matter penetration level)
		
		autohook(0x4259C4, function(d)
			if attackingPlayer then
				d.eax = getEffectiveResistance(attackedMonster, attackingPlayer, d.esi)
			end
		end)
		
		mem.asmpatch(0x4259CF, "lea esi,dword ptr [ds:eax+0x1E]")
		-- fix darkfire bolt to use penetration when deciding resistance?
	end
	
	local i = 1
	
	local resOrder = {cd.Fire, cd.Air, cd.Water, cd.Earth,
		cd.Mind, cd.Spirit, cd.Body, cd.Light, cd.Dark, cd.Phys}
	
	autohook(0x41E8A0, function(d)
		local pl = Party.CurrentPlayer
		-- move resistance values a little to the left (default is 070)
		moveLeft(20)
		if i == 10 then
			i = 1
			-- shorten "Physical" to "Phys" to get more space
			local str = mem.string(monsterRightclickDataBuf)
			-- Physical
			-- 12345678
			str = str:sub(1, 4) .. str:sub(9, str:len()) .. string.char(0)
			mem.copy(monsterRightclickDataBuf, str)
			return
		end
		if pl < 0 then i = i + 1; return end -- skip if no player selected
		local damageType = resOrder[i]
		local monsterPtr = u4[d.ebp - 0x10]
		local id, mon = internal.GetMonster(monsterPtr)
		local newRes = getEffectiveResistance(mon, Party[pl], damageType)
		local buf = mem.string(monsterRightclickDataBuf)
		local oldRes = u2[monsterPtr + 0x50 + (i - 1) * 2]
		local strToFind = tostring(oldRes)
		local immune = oldRes == const.MonsterImmune
		if immune then
			strToFind = "Immune"
		elseif oldRes == 0 then
			strToFind = "None"
		end
		local pos, pos2 = 0, -1
		while pos2 ~= nil do
			pos2 = buf:find(strToFind, pos + 1)
			if pos2 then
				pos = pos2
			end
		end
		local stripImmunity, gainImmunity, greater, less = false, false, false, false
		if newRes < oldRes then
			less = true
			if immune then
				stripImmunity = true
			end
		elseif newRes > oldRes then
			greater = true
			if not immune and newRes >= const.MonsterImmune then
				gainImmunity = true
			end
		end
		local changed = greater or less
		if not immune or stripImmunity then
			local replacement
			if gainImmunity then
				replacement = strGreen .. "Immune" .. strDefaultColor .. " / " .. oldRes
			elseif less and newRes == 0 then
				replacement = strRed .. "None" .. strDefaultColor .. " / " .. (immune and ("I" .. IMMUNE_MONSTER_RESISTANCE) or oldRes)
			elseif changed then
				replacement = (greater and strGreen or strRed) .. newRes .. strDefaultColor .. " / " .. (stripImmunity and ("I" .. IMMUNE_MONSTER_RESISTANCE) or oldRes)
			end
			if replacement then
				mem.copy(monsterRightclickDataBuf + pos - 1, replacement .. string.char(0))
			end
		end
		i = i + 1
	end)
	
	-- move resistances to the left if you don't have skill
	autohook(0x41E8F5, function(d)
		moveLeft(20)
		if i == 10 then
			i = 1
			-- shorten "Physical" to "Phys" to get more space
			local str = mem.string(monsterRightclickDataBuf)
			str = str:sub(1, 4) .. str:sub(9, str:len()) .. string.char(0)
			mem.copy(monsterRightclickDataBuf, str)
			return
		end
		i = i + 1
	end)
else
	function getEffectiveResistance(mon, pl, damageType)
		return mon.Resistances[damageType] or 0
	end
end

-- boost mapstats spawns depending on difficulty
-- this is forced change because Merge makes game intrinsically easier with 5th PC
function events.BeforeLoadMap()
	local indexes = {"Mon1Low", "Mon1Hi", "Mon2Low", "Mon2Hi", "Mon3Low", "Mon3Hi"}
	for i, v in Game.MapStats do
		local inc = TownPortalControls.MapOfContinent(i) == 2 and diffsel(1, 2, 3) or diffsel(2, 3, 5) -- 2 = Antagarich
		if MS.Rev4ForMergeSmallerMapstatsSpawnIncrease == 1 then
			inc = inc - 1
		end
		for j = 1, 5, 2 do
			local minIdx = indexes[j]
			local maxIdx = indexes[j + 1]
			if --[[v[idx] > 0 and ]]v[maxIdx] > 0 and v[minIdx] ~= v[maxIdx] then -- I once adopted a rule that when both spawn values are equal, no boost happens
			-- idk why, but I'll preserve it to not break anything
				v[minIdx] = v[minIdx] + inc
				v[maxIdx] = v[maxIdx] + inc
			end
		end
	end
	Game.MapStats[70].Tres = 4 -- Barrow Downs
	events.Remove("BeforeLoadMap", 1) -- should only run once, general won't work because I need TownPortalControls.MapOfContinent
end

if not isEasy() then
	-- reduce damage to monsters
	if Merge.ModSettings.Rev4ForMergeNerfDamage == 1 then
		function events.CalcDamageToMonster(t)
			-- TODO: WhoHitMonster, if monster then don't reduce damage
			-- TODO: <del>anything can hit oozes for 1 now</del> (same probably applies with medusas and spells)
			local m = 1
			-- handle monsters immune to t.DamageKind
			if t.Monster.Resistances[t.DamageKind] and t.Monster.Resistances[t.DamageKind] == const.MonsterImmune then
				m = 0
			end
			t.Result = max(m, isMedium() and round(t.Result * 0.85) or round(t.Result * 0.70))
		end
	end
	
	-- reduce gold gains from monsters, gold piles and evt.Add rewards (quests, wells etc.)
	-- gold penalty for monsters is nullified in General/AdaptiveMonstersStats.lua, because it'd be way too low
	if Merge.ModSettings.Rev4ForMergeNerfGoldGains == 1 then
		function events.BeforeGotGold(t)
			t.Amount = isMedium() and round(t.Amount * 0.75) or round(t.Amount * 0.50)
		end
	end
end

-- optional skill point refund when getting free skill barrels
function refundSkillpoints(skill, freeSkillLevel)
	for _, pl in Party do
		local s, m = SplitSkill(pl.Skills[skill])
		local level = min(s, freeSkillLevel)
		if level >= 2 then
			local refund = level * (level + 1) / 2 - 1
			pl.SkillPoints = pl.SkillPoints + refund
		end
	end
end

-- skill level and mastery won't ever be reduced to boost amount if higher
-- also higher difficulty reduces skill level gained
local reqSkill = {1, 4, 7, 10}
function giveFreeSkill(skill, level, mastery, check)
	if Merge.ModSettings.Rev4ForMergeNerfSkillBoosts == 1 then
		if isMedium() then
			level = max(reqSkill[mastery], level - 1)
			--level = max(1, level - 1)
		elseif isHard() then
			level = max(reqSkill[mastery], level - 2)
			--level = max(1, level - 2)
		end
	end

	if Merge.ModSettings.Rev4ForMergeRefundSkillpoints == 1 then
		refundSkillpoints(skill, level)
	end
	local benefit = false
	for i, pl in Party do
		if check and type(check) == "function" and not check(pl) then
			goto continue
		end
		local s, m = SplitSkill(pl.Skills[skill])
		if level > s or mastery > m or (s >= 2 and Merge.ModSettings.Rev4ForMergeRefundSkillpoints == 1) then
			benefit = true
			evt[i].Add("Experience", 0) -- make sparkle sound and animation
			pl.Skills[skill] = JoinSkill(max(level, s), max(m, mastery))
		end
		::continue::
	end
	if not benefit then
		Game.ShowStatusText("You received the bonus but didn't benefit from it")
	end
end

-- boost base alchemy skill
if MS.Rev4ForMergeBoostBaseAlchemySkill == 1 then
	function events.GetSkill(t)
		if t.Skill == const.Skills.Alchemy then
			local lev = SplitSkill(t.Player.Skills[const.Skills.Alchemy])
			if lev > 0 then
				local rs, rm = SplitSkill(t.Result)
				t.Result = JoinSkill(rs + lev, rm)
			end
		end
	end
end

if MS.Rev4ForMergeMiscBalanceChanges == 1 then
	function events.CalcStatBonusBySkills(t)
		-- make GM leather actually give decent resistances
		if t.Stat >= const.Stats.FireResistance and t.Stat <= const.Stats.EarthResistance then
			local s, m = SplitSkill(t.Player:GetSkill(const.Skills.Leather))
			if m == const.GM and t.Player.ItemArmor ~= 0 then
				for item, slot in t.Player:EnumActiveItems(false) do
					if slot == const.ItemSlot.Armor and item:T().Skill == const.Skills.Leather then
						t.Result = t.Result + s * 3
						break
					end
				end
			end
		end
	end

	function events.PlayerSpellVar(t)
		-- buff stoneskin
		if t.Spell == const.Spells.StoneSkin and t.VarNum == 3 then -- armor per skill
			t.Value = 2
		-- nerf paralyze
		elseif t.Spell == const.Spells.Paralyze and t.VarNum == 1 then -- duration per skill
			t.Value = 60 -- 1 minute instead of 3
		end
	end

	function events.CalcStatBonusByItems(t)
		-- boost "of Doom" to not be garbage
		if t.Stat >= const.Stats.Might and t.Stat <= const.Stats.BodyResistance then
			for item, slot in t.Player:EnumActiveItems(false) do
				if item.Bonus2 == 42 then
					t.Result = t.Result + 2
				end
			end
		end
		
		-- make "of the Gods" actually deserve D rating and 3000 gold price (it still sucks for spellcasters though)
		if t.Stat >= const.Stats.Might and t.Stat <= const.Stats.Luck then
			for item, slot in t.Player:EnumActiveItems(false) do
				if item.Bonus2 == 2 then
					t.Result = t.Result + 15
				end
			end
		end
	end

	local GMDesc = "Skill*4 added to Elemental (Fire/Earth/Air/Water) Resistances."
	function events.GameInitialized2()
		u4[0x5E4A54] = mem.topointer(GMDesc)
		Game.SpcItemsTxt[1].BonusStat = "+25 to all Seven Statistics." -- of the gods
		Game.SpcItemsTxt[41].BonusStat = "+3 to Seven Stats, HP, SP, Armor, Resistances." -- of doom

		local count
		local spellEntry = Game.SpellsTxt[const.Spells.StoneSkin]
		spellEntry.Description, count = spellEntry.Description:gsub("5 %+ 1 point", "5 %+ 2 points")
		assert(count == 1, "Couldn't change stone skin spell description")

		spellEntry = Game.SpellsTxt[const.Spells.Paralyze]
		spellEntry.Description, count = spellEntry.Description:gsub("3 minutes", "1 minute")
		assert(count == 1, "Couldn't change paralyze spell description")
	end
end

-- for testing
--[[
function events.BeforeNewGameAutosave()
	tget(vars, "ExtraSettings").UseMonsterBolster = false
	-- allow F5 for quicksave
	vars.ExtraSettings.QSKeybinds = {
		[117] = 1, -- F6
		[118] = 1, -- F7
		[119] = 1, -- F8
		[121] = 1, -- F10
	}
	god() -- god script needs to be in General directory
	for i, pl in Party do
		pl.QuickSpell = const.Spells.Fireball
		for stat = const.Stats.Might, const.Stats.Luck do
			pl.Stats[stat].Base = 500
		end
		for res in pl.Resistances do
			pl.Resistances[res].Base = 500
		end
	end
end
]]

-- testing spc bonuses generation
-- for i = 1, 100 do evt.GiveItem{Strength = 5, Type = const.ItemType.Ring} end; local count = 0; for i, item in Party[0].Items do if item.Bonus2 == rev4m.const.spcBonuses.permanence + 1 then count = count + 1 end end; print(count)