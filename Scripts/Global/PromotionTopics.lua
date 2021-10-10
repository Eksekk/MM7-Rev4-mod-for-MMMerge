local LogId = "PromotionTopics"
local Log = Log
Log(Merge.Log.Info, "Init started: %s", LogId)
local MF, MM, MS, MT = Merge.Functions, Merge.ModSettings, Merge.Settings, Merge.Tables
local CPA = const.PromoAwards
local max, min = math.max, math.min
local strformat, strlower = string.format, string.lower

local TXT = {
	promotion = "%s promotion",
	promote_to = "Promote to %s",
	promote_to_honorary = "Promote to Honorary %s",
	cannot_be_promoted = "%s cannot be promoted to %s.",
	already_promoted = "You have been promoted already to the rank of %s.",
	congratulations = "Congratulations, %s!",
	convert_to = "Convert to %s",
	cannot_be_converted_to_undead = "Race %s cannot be converted to Undead.",
	master_druids = "Master Druids",
	battle_mages = "Battle Mages",
	justiciars = "Justiciars",
	warmongers = "Warmongers",
	warmongers1 = "Can you please clear Ancient Troll Home from these nasty Basilisks? All Berserkers in your party will be promoted to Warmonger.",
	warmongers2 = "If you ever want to be considered Warmonger candidate you should have no problem with ordinary Basilisks. Come back after you finish them.",
	warmongers3 = "So those Basilisks are no longer a threat? Great news! All Berserkers among you have been promoted to Warmonger."
}

local CC = const.Class

--------------------------------------------
---- Learn basic blaster (Tolberti, Robert the Wise)

Game.GlobalEvtLines:RemoveEvent(950)
Game.NPCTopic[950] = Game.GlobalTxt[278] -- Blaster
evt.Global[950] = function()
	local Noone = true
	for i, v in Party do
		if v.Skills[7] == 0 and Game.Classes.Skills[v.Class][7] > 0 then
			evt.ForPlayer(i).Set{"BlasterSkill", 1}
			Noone = false
		end
	end
end

--------------------------------------------
---- Base functions
local LichAppearance = {
[const.Race.Dwarf]		= {[0] = {Portrait = 65, Voice = 26}, [1] = {Portrait = 66, Voice = 27}},
[const.Race.Dragon]		= {[0] = {Portrait = 67, Voice = 28}, [1] = {Portrait = 67, Voice = 28}},
[const.Race.Minotaur]	= {[0] = {Portrait = 69, Voice = 67}, [1] = {Portrait = 69, Voice = 67}},
[const.Race.Troll]	= {[0] = {Portrait = 75, Voice = 72}, [1] = {Portrait = 75, Voice = 72}},
default					= {[0] = {Portrait = 26, Voice = 26}, [1] = {Portrait = 27, Voice = 27}}
}

local function SetLichAppearance(i, v)
	local player = v
	if v.Class == const.Class.MasterNecromancer then
		local Race = GetCharRace(v)

		if MS.Conversions.PreserveRaceOnLichPromotion == 1
				and Game.Races[Race].Kind == const.RaceKind.Undead then
			if MS.Races.MaxMaturity > 0 then
				Log(Merge.Log.Info, "Lich promotion: only improve maturity of undead kind race")
				local maturity = player.Attrs.Maturity or 0
				-- FIXME
				player.Attrs.Maturity = min(2, MS.Races.MaxMaturity)
			else
				Log(Merge.Log.Info, "Lich promotion: do not convert undead kind race")
			end
		elseif MS.Conversions.PreserveRaceOnLichPromotion == 2 then
			Log(Merge.Log.Info, "Lich promotion: keep current race")
		else
			Log(Merge.Log.Info, "Lich promotion: convert race")
			local CurPortrait = Game.CharacterPortraits[v.Face]
			local CurSex = CurPortrait.DefSex

			if Game.Races[Race].Family ~= const.RaceFamily.Undead
					and Game.Races[Race].Family ~= const.RaceFamily.Ghost then
				local NewFace = LichAppearance[Game.Races[Race].BaseRace]
						or LichAppearance.default
				NewFace = NewFace[CurSex]

				local new_race

				new_race = table.filter(Game.Races, 0,
					"BaseRace", "=", Game.Races[Race].BaseRace,
					"Family", "=", const.RaceFamily.Undead
					)[1].Id

				if new_race and new_race >= 0 then
					player.Attrs.Race = new_race
					if MS.Races.MaxMaturity > 0 then
						-- FIXME
						player.Attrs.Maturity = min(2, MS.Races.MaxMaturity)
					end
				end

				player.Face = NewFace.Portrait
				if MS.Conversions.KeepVoiceOnRaceConversion == 1 then
					Log(Merge.Log.Info, "Lich Promotion: keep current voice")
				else
					v.Voice = NewFace.Voice
				end
				SetCharFace(i, NewFace.Portrait)
			end

			-- Consider not to increase overbuffed lich resistances
			for j = 0, 3 do
				v.Resistances[j].Base = max(v.Resistances[j].Base, 20)
			end

			local RepSkill = SplitSkill(v.Skills[26])
			if RepSkill > 0 then
				local CR = 0
				for i = 1, RepSkill do
					CR = CR + i
				end
				v.SkillPoints = v.SkillPoints + CR - 1
				v.Skills[26] = 0
			end
		end
	end
end

local function Promote(From, To, PromRewards, NonPromRewards, Gold, QBits, Awards)

	local Check

	if type(From) == "table" then
		Check = table.find
	else
		Check = function(v1, v2) return v1 == v2 end
	end

	for i,v in Party do
		if Check(From, v.Class) then
			evt.ForPlayer(i).Set{"ClassIs", To}
			if PromRewards then
				for k,v in pairs(PromRewards) do
					evt.ForPlayer(i).Add{k, v}
				end
			end
		elseif NonPromRewards then
			for k,v in pairs(NonPromRewards) do
				evt.ForPlayer(i).Add{k, v}
			end
		end
	end

	if GlobalRewards then
		for k,v in pairs(GlobalRewards) do
			evt.Add{k, v}
		end
	end

	if Gold then
		evt.Add{"Gold", Gold}
	end

	if QBits then
		for k,v in pairs(QBits) do
			evt.Add{"QBits", v}
		end
	end

	if Awards then
		for k,v in pairs(Awards) do
			evt.ForPlayer("All").Add{"Awards", v}
		end
	end

end

--[[
Promote2{
	From 	= ,
	To 		= ,
	PromRewards 	= {},
	NonPromRewards 	= {},
	Gold 	= ,
	QBits 	= {},
	Awards	= {},
	Reputation	 = ,
	TextIdFirst	 = ,
	TextIdSecond = ,
	TextIdRefuse = ,
	Condition	 = nil -- function() return true end
}
]]
local function Promote2(t)

	local Check

	if type(t.From) == "table" then
		Check = table.find
	else
		Check = function(v1, v2) return v1 == v2 end
	end

	local FirstTime = true
	for k,v in pairs(t.QBits) do
		if Party.QBits[v] then
			FirstTime = false
			break
		end
	end

	local CanPromote = not FirstTime or not t.Condition or t.Condition()

	if not CanPromote then
		Message(Game.NPCText[t.TextIdRefuse])
		return 0
	end

	if t.TextIdFirst then
		if FirstTime then
			Message(Game.NPCText[t.TextIdFirst])
		else
			Message(Game.NPCText[t.TextIdSecond or t.TextIdFirst])
		end
	end

	for i,v in Party do
		if Check(t.From, v.Class) then
			evt.ForPlayer(i).Set{"ClassIs", t.To}
			if t.PromRewards then
				for k,v in pairs(t.PromRewards) do
					evt.ForPlayer(i).Add{k, v}
				end
			end
		elseif FirstTime and t.NonPromRewards then
			for k,v in pairs(t.NonPromRewards) do
				evt.ForPlayer(i).Add{k, v}
			end
		end
	end

	if FirstTime then

		for k,v in pairs(t.QBits) do
			evt.Add{"QBits", v}
		end

		if t.Gold then
			evt.Add{"Gold", t.Gold}
		end

		if t.Reputation then
			evt.Add{"Reputation", t.Reputation}
		end

		if t.Awards then
			for k,v in pairs(t.Awards) do
				evt.ForPlayer("All").Add{"Awards", v}
			end
		end

	end

	return FirstTime and 1 or 2

end

local function CheckPromotionSide(ThisSideBit, OppSideBit, ThisText, OppText, ElseText)
	if Party.QBits[ThisSideBit] then
		Message(Game.NPCText[ThisText])
		return true
	elseif Party.QBits[OppSideBit] then
		Message(Game.NPCText[OppText])
	else
		Message(Game.NPCText[ElseText])
	end
	return false
end

local function can_convert_to_undead(player)
	local family = Game.Races[player.Attrs.Race].Family
	local kind = Game.Races[player.Attrs.Race].Kind
	local baserace = Game.Races[player.Attrs.Race].BaseRace
	if family == const.RaceFamily.Undead then
		return 0
	end
	if family == const.RaceFamily.Ghost then
		return -1
	end
	if MM.ConversionToUndeadRestriction == 1 and kind == const.RaceKind.Undead then
		return -1
	end
	if MM.ConversionToUndeadRestriction == 2 then
		return -1
	end
	local race = table.filter(Game.Races, 0,
		"BaseRace", "=", baserace,
		"Family", "=", const.RaceFamily.Undead
		)[1].Id
	if race and race > 0 then
		return race
	end
end

local function promote_class(t)
	local k = MF.GetCurrentPlayer() or 0
	local player = Party[k]
	local orig_class = player.Class
	if player.Class == t.Class and not t.SameClass then
		Message(strformat(TXT.already_promoted, Game.ClassNames[t.Class]))
		return false
	else
		if type(t.From) == "table" then
			if not table.find(t.From, player.Class) then
				Message(strformat(TXT.cannot_be_promoted,
					Game.ClassNames[player.Class], Game.ClassNames[t.Class]))
				return false
			end
		elseif not table.find(MT.ClassPromotionsInv[t.Class] or {}, player.Class)
				and (not t.SameClass or player.Class ~= t.Class) then
			Message(strformat(TXT.cannot_be_promoted,
				Game.ClassNames[player.Class], Game.ClassNames[t.Class]))
			return false
		end
		if (player.Attrs.Race == t.Race or Game.Races[player.Attrs.Race].Family == t.RaceFamily)
				and t.Maturity and (not player.Attrs.Maturity
				or player.Attrs.Maturity < t.Maturity) then
			MF.ConvertCharacter({Player = player, ToClass = t.Class, ToMaturity = t.Maturity})
		else
			MF.ConvertCharacter({Player = player, ToClass = t.Class})
		end
		if t.Exp and t.Exp ~= 0 and orig_class ~= t.Class then
			evt[k].Add("Experience", t.Exp)
		end
		if t.Award then
			player.Attrs.PromoAwards[t.Award] = true
		end
		Message(strformat(TXT.congratulations, Game.ClassNames[t.Class]))
		MF.ShowAwardAnimation()
		return true
	end
end

local function promote_honorary_class(t)
	local k = MF.GetCurrentPlayer() or 0
	local player = Party[k]
	local show_anim = false
	if (player.Attrs.Race == t.Race or Game.Races[player.Attrs.Race].Family == t.RaceFamily)
			and t.Maturity and (not player.Attrs.Maturity
			or player.Attrs.Maturity < t.Maturity) then
		MF.ConvertCharacter({Player = player, ToMaturity = t.Maturity})
		show_anim = true
	end
	if not player.Attrs.PromoAwards[t.Award] and not (player.Class == t.Class) then
		player.Attrs.PromoAwards[t.Award] = true
		show_anim = true
	end
	if show_anim then
		MF.ShowAwardAnimation()
	end
end

local function mm6_generate_promo_quests(t)
	QuestNPC = t.QuestNPC
	local class = CC[t.Name]
	local branch = strlower(t.Name)
	local class_name = Game.ClassNames[class]
	Quest{
		Name = "MM6_Promo_" .. t.Name .. "_1",
		Branch = "",
		Slot = t.Slot,
		CanShow = function() return Party.QBits[t.QBit] end,
		Ungive = function()
			QuestBranch(branch)
		end,
		Texts = {
			Topic = strformat(TXT.promotion, class_name),
			Greet = t.Greet and Game.NPCText[t.Greet]
		}
	}
	Quest{
		Name = "MM6_Promo_" .. t.Name .. "_2",
		Branch = branch,
		Slot = 0,
		Ungive = function()
			promote_class({Class = class, Award = CPA["Enroth" .. t.Name],
				Race = const.Race.Human, Maturity = t.Maturity, Exp = t.Exp})
		end,
		Texts = {
			Topic = strformat(TXT.promote_to, class_name)
		}
	}
	Quest{
		Name = "MM6_Promo_" .. t.Name .. "_3",
		Branch = branch,
		Slot = 1,
		Ungive = function()
			promote_honorary_class({Class = class,
				Award = CPA["EnrothHonorary" .. t.Name],
				Race = const.Race.Human, Maturity = t.Maturity})
		end,
		Texts = {
			Topic = strformat(TXT.promote_to_honorary, class_name)
		}
	}
end

local function mm8_generate_promo_quests(t)
	QuestNPC = t.QuestNPC
	local class = CC[t.Name]
	local branch = strlower(t.Name)
	local class_name = Game.ClassNames[class]
	local slot2 = t.Slot2 or 0
	Quest{
		Name = "MM8_Promo_" .. t.Name .. "_" .. t.Seq .. "_1",
		Branch = "",
		Slot = t.Slot,
		CanShow = function() return Party.QBits[t.QBit] end,
		Ungive = function()
			QuestBranch(branch)
		end,
		Texts = {
			Topic = strformat(TXT.promotion, class_name),
			Greet = t.Greet and Game.NPCText[t.Greet],
			Ungive = t.Ungive and Game.NPCText[t.Ungive]
		}
	}
	Quest{
		Name = "MM8_Promo_" .. t.Name .. "_" .. t.Seq .. "_2",
		Branch = branch,
		Slot = slot2,
		Ungive = function()
			promote_class({Class = class, Award = CPA["Jadame" .. t.Name],
				From = t.From, Race = t.Race, RaceFamily = t.RaceFamily,
				Maturity = t.Maturity, Exp = t.Exp})
		end,
		Texts = {
			Topic = strformat(TXT.promote_to, class_name)
		}
	}
	Quest{
		Name = "MM8_Promo_" .. t.Name .. "_" .. t.Seq .. "_3",
		Branch = branch,
		Slot = slot2 + 1,
		Ungive = function()
			promote_honorary_class({Class = class,
				Award = CPA["JadameHonorary" .. t.Name],
				Race = t.Race, RaceFamily = t.RaceFamily,
				Maturity = t.Maturity})
		end,
		Texts = {
			Topic = strformat(TXT.promote_to_honorary, class_name)
		}
	}
end

--------------------------------------------
---- 		ENROTH PROMOTIONS			----
--------------------------------------------

--------------------------------------------
---- Enroth Knight promotion
QuestNPC = 791	-- Osric Temper
-- First
-- "Nomination"
evt.global[1379] = function()
	Party.QBits[1283] = true
end

Quest{
	Name = "MM6_Promo_Cavalier",
	Branch = "",
	Slot = 1,
	Quest = 1138,
	Exp = 15000,
	Give = function()
		if MF.CheckClassInParty(CC.Knight) then
			Message(Game.NPCText[1771])
		else
			Message(Game.NPCText[1772])
		end
		Game.NPC[792].EventA = 1379
	end,
	CheckDone = function() return Party.QBits[1283] end,
	Done = function()
		evt[0].Add("Reputation", -50)
		Party.QBits[1273] = true
		Game.NPC[792].EventA = 1380
	end,
	Texts = {
		Topic = Game.NPCTopic[1378],
		Undone = Game.NPCText[1775],
		Done = Game.NPCText[1776]
	}
}
mm6_generate_promo_quests({QuestNPC = 791, Name = "Cavalier", Slot = 1,
	QBit = 1273, Maturity = 1, Exp = MM.MM6Promo1ExpReward})

-- Second
Quest{
	Name = "MM6_Promo_Champion",
	Branch = "",
	Slot = 2,
	Quest = 1139,
	QuestItem = 2128,
	Exp = 40000,
	CanShow = function() return Party.QBits[1273] end,
	Done = function()
		evt[0].Add("Reputation", -100)
		Party.QBits[1211] = false
		Party.QBits[1274] = true
	end,
	Texts = {
		Topic = Game.NPCTopic[1383],
		Give = Game.NPCText[1777],
		Undone = Game.NPCText[1778],
		Done = Game.NPCText[1779]
	}
}
mm6_generate_promo_quests({QuestNPC = 791, Name = "Champion", Slot = 2,
	QBit = 1274, Greet = 1812, Maturity = 2, Exp = MM.MM6Promo2ExpReward})

--------------------------------------------
---- Enroth Sorcerer promotion
QuestNPC = 790	-- Albert Newton
-- First
Quest{
	Name = "MM6_Promo_Wizard",
	Branch = "",
	Slot = 1,
	Quest = 1135,	-- "Drink from the Fountain of Magic and return to Lord Albert Newton in Mist."
	Exp = 15000,
	Give = function()
		if MF.CheckClassInParty(CC.Sorcerer) then
			Message(Game.NPCText[1759])
		else
			Message(Game.NPCText[1760])
		end
	end,
	CheckDone = function() return Party.QBits[1260] end,
	Done = function()
		evt[0].Add("Reputation", -50)
		Party.QBits[1271] = true
	end,
	Texts = {
		Topic = Game.NPCTopic[1368],
		Undone = Game.NPCText[1761],
		Done = Game.NPCText[1762]	--[[
			"You have done well in finding the Fountain.  It’s location and
			powers are a secret, do not spread its location around.  Now,
			let me show you the secrets of the wizard."
			]]
	}
}
mm6_generate_promo_quests({QuestNPC = 790, Name = "Wizard", Slot = 1,
	QBit = 1271, Maturity = 1, Exp = MM.MM6Promo1ExpReward})

if MF.GtSettingNum(MM.MM6MagePromo, 0) then
	Quest{
		Name = "MM6_Promo_Wizard_4",
		Branch = "wizard",
		Slot = 2,
		Ungive = function()
			promote_class({Class = const.Class.Mage, Award = CPA.EnrothMage})
		end,
		Texts = {
			Topic = strformat(TXT.promote_to, Game.ClassNames[const.Class.Mage])
		}
	}
end
if MF.GtSettingNum(MM.MM6NecromancerPromo, 0) then
	Quest{
		Name = "MM6_Promo_Wizard_5",
		Branch = "wizard",
		Slot = 3,
		Ungive = function()
			promote_class({Class = const.Class.Necromancer, Award = CPA.EnrothNecromancer})
		end,
		Texts = {
			Topic = strformat(TXT.promote_to, Game.ClassNames[const.Class.Necromancer])
		}
	}
end
-- Second
Quest{
	Name = "MM6_Promo_MasterWizard",
	Branch = "",
	Slot = 2,
	Quest = 1136,
	QuestItem = 2077,
	Exp = 30000,
	CanShow = function() return Party.QBits[1271] end,
	Done = function()
		evt[0].Add("Reputation", -100)
		Party.QBits[1210] = false
		Party.QBits[1272] = true
	end,
	Texts = {
		Topic = Game.NPCTopic[1372],
		Give = Game.NPCText[1763],
		Undone = Game.NPCText[1764],
		Done = Game.NPCText[1765]
	}
}
mm6_generate_promo_quests({QuestNPC = 790, Name = "MasterWizard", Slot = 2,
	QBit = 1272, Greet = 1813, Maturity = 2, Exp = MM.MM6Promo2ExpReward})

--------------------------------------------
---- Enroth Archer promotion
QuestNPC = 800	-- Erik Von Stromgard
-- First
Quest{
	Name = "MM6_Promo_WarriorMage",
	Branch = "",
	Slot = 1,
	Quest = 1145,
	QuestItem = 2106,
	KeepQuestItem = true,
	Exp = 15000,
	Done = function()
		evt[0].Add("Reputation", -50)
		Party.QBits[1279] = true
	end,
	Texts = {
		Topic = Game.NPCTopic[1404],
		Give = Game.NPCText[1801],
		Undone = Game.NPCText[1802],
		Done = Game.NPCText[1803]
	}
}
mm6_generate_promo_quests({QuestNPC = 800, Name = "WarriorMage", Slot = 1,
	QBit = 1279, Maturity = 1, Exp = MM.MM6Promo1ExpReward})

-- Second
Quest{
	Name = "MM6_Promo_BattleMage",
	Branch = "",
	Slot = 2,
	Quest = 1146,
	Exp = 40000,
	CanShow = function() return Party.QBits[1279] end,
	CheckDone = function()
		return Party.QBits[1180] and Party.QBits[1181] and Party.QBits[1182]
			 and Party.QBits[1183] and Party.QBits[1184] and Party.QBits[1185]
	end,
	Done = function()
		evt[0].Add("Reputation", -100)
		Party.QBits[1213] = false
		evt.ForPlayer("All").Subtract("Inventory", 2106)
		Party.QBits[1280] = true
	end,
	Texts = {
		Topic = TXT.battle_mages,
		Give = Game.NPCText[1804],
		Undone = Game.NPCText[1805],
		Done = Game.NPCText[1807]
	}
}
mm6_generate_promo_quests({QuestNPC = 800, Name = "BattleMage", Slot = 2,
	QBit = 1280, Greet = 1808, Maturity = 2, Exp = MM.MM6Promo2ExpReward})

--------------------------------------------
-- "Ankh"
Game.GlobalEvtLines:RemoveEvent(1613)
evt.Global[1613] = function()
	evt.SetMessage{Str = 2003}	-- "Gerrard has an ankh inscribed with his name given to him by the priests of Baa.  I’m not sure exactly what the ankh is used for, but he may use it to identify himself as a friend of Baa."
	--evt.SetNPCTopic{NPC = 799, Index = 2, Event = 1675}	-- "Loretta Fleise" : "Ankh"
	--evt.SetNPCTopic{NPC = 801, Index = 2, Event = 1676}	-- "Anthony Stone" : "Ankh"
	Party.QBits[1281] = true
end

--------------------------------------------
---- Enroth Cleric promotion
QuestNPC = 801	-- Anthony Stone
-- Ankh
Quest{
	Name = "MM6_Ankh_2",
	Branch = "",
	Slot = 3,
	QuestItem = 2068,
	Exp = 10000,
	Gold = 5000,
	NeverGiven = true,
	CanShow = function() return Party.QBits[1281] end,
	Done = function() Party.QBits[1281] = false end,
	Texts = {
		Topic = Game.NPCTopic[1676],
		Undone = Game.NPCText[2095],
		Done = Game.NPCText[2082]
	}
}
Quest{
	Name = "MM6_Ankh_3",
	Branch = "",
	Slot = 3,
	Gold = 5000,
	NeverGiven = true,
	CanShow = function() return Party.QBits[1282] end,
	Done = function()
		Party.QBits[1282] = false
		MF.ShowAwardAnimation()
	end,
	Texts = {
		Topic = Game.NPCTopic[1677],
		Done = Game.NPCText[2083]
	}
}

-- First
Quest{
	Name = "MM6_Promo_Priest",
	Branch = "",
	Slot = 1,
	Quest = 1129,	--[[
		"Hire a Stonecutter and a Carpenter, bring them to Temple
		Stone in Free Haven to repair the Temple, and then return
		to Lord Anthony Stone at Castle Stone."
		]]
	Exp = 15000,
	CheckDone = function() return Party.QBits[1130] end,
	Done = function()
		evt[0].Add("Reputation", -50)
		Party.QBits[1275] = true
	end,
	Texts = {
		Topic = Game.NPCTopic[1348],
		Give = Game.NPCText[1738],
		Undone = Game.NPCText[1739],
		Done = Game.NPCText[1740]	--[[
			"Excellent work!  The temple has been rebuilt and
			the affront to the gods eased.  For this service,
			I am happy to promote all clerics to priests, and
			I grant honorary priest status to all non-clerics.
			Congratulations! "
			]]
	}
}
mm6_generate_promo_quests({QuestNPC = 801, Name = "Priest", Slot = 1,
	QBit = 1275, Maturity = 1, Exp = MM.MM6Promo1ExpReward})

if MF.GtSettingNum(MM.MM6ClericLightPromo, 0) then
	Quest{
		Name = "MM6_Promo_Priest_4",
		Branch = "priest",
		Slot = 2,
		Ungive = function()
			promote_class({Class = const.Class.ClericLight, Award = CPA.EnrothClericLight})
		end,
		Texts = {
			Topic = strformat(TXT.promote_to, Game.ClassNames[const.Class.ClericLight])
		}
	}
end
if MF.GtSettingNum(MM.MM6ClericDarkPromo, 0) then
	Quest{
		Name = "MM6_Promo_Priest_5",
		Branch = "priest",
		Slot = 3,
		Ungive = function()
			promote_class({Class = const.Class.ClericDark, Award = CPA.EnrothClericDark})
		end,
		Texts = {
			Topic = strformat(TXT.promote_to, Game.ClassNames[const.Class.ClericDark])
		}
	}
end

-- Second
Quest{
	Name = "MM6_Promo_HighPriest",
	Branch = "",
	Slot = 2,
	Quest = 1131,
	Exp = 30000,
	CanShow = function() return Party.QBits[1275] end,
	CheckDone = function() return Party.QBits[1132] end,
	Undone = function()
		if evt.All.Cmp("Inventory", 2054) then
			Message(Game.NPCText[1743])
		else
			Message(Game.NPCText[1742])
		end
	end,
	Done = function()
		evt[0].Add("Reputation", -100)
		Party.QBits[1276] = true
	end,
	Texts = {
		Topic = Game.NPCTopic[1350],
		Give = Game.NPCText[1741],
		Done = Game.NPCText[1744]
	}
}
mm6_generate_promo_quests({QuestNPC = 801, Name = "HighPriest", Slot = 2,
	QBit = 1276, Greet = 1745, Maturity = 2, Exp = MM.MM6Promo2ExpReward})

--------------------------------------------
---- Enroth Druid promotion
QuestNPC = 799	-- Loretta Fleise
-- Ankh
Quest{
	Name = "MM6_Ankh_1",
	Branch = "",
	Slot = 3,
	QuestItem = 2068,
	Exp = 10000,
	NeverGiven = true,
	CanShow = function() return Party.QBits[1281] end,
	Done = function()
		Party.QBits[1281] = false
		Party.QBits[1282] = true
	end,
	Texts = {
		Topic = Game.NPCTopic[1675],
		Undone = Game.NPCText[2094],
		Done = Game.NPCText[2081]
	}
}

function events.NewMonth(t)
	Party.QBits[1197] = false
	Party.QBits[1198] = false
end

-- First
Quest{
	Name = "MM6_Promo_GreatDruid",
	Branch = "",
	Slot = 1,
	CheckDone = false,
	Quest = 1142,
	Texts = {
		Topic = Game.NPCTopic[1395],
		Give = Game.NPCText[1790],
		Undone = Game.NPCText[1791],
		After = Game.NPCText[1791]
	}
}

QuestNPC = 1090	-- Loretta Fleise

Quest{
	Name = "MM6_Promo_GreatDruid_0",
	BaseName = "MM6_Promo_GreatDruid",
	Branch = "",
	Slot = 0,
	Quest = 1142,
	Done = function()
		Party.QBits[1277] = true
		Party.QBits[1197] = true
		evt[0].Add("Reputation", -50)
		MF.ShowAwardAnimation()
	end,
	Texts = {
		Topic = Game.NPCTopic[1678],
		Done = Game.NPCText[1792]
	}
}
mm6_generate_promo_quests({QuestNPC = 1090, Name = "GreatDruid", Slot = 0,
	QBit = 1277, Greet = 1792, Maturity = 1, Exp = MM.MM6Promo1ExpReward})

Quest{
	Name = "MM6_Promo_GreatDruid_4",
	Branch = "",
	Slot = 1,
	Texts = {
		Topic = " "
	}
}

-- Second
QuestNPC = 799	-- Loretta Fleise
Quest{
	Name = "MM6_Promo_MasterDruid",
	Branch = "",
	Slot = 2,
	CheckDone = false,
	Quest = 1143,
	CanShow = function() return Party.QBits[1277] end,
	Texts = {
		Topic = TXT.master_druids,
		Give = Game.NPCText[1793],
		Undone = Game.NPCText[1795]
	}
}
Quest{
	Name = "MM6_Promo_MasterDruid_5",
	Branch = "",
	Slot = 2,
	CanShow = function() return Party.QBits[1278] end,
	Texts = {
		Topic = TXT.master_druids,
		Ungive = Game.NPCText[1795],
		Greet = Game.NPCText[1796]
	}
}

QuestNPC = 1091	-- Loretta Fleise

Quest{
	Name = "MM6_Promo_MasterDruid_0",
	BaseName = "MM6_Promo_MasterDruid",
	Branch = "",
	Slot = 0,
	Quest = 1143,
	Exp = 40000,
	Done = function()
		Party.QBits[1278] = true
		Party.QBits[1198] = true
		evt[0].Add("Reputation", -100)
		MF.ShowAwardAnimation()
	end,
	Texts = {
		Topic = Game.NPCTopic[1679],
		Done = Game.NPCText[1794]
	}
}
mm6_generate_promo_quests({QuestNPC = 1091, Name = "MasterDruid", Slot = 0,
	QBit = 1278, Greet = 1794, Maturity = 2, Exp = MM.MM6Promo2ExpReward})

Quest{
	Name = "MM6_Promo_MasterDruid_4",
	Branch = "",
	Slot = 1,
	Texts = {
		Topic = " "
	}
}

--------------------------------------------
---- Enroth Paladin promotion
QuestNPC = 789	-- Wilbur Humphrey
-- First
Quest{
	Name = "MM6_Promo_Crusader",
	Branch = "",
	Slot = 1,
	Quest = 1112,
	Exp = 15000,
	CheckDone = function()
		return NPCFollowers.NPCInGroup(796)
	end,
	Done = function()
		evt[0].Add("Reputation", -50)
		Party.QBits[1269] = true
		NPCFollowers.Remove(796)
	end,
	Texts = {
		Topic = Game.NPCTopic[1326],
		Give = Game.NPCText[1711],
		Undone = Game.NPCText[1712],
		Done = Game.NPCText[1713]
	}
}
mm6_generate_promo_quests({QuestNPC = 789, Name = "Crusader", Slot = 1,
	QBit = 1269, Maturity = 1, Exp = MM.MM6Promo1ExpReward})

-- Second
Quest{
	Name = "MM6_Promo_Justiciar",
	Branch = "",
	Slot = 2,
	Quest = 1112,
	Exp = 30000,
	QuestItem = 2075,
	CanShow = function() return Party.QBits[1269] end,
	Done = function()
		evt[0].Add("Reputation", -100)
		Party.QBits[1270] = true
	end,
	Texts = {
		Topic = TXT.justiciars,
		Give = Game.NPCText[1714],
		Undone = Game.NPCText[1715],
		Done = Game.NPCText[1716]
	}
}
mm6_generate_promo_quests({QuestNPC = 789, Name = "Justiciar", Slot = 2,
	QBit = 1270, Greet = 1717, Maturity = 2, Exp = MM.MM6Promo2ExpReward})

-- Pearl of Purity
Game.GlobalEvtLines:RemoveEvent(1652)
evt.global[1652] = function()
	evt.SetMessage{Str = 2055}         --[[
		"In my flight, I managed to hide the Pearl of Purity in these caverns.
		The pearl will both protect you from the curse of the werewolves, and will
		also destroy the Altar of the Wolf if the pearl touches it.  That should
		free everyone afflicted by the curse these werewolves have caused.  The
		pearl is at the end of the cavern across from this one.  Please do me one
		favor, return the Pearl to Wilbur Humphrey.  He is the lord in charge of
		paladins and the pearl belongs with him."
		]]
	evt.Add{"QBits", Value = 1166}         -- NPC
end

Quest{
	Name = "MM6_PearlOfPurity",
	Branch = "",
	Slot = 3,
	Quest = 1166,
	QuestItem = 2079,
	Exp = 10000,
	NeverGiven = true,
	CanShow = function() return Party.QBits[1166] end,
	Texts = {
		Topic = Game.NPCTopic[1655],
		Undone = Game.NPCText[2092],
		Done = Game.NPCText[2059]
	}
}

--------------------------------------------
---- 		JADAME PROMOTIONS			----
--------------------------------------------

--------------------------------------------
---- Jadame Sorcerer promotion
Quest{
	NPC = 62, -- Lathean
	Branch = "",
	Slot = 3,
	CanShow 	= function() return evt.ForPlayer("All").Cmp{"ClassIs", CC.Sorcerer}
					or evt.ForPlayer("All").Cmp{"ClassIs", CC.Wizard}
					or evt.ForPlayer("All").Cmp{"ClassIs", CC.Peasant}
			end,
	CheckDone 	= function(t)	Message(t.Texts.Undone)
								return evt.Subtract{"Gold", 10000}	end,
	Done		= function() 
			Promote({CC.Sorcerer, CC.Wizard, CC.Peasant},
					CC.Necromancer,
					{Experience = 15000}, {Experience = 5000})
		end,
	After		= function()
			Promote({CC.Sorcerer, CC.Wizard, CC.Peasant},
					CC.Necromancer, {Experience = 15000})
		end,
	Texts = {	Topic 	= Game.NPCText[2699], -- "Join guild"
				Give 	= Game.NPCText[2700], -- "Well, sorcerers among you seeking for power of dark arts? Pay 10000 bill and step into our chambers."
				Undone	= Game.NPCText[2701], -- "We will not allow any rambler to sneak here. Pay and study or scram!"
				Done	= Game.NPCText[2702], -- "Perfect! Now i call all sorcerers among you necromancers, don't pretend to be good anymore."
				After	= Game.NPCText[2703]} -- "Welcome, necromancers."
	}

--------------------------------------------
---- Jadame Necromancer promotion
QuestNPC = 61	-- Vetrinus Taleshire

Quest{
	Name = "MM8_Promo_MasterNecromancer_1",
	Branch = "",
	Slot = 1,
	Quest = 82,
	QuestItem = 611,
	Exp = 25000,
	Done = function()
		Party.QBits[83] = true
		evt.All.Add("Awards", 35)	-- "Found the Lost Book of Khel."
		evt.SetNPCTopic(61, 0, 742)	-- "Vetrinus Taleshire" : "Travel with you!"
	end,
	Texts = {
		Topic = Game.NPCTopic[86],
		Give = Game.NPCText[113],
		Undone = Game.NPCText[115]
	}
}
mm8_generate_promo_quests({QuestNPC = 61, Name = "MasterNecromancer", Seq = 1, Slot = 1,
	Slot2 = 1, QBit = 83, RaceFamily = const.RaceFamily.Undead, Maturity = 2,
	Exp = 10000})
Quest{
	Name = "MM8_Promo_MasterNecromancer_1_4",
	Branch = "masternecromancer",
	Slot = 0,
	Ungive = function()
		local k = MF.GetCurrentPlayer() or 0
		local player = Party[k]
		evt.ForPlayer(k)
		local new_race = can_convert_to_undead(player)
		if new_race == 0 then
			promote_class({Class = CC.MasterNecromancer,
				Award = CPA["JadamePowerLich"],
				Race = player.Attrs.Race, Maturity = 2, Exp = 10000})
			return
		end
		if new_race > 0 then
			if not table.find(MT.ClassPromotionsInv[CC.MasterNecromancer] or {}, player.Class)
					and not player.Class == CC.MasterNecromancer then
				Message(strformat(TXT.cannot_be_promoted,
					Game.ClassNames[player.Class],
					GetClassName({ClassId = CC.MasterNecromancer,
						RaceId = const.Race.UndeadHuman})))
				return
			end
			if not evt.Cmp("Inventory", 628) then	-- "Lich Jar"
				Message(Game.NPCText[114])
				return
			end
			if not promote_class({Class = CC.MasterNecromancer,
					Award = CPA["JadamePowerLich"],
					Race = new_race, Maturity = 2, Exp = 10000,
					SameClass = true}) then
				return
			end
			Message(Game.NPCText[116])
			evt.Subtract("Inventory", 628)	-- "Lich Jar"
			SetLichAppearance(k, player)
		else
			Message(strformat(TXT.cannot_be_converted_to_undead,
				Game.Races[player.Attrs.Race].Name))
		end
	end,
	Texts = {
		Topic = strformat(TXT.promote_to,
			GetClassName({ClassId = CC.MasterNecromancer,
				RaceId = const.Race.UndeadHuman}))
	}
}
--[=[
-- Promotion to Lich
Game.GlobalEvtLines:RemoveEvent(89)
-- FIXME: not updated on-the-fly
--[[
evt.CanShowTopic[89] = function()
	local k = max(Game.CurrentPlayer, 0)
	local player = Party[k]
	return table.find(MT.ClassPromotionsInv[const.Class.MasterNecromancer], player.Class) and true or false
end
]]
evt.Global[89] = function()
	if not Party.QBits[83] then
		evt.SetMessage{Str = 115}	--[[
				"You do not have the Lost Book of Khel!  I cannot help you, if you
				do not help me!  Return here with the Book and a Lich Jar for each
				necromancer in your party that wishes to become a Lich!"
				]]
		return
	end
	local k = max(Game.CurrentPlayer, 0)
	local player = Party[k]
	evt.ForPlayer(k)
	if not (table.find(MT.ClassPromotionsInv[const.Class.MasterNecromancer], player.Class)
			or player.Class == const.Class.MasterNecromancer) then
		-- FIXME: show message
		return
	end
	if table.find(MT.ClassPromotionsInv[const.Class.MasterNecromancer], player.Class)
			and not evt.Cmp{"Inventory", Value = 628} then	-- "Lich Jar"
		evt.SetMessage{Str = 114}	--[[
				"You have the Lost Book of Khel, however you lack the Lich Jars
				needed to complete the transformation!  Return here when you have
				one for each necromancer in your party!"
				]]
		return
	end
	if table.find(MT.ClassPromotionsInv[const.Class.MasterNecromancer], player.Class) then
		evt.SetMessage{116}	--[[
			"You have brought everything needed to perform the transformation!
			So be it!  All necromancer’s in your party will be transformed into
			Liches!  May the dark energies flow through them for all eternity!
			The rest of you will gain what knowledge I can teach them as reward
			for their assistance!  Lets begin!After we have completed, good
			friend Lathean can handle any future promotions for your party."
			]]
		player.Class = const.Class.MasterNecromancer
		evt.Add{"Experience", 10000}
		Party.QBits[1548] = true	-- Promoted to Lich.
		evt.Subtract{"Inventory", Value = 628}	-- "Lich Jar"
		SetLichAppearance(k, player)
		player.Attrs.PromoAwards[CPA.JadameLich] = true
	elseif player.Class == const.Class.MasterNecromancer
			and Game.Races[player.Attrs.Race].Family ~= const.RaceFamily.Undead
			and Game.Races[player.Attrs.Race].Family ~= const.RaceFamily.Ghost then
		if evt.Cmp{"Inventory", Value = 628} then	-- "Lich Jar"
			-- FIXME: show proper text
			evt.Add{"Experience", 5000}
			Party.QBits[1548] = true	-- Promoted to Lich.
			evt.Subtract{"Inventory", Value = 628}	-- "Lich Jar"
			SetLichAppearance(k, player)
			player.Attrs.PromoAwards[CPA.JadameLich] = true
		else
			-- FIXME: use proper text
			evt.SetMessage{114}	--[[
				"You have the Lost Book of Khel, however you lack the Lich Jars
				needed to complete the transformation!  Return here when you have
				one for each necromancer in your party!"
				]]
		end
	end
end

-- Promotion to Master Necromancer
-- FIXME: not updated on-the-fly
--[[
evt.CanShowTopic[1796] = function()
	local k = max(Game.CurrentPlayer, 0)
	local player = Party[k]
	return table.find(MT.ClassPromotionsInv[const.Class.MasterNecromancer], player.Class) and true or false
end
]]
evt.Global[1796] = function()
	if not Party.QBits[83] then
		evt.SetMessage{Str = 115}	--[[
				"You do not have the Lost Book of Khel!  I cannot help you, if you
				do not help me!  Return here with the Book and a Lich Jar for each
				necromancer in your party that wishes to become a Lich!"
				]]
		return
	end
	local k = max(Game.CurrentPlayer, 0)
	local player = Party[k]
	evt.ForPlayer(k)
	if not table.find(MT.ClassPromotionsInv[const.Class.MasterNecromancer], player.Class) then
		-- FIXME: show message
		return
	end
	if MS.Promotions.LichJarForMasterNecromancer == 2 then
		if not evt.Cmp{"Inventory", Value = 628} then	-- "Lich Jar"
			-- FIXME: use proper text
			evt.SetMessage{Str = 114}	--[[
				"You have the Lost Book of Khel, however you lack the Lich Jars
				needed to complete the transformation!  Return here when you have
				one for each necromancer in your party!"
				]]
			return
		else
			Party.QBits[1548] = true	-- Promoted to Lich.
			evt.Subtract{"Inventory", Value = 628}	-- "Lich Jar"
		end
	elseif MS.Promotions.LichJarForMasterNecromancer == 1
			and not Party.QBits[1548] then
		if not evt.Cmp{"Inventory", Value = 628} then	-- "Lich Jar"
			-- FIXME: use proper text
			evt.SetMessage{Str = 114}	--[[
				"You have the Lost Book of Khel, however you lack the Lich Jars
				needed to complete the transformation!  Return here when you have
				one for each necromancer in your party!"
				]]
			return
		else
			Party.QBits[1548] = true	-- Promoted to Lich.
			evt.Subtract{"Inventory", Value = 628}	-- "Lich Jar"
		end
	end
	player.Class = const.Class.MasterNecromancer
	evt.Add{"Experience", 5000}
	player.Attrs.PromoAwards[CPA.JadameMasterNecromancer] = true
	-- TODO: update undead races
end
]=]

QuestNPC = 62	-- Lathean

Quest{
	Name = "MM8_Promo_MasterNecromancer_2",
	Branch = "",
	Slot = 2,
	Texts = {
		Topic = Game.NPCTopic[738],
		Ungive = Game.NPCText[924]
	}
}
mm8_generate_promo_quests({QuestNPC = 62, Name = "MasterNecromancer", Seq = 2, Slot = 2,
	Slot2 = 1, QBit = 83, Ungive = 925,
	RaceFamily = const.RaceFamily.Undead, Maturity = 2, Exp = 10000})
Quest{
	Name = "MM8_Promo_MasterNecromancer_2_4",
	Branch = "masternecromancer",
	Slot = 0,
	Ungive = function()
		local k = MF.GetCurrentPlayer() or 0
		local player = Party[k]
		evt.ForPlayer(k)
		local new_race = can_convert_to_undead(player)
		if new_race == 0 then
			promote_class({Class = CC.MasterNecromancer,
				Award = CPA["JadamePowerLich"],
				Race = player.Attrs.Race, Maturity = 2, Exp = 10000})
			return
		end
		if new_race > 0 then
			if not table.find(MT.ClassPromotionsInv[CC.MasterNecromancer] or {}, player.Class)
					and not player.Class == CC.MasterNecromancer then
				Message(strformat(TXT.cannot_be_promoted,
					Game.ClassNames[player.Class],
					GetClassName({ClassId = CC.MasterNecromancer,
						RaceId = const.Race.UndeadHuman})))
				return
			end
			if not evt.Cmp("Inventory", 628) then	-- "Lich Jar"
				Message(Game.NPCText[114])
				return
			end
			if not promote_class({Class = CC.MasterNecromancer,
					Award = CPA["JadamePowerLich"],
					Race = new_race, Maturity = 2, Exp = 10000,
					SameClass = true}) then
				return
			end
			--Message(Game.NPCText[116])
			evt.Subtract("Inventory", 628)	-- "Lich Jar"
			SetLichAppearance(k, player)
		else
			Message(strformat(TXT.cannot_be_converted_to_undead,
				Game.Races[player.Attrs.Race].Name))
		end
	end,
	Texts = {
		Topic = strformat(TXT.promote_to,
			GetClassName({ClassId = CC.MasterNecromancer,
				RaceId = const.Race.UndeadHuman}))
	}
}

--[=[
evt.Global[738] = function()
	if not Party.QBits[83] then
		evt.SetMessage{Str = 924}]]	--[[
				"You have not recovered the Lost Book of Kehl!  There will be no promotions
				until you return with the book!  Speak with Vetrinus Taleshire."
				]]
		return
	end
	local k = max(Game.CurrentPlayer, 0)
	local player = Party[k]
	evt.ForPlayer(k)
	if not (table.find(MT.ClassPromotionsInv[const.Class.MasterNecromancer], player.Class)
			or player.Class == const.Class.MasterNecromancer) then
		-- FIXME: show message
		return
	end
	if table.find(MT.ClassPromotionsInv[const.Class.MasterNecromancer], player.Class)
			and not evt.Cmp{"Inventory", Value = 628} then	-- "Lich Jar"
		evt.SetMessage{Str = 114}]]	--[[
				"You have the Lost Book of Khel, however you lack the Lich Jars
				needed to complete the transformation!  Return here when you have
				one for each necromancer in your party!"
				]]
		return
	end
	if table.find(MT.ClassPromotionsInv[const.Class.MasterNecromancer], player.Class) then
		evt.SetMessage{925}]]	--[[
			"Ah, you return seeking promotion for others in your party?
			I have not forgotten your help in recovering the Lost Book of Kehl!
			All Necromancers in your party will be promoted to Lich.  Be sure
			each Necromancer has a Lich Jar in his possession."
			]]
		player.Class = const.Class.MasterNecromancer
		evt.Add{"Experience", 10000}
		Party.QBits[1548] = true	-- Promoted to Lich.
		evt.Subtract{"Inventory", Value = 628}	-- "Lich Jar"
		SetLichAppearance(k, player)
		player.Attrs.PromoAwards[CPA.JadameLich] = true
	elseif player.Class == const.Class.MasterNecromancer
			and Game.Races[player.Attrs.Race].Family ~= const.RaceFamily.Undead
			and Game.Races[player.Attrs.Race].Family ~= const.RaceFamily.Ghost then
		if evt.Cmp{"Inventory", Value = 628} then	-- "Lich Jar"
			-- FIXME: show proper text
			evt.Add{"Experience", 5000}
			Party.QBits[1548] = true	-- Promoted to Lich.
			evt.Subtract{"Inventory", Value = 628}	-- "Lich Jar"
			SetLichAppearance(k, player)
			player.Attrs.PromoAwards[CPA.JadameLich] = true
		else
			-- FIXME: use proper text
			evt.SetMessage{114}]]	--[[
				"You have the Lost Book of Khel, however you lack the Lich Jars
				needed to complete the transformation!  Return here when you have
				one for each necromancer in your party!"
				]]
		end
	end
end
]=]

--------------------------------------------
---- Jadame Cleric/Priest promotion
QuestNPC = 59	-- Stephen

Quest{
	Name = "MM8_Promo_PriestLight_1",
	Branch = "",
	Slot = 1,
	Quest = 78,
	QuestItem = 626,
	Exp = 25000,
	Done = function()
		Party.QBits[79] = true
		evt.All.Add("Awards", 31)
	end,
	Texts = {
		Topic = Game.NPCTopic[78],
		Give = Game.NPCText[105],
		Undone = Game.NPCText[106],
		Done = Game.NPCText[107]
	}
}
mm8_generate_promo_quests({QuestNPC = 59, Name = "PriestLight", Seq = 1, Slot = 1,
	QBit = 79, From = {CC.Cleric, CC.Priest, CC.ClericLight},
	Ungive = 923, Race = const.Race.Human, Maturity = 2, Exp = 10000})
Quest{
	Name = "MM8_Promo_PriestLight_1_4",
	Branch = "",
	Slot = 0,
	CanShow = function() return Party.QBits[78] end,
	Texts = {
		Topic = Game.NPCTopic[76],
		Ungive = Game.NPCText[119]
	}
}
Quest{
	Name = "MM8_Promo_PriestLight_1_5",
	Branch = "",
	Slot = 2,
	CanShow = function() return Party.QBits[78] end,
	Texts = {
		Topic = Game.NPCTopic[77],
		Ungive = Game.NPCText[104]
	}
}
Quest{
	Name = "MM8_Promo_PriestLight_1_6",
	Branch = "",
	Slot = 3,
	CanShow = function() return Party.QBits[78] end,
	Texts = {
		Topic = Game.NPCTopic[79],
		Ungive = Game.NPCText[118]
	}
}
--[=[
-- "Quest"
Game.GlobalEvtLines:RemoveEvent(81)
--evt.CanShowTopic[81] = function()
--	return evt.Cmp{"Inventory", Value = 626}	-- "Prophecies of the Sun"
--end

evt.Global[81] = function()
	evt.ForPlayer("All")
	if not evt.Cmp{"Inventory", Value = 626} then	-- "Prophecies of the Sun"
		evt.SetMessage{106}	-- "Have you found this Lair of the Feathered Serpent and the Prophecies of the Sun?  Do not waste my time!  The world is ending and you waste time with useless conversation!  Return to me when you have found the Prophecies and have taken them to the Temple of the Sun."
		return
	end
	evt.SetMessage{107}	-- "You have found the lost Prophecies of the Sun?  May the Light forever shine upon you and may the Prophet guide your steps.  With these we may be able to find the answer to what has befallen Jadame! "
	evt.Add{"Experience", 25000}
	evt.Add{"Awards", 31}	-- "Found the lost Prophecies of the Sun and returned them to the Temple of the Sun."
	evt.Subtract{"Inventory", 626}	-- "Prophecies of the Sun"
	Party.QBits[79] = true
	Party.QBits[78] = false	-- "Find the Prophecies of the Sun in the Abandoned Temple  and take them to Stephen."
	Game.NPC[59].EventB = 1798	-- Stephen : Promotion to Honorary Priest of the Light
	Game.NPC[59].EventC = 0	-- remove "Quest" topic
	Game.NPC[59].EventD = 0	-- remove "Prophecies of the Sun" topic
	Game.NPC[59].EventE = 0	-- remove "Clues" topic
	evt.SetNPCTopic{NPC = 59, Index = 0, Event = 737}	-- "Stephen" : "Promote Clerics"
end

-- FIXME: change NPCTopic
-- "Promote Clerics"
Game.GlobalEvtLines:RemoveEvent(737)
evt.Global[737] = function()
	if not Party.QBits[79] then
		evt.SetMessage{922}	-- "You cannot be promoted to Priest of the Sun until you have recovered the Prophecies of the Sun!"
		return
	end
	evt.SetMessage{923}	-- "You are always welcome here!  Of course I will promote any Clerics that travel with you to Priest of the Sun!  "
	local k = max(Game.CurrentPlayer, 0)
	local player = Party[k]
	evt.ForPlayer(k)
	-- FIXME: use MT.ClassPromotionsInv
	if table.find({const.Class.Cleric, const.Class.Priest, const.Class.ClericLight}, player.Class) then
		player.Class = const.Class.PriestLight
		evt.Add{"Experience", 10000}
		player.Attrs.PromoAwards[CPA.JadamePriestLight] = true
		Party.QBits[1546] = true	-- Promoted to Cleric of the Sun. // Actually Priest of the Light
		if MS.Races.MaxMaturity > 0
				and player.Attrs.Race == const.Race.Human then
			-- FIXME
			player.Attrs.Maturity = min(2, MS.Races.MaxMaturity)
		end
	end
end
]=]

--------------------------------------------
---- Jadame Dark Elf promotion
QuestNPC = 42	-- Cauri Blackthorne

-- "Thank you!"
Game.GlobalEvtLines:RemoveEvent(24)
evt.Global[24] = function()
	evt.SetMessage{26}	--[[
		"Thank you for your assistance with the Basilisk Curse.  Usually I am
		prepared to handle the vile lizards, but this time there were just too
		many of them.The Temple of the Sun asked me to check on a few pilgrims
		that were looking for the Druid Circle of Stone in this area.  When I
		found the first statue, I realized what had happened to the pilgrims.
		I myself did not know of the increase in the number of Basilisks in this
		area.  They seem to be agitated by something.  I was going to investigate
		the Druid Circle of Stone when the Basilisks attacked me."
		]]
	-- See out07.lua, evt.Map[132]
	--[[
	evt.ForPlayer("All")
	evt.Add{"Experience", 25000}
	evt.Add{"Awards", 20}	-- "Rescued Cauri Blackthorne."
	Party.QBits[39] = false	-- "Find Cauri Blackthorne then return to Dantillion in Murmurwoods with information of her location."
	Party.QBits[40] = true	-- Found and Rescued Cauri Blackthorne
	Party.QBits[430] = true	-- Roster Character In Party 31
	Game.NPC[42].EventB = 25	-- Cauri Blackthorne : Promotion to Patriarch
	Game.NPC[42].EventC = 1799	-- Cauri Blackthorne : Promotion to Honorary Patriarch
	Game.NPC[39].EventD = 1799	-- Relburn Jeebes : Promotion to Honorary Patriarch
	]]
	evt.SetNPCTopic{NPC = 42, Index = 0, Event = 38}	-- "Cauri Blackthorne" : "Thanks for your help!"
end

mm8_generate_promo_quests({QuestNPC = 42, Name = "Patriarch", Seq = 1, Slot = 1,
	QBit = 40, Ungive = 27, Race = const.Race.DarkElf, Maturity = 2, Exp = 10000})

QuestNPC = 39	-- Relburn Jeebes

Quest{
	Name = "MM8_Promo_Patriarch_2",
	Branch = "",
	Slot = 2,
	CanShow = function() return Party.QBits[39] end,
	Texts = {
		Topic = Game.NPCTopic[733],
		Ungive = Game.NPCText[914]
	}
}
mm8_generate_promo_quests({QuestNPC = 39, Name = "Patriarch", Seq = 2, Slot = 2,
	QBit = 40, Ungive = 915, Race = const.Race.DarkElf, Maturity = 2, Exp = 10000})
-- Hide EventC
Quest{
	Name = "MM8_Promo_Patriarch_2_4",
	Branch = "patriarch",
	Slot = 2,
}

--------------------------------------------
---- Jadame Dragon promotion
QuestNPC = 17	-- Deftclaw Redreaver

Quest{
	Name = "MM8_Promo_GreatWyrm_1",
	Branch = "",
	Slot = 1,
	Quest = 74,
	QuestItem = 540,
	Exp = 25000,
	Give = function()
		if Party.QBits[21] then
			Message(Game.NPCText[76])
		else
			Message(Game.NPCText[75])
		end
	end,
	Undone = function()
		if Party.QBits[75] then
			Message(Game.NPCText[81])
		elseif Party.QBits[22] then
			Message(Game.NPCText[77])
		elseif Party.QBits[21] then
			Message(Game.NPCText[78])
		else
			Message(Game.NPCText[86])
		end
	end,
	Done = function()
		Party.QBits[86] = true
		if Party.QBits[21] then
			Message(Game.NPCText[80])
		else
			Message(Game.NPCText[79])
		end
	end,
	Texts = {
		Topic = Game.NPCTopic[60],
		TopicGiven = Game.NPCTopic[62]
	}
}
mm8_generate_promo_quests({QuestNPC = 17, Name = "GreatWyrm", Seq = 1, Slot = 1,
	QBit = 86, Ungive = 921, Race = const.Race.Dragon, Maturity = 2, Exp = 10000})
--[=[
-- "Sword of the Slayer"
Game.GlobalEvtLines:RemoveEvent(62)
evt.CanShowTopic[62] = function()
	return Party.QBits[75]	-- Killed all Dragon Slayers in southwest encampment in Area 5
end

evt.Global[62] = function()
	evt.ForPlayer("All")
	if not evt.Cmp{"Inventory", 540} then	-- "Sword of Whistlebone"
		evt.SetMessage{81}	--[[
			"You have killed the Dragon Slayers, but where is the Sword
			of Whistlebone?  Return to me when you have it!"
			]]
		return
	end
	if Party.QBits[22]	-- Allied with Dragons. Return Dragon Egg to Dragons done.
			or not Party.QBits[21] then	-- Allied with Charles Quioxte's Dragon Hunters. Return Dragon Egg to Quixote done.
		evt.SetMessage{79}	--[[
			"You return to me with the sword of the Slayer, Whistlebone!
			You are indeed worthy of my notice!  The Dragons in your group are
			promoted to Great Wyrm!  I will teach the others of your group what
			skills I can as a reward for their assistance!"
			]]
	else
		evt.SetMessage{80}	--[[
			"You return to me with the sword of the Slayer, Whistlebone!
			Is there no end to the treachery that you will commit? Is there
			no one that you owe allegiance to?  I will promote those Dragons
			who travel with you to Great Wyrm, however they will never fly
			underneath me!  There rest of your traitorous group will be
			instructed in those skills which can be taught to them!  Go now!
			Never show your face here again, unless you want it eaten!"
			]]
	end
	evt.Add{"Experience", 25000}
	evt.Subtract{"Inventory", 540}	-- "Sword of Whistlebone"

	Party.QBits[86] = true
	Party.QBits[74] = false	-- "Kill all Dragon Slayers and return the Sword of Whistlebone the Slayer to Deftclaw Redreaver in Garrote Gorge."
	Game.NPC[17].EventD = 1800	-- Deftclaw Redreaver : Promotion to Honorary Great Wyrm
	evt.SetNPCTopic{NPC = 17, Index = 2, Event = 736}	-- "Deftclaw Redreaver" : "Promote Dragons"
end

-- "Promote Dragons"
Game.GlobalEvtLines:RemoveEvent(736)
evt.Global[736] = function()
	if not Party.QBits[86] then
		evt.SetMessage{920}	--[[
			"You have not proven yourself worthy!  Until you strike a blow against
			the Dragon Hunters, none of you will be promoted!"
			]]
		return
	end
	local k = max(Game.CurrentPlayer, 0)
	local player = Party[k]
	evt.ForPlayer(k)
	if not table.find(MT.ClassPromotionsInv[const.Class.GreatWyrm], player.Class) then
		-- FIXME: show message
		return
	end
	evt.SetMessage{921}	--[[
		"You have proven yourself and I will promote any Dragons that travel
		with you to Great Wyrm."
		]]
	player.Class = const.Class.GreatWyrm
	-- Note: in MM8 - experience award is only on bringing Sword of Whistlebone
	evt.Add{"Experience", Value = 10000}
	player.Attrs.PromoAwards[CPA.JadameGreatWyrm] = true
	if MS.Races.MaxMaturity > 0
			and player.Attrs.Race == const.Race.Dragon then
		-- FIXME
		player.Attrs.Maturity = min(2, MS.Races.MaxMaturity)
	end
	Party.QBits[1543] = true	-- Promoted to Great Wyrm.
end
]=]

--------------------------------------------
---- Jadame Knight/Cavalier promotion
QuestNPC = 15

Quest{
	Name = "MM8_Promo_Champion_1",
	Branch = "",
	Slot = 1,
	Quest = 70,
	QuestItem = 539,
	Exp = 35000,
	NeverGiven = true,
	CanShow = function() return Party.QBits[73] end,
	Done = function()
		Party.QBits[71] = true
		if Party.QBits[22] then
			Message(Game.NPCText[71])
		else
			Message(Game.NPCText[70])
		end
	end,
	Texts = {
		Topic = Game.NPCTopic[58],
		Undone = Game.NPCText[85]
	}
}
mm8_generate_promo_quests({QuestNPC = 15, Name = "Champion", Seq = 1, Slot = 1,
	QBit = 71, Ungive = 919, From = {CC.Knight, CC.Cavalier},
	Race = const.Race.Human, Maturity = 2, Exp = 15000})
Quest{
	Name = "MM8_Promo_Champion_1_4",
	Branch = "",
	Slot = 2,
	CanShow = function() return not Party.QBits[71] end,
	Texts = {
		Topic = Game.NPCTopic[56],
		Ungive = Game.NPCText[66]
	}
}
Quest{
	Name = "MM8_Promo_Champion_1_5",
	Branch = "",
	Slot = 3,
	CanShow = function() return not Party.QBits[71] end,
	Texts = {
		Topic = Game.NPCTopic[57],
		Ungive = Game.NPCText[67]
	}
}
--[=[
-- "Promotion to Champion"
Game.GlobalEvtLines:RemoveEvent(58)
evt.CanShowTopic[58] = function()
	return Party.QBits[73]	-- Received Cure for Blazen Stormlance
end

evt.Global[58] = function()
	evt.ForPlayer("All")
	if not evt.Cmp{"Inventory", 539} then	-- "Ebonest"
		evt.SetMessage{85}	--[[
			"You have found Blazen Stormlance? But where is Ebonest?
			Return to me when you have the spear and you will be promoted!"
			]]
		return
	end
	if Party.QBits[22] then	-- Allied with Dragons. Return Dragon Egg to Dragons done.
		evt.SetMessage{71}	--[[
			"What is this?  You ally with my mortal enemies and then seek
			to do me a favor?I wonder what the Dragons think of this. But so
			be it.  I am in your debt for returning Ebonest to me.  I will
			promote any Knights in your party to Champion, however they will
			never be accepted in my service.  The rest I will teach what I can.
			I do not wish to see you again!"
			]]
	else
		evt.SetMessage{70}	--[[
			"You found Blazen Stormlance?  What about MY spear Ebonest?  You
			have that as well?FANTASTIC!I thank you for this and find myself
			in your debt!  I will promote all knights in your party to
			Champion and teach what skills I can to the rest of your party. "
			]]
	end
	evt.Add{"Experience", 35000}
	evt.Subtract{"Inventory", 539}	-- "Ebonest"
	Party.QBits[71] = true
	Party.QBits[70] = false	-- "Find Blazen Stormlance and recover the spear Ebonest. Return to Leane Stormlance in Garrote Gorge and deliver Ebonest to Charles Quixote."
	Game.NPC[15].EventD = 1801	-- Sir Charles Quixote : Promotion to Honorary Champion
	evt.SetNPCTopic{NPC = 15, Index = 2, Event = 735}	-- "Sir Charles Quixote" : "Promote Knights"
end
]=]
QuestNPC = 51	-- Garret Deverro
mm8_generate_promo_quests({QuestNPC = 51, Name = "Champion", Seq = 2, Slot = 0,
	QBit = 71, Ungive = 919, From = {CC.Knight, CC.Cavalier},
	Race = const.Race.Human, Maturity = 2, Exp = 15000})
--[=[
-- "Promote Knights"
Game.GlobalEvtLines:RemoveEvent(735)
evt.Global[735] = function()
	if not Party.QBits[71] then
		evt.SetMessage{918}	--[[
			"You cannot be promoted to Champion until you have proven yourself worthy!  "
			]]
		return
	end
	local k = max(Game.CurrentPlayer, 0)
	local player = Party[k]
	evt.ForPlayer(k)
	if not table.find({const.Class.Knight, const.Class.Cavalier}, player.Class) then
		-- FIXME: show message
		return
	end
	evt.SetMessage{919}	--[[
		"Thanks for you help recovering the spear Ebonest!  I can promote
		any Knights that travel with you to Champion."
		]]
	player.Class = const.Class.Champion
	-- Note: in MM8 - experience award is only on bringing Ebonest
	evt.Add{"Experience", Value = 15000}
	player.Attrs.PromoAwards[CPA.JadameChampion] = true
	if MS.Races.MaxMaturity > 0
			and player.Attrs.Race == const.Race.Human then
		-- FIXME
		player.Attrs.Maturity = min(2, MS.Races.MaxMaturity)
	end
	Party.QBits[1540] = true	-- Promoted to Champion.
end
]=]

--------------------------------------------
---- Jadame Minotaur promotion
QuestNPC = 58	-- Tessalar

Quest{
	Name = "MM8_Promo_MinotaurLord_1",
	Branch = "",
	Slot = 0,
	Quest = 76,
	QuestItem = {541, 732},
	Exp = 25000,
	Undone = function()
		if not evt.Cmp("Inventory", 541) then
			Message(Game.NPCText[98])
		else
			Message(Game.NPCText[94])
		end
	end,
	Done = function()
		Party.QBits[77] = true	-- Found the Axe of Balthazar.
		Message(Game.NPCText[95])
		evt.All.Add("Awards", 29)	-- "Recovered Axe of Balthazar."
	end,
	Texts = {
		Topic = Game.NPCTopic[69],
		TopicGiven = Game.NPCTopic[73],	-- Used by Dadeross
		Give = Game.NPCText[92],
	}
}
mm8_generate_promo_quests({QuestNPC = 58, Name = "MinotaurLord", Seq = 1, Slot = 0,
	QBit = 77, Ungive = 929, Race = const.Race.Minotaur, Maturity = 2, Exp = 10000})
--[=[
-- "Quest"
Game.GlobalEvtLines:RemoveEvent(71)
-- Don't hide Quest topic
--[[
evt.CanShowTopic[71] = function()
	return evt.Cmp{"Inventory", 732}	-- "Certificate of Authentication"
end
]]

evt.Global[71] = function()
	evt.ForPlayer("All")
	if not evt.Cmp{"Inventory", 541} then	-- "Axe of Balthazar"
		evt.SetMessage{98}	--[[
			"Where is Balthazar's Axe?  You waste my time!
			Find the axe, find Dadeross and return to me!"
			]]
		return
	end
	if not evt.Cmp{"Inventory", 732} then	-- "Certificate of Authentication"
		evt.SetMessage{94}	--[[
			"You have found the Axe of Balthazar!  Have you presented it
			to Dadeross?  Without his authentication, we can not proceed
			with the Rite’s of Purity!  Find him and return to us once
			you have presented him with the axe!"
			]]
		return
	end
	evt.SetMessage{95}	--[[
		"You have found the Axe of Balthazar!  Have you presented it to
		Dadeross? Ah, you have authentication from Dadeross!  The Rite’s
		of Purity will begin immediately! You proven yourselves worthy, and
		our now members of our herd!  The Minotaurs who travel with you are
		promoted to Minotaur Lord.  The others in your group will be taught
		what skills we have that maybe useful to them."
		]]
	evt.Add{"Experience", 25000}
	evt.Add{"Awards", 29}	-- "Recovered Axe of Balthazar."
	Party.QBits[76] = false	-- "Find the Axe of Balthazar, in the Dark Dwarf Mines.  Have the Axe authenticated by Dadeross.  Return the axe to Tessalar, heir to the leadership of the Minotaur Herd."
	Party.QBits[77] = true	-- Found the Axe of Balthazar.
	evt.Subtract{"Inventory", 541}	-- "Axe of Balthazar"
	evt.Subtract{"Inventory", 732}	-- "Certificate of Authentication"
	Game.NPC[58].EventB = 1802	-- Tessalar : Promotion to Honorary Minotaur Lord
	Game.NPC[58].EventC = 70	-- Tessalar : Dark Dwarves
	evt.SetNPCTopic{NPC = 58, Index = 0, Event = 740}         -- "Tessalar" : "Promote Minotuars"
end

-- "Hurry!"
Game.GlobalEvtLines:RemoveEvent(75)
evt.Global[75] = function()
	if Party.QBits[77] then	-- Found the Axe of Balthazar.
		evt.SetMessage{102}	--[[
			"Ah, you returned Balthazar's Axe with my certificate to
			Tessalar!  The Rites of Purity have begun.  Soon Lord Masul
			will wield his father's axe as his own!  Greatness will
			return to my herd!"
			]]
	else
		evt.SetMessage{101}	--[[
			"You have found Balthazar's Axe and I have authenticated it!
			Hurry back to Tessalar so that the Rites of Purity may begin!"
			]]
	end
end

-- "Promote Minotuars"
Game.GlobalEvtLines:RemoveEvent(740)
evt.Global[740] = function()
	if not Party.QBits[77] then	-- Found the Axe of Balthazar.
		evt.SetMessage{928}	--[[
			"You have not found the Axe of Balthazar!
			You are not worthy of promotion!"
			]]
		return
	end
	local k = max(Game.CurrentPlayer, 0)
	local player = Party[k]
	evt.ForPlayer(k)
	if not table.find(MT.ClassPromotionsInv[const.Class.MinotaurLord], player.Class) then
		-- FIXME: show message
		return
	end
	evt.SetMessage{929}	--[[
		"The Herd of Masul is in debt to you.  Any Minotaurs
		in your party are promoted to Minotaur Lord!"
		]]
	player.Class = const.Class.MinotaurLord
	-- Note: in MM8 - experience award is only on bringing Axe of Balthazar
	evt.Add{"Experience", Value = 10000}
	player.Attrs.PromoAwards[CPA.JadameMinotaurLord] = true
	if MS.Races.MaxMaturity > 0
			and player.Attrs.Race == const.Race.Minotaur then
		-- FIXME
		player.Attrs.Maturity = min(2, MS.Races.MaxMaturity)
	end
	Party.QBits[1545] = true	-- Promoted to Minotaur Lord.
end

-- Promotion to Honorary Minotaur Lord
evt.Global[1802] = function()
	if not Party.QBits[77] then	-- Found the Axe of Balthazar.
		return
	end
	local k = max(Game.CurrentPlayer, 0)
	local player = Party[k]
	evt.ForPlayer(k)
	if not (player.Attrs.PromoAwards[CPA.JadameMinotaurLord]
			or player.Attrs.PromoAwards[CPA.JadameHonoraryMinotaurLord]) then
		evt.Add{"Experience", 0}
		player.Attrs.PromoAwards[CPA.JadameHonoraryMinotaurLord] = true
	end
	if MS.Races.MaxMaturity > 0
			and player.Attrs.Race == const.Race.Minotaur then
		-- FIXME
		player.Attrs.Maturity = min(2, MS.Races.MaxMaturity)
	end
end
]=]

--------------------------------------------
---- Jadame Berserker/Troll promotion
QuestNPC = 43	-- Volog Sandwind

Quest{
	Name = "MM8_Promo_Berserker_1",
	Branch = "",
	Slot = 1,
	Quest = 68,
	Exp = 25000,
	CheckDone = function() return Party.QBits[69] end,
	Done = function()
		Party.QBits[87] = true
		evt.SetNPCTopic(43, 0, 612)	-- "Volog Sandwind" : "Roster Join Event"
	end,
	Texts = {
		Topic = Game.NPCTopic[35],
		Give = Game.NPCText[43],
		Undone = Game.NPCText[49],
		Done = Game.NPCText[45]
	}
}
Quest{
	Name = "MM8_Promo_Berserker_1_4",
	Branch = "",
	Slot = 2,
	CanShow = function() return Party.QBits[87] end,
	Texts = {
		Topic = Game.NPCTopic[39],
		Ungive = Game.NPCText[48]
	}
}
mm8_generate_promo_quests({QuestNPC = 43, Name = "Berserker", Seq = 1, Slot = 1,
	QBit = 87, Race = const.Race.Troll, Maturity = 1, Exp = MM.MM8Promo1ExpReward})

QuestNPC = 67	-- Hobb Sandwind

mm8_generate_promo_quests({QuestNPC = 67, Name = "Berserker", Seq = 2, Slot = 0,
	QBit = 87, Ungive = 917, Race = const.Race.Troll, Maturity = 1,
	Exp = MM.MM8Promo1ExpReward})
Quest{
	Name = "MM8_Promo_Warmonger_1",
	Branch = "",
	Slot = 1,
	Quest = 287,
	Exp = 25000,
	CanShow = function() return Party.QBits[87] end,
	CheckDone = function() return Party.QBits[288] end,
	Done = function() Party.QBits[289] = true end,
	Texts = {
		Topic = TXT.warmongers,
		Give = TXT.warmongers1,
		Undone = TXT.warmongers2,
		Done = TXT.warmongers3
	}
}
mm8_generate_promo_quests({QuestNPC = 67, Name = "Warmonger", Seq = 1, Slot = 1,
	QBit = 289, Race = const.Race.Troll, Maturity = 2, Exp = 10000})
--[=[
-- "Ancient Home Found!"
Game.GlobalEvtLines:RemoveEvent(36)
evt.CanShowTopic[36] = function()
	return Party.QBits[69]	-- Ancient Troll Homeland Found
end

evt.Global[36] = function()
	if not Party.QBits[69] then
		evt.SetMessage{49}	--[[
			"Have you found the Ancient Home for our Clan?
			Without its location, my people will surely perish!"
			]]
		return
	end
	evt.SetMessage{45}	--[[
		"You have found our Ancient Home?  Its located in the western area
		of the Murmurwoods?  This is wonderful news.  Perhaps there is still
		time to move my people.  Unfortunately the Elemental threat must be
		dealt with first, or no people will be safe! All Trolls among you
		have been promoted to War Troll, and their names will be forever
		remembered in our songs.  I will teach the rest of you what skills
		I can, perhaps it will be enough to help you save all of Jadame."
		]]
	evt.ForPlayer("All")
	evt.Add{"Experience", Value = 25000}
	Party.QBits[87] = true
	Party.QBits[68] = false	-- "Find the Ancient Troll Homeland and return to Volog Sandwind in the Ironsand Desert."
	Game.NPC[43].EventB = 1803	-- Volog Sandwind : Promotion to Warmonger
	Game.NPC[43].EventC = 1804	-- Volog Sandwind : Promotion to Honorary Warmonger
	Game.NPC[67].EventB = 1804	-- Hobb Sandwind : Promotion to Honorary Warmonger
	evt.SetNPCTopic{NPC = 43, Index = 0, Event = 612}	-- "Volog Sandwind" : "Roster Join Event"
end

-- Promotion to Warmonger
evt.Global[1803] = function()
	if not Party.QBits[87] then
		evt.SetMessage{49}	--[[
			"Have you found the Ancient Home for our Clan?
			Without its location, my people will surely perish!"
			]]
		return
	end
	local k = max(Game.CurrentPlayer, 0)
	local player = Party[k]
	evt.ForPlayer(k)
	if not table.find(MT.ClassPromotionsInv[const.Class.Warmonger], player.Class) then
		-- FIXME: show message
		return
	end
	-- FIXME: show message
	player.Class = const.Class.Warmonger
	-- Note: in MM8 - experience award is only on first time
	evt.Add{"Experience", Value = 10000}
	player.Attrs.PromoAwards[CPA.JadameWarmonger] = true
	if MS.Races.MaxMaturity > 0
			and player.Attrs.Race == const.Race.Troll then
		-- FIXME
		player.Attrs.Maturity = min(2, MS.Races.MaxMaturity)
	end
	Party.QBits[1538] = true	-- Promoted to War Troll.
end
]=]
--------------------------------------------
---- Jadame Vampire promotion
QuestNPC = 62	-- Lathean

Quest{
	Name = "MM8_Promo_Nosferatu_1",
	Branch = "",
	Slot = 1,
	Quest = 80,
	QuestItem = {627, 612},
	Exp = 25000,
	Undone = function()
		if evt.All.Cmp("Inventory", 627) then
			Message(Game.NPCText[111])
		elseif evt.All.Cmp("Inventory", 612) then
			Message(Game.NPCText[112])
		else
			Message(Game.NPCText[151])
		end
	end,
	Done = function()
		Party.QBits[88] = true
		evt.All.Add("Awards", 33)	-- "Found the Sarcophagus and Remains of Korbu."
	end,
	Texts = {
		Topic = Game.NPCTopic[83],
		TopicGiven = Game.NPCTopic[90],	-- "Return of Korbu"
		Give = Game.NPCText[110],
		Done = Game.NPCText[117]
	}
}
mm8_generate_promo_quests({QuestNPC = 62, Name = "Nosferatu", Seq = 1, Slot = 1,
	QBit = 88, 
	RaceFamily = const.RaceFamily.Vampire, Maturity = 2,
	Exp = MM.MM8Promo1ExpReward})
-- Hide EventC
Quest{
	Name = "MM8_Promo_Nosferatu_1_4",
	Branch = "nosferatu",
	Slot = 2,
}

--[=[
-- "Promote Vampires"
Game.GlobalEvtLines:RemoveEvent(739)
evt.Global[739] = function()
	if not Party.QBits[88] then
		evt.SetMessage{926}	--[[
			"You have not found Korbu and until you have I refuse to promote any of you!  Begone!"
			]]
		return
	end
	local k = max(Game.CurrentPlayer, 0)
	local player = Party[k]
	evt.ForPlayer(k)
	if not table.find(MT.ClassPromotionsInv[const.Class.Nosferatu], player.Class) then
		-- FIXME: show message
		return
	end
	evt.SetMessage{927}	--[[
		"Any Vampires among you will be promoted to Nosferatu!  I remember
		those who helped in the recovery of the Remains of Korbu."
		]]
	player.Class = const.Class.Nosferatu
	-- Note: in MM8 - experience award is only on bringing Korbu
	evt.Add{"Experience", Value = 10000}
	player.Attrs.PromoAwards[CPA.JadameNosferatu] = true
	-- TODO: update vampire races
	Party.QBits[1547] = true	-- Promoted to Nosferatu.
end
]=]
--------------------------------------------
---- 		PEASANT PROMOTIONS			----
--------------------------------------------

-- SkillId = Class
-- Teachers will also promote peasants to class assigned to skill.
local TeacherPromoters = {

	[0] = CC.Monk,	-- Staff = Monk
	[1] = CC.Knight,	-- Sword = Knight
	[2] = CC.Thief,	-- Dagger = Thief
	--[3] = CC.Ranger	-- Axe = Ranger
	[4] = CC.Knight,	-- Spear = Knight
	[5] = CC.Archer,	-- Bow = Archer
	[6] = CC.Cleric,	-- Mace = Cleric
	[7] = nil,
	[8] = CC.Paladin,	-- Shield = Paladin
	[9] = CC.Thief,	-- Leather = Thief
	[10] = CC.Archer,	-- Chain = Archer
	[11] = CC.Paladin,	-- Plate = Paladin
	[12] = CC.Sorcerer, 	-- Fire = Sorcerer
	[13] = CC.Sorcerer,	-- Air = Sorcerer
	[14] = CC.Druid,	-- Water = Druid
	[15] = CC.Druid,	-- Earth = Druid
	[16] = CC.Paladin,	-- Spirit = Paladin
	[17] = CC.Druid,	-- Mind = Druid
	[18] = CC.Cleric,	-- Body = Cleric
	[19] = CC.Cleric,	-- Light = Cleric
	[20] = CC.Sorcerer,	-- Dark = Sorcerer
	[21] = CC.DarkElf,	-- Dark elf
	[22] = CC.Vampire,	-- Vampire
	[23] = nil,
	[24] = CC.Thief,	-- ItemId = Thief
	[25] = CC.Thief,	-- Merchant = Thief
	[26] = CC.Knight,	-- Repair = Knight
	[27] = CC.Knight,	-- Bodybuilding = Knight
	[28] = CC.Druid,	-- Meditation = Druid
	[29] = CC.Archer,	-- Perception = Archer
	[30] = nil,
	[31] = CC.Thief,	-- Disarm = Thief
	[32] = CC.Monk,	-- Dodging = Monk
	[33] = CC.Monk, 	-- Unarmed = Monk
	[34] = CC.Ranger,	-- Mon Id = Ranger
	[35] = CC.Ranger,	-- Arms = Ranger
	[36] = nil,
	[37] = CC.Druid,	-- Alchemy = Druid
	[38] = CC.Sorcerer	-- Learning = Sorcerer

}

local PeasantPromoteTopic = 1721

local function PromotePeasant(To)

	evt.ForPlayer("Current")
	if not evt.Cmp{"ClassIs", CC.Peasant} then
		return false
	end

	evt.Set{"ClassIs", To}
	evt.Add{"Experience", 5000}

	if To == CC.Vampire or To == CC.Nosferatu then
		local cChar = Party[Game.CurrentPlayer]
		local Gender = Game.CharacterPortraits[cChar.Face].DefSex
		local NewFace = 12 + math.random(0,1)*2 + Gender

		cChar.Face = NewFace
		SetCharFace(Game.CurrentPlayer, NewFace)
		cChar.Skills[const.Skills.VampireAbility] = 1
		cChar.Spells[110] = true

		local new_race = table.filter(Game.Races, 0,
			"BaseRace", "=", Game.Races[cChar.Attrs.Race].BaseRace,
			"Family", "=", const.RaceFamily.Vampire
			)[1].Id
		if new_race and new_race >= 0 then
			cChar.Attrs.Race = new_race
			cChar.Attrs.Maturity = 0
		end

	elseif To == CC.DarkElf then
		local cChar = Party[Game.CurrentPlayer]
		cChar.Skills[const.Skills.DarkElfAbility] = 1
		cChar.Spells[99] = true

	end

	return true

end

local function CheckRace(To)

	local cChar = Party[Game.CurrentPlayer]
	local cRace = GetCharRace(cChar)
	local Races = const.Race

	if To == CC.Vampire and
		(cRace == Races.Human or cRace == Races.Elf or cRace == Races.DarkElf or cRace == Races.Goblin) then

		return true
	end

	local T = Game.CharSelection.ClassByRace[cRace]
	if T then
		return T[To]
	end

	return false

end

local CurPeasantPromClass
local RestrictedTeachers = {427, 418}
function events.EnterNPC(i)
	local cNPC = Game.NPC[i]
	for i = 0, 4 do
		if cNPC.Events[i] == PeasantPromoteTopic then
			cNPC.Events[i] = 0
		end
	end

	if table.find(RestrictedTeachers, i) then
		return
	end

	if MF.CheckClassInParty(CC.Peasant) then
		local ClassId
		local cEvent
		for Eid = 0, 5 do
			cEvent = cNPC.Events[Eid]
			local TTopic = Game.TeacherTopics[cEvent]
			if TTopic and TeacherPromoters[TTopic.SId] then
				ClassId = TeacherPromoters[TTopic.SId]
			end
		end

		if not ClassId then
			return
		end

		CurPeasantPromClass = ClassId

		for i = 0, 4 do
			if cNPC.Events[i] == 0 then
				cEvent = i
				break
			end
		end

		if not cEvent then
			return
		end

		cNPC.Events[cEvent] = PeasantPromoteTopic
		Game.NPCTopic[PeasantPromoteTopic] = string.format(Game.NPCText[1676], Game.ClassNames[ClassId])
	end

end

local PeasantLastClick = 0
evt.Global[PeasantPromoteTopic] = function()
	if Game.CurrentPlayer < 0 then
		return
	end

	local ClassId = CurPeasantPromClass

	if not CheckRace(ClassId) then
		Message(string.format(Game.NPCText[1679], Game.ClassNames[ClassId]))
		return
	end

	if PeasantLastClick + 2 > os.time() then
		PeasantLastClick = 0
		if PromotePeasant(ClassId) then
			Message(string.format(Game.NPCText[1678], Game.ClassNames[ClassId]))
		end
	else
		PeasantLastClick = os.time()
		Message(string.format(Game.NPCText[1677], Game.ClassNames[ClassId]))
	end
end

--------------------------------------------
---- 	ELF/VAMPIRE/DRAGON TEACHERS		----
--------------------------------------------

local LastLearnClick = 0
local LastTeacherSkill
local LearnSkillTopic = 1674
local SkillsToLearnFromTeachers = {21,22,23}

local function PartyCanLearn(skill)
	for _,pl in Party do
		if pl.Skills[skill] == 0 and GetMaxAvailableSkill(pl, skill) > 0 then
			return true
		end
	end
	return false
end

evt.Global[LearnSkillTopic] = function()
	if Game.CurrentPlayer < 0 then
		return
	end

	local Player = Party[Game.CurrentPlayer]
	local Skill = LastTeacherSkill
	local cNPC = Game.NPC[GetCurrentNPC()]

	if not Skill then
		return
	end

	if Player.Skills[Skill] > 0 then
		Message(string.format(Game.GlobalTxt[403], Game.SkillNames[Skill]))
	elseif GetMaxAvailableSkill(Player, Skill) == 0 then
		Message(string.format(Game.GlobalTxt[632],
				GetClassName({ClassId = Player.Class, RaceId = Player.Attrs.Race})))
	elseif Party.Gold < 500 then
		Message(Game.GlobalTxt[155])
	elseif GetMaxAvailableSkill(Player, Skill) > 0 and Player.Skills[Skill] == 0 then
		evt[Game.CurrentPlayer].Add{"Experience", 0} -- animation
		Player.Skills[Skill] = 1

		for i = 9, 11 do
			local CurS, CurM = SplitSkill(Player.Skills[i+12])
			for iL = 0 + i*11, CurM + i*11 - 1 do
				Player.Spells[iL] = true
			end
		end

		evt[Game.CurrentPlayer].Subtract{"Gold", 500}
		Message(Game.GlobalTxt[569])
	end
end

function events.EnterNPC(i)

	LastTeacherSkill = nil

	local TTopic
	local cNPC = Game.NPC[i]
	for Eid = 0, 5 do
		TTopic = Game.TeacherTopics[cNPC.Events[Eid]]
		if TTopic then
			LastTeacherSkill = TTopic.SId
			break
		end
	end

	if not table.find(SkillsToLearnFromTeachers, LastTeacherSkill) then
		return
	end

	if LastTeacherSkill and PartyCanLearn(LastTeacherSkill) then
		local str = Game.GlobalTxt[534]
		str = string.replace(str, "%lu", "500")
		str = string.format(str, Game.GlobalTxt[431], Game.SkillNames[LastTeacherSkill], "")

		Game.NPCTopic[LearnSkillTopic] = str
		cNPC.Events[NPCFollowers.FindFreeEvent(cNPC, LearnSkillTopic)] = LearnSkillTopic
	else
		NPCFollowers.ClearEvents(cNPC, {LearnSkillTopic})
	end

end

Log(Merge.Log.Info, "Init finished: %s", LogId)

