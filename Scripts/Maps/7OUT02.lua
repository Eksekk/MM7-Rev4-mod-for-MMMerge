local TXT = Localize{
	[0] = " ",
	[1] = "Crate",
	[2] = "Barrel",
	[3] = "Well",
	[4] = "Drink from the Well",
	[5] = "Fountain",
	[6] = "Drink from the Fountain",
	[7] = "House",
	[8] = "Trash Heap",
	[9] = "Tent",
	[10] = "Hut",
	[11] = "Refreshing!",
	[12] = "Boat",
	[13] = "Dock",
	[14] = "Drink",
	[15] = "Button",
	[16] = "Fire",
	[17] = "Hatch",
	[18] = "Chest",
	[19] = "Harmondale Teleportal Hub",
	[20] = "You need a key to use this hub!",
	[21] = "This Door is Locked",
	[22] = "Signal Fire Pit",
	[23] = "It's too dangerous to enter the cave at this time.",
	[24] = "Closed for repairs.  Open again in 2 weeks.",
	[25] = "Castle Harmondale",
	[26] = "White Cliff Caves",
	[27] = "As you arrive in Harmondale, the streets are teaming with cheerful people.  The Erathian Festival of the Five Moons has just begun!",
	[28] = "As you return to Harmondale, the Festival of the Five Moons has just ended and life is returning to normal.",
	[29] = "",
	[30] = "Enter Castle Harmondale",
	[31] = "Enter the White Cliff Caves",
	[32] = "",
	[33] = "",
	[34] = "",
	[35] = "Temple",
	[36] = "Guilds",
	[37] = "Stables",
	[38] = "Docks",
	[39] = "Shops",
	[40] = "",
	[41] = "Castle Harmondale",
	[42] = "East",
	[43] = "North to the Tularean Forest",
	[44] = "West to Erathia",
	[45] = "South to Barrow Downs",
	[46] = "Harmondale",
	[47] = "",
	[48] = "",
	[49] = "",
	[50] = "Obelisk",
	[51] = "pohuwwba",
	[52] = "Shrine",
	[53] = "Altar",
	[54] = "You Pray",
	[55] = "",
	[56] = "",
	[57] = "",
	[58] = "",
	[59] = "",
	[60] = "Fruit Tree",
	[61] = "You received an apple",
	[62] = "",
	[63] = "",
	[64] = "",
	[65] = "",
	[66] = "",
	[67] = "",
	[68] = "",
	[69] = "",
	[70] = "+ 10 Might (Temporary)",
	[71] = "+2 Accuracy (Permanent)",
	[72] = "Maybe that wasn't such a good idea.",
	[73] = "You probably shouldn't do that.",
}
table.copy(TXT, evt.str, true)


evt.hint[1] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(1)
evt.map[1] = function()  -- function events.LoadMap()
	if evt.Cmp{"QBits", Value = 796} then         -- Beginning of Festival
		evt.Subtract{"QBits", Value = 796}         -- Beginning of Festival
		evt.Set{"QBits", Value = 806}         -- Return to EI
		evt.SpeakNPC{NPC = 345}         -- "Wren Wilder"
	end
end

events.LoadMap = evt.map[1].last

evt.house[2] = 382  -- "Castle Harmondale"
Game.MapEvtLines:RemoveEvent(2)
evt.map[2] = function()
end

evt.house[3] = 9  -- "Tempered Steel"
Game.MapEvtLines:RemoveEvent(3)
evt.map[3] = function()
	if evt.Cmp{"QBits", Value = 695} then         -- Failed either goto or do guild quest
		evt.StatusText{Str = 21}         -- "This Door is Locked"
		evt.FaceAnimation{-- ERROR: Const not found
Player = "Current", Animation = 18}
	else
		evt.EnterHouse{Id = 9}         -- "Tempered Steel"
	end
end

evt.house[4] = 9  -- "Tempered Steel"
Game.MapEvtLines:RemoveEvent(4)
evt.map[4] = function()
end

evt.house[5] = 47  -- "The Peasant's Smithy"
Game.MapEvtLines:RemoveEvent(5)
evt.map[5] = function()
	if evt.Cmp{"QBits", Value = 695} then         -- Failed either goto or do guild quest
		evt.StatusText{Str = 21}         -- "This Door is Locked"
		evt.FaceAnimation{-- ERROR: Const not found
Player = "Current", Animation = 18}
	else
		evt.EnterHouse{Id = 47}         -- "The Peasant's Smithy"
	end
end

evt.house[6] = 47  -- "The Peasant's Smithy"
Game.MapEvtLines:RemoveEvent(6)
evt.map[6] = function()
end

evt.house[7] = 85  -- "Otto's Oddities"
Game.MapEvtLines:RemoveEvent(7)
evt.map[7] = function()
	if evt.Cmp{"QBits", Value = 695} then         -- Failed either goto or do guild quest
		evt.StatusText{Str = 21}         -- "This Door is Locked"
		evt.FaceAnimation{-- ERROR: Const not found
Player = "Current", Animation = 18}
	else
		evt.EnterHouse{Id = 85}         -- "Otto's Oddities"
	end
end

evt.house[8] = 85  -- "Otto's Oddities"
Game.MapEvtLines:RemoveEvent(8)
evt.map[8] = function()
end

evt.house[9] = 117  -- "Philters and Elixirs"
Game.MapEvtLines:RemoveEvent(9)
evt.map[9] = function()
	if evt.Cmp{"QBits", Value = 695} then         -- Failed either goto or do guild quest
		evt.StatusText{Str = 21}         -- "This Door is Locked"
		evt.FaceAnimation{-- ERROR: Const not found
Player = "Current", Animation = 18}
	else
		evt.EnterHouse{Id = 117}         -- "Philters and Elixirs"
	end
end

evt.house[10] = 117  -- "Philters and Elixirs"
Game.MapEvtLines:RemoveEvent(10)
evt.map[10] = function()
end

evt.house[11] = 311  -- "WelNin Cathedral"
Game.MapEvtLines:RemoveEvent(11)
evt.map[11] = function()
	if evt.Cmp{"QBits", Value = 695} then         -- Failed either goto or do guild quest
		evt.StatusText{Str = 21}         -- "This Door is Locked"
		evt.FaceAnimation{-- ERROR: Const not found
Player = "Current", Animation = 18}
	else
		evt.EnterHouse{Id = 311}         -- "WelNin Cathedral"
	end
end

evt.house[12] = 311  -- "WelNin Cathedral"
Game.MapEvtLines:RemoveEvent(12)
evt.map[12] = function()
end

evt.house[13] = 1571  -- "Basic Principles"
Game.MapEvtLines:RemoveEvent(13)
evt.map[13] = function()
	if evt.Cmp{"QBits", Value = 695} then         -- Failed either goto or do guild quest
		evt.StatusText{Str = 21}         -- "This Door is Locked"
		evt.FaceAnimation{-- ERROR: Const not found
Player = "Current", Animation = 18}
	else
		evt.EnterHouse{Id = 1571}         -- "Basic Principles"
	end
end

evt.house[14] = 1571  -- "Basic Principles"
Game.MapEvtLines:RemoveEvent(14)
evt.map[14] = function()
end

evt.house[15] = 240  -- "On the House"
Game.MapEvtLines:RemoveEvent(15)
evt.map[15] = function()
	if evt.Cmp{"QBits", Value = 695} then         -- Failed either goto or do guild quest
		evt.StatusText{Str = 21}         -- "This Door is Locked"
		evt.FaceAnimation{-- ERROR: Const not found
Player = "Current", Animation = 18}
	else
		evt.EnterHouse{Id = 240}         -- "On the House"
	end
end

evt.house[16] = 240  -- "On the House"
Game.MapEvtLines:RemoveEvent(16)
evt.map[16] = function()
end

evt.house[17] = 129  -- "Adept Guild of Fire"
Game.MapEvtLines:RemoveEvent(17)
evt.map[17] = function()
	if evt.Cmp{"QBits", Value = 695} then         -- Failed either goto or do guild quest
		evt.StatusText{Str = 21}         -- "This Door is Locked"
		evt.FaceAnimation{-- ERROR: Const not found
Player = "Current", Animation = 18}
	else
		evt.EnterHouse{Id = 129}         -- "Adept Guild of Fire"
	end
end

evt.house[18] = 129  -- "Adept Guild of Fire"
Game.MapEvtLines:RemoveEvent(18)
evt.map[18] = function()
end

evt.house[19] = 135  -- "Adept Guild of Air"
Game.MapEvtLines:RemoveEvent(19)
evt.map[19] = function()
	if evt.Cmp{"QBits", Value = 695} then         -- Failed either goto or do guild quest
		evt.StatusText{Str = 21}         -- "This Door is Locked"
		evt.FaceAnimation{-- ERROR: Const not found
Player = "Current", Animation = 18}
	else
		evt.EnterHouse{Id = 135}         -- "Adept Guild of Air"
	end
end

evt.house[20] = 135  -- "Adept Guild of Air"
Game.MapEvtLines:RemoveEvent(20)
evt.map[20] = function()
end

evt.house[21] = 153  -- "Adept Guild of Spirit"
Game.MapEvtLines:RemoveEvent(21)
evt.map[21] = function()
	if evt.Cmp{"QBits", Value = 695} then         -- Failed either goto or do guild quest
		evt.StatusText{Str = 21}         -- "This Door is Locked"
		evt.FaceAnimation{-- ERROR: Const not found
Player = "Current", Animation = 18}
	else
		evt.EnterHouse{Id = 153}         -- "Adept Guild of Spirit"
	end
end

evt.house[22] = 153  -- "Adept Guild of Spirit"
Game.MapEvtLines:RemoveEvent(22)
evt.map[22] = function()
end

evt.house[23] = 165  -- "Adept Guild of Body"
Game.MapEvtLines:RemoveEvent(23)
evt.map[23] = function()
	if evt.Cmp{"QBits", Value = 695} then         -- Failed either goto or do guild quest
		evt.StatusText{Str = 21}         -- "This Door is Locked"
		evt.FaceAnimation{-- ERROR: Const not found
Player = "Current", Animation = 18}
	else
		evt.EnterHouse{Id = 165}         -- "Adept Guild of Body"
	end
end

evt.house[24] = 165  -- "Adept Guild of Body"
Game.MapEvtLines:RemoveEvent(24)
evt.map[24] = function()
end

evt.house[25] = 140  -- "Initiate Guild of Water"
Game.MapEvtLines:RemoveEvent(25)
evt.map[25] = function()
	if evt.Cmp{"QBits", Value = 695} then         -- Failed either goto or do guild quest
		evt.StatusText{Str = 21}         -- "This Door is Locked"
		evt.FaceAnimation{-- ERROR: Const not found
Player = "Current", Animation = 18}
	else
		evt.EnterHouse{Id = 140}         -- "Initiate Guild of Water"
	end
end

evt.house[26] = 140  -- "Initiate Guild of Water"
Game.MapEvtLines:RemoveEvent(26)
evt.map[26] = function()
end

evt.house[27] = 146  -- "Initiate Guild of Earth"
Game.MapEvtLines:RemoveEvent(27)
evt.map[27] = function()
	if evt.Cmp{"QBits", Value = 695} then         -- Failed either goto or do guild quest
		evt.StatusText{Str = 21}         -- "This Door is Locked"
		evt.FaceAnimation{-- ERROR: Const not found
Player = "Current", Animation = 18}
	else
		evt.EnterHouse{Id = 146}         -- "Initiate Guild of Earth"
	end
end

evt.house[28] = 146  -- "Initiate Guild of Earth"
Game.MapEvtLines:RemoveEvent(28)
evt.map[28] = function()
end

evt.house[29] = 158  -- "Initiate Guild of Mind"
Game.MapEvtLines:RemoveEvent(29)
evt.map[29] = function()
	if evt.Cmp{"QBits", Value = 695} then         -- Failed either goto or do guild quest
		evt.StatusText{Str = 21}         -- "This Door is Locked"
		evt.FaceAnimation{-- ERROR: Const not found
Player = "Current", Animation = 18}
	else
		evt.EnterHouse{Id = 158}         -- "Initiate Guild of Mind"
	end
end

evt.house[30] = 158  -- "Initiate Guild of Mind"
Game.MapEvtLines:RemoveEvent(30)
evt.map[30] = function()
end

evt.house[31] = 286  -- "The Vault"
Game.MapEvtLines:RemoveEvent(31)
evt.map[31] = function()
	if evt.Cmp{"QBits", Value = 695} then         -- Failed either goto or do guild quest
		evt.StatusText{Str = 21}         -- "This Door is Locked"
		evt.FaceAnimation{-- ERROR: Const not found
Player = "Current", Animation = 18}
	else
		evt.EnterHouse{Id = 286}         -- "The Vault"
	end
end

evt.house[32] = 286  -- "The Vault"
Game.MapEvtLines:RemoveEvent(32)
evt.map[32] = function()
end

evt.house[33] = 203  -- "Harmondale Townhall"
Game.MapEvtLines:RemoveEvent(33)
evt.map[33] = function()
	if evt.Cmp{"QBits", Value = 695} then         -- Failed either goto or do guild quest
		evt.StatusText{Str = 21}         -- "This Door is Locked"
		evt.FaceAnimation{-- ERROR: Const not found
Player = "Current", Animation = 18}
	else
		evt.EnterHouse{Id = 203}         -- "Harmondale Townhall"
	end
end

evt.house[34] = 203  -- "Harmondale Townhall"
Game.MapEvtLines:RemoveEvent(34)
evt.map[34] = function()
end

evt.house[35] = 461  -- "The J.V.C Corral"
Game.MapEvtLines:RemoveEvent(35)
evt.map[35] = function()
	if evt.Cmp{"Awards", Value = 126} then         -- "Reopened Harmondale Stables"
		evt.EnterHouse{Id = 461}         -- "The J.V.C Corral"
	else
		evt.SpeakNPC{NPC = 1254}         -- "Christian the Stablemaster"
	end
end

evt.house[36] = 461  -- "The J.V.C Corral"
Game.MapEvtLines:RemoveEvent(36)
evt.map[36] = function()
end

evt.house[37] = 1165  -- "Arbiter"
Game.MapEvtLines:RemoveEvent(37)
evt.map[37] = function()
	if evt.Cmp{"QBits", Value = 611} then         -- Chose the path of Light
		goto _40
	end
	if evt.Cmp{"QBits", Value = 612} then         -- Chose the path of Dark
		goto _75
	end
	if evt.Cmp{"NPCs", Value = 416} then         -- "Judge Fairweather"
		if evt.Cmp{"QBits", Value = 592} then         -- Gave plans to elfking
			if evt.Cmp{"QBits", Value = 593} then         -- Gave Loren to Catherine
				goto _19
			end
			if evt.Cmp{"QBits", Value = 597} then         -- Gave artifact to elves
				goto _24
			end
			if evt.Cmp{"QBits", Value = 595} then         -- Gave false Loren to Catherine (betray)
				goto _24
			end
		else
			if evt.Cmp{"QBits", Value = 594} then         -- Gave false plans to elfking (betray)
				if evt.Cmp{"QBits", Value = 595} then         -- Gave false Loren to Catherine (betray)
					goto _19
				end
			else
				if evt.Cmp{"QBits", Value = 595} then         -- Gave false Loren to Catherine (betray)
					if evt.Cmp{"QBits", Value = 597} then         -- Gave artifact to elves
						goto _24
					end
				end
			end
		end
		goto _22
	end
	if not evt.Cmp{"NPCs", Value = 417} then         -- "Judge Sleen"
		if not evt.Cmp{"QBits", Value = 646} then         -- Arbiter Messenger only happens once
			evt.EnterHouse{Id = 1165}         -- "Arbiter"
		end
		return
	end
	if evt.Cmp{"QBits", Value = 592} then         -- Gave plans to elfking
		if evt.Cmp{"QBits", Value = 593} then         -- Gave Loren to Catherine
			goto _54
		end
		if evt.Cmp{"QBits", Value = 597} then         -- Gave artifact to elves
			goto _59
		end
		if evt.Cmp{"QBits", Value = 595} then         -- Gave false Loren to Catherine (betray)
			goto _59
		end
	else
		if evt.Cmp{"QBits", Value = 594} then         -- Gave false plans to elfking (betray)
			if evt.Cmp{"QBits", Value = 595} then         -- Gave false Loren to Catherine (betray)
				goto _54
			end
		else
			if evt.Cmp{"QBits", Value = 595} then         -- Gave false Loren to Catherine (betray)
				if evt.Cmp{"QBits", Value = 597} then         -- Gave artifact to elves
					goto _59
				end
			end
		end
	end
::_57::
	evt.Add{"History14", Value = 0}
::_62::
	evt.Set{"QBits", Value = 612}         -- Chose the path of Dark
	evt.Subtract{"QBits", Value = 665}         -- "Choose a judge to succeed Judge Grey as Arbiter in Harmondale."
	evt.Set{"QBits", Value = 663}         -- "Enter the Pit from the Hall of the Pit in the Deyja Moors, then talk to Archibald in Castle Gloaming in the Pit."
	evt.Set{"Counter5", Value = 0}
	evt.SetNPCGreeting{NPC = 417, Greeting = 218}         -- "Judge Sleen" : "I am happy to see you again, my lords.  Deyja is very pleased with the way things have turned out.  Is there anything I can do for you?"
	evt.Subtract{"NPCs", Value = 417}         -- "Judge Sleen"
	evt.MoveNPC{NPC = 414, HouseId = 0}         -- "Ambassador Wright"
	evt.MoveNPC{NPC = 416, HouseId = 0}         -- "Judge Fairweather"
	evt.MoveNPC{NPC = 415, HouseId = 0}         -- "Ambassador Scale"
	evt.MoveNPC{NPC = 417, HouseId = 1166}         -- "Judge Sleen" -> "Arbiter"
	evt.SetNPCTopic{NPC = 417, Index = 1, Event = 892}         -- "Judge Sleen" : "Hint"
	evt.SetNPCTopic{NPC = 417, Index = 2, Event = 889}         -- "Judge Sleen" : "I lost it"
	evt.ShowMovie{DoubleSize = 1, Name = "\"arbiter evil\" "}
::_75::
	evt.EnterHouse{Id = 1166}         -- "Arbiter"
	do return end
::_40::
	evt.EnterHouse{Id = 1164}         -- "Arbiter"
	do return end
::_19::
	if evt.Cmp{"QBits", Value = 659} then         -- Gave artifact to arbiter
		evt.Add{"History9", Value = 0}
		goto _27
	end
	if not evt.Cmp{"QBits", Value = 596} then         -- Gave artifact to humans
		if evt.Cmp{"QBits", Value = 597} then         -- Gave artifact to elves
			goto _24
		end
	end
::_22::
	evt.Add{"History7", Value = 0}
::_27::
	evt.Set{"QBits", Value = 611}         -- Chose the path of Light
	evt.Subtract{"QBits", Value = 665}         -- "Choose a judge to succeed Judge Grey as Arbiter in Harmondale."
	evt.Set{"QBits", Value = 664}         -- "Enter Celeste from the grand teleporter in the Bracada Desert, then talk to Gavin Magnus in Castle Lambent in Celeste."
	evt.Set{"Counter5", Value = 0}
	evt.SetNPCGreeting{NPC = 416, Greeting = 221}         -- "Judge Fairweather" : "I am happy to see you again, my lords.  Bracada is very pleased with the way things have turned out.  Is there anything I can do for you?"
	evt.Subtract{"NPCs", Value = 416}         -- "Judge Fairweather"
	evt.MoveNPC{NPC = 416, HouseId = 1164}         -- "Judge Fairweather" -> "Arbiter"
	evt.MoveNPC{NPC = 417, HouseId = 0}         -- "Judge Sleen"
	evt.MoveNPC{NPC = 414, HouseId = 0}         -- "Ambassador Wright"
	evt.MoveNPC{NPC = 415, HouseId = 0}         -- "Ambassador Scale"
	evt.SetNPCTopic{NPC = 416, Index = 1, Event = 894}         -- "Judge Fairweather" : "Hint"
	evt.SetNPCTopic{NPC = 416, Index = 2, Event = 889}         -- "Judge Fairweather" : "I lost it"
	evt.ShowMovie{DoubleSize = 1, Name = "\"arbiter good\" "}
	goto _40
::_24::
	evt.Add{"History8", Value = 0}
	goto _27
::_54::
	if evt.Cmp{"QBits", Value = 659} then         -- Gave artifact to arbiter
		evt.Add{"History16", Value = 0}
		goto _62
	end
	if not evt.Cmp{"QBits", Value = 596} then         -- Gave artifact to humans
		if evt.Cmp{"QBits", Value = 597} then         -- Gave artifact to elves
			goto _59
		end
	end
	goto _57
::_59::
	evt.Add{"History15", Value = 0}
	goto _62
end

evt.hint[38] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(38)
evt.map[38] = function()  -- function events.LoadMap()
	if evt.Cmp{"QBits", Value = 875} then         -- Eradicated
		evt.SpeakNPC{NPC = 364}         -- "Operator"
	end
end

events.LoadMap = evt.map[38].last

evt.hint[39] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(39)
evt.map[39] = function()  -- function events.LoadMap()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if not evt.Cmp{"Awards", Value = 123} then         -- "Completed the MM7Rev4mod Game!!"
		if evt.Cmp{"QBits", Value = 886} then         -- End Game
			evt.SetNPCGreeting{NPC = 365, Greeting = 147}         -- "Count ZERO" : "Magic Shop"
			evt.Set{"Awards", Value = 123}         -- "Completed the MM7Rev4mod Game!!"
			evt.Subtract{"QBits", Value = 642}         -- "Go to the Lincoln in the sea west of Avlee and retrieve the Oscillation Overthruster and return it to Resurectra in Celeste."
			evt.SpeakNPC{NPC = 365}         -- "Count ZERO"
		end
	end
end

events.LoadMap = evt.map[39].last

evt.hint[50] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(50)
evt.map[50] = function()  -- function events.LoadMap()
	if not evt.Cmp{"QBits", Value = 526} then         -- Accepted Fireball wand from Malwick
		return
	end
	if evt.Cmp{"QBits", Value = 702} then         -- Finished with Malwick & Assc.
		return
	end
	if evt.Cmp{"QBits", Value = 695} then         -- Failed either goto or do guild quest
		goto _20
	end
	if not evt.Cmp{"QBits", Value = 694} then         -- "Steal the Tapestry from your associate's Castle and return it to Niles Stantley in the Mercenary Guild in Tatalia."
		if not evt.Cmp{"QBits", Value = 693} then         -- "Go to the Mercenary Guild in Tatalia and talk to Niles Stantley within two weeks."
			if evt.Cmp{"Counter5", Value = 1008} then
				evt.Set{"Counter5", Value = 0}
				evt.Add{"Inventory", Value = 1506}         -- "Message from Mr. Stantley"
				evt.Add{"QBits", Value = 693}         -- "Go to the Mercenary Guild in Tatalia and talk to Niles Stantley within two weeks."
				evt.SpeakNPC{NPC = 437}         -- "Messenger"
			end
			return
		end
		if not evt.Cmp{"Counter5", Value = 336} then
			return
		end
	else
		if not evt.Cmp{"Counter5", Value = 672} then
			return
		end
	end
	evt.Add{"QBits", Value = 695}         -- Failed either goto or do guild quest
	evt.SpeakNPC{NPC = 437}         -- "Messenger"
::_20::
	evt.SetMonGroupBit{NPCGroup = 60, Bit = const.MonsterBits.Hostile, On = true}         -- "Group for Malwick's Assc."
	evt.SetMonGroupBit{NPCGroup = 60, Bit = const.MonsterBits.Invisible, On = false}         -- "Group for Malwick's Assc."
	evt.Set{"BankGold", Value = 0}
	evt.Subtract{"QBits", Value = 693}         -- "Go to the Mercenary Guild in Tatalia and talk to Niles Stantley within two weeks."
	evt.Subtract{"QBits", Value = 694}         -- "Steal the Tapestry from your associate's Castle and return it to Niles Stantley in the Mercenary Guild in Tatalia."
end

events.LoadMap = evt.map[50].last

evt.hint[51] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(51)
evt.map[51] = function()  -- Timer(<function>, 7.5*const.Minute)
	if evt.Cmp{"QBits", Value = 695} then         -- Failed either goto or do guild quest
		if not evt.Cmp{"QBits", Value = 697} then         -- Killed all outdoor monsters
			if evt.CheckMonstersKilled{CheckType = 1, Id = 60, Count = 0} then
				evt.ForPlayer(-- ERROR: Const not found
"All")
				evt.Add{"QBits", Value = 697}         -- Killed all outdoor monsters
				if evt.Cmp{"QBits", Value = 696} then         -- Killed all castle monsters
					evt.ForPlayer(-- ERROR: Const not found
"All")
					evt.Add{"QBits", Value = 702}         -- Finished with Malwick & Assc.
					evt.Subtract{"QBits", Value = 695}         -- Failed either goto or do guild quest
				end
			end
		end
	end
end

Timer(evt.map[51].last, 7.5*const.Minute)

evt.hint[52] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(52)
evt.map[52] = function()  -- function events.LoadMap()
	if not evt.Cmp{"QBits", Value = 888} then         -- LG 1-time
		if evt.Cmp{"QBits", Value = 868} then         -- 0
			evt.SetNPCGreeting{NPC = 357, Greeting = 263}         -- "Lord Godwinson" : "Let us press on,my friends!"
			evt.Set{"NPCs", Value = 357}         -- "Lord Godwinson"
			evt.MoveNPC{NPC = 1253, HouseId = 0}         -- "Lord Godwinson"
			evt.SetNPCTopic{NPC = 357, Index = 0, Event = 846}         -- "Lord Godwinson" : "Coding Wizard Quest"
			evt.Set{"QBits", Value = 888}         -- LG 1-time
			evt.SpeakNPC{NPC = 357}         -- "Lord Godwinson"
		end
	end
end

events.LoadMap = evt.map[52].last

Game.MapEvtLines:RemoveEvent(110)
evt.map[110] = function()
	if not evt.Cmp{"QBits", Value = 645} then         -- Player castle timer only happens once
		evt.Set{"Counter3", Value = 0}
		evt.Set{"QBits", Value = 645}         -- Player castle timer only happens once
	end
	evt.SetTexture{Facet = 1, Name = "chb1dl"}
	evt.SetTexture{Facet = 2, Name = "chb1dr"}
	evt.SetTexture{Facet = 3, Name = "CHB1EL"}
	evt.SetTexture{Facet = 4, Name = "chb1er"}
	evt.SetTexture{Facet = 5, Name = "chb1s"}
	evt.SetTexture{Facet = 6, Name = "chb1"}
	evt.SetTexture{Facet = 11, Name = "chb1el"}
	evt.SetTexture{Facet = 12, Name = "chb1"}
	evt.SetTexture{Facet = 13, Name = "chb1er"}
	evt.SetTexture{Facet = 14, Name = "chb1s"}
	evt.SetTexture{Facet = 15, Name = "chbw"}
	evt.SetTexture{Facet = 7, Name = "chbw"}
	evt.SetFacetBit{Id = 10, Bit = const.FacetBits.Invisible, On = true}
	evt.SetFacetBit{Id = 15, Bit = const.FacetBits.Invisible, On = false}
	evt.SetSprite{SpriteId = 1, Visible = 1, Name = "7tree07"}
	evt.SetSprite{SpriteId = 2, Visible = 1, Name = "7tree01"}
	if not evt.Cmp{"History5", Value = 0} then
		evt.Add{"History5", Value = 0}
	end
end

function events.LoadMap()
	if not evt.Cmp{"QBits", Value = 610} then         -- Built Castle to Level 2 (rescued dwarf guy)
		return
	end
	if not evt.Cmp{"QBits", Value = 645} then         -- Player castle timer only happens once
		evt.Set{"Counter3", Value = 0}
		evt.Set{"QBits", Value = 645}         -- Player castle timer only happens once
	end
	evt.SetTexture{Facet = 1, Name = "chb1dl"}
	evt.SetTexture{Facet = 2, Name = "chb1dr"}
	evt.SetTexture{Facet = 3, Name = "CHB1EL"}
	evt.SetTexture{Facet = 4, Name = "chb1er"}
	evt.SetTexture{Facet = 5, Name = "chb1s"}
	evt.SetTexture{Facet = 6, Name = "chb1"}
	evt.SetTexture{Facet = 11, Name = "chb1el"}
	evt.SetTexture{Facet = 12, Name = "chb1"}
	evt.SetTexture{Facet = 13, Name = "chb1er"}
	evt.SetTexture{Facet = 14, Name = "chb1s"}
	evt.SetTexture{Facet = 15, Name = "chbw"}
	evt.SetTexture{Facet = 7, Name = "chbw"}
	evt.SetFacetBit{Id = 10, Bit = const.FacetBits.Invisible, On = true}
	evt.SetFacetBit{Id = 15, Bit = const.FacetBits.Invisible, On = false}
	evt.SetSprite{SpriteId = 1, Visible = 1, Name = "7tree07"}
	evt.SetSprite{SpriteId = 2, Visible = 1, Name = "7tree01"}
	if not evt.Cmp{"History5", Value = 0} then
		evt.Add{"History5", Value = 0}
	end
end

Game.MapEvtLines:RemoveEvent(111)
evt.map[111] = function()
	evt.SetFacetBit{Id = 20, Bit = const.FacetBits.Untouchable, On = false}
	evt.SetFacetBit{Id = 20, Bit = const.FacetBits.Invisible, On = false}
	evt.SetFacetBit{Id = 15, Bit = const.FacetBits.Invisible, On = true}
	evt.SetFacetBit{Id = 11, Bit = const.FacetBits.Invisible, On = true}
	evt.SetFacetBit{Id = 12, Bit = const.FacetBits.Invisible, On = true}
	evt.SetFacetBit{Id = 13, Bit = const.FacetBits.Invisible, On = true}
	evt.SetFacetBit{Id = 14, Bit = const.FacetBits.Invisible, On = true}
	evt.SetFacetBit{Id = 15, Bit = const.FacetBits.Invisible, On = true}
	evt.SetFacetBit{Id = 16, Bit = const.FacetBits.Invisible, On = true}
end

function events.LoadMap()
	if not evt.Cmp{"QBits", Value = 614} then         -- Completed Proving Grounds without killing a single creature
		if not evt.Cmp{"QBits", Value = 641} then         -- Completed Breeding Pit.
			return
		end
	end
	evt.SetFacetBit{Id = 20, Bit = const.FacetBits.Untouchable, On = false}
	evt.SetFacetBit{Id = 20, Bit = const.FacetBits.Invisible, On = false}
	evt.SetFacetBit{Id = 15, Bit = const.FacetBits.Invisible, On = true}
	evt.SetFacetBit{Id = 11, Bit = const.FacetBits.Invisible, On = true}
	evt.SetFacetBit{Id = 12, Bit = const.FacetBits.Invisible, On = true}
	evt.SetFacetBit{Id = 13, Bit = const.FacetBits.Invisible, On = true}
	evt.SetFacetBit{Id = 14, Bit = const.FacetBits.Invisible, On = true}
	evt.SetFacetBit{Id = 15, Bit = const.FacetBits.Invisible, On = true}
	evt.SetFacetBit{Id = 16, Bit = const.FacetBits.Invisible, On = true}
end

evt.hint[112] = evt.str[1]  -- "Crate"
Game.MapEvtLines:RemoveEvent(112)
evt.map[112] = function()
	evt.OpenChest{Id = 1}
end

evt.hint[113] = evt.str[1]  -- "Crate"
Game.MapEvtLines:RemoveEvent(113)
evt.map[113] = function()
	evt.OpenChest{Id = 2}
end

evt.hint[114] = evt.str[1]  -- "Crate"
Game.MapEvtLines:RemoveEvent(114)
evt.map[114] = function()
	evt.OpenChest{Id = 3}
end

evt.hint[115] = evt.str[1]  -- "Crate"
Game.MapEvtLines:RemoveEvent(115)
evt.map[115] = function()
	evt.OpenChest{Id = 4}
end

evt.hint[116] = evt.str[1]  -- "Crate"
Game.MapEvtLines:RemoveEvent(116)
evt.map[116] = function()
	evt.OpenChest{Id = 5}
end

evt.hint[117] = evt.str[18]  -- "Chest"
Game.MapEvtLines:RemoveEvent(117)
evt.map[117] = function()
	evt.OpenChest{Id = 6}
end

evt.hint[118] = evt.str[18]  -- "Chest"
Game.MapEvtLines:RemoveEvent(118)
evt.map[118] = function()
	evt.OpenChest{Id = 7}
end

evt.hint[119] = evt.str[18]  -- "Chest"
Game.MapEvtLines:RemoveEvent(119)
evt.map[119] = function()
	evt.OpenChest{Id = 8}
end

evt.hint[120] = evt.str[18]  -- "Chest"
Game.MapEvtLines:RemoveEvent(120)
evt.map[120] = function()
	evt.OpenChest{Id = 9}
end

evt.hint[121] = evt.str[1]  -- "Crate"
Game.MapEvtLines:RemoveEvent(121)
evt.map[121] = function()
	evt.OpenChest{Id = 10}
end

evt.hint[122] = evt.str[1]  -- "Crate"
Game.MapEvtLines:RemoveEvent(122)
evt.map[122] = function()
	evt.OpenChest{Id = 11}
end

evt.hint[123] = evt.str[1]  -- "Crate"
Game.MapEvtLines:RemoveEvent(123)
evt.map[123] = function()
	evt.OpenChest{Id = 12}
end

evt.hint[150] = evt.str[60]  -- "Fruit Tree"
Game.MapEvtLines:RemoveEvent(150)
evt.map[150] = function()
	if not evt.CheckSeason{Season = 3} then
		if not evt.CheckSeason{Season = 2} then
			if not evt.Cmp{"MapVar50", Value = 1} then
				evt.Add{"Inventory", Value = 1432}         -- "Red Delicious Apple"
				evt.Set{"MapVar50", Value = 1}
				evt.StatusText{Str = 61}         -- "You received an apple"
				evt.SetSprite{SpriteId = 51, Visible = 1, Name = "tree37"}
			end
		end
	end
end

evt.hint[151] = evt.str[60]  -- "Fruit Tree"
Game.MapEvtLines:RemoveEvent(151)
evt.map[151] = function()
	if not evt.CheckSeason{Season = 3} then
		if not evt.CheckSeason{Season = 2} then
			if not evt.Cmp{"MapVar51", Value = 1} then
				evt.Add{"Inventory", Value = 1432}         -- "Red Delicious Apple"
				evt.Set{"MapVar51", Value = 1}
				evt.StatusText{Str = 61}         -- "You received an apple"
				evt.SetSprite{SpriteId = 52, Visible = 1, Name = "tree37"}
			end
		end
	end
end

evt.hint[152] = evt.str[60]  -- "Fruit Tree"
Game.MapEvtLines:RemoveEvent(152)
evt.map[152] = function()
	if not evt.CheckSeason{Season = 3} then
		if not evt.CheckSeason{Season = 2} then
			if not evt.Cmp{"MapVar52", Value = 1} then
				evt.Add{"Inventory", Value = 1432}         -- "Red Delicious Apple"
				evt.Set{"MapVar52", Value = 1}
				evt.StatusText{Str = 61}         -- "You received an apple"
				evt.SetSprite{SpriteId = 53, Visible = 1, Name = "tree37"}
			end
		end
	end
end

evt.hint[153] = evt.str[60]  -- "Fruit Tree"
Game.MapEvtLines:RemoveEvent(153)
evt.map[153] = function()
	if not evt.CheckSeason{Season = 3} then
		if not evt.CheckSeason{Season = 2} then
			if not evt.Cmp{"MapVar53", Value = 1} then
				evt.Add{"Inventory", Value = 1432}         -- "Red Delicious Apple"
				evt.Set{"MapVar53", Value = 1}
				evt.StatusText{Str = 61}         -- "You received an apple"
				evt.SetSprite{SpriteId = 54, Visible = 1, Name = "tree37"}
			end
		end
	end
end

evt.hint[154] = evt.str[60]  -- "Fruit Tree"
Game.MapEvtLines:RemoveEvent(154)
evt.map[154] = function()
	if not evt.CheckSeason{Season = 3} then
		if not evt.CheckSeason{Season = 2} then
			if not evt.Cmp{"MapVar54", Value = 1} then
				evt.Add{"Inventory", Value = 1432}         -- "Red Delicious Apple"
				evt.Set{"MapVar54", Value = 1}
				evt.StatusText{Str = 61}         -- "You received an apple"
				evt.SetSprite{SpriteId = 55, Visible = 1, Name = "tree37"}
			end
		end
	end
end

evt.hint[155] = evt.str[60]  -- "Fruit Tree"
Game.MapEvtLines:RemoveEvent(155)
evt.map[155] = function()
	if not evt.CheckSeason{Season = 3} then
		if not evt.CheckSeason{Season = 2} then
			if not evt.Cmp{"MapVar55", Value = 1} then
				evt.Add{"Inventory", Value = 1432}         -- "Red Delicious Apple"
				evt.Set{"MapVar55", Value = 1}
				evt.StatusText{Str = 61}         -- "You received an apple"
				evt.SetSprite{SpriteId = 56, Visible = 1, Name = "tree37"}
			end
		end
	end
end

evt.hint[156] = evt.str[60]  -- "Fruit Tree"
Game.MapEvtLines:RemoveEvent(156)
evt.map[156] = function()
	if not evt.CheckSeason{Season = 3} then
		if not evt.CheckSeason{Season = 2} then
			if not evt.Cmp{"MapVar56", Value = 1} then
				evt.Add{"Inventory", Value = 1432}         -- "Red Delicious Apple"
				evt.Set{"MapVar56", Value = 1}
				evt.StatusText{Str = 61}         -- "You received an apple"
				evt.SetSprite{SpriteId = 57, Visible = 1, Name = "tree37"}
			end
		end
	end
end

evt.hint[157] = evt.str[60]  -- "Fruit Tree"
Game.MapEvtLines:RemoveEvent(157)
evt.map[157] = function()
	if not evt.CheckSeason{Season = 3} then
		if not evt.CheckSeason{Season = 2} then
			if not evt.Cmp{"MapVar57", Value = 1} then
				evt.Add{"Inventory", Value = 1432}         -- "Red Delicious Apple"
				evt.Set{"MapVar57", Value = 1}
				evt.StatusText{Str = 61}         -- "You received an apple"
				evt.SetSprite{SpriteId = 58, Visible = 1, Name = "tree37"}
			end
		end
	end
end

Game.MapEvtLines:RemoveEvent(211)
evt.map[211] = function()  -- function events.LoadMap()
	if not evt.Cmp{"QBits", Value = 646} then         -- Arbiter Messenger only happens once
		if evt.Cmp{"Counter3", Value = 2272} then
			evt.Add{"QBits", Value = 665}         -- "Choose a judge to succeed Judge Grey as Arbiter in Harmondale."
			evt.Add{"History6", Value = 0}
			evt.MoveNPC{NPC = 406, HouseId = 0}         -- "Ellen Rockway"
			evt.MoveNPC{NPC = 407, HouseId = 0}         -- "Alain Hani"
			evt.MoveNPC{NPC = 414, HouseId = 1169}         -- "Ambassador Wright" -> "Throne Room"
			evt.MoveNPC{NPC = 416, HouseId = 244}         -- "Judge Fairweather" -> "Familiar Place"
			evt.Set{"QBits", Value = 646}         -- Arbiter Messenger only happens once
			evt.SpeakNPC{NPC = 430}         -- "Messenger"
		end
	end
end

events.LoadMap = evt.map[211].last

evt.hint[212] = evt.str[43]  -- "North to the Tularean Forest"
evt.hint[213] = evt.str[44]  -- "West to Erathia"
evt.hint[214] = evt.str[45]  -- "South to Barrow Downs"
evt.hint[215] = evt.str[42]  -- "East"
evt.hint[216] = evt.str[46]  -- "Harmondale"
evt.hint[217] = evt.str[3]  -- "Well"
evt.hint[218] = evt.str[19]  -- "Harmondale Teleportal Hub"
Game.MapEvtLines:RemoveEvent(218)
evt.map[218] = function()
	local hasKey = false
	for i = 0, 4 do
		if evt.All.Cmp("Inventory", 1467 + i) then
			hasKey = true
			break
		end
	end
	if not hasKey then
		Game.ShowStatusText(evt.str[20])
	else
		evt.EnterHouse(925)
	end
end

evt.hint[219] = evt.str[41]  -- "Castle Harmondale"
evt.hint[220] = evt.str[50]  -- "Obelisk"
Game.MapEvtLines:RemoveEvent(220)
evt.map[220] = function()
	if not evt.Cmp{"QBits", Value = 676} then         -- Visited Obelisk in Area 2
		evt.StatusText{Str = 51}         -- "pohuwwba"
		evt.Add{"AutonotesBits", Value = 309}         -- "Obelisk message #1: pohuwwba"
		evt.ForPlayer(-- ERROR: Const not found
"All")
		evt.Add{"QBits", Value = 676}         -- Visited Obelisk in Area 2
	end
end

evt.hint[221] = evt.str[53]  -- "Altar"
Game.MapEvtLines:RemoveEvent(221)
evt.map[221] = function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if not evt.Cmp{"QBits", Value = 868} then         -- 0
		evt.StatusText{Str = 54}         -- "You Pray"
		return
	end
	vars.TheGauntletQBits = {}
	for i = 0, 2 do
		vars.TheGauntletQBits[i + 718] = Party.QBits[i + 718]
	end
	evt.Subtract{"QBits", Value = 718}         -- Harmondale - Town Portal
	evt.Subtract{"QBits", Value = 719}         -- Erathia - Town Portal
	evt.Subtract{"QBits", Value = 720}         -- Tularean Forest - Town Portal
	while evt.Cmp{"Inventory", Value = 223} do         -- "Magic Potion"
		evt.Subtract{"Inventory", Value = 223}         -- "Magic Potion"
	end
	local LBscrolls = {332, 1134, 1834}
	for _, scroll in ipairs(LBscrolls) do
		while evt.Cmp("Inventory", scroll) do
			evt.Subtract("Inventory", scroll)
		end
	end
	for _, pl in Party do
		if pl.Skills[const.Skills.Fire] ~= 0 then
			pl.SP = 0
		end
	end
	evt.ForPlayer(-- ERROR: Const not found
"All")
	-- doesn't work -- evt.CastSpell{Spell = 80, Mastery = const.GM, Skill = 53, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Dispel Magic"
	-- dispel magic
	for i, pl in Party do
		for buffid, buff in pl.SpellBuffs do
			mem.call(0x455E3C, 1, Party[i].SpellBuffs[buffid]["?ptr"])
		end
	end
	for i, buff in Party.SpellBuffs do
		mem.call(0x455E3C, 1, Party.SpellBuffs[i]["?ptr"])
	end
	evt.Subtract{"QBits", Value = 718}         -- Harmondale - Town Portal
	evt.MoveToMap{X = -3257, Y = -12544, Z = 833, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 3, Name = "7D08.blv"}
end

evt.hint[222] = evt.str[52]  -- "Shrine"
evt.hint[223] = evt.str[4]  -- "Drink from the Well"
Game.MapEvtLines:RemoveEvent(223)
evt.map[223] = function()
	if not evt.Cmp{"BankGold", Value = 99} then
		if not evt.Cmp{"Gold", Value = 199} then
			if not evt.Cmp{"MapVar19", Value = 1} then
				evt.Add{"Gold", Value = 200}
				evt.Set{"MapVar19", Value = 1}
			end
		end
	end
	evt.StatusText{Str = 11}         -- "Refreshing!"
end

RefillTimer(function()
	evt.Set{"MapVar19", Value = 0}
end, const.Week, true)

evt.hint[227] = evt.str[6]  -- "Drink from the Fountain"
Game.MapEvtLines:RemoveEvent(227)
evt.map[227] = function()
	local i
	if evt.Cmp{"PoisonedGreen", Value = 0} then
		goto _12
	end
	if evt.Cmp{"PoisonedYellow", Value = 0} then
		goto _12
	end
	if evt.Cmp{"PoisonedRed", Value = 0} then
		goto _12
	end
	i = Game.Rand() % 3
	if i == 1 then
		evt.Set{"PoisonedGreen", Value = 0}
	elseif i == 2 then
		evt.Set{"PoisonedYellow", Value = 0}
	else
		evt.Set{"PoisonedRed", Value = 0}
	end
	evt.StatusText{Str = 72}         -- "Maybe that wasn't such a good idea."
	do return end
::_12::
	evt.StatusText{Str = 73}         -- "You probably shouldn't do that."
end

evt.hint[228] = evt.str[4]  -- "Drink from the Well"
Game.MapEvtLines:RemoveEvent(228)
evt.map[228] = function()
	if evt.Cmp{"PlayerBits", Value = 2} then
		evt.StatusText{Str = 11}         -- "Refreshing!"
	else
		evt.Add{"BaseAccuracy", Value = 2}
		evt.Add{"PlayerBits", Value = 2}
		evt.StatusText{Str = 71}         -- "+2 Accuracy (Permanent)"
	end
end

evt.hint[229] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(229)
evt.map[229] = function()  -- Timer(<function>, 2.5*const.Minute)
	local i
	if not evt.Cmp{"QBits", Value = 760} then         -- Took area 2 hill fort
		i = Game.Rand() % 4
		if i == 1 then
			i = Game.Rand() % 5
			if i == 1 then
				evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 7368, FromY = 4920, FromZ = 416, ToX = 4903, ToY = 7358, ToZ = 1}         -- "Fireball"
			elseif i == 2 then
				evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 7368, FromY = 4920, FromZ = 416, ToX = 3820, ToY = 6694, ToZ = 1}         -- "Fireball"
			elseif i == 3 then
				evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 7368, FromY = 4920, FromZ = 416, ToX = 5419, ToY = 7931, ToZ = 1}         -- "Fireball"
			elseif i == 4 then
				evt.CastSpell{Spell = 15, Mastery = const.GM, Skill = 10, FromX = 7368, FromY = 4920, FromZ = 416, ToX = 5507, ToY = 6889, ToZ = 1}         -- "Sparks"
			else
				evt.CastSpell{Spell = 43, Mastery = const.Master, Skill = 10, FromX = 7336, FromY = 4952, FromZ = 416, ToX = 5507, ToY = 6889, ToZ = 512}         -- "Death Blossom"
			end
		elseif i == 2 then
			i = Game.Rand() % 5
			if i == 1 then
				evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 9000, FromY = 4920, FromZ = 416, ToX = 11822, ToY = 8132, ToZ = 0}         -- "Fireball"
			elseif i == 2 then
				evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 9000, FromY = 4920, FromZ = 416, ToX = 11218, ToY = 7086, ToZ = 0}         -- "Fireball"
			elseif i == 3 then
				evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 9000, FromY = 4920, FromZ = 416, ToX = 12054, ToY = 6754, ToZ = 0}         -- "Fireball"
			elseif i == 4 then
				evt.CastSpell{Spell = 15, Mastery = const.GM, Skill = 10, FromX = 9000, FromY = 4920, FromZ = 416, ToX = 10772, ToY = 6539, ToZ = 0}         -- "Sparks"
			else
				evt.CastSpell{Spell = 43, Mastery = const.Master, Skill = 10, FromX = 9032, FromY = 4952, FromZ = 416, ToX = 10772, ToY = 6539, ToZ = 512}         -- "Death Blossom"
			end
		elseif i == 3 then
			i = Game.Rand() % 5
			if i == 1 then
				evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 9000, FromY = 3280, FromZ = 416, ToX = 13002, ToY = 728, ToZ = 64}         -- "Fireball"
			elseif i == 2 then
				evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 9000, FromY = 3280, FromZ = 416, ToX = 11937, ToY = 538, ToZ = 64}         -- "Fireball"
			elseif i == 3 then
				evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 9000, FromY = 3280, FromZ = 416, ToX = 11239, ToY = -167, ToZ = 64}         -- "Fireball"
			elseif i == 4 then
				evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 10, FromX = 9000, FromY = 3280, FromZ = 416, ToX = 10486, ToY = 1825, ToZ = 47}         -- "Sparks"
			else
				evt.CastSpell{Spell = 43, Mastery = const.Master, Skill = 10, FromX = 9032, FromY = 3248, FromZ = 416, ToX = 10486, ToY = 1825, ToZ = 512}         -- "Death Blossom"
			end
		else
			i = Game.Rand() % 5
			if i == 1 then
				evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 7368, FromY = 3280, FromZ = 416, ToX = 5493, ToY = 88, ToZ = 1}         -- "Fireball"
			elseif i == 2 then
				evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 7368, FromY = 3280, FromZ = 416, ToX = 5452, ToY = 815, ToZ = 1}         -- "Fireball"
			elseif i == 3 then
				evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 7368, FromY = 3280, FromZ = 416, ToX = 4448, ToY = 1052, ToZ = 1}         -- "Fireball"
			elseif i == 4 then
				evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 10, FromX = 7368, FromY = 3280, FromZ = 416, ToX = 5319, ToY = 1298, ToZ = 1}         -- "Sparks"
			else
				evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 7336, FromY = 3248, FromZ = 416, ToX = 5319, ToY = 1298, ToZ = 512}         -- "Fireball"
			end
		end
	end
end

Timer(evt.map[229].last, 2.5*const.Minute)

evt.hint[231] = evt.str[16]  -- "Fire"
Game.MapEvtLines:RemoveEvent(231)
evt.map[231] = function()
	local i
	i = Game.Rand() % 5
	if i == 1 then
		evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 7368, FromY = 4920, FromZ = 416, ToX = 4903, ToY = 7358, ToZ = 1}         -- "Fireball"
	elseif i == 2 then
		evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 7368, FromY = 4920, FromZ = 416, ToX = 3820, ToY = 6694, ToZ = 1}         -- "Fireball"
	elseif i == 3 then
		evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 7368, FromY = 4920, FromZ = 416, ToX = 5419, ToY = 7931, ToZ = 1}         -- "Fireball"
	elseif i == 4 then
		evt.CastSpell{Spell = 15, Mastery = const.GM, Skill = 10, FromX = 7368, FromY = 4920, FromZ = 416, ToX = 5507, ToY = 6889, ToZ = 1}         -- "Sparks"
	else
		evt.CastSpell{Spell = 43, Mastery = const.Master, Skill = 10, FromX = 7336, FromY = 4952, FromZ = 416, ToX = 5507, ToY = 6889, ToZ = 512}         -- "Death Blossom"
	end
end

evt.hint[232] = evt.str[16]  -- "Fire"
Game.MapEvtLines:RemoveEvent(232)
evt.map[232] = function()
	local i
	i = Game.Rand() % 5
	if i == 1 then
		evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 9000, FromY = 4920, FromZ = 416, ToX = 11822, ToY = 8132, ToZ = 0}         -- "Fireball"
	elseif i == 2 then
		evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 9000, FromY = 4920, FromZ = 416, ToX = 11218, ToY = 7086, ToZ = 0}         -- "Fireball"
	elseif i == 3 then
		evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 9000, FromY = 4920, FromZ = 416, ToX = 12054, ToY = 6754, ToZ = 0}         -- "Fireball"
	elseif i == 4 then
		evt.CastSpell{Spell = 15, Mastery = const.GM, Skill = 10, FromX = 9000, FromY = 4920, FromZ = 416, ToX = 10772, ToY = 6539, ToZ = 0}         -- "Sparks"
	else
		evt.CastSpell{Spell = 43, Mastery = const.Master, Skill = 10, FromX = 9032, FromY = 4952, FromZ = 416, ToX = 10772, ToY = 6539, ToZ = 512}         -- "Death Blossom"
	end
end

evt.hint[233] = evt.str[16]  -- "Fire"
Game.MapEvtLines:RemoveEvent(233)
evt.map[233] = function()
	local i
	i = Game.Rand() % 5
	if i == 1 then
		evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 9000, FromY = 3280, FromZ = 416, ToX = 13002, ToY = 728, ToZ = 64}         -- "Fireball"
	elseif i == 2 then
		evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 9000, FromY = 3280, FromZ = 416, ToX = 11937, ToY = 538, ToZ = 64}         -- "Fireball"
	elseif i == 3 then
		evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 9000, FromY = 3280, FromZ = 416, ToX = 11239, ToY = -167, ToZ = 64}         -- "Fireball"
	elseif i == 4 then
		evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 10, FromX = 9000, FromY = 3280, FromZ = 416, ToX = 10486, ToY = 1825, ToZ = 47}         -- "Sparks"
	else
		evt.CastSpell{Spell = 43, Mastery = const.Master, Skill = 10, FromX = 9032, FromY = 3248, FromZ = 416, ToX = 10486, ToY = 1825, ToZ = 512}         -- "Death Blossom"
	end
end

evt.hint[234] = evt.str[16]  -- "Fire"
Game.MapEvtLines:RemoveEvent(234)
evt.map[234] = function()
	local i
	i = Game.Rand() % 5
	if i == 1 then
		evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 7368, FromY = 3280, FromZ = 416, ToX = 5493, ToY = 88, ToZ = 1}         -- "Fireball"
	elseif i == 2 then
		evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 7368, FromY = 3280, FromZ = 416, ToX = 5452, ToY = 815, ToZ = 1}         -- "Fireball"
	elseif i == 3 then
		evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 7368, FromY = 3280, FromZ = 416, ToX = 4448, ToY = 1052, ToZ = 1}         -- "Fireball"
	elseif i == 4 then
		evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 10, FromX = 7368, FromY = 3280, FromZ = 416, ToX = 5319, ToY = 1298, ToZ = 1}         -- "Sparks"
	else
		evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 7336, FromY = 3248, FromZ = 416, ToX = 5319, ToY = 1298, ToZ = 512}         -- "Fireball"
	end
end

evt.hint[235] = evt.str[17]  -- "Hatch"
Game.MapEvtLines:RemoveEvent(235)
evt.map[235] = function()
	evt.SetFacetBit{Id = 50, Bit = const.FacetBits.Invisible, On = true}
end

evt.hint[236] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(236)
evt.map[236] = function()
	if not evt.Cmp{"QBits", Value = 760} then         -- Took area 2 hill fort
		evt.Add{"QBits", Value = 760}         -- Took area 2 hill fort
		evt.CastSpell{Spell = 2, Mastery = const.GM, Skill = 10, FromX = 6545, FromY = 10984, FromZ = 4000, ToX = 6545, ToY = 5678, ToZ = 111}         -- "Fire Bolt"
		evt.CastSpell{Spell = 2, Mastery = const.GM, Skill = 10, FromX = 13458, FromY = 8781, FromZ = 4000, ToX = 8805, ToY = 5257, ToZ = 204}         -- "Fire Bolt"
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 10, X = 5232, Y = 1424, Z = 0, NPCGroup = 51, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 10, X = 10880, Y = 784, Z = 64, NPCGroup = 51, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 10, X = 5824, Y = 6400, Z = 12, NPCGroup = 51, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 10, X = 10832, Y = 6208, Z = 0, NPCGroup = 51, unk = 0}
		evt.CastSpell{Spell = 2, Mastery = const.GM, Skill = 10, FromX = 8096, FromY = -3423, FromZ = 4000, ToX = 7952, ToY = 3872, ToZ = 320}         -- "Fire Bolt"
		evt.CastSpell{Spell = 2, Mastery = const.GM, Skill = 10, FromX = 12240, FromY = 7312, FromZ = 0, ToX = 8160, ToY = 5136, ToZ = 314}         -- "Fire Bolt"
	end
end

evt.hint[237] = evt.str[22]  -- "Signal Fire Pit"
Game.MapEvtLines:RemoveEvent(237)
evt.map[237] = function()
	if not evt.Cmp{"QBits", Value = 779} then         -- South Signal Fire Out02
		evt.Set{"QBits", Value = 779}         -- South Signal Fire Out02
		evt.SetSprite{SpriteId = 20, Visible = 1, Name = "dec24"}
		if evt.Cmp{"QBits", Value = 780} then         -- North Signal Fire Out02
			if evt.Cmp{"QBits", Value = 781} then         -- West Siganl Fire Out02
				evt.Set{"QBits", Value = 774}         -- Time for Gobs to appear in area 2(raiding camp)
			end
		end
	end
end

evt.hint[238] = evt.str[22]  -- "Signal Fire Pit"
Game.MapEvtLines:RemoveEvent(238)
evt.map[238] = function()
	if not evt.Cmp{"QBits", Value = 780} then         -- North Signal Fire Out02
		evt.Set{"QBits", Value = 780}         -- North Signal Fire Out02
		evt.SetSprite{SpriteId = 21, Visible = 1, Name = "dec24"}
		if evt.Cmp{"QBits", Value = 779} then         -- South Signal Fire Out02
			if evt.Cmp{"QBits", Value = 781} then         -- West Siganl Fire Out02
				evt.Set{"QBits", Value = 774}         -- Time for Gobs to appear in area 2(raiding camp)
			end
		end
	end
end

evt.hint[239] = evt.str[22]  -- "Signal Fire Pit"
Game.MapEvtLines:RemoveEvent(239)
evt.map[239] = function()
	if not evt.Cmp{"QBits", Value = 781} then         -- West Siganl Fire Out02
		evt.Set{"QBits", Value = 781}         -- West Siganl Fire Out02
		evt.SetSprite{SpriteId = 22, Visible = 1, Name = "dec24"}
		if evt.Cmp{"QBits", Value = 780} then         -- North Signal Fire Out02
			if evt.Cmp{"QBits", Value = 779} then         -- South Signal Fire Out02
				evt.Set{"QBits", Value = 774}         -- Time for Gobs to appear in area 2(raiding camp)
			end
		end
	end
end

evt.hint[240] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(240)
evt.map[240] = function()  -- function events.LoadMap()
	if evt.Cmp{"QBits", Value = 774} then         -- Time for Gobs to appear in area 2(raiding camp)
		evt.SetMonGroupBit{NPCGroup = 71, Bit = const.MonsterBits.Invisible, On = false}         -- "Ridge walkers in Bracada"
	end
end

events.LoadMap = evt.map[240].last

evt.hint[249] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(249)
evt.map[249] = function()  -- function events.LoadMap()
	if not evt.Cmp{"QBits", Value = 611} then         -- Chose the path of Light
		evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
	end
end

events.LoadMap = evt.map[249].last

evt.house[251] = 1101  -- "Mist Manor"
Game.MapEvtLines:RemoveEvent(251)
evt.map[251] = function()
	if evt.Cmp{"QBits", Value = 695} then         -- Failed either goto or do guild quest
		evt.StatusText{Str = 21}         -- "This Door is Locked"
		evt.FaceAnimation{-- ERROR: Const not found
Player = "Current", Animation = 18}
	else
		evt.EnterHouse{Id = 1101}         -- "Mist Manor"
	end
end

evt.house[252] = 1102  -- "Hillsmen Residence"
Game.MapEvtLines:RemoveEvent(252)
evt.map[252] = function()
	if evt.Cmp{"QBits", Value = 695} then         -- Failed either goto or do guild quest
		evt.StatusText{Str = 21}         -- "This Door is Locked"
		evt.FaceAnimation{-- ERROR: Const not found
Player = "Current", Animation = 18}
	else
		evt.EnterHouse{Id = 1102}         -- "Hillsmen Residence"
	end
end

evt.house[253] = 1103  -- "Stillwater Residence"
Game.MapEvtLines:RemoveEvent(253)
evt.map[253] = function()
	if evt.Cmp{"QBits", Value = 695} then         -- Failed either goto or do guild quest
		evt.StatusText{Str = 21}         -- "This Door is Locked"
		evt.FaceAnimation{-- ERROR: Const not found
Player = "Current", Animation = 18}
	else
		evt.EnterHouse{Id = 1103}         -- "Stillwater Residence"
	end
end

evt.house[254] = 1104  -- "Mark Manor"
Game.MapEvtLines:RemoveEvent(254)
evt.map[254] = function()
	if evt.Cmp{"QBits", Value = 695} then         -- Failed either goto or do guild quest
		evt.StatusText{Str = 21}         -- "This Door is Locked"
		evt.FaceAnimation{-- ERROR: Const not found
Player = "Current", Animation = 18}
	else
		evt.EnterHouse{Id = 1104}         -- "Mark Manor"
	end
end

evt.house[255] = 1105  -- "Bowes Residence"
Game.MapEvtLines:RemoveEvent(255)
evt.map[255] = function()
	if evt.Cmp{"QBits", Value = 695} then         -- Failed either goto or do guild quest
		evt.StatusText{Str = 21}         -- "This Door is Locked"
		evt.FaceAnimation{-- ERROR: Const not found
Player = "Current", Animation = 18}
	else
		evt.EnterHouse{Id = 1105}         -- "Bowes Residence"
	end
end

evt.house[256] = 1106  -- "Godwinson Estate"
Game.MapEvtLines:RemoveEvent(256)
evt.map[256] = function()
	if evt.Cmp{"QBits", Value = 695} then         -- Failed either goto or do guild quest
		evt.StatusText{Str = 21}         -- "This Door is Locked"
		evt.FaceAnimation{-- ERROR: Const not found
Player = "Current", Animation = 18}
	else
		evt.EnterHouse{Id = 1106}         -- "Godwinson Estate"
	end
end

evt.house[257] = 1107  -- "Krewlen Residence"
Game.MapEvtLines:RemoveEvent(257)
evt.map[257] = function()
	if evt.Cmp{"QBits", Value = 695} then         -- Failed either goto or do guild quest
		evt.StatusText{Str = 21}         -- "This Door is Locked"
		evt.FaceAnimation{-- ERROR: Const not found
Player = "Current", Animation = 18}
	else
		evt.EnterHouse{Id = 1107}         -- "Krewlen Residence"
	end
end

evt.house[258] = 1108  -- "Withersmythe's Home"
Game.MapEvtLines:RemoveEvent(258)
evt.map[258] = function()
	if evt.Cmp{"QBits", Value = 695} then         -- Failed either goto or do guild quest
		evt.StatusText{Str = 21}         -- "This Door is Locked"
		evt.FaceAnimation{-- ERROR: Const not found
Player = "Current", Animation = 18}
	else
		evt.EnterHouse{Id = 1108}         -- "Withersmythe's Home"
	end
end

evt.house[260] = 1121  -- "Kern Residence"
Game.MapEvtLines:RemoveEvent(260)
evt.map[260] = function()
	if evt.Cmp{"QBits", Value = 695} then         -- Failed either goto or do guild quest
		evt.StatusText{Str = 21}         -- "This Door is Locked"
		evt.FaceAnimation{-- ERROR: Const not found
Player = "Current", Animation = 18}
	else
		evt.EnterHouse{Id = 1121}         -- "Kern Residence"
	end
end

evt.house[261] = 1122  -- "Chadric's House"
Game.MapEvtLines:RemoveEvent(261)
evt.map[261] = function()
	if evt.Cmp{"QBits", Value = 695} then         -- Failed either goto or do guild quest
		evt.StatusText{Str = 21}         -- "This Door is Locked"
		evt.FaceAnimation{-- ERROR: Const not found
Player = "Current", Animation = 18}
	else
		evt.EnterHouse{Id = 1122}         -- "Chadric's House"
	end
end

evt.house[262] = 1123  -- "Weider Residence"
Game.MapEvtLines:RemoveEvent(262)
evt.map[262] = function()
	if evt.Cmp{"QBits", Value = 695} then         -- Failed either goto or do guild quest
		evt.StatusText{Str = 21}         -- "This Door is Locked"
		evt.FaceAnimation{-- ERROR: Const not found
Player = "Current", Animation = 18}
	else
		evt.EnterHouse{Id = 1123}         -- "Weider Residence"
	end
end

evt.house[263] = 1126  -- "Kinney Residence"
Game.MapEvtLines:RemoveEvent(263)
evt.map[263] = function()
	if evt.Cmp{"QBits", Value = 695} then         -- Failed either goto or do guild quest
		evt.StatusText{Str = 21}         -- "This Door is Locked"
		evt.FaceAnimation{-- ERROR: Const not found
Player = "Current", Animation = 18}
	else
		evt.EnterHouse{Id = 1126}         -- "Kinney Residence"
	end
end

evt.house[264] = 1127  -- "Farswell Residence"
Game.MapEvtLines:RemoveEvent(264)
evt.map[264] = function()
	if evt.Cmp{"QBits", Value = 695} then         -- Failed either goto or do guild quest
		evt.StatusText{Str = 21}         -- "This Door is Locked"
		evt.FaceAnimation{-- ERROR: Const not found
Player = "Current", Animation = 18}
	else
		evt.EnterHouse{Id = 1127}         -- "Farswell Residence"
	end
end

evt.hint[265] = evt.str[7]  -- "House"
evt.hint[266] = evt.str[10]  -- "Hut"
evt.house[267] = 1124  -- "Skinner's House"
Game.MapEvtLines:RemoveEvent(267)
evt.map[267] = function()
	evt.EnterHouse{Id = 1124}         -- "Skinner's House"
end

evt.house[268] = 1125  -- "Torrent's"
Game.MapEvtLines:RemoveEvent(268)
evt.map[268] = function()
	evt.EnterHouse{Id = 1125}         -- "Torrent's"
end


evt.hint[302] = evt.str[31]  -- "Enter the White Cliff Caves"
Game.MapEvtLines:RemoveEvent(302)
evt.map[302] = function()
	if evt.Cmp{"QBits", Value = 836} then         -- White Cliff Cave Permission
		evt.MoveToMap{X = 1344, Y = -256, Z = -107, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 391, Icon = 3, Name = "7D21.blv"}         -- "White Cliff Caves"
	else
		evt.StatusText{Str = 23}         -- "It's too dangerous to enter the cave at this time."
	end
end



--[[ MMMerge additions ]]--

-- Harmondale

function events.AfterLoadMap()
	Party.QBits[937] = true	-- DDMapBuff, changed for rev4 for merge
end

-- Choose Judge quest

evt.Map[37] = function()
	NPCFollowers.Remove(416)
	NPCFollowers.Remove(417)
end

-- Enter castle Harmondale

Game.MapEvtLines:RemoveEvent(301)
evt.Hint = evt.str[30]
evt.Map[301] = function()
	if Party.QBits[519] then
		if Party.QBits[610] or Party.QBits[644] then
			if Party.QBits[610] then
				evt.MoveToMap{-5073, -2842, 1, 512, 0, 0, 382, 9, "7d29.blv"}
			else
				evt.MoveToMap{-5073, -2842, 1, 512, 0, 0, 390, 9, "7d29.blv"}
			end
		else
			Party.QBits[644] = true
			Party.QBits[587] = true

			evt.Add{"History3", 0}
			evt.MoveNPC {397, 240}
			evt.SpeakNPC{397}
		end
	else
		evt.FaceAnimation{Game.CurrentPlayer, const.FaceAnimation.DoorLocked}
	end
end

-- Mercenary guild - invasion

Party.QBits[608] = Party.QBits[611] or Party.QBits[612]

evt.Map[50] = function()
	if (Party.QBits[693] or Party.QBits[694]) and not (Party.QBits[702] or Party.QBits[695]) then
		mapvars.InvasionTime = mapvars.InvasionTime or Game.Time + const.Week*2
		if mapvars.InvasionTime < Game.Time then
			Party.QBits[695] = true
			evt.SetMonGroupBit {60,  const.MonsterBits.Hostile,  true}
			evt.SetMonGroupBit {60,  const.MonsterBits.Invisible, false}
			evt.Set{"BankGold", 0}
			evt.SpeakNPC{437}
		end
	end
end

-- Give "Scavenger hunt" advertisment

local CCTimers = {}

function events.AfterLoadMap()
	if not (mapvars.GotAdvertisment or Party.QBits[519] or evt.All.Cmp{"Inventory", 774}) then

		CCTimers.Catch = function()
			if not (Party.Flying or Party.EnemyDetectorRed or Party.EnemyDetectorYellow)
				and 4000 > math.sqrt((-13115-Party.X)^2 + (12497-Party.Y)^2) then

				mapvars.GotAdvertisment = true
				RemoveTimer(CCTimers.Catch)
				evt.ForPlayer(0).Add{"Inventory", 774}
				evt.SetNPCGreeting(649, 332)
				evt.SpeakNPC{649}

			end
		end
		Timer(CCTimers.Catch, false, const.Minute*3)

	end
end
