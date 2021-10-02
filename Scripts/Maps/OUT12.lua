local TXT = Localize{
	[0] = " ",
	[1] = "Chest ",
	[2] = "Barrel",
	[3] = "Well",
	[4] = "Drink from the Well",
	[5] = "Fountain",
	[6] = "Drink from the Fountain",
	[7] = "House",
	[8] = "",
	[9] = "Tent",
	[10] = "Hut",
	[11] = "Refreshing!",
	[12] = "Boat",
	[13] = "Dock",
	[14] = "Drink",
	[15] = "Button",
	[16] = "",
	[17] = "",
	[18] = "",
	[19] = "",
	[20] = "",
	[21] = "This Door is Locked",
	[22] = "",
	[23] = "",
	[24] = "",
	[25] = "Colony Zod",
	[26] = "Tunnel Entrance",
	[27] = "Cave",
	[28] = "",
	[29] = "",
	[30] = "Enter Colony Zod",
	[31] = "Enter the Cave",
	[32] = "Enter the Cave",
	[33] = "",
	[34] = "",
	[35] = "Temple",
	[36] = "Guilds",
	[37] = "Stables",
	[38] = "Docks",
	[39] = "Shops",
	[40] = "",
	[41] = "Castle Harmondy",
	[42] = "East ",
	[43] = "North ",
	[44] = "West",
	[45] = "South ",
	[46] = "Harmondale",
	[47] = "",
	[48] = "",
	[49] = "",
	[50] = "Obelisk",
	[51] = "veoseo_l",
	[52] = "Shrine",
	[53] = "Altar",
	[54] = "You Pray",
	[55] = "",
	[56] = "",
	[57] = "",
	[58] = "",
	[59] = "",
	[60] = "",
	[61] = "",
	[62] = "",
	[63] = "",
	[64] = "",
	[65] = "You make a wish",
}
table.copy(TXT, evt.str, true)


evt.hint[1] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(1)
evt.map[1] = function()  -- function events.LoadMap()
	if evt.Cmp{"QBits", Value = 775} then         -- Area 12 Archibald only once
		return
	end
	if not evt.Cmp{"QBits", Value = 616} then         -- "Go to Colony Zod in the Land of the Giants and slay Xenofex then return to Resurectra in Castle Lambent in Celeste."
		if evt.Cmp{"QBits", Value = 635} then         -- "Go to Colony Zod in the Land of the Giants and slay Xenofex then return to Kastore in the Pit."
			evt.SetNPCGreeting{NPC = 462, Greeting = 363}         --[[ "Archibald Ironfist" : "::You receive a telepathic message:: My friends.  I know you are working with my old advisors, but I must ask for your help one more time.

With the aid of equipment I have found in my new laboratory, I have discovered that my brother Roland, husband to Queen Catherine of Erathia, remains imprisoned by the devils in their foul, ah, dwelling.  I overheard that you're on your way to do battle with them (this equipment really is wonderful), and I want to make sure it goes well.  My brother has stolen the key to their leader's chambers, and has hidden it in the beastly cage they're keeping him in.  

Please rescue him!  Not even I can bear to think of my brother in those conditions!  To help you along, I offer this weapon.  It was...found by my loyal servant sergeant Piridak, amongst my advisor's personal belongings.  I hope it helps." ]]
			evt.Add{"QBits", Value = 775}         -- Area 12 Archibald only once
			evt.SpeakNPC{NPC = 462}         -- "Archibald Ironfist"
			evt.Add{"Inventory", Value = 866}         -- "Blaster"
			return
		end
	end
	evt.Add{"QBits", Value = 775}         -- Area 12 Archibald only once
	evt.SetNPCGreeting{NPC = 462, Greeting = 362}         --[[ "Archibald Ironfist" : "::You receive a telepathic message:: My…Lords.  My name is Archibald Ironfist.  You've probably heard of me--it is I who, up until recently, was the ruler of the Pit.  With my retirement, I find myself no longer concerned with the affairs of state.  I know that we were adversaries, but I am forced to ask for your help.  In return, I think I can help you.

I see that you're on your way to do battle with the devils, and I want to make sure it goes well.  With the aid of equipment I have found in my new laboratory, I have discovered that my brother Roland, husband to Queen Catherine of Erathia, remains imprisoned by the devils in their foul, ah, dwelling.

Please rescue him!  Not even I can bear to think of my brother in those conditions!  To help you along, I offer this weapon.  It was...found by my loyal servant sergeant Piridak, amongst my advisor's personal belongings.  I hope it helps." ]]
	evt.SpeakNPC{NPC = 462}         -- "Archibald Ironfist"
	evt.Add{"Inventory", Value = 866}         -- "Blaster"
end

events.LoadMap = evt.map[1].last

evt.hint[51] = evt.str[7]  -- "House"
evt.house[52] = 1150  -- "Lasiter's Home"
Game.MapEvtLines:RemoveEvent(52)
evt.map[52] = function()
	evt.EnterHouse{Id = 1150}         -- "Lasiter's Home"
end

evt.hint[151] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(151)
evt.map[151] = function()
	evt.OpenChest{Id = 1}
end

evt.hint[152] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(152)
evt.map[152] = function()
	evt.OpenChest{Id = 2}
end

evt.hint[153] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(153)
evt.map[153] = function()
	evt.OpenChest{Id = 3}
end

evt.hint[154] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(154)
evt.map[154] = function()
	evt.OpenChest{Id = 4}
end

evt.hint[155] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(155)
evt.map[155] = function()
	evt.OpenChest{Id = 5}
end

evt.hint[156] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(156)
evt.map[156] = function()
	evt.OpenChest{Id = 6}
end

evt.hint[157] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(157)
evt.map[157] = function()
	evt.OpenChest{Id = 7}
end

evt.hint[158] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(158)
evt.map[158] = function()
	evt.OpenChest{Id = 8}
end

evt.hint[159] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(159)
evt.map[159] = function()
	evt.OpenChest{Id = 9}
end

evt.hint[160] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(160)
evt.map[160] = function()
	evt.OpenChest{Id = 10}
end

evt.hint[161] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(161)
evt.map[161] = function()
	evt.OpenChest{Id = 11}
end

evt.hint[162] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(162)
evt.map[162] = function()
	evt.OpenChest{Id = 12}
end

evt.hint[163] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(163)
evt.map[163] = function()
	evt.OpenChest{Id = 13}
end

evt.hint[164] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(164)
evt.map[164] = function()
	evt.OpenChest{Id = 14}
end

evt.hint[165] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(165)
evt.map[165] = function()
	evt.OpenChest{Id = 15}
end

evt.hint[166] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(166)
evt.map[166] = function()
	evt.OpenChest{Id = 16}
end

evt.hint[167] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(167)
evt.map[167] = function()
	evt.OpenChest{Id = 17}
end

evt.hint[168] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(168)
evt.map[168] = function()
	evt.OpenChest{Id = 18}
end

evt.hint[169] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(169)
evt.map[169] = function()
	evt.OpenChest{Id = 19}
end

evt.hint[170] = evt.str[1]  -- "Chest "
Game.MapEvtLines:RemoveEvent(170)
evt.map[170] = function()
	evt.OpenChest{Id = 0}
end

evt.hint[201] = evt.str[3]  -- "Well"
evt.hint[202] = evt.str[4]  -- "Drink from the Well"
Game.MapEvtLines:RemoveEvent(202)
evt.map[202] = function()
	if evt.Cmp{"MapVar0", Value = 1} then
		evt.StatusText{Str = 11}         -- "Refreshing!"
	else
		evt.Add{"MightBonus", Value = 100}
		evt.StatusText{Str = 60}         -- ""
		evt.Set{"MapVar0", Value = 1}
	end
end

Timer(function()
	evt.Set{"MapVar0", Value = 0}
end, const.Week)

evt.hint[203] = evt.str[25]  -- "Colony Zod"
evt.hint[204] = evt.str[26]  -- "Tunnel Entrance"
evt.hint[205] = evt.str[3]  -- "Well"
Game.MapEvtLines:RemoveEvent(205)
evt.map[205] = function()
	local i
	if evt.Cmp{"Gold", Value = 5000} then
		i = Game.Rand() % 3
		if i == 1 then
			i = Game.Rand() % 4
			if i == 1 then
				evt.Set{"Eradicated", Value = 0}
			elseif i == 2 then
				evt.Set{"AgeBonus", Value = 0}
				evt.Add{"Experience", Value = 5000}
			elseif i == 3 then
			else
				evt.Set{"Dead", Value = 0}
			end
		elseif i == 2 then
			i = Game.Rand() % 3
			if i == 1 then
				evt.Add{"AirResBonus", Value = 50}
			elseif i == 2 then
				evt.Add{"FireResBonus", Value = 50}
			else
				evt.Set{"Stoned", Value = 0}
			end
		else
			i = Game.Rand() % 3
			if i == 1 then
				evt.Add{"Gold", Value = 10000}
			elseif i == 2 then
				evt.Add{"SkillPoints", Value = 10}
			else
				evt.Subtract{"ArmorClassBonus", Value = 50}
			end
		end
	else
		evt.Subtract{"Gold", Value = 4999}
	end
	evt.StatusText{Str = 65}         -- "You make a wish"
end

evt.hint[451] = evt.str[52]  -- "Shrine"
evt.hint[452] = evt.str[53]  -- "Altar"
Game.MapEvtLines:RemoveEvent(452)
evt.map[452] = function()
	evt.Set{"QBits", Value = 758}         -- Visited The Land of the giants
	evt.MoveToMap{X = -13523, Y = 4234, Z = 0, Direction = 256, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "out09.odm"}
end

evt.hint[453] = evt.str[50]  -- "Obelisk"
Game.MapEvtLines:RemoveEvent(453)
evt.map[453] = function()
	if not evt.Cmp{"QBits", Value = 686} then         -- Visited Obelisk in Area 12
		evt.StatusText{Str = 51}         -- "veoseo_l"
		evt.Add{"AutonotesBits", Value = 319}         -- "Obelisk message #11: veoseo_l"
		evt.ForPlayer(-- ERROR: Const not found
"All")
		evt.Add{"QBits", Value = 686}         -- Visited Obelisk in Area 12
	end
end

evt.hint[500] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(500)
evt.map[500] = function()
	if not evt.CheckSeason{Season = 3} then
		if not evt.CheckSeason{Season = 2} then
			if not evt.CheckSeason{Season = 1} then
				evt.CheckSeason{Season = 0}
			end
		end
	end
end

evt.hint[501] = evt.str[30]  -- "Enter Colony Zod"
Game.MapEvtLines:RemoveEvent(501)
evt.map[501] = function()
	evt.MoveToMap{X = 2648, Y = -1372, Z = 1, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 409, Icon = 3, Name = "7D27.blv"}         -- "Colony Zod"
end

evt.hint[502] = evt.str[31]  -- "Enter the Cave"
Game.MapEvtLines:RemoveEvent(502)
evt.map[502] = function()
	evt.MoveToMap{X = 9165, Y = 15139, Z = -583, Direction = 24, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 3, Name = "7D36.blv"}
end

evt.hint[503] = evt.str[32]  -- "Enter the Cave"
Game.MapEvtLines:RemoveEvent(503)
evt.map[503] = function()
	evt.Set{"QBits", Value = 876}         -- 0
	evt.MoveToMap{X = 752, Y = 2229, Z = 1, Direction = 1012, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "7D28.Blv"}
end

evt.hint[504] = evt.str[32]  -- "Enter the Cave"
Game.MapEvtLines:RemoveEvent(504)
evt.map[504] = function()
	evt.Set{"QBits", Value = 877}         -- 0
	evt.MoveToMap{X = 752, Y = 2229, Z = 1, Direction = 1012, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "7D28.Blv"}
end



--[[ MMMerge additions ]]--

-- The Land of the Giants

-- Correct load map event.
Game.MapEvtLines:RemoveEvent(1)
local function event1()
	Sleep(1000, 1000)

	local QB = Party.QBits
	local need_speak = not QB[775] and (QB[616] or QB[635])

	if need_speak then
		QB[775] = true

		if QB[616] then
			evt.SetNPCGreeting{462, 316}
		elseif QB[635] then
			evt.SetNPCGreeting{462, 317}
		end

		if Mouse.Item.Number ~= 0 then
			Mouse:ReleaseItem()
		end

		Mouse.Item.Number = 866
		Mouse.Item.Identified = true

		evt.SpeakNPC{462}
	end
end

function events.AfterLoadMap()
	coroutine.resume(coroutine.create(event1))
	Party.QBits[947] = true	-- DDMapBuff, changed for rev4 for merge
end
