local function GenieLamp(Target, Item, PlayerId)
	local day = Game.DayOfMonth + 1
	local month = Game.Month
	local bonusMul = math.ceil(day / 7)
	local badDays =
	{
		[5] = "Stoned",
		[7] = "Eradicated",
		[13] = "Dead",
		[21] = "Eradicated",
		[26] = "Stoned",
		[27] = "Dead"
	}
	local rewardString = "+%d %s!"
	local statReorder = {[4] = 5, [5] = 4}
	local statNamesInGlobalTxt = {[0] = 144, 116, 163, 75, 1, 211, 136}
	evt.ForPlayer(PlayerId)
	if month <= 6 then
		local stat = statReorder[month] or month
		evt.Add(32 + stat, bonusMul)
		Game.ShowStatusText(rewardString:format(bonusMul, Game.GlobalTxt[statNamesInGlobalTxt[stat]]))
	elseif month == 7 then
		evt.Add("Gold", bonusMul * 1000)
		Game.ShowStatusText(rewardString:format(bonusMul * 1000, Game.GlobalTxt[97]))
	elseif month == 8 then
		evt.Add("Food", bonusMul * 5)
		Game.ShowStatusText(rewardString:format(bonusMul * 5, Game.GlobalTxt[653]))
	elseif month == 9 then
		evt.Add("SkillPoints", bonusMul * 2)
		Game.ShowStatusText(rewardString:format(bonusMul * 2, Game.GlobalTxt[207]))
	elseif month == 10 then
		evt.Add("Experience", bonusMul * 2500)
		Game.ShowStatusText(rewardString:format(bonusMul * 2500, Game.GlobalTxt[83]))
	elseif month == 11 then
		local resists = {[0] = 46, 47, 48, 49, 51, 52}
		local resistTexts = {[0] = 24, 202, 194, 208, 213, 204}
		local res = math.random(0, 5)
		evt.Add(resists[res], bonusMul)
		Game.ShowStatusText(rewardString:format(BonusMul, Game.GlobalTxt[resistTexts[res]]))
	end
	evt.PlaySound{Id = 152, X = Party.X, Y = Party.Y}
	if badDays[day] ~= nil then
		evt.Set(badDays[day], 0)
		evt.PlaySound{Id = 148, X = Party.X, Y = Party.Y}
	end
	return 2
end

evt.UseItemEffects[1418] = GenieLamp
evt.UseItemEffects[2103] = GenieLamp