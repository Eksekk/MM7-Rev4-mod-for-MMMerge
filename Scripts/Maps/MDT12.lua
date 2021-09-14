local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Enter the tunnel.",
	[3] = "Chest",
	[4] = "Button",
	[5] = "Lever",
	[6] = "Vault",
	[7] = "Cabinet",
	[8] = "Switch",
	[9] = "The Steel Grate is locked.",
	[10] = "Bookcase",
	[11] = "Exit to Celeste",
	[12] = "You can't exit without the Control Cube",
	[13] = "",
	[14] = "You Successfully disarm the trap",
	[15] = "",
	[16] = "Take a Drink",
	[17] = "Not Very Refreshing",
	[18] = "Refreshing",
}
table.copy(TXT, evt.str, true)


evt.hint[1] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(1)
evt.map[1] = function()  -- function events.LoadMap()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	evt.SetMonGroupBit{NPCGroup = 57, Bit = const.MonsterBits.Hostile, On = false}         -- "Group for M1"
	evt.SetMonGroupBit{NPCGroup = 58, Bit = const.MonsterBits.Hostile, On = false}         -- "Group fo M2"
	evt.SetMonGroupBit{NPCGroup = 59, Bit = const.MonsterBits.Hostile, On = false}         -- "Group for M3"
	evt.SetMonGroupBit{NPCGroup = 60, Bit = const.MonsterBits.Hostile, On = false}         -- "Group for Malwick's Assc."
	evt.SetMonGroupBit{NPCGroup = 61, Bit = const.MonsterBits.Hostile, On = false}         -- "Southern Village Group in Harmondy"
	evt.SetMonGroupBit{NPCGroup = 62, Bit = const.MonsterBits.Hostile, On = false}         -- "Main village in Harmondy"
	if evt.Cmp{"QBits", Value = 892} then         -- "Pass the Test of Friendship"
		evt.SetNPCGreeting{NPC = 1249, Greeting = 156}         -- "The Coding Wizard" : "Friends do not abandon friends in the midst of a fray!  You have failed the Test of Friendship!"
		evt.SpeakNPC{NPC = 1249}         -- "The Coding Wizard"
		evt.Set{"Awards", Value = 33}         -- "Hall of Shame Award ‘Unfaithful Friends’"
		evt.Subtract{"Inventory", Value = 1477}         -- "Control Cube"
		evt.Set{"Eradicated", Value = 0}
	else
		evt.SetNPCTopic{NPC = 1249, Index = 1, Event = 0}         -- "The Coding Wizard"
		evt.SetNPCTopic{NPC = 1249, Index = 2, Event = 0}         -- "The Coding Wizard"
		evt.SetNPCTopic{NPC = 1249, Index = 3, Event = 0}         -- "The Coding Wizard"
		evt.SetNPCTopic{NPC = 357, Index = 0, Event = 0}         -- "Lord Godwinson"
		evt.SetNPCTopic{NPC = 357, Index = 1, Event = 0}         -- "Lord Godwinson"
		evt.SetNPCTopic{NPC = 360, Index = 0, Event = 0}         -- "Zedd True Shot"
		evt.SetNPCTopic{NPC = 360, Index = 1, Event = 0}         -- "Zedd True Shot"
		evt.SetNPCTopic{NPC = 357, Index = 2, Event = 0}         -- "Lord Godwinson"
		evt.SetNPCTopic{NPC = 1249, Index = 0, Event = 1321}         -- "The Coding Wizard" : "SAVE you Game!"
	end
end

events.LoadMap = evt.map[1].last

evt.hint[2] = evt.str[100]  -- ""
Game.MapEvtLines:RemoveEvent(2)
evt.map[2] = function()  -- function events.LeaveMap()
	if not evt.Cmp{"QBits", Value = 739} then         -- Dragon Egg - I lost it
		if evt.Cmp{"Inventory", Value = 1449} then         -- "Dragon Egg"
			evt.Add{"QBits", Value = 739}         -- Dragon Egg - I lost it
		end
	end
end

events.LeaveMap = evt.map[2].last

evt.hint[176] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(176)
evt.map[176] = function()
	evt.OpenChest{Id = 1}
end

evt.hint[177] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(177)
evt.map[177] = function()
	evt.OpenChest{Id = 2}
end

evt.hint[178] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(178)
evt.map[178] = function()
	evt.OpenChest{Id = 3}
end

evt.hint[179] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(179)
evt.map[179] = function()
	evt.OpenChest{Id = 4}
end

evt.hint[180] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(180)
evt.map[180] = function()
	evt.OpenChest{Id = 5}
end

evt.hint[181] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(181)
evt.map[181] = function()
	evt.OpenChest{Id = 6}
end

evt.hint[182] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(182)
evt.map[182] = function()
	evt.OpenChest{Id = 7}
end

evt.hint[183] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(183)
evt.map[183] = function()
	evt.OpenChest{Id = 8}
end

evt.hint[184] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(184)
evt.map[184] = function()
	evt.OpenChest{Id = 9}
end

evt.hint[185] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(185)
evt.map[185] = function()
	evt.OpenChest{Id = 10}
end

evt.hint[186] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(186)
evt.map[186] = function()
	evt.OpenChest{Id = 11}
end

evt.hint[187] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(187)
evt.map[187] = function()
	evt.OpenChest{Id = 12}
end

evt.hint[188] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(188)
evt.map[188] = function()
	evt.OpenChest{Id = 13}
end

evt.hint[189] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(189)
evt.map[189] = function()
	evt.OpenChest{Id = 14}
end

evt.hint[190] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(190)
evt.map[190] = function()
	evt.OpenChest{Id = 15}
end

evt.hint[191] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(191)
evt.map[191] = function()
	evt.OpenChest{Id = 16}
end

evt.hint[192] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(192)
evt.map[192] = function()
	evt.OpenChest{Id = 17}
end

evt.hint[193] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(193)
evt.map[193] = function()
	evt.OpenChest{Id = 18}
end

evt.hint[194] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(194)
evt.map[194] = function()
	evt.OpenChest{Id = 19}
end

evt.hint[195] = evt.str[3]  -- "Chest"
Game.MapEvtLines:RemoveEvent(195)
evt.map[195] = function()
	evt.OpenChest{Id = 0}
end

evt.hint[501] = evt.str[2]  -- "Enter the tunnel."
Game.MapEvtLines:RemoveEvent(501)
evt.map[501] = function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if evt.Cmp{"QBits", Value = 891} then         -- Exit 1-time Cave 1 Vault
		evt.SpeakNPC{NPC = 1249}         -- "The Coding Wizard"
		evt.Set{"QBits", Value = 892}         -- "Pass the Test of Friendship"
		evt.Subtract{"NPCs", Value = 360}         -- "Zedd True Shot"
		evt.Subtract{"NPCs", Value = 357}         -- "Lord Godwinson"
		evt.Subtract{"NPCs", Value = 359}         -- "Baron BunGleau"
		evt.Subtract{"NPCs", Value = 374}         -- "Sir Vilx of Stone City"
		evt.Subtract{"NPCs", Value = 373}         -- "Duke Bimbasto"
		evt.Subtract{"NPCs", Value = 376}         -- "Pascal the Mad Mage"
		evt.SetMonGroupBit{NPCGroup = 57, Bit = const.MonsterBits.Hostile, On = false}         -- "Group for M1"
		evt.SetMonGroupBit{NPCGroup = 58, Bit = const.MonsterBits.Hostile, On = false}         -- "Group fo M2"
		evt.SetMonGroupBit{NPCGroup = 59, Bit = const.MonsterBits.Hostile, On = false}         -- "Group for M3"
		evt.SetMonGroupBit{NPCGroup = 60, Bit = const.MonsterBits.Hostile, On = false}         -- "Group for Malwick's Assc."
		evt.SetMonGroupBit{NPCGroup = 61, Bit = const.MonsterBits.Hostile, On = false}         -- "Southern Village Group in Harmondy"
		evt.SetMonGroupBit{NPCGroup = 62, Bit = const.MonsterBits.Hostile, On = false}         -- "Main village in Harmondy"
		evt.SetMonGroupBit{NPCGroup = 57, Bit = const.MonsterBits.Invisible, On = false}         -- "Group for M1"
		evt.SetMonGroupBit{NPCGroup = 58, Bit = const.MonsterBits.Invisible, On = false}         -- "Group fo M2"
		evt.SetMonGroupBit{NPCGroup = 59, Bit = const.MonsterBits.Invisible, On = false}         -- "Group for M3"
		evt.SetMonGroupBit{NPCGroup = 60, Bit = const.MonsterBits.Invisible, On = false}         -- "Group for Malwick's Assc."
		evt.SetMonGroupBit{NPCGroup = 61, Bit = const.MonsterBits.Invisible, On = false}         -- "Southern Village Group in Harmondy"
		evt.SetMonGroupBit{NPCGroup = 62, Bit = const.MonsterBits.Invisible, On = false}         -- "Main village in Harmondy"
		evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.SetNPCTopic{NPC = 360, Index = 1, Event = 790}         -- "Zedd True Shot" : "Let's Go!"
		evt.SetNPCTopic{NPC = 373, Index = 1, Event = 876}         -- "Duke Bimbasto" : "Let's Go!"
		evt.SetNPCTopic{NPC = 374, Index = 1, Event = 877}         -- "Sir Vilx of Stone City" : "Let's Go!"
		evt.SetNPCTopic{NPC = 376, Index = 1, Event = 884}         -- "Pascal the Mad Mage" : "Let's Go!"
		evt.SetNPCTopic{NPC = 359, Index = 1, Event = 885}         -- "Baron BunGleau" : "Let's Go!"
		evt.SetNPCTopic{NPC = 357, Index = 1, Event = 886}         -- "Lord Godwinson" : "Let's Go!"
		evt.SetNPCTopic{NPC = 1249, Index = 0, Event = 1174}         -- "The Coding Wizard" : "A word of Caution!"
		evt.MoveToMap{X = -54, Y = 3470, Z = 0, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	else
		if evt.Cmp{"Inventory", Value = 963} then         -- "Grate Key"
			evt.Subtract{"Inventory", Value = 963}         -- "Grate Key"
			evt.SetNPCGreeting{NPC = 1249, Greeting = 150}         --[[ "The Coding Wizard" : "You are finally face-to-face with Jester’s Folly and his minions, adventurers.  It is now time for the Test of Friendship.  Hear me and heed my words.

I give you a solemn charge, adventurers.  It is your responsibility to ensure that the entire brotherhood survives this encounter.  All must leave this cave together, or you will have failed the Test of Friendship and, hence, The Game!

Once you have defeated Jester’s Folly and possess the Cube, you must gather each member of the fellowship and then use the cave exit immediately behind you to return to Celeste. Return to Robert the Wise with the Cube and in company with the entire brotherhood.  Robert will grant you the appropriate rewards for your victory!

But be warned, adventurers!  If you let any of the brotherhood fall in battle, you will be eradicated, returned to Hamdondale, and branded ‘Unfaithful Friends’.  Unfaithful friends will not be able to complete ‘The Game’." ]]
			evt.SpeakNPC{NPC = 1249}         -- "The Coding Wizard"
			evt.SetNPCGreeting{NPC = 360, Greeting = 151}         -- "Zedd True Shot" : "What a glorious day for victory, my friends!."
			evt.SetNPCGreeting{NPC = 376, Greeting = 151}         -- "Pascal the Mad Mage" : "What a glorious day for victory, my friends!."
			evt.SetNPCGreeting{NPC = 373, Greeting = 151}         -- "Duke Bimbasto" : "What a glorious day for victory, my friends!."
			evt.SetNPCGreeting{NPC = 374, Greeting = 151}         -- "Sir Vilx of Stone City" : "What a glorious day for victory, my friends!."
			evt.SetNPCGreeting{NPC = 359, Greeting = 151}         -- "Baron BunGleau" : "What a glorious day for victory, my friends!."
			evt.SetNPCGreeting{NPC = 357, Greeting = 151}         -- "Lord Godwinson" : "What a glorious day for victory, my friends!."
			evt.Set{"NPCs", Value = 360}         -- "Zedd True Shot"
			evt.Set{"NPCs", Value = 357}         -- "Lord Godwinson"
			evt.Set{"NPCs", Value = 359}         -- "Baron BunGleau"
			evt.Set{"NPCs", Value = 374}         -- "Sir Vilx of Stone City"
			evt.Set{"NPCs", Value = 373}         -- "Duke Bimbasto"
			evt.Set{"NPCs", Value = 376}         -- "Pascal the Mad Mage"
			evt.Set{"QBits", Value = 891}         -- Exit 1-time Cave 1 Vault
		else
			evt.StatusText{Str = 9}         -- "The Steel Grate is locked."
		end
	end
end

evt.hint[502] = evt.str[11]  -- "Exit to Celeste"
Game.MapEvtLines:RemoveEvent(502)
evt.map[502] = function()
	evt.ForPlayer(-- ERROR: Const not found
"All")
	if not evt.Cmp{"Inventory", Value = 1477} then         -- "Control Cube"
		evt.StatusText{Str = 12}         -- "You can't exit without the Control Cube"
		return
	end
	if evt.Cmp{"NPCs", Value = 373} then         -- "Duke Bimbasto"
		if evt.Cmp{"NPCs", Value = 374} then         -- "Sir Vilx of Stone City"
			if evt.Cmp{"NPCs", Value = 357} then         -- "Lord Godwinson"
				if evt.Cmp{"NPCs", Value = 376} then         -- "Pascal the Mad Mage"
					if evt.Cmp{"NPCs", Value = 359} then         -- "Baron BunGleau"
						if evt.Cmp{"NPCs", Value = 360} then         -- "Zedd True Shot"
							evt.Set{"Awards", Value = 32}         -- "Declared Friends of ‘The Game’"
							evt.Subtract{"QBits", Value = 892}         -- "Pass the Test of Friendship"
							evt.MoveToMap{X = -6781, Y = 792, Z = 57, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "7D25.blv"}
							return
						end
					end
				end
			end
		end
	end
	evt.Set{"Awards", Value = 33}         -- "Hall of Shame Award ‘Unfaithful Friends’"
	evt.Subtract{"Inventory", Value = 1477}         -- "Control Cube"
	evt.Set{"Eradicated", Value = 0}
end

