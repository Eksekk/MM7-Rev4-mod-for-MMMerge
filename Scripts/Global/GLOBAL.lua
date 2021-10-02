-- ERROR: Duplicate label: 120:0
-- ERROR: Duplicate label: 518:5

-- "Castle Harmondale?"
evt.CanShowTopic[751] = function()
	return not evt.Cmp("QBits", 519)         -- Finished Scavenger Hunt
end

Game.GlobalEvtLines:RemoveEvent(751)
evt.global[751] = function()
	evt.SetMessage(944)         -- "If you win, you'll be in charge of one of the most scenic areas in all Erathia!  Harmondale is just outside of the Tularean Forest, right on the edge of the Elf-Human border.  And I'm sure you'll love the castle.  It's a bit of a fixer-upper, but it's quite roomy and has excellent ventilation.  It breaks my heart to part with this property, but I feel that the time has come for me to give something back to the people."
end

-- "What do you think about the hunt?"
evt.CanShowTopic[752] = function()
	return not evt.Cmp("QBits", 519)         -- Finished Scavenger Hunt
end

Game.GlobalEvtLines:RemoveEvent(752)
evt.global[752] = function()
	evt.SetMessage(943)         -- "Isn't this hunt exciting?  I really am grateful you came to my little event, and I hope you have fun, even if you don't win.  I think it's great that everyone is competing in a spirit of good sportsmanship and camaraderie."
end

-- "Congratulations"
evt.CanShowTopic[753] = function()
	return evt.Cmp("QBits", 519)         -- Finished Scavenger Hunt
end

Game.GlobalEvtLines:RemoveEvent(753)
evt.global[753] = function()
	evt.SetMessage(945)         -- "Congratulations!  You are the new Lords of Harmondale!  Isn't it thrilling?  You can't imagine how good it feels for me to give this property away to you!  All of the benefits and rewards, and of course, the responsibilities of governing the town of Harmondale are now yours.  (Lord Markham produces a deed and contract) Just sign here...And here... And if I could just get your initials here... Yes!  Well, that's that!  You're all set.  And once again, congratulations!!!"
	evt.SetNPCTopic{NPC = 340, Index = 2, Event = 754}         -- "Lord Markham" : "Your ship…"
	evt.Subtract("NPCs", 342)         -- "Big Daddy Jim"
	evt.Set("QBits", 529)         -- No more docent babble
	evt.ForPlayer("All")
	evt.Add("Experience", 1000)
	evt.Add("Awards", 1)         -- "Won the Scavenger Hunt on Emerald Island"
	evt.Set("QBits", 796)         -- Beginning of Festival
	evt.SetNPCGroupNews{NPCGroup = 52, NPCNews = 56}         -- "" : "Congratulations!"
end

-- "Your ship…"
Game.GlobalEvtLines:RemoveEvent(754)
evt.global[754] = function()
	evt.SetMessage(946)         -- "Well, the ship that will take you to your fiefdom awaits you in the harbor.  My entourage and I will be taking a different ship out.  Just board whenever you're ready."
	evt.Add("QBits", 527)         -- Able to use boat to get off Emerald Island
	evt.SetNPCTopic{NPC = 350, Index = 0, Event = 783}         -- "William Darvees" : "Let's Go!"
	evt.SetNPCTopic{NPC = 340, Index = 2, Event = 0}         -- "Lord Markham"
	evt.SetNPCGreeting{NPC = 340, Greeting = 0}         -- "Lord Markham" : ""
end

-- "Tell us the rules of the hunt"
Game.GlobalEvtLines:RemoveEvent(755)
evt.global[755] = function()
	evt.SetMessage(963)         -- "Good afternoon.  My duty is to verify that you have all the items necessary to win the contest.  You are required to bring a red potion, a longbow, a floor tile from the Temple of the Moon, a wealthy hat, seashell, and an instrument to me.  You can bring them in any order, just show them to me one at a time so that I may verify them."
end

-- "We found something!"
Game.GlobalEvtLines:RemoveEvent(756)
evt.global[756] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 520) then         -- Brought red potion
		if evt.Cmp("Inventory", 222) then         -- "Cure Wounds"
			evt.Subtract("QBits", 513)         -- "Return a red potion to the Judge on Emerald Island."
			evt.Add("Experience", 500)
			evt.Add("QBits", 520)         -- Brought red potion
			evt.Subtract("Inventory", 222)         -- "Cure Wounds"
			evt.SetMessage(969)         -- "What took you so long?  Almost every group has turned in a red potion by now.  This is the easiest item in the hunt to manage, but better late than never.  I will mark it off your list."
			return
		end
	end
	if not evt.Cmp("QBits", 521) then         -- Brought seashell
		if evt.Cmp("Inventory", 1437) then         -- "Seashell"
			evt.Subtract("QBits", 514)         -- "Return a seashell to the Judge on Emerald Island."
			evt.Subtract("Inventory", 1437)         -- "Seashell"
			evt.Add("QBits", 521)         -- Brought seashell
			evt.Add("Experience", 500)
			evt.SetMessage(968)         -- "A beautiful shell, much like the ones that Sally sells.  This certainly came from Emerald Island- I shall mark the shell off your list."
			return
		end
	end
	if not evt.Cmp("QBits", 522) then         -- Brought longbow
		if evt.Cmp("Inventory", 845) then         -- "Recurve Bow"
			evt.SetMessage(967)         -- "This longbow certainly qualifies for the hunt.  Good work, I shall mark that off your list."
			evt.Subtract("Inventory", 845)         -- "Recurve Bow"
			evt.Subtract("QBits", 515)         -- "Return a longbow to the Judge on Emerald Island."
			evt.Add("Experience", 500)
			evt.Add("QBits", 522)         -- Brought longbow
			return
		end
	end
	if not evt.Cmp("QBits", 523) then         -- Brought tile
		if evt.Cmp("Inventory", 1438) then         -- "Floor Tile (w/ moon insignia)"
			evt.SetMessage(966)         -- "Adventurers indeed!  I didn't expect anyone to bring back a tile so quickly.  This is certainly a tile from the Temple, however so I shall mark the tile off your list."
			evt.Subtract("Inventory", 1438)         -- "Floor Tile (w/ moon insignia)"
			evt.Subtract("QBits", 516)         -- "Return a floor tile to the Judge on Emerald Island."
			evt.Add("Experience", 500)
			evt.Add("QBits", 523)         -- Brought tile
			return
		end
	end
	if not evt.Cmp("QBits", 524) then         -- Brought instrument
		if evt.Cmp("Inventory", 1434) then         -- "Lute"
			evt.SetMessage(965)         -- "Hmm, a fine lute this is.  Let me mark off the instrument from your list."
			evt.Subtract("Inventory", 1434)         -- "Lute"
			evt.Subtract("QBits", 517)         -- "Return a musical instrument to the Judge on Emerald Island."
			evt.Add("Experience", 500)
			evt.Add("QBits", 524)         -- Brought instrument
			return
		end
	end
	if evt.Cmp("QBits", 525) then         -- Brought hat
		if not evt.Cmp("QBits", 513) then         -- "Return a red potion to the Judge on Emerald Island."
			if not evt.Cmp("QBits", 514) then         -- "Return a seashell to the Judge on Emerald Island."
				if not evt.Cmp("QBits", 515) then         -- "Return a longbow to the Judge on Emerald Island."
					if not evt.Cmp("QBits", 516) then         -- "Return a floor tile to the Judge on Emerald Island."
						if not evt.Cmp("QBits", 517) then         -- "Return a musical instrument to the Judge on Emerald Island."
							if not evt.Cmp("QBits", 518) then         -- "Return a wealthy hat to the Judge on Emerald Island."
								evt.Add("QBits", 519)         -- Finished Scavenger Hunt
								evt.SetMessage(970)         -- "Well, that's all six items.  You're the winner of the contest!  I suggest you talk to Lord Markham for the details on gaining your fiefdom, my work is done here."
								evt.SetNPCTopic{NPC = 341, Index = 0, Event = 0}         -- "Thomas the Judge"
								evt.SetNPCTopic{NPC = 341, Index = 1, Event = 0}         -- "Thomas the Judge"
								evt.MoveNPC{NPC = 341, HouseId = 0}         -- "Thomas the Judge"
								evt.SetNPCTopic{NPC = 340, Index = 1, Event = 0}         -- "Lord Markham"
								evt.SetNPCGreeting{NPC = 345, Greeting = 124}         -- "Wren Wilder" : ""
								return
							end
						end
					end
				end
			end
		end
	elseif evt.Cmp("Inventory", 1433) then         -- "Wealthy Hat"
		evt.SetMessage(964)         -- "I see you have found a wealthy hat.  I shall mark this off your list accordingly, good work."
		evt.Subtract("Inventory", 1433)         -- "Wealthy Hat"
		evt.Subtract("QBits", 518)         -- "Return a wealthy hat to the Judge on Emerald Island."
		evt.Add("Experience", 500)
		evt.Add("QBits", 525)         -- Brought hat
		return
	end
	evt.SetMessage(971)         -- "I'm sorry, but nothing you have is necessary for the hunt.  I don't mean to belittle what you have, but I'm not looking for any of it."
end

-- "MM7Rev4mod"
Game.GlobalEvtLines:RemoveEvent(757)
evt.global[757] = function()
	evt.SetMessage(1090)         --[[ "The development of this mod began in October 2007 as an ‘experiment’ in reverse-engineering the ‘event language’ of MM6, MM7, and MM8.  This was a massive effort that consumed countless hours of ‘blood sweating’ research and applications programming trials.  The MM7Rev4mod is the result of this ‘experiment’ and was completed by yours truly as a solo effort.  That makes me the ‘Sole Proprietor’ of this venture – author, designer, programmer, chef, bottle washer, and ‘go-for’.

If you enjoy this mod, ‘kudos’ to me. If you don’t like the mod … well ya gotta admit that the price was right ... different strokes and all that stuff.

Have fun exploring Vori.

The Coding Wizard

09March2008" ]]
	evt.SetNPCTopic{NPC = 342, Index = 0, Event = 758}         -- "Big Daddy Jim" : "Credits"
end

-- "Credits"
Game.GlobalEvtLines:RemoveEvent(758)
evt.global[758] = function()
	evt.SetMessage(1091)         --[[ "The MM8LevelEditor utility was an invaluable database import and extract tool during the development process.  My appreciation and recognition to the author and his dedicated efforts to produce this fine utility.

Thanks to Pascal (AKA: Asterix, asterix15, etal), for the initial announcements and ‘marketing’ of this mod, for contributing a few custom graphics to the otherwise status-quo visuals in the game, and for ‘early’ play testing of the R1 release.  If ya know about this mod, chances are it is due to Pascal’s efforts.

An ‘above and beyond the call of duty’ thanks to my work compatriots for giving up their Christmas holiday to ‘play test’ the R1 mod.  Special note to Tom A., Wren, Tony, Jude, and the ever-elusive ‘Count Zero, Seeker of Lost Ones’.  For programming Geeks, you guys are OK by me.

A ‘special’ thanks to Sarah Lambent (of the Courier Guild), simply because of her infectious ‘love’ of the MM7 gaming universe.

BDJ" ]]
	evt.SetNPCTopic{NPC = 342, Index = 0, Event = 759}         -- "Big Daddy Jim" : "Friends of  'The Game'"
end

-- "Friends of  'The Game'"
Game.GlobalEvtLines:RemoveEvent(759)
evt.global[759] = function()
	evt.SetMessage(1092)         --[[ "Finally, I’d like to recognize the contributions from the MM community at-large, and specifically the following six ‘gamers’.  Each has provided me with significant encouragement and play-testing ‘bug reports’ and suggestions.  As a special ‘Thanks!’, each of these contributors has become ‘immortalized’ within Erathia as an NPC in the MM7Rev4mod game.

Pascal the Mad Mage
Lord Godwinson
Zedd True Shot
Duke Bimbasto
Sir Vilx of Stone City
Baron BunGleau

Thank you all for your assistance.

Big Daddy Jim
15 April, 2008
" ]]
	evt.SetNPCTopic{NPC = 342, Index = 0, Event = 0}         -- "Big Daddy Jim"
	evt.SetNPCTopic{NPC = 342, Index = 1, Event = 0}         -- "Big Daddy Jim"
	evt.Subtract("NPCs", 342)         -- "Big Daddy Jim"
end

-- "We are going to win the Scavenger Hunt!"
Game.GlobalEvtLines:RemoveEvent(760)
evt.global[760] = function()
	evt.SetMessage(972)         -- "Are you contestants in Lord Markham's Scavenger Hunt?  How neat!  I'm here to provide entertainment to Lord Markham's entourage, the contestants, and to anyone else that would like to hear a song."
end

-- "Do you have any instruments?"
Game.GlobalEvtLines:RemoveEvent(761)
evt.global[761] = function()
	evt.SetMessage(973)         -- "I own a few instruments, but I only brought my lute with me.  Its old and not quite as well kept as some of the others, but I didn't want one of my good instruments stolen by pirates or damaged from exposure to the humid, salty air."
end

-- "We need an instrument for the contest"
Game.GlobalEvtLines:RemoveEvent(762)
evt.global[762] = function()
	evt.ForPlayer("All")
	evt.SetMessage(974)         -- "You say you need an instrument for the Scavenger Hunt?  I suppose you could buy my lute, but I've had it for such a long time.  I guess I'd part with it for 500 gold.  Interested?"
	evt.SetNPCTopic{NPC = 343, Index = 2, Event = 763}         -- "Ailyssa the Bard" : "Buy Lute for 500 gold"
end

evt.CanShowTopic[762] = function()
	if not evt.Cmp("Inventory", 1434) then         -- "Lute"
		return not evt.Cmp("QBits", 524)         -- Brought instrument
	end
	return false
end

-- "Buy Lute for 500 gold"
Game.GlobalEvtLines:RemoveEvent(763)
evt.global[763] = function()
	if evt.Cmp("Gold", 500) then
		evt.Subtract("Gold", 500)
		evt.Add("Inventory", 1434)         -- "Lute"
		evt.SetMessage(975)         -- "Well, promise to at least take care of it and not use it for firewood.  I suppose I'll have to make do without an instrument for the rest of this trip.  Maybe I should tell stories instead of sing until I get back home."
		evt.SetNPCItem{NPC = 343, Item = 1434, On = false}         -- "Ailyssa the Bard" : "Lute"
		evt.SetNPCTopic{NPC = 343, Index = 2, Event = 0}         -- "Ailyssa the Bard"
		evt.SetNPCTopic{NPC = 343, Index = 1, Event = 0}         -- "Ailyssa the Bard"
	else
		evt.SetMessage(976)         -- "It would help if you had the 500 gold pieces.  Please don't try and cheat me out of my instrument."
	end
end

-- "What do you think about the ocean?"
Game.GlobalEvtLines:RemoveEvent(764)
evt.global[764] = function()
	evt.SetMessage(950)         -- "I love being out on this side of the island, the view of the ocean is much better than from town, don't you agree?"
end

-- "Do you have any seashells?"
Game.GlobalEvtLines:RemoveEvent(765)
evt.global[765] = function()
	evt.SetMessage(951)         -- "I have some nice sea shells for sale, shells that you can only find on Emerald Island.  Can I sell one to you?  They're only a hundred gold pieces each."
	evt.SetNPCTopic{NPC = 344, Index = 1, Event = 766}         -- "Sally" : "Buy a Seashell for 100 gold"
end

-- "Buy a Seashell for 100 gold"
Game.GlobalEvtLines:RemoveEvent(766)
evt.global[766] = function()
	if evt.Cmp("Gold", 100) then
		evt.Subtract("Gold", 100)
		evt.Add("Inventory", 1437)         -- "Seashell"
		evt.SetMessage(952)         -- "Here you go, I hope it reminds you of your trip to Emerald Island."
	else
		evt.SetMessage(953)         -- "I really can't go any less than 100 gold; I need to make a living, too."
	end
end

-- "Harmondale?"
evt.CanShowTopic[767] = function()
	return not evt.Cmp("QBits", 519)         -- Finished Scavenger Hunt
end

Game.GlobalEvtLines:RemoveEvent(767)
evt.global[767] = function()
	evt.SetMessage(948)         --[[ "Congratulations!  You’ve completed all four assignments in record time, just as the Erathian Festival of the Five Moons is ending!   You are now ready to join the ranks of our elite guild. I hereby promote you to the rank of Master Courier!  Welcome to the Guild! 

Now just one more thing.  Our couriers used to service the Evenmorn Islands. Unfortunately through a series of miss-haps, all keys to the island chain were lost, stolen, or destroyed.   If you ever come across one of these keys, please bring it back to me so that I can make a copy of it.  I will reward you handsomely in gold.  Good luck, Master Couriers!"" ]]
end

-- "Gatekeeper Woes!"
Game.GlobalEvtLines:RemoveEvent(768)
evt.global[768] = function()
	evt.SetMessage(955)         -- "The Town Portal spell has been unmade by strange and sinister magics.  The mages in Bracada have tried to remake the spell, but with no success.  This has caused all Gate Keepers much ruin since they can no longer earn their living through their abilites.  Why just the other day I saw Merta the Gatekeeper sweeping out the stables just to make ends meet.  I hope the mages can restore this spell soon."
end

-- "Erathia has been betrayed!"
Game.GlobalEvtLines:RemoveEvent(769)
evt.global[769] = function()
	evt.SetMessage(959)         -- "We have discovered a corruption so powerful that it threatens to engulf all of Erathia. Due to this peril, we have formed a temporary truce with Lord Archibald until we can ‘neutralize’ this threat. Since the danger was spawned in The Pit, you need to travel there and seek out Maximus.  He will brief you on the situation.  Obey him as if his words were spoken by Gavin Magnus, himself."
	evt.Set("QBits", 805)         -- Return to NWC
	evt.SetNPCTopic{NPC = 421, Index = 0, Event = 0}         -- "Sir Caneghem"
	evt.MoveNPC{NPC = 424, HouseId = 1071}         -- "Maximus" -> "Hostel"
	evt.SetNPCTopic{NPC = 424, Index = 0, Event = 772}         -- "Maximus" : "Dangerous Mission"
end

-- "Erathia has been betrayed!"
Game.GlobalEvtLines:RemoveEvent(770)
evt.global[770] = function()
	evt.SetMessage(1141)         -- "We have discovered a corruption so powerful that it threatens to engulf all of Erathia. Due to this peril, we have formed a temporary truce with Gavin Magnus until we can ‘neutralize’ this threat. Since the danger was spawned in Celeste, you need to travel there and seek out Sir Caneghem.  He will brief you on the situation.  Obey him as if his words were spoken by Lord Archibald, himself."
	evt.Set("QBits", 805)         -- Return to NWC
	evt.SetNPCTopic{NPC = 424, Index = 0, Event = 0}         -- "Maximus"
	evt.MoveNPC{NPC = 421, HouseId = 1064}         -- "Sir Caneghem" -> "Hostel"
	evt.SetNPCTopic{NPC = 421, Index = 0, Event = 771}         -- "Sir Caneghem" : "Dangerous Mission"
end

-- "Dangerous Mission"
Game.GlobalEvtLines:RemoveEvent(771)
evt.global[771] = function()
	evt.SetMessage(1144)         -- "This assignment is extremely dangerous, adventurers.  So I have taken the liberty to solicit the assistance of the four Grandmasters of the Elemental Magicks, and each has agreed to provide what assistance they may to you.  So before I can brief you on this mission, you must first visit these Grandmasters and receive their blessing.  After this, return to me."
	evt.SetNPCTopic{NPC = 421, Index = 0, Event = 867}         -- "Sir Caneghem" : "We've received the Blessings!"
	evt.SetNPCTopic{NPC = 484, Index = 2, Event = 773}         -- "Torrent" : "Blessing"
	evt.SetNPCTopic{NPC = 478, Index = 2, Event = 774}         -- "Blayze " : "Blessing"
	evt.SetNPCTopic{NPC = 481, Index = 2, Event = 775}         -- "Gayle" : "Blessing"
	evt.SetNPCTopic{NPC = 487, Index = 2, Event = 776}         -- "Avalanche" : "Blessing"
end

-- "Dangerous Mission"
Game.GlobalEvtLines:RemoveEvent(772)
evt.global[772] = function()
	evt.SetMessage(1144)         -- "This assignment is extremely dangerous, adventurers.  So I have taken the liberty to solicit the assistance of the four Grandmasters of the Elemental Magicks, and each has agreed to provide what assistance they may to you.  So before I can brief you on this mission, you must first visit these Grandmasters and receive their blessing.  After this, return to me."
	evt.SetNPCTopic{NPC = 424, Index = 0, Event = 869}         -- "Maximus" : "We've received the Blessings!"
	evt.SetNPCTopic{NPC = 484, Index = 2, Event = 773}         -- "Torrent" : "Blessing"
	evt.SetNPCTopic{NPC = 478, Index = 2, Event = 774}         -- "Blayze " : "Blessing"
	evt.SetNPCTopic{NPC = 481, Index = 2, Event = 775}         -- "Gayle" : "Blessing"
	evt.SetNPCTopic{NPC = 487, Index = 2, Event = 776}         -- "Avalanche" : "Blessing"
end

-- "Blessing"
Game.GlobalEvtLines:RemoveEvent(773)
evt.global[773] = function()
	evt.SetMessage(1146)         --[[ "What you are about to attempt will try your mettle and prove your worth.  If you are successful, you’ll be heralded as the ‘Heroes of Erathia’.  If you fail, the Erathian way of life will be destroyed by unspeakable evil. For Erathia, and for your victory, I give you my blessing.

For Truth!  For Justice!  For the Erathian Way!" ]]
	evt.Set("QBits", 807)         -- Water
	for pl = 0, Party.High do
		evt.ForPlayer(pl)
		evt.Add("WaterResistance", 50)
	end
	evt.SetNPCTopic{NPC = 484, Index = 2, Event = 0}         -- "Torrent"
end

-- "Blessing"
Game.GlobalEvtLines:RemoveEvent(774)
evt.global[774] = function()
	evt.SetMessage(1146)         --[[ "What you are about to attempt will try your mettle and prove your worth.  If you are successful, you’ll be heralded as the ‘Heroes of Erathia’.  If you fail, the Erathian way of life will be destroyed by unspeakable evil. For Erathia, and for your victory, I give you my blessing.

For Truth!  For Justice!  For the Erathian Way!" ]]
	evt.Set("QBits", 808)         -- Fire
	for pl = 0, Party.High do
		evt.ForPlayer(pl)
		evt.Add("FireResistance", 50)
	end
	evt.SetNPCTopic{NPC = 478, Index = 2, Event = 0}         -- "Blayze "
end

-- "Blessing"
Game.GlobalEvtLines:RemoveEvent(775)
evt.global[775] = function()
	evt.SetMessage(1146)         --[[ "What you are about to attempt will try your mettle and prove your worth.  If you are successful, you’ll be heralded as the ‘Heroes of Erathia’.  If you fail, the Erathian way of life will be destroyed by unspeakable evil. For Erathia, and for your victory, I give you my blessing.

For Truth!  For Justice!  For the Erathian Way!" ]]
	evt.Set("QBits", 809)         -- Air
	for pl = 0, Party.High do
		evt.ForPlayer(pl)
		evt.Add("AirResistance", 50)
	end
	evt.SetNPCTopic{NPC = 481, Index = 2, Event = 0}         -- "Gayle"
end

-- "Blessing"
Game.GlobalEvtLines:RemoveEvent(776)
evt.global[776] = function()
	evt.SetMessage(1146)         --[[ "What you are about to attempt will try your mettle and prove your worth.  If you are successful, you’ll be heralded as the ‘Heroes of Erathia’.  If you fail, the Erathian way of life will be destroyed by unspeakable evil. For Erathia, and for your victory, I give you my blessing.

For Truth!  For Justice!  For the Erathian Way!" ]]
	evt.Set("QBits", 810)         -- Earth
	for pl = 0, Party.High do
		evt.ForPlayer(pl)
		evt.Add("EarthResistance", 50)
	end
	evt.SetNPCTopic{NPC = 487, Index = 2, Event = 0}         -- "Avalanche"
end

-- "Will you rejoin our party?"
Game.GlobalEvtLines:RemoveEvent(777)
evt.global[777] = function()
	evt.SetMessage(992)         -- "You have decided to listen to my tour about the points of interest on Emerald Island.  If you decide that you no longer want me to point out areas of interest then select Tour Off."
	evt.Subtract("QBits", 529)         -- No more docent babble
	evt.Set("NPCs", 342)         -- "Big Daddy Jim"
	evt.SetNPCTopic{NPC = 342, Index = 2, Event = 793}         -- "Big Daddy Jim" : "We need your help!"
end

-- "Fire Magic Expert"
Game.GlobalEvtLines:RemoveEvent(778)
evt.global[778] = function()
	evt.SetMessage(960)         --[[ "So you wanna become an Ekspert in Fire Magic? My, my ... aren't we feeling 'special'!  <hic!>  Pardon me.  I've been hittin' the sauce too much lately.

Ohhh!  I've gotta hangov ...  err ... headache.  I can't deal with this right now.  Just go away ... <burp> ... and let me be!!!" ]]
end

-- "Purchase Town Portal Pass for 200 gold"
Game.GlobalEvtLines:RemoveEvent(779)
evt.global[779] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Gold", 200) then
		evt.ForPlayer("Current")
		evt.Subtract("Gold", 200)
		evt.Add("Inventory", 1539)         -- "Town Portal Pass"
	else
		evt.SetMessage(1063)         -- "You don't have enough gold!"
	end
end

-- "Fire Magic Master"
Game.GlobalEvtLines:RemoveEvent(780)
evt.global[780] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 1362) then         -- "Watcher's Ring of Elemental Fire"
		evt.SetMessage(2740)         -- "I see that you've returned with the Watcher's Ring of Elemental Fire. Excellent!   Now we can discuss your promotion to Master of Fire Magic."
		evt.Add("Experience", 30000)
		evt.SetNPCTopic{NPC = 477, Index = 0, Event = 337}         -- "Ashen Temper" : "Fire Magic Master"
		return
	end
	if not evt.Cmp("Inventory", 1364) then         -- "Ring of UnWarding"
		evt.ForPlayer("Current")
		evt.Add("Inventory", 1364)         -- "Ring of UnWarding"
	end
	evt.SetMessage(2739)         -- "Before I can promote you to Master of Fire Magic, you must first retrieve the Watcher's Ring of Elemental Fire and return it to me.  The Ring is guarded by powerful Dragons who live in a cave on Emerald Island.  Make sure you keep the Ring of UnWarding with you to enter the cave."
end

-- "Earth Magic Grandmaster"
Game.GlobalEvtLines:RemoveEvent(781)
evt.global[781] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 1355) then         -- "Watcher's Ring of Elemental Earth "
		evt.SetMessage(2742)         -- "I see that you've defeated Greckaw and returned with the Watcher's Ring of Elemental Earth. An impressive accomplishment, indeed!!   Now we can discuss your promotion to Master of Earth Magic."
		evt.Add("Experience", 30000)
		evt.SetNPCTopic{NPC = 487, Index = 0, Event = 347}         -- "Avalanche" : "Earth Magic Grandmaster"
		return
	end
	if not evt.Cmp("Inventory", 253) then         -- "Divine Cure"
		evt.Add("Inventory", 253)         -- "Divine Cure"
	end
	evt.Set("QBits", 836)         -- White Cliff Cave Permission
	evt.SetMessage(2741)         --[[ "Retrieve the Watcher's Ring of Elemental Earth and then we’ll discuss promotions.  The Ring is guarded by Greckaw, Hurler of Mountains, a powerful Earth Elemental who dwells in the White Cliff Caves in Harmondale. 

Be extremely cautious when you enter this cave, children.  The Mad Mage Pascal, Diviner of Strange Flesh has sent his army of Trolls to take this ring by force, and a battle rages between Greckaw’s minions and these invaders.  You would do well to let them fight it out and then kill the survivors.  But make no mistake, young ones, either side will turn on you in a heartbeat! 

Make sure you have some healing potents with you.  You’ll need them!" ]]
end

-- "Let's go!"
Game.GlobalEvtLines:RemoveEvent(782)
evt.global[782] = function()
	evt.SetMessage(962)         -- "Sorry mates, this vessel's moored until a winner has been declared in the contest."
end

-- "Let's Go!"
Game.GlobalEvtLines:RemoveEvent(783)
evt.global[783] = function()
	evt.SetMessage(981)         -- "Good job, mates!  We'll be heading off for Harmondale right now.  Congratulations."
	evt.Subtract("QBits", 528)         -- "Find the missing contestants on Emerald Island and bring back proof to Lord Markham."
	evt.SetNPCTopic{NPC = 340, Index = 3, Event = 0}         -- "Lord Markham"
	evt.Add("History1", 0)
	evt.Add("History2", 0)
	evt.MoveNPC{NPC = 340, HouseId = 215}         -- "Lord Markham" -> "Lord Markham's Chamber"
	evt.SetNPCGreeting{NPC = 340, Greeting = 366}         -- "Lord Markham" : "Hmmph.  You don't actually expect me to act as though you really were a noble, do you?  Once a peasant, always a peasant, that's what my mother used to say.  Really, could you use the servant's entrance next time you stop by?  It really is embarrassing to have you dusty, mud spattered peasants coming in through the front door.  What will the neighbors think?"
	evt.Add("QBits", 648)         -- Party doesn't come back to Out01 temple anymore
	evt.ShowMovie{DoubleSize = 1, ExitCurrentScreen = true, Name = "pcout01 "}
	evt.MoveToMap{X = -17331, Y = 12547, Z = 465, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "Out02.odm"}
end

-- "Do you have any quests for us?"
Game.GlobalEvtLines:RemoveEvent(784)
evt.global[784] = function()
	evt.SetMessage(982)         -- "Keep in mind I have a 1000 gold reward for the group to bring back information on the contestants that have disappeared."
	evt.SetNPCTopic{NPC = 340, Index = 3, Event = 785}         -- "Lord Markham" : "About the missing contestants..."
	evt.Set("QBits", 528)         -- "Find the missing contestants on Emerald Island and bring back proof to Lord Markham."
end

-- "About the missing contestants..."
Game.GlobalEvtLines:RemoveEvent(785)
evt.global[785] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 1460) then         -- "Contestant's Shield"
		evt.SetMessage(984)         -- "Killed by another group of contestants?!  Beyond belief!  Is there no end to the Greed of Man?!  Thanks for dispatching these criminals for me!  Here's your reward."
		evt.Subtract("Inventory", 1460)         -- "Contestant's Shield"
		evt.Add("Awards", 2)         -- "Found the missing contestants on Emerald Island"
		evt.Add("Experience", 1000)
		evt.ForPlayer("Current")
		evt.Add("Gold", 1000)
		evt.Subtract("Reputation", 5)
		evt.Subtract("QBits", 528)         -- "Find the missing contestants on Emerald Island and bring back proof to Lord Markham."
		evt.SetNPCTopic{NPC = 340, Index = 3, Event = 0}         -- "Lord Markham"
	else
		evt.SetMessage(983)         -- "No news on the missing people yet?"
	end
end

-- "The Coding Wizard"
Game.GlobalEvtLines:RemoveEvent(786)
evt.global[786] = function()
	evt.SetMessage(2734)         -- "“BDJ the Coding Wizard, lives on the mainland. All those who have gained Grandmaster status in their chosen profession should seek out this wizard.  It is reported that he offers to ‘cross-train’ them into a second profession, thereby granting dual-character classes to all who meet his requirements.”"
end

-- "Is the cave behind your house the abandoned temple?"
Game.GlobalEvtLines:RemoveEvent(787)
evt.global[787] = function()
	evt.SetMessage(986)         -- "The cave right behind my house is not the Abandoned Temple.  It belongs to Morcarack the Pitiless, the Dragon of Emerald Island.  You don't have to worry, though.  The cave has been magically sealed for ages by the Watchers.  The Abandoned Temple is buried in the hill south of my house.  You can get to it by entering the caves at the top of the hill."
end

-- "The Watchers"
Game.GlobalEvtLines:RemoveEvent(788)
evt.global[788] = function()
	evt.SetMessage(987)         -- "In the beginning, the Watchers forged four Scarab Rings of Elemental Magic and hid them in the land under the protection of a fierce guardian.  Powerful indeed is the wizard who obtains these rings!!"
end

-- "How can we get to the mainland from here?"
Game.GlobalEvtLines:RemoveEvent(789)
evt.global[789] = function()
	evt.SetMessage(988)         -- "Getting to the mainland is no problem.  The Lady Margaret makes daily trips to Harmondale.  Getting back, now that's a different story. The fine Lady only carries cargo back to here. I have heard rumors that there is a teleporter hub in Harmondale, but I don't know if it can return you to our island."
end

-- "Let's Go!"
Game.GlobalEvtLines:RemoveEvent(790)
evt.global[790] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 1477) then         -- "Control Cube"
		evt.SetMessage(1230)         -- "Gladly, friends!"
		evt.SetMonGroupBit{NPCGroup = 62, Bit = const.MonsterBits.Invisible, On = true}         -- "Main village in Harmondy"
		evt.Set("NPCs", 360)         -- "Zedd True Shot"
		evt.SetNPCTopic{NPC = 360, Index = 1, Event = 0}         -- "Zedd True Shot"
	else
		evt.SetMessage(1245)         -- "We cannot leave until we have the Control Cube."
	end
end

-- "Have you seen any other contestants?"
Game.GlobalEvtLines:RemoveEvent(791)
evt.global[791] = function()
	evt.SetMessage(990)         -- "I'd watch those other contestants-- some of them seem ruthless.  One particularly nasty group headed to the north side of the island, and I haven't seen them since.  I'm surprised at the attention this contest has received, apparently people are hoping to get on the good side of the contestants for future favors if they win."
end

-- "Good Bye."
Game.GlobalEvtLines:RemoveEvent(792)
evt.global[792] = function()
	evt.StatusText(980)         -- "Enjoy the Game!"
	evt.SetNPCTopic{NPC = 342, Index = 0, Event = 0}         -- "Big Daddy Jim"
	evt.SetNPCTopic{NPC = 342, Index = 1, Event = 0}         -- "Big Daddy Jim"
	evt.Subtract("NPCs", 342)         -- "Big Daddy Jim"
end

-- "We need your help!"
Game.GlobalEvtLines:RemoveEvent(793)
evt.global[793] = function()
	evt.SetMessage(992)         -- "You have decided to listen to my tour about the points of interest on Emerald Island.  If you decide that you no longer want me to point out areas of interest then select Tour Off."
	evt.Subtract("QBits", 529)         -- No more docent babble
	evt.SetNPCTopic{NPC = 342, Index = 2, Event = 792}         -- "Big Daddy Jim" : "Good Bye."
end

-- "Rogue "
Game.GlobalEvtLines:RemoveEvent(794)
evt.global[794] = function()
	evt.SetMessage(993)         -- "Though the law may decide who is guilty and who is not, I decide who is called Thief, and who is just a criminal.  Bring me that lovely vase I saw on the mantle in Lord Markham’s manor, and I shall call you Rogue."
	evt.Add("QBits", 530)         -- "Go to Lord Markham's estate in Tatalia, steal the vase there, and return it to William Lasker in the Erathian Sewers."
	evt.SetNPCTopic{NPC = 354, Index = 0, Event = 795}         -- "William Lasker" : "Rogue "
end

-- "Rogue "
Game.GlobalEvtLines:RemoveEvent(795)
evt.global[795] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 1426) then         -- "Vase"
		evt.SetMessage(994)         -- "Common criminals steal whatever catches their eye; Rogues steal what I tell them to steal.  I shall not grant titles to failures.  Return with Lord Markham’s Vase and I will promote all Thieves to Rogues, and all non-thieves to Honorary Rogues."
		return
	end
	evt.SetMessage(995)         -- "Well done.  Stealing that vase took guts and skill.  I grant you the title of Rogue, and a small payment for your services. "
	for pl = 0, Party.High do
		evt.ForPlayer(pl)
		if evt.Cmp("ClassIs", const.Class.Thief) then
			evt.Set("ClassIs", const.Class.Rogue)
			evt.Add("QBits", 1560)         -- "Promoted to Rogue"
			evt.Add("Experience", 30000)
		else
			evt.Add("QBits", 1561)         -- "Promoted to Honorary Rogue"
			evt.Add("Experience", 15000)
		end
	end
	evt.Subtract("Inventory", 1426)         -- "Vase"
	evt.Subtract("QBits", 724)         -- Vase - I lost it
	evt.ForPlayer("All")
	evt.ForPlayer("Current")
	evt.Add("Gold", 5000)
	evt.Subtract("QBits", 530)         -- "Go to Lord Markham's estate in Tatalia, steal the vase there, and return it to William Lasker in the Erathian Sewers."
	evt.SetNPCTopic{NPC = 354, Index = 0, Event = 796}         -- "William Lasker" : "Spy"
end

-- "Spy"
Game.GlobalEvtLines:RemoveEvent(796)
evt.global[796] = function()
	evt.ForPlayer("All")
	if evt.Cmp("QBits", 611) then         -- Chose the path of Light
		evt.SetMessage(998)         -- "Your next task is somewhat more difficult…more suited for Spies than Rogues.  I have been asked to ensure that Watchtower 6, the only tower to survive the recent wars against the Necromancers, be unable to defend itself the next time it is attacked.  Killing the guards inside won’t help—the Necromancers will just fill it again with more troops.  The tower is on the southern edge of the Necromancers’ land.  I want you to slip inside and move the counterweight in the gatehouse at the top of the tower to the gatehouse at the bottom of the tower.  It is a heavy weight that can be found in a slot against the wall with a rope tied to it.  When the time comes for an attack, the misplaced weights will be noticed too late, and the gate will not close.  If you can do this, you will have proven your status as a Spy."
		evt.Set("QBits", 531)         -- "Go to Watchtower 6 in the Deyja Moors, and move the weight from the top of the tower to the bottom of the tower.  Then return to William Lasker in the Erathian Sewers."
		evt.SetNPCTopic{NPC = 354, Index = 0, Event = 797}         -- "William Lasker" : "Spy"
	elseif evt.Cmp("QBits", 612) then         -- Chose the path of Dark
		evt.SetMessage(996)         -- "You have chosen the path of Darkness, and I will promote you no further.  Perhaps an Assassin would have something to teach you.  I hear there is one in Deyja."
	else
		evt.SetMessage(997)         -- "You are not quite ready to take the next step.  The time is fast approaching when you must decide whether to follow the path of light, or the path of darkness.  If you choose the Light, return to me to complete your training."
	end
end

-- "Spy"
Game.GlobalEvtLines:RemoveEvent(797)
evt.global[797] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 532) then         -- Watchtower 6.  Weight in the appropriate box.  Important for Global event 47 (Spy promotion)
		if evt.Cmp(-- ERROR: Not found
"Inventory", 999) then
			evt.SetMessage(999)         -- "Um…The weight needs to go in the box in the lower gatehouse—not here.  Go back to Watchtower 6 and put the weight in the right box!"
		elseif evt.Cmp("QBits", 568) then         -- Watchtower 6.  Taken the weight from the upper gatehouse.  Spy promo quest
			evt.SetMessage(1000)         -- "Hmm.  Removing the weight from the upper gatehouse was a start, but where is it now?!?  The plan won’t work unless you put the weight in the lower gatehouse!  Go back to Watchtower 6 and put the weight in the right box!"
		else
			evt.SetMessage(1001)         -- "You haven’t done the job yet!  Remember, you must go to Watchtower 6 and move the weight from the box in the upper gatehouse to the lower gatehouse.  I will not promote you until that is done. "
		end
		return
	end
	evt.SetMessage(1002)         -- "Good work!  Some day, your sabotage of that watchtower will save hundreds of lives.  For your services, I hereby promote the Rogues among you to the status of Spy, and the Honorary Rogues to Honorary Spies! Oh, and here’s some gold as payment. "
	for pl = 0, Party.High do
		evt.ForPlayer(pl)
		if evt.Cmp("ClassIs", const.Class.Rogue) then
			evt.Set("ClassIs", const.Class.Spy)
			evt.Add("QBits", 1562)         -- "Promoted to Spy"
			evt.Add("Experience", 80000)
		else
			evt.Add("QBits", 1563)         -- "Promoted to Honorary Spy"
			evt.Add("Experience", 40000)
		end
	end
	evt.Add("Gold", 15000)
	evt.Subtract("QBits", 531)         -- "Go to Watchtower 6 in the Deyja Moors, and move the weight from the top of the tower to the bottom of the tower.  Then return to William Lasker in the Erathian Sewers."
	evt.ForPlayer("All")
	evt.SetNPCTopic{NPC = 354, Index = 0, Event = 0}         -- "William Lasker"
	evt.SetNPCGreeting{NPC = 354, Greeting = 154}         -- "William Lasker" : "Greetings Rogues, how may I be of service?"
end

-- "Greetings from BDJ!"
Game.GlobalEvtLines:RemoveEvent(798)
evt.global[798] = function()
	evt.SetMessage(1009)         --[[ "BDJ’s the name, coding wizard’s the Game! And I do trust that you are enjoying the ‘game’.

I see that you have survived The Gauntlet in good fashion.  Congratulations!  You may now select a new profession for each qualified party member.  Each member will be presented with three choices for a new profession.  Based upon the choice, twenty ‘bonus’ points will be distributed to one-or-more attributes: re, a new fighter will gain +15 Endurance and +5 Might; a new sorcerer will gain +20 Intellect.

When you select the new profession, the member will automatically be promoted to the highest rating in that character class; re, a Fighter will immediately become a Champion, a Sorcerer an Arch Mage.  Once you’ve selected your new profession, you will no longer continue to advance in your original profession, although you will retain all or your previous skill and spell abilities." ]]
	evt.ForPlayer("All")
	evt.SetNPCTopic{NPC = 1249, Index = 0, Event = 799}         -- "The Coding Wizard" : "How does this work?"
	evt.MoveNPC{NPC = 1253, HouseId = 1106}         -- "Lord Godwinson" -> "Godwinson Estate"
	evt.SetNPCTopic{NPC = 1253, Index = 0, Event = 846}         -- "Lord Godwinson" : "Coding Wizard Quest"
	evt.SetNPCGreeting{NPC = 1253, Greeting = 141}         -- "Lord Godwinson" : "Well met, my friends!  Sit a-spell and tell me all about your recent adventures."
end

-- "How does this work?"
Game.GlobalEvtLines:RemoveEvent(799)
evt.global[799] = function()
	evt.SetMessage(1010)         --[[ "Here’s how the process works.  You have four members in your party; member 1, member 2, member 3, and member 4 (from left-to-right).  Each time you select “New Profession”, you will ‘index’ to a different party member, starting at member 1.  The member will be presented with a single ‘fast track’ choice.  You may either select this choice or ‘EXIT’ and then select me a second time to be presented with three choices.

When the selected party member has chosen a new profession, proceed to the Brazier to acquire the new profession and then return to me.  When all four members have selected their new Profession, return to me one more time and then we’re done.  So let’s get started, ok?" ]]
	evt.ForPlayer("All")
	evt.SetNPCTopic{NPC = 1249, Index = 0, Event = 800}         -- "The Coding Wizard" : "New Profession."
end

-- "New Profession."
Game.GlobalEvtLines:RemoveEvent(800)
evt.global[800] = function()
	evt.ForPlayer("All")
	if evt.Cmp("QBits", 869) then         -- BDJ Final
		evt.SetMessage(2754)         -- "Adventurer 5, select your new profession."
		evt.ForPlayer(4)
	elseif evt.Cmp("QBits", 850) then         -- BDJ 4
		evt.SetMessage(1024)         -- "Adventurer 4, select your new profession."
		evt.ForPlayer(3)
	elseif evt.Cmp("QBits", 849) then         -- BDJ 3
		evt.SetMessage(1023)         -- "Adventurer 3, select your new profession."
		evt.ForPlayer(2)
	elseif evt.Cmp("QBits", 848) then         -- BDJ 2
		evt.SetMessage(1022)         -- "Adventurer 2, select your new profession."
		evt.ForPlayer(1)
	else
		evt.SetMessage(1021)         -- "Adventurer 1, select your new profession."
		evt.ForPlayer(0)
	end
	evt.Set("QBits", 861)         -- One Use
	if evt.Cmp("ClassIs", const.Class.ArchMage) then
		evt.SetNPCTopic{NPC = 1249, Index = 0, Event = 820}         -- "The Coding Wizard" : "Archer"
		evt.SetNPCTopic{NPC = 1249, Index = 1, Event = 836}         -- "The Coding Wizard" : "Paladin"
		evt.SetNPCTopic{NPC = 1249, Index = 2, Event = 807}         -- "The Coding Wizard" : "Cleric"
	elseif evt.Cmp("ClassIs", const.Class.PriestLight) then
		evt.SetNPCTopic{NPC = 1249, Index = 0, Event = 825}         -- "The Coding Wizard" : "Druid"
		evt.SetNPCTopic{NPC = 1249, Index = 1, Event = 836}         -- "The Coding Wizard" : "Paladin"
		evt.SetNPCTopic{NPC = 1249, Index = 2, Event = 820}         -- "The Coding Wizard" : "Archer"
	elseif evt.Cmp("ClassIs", const.Class.MasterArcher) then
		evt.SetNPCTopic{NPC = 1249, Index = 0, Event = 836}         -- "The Coding Wizard" : "Paladin"
		evt.SetNPCTopic{NPC = 1249, Index = 1, Event = 831}         -- "The Coding Wizard" : "Monk"
		evt.SetNPCTopic{NPC = 1249, Index = 2, Event = 825}         -- "The Coding Wizard" : "Druid"
	elseif evt.Cmp("ClassIs", const.Class.ArchDruid) then
		evt.SetNPCTopic{NPC = 1249, Index = 0, Event = 820}         -- "The Coding Wizard" : "Archer"
		evt.SetNPCTopic{NPC = 1249, Index = 1, Event = 831}         -- "The Coding Wizard" : "Monk"
		evt.SetNPCTopic{NPC = 1249, Index = 2, Event = 806}         -- "The Coding Wizard" : "Sorcerer"
	elseif evt.Cmp("ClassIs", const.Class.Champion) then
		evt.SetNPCTopic{NPC = 1249, Index = 0, Event = 820}         -- "The Coding Wizard" : "Archer"
		evt.SetNPCTopic{NPC = 1249, Index = 1, Event = 826}         -- "The Coding Wizard" : "Ranger"
		evt.SetNPCTopic{NPC = 1249, Index = 2, Event = 825}         -- "The Coding Wizard" : "Druid"
	elseif evt.Cmp("ClassIs", const.Class.Master) then
		evt.SetNPCTopic{NPC = 1249, Index = 0, Event = 832}         -- "The Coding Wizard" : "Thief"
		evt.SetNPCTopic{NPC = 1249, Index = 1, Event = 825}         -- "The Coding Wizard" : "Druid"
		evt.SetNPCTopic{NPC = 1249, Index = 2, Event = 820}         -- "The Coding Wizard" : "Archer"
	elseif evt.Cmp("ClassIs", const.Class.Hero) then
		evt.SetNPCTopic{NPC = 1249, Index = 0, Event = 825}         -- "The Coding Wizard" : "Druid"
		evt.SetNPCTopic{NPC = 1249, Index = 1, Event = 826}         -- "The Coding Wizard" : "Ranger"
		evt.SetNPCTopic{NPC = 1249, Index = 2, Event = 820}         -- "The Coding Wizard" : "Archer"
	elseif evt.Cmp("ClassIs", const.Class.RangerLord) then
		evt.SetNPCTopic{NPC = 1249, Index = 0, Event = 820}         -- "The Coding Wizard" : "Archer"
		evt.SetNPCTopic{NPC = 1249, Index = 1, Event = 836}         -- "The Coding Wizard" : "Paladin"
		evt.SetNPCTopic{NPC = 1249, Index = 2, Event = 832}         -- "The Coding Wizard" : "Thief"
	else
		if not evt.Cmp("ClassIs", const.Class.Spy) then
			evt.Subtract("QBits", 861)         -- One Use
			evt.SetMessage(978)         -- "You don't Qualify"
			return
		end
		evt.SetNPCTopic{NPC = 1249, Index = 0, Event = 820}         -- "The Coding Wizard" : "Archer"
		evt.SetNPCTopic{NPC = 1249, Index = 1, Event = 819}         -- "The Coding Wizard" : "Fighter"
		evt.SetNPCTopic{NPC = 1249, Index = 2, Event = 831}         -- "The Coding Wizard" : "Monk"
	end
	evt.SetNPCTopic{NPC = 1249, Index = 3, Event = 873}         -- "The Coding Wizard" : "No Thanks."
end

-- "Crusader"
Game.GlobalEvtLines:RemoveEvent(801)
evt.global[801] = function()
	evt.ForPlayer("Current")
	evt.SetMessage(1012)         -- "If you wish to be promoted to Crusader, you must first bring me the map that indicates the location of Sir BunGleau's panoply. Here, take this scroll of the Saints.  It will provide you with a firm foundation as you begin your quest."
	evt.Set("QBits", 534)         -- "Find the map that shows the location of Sir BunGleau's panoply and return it to the Massenger of the Saints.."
	evt.Add("Inventory", 1532)         -- "Saints of Selinas Scroll 2"
	evt.SetNPCGreeting{NPC = 1243, Greeting = 125}         -- "Messenger of the Saints" : "Greetings again, friends."
	evt.SetNPCTopic{NPC = 1243, Index = 0, Event = 802}         -- "Messenger of the Saints" : "Crusader"
end

-- "Crusader"
Game.GlobalEvtLines:RemoveEvent(802)
evt.global[802] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 1541) then         -- "Map to Treasure"
		evt.SetMessage(1014)         -- "You must bring the map to me before I can name thee Crusaders."
		return
	end
	evt.SetMessage(1013)         -- "Ahh!  I see you've completed your quest and have returned with the map.  May the Saints be praised! I hereby promote all Paladins to Crusaders, and all others to Honorary Crusaders!  Congratulations!"
	for pl = 0, Party.High do
		evt.ForPlayer(pl)
		if evt.Cmp("ClassIs", const.Class.Paladin) then
			evt.Set("ClassIs", const.Class.Crusader)
			evt.Add("QBits", 1590)         -- "Promoted to Crusader"
			evt.Add("Experience", 30000)
		else
			evt.Add("QBits", 1591)         -- "Promoted to Honorary Crusader"
			evt.Add("Experience", 15000)
		end
	end
	evt.Subtract("QBits", 534)         -- "Find the map that shows the location of Sir BunGleau's panoply and return it to the Massenger of the Saints.."
	evt.Subtract("NPCs", 356)         -- "Sally"
	evt.Subtract("Inventory", 1541)         -- "Map to Treasure"
	evt.Subtract("Inventory", 1531)         -- "Saints of Selinas Scroll 1"
	evt.Subtract("Inventory", 1535)         -- "Saints of Selinas Scroll 5"
	evt.Subtract("Inventory", 1532)         -- "Saints of Selinas Scroll 2"
	evt.Subtract("Inventory", 1537)         -- "Saints of Selinas Scroll 6"
	evt.Subtract("Inventory", 1533)         -- "Saints of Selinas Scroll 3"
	evt.Subtract("Inventory", 1534)         -- "Saints of Selinas Scroll 4"
	evt.ForPlayer("All")
	evt.SetNPCTopic{NPC = 1243, Index = 0, Event = 803}         -- "Messenger of the Saints" : "Hero"
end

-- "Hero"
Game.GlobalEvtLines:RemoveEvent(803)
evt.global[803] = function()
	if evt.Cmp("QBits", 611) then         -- Chose the path of Light
		evt.SetMessage(1015)         -- "I am pleased to see you have chosen the path of Light, Crusaders!  It is now time to retrieve the panoply of Sir BunGleau and once again employ it in the fight against the Dark!!  To accomplish this you must return to Emerald Island and drink from the Well of Luck.  This will transport you to the Place of Hiding where you will find the panoply.  Return to me with this panoply to complete your promotion.  ** Oh ... beware of the Blue Guardians!! *"
		evt.SetNPCTopic{NPC = 1243, Index = 0, Event = 804}         -- "Messenger of the Saints" : "Hero"
		evt.Set("QBits", 536)         -- "Find the Blessed Panoply of Sir BunGleau and return to the Angel in Castle Harmondale""
		evt.SetNPCGreeting{NPC = 1243, Greeting = 125}         -- "Messenger of the Saints" : "Greetings again, friends."
	elseif evt.Cmp("QBits", 612) then         -- Chose the path of Dark
		evt.SetMessage(1016)         -- "I will not have truck with thee further, scoundrel!  I see now thee hath chosen the path of Darkness.  Mayhaps thee should seek a villain like thyself for training."
	else
		evt.SetMessage(1017)         -- "Ah, my Crusader friends!  I know you seek another task with which to hone your Crusading skills, but first you must pass a far more serious test.  You must agree to follow the Path of Light before I can help you further.  You will know when you have made this choice.  Return to me then."
	end
end

-- "Hero"
Game.GlobalEvtLines:RemoveEvent(804)
evt.global[804] = function()
	if not evt.Cmp("Inventory", 1359) then         -- "SBG's Blessed Gauntlets"
		evt.SetMessage(1019)         -- "Though your deeds remain impressive indeed, crusaders, I cannot declare you Heroes until you return the panoply to me."
		return
	end
	evt.SetMessage(1018)         -- "You’ve done it! I knew you could do it!  I’m so proud of you!  Another victory for the Light!  You can keep the panoply and use it for Truth, Justice, and the Erathian way! [The Angel sighs and smiles broadly] Well.  My work here is done!  You have passed the tests and deserve your reward.  Therefore do I solemnly declare you Heroes! "
	for pl = 0, Party.High do
		evt.ForPlayer(pl)
		if evt.Cmp("ClassIs", const.Class.Crusader) then
			evt.Set("ClassIs", const.Class.Hero)
			evt.Add("QBits", 1592)         -- "Promoted to Hero"
			evt.Add("Experience", 80000)
		else
			evt.Add("QBits", 1593)         -- "Promoted to Honorary Hero"
			evt.Add("Experience", 40000)
		end
	end
	evt.Subtract("QBits", 536)         -- "Find the Blessed Panoply of Sir BunGleau and return to the Angel in Castle Harmondale""
	evt.Subtract("NPCs", 393)         -- "Alice Hargreaves"
	evt.Subtract("Reputation", 10)
	evt.ForPlayer("All")
	evt.SetNPCGreeting{NPC = 1243, Greeting = 161}         -- "Messenger of the Saints" : "Salutations Heroes!  I am certain thou hast much to accomplish before we dally about."
	evt.SetMonGroupBit{NPCGroup = 56, Bit = const.MonsterBits.Invisible, On = true}         -- "Generic Monster Group for Dungeons"
	evt.SetNPCTopic{NPC = 1243, Index = 0, Event = 0}         -- "Messenger of the Saints"
	evt.Set("QBits", 885)         -- Harm no respawn
end

-- "Hello?"
Game.GlobalEvtLines:RemoveEvent(805)
evt.global[805] = function()
	if evt.Cmp("QBits", 611) then         -- Chose the path of Light
		if evt.Cmp("QBits", 537) then         -- Mini-dungeon Area 5.  Rescued/Captured Alice Hargreaves.
			evt.SetMessage(1023)         -- "Adventurer 3, select your new profession."
		else
			evt.SetMessage(1022)         -- "Adventurer 2, select your new profession."
			evt.Set("QBits", 537)         -- Mini-dungeon Area 5.  Rescued/Captured Alice Hargreaves.
			evt.Set("NPCs", 393)         -- "Alice Hargreaves"
		end
	elseif not evt.Cmp("QBits", 612) then         -- Chose the path of Dark
		evt.SetMessage(1021)         -- "Adventurer 1, select your new profession."
	elseif evt.Cmp("QBits", 537) then         -- Mini-dungeon Area 5.  Rescued/Captured Alice Hargreaves.
		evt.SetMessage(1025)         -- "There ya go!  Now return this scroll to Lord Godwinson to complete this quest.  Then he’ll know that I am more than a myth."
	else
		evt.SetMessage(1024)         -- "Adventurer 4, select your new profession."
		evt.Set("QBits", 537)         -- Mini-dungeon Area 5.  Rescued/Captured Alice Hargreaves.
		evt.Set("NPCs", 393)         -- "Alice Hargreaves"
	end
end

-- "Sorcerer"
Game.GlobalEvtLines:RemoveEvent(806)
evt.global[806] = function()
	evt.ForPlayer("All")
	evt.Set("QBits", 851)         -- Sorcerer
	evt.SetNPCTopic{NPC = 1249, Index = 0, Event = 0}         -- "The Coding Wizard"
	evt.SetNPCTopic{NPC = 1249, Index = 1, Event = 0}         -- "The Coding Wizard"
	evt.SetNPCTopic{NPC = 1249, Index = 2, Event = 0}         -- "The Coding Wizard"
	evt.SetMessage(979)         -- "Proceed to the Brazier to acquire your new profession."
end

-- "Cleric"
Game.GlobalEvtLines:RemoveEvent(807)
evt.global[807] = function()
	evt.ForPlayer("All")
	evt.Set("QBits", 852)         -- Cleric
	evt.SetNPCTopic{NPC = 1249, Index = 0, Event = 0}         -- "The Coding Wizard"
	evt.SetNPCTopic{NPC = 1249, Index = 1, Event = 0}         -- "The Coding Wizard"
	evt.SetNPCTopic{NPC = 1249, Index = 2, Event = 0}         -- "The Coding Wizard"
	evt.SetMessage(979)         -- "Proceed to the Brazier to acquire your new profession."
end

-- "Initiate"
Game.GlobalEvtLines:RemoveEvent(808)
evt.global[808] = function()
	evt.SetMessage(1031)         -- "Ah, it is normal for novice Monks to ask for the path of enlightenment.  I shall tell you of the path, though the journey is yours to make.  In the Barrow Downs is a series of tombs-- one of which was constructed on a site of great natural power.  You will know the right barrow because it is different from the rest.  Reach this barrow and meditate by the water, and your promotion to Initiate will be complete."
	evt.Set("QBits", 539)         -- "Find the lost meditation spot in the Dwarven Barrows."
	evt.SetNPCTopic{NPC = 377, Index = 1, Event = 809}         -- "Bartholomew Hume" : "Initiate"
end

-- "Initiate"
Game.GlobalEvtLines:RemoveEvent(809)
evt.global[809] = function()
	evt.SetMessage(1033)         -- "You have not finished your journey.  Return to me only when you have completed your task."
end

-- "Initiate"
Game.GlobalEvtLines:RemoveEvent(810)
evt.global[810] = function()
	evt.SetMessage(1032)         -- "[Bartholomew Hume contacts you mentally] Congratulations, young ones.  My final lesson given to you as Monks is this:  enlightenment is gained by the journey, not the destination.  In this case, the destination was critical to prove that you were capable of the journey.  I shall now promote all Monks to Initiates and everyone else to Honorary Initiates-- congratulations."
	for pl = 0, Party.High do
		evt.ForPlayer(pl)
		if evt.Cmp("ClassIs", const.Class.Monk) then
			evt.Set("ClassIs", const.Class.Initiate)
			evt.Add("QBits", 1572)         -- "Promoted to Initiate"
			evt.Add("Experience", 30000)
		else
			evt.Add("QBits", 1573)         -- "Promoted to Honorary Initiate"
			evt.Add("Experience", 15000)
		end
	end
	evt.Subtract("QBits", 539)         -- "Find the lost meditation spot in the Dwarven Barrows."
	evt.ForPlayer("All")
	evt.SetNPCTopic{NPC = 377, Index = 1, Event = 811}         -- "Bartholomew Hume" : "Master"
	evt.SetNPCTopic{NPC = 394, Index = 0, Event = 0}         -- "Bartholomew Hume"
end

-- "Master"
Game.GlobalEvtLines:RemoveEvent(811)
evt.global[811] = function()
	if evt.Cmp("QBits", 612) then         -- Chose the path of Dark
		evt.SetMessage(1035)         -- "I am sorry, but I am permitted to train you no longer.  You will need to find a new Master to learn from."
	elseif evt.Cmp("QBits", 611) then         -- Chose the path of Light
		evt.SetMessage(1034)         -- "I see you wish to continue your journey.  Excellent!  Have no fear, for you are prepared for your next step.  You must extinguish the remnants of an evil order- the Order of Baa.  Defeat their High Priest and return to me and I shall complete your training and promote you to Master."
		evt.Set("QBits", 540)         -- "Go to the Temple of Baa in Avlee and kill the High Priest of Baa, then return to Bartholomew Hume in Harmondale."
		evt.SetNPCTopic{NPC = 377, Index = 1, Event = 812}         -- "Bartholomew Hume" : "Master"
	else
		evt.SetMessage(1036)         -- "A fork approaches in your path.  I will only train you after you've chosen to walk the lighter path."
	end
end

-- "Master"
Game.GlobalEvtLines:RemoveEvent(812)
evt.global[812] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 755) then         -- Killed High Preist of Baa
		evt.SetMessage(1073)         -- "The Temple of Baa still stands, their High Priest still lives.  Until this is completed, you are not ready for the title of Master.  Go now and do not fail."
		return
	end
	evt.SetMessage(1072)         -- "Good work.  No longer shall the Order of Baa stain the lands of Erathia.  Now, allow me to promote all Initiates to Masters, and all Honorary Initiates to Honorary Masters.  Keep in mind that this is but a stop along the path of enlightenment.  Your journey only ends with your eventual death-- never close your mind."
	for pl = 0, Party.High do
		evt.ForPlayer(pl)
		if evt.Cmp("ClassIs", const.Class.Initiate) then
			evt.Set("ClassIs", const.Class.Master)
			evt.Add("QBits", 1574)         -- "Promoted to Master"
			evt.Add("Experience", 80000)
		else
			evt.Add("QBits", 1575)         -- "Promoted to Honorary Master"
			evt.Add("Experience", 40000)
		end
	end
	evt.Add("Gold", 7500)
	evt.Subtract("QBits", 540)         -- "Go to the Temple of Baa in Avlee and kill the High Priest of Baa, then return to Bartholomew Hume in Harmondale."
	evt.Subtract("Reputation", 10)
	evt.ForPlayer("All")
	evt.SetNPCTopic{NPC = 377, Index = 1, Event = 0}         -- "Bartholomew Hume"
	evt.SetNPCGreeting{NPC = 377, Greeting = 167}         -- "Bartholomew Hume" : "Greetings again, Masters.  How can Bartholomew aid you?"
end

-- "Quest"
Game.GlobalEvtLines:RemoveEvent(813)
evt.global[813] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 1354) then         -- "Grognard's Cutlass"
		evt.SetMessage(991)         -- "I see you’ve cleared the area of Goblins and have returned with Grognard’s Cutlass.  Good job!  The stables will now renew our services."
		evt.Set("Awards", 126)         -- "Reopened Harmondale Stables"
		evt.Add("Experience", 7500)
		evt.Add("Gold", 500)
		evt.Subtract("QBits", 895)         -- "Bring the Grognard's Cutlass to Christian at the J.V.C Corral."
		evt.SetNPCTopic{NPC = 1254, Index = 0, Event = 0}         -- "Christian the Stablemaster"
	else
		evt.SetMessage(940)         --[[ "The Stable Guild has discovered that a raiding force of Goblins, lead by the infamous Grognard, is poised to launch an incursion into Harmondale.  Until this threat is ‘neutralized’, the stables will remain closed.

The Guild has intercepted and ‘detained’ a Goblin courier who has revealed that the Goblin force will launch their attack shortly after ‘signal fires’ are lighted.  Don’t know about these ‘signal fires’, but if you can find them, light them, and then ambush the invasion force, perhaps you could deal with this threat decisively.

If you will ‘neutralize’ this threat and bring me proof that it is safe once again to renew our services, I will re-open the stables.  The proof I will need is the Grognard’s Cutlass carried by the Goblin leader." ]]
		evt.Set("QBits", 895)         -- "Bring the Grognard's Cutlass to Christian at the J.V.C Corral."
	end
end

-- "Ninja"
Game.GlobalEvtLines:RemoveEvent(814)
evt.global[814] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 754) then         -- Opened chest with shadow mask
		if evt.Cmp("QBits", 569) then         -- Solved the code puzzle.  Ninja promo quest
			evt.SetMessage(1078)         -- "So you have the key, but you haven't followed the directions in the message.  Remember, the tomb is in Southern Erathia.  Complete your task, and return to me to report success.  If you can't complete your mission, don't bother returning to me.  Failure is pathetic."
		else
			evt.SetMessage(1079)         -- "[Sand sighs] Once again, the cipher key is the third word of the first paragraph of the Scroll of Waves.  You can find it somewhere in the School of Wizardry.  I don't care how you get in there--kill anyone who gets in your way, or sneak in.  Whatever you want.  The only thing that matters is success.  Everything else is an excuse for personal weakness."
		end
		return
	end
	evt.SetMessage(1080)         -- "Well done.  No one can argue with success except apologists for the weak and the cowardly.  I hearby promote all Initiates to Ninjas, and all non-Initiates to Honorary Ninjas.  Oh yeah, go ahead and keep that little trinket you stole from the tomb.  This was just a training exercise, after all."
	for pl = 0, Party.High do
		evt.ForPlayer(pl)
		if evt.Cmp("ClassIs", const.Class.Initiate) then
			evt.Set("ClassIs", const.Class.Ninja)
			evt.Add("Awards", 126)         -- "Reopened Harmondale Stables"
			evt.Add("Experience", 80000)
		else
			evt.Add("QBits", 1577)         -- "Promoted to Honorary Ninja"
			evt.Add("Experience", 40000)
		end
	end
	evt.Subtract("QBits", 541)         -- "Kill the creatures in the Kennel and return to Queen Catherine with the Journal of Experiments.."
	evt.Subtract("Reputation", 10)
	evt.ForPlayer("All")
	evt.SetNPCTopic{NPC = 378, Index = 0, Event = 0}         -- "Stephan Sand"
	evt.SetNPCGreeting{NPC = 378, Greeting = 170}         -- "Stephan Sand" : "Now that you've achieved the exaulted status of Ninja, I have nothing further to give you.  I hope my teachings take you far."
end

-- "Master Archer"
Game.GlobalEvtLines:RemoveEvent(815)
evt.global[815] = function()
	if not evt.Cmp("QBits", 1584) then         -- "Promoted to Warrior Mage"
		if not evt.Cmp("QBits", 1585) then         -- "Promoted to Honorary Warrior Mage"
			evt.SetMessage(1084)         -- "I am the person to see if you want to become Master Archers, but you have come too soon!  You must have the proper background to become a Master, and that means first becoming a warrior mage.  Return when you are ready."
			return
		end
	end
	if evt.Cmp("QBits", 611) then         -- Chose the path of Light
		evt.SetMessage(1081)         -- "A few generations ago, an enchanted bow was created by alchemists in the Tularean Forest to seal another peace treaty between the elves and the humans.  While en route to Erathia, the bow was taken from the couriers by the Titans in Avlee.  They have no use for the thing, so it's probably in their stronghold still.  Strike a blow for our profession, and get that bow back.  It is absolutely the finest thing of its kind ever made.  Oh, and while you're there, feel free to cut some of those bullies down to size--They stole it out of cruelty, not need!  If you are successful, I will promote all Warrior Mages to Master Archers, or honorary Master Archers, as the case may be."
		evt.Add("QBits", 542)         -- "Retrieve the Perfect Bow from the Titans' Stronghold in Avlee and return it to Lawrence Mark in Harmondale."
		evt.SetNPCTopic{NPC = 379, Index = 0, Event = 816}         -- "Lawrence Mark" : "Master Archer"
	elseif evt.Cmp("QBits", 612) then         -- Chose the path of Dark
		evt.SetMessage(1083)         -- "You have chosen the path of Darkness.  I will never help you improve, for fear you will use your skills to advance your selfish goals!"
	else
		evt.SetMessage(1082)         -- "So, you've achieved the rank of Warrior Mage, and wish to advance to Master Archer!  A worthy goal, but I only promote those who's heart and courage match their skill.  Come back to me when you have firmly committed to the Light.  Then I will help you."
	end
end

-- "Master Archer"
Game.GlobalEvtLines:RemoveEvent(816)
evt.global[816] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 1344) then         -- "The Perfect Bow"
		evt.SetMessage(1086)         -- "No luck getting the bow?  Well, take your time, and plan your assault against the Titans carefully.  Against such powerful opponents, there is no shame in striking and retreating.  Do what you must to defeat these monsters."
		return
	end
	evt.SetMessage(1085)         -- "You found the bow!  Let me take some measurements and adjust it to your specific style of archery. Once I have finished you should keep it, and use it in defense the of the land and the people.  I am happy to promote all Warrior Mages to Master Archers, and all Honorary Warrior Mages to Honorary Master Archers."
	for pl = 0, Party.High do
		evt.ForPlayer(pl)
		if evt.Cmp("ClassIs", const.Class.WarriorMage) then
			evt.Set("ClassIs", const.Class.MasterArcher)
			evt.Add("QBits", 1586)         -- "Promoted to Master Archer"
			evt.Add("Experience", 80000)
		else
			evt.Add("QBits", 1587)         -- "Promoted to Honorary Master Archer"
			evt.Add("Experience", 40000)
		end
	end
	evt.Subtract("QBits", 542)         -- "Retrieve the Perfect Bow from the Titans' Stronghold in Avlee and return it to Lawrence Mark in Harmondale."
	evt.Add("Inventory", 1345)         -- "The Perfect Bow"
	evt.Subtract("Reputation", 10)
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 1344) then         -- "The Perfect Bow"
		evt.Subtract("Inventory", 1344)         -- "The Perfect Bow"
	end
	evt.SetNPCTopic{NPC = 379, Index = 0, Event = 0}         -- "Lawrence Mark"
	evt.SetNPCGreeting{NPC = 379, Greeting = 172}         -- "Lawrence Mark" : "Welcome my friends!  That's a fine weapon you have there, but don't think for a moment you'll best me in this year's Tourney--I'm still the Master!"
end

-- "Warrior Mage"
Game.GlobalEvtLines:RemoveEvent(817)
evt.global[817] = function()
	evt.SetMessage(1087)         -- "So you want to become Warrior Mages, do you?  It isn't easy.  You must be equally proficient in magical skills and physical skills.  There is a test of this.  Visit the Red Dwarf Mines.  Inside you will find two kinds of beasts--one that can be harmed only with magic, and one that can be harmed only with steel.  In the back of the lower section of the mines you will find a machine created by the Dwarves that powers the lift-- the only access between the upper and lower sections of the mines.  To keep the creatures trapped in the lower section, you will have to replace the belt in the machine with this one, a worn belt that will only last about an hour before breaking.  This should give you enough time to get to the lift and get out before you are trapped down there.  Seal away these creatures and return to me-- only then will I call you Warrior Mages."
	evt.Add("Inventory", 1451)         -- "Worn Belt"
	evt.Add("QBits", 543)         -- "Sabotage the lift in the Red Dwarf Mines in the Bracada Desert then return to Zedd True Shot on Emerald Island."
	evt.Add("QBits", 728)         -- Worn Belt - I lost it
	evt.SetNPCTopic{NPC = 360, Index = 1, Event = 818}         -- "Zedd True Shot" : "Warrior Mage"
end

-- "Warrior Mage"
Game.GlobalEvtLines:RemoveEvent(818)
evt.global[818] = function()
	if not evt.Cmp("QBits", 570) then         -- Destroyed critter generator in dungeon.  Warrior Mage promo quest.
		evt.SetMessage(1089)         -- "You haven't sabotaged the machine yet.  You must finish this before I'll promote you to Warrior Mage."
		return
	end
	evt.SetMessage(1088)         -- "Very Good.  You have passed the test.  Now the creatures are sealed away and won't be able to prey on the dwarves any longer, and you have proven your ability in both sorcery and steel.  I am proud to declare all Archers amongst you Warrior Mages, and everyone else Honorary Warrior Mages.  Congratulations!  See you later in 'The Game'. "
	for pl = 0, Party.High do
		evt.ForPlayer(pl)
		if evt.Cmp("ClassIs", const.Class.Archer) then
			evt.Set("ClassIs", const.Class.WarriorMage)
			evt.Add("QBits", 1584)         -- "Promoted to Warrior Mage"
			evt.Add("Experience", 30000)
		else
			evt.Add("QBits", 1585)         -- "Promoted to Honorary Warrior Mage"
			evt.Add("Experience", 15000)
		end
	end
	evt.Subtract("QBits", 543)         -- "Sabotage the lift in the Red Dwarf Mines in the Bracada Desert then return to Zedd True Shot on Emerald Island."
	evt.Add("Gold", 7500)
	evt.Subtract("Reputation", 5)
	evt.ForPlayer("All")
	evt.SetNPCTopic{NPC = 360, Index = 1, Event = 0}         -- "Zedd True Shot"
end

-- "Fighter"
Game.GlobalEvtLines:RemoveEvent(819)
evt.global[819] = function()
	evt.ForPlayer("All")
	evt.Set("QBits", 853)         -- Fighter
	evt.SetNPCTopic{NPC = 1249, Index = 0, Event = 0}         -- "The Coding Wizard"
	evt.SetNPCTopic{NPC = 1249, Index = 1, Event = 0}         -- "The Coding Wizard"
	evt.SetNPCTopic{NPC = 1249, Index = 2, Event = 0}         -- "The Coding Wizard"
	evt.SetMessage(979)         -- "Proceed to the Brazier to acquire your new profession."
end

-- "Archer"
Game.GlobalEvtLines:RemoveEvent(820)
evt.global[820] = function()
	evt.ForPlayer("All")
	evt.Set("QBits", 858)         -- Archer
	evt.SetNPCTopic{NPC = 1249, Index = 0, Event = 0}         -- "The Coding Wizard"
	evt.SetNPCTopic{NPC = 1249, Index = 1, Event = 0}         -- "The Coding Wizard"
	evt.SetNPCTopic{NPC = 1249, Index = 2, Event = 0}         -- "The Coding Wizard"
	evt.SetMessage(979)         -- "Proceed to the Brazier to acquire your new profession."
end

-- "Champion"
Game.GlobalEvtLines:RemoveEvent(821)
evt.global[821] = function()
	if not evt.Cmp("QBits", 1566) then         -- "Promoted to Cavalier"
		if not evt.Cmp("QBits", 1567) then         -- "Promoted to Honorary Cavalier"
			evt.SetMessage(1098)         -- "I am the person to talk to if you want to be called Champions.  First, though, you must practice.  Return to me when you've become Cavaliers.  Then, if you have the right outlook, I will tell you what you must do to become Champions."
			return
		end
	end
	if evt.Cmp("QBits", 612) then         -- Chose the path of Dark
		evt.SetMessage(1097)         -- "Call you Champions?  Never!  The only reason I'm not hacking you evil doers to bits is that you came here peacefully.  Leave now, before I change my mind and rid the world of another problem."
	elseif evt.Cmp("QBits", 611) then         -- Chose the path of Light
		evt.SetMessage(1095)         -- "So you want to be champions, do you?  Ha!  How can you be a champion if you don't win any tournaments?  You know, I can't really promote you to Champion status--you have to do it yourself, just like everything else.  Go and win five championship tournaments in the Arena at Knight level, and come back to me.  I'll call you Champions then, if you want."
		evt.Set("QBits", 545)         -- "Win five arena challenges then return to Leda Rowan in the Bracada Desert."
		evt.SetNPCTopic{NPC = 381, Index = 0, Event = 822}         -- "Leda Rowan" : "Champion"
	else
		evt.SetMessage(1096)         -- "I can see you very much want to be called Champions, but I'm not so sure I should help you.  Prove to me that you follow the Path of Light, and then we'll talk about promotion."
	end
end

-- "Champion"
Game.GlobalEvtLines:RemoveEvent(822)
evt.global[822] = function()
	if not evt.Cmp("ArenaWinsKnight", 5) then
		evt.SetMessage(1100)         -- "You have not yet won 5 championship tournaments in the Arena.  Return to me when you have won five, and I will promote you.  Remember, these battles MUST be at the Knight difficulty level."
		return
	end
	evt.SetMessage(1099)         -- "Congratulations for you recent tourney victories, my friends!  I gladly name the Cavaliers among you Champions, and the Honorary Cavaliers I name Honorary Champions!  Always fight for the Light, Champions!"
	for pl = 0, Party.High do
		evt.ForPlayer(pl)
		if evt.Cmp("ClassIs", const.Class.Cavalier) then
			evt.Set("ClassIs", const.Class.Champion)
			evt.Add("QBits", 1568)         -- "Promoted to Champion"
			evt.Add("Experience", 80000)
		else
			evt.Add("QBits", 1569)         -- "Promoted to Honorary Champion"
			evt.Add("Experience", 40000)
		end
	end
	evt.Subtract("QBits", 545)         -- "Win five arena challenges then return to Leda Rowan in the Bracada Desert."
	evt.Subtract("Reputation", 10)
	evt.ForPlayer("All")
	evt.SetNPCTopic{NPC = 381, Index = 0, Event = 0}         -- "Leda Rowan"
	evt.SetNPCGreeting{NPC = 381, Greeting = 176}         -- "Leda Rowan" : "Hail, champions!  Your courage and skill has all the tongues in the Kingdom wagging!  I am very proud of you!"
end

-- "Cavalier"
Game.GlobalEvtLines:RemoveEvent(823)
evt.global[823] = function()
	evt.SetMessage(1101)         -- "The hallmark of the Cavalier is courage.  I can promote you to Cavalier status, but before I'll do that, you'll have to prove to me your bravery in battle.  Since most people are yellow bellied cowards at heart, I doubt you'll succeed.  But if you want to try, here is what you must do: Destroy all the undead in the haunted mansion in the Barrow Downs."
	evt.Set("QBits", 546)         -- "Destroy all the undead in the Haunted House in the Barrow Downs and return to Frederick Org in Erathia."
	evt.SetNPCTopic{NPC = 382, Index = 0, Event = 824}         -- "Frederick Org" : "Cavalier"
end

-- "Cavalier"
Game.GlobalEvtLines:RemoveEvent(824)
evt.global[824] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 652) then         -- Cleaned out the haunted mansion (Cavalier promo)
		evt.SetMessage(1103)         -- "Did one little haunted house send you packing in fear?  I've seen chocolate eclairs with more backbone than you!  Get you gone, and don't come back 'til you've stiffened your spine!"
		return
	end
	evt.SetMessage(1102)         -- "So you're back!  And from the look on your faces I see you have finished the job.  Well done!  I hereby officially promote all Knights amongst you to Cavaliers, and everyone else to honorary Cavaliers.  Carry your title with pride!"
	for pl = 0, Party.High do
		evt.ForPlayer(pl)
		if evt.Cmp("ClassIs", const.Class.Knight) then
			evt.Set("ClassIs", const.Class.Cavalier)
			evt.Add("QBits", 1566)         -- "Promoted to Cavalier"
			evt.Add("Experience", 30000)
		else
			evt.Add("QBits", 1567)         -- "Promoted to Honorary Cavalier"
			evt.Add("Experience", 15000)
		end
	end
	evt.Subtract("QBits", 546)         -- "Destroy all the undead in the Haunted House in the Barrow Downs and return to Frederick Org in Erathia."
	evt.Subtract("Reputation", 5)
	evt.ForPlayer("All")
	evt.SetNPCTopic{NPC = 382, Index = 0, Event = 0}         -- "Frederick Org"
	evt.MoveNPC{NPC = 382, HouseId = 0}         -- "Frederick Org"
end

-- "Druid"
Game.GlobalEvtLines:RemoveEvent(825)
evt.global[825] = function()
	evt.ForPlayer("All")
	evt.Set("QBits", 859)         -- Druid
	evt.SetNPCTopic{NPC = 1249, Index = 0, Event = 0}         -- "The Coding Wizard"
	evt.SetNPCTopic{NPC = 1249, Index = 1, Event = 0}         -- "The Coding Wizard"
	evt.SetNPCTopic{NPC = 1249, Index = 2, Event = 0}         -- "The Coding Wizard"
	evt.SetMessage(979)         -- "Proceed to the Brazier to acquire your new profession."
end

-- "Ranger"
Game.GlobalEvtLines:RemoveEvent(826)
evt.global[826] = function()
	evt.ForPlayer("All")
	evt.Set("QBits", 857)         -- Ranger
	evt.SetNPCTopic{NPC = 1249, Index = 0, Event = 0}         -- "The Coding Wizard"
	evt.SetNPCTopic{NPC = 1249, Index = 1, Event = 0}         -- "The Coding Wizard"
	evt.SetNPCTopic{NPC = 1249, Index = 2, Event = 0}         -- "The Coding Wizard"
	evt.SetMessage(979)         -- "Proceed to the Brazier to acquire your new profession."
end

-- "Ranger Lord"
Game.GlobalEvtLines:RemoveEvent(827)
evt.global[827] = function()
	if not evt.Cmp("QBits", 1578) then         -- "Promoted to Hunter"
		if not evt.Cmp("QBits", 1579) then         -- "Promoted to Honorary Hunter"
			evt.SetMessage(1111)         -- "[Lysander shakes his head, smiling gently] Too soon, eager ones.  I train only the most advanced students.  Seek me out again when you reach Hunter status."
			return
		end
	end
	if evt.Cmp("QBits", 611) then         -- Chose the path of Light
		evt.SetMessage(1109)         -- "Well, it looks like you might be able to do the job I have in mind.  The fundamental task a Ranger Lord faces is caring for the land.  Recently, poachers removed a magical gemstone called the ""heart of the forest"" from the Tularean Forest.  The forest has become restless, and attacks travelers who come too close.  The forest blames all 'Walkers' for the theft, and won't calm down until the stone is returned.  Find the stone and return it to the oldest tree in the Forest.  Come back to me when you've done this."
		evt.Set("QBits", 548)         -- "Calm the trees in the Tularean Forest by speaking to the Oldest Tree then return to Lysander Sweet in the Bracada Desert."
		evt.SetNPCTopic{NPC = 383, Index = 0, Event = 828}         -- "Lysander Sweet" : "Ranger Lord"
	elseif evt.Cmp("QBits", 612) then         -- Chose the path of Dark
		evt.SetMessage(1112)         -- "[Lysander frowns] You've chosen the path of darkness.  I refuse to teach such as you--you would only use my lessons to further your selfish goals.  May Heaven have mercy on your souls."
	else
		evt.SetMessage(1110)         -- "I would like to be your teacher--I really would, but I'm not sure you're cut out to be a Ranger Lord.  Soon you must make a decision of the heart.  If you choose the Path of Light, return to me.  I would be honored to be your teacher."
	end
end

-- "Ranger Lord"
Game.GlobalEvtLines:RemoveEvent(828)
evt.global[828] = function()
	if not evt.Cmp("QBits", 553) then         -- Solved Tree quest
		if evt.Cmp("QBits", 552) then         -- Talked to the Oldest Tree
			evt.SetMessage(1114)         -- "Well, you've spoken with the tree, and now know as much as I do about the theft.  If you manage to find the stone, take it directly to the tree and then come see me."
		else
			evt.SetMessage(1113)         -- "If you can't figure out where to start, you should try finding the oldest tree in the forest.  It should be somewhere outside of Pierpont in Avlee.  The oldest tree has the power of speech, and may know something helpful.  It will be happy to tell you whatever you want to hear, plus a whole lot more.  You'll see."
		end
		return
	end
	evt.SetMessage(1115)         -- "You've done a good thing, returning the Heart.  The forest is quieter now, and no longer attacks travelers.  You've probably saved many lives.  For service to the Land and the Light, I hereby promote all Hunters among you to Ranger Lords, and all honorary Hunters to honorary Ranger Lords!"
	for pl = 0, Party.High do
		evt.ForPlayer(pl)
		if evt.Cmp("ClassIs", const.Class.Hunter) then
			evt.Set("ClassIs", const.Class.RangerLord)
			evt.Add("QBits", 1580)         -- "Promoted to Ranger Lord"
			evt.Add("Experience", 80000)
		else
			evt.Add("QBits", 1581)         -- "Promoted to Honorary Ranger Lord"
			evt.Add("Experience", 40000)
		end
	end
	evt.Subtract("QBits", 548)         -- "Calm the trees in the Tularean Forest by speaking to the Oldest Tree then return to Lysander Sweet in the Bracada Desert."
	evt.Subtract("Reputation", 10)
	evt.ForPlayer("All")
	evt.SetNPCTopic{NPC = 383, Index = 0, Event = 0}         -- "Lysander Sweet"
	evt.SetNPCGreeting{NPC = 383, Greeting = 180}         -- "Lysander Sweet" : "Your good works have served the forest well.  And, I can see, the experience has served you well in turn.  May you continue to reap the rewards of your good deeds, my friends!"
end

-- "Hunter"
Game.GlobalEvtLines:RemoveEvent(829)
evt.global[829] = function()
	evt.SetMessage(1116)         -- "Think you can improve?  I have a test for you.  A hunter needs to understand the woods, and a hunter needs to be as skilled with magic as with a blade.  The best teachers for that are the faeries.  There's a faerie mound in Northern Avlee.  Figure out how to get in, and the Faeries will grant magic to the genuine rangers among you, meaning that they will be promoted to Hunter status.  The rest of you will be honorary hunters. "
	evt.Set("QBits", 549)         -- "Solve the secret to the entrance of the Faerie Mound in Avlee and speak to the Faerie King."
	evt.SetNPCTopic{NPC = 384, Index = 0, Event = 830}         -- "Ebednezer Sower" : "Hunter"
end

-- "Hunter"
Game.GlobalEvtLines:RemoveEvent(830)
evt.global[830] = function()
	evt.SetMessage(1117)         -- "Foxed by the Faeries? [Ebednezer snickers, then begins to laugh uproariously at his own wit] Foxed?  Faeries?  Hahahah!  Get it?  Foxed… you know…ah ahahah.  Maybe not.  Well, I've already told you how to become Hunters.  Get inside the Faerie Mound in Avlee.  Now, stop bothering me!  "
end

-- "Monk"
Game.GlobalEvtLines:RemoveEvent(831)
evt.global[831] = function()
	evt.ForPlayer("All")
	evt.Set("QBits", 855)         -- Monk
	evt.SetNPCTopic{NPC = 1249, Index = 0, Event = 0}         -- "The Coding Wizard"
	evt.SetNPCTopic{NPC = 1249, Index = 1, Event = 0}         -- "The Coding Wizard"
	evt.SetNPCTopic{NPC = 1249, Index = 2, Event = 0}         -- "The Coding Wizard"
	evt.SetMessage(979)         -- "Proceed to the Brazier to acquire your new profession."
end

-- "Thief"
Game.GlobalEvtLines:RemoveEvent(832)
evt.global[832] = function()
	evt.ForPlayer("All")
	evt.Set("QBits", 856)         -- Thief
	evt.SetNPCTopic{NPC = 1249, Index = 0, Event = 0}         -- "The Coding Wizard"
	evt.SetNPCTopic{NPC = 1249, Index = 1, Event = 0}         -- "The Coding Wizard"
	evt.SetNPCTopic{NPC = 1249, Index = 2, Event = 0}         -- "The Coding Wizard"
	evt.SetMessage(979)         -- "Proceed to the Brazier to acquire your new profession."
end

-- "Hunter?"
evt.CanShowTopic[833] = function()
	return evt.Cmp("QBits", 549)         -- "Solve the secret to the entrance of the Faerie Mound in Avlee and speak to the Faerie King."
end

Game.GlobalEvtLines:RemoveEvent(833)
evt.global[833] = function()
	evt.SetMessage(1123)         -- "Come to my door looking for magic?  Thee've always had it, if thee knew where to look.  Some I tell this to, and they still can't see it, though it be plain as the nose on their face.  Those amongst thee that are simple Rangers are now Hunters, and those who aren't are but Honorary Hunters.  Clever the ones who can knock on my door!"
	for pl = 0, Party.High do
		evt.ForPlayer(pl)
		if evt.Cmp("ClassIs", const.Class.Ranger) then
			evt.Set("ClassIs", const.Class.Hunter)
			evt.Add("QBits", 1578)         -- "Promoted to Hunter"
			evt.Add("Experience", 30000)
		else
			evt.Add("QBits", 1579)         -- "Promoted to Honorary Hunter"
			evt.Add("Experience", 15000)
		end
	end
	evt.Subtract("QBits", 549)         -- "Solve the secret to the entrance of the Faerie Mound in Avlee and speak to the Faerie King."
	evt.ForPlayer("All")
	evt.SetNPCTopic{NPC = 384, Index = 0, Event = 0}         -- "Ebednezer Sower"
	evt.SetNPCTopic{NPC = 391, Index = 0, Event = 0}         -- "Faerie King"
	evt.MoveNPC{NPC = 384, HouseId = 0}         -- "Ebednezer Sower"
end

-- "Heart of the Wood"
evt.CanShowTopic[834] = function()
	return evt.Cmp("QBits", 548)         -- "Calm the trees in the Tularean Forest by speaking to the Oldest Tree then return to Lysander Sweet in the Bracada Desert."
end

Game.GlobalEvtLines:RemoveEvent(834)
evt.global[834] = function()
	evt.SetMessage(1124)         -- "The thieves reached deep inside me to take my Heart.  The grapevines say they are hiding in the Mercenary Guild in Tatalia.  We would squeeze them, but they aren't close enough to reach.  Walkers are needed to catch walkers.  Catch the thieves for us.  Ok?"
	evt.Set("QBits", 551)         -- "Find the Heart of the Forest in the Mercenary Guild in Tatalia and return it to the Oldest Tree in the Tularean Forest."
	evt.SetNPCTopic{NPC = 392, Index = 0, Event = 835}         -- "The Oldest Tree" : "Heart of the Wood"
end

-- "Heart of the Wood"
Game.GlobalEvtLines:RemoveEvent(835)
evt.global[835] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 1402) then         -- "Heart of the Wood"
		evt.SetMessage(1125)         -- "Ahhh!  [The tree sighs happily]  You have the heart!  The forest sings with joy!  Tonight we will recite the song of the ancestors.  Will you stay and recite with us?"
		evt.Subtract("Inventory", 1402)         -- "Heart of the Wood"
		evt.Subtract("QBits", 729)         -- Heart of Wood - I lost it
		evt.Add("Experience", 5000)
		evt.Subtract("QBits", 551)         -- "Find the Heart of the Forest in the Mercenary Guild in Tatalia and return it to the Oldest Tree in the Tularean Forest."
		evt.Set("QBits", 553)         -- Solved Tree quest
		evt.SetNPCTopic{NPC = 392, Index = 0, Event = 0}         -- "The Oldest Tree"
		evt.SetNPCGreeting{NPC = 392, Greeting = 186}         -- "The Oldest Tree" : "Ohhhhh…It's the Walkers from the South.  I remember you!  You returned the Heart.  The trees are very happy, and promise not to kill any more walkers.  Come and talk to me any time."
		evt.Set("Awards", 23)         -- "Retrieved the Heart of the Wood"
		evt.SetMonGroupBit{NPCGroup = 61, Bit = const.MonsterBits.Hostile, On = false}         -- "Southern Village Group in Harmondy"
	else
		evt.SetMessage(1126)         -- "Oh, the forest is still very angry.  The grapevines say the thieves have not left their hiding place.  You will catch the thieves for us, won't you?"
	end
end

-- "Paladin"
Game.GlobalEvtLines:RemoveEvent(836)
evt.global[836] = function()
	evt.ForPlayer("All")
	evt.Set("QBits", 854)         -- Paladin
	evt.SetNPCTopic{NPC = 1249, Index = 0, Event = 0}         -- "The Coding Wizard"
	evt.SetNPCTopic{NPC = 1249, Index = 1, Event = 0}         -- "The Coding Wizard"
	evt.SetNPCTopic{NPC = 1249, Index = 2, Event = 0}         -- "The Coding Wizard"
	evt.SetMessage(979)         -- "Proceed to the Brazier to acquire your new profession."
end

-- "Let's Continue."
Game.GlobalEvtLines:RemoveEvent(837)
evt.global[837] = function()
	evt.ForPlayer("All")
	evt.SetMessage(1025)         -- "There ya go!  Now return this scroll to Lord Godwinson to complete this quest.  Then he’ll know that I am more than a myth."
	evt.SetNPCTopic{NPC = 1249, Index = 0, Event = 0}         -- "The Coding Wizard"
	evt.Set("QBits", 718)         -- Harmondale - Town Portal
	evt.Set("QBits", 719)         -- Erathia - Town Portal
	evt.Set("QBits", 720)         -- Tularean Forest - Town Portal
	evt.SetMonGroupBit{NPCGroup = 60, Bit = const.MonsterBits.Invisible, On = true}         -- "Group for Malwick's Assc."
	evt.ForPlayer("Current")
	evt.Add("Inventory", 1577)         -- "LG's Proof"
end

-- "Priest"
Game.GlobalEvtLines:RemoveEvent(838)
evt.global[838] = function()
	evt.SetMessage(1133)         -- "[Falk gives you a grandfatherly smile] You have, perhaps, an ambition to be priests?  I can help you, if you'll help me.  There is an island south of Bracada where stands an old temple that I need to find again.  I think the pirates west of Erathia must know where the island is.  The Erathian navy is rather feeble, and hasn't been able to root them out of their hiding places amongst the Tidewater Caverns.  Perhaps the pirates have a map.  If you can bring me that map, I would promote you to Priest status immediately."
	evt.Set("QBits", 555)         -- "Find the lost pirate map in the Tidewater Caverns in Tatalia and return to Daedalus Falk on Emerald Island."
	evt.SetNPCTopic{NPC = 386, Index = 0, Event = 839}         -- "Daedalus Falk" : "Priest"
end

-- "Priest"
Game.GlobalEvtLines:RemoveEvent(839)
evt.global[839] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 1485) then         -- "Map to Evenmorn Island"
		evt.SetMessage(1135)         -- "If there is a map that says where that island is, the map would be in the Tidewater Caverns of western Erathia.  When you bring me that map, then I will be happy to promote you all to Priests."
		return
	end
	evt.SetMessage(1134)         -- "The Map!  You found it!  [Falk looks at the map, and points at the island] There it is.  The island has been shrouded in mist since the Churches of the Sun and Moon began fighting over a century ago.  Keep the map--I have the coordinates now, and will have no trouble finding the place when I need to.  I am proud to declare the Clerics amongst you to be Priests, and the rest to be honorary Priests.  Thank you so much for your good work!"
	for pl = 0, Party.High do
		evt.ForPlayer(pl)
		if evt.Cmp("ClassIs", const.Class.Cleric) then
			evt.Set("ClassIs", const.Class.Priest)
			evt.Add("QBits", 1607)         -- "Promoted to Priest"
			evt.Add("Experience", 30000)
		else
			evt.Add("QBits", 1608)         -- "Promoted to Honorary Priest"
			evt.Add("Experience", 15000)
		end
	end
	evt.Subtract("QBits", 555)         -- "Find the lost pirate map in the Tidewater Caverns in Tatalia and return to Daedalus Falk on Emerald Island."
	evt.Add("Gold", 5000)
	evt.Subtract("Reputation", 5)
	evt.ForPlayer("All")
	evt.Subtract("Inventory", 1485)         -- "Map to Evenmorn Island"
	evt.Subtract("QBits", 730)         -- Map to Evenmorn - I lost it
	evt.SetNPCTopic{NPC = 386, Index = 0, Event = 840}         -- "Daedalus Falk" : "Priest of Light"
	evt.Set("QBits", 576)         -- Activate boat to area 9.  Priest promo quest
end

-- "Priest of Light"
Game.GlobalEvtLines:RemoveEvent(840)
evt.global[840] = function()
	if evt.Cmp("QBits", 612) then         -- Chose the path of Dark
		evt.SetMessage(200)         -- "How dare you insult me with your presence?  You have chosen the Path of Darkness, and have forever renounced me as your teacher.  Go now, and be consumed by your own selfish desires.  Get out of my sight!"
	elseif evt.Cmp("QBits", 611) then         -- Chose the path of Light
		evt.SetMessage(1136)         -- "Priests.  [Falk gazes warmly at you] Well it is that you have come to see the purity of the Path of Light.  Never regret your decision, and never look back.  South of Bracada is an island called Evenmorn, and upon that island are the old temples of the Sun and the Moon.  Both are inhabited by the remnants of the two religions, their once proud churches reduced to two old temples fighting for a small island.  The Church of the Sun was the founding religion for our current faith, the Path of Lights.  I propose we help them out and tip the balance in favor of the Church of the Sun.  Using the map that I sent you to find, convince a sea captain to bring you to the island.  There, bring aid and comfort to the Church of the Sun by purifying the altar in the Church of the Moon.  This will so weaken theMoon cult that the Church of the Sun will be able to overcome them in battle.  Return to me when you have done this.   "
		evt.Set("QBits", 554)         -- "Purify the Altar of Evil in the Temple of the Moon on Evenmorn Isle then return to Daedalus Falk on Emerald Island."
		evt.SetNPCTopic{NPC = 386, Index = 0, Event = 841}         -- "Daedalus Falk" : "Priest of Light"
	else
		evt.SetMessage(1137)         -- "If you wish to follow the Path of Light, first you must formally choose it.  Soon you will be asked to make the choice, and the way will be clear.  Until then, I cannot be your guide."
	end
end

-- "Priest of Light"
Game.GlobalEvtLines:RemoveEvent(841)
evt.global[841] = function()
	if not evt.Cmp("QBits", 574) then         -- Purified the Altar of Evil.  Priest of Light promo quest.
		evt.SetMessage(1138)         -- "You must visit Evenmorn island and purify the Altar of Darkness in the Church of the Moon.  Only then can I promote you to Priests of the Light."
		return
	end
	evt.SetMessage(201)         -- "Your bravery has advanced our faith tremendously, Priests.  It's with pleasure that I can hereby promote all Priests to Priests of the Light, and all honorary Priests to Honorary Priests of the Light.  Thank you so much for your help!"
	for pl = 0, Party.High do
		evt.ForPlayer(pl)
		if evt.Cmp("ClassIs", const.Class.Priest) then
			evt.Set("ClassIs", const.Class.PriestLight)
			evt.Add("QBits", 1609)         -- "Promoted to Priest of the Light"
			evt.Add("Experience", 80000)
		else
			evt.Add("QBits", 1610)         -- "Promoted to Honorary Priest of the Light"
			evt.Add("Experience", 40000)
		end
	end
	evt.Subtract("QBits", 554)         -- "Purify the Altar of Evil in the Temple of the Moon on Evenmorn Isle then return to Daedalus Falk on Emerald Island."
	evt.Add("Gold", 10000)
	evt.Subtract("Reputation", 10)
	evt.ForPlayer("All")
	evt.SetNPCTopic{NPC = 386, Index = 0, Event = 0}         -- "Daedalus Falk"
	evt.SetNPCGreeting{NPC = 386, Greeting = 190}         -- "Daedalus Falk" : "Shadow Conceal, Brethren.  My time is always yours."
end

-- "Wizard"
Game.GlobalEvtLines:RemoveEvent(842)
evt.global[842] = function()
	evt.SetMessage(1139)         --[[ "I am indeed the one to speak to if you wish to become Wizards.  Every student of mine must complete a project before I name them Wizards.  This year's project is to build a golem.  There are spare parts scattered about the lands from here to Avlee.  You'll need all four limbs plus the torso and the head.  Pay special attention to where you get the head--one of my students made a mistake while making a head last summer and gave the defective head away as a joke.  

When you have all the parts, come talk to me.  I'll promote you to Wizards then, and I'll animate your Golem.  Well, on your way, and have fun!" ]]
	evt.Set("QBits", 557)         -- "Collect the six golem pieces and construct a complete golem, then return to Thomas Grey in the School of Sorcery."
	evt.Set("NPCs", 395)         -- "Golem"
	evt.SetNPCTopic{NPC = 387, Index = 0, Event = 843}         -- "Thomas Grey" : "Wizard"
end

-- "Wizard"
Game.GlobalEvtLines:RemoveEvent(843)
evt.global[843] = function()
	if not evt.Cmp("QBits", 586) then         -- Finished constructing Golem with normal head
		if not evt.Cmp("QBits", 585) then         -- Finished constructing Golem with Abbey normal head
			evt.SetMessage(205)         -- "You have to have all the parts together and properly assembled for me to animate it, students!  I can't animate incomplete golems."
			return
		end
	end
	evt.SetMessage(1140)         -- "[You proudly display your assembled golem to Master Grey, and he nods approvingly] Well done.  Head looks alright, but you can never be sure…Well, good work!  Clearly, you qualify for Wizard status.  All Sorcerers amongst you are now Wizards, and all non Sorcerers are now honorary Wizards!  [Master Grey spends awhile casting the spell that animates your golem] He's all yours!  Take him back to your castle and put him where you want.  He'll attack intruders relentlessly.  "
	for pl = 0, Party.High do
		evt.ForPlayer(pl)
		if evt.Cmp("ClassIs", const.Class.Sorcerer) then
			evt.Set("ClassIs", const.Class.Wizard)
			evt.Add("QBits", 1619)         -- "Promoted to Wizard"
			evt.Add("Experience", 30000)
		else
			evt.Add("QBits", 1620)         -- "Promoted to Honorary Wizard"
			evt.Add("Experience", 15000)
		end
	end
	evt.Subtract("QBits", 557)         -- "Collect the six golem pieces and construct a complete golem, then return to Thomas Grey in the School of Sorcery."
	evt.ForPlayer("All")
	evt.SetNPCTopic{NPC = 387, Index = 0, Event = 844}         -- "Thomas Grey" : "Archmage"
	evt.SetNPCGreeting{NPC = 395, Greeting = 199}         -- "Golem" : "I am yours to command, master."
	evt.Set("QBits", 558)         -- Player Castle.  Golem should appear in castle bit.
	evt.Subtract("QBits", 731)         -- Golem Head - I lost it
	evt.Subtract("QBits", 732)         -- Abby normal head - I lost it
end

-- "Archmage"
Game.GlobalEvtLines:RemoveEvent(844)
evt.global[844] = function()
	if evt.Cmp("QBits", 611) then         -- Chose the path of Light
		evt.SetMessage(956)         --[[ "Our Diviners have been unable to discover who, or what, caused the unmaking of the Town Portal spell, but they have located the book that was used to accomplish this dastardly deed.  It’s called the Book of UnMakings.  The book was  kept under guard in the Strange Temple here in the Bracada.  However, several years ago, the temple was swallowed up by a terrible tremor that shook the Bracada, and the book went down with it.  This temple is now buried deep within the depths of the land, with no known entrance from the surface.

However, after consulting with Torrent, the Grandmaster of Water Migicks, we have been able to open an astral tunnel into the temple and link it to the Home Portal here in Bracada.  The tunnel is not too stable, and we aren’t sure how long we can keep it open.

If you desire this promotion, you must enter the tunnel, find the Book of UnMakings, and return it to me.  But you must go NOW.  We cannot afford to wait even an hour, lest the tunnel close." ]]
		evt.Set("QBits", 559)         -- "Recover the Book of Unmakings from the Strange Temple and return it to Thomas Grey in the School of Sorcery."
		evt.SetNPCTopic{NPC = 387, Index = 0, Event = 845}         -- "Thomas Grey" : "We've retrieved the Book of UnMakings!"
	elseif evt.Cmp("QBits", 612) then         -- Chose the path of Dark
		evt.SetMessage(1143)         -- "You've chosen Darkness, my students.  I will teach you no more."
	else
		evt.SetMessage(1142)         -- "Archmage training is reserved only for people dedicated to the Path of Light.  Prove to me you have chosen the right way, and I will be proud to be your teacher."
	end
end

-- "We've retrieved the Book of UnMakings!"
Game.GlobalEvtLines:RemoveEvent(845)
evt.global[845] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 1301) then         -- "Book of UnMakings"
		evt.SetMessage(958)         --[[ "“The portal has collapsed!  Had you but heeded my words there would have been a chance to recover the Book of UnMakings.  But your hesitation has lost the book forever.

Get out of my sight.  You don’t have what it takes for this advancement."" ]]
		evt.SetNPCTopic{NPC = 387, Index = 0, Event = 0}         -- "Thomas Grey"
		evt.Subtract("QBits", 559)         -- "Recover the Book of Unmakings from the Strange Temple and return it to Thomas Grey in the School of Sorcery."
		return
	end
	evt.SetMessage(1145)         --[[ "The Book of UnMakings!  Good work at recovering this book!  Now we can undo its work and remake the Town Portal spell!

Have you discovered who, or what, performed this dastardly deed of unMaking?  [You recount the encounter with the Golems, the Angels, and the Devils]    Devils, you say?  And they were in-league with the Golems and the Angels?!  This is not good ... not good at all!!!  But who, or what, could have engineered such a twisted coalition?

I sense that we haven’t unveiled the real source for this unnatural corruption.  I will consult our Diviners to see if they can unlock this mystery.  As for your party, you have done well and have earned your promotion.  Congratulations! " ]]
	for pl = 0, Party.High do
		evt.ForPlayer(pl)
		if evt.Cmp("ClassIs", const.Class.Wizard) then
			evt.Set("ClassIs", const.Class.ArchMage)
			evt.Add("QBits", 1621)         -- "Promoted to Archmage"
			evt.Add("Experience", 80000)
		else
			evt.Add("QBits", 1622)         -- "Promoted to Honorary Archmage"
			evt.Add("Experience", 40000)
		end
	end
	evt.Subtract("QBits", 559)         -- "Recover the Book of Unmakings from the Strange Temple and return it to Thomas Grey in the School of Sorcery."
	evt.Subtract("QBits", 738)         -- Book of Divine Intervention - I lost it
	evt.Add("Gold", 10000)
	evt.ForPlayer("All")
	evt.SetNPCTopic{NPC = 387, Index = 0, Event = 0}         -- "Thomas Grey"
	evt.SetNPCGreeting{NPC = 387, Greeting = 192}         -- "Thomas Grey" : "I am honored to be graced with your presence, my lords."
	evt.Set("QBits", 718)         -- Harmondale - Town Portal
	evt.Set("QBits", 719)         -- Erathia - Town Portal
	evt.Set("QBits", 720)         -- Tularean Forest - Town Portal
	evt.Subtract("Inventory", 1301)         -- "Book of UnMakings"
	evt.SetNPCTopic{NPC = 432, Index = 1, Event = 0}         -- "Tarin Withern"
end

-- "Coding Wizard Quest"
Game.GlobalEvtLines:RemoveEvent(846)
evt.global[846] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 1577) then         -- "LG's Proof"
		evt.SetMessage(1026)         --[[ "What’s this? [You proudly hand the scroll to Lord Godwinson].  A message for me written in the hand of the legendary Coding Wizard!?  I just **knew** that I was right!  He does exist!  Thank you soooo much for this scroll!

Here, take this reward of 50 Skill Points for each party member.  It should help you in upgrading your new skills!

Now tell me all about your adventure!" ]]
		evt.Subtract("Inventory", 1577)         -- "LG's Proof"
		evt.Add("SkillPoints", 50)
		evt.Subtract("QBits", 865)         -- "Bring proof of the Coding Wizard's existence to Lord Godwinson."
		evt.Set("Awards", 120)         -- "Completed Coding Wizard Quest"
		evt.SetNPCTopic{NPC = 1253, Index = 0, Event = 0}         -- "Lord Godwinson"
		evt.Subtract("NPCs", 357)         -- "Lord Godwinson"
		evt.MoveNPC{NPC = 1253, HouseId = 1106}         -- "Lord Godwinson" -> "Godwinson Estate"
	elseif evt.Cmp("QBits", 865) then         -- "Bring proof of the Coding Wizard's existence to Lord Godwinson."
		evt.SetMessage(1027)         -- "Bring me proof that the Coding Wizard is more than just a myth."
	else
		evt.SetMessage(1005)         --[[ "Erathian folklore mentions a mysterious ‘coding wizard’ named ‘BDJ’. The legend says he has mastered the ‘coding magicks’ that control ‘The Game’. As the story goes, he is able to offer a second character class to those who have already mastered their chosen profession.

I spent much of my youth in search of this wizard, but alas, I was never able to find him.  Maybe he’s just a myth to entice the Young into the world of adventuring; maybe not.  For my peace of mind, I’ve got to know if he is more than a myth.  If you can find this wizard and return to me with proof of his existence, I will reward you handsomely.

I have a dear friend, the Lady Kathryn, who may be able to assist you with this quest.  She resides on Evenmorn Island.  Seek her out and heed her advise.

Good luck, adventurers!" ]]
		evt.Set("QBits", 865)         -- "Bring proof of the Coding Wizard's existence to Lord Godwinson."
		evt.MoveNPC{NPC = 1250, HouseId = 247}         -- "Lady K" -> "The Laughing Monk"
		evt.SetNPCTopic{NPC = 1250, Index = 0, Event = 847}         -- "Lady K" : "Lord Godwinson sent us!"
	end
end

-- "Lord Godwinson sent us!"
Game.GlobalEvtLines:RemoveEvent(847)
evt.global[847] = function()
	evt.SetMessage(1006)         --[[ "Ah, my old friend Lord Godwinson!  I trust that he is doing well?

So you’ve decided to take the journey to find BDJ the Coding Wizard?  He’s a strange one, that Wizard.  A mysterious legend in Erathia who, above all, covets his privacy and guards his secrets closely.  But if you can find him, the rewards are worth the journey!

I do know this.  To reach this wizard you must first run The Gauntlet.  The Lector EAO is the foremost authority on this ‘gauntlet’.  She travels quite a bit, but she does return to her home in Erathia each Summer.  Seek her out.  She may be able to assist you on your journey." ]]
	evt.Set("QBits", 866)         -- 0
	evt.SetNPCTopic{NPC = 1250, Index = 0, Event = 0}         -- "Lady K"
end

-- "Great Druid"
Game.GlobalEvtLines:RemoveEvent(848)
evt.global[848] = function()
	evt.SetMessage(1152)         -- "Advancement as a Druid is simple.  You must visit the three ancient temples to nature we erected centuries ago and pray at their centers.  They are in Tatalia, Evenmorn Isle, and Avlee, and look like circles of stone with an altar of water in their centers.  Where exactly I will not say, but exploring the land about them is part of the process.  When you have visited all three Circles, return to me to detail your experience."
	evt.Set("QBits", 561)         -- "Visit the three stonehenge monoliths in Tatalia, the Evenmorn Islands, and Avlee, then return to Anthony Green in the Tularean Forest."
	evt.SetNPCTopic{NPC = 389, Index = 0, Event = 849}         -- "Anthony Green" : "Great Druid"
end

-- "Great Druid"
Game.GlobalEvtLines:RemoveEvent(849)
evt.global[849] = function()
	if evt.Cmp("QBits", 562) then         -- Visited all stonehenges
		evt.SetMessage(1155)         -- "I have only to look into your eyes to see where you've been.  You have seen the circles, and they have left their imprint upon you.  Telling you that all Druids amongst you are now Great Druids is but a formality.  Telling the rest of you that you're now honorary Druids is showing you respect for the respect you have shown me and my faith.  "
		evt.ForPlayer(0)
		if evt.Cmp("ClassIs", const.Class.Druid) then
			evt.Set("ClassIs", const.Class.GreatDruid)
			evt.Add("QBits", 1613)         -- "Promoted to Great Druid"
			evt.Add("Experience", 30000)
		else
			evt.Add("QBits", 1614)         -- "Promoted to Honorary Great Druid"
			evt.Add("Experience", 15000)
		end
		goto _17
	end
	if not evt.Cmp("QBits", 563) then         -- Visited stonehenge 1 (area 9)
		if not evt.Cmp("QBits", 564) then         -- Visited stonehenge 2 (area 13)
			if not evt.Cmp("QBits", 565) then         -- Visited stonehenge 3 (area 14)
				evt.SetMessage(1153)         -- "Visit the Circles, then return to me.  That is the process.  "
				return
			end
		end
	end
	evt.SetMessage(1154)         -- "You've found a circle!  Very good, but you must find all three before you will be ready for promotion.  Remember, circles three, then return to me."
	do return end
::_17::
	for pl = 1, Party.High do
		evt.ForPlayer(pl)
		if evt.Cmp("ClassIs", const.Class.Druid) then
			evt.Set("ClassIs", const.Class.GreatDruid)
			evt.Add("QBits", 1613)         -- "Promoted to Great Druid"
			evt.Add("Experience", 30000)
		else
			evt.Add("QBits", 1614)         -- "Promoted to Honorary Great Druid"
			evt.Add("Experience", 15000)
		end
	end
	evt.Subtract("QBits", 561)         -- "Visit the three stonehenge monoliths in Tatalia, the Evenmorn Islands, and Avlee, then return to Anthony Green in the Tularean Forest."
	evt.Subtract("Reputation", 5)
	evt.ForPlayer("All")
	evt.SetNPCTopic{NPC = 389, Index = 0, Event = 850}         -- "Anthony Green" : "Arch Druid"
end

-- "Arch Druid"
Game.GlobalEvtLines:RemoveEvent(850)
evt.global[850] = function()
	if evt.Cmp("QBits", 611) then         -- Chose the path of Light
		evt.SetMessage(1156)         --[[ "To be named an Arch Druid, you must serve the land.  I know of a service you could perform.  In the land above Stone City, where the Dwarves bury their dead, is the barrow of King Zokarr IV.  He died fighting in defense of Stone City during the invasion of Erathia by Nighon.  His remains were never recovered and still lie in those tunnels.    

Retrieve his bones and place them in his coffin in his barrow.  When you have done this, the King will rest, and so will the land.  Return to me when you've performed this service, and I will perform the Ceremony of Ascension and name you Arch Druids." ]]
		evt.Set("QBits", 566)         -- "Retrieve the bones of the Dwarf King from the tunnels between Stone City and Nighon and place them in their proper resting place in the Barrow Downs, then return to Anthony Green in the Tularean Forest."
		evt.SetNPCTopic{NPC = 389, Index = 0, Event = 851}         -- "Anthony Green" : "Arch Druid"
	elseif evt.Cmp("QBits", 612) then         -- Chose the path of Dark
		evt.SetMessage(1158)         -- "Servants of Darkness, I am sorry I promoted you earlier.  I am ashamed I didn't notice the darkness in your souls until it was too late.  Leave me."
	else
		evt.SetMessage(1157)         -- "I am dedicated to the service of the Light.  I will not promote you further until you are as dedicated as I.  Come back to me when you choose the Light."
	end
end

-- "Arch Druid"
Game.GlobalEvtLines:RemoveEvent(851)
evt.global[851] = function()
	if not evt.Cmp("QBits", 577) then         -- Barrow downs.   Returned the bones of the Dwarf King.  Arch Druid promo quest.
		evt.SetMessage(1160)         -- "The Service is not easy, but it needs to be done.  Remember, you must bring the bones of King Zokarr IV from where they lie in the tunnels between Stone City and Nighon to Zokarr's coffin in a secret dwarven barrow.  Only then can I perform the Ceremony of Ascension and promote you."
		return
	end
	evt.SetMessage(1159)         --[[ "[Master Green seems beside himself with joy at your accomplishment] I felt the King's soul return to the land of the dead when you returned his bones.  The land breathed a sigh of relief--did you feel it?  

The Ceremony of Ascension is complete.  I'm happy to promote all Great Druids amongst you to Arch Druids, and all honorary Great Druids to Honorary Arch Druids.  This is a very happy day!  Your service will be remembered!" ]]
	for pl = 0, Party.High do
		evt.ForPlayer(pl)
		if evt.Cmp("ClassIs", const.Class.GreatDruid) then
			evt.Set("ClassIs", const.Class.ArchDruid)
			evt.Add("QBits", 1615)         -- "Promoted to Arch Druid"
			evt.Add("Experience", 80000)
		else
			evt.Add("QBits", 1616)         -- "Promoted to Honorary Arch Druid"
			evt.Add("Experience", 40000)
		end
	end
	evt.Subtract("QBits", 566)         -- "Retrieve the bones of the Dwarf King from the tunnels between Stone City and Nighon and place them in their proper resting place in the Barrow Downs, then return to Anthony Green in the Tularean Forest."
	evt.Subtract("Reputation", 10)
	evt.ForPlayer("All")
	evt.SetNPCTopic{NPC = 389, Index = 0, Event = 0}         -- "Anthony Green"
	evt.SetNPCGreeting{NPC = 389, Greeting = 196}         -- "Anthony Green" : "Fortune be your friend, lords.  Do you seek my advice today?"
end

-- "Can you tell us about The Gauntlet?"
Game.GlobalEvtLines:RemoveEvent(852)
evt.global[852] = function()
	evt.SetMessage(1007)         --[[ "The Gauntlet. Yes.  Legend has it that it was established by the recluse BDJ, commonly called the Coding Wizard, during the Second Age of Erathia, when he decided to withdraw from public life to pursue research on what he termed ‘The Game’.  The purpose of The Gauntlet is to dissuade idle curiosity seekers, indolent ‘wannabees’, and other tavern-dwellers from taking the magicks of coding for granted and unbalancing ‘The Game’.  This is in perfect harmony with the ‘TANSTAAFL!’ principle championed by Mage Emeritus R. Heinlein.

To reach this wizard, one must first ‘run The Gauntlet’, which consists of a series of ‘challenges’ in the realms of Earth, Fire, Water, and finally of Air and of Light.  The rewards of the Coding Wizard await those who emerge from these trials.

The Duchess of Deja may have information on the legendary location of The Gauntlet. Seek her out to continue your journey." ]]
	evt.SetNPCTopic{NPC = 1251, Index = 0, Event = 0}         -- "EAO the Lector"
	evt.MoveNPC{NPC = 1252, HouseId = 984}         -- "Duchess of Deja" -> "Duchess of Deja"
	evt.SetNPCTopic{NPC = 1252, Index = 0, Event = 853}         -- "Duchess of Deja" : "Where is The Gauntlet?"
end

-- "Where is The Gauntlet?"
Game.GlobalEvtLines:RemoveEvent(853)
evt.global[853] = function()
	evt.ForPlayer("All")
	if evt.Cmp("QBits", 867) then         -- "Bring a Red Delicious Apple to the Duchess of Deja."
		goto _4
	end
::_2::
	evt.Subtract("Inventory", 1432)         -- "Red Delicious Apple"
	if evt.Cmp("Inventory", 1432) then         -- "Red Delicious Apple"
		goto _2
	end
::_4::
	if evt.Cmp("Inventory", 1432) then         -- "Red Delicious Apple"
		evt.SetMessage(1008)         --[[ "The Apple!  Oh this is soooo delicious! [The duchess takes a large byte out of the apple and begins to chew]  Ummmm.  I have waited sooo long for this treat.  Thank you!  Now to my part of our bargain.

Unfortunately, no one knows exactly **where** The Gauntlet is located.  Some scholars believe that it has been created in the vast expanse of the Coding Void surrounded by the Null of Darkness.  Others believe that it is hidden in plain sight, cloaked in the Great Expanse of the Exclusive OR. Pure speculation if you ask me.

However, I do know **how** you can enter The Gauntlet.  You simply need to pray at the proper altar.  All you need to do is to find this alter.

Good Luck!" ]]
		evt.Subtract("Inventory", 1432)         -- "Red Delicious Apple"
		evt.Subtract("QBits", 867)         -- "Bring a Red Delicious Apple to the Duchess of Deja."
		evt.Set("QBits", 868)         -- 0
		evt.SetNPCTopic{NPC = 1252, Index = 0, Event = 0}         -- "Duchess of Deja"
	else
		evt.SetMessage(1028)         --[[ "So you want to know the location of the legendary ‘Gauntlet’ leading to the Coding Wizard?  Perhaps I can help.  But you must first do something for me.

As you can see, Deja is not exactly the Land of Milk and Honey.  I have a terrible hunger for a fresh Red Delicious Apple from the forests in Tulerea.  Bring one of these apples to me, and then we’ll talk."" ]]
		evt.Set("QBits", 867)         -- "Bring a Red Delicious Apple to the Duchess of Deja."
	end
end

-- "Golem Parts"
Game.GlobalEvtLines:RemoveEvent(854)
evt.global[854] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 578) then         -- Placed Golem torso
		if evt.Cmp("Inventory", 1441) then         -- "Golem chest"
			evt.Add("QBits", 578)         -- Placed Golem torso
			evt.Subtract("Inventory", 1441)         -- "Golem chest"
			evt.Subtract("QBits", 737)         -- Torso - I lost it
			evt.SetMessage(1167)         -- "You prepare the torso for assembly with the rest of the parts."
			return
		end
	end
	if not evt.Cmp("QBits", 579) then         -- Placed Golem left leg
		if evt.Cmp("Inventory", 1444) then         -- "Golem left leg"
			evt.Subtract("Inventory", 1444)         -- "Golem left leg"
			evt.Subtract("QBits", 736)         -- Left leg - I lost it
			evt.Add("QBits", 579)         -- Placed Golem left leg
			evt.SetMessage(1168)         -- "You prepare the left leg for assembly with the rest of the parts."
			return
		end
	end
	if not evt.Cmp("QBits", 580) then         -- Placed Golem right leg
		if evt.Cmp("Inventory", 1445) then         -- "Golem right leg"
			evt.SetMessage(1169)         -- "You prepare the right leg for assembly with the rest of the parts."
			evt.Subtract("Inventory", 1445)         -- "Golem right leg"
			evt.Subtract("QBits", 735)         -- Right leg - I lost it
			evt.Add("QBits", 580)         -- Placed Golem right leg
			return
		end
	end
	if not evt.Cmp("QBits", 581) then         -- Placed Golem left arm
		if evt.Cmp("Inventory", 1447) then         -- "Golem left arm"
			evt.SetMessage(1170)         -- "You prepare the left arm for assembly with the rest of the parts."
			evt.Subtract("Inventory", 1447)         -- "Golem left arm"
			evt.Subtract("QBits", 734)         -- Left arm - I lost it
			evt.Add("QBits", 581)         -- Placed Golem left arm
			return
		end
	end
	if not evt.Cmp("QBits", 582) then         -- Placed Golem left leg
		if evt.Cmp("Inventory", 1446) then         -- "Golem right arm"
			evt.SetMessage(1171)         -- "You prepare the right arm for assembly with the rest of the parts."
			evt.Subtract("Inventory", 1446)         -- "Golem right arm"
			evt.Subtract("QBits", 733)         -- Right arm - I lost it
			evt.Add("QBits", 582)         -- Placed Golem left leg
			return
		end
	end
	if evt.Cmp("QBits", 583) then         -- Placed Golem head
		goto _71
	end
	if evt.Cmp("QBits", 584) then         -- Placed Golem Abbey normal head
		goto _71
	end
	if evt.Cmp("Inventory", 1443) then         -- "Golem head"
		evt.SetMessage(1172)         -- "You prepare the head for assembly with the rest of the parts."
		evt.Subtract("Inventory", 1443)         -- "Golem head"
		evt.Subtract("QBits", 731)         -- Golem Head - I lost it
		evt.Add("QBits", 583)         -- Placed Golem head
		return
	end
	if evt.Cmp("QBits", 583) then         -- Placed Golem head
		goto _71
	end
	if evt.Cmp("QBits", 584) then         -- Placed Golem Abbey normal head
		goto _71
	end
	if evt.Cmp("Inventory", 1442) then         -- "Abbey Normal Golem Head"
		evt.SetMessage(1173)         -- "You prepare the head (with a dent in it) for assembly with the rest of the parts."
		evt.Subtract("Inventory", 1442)         -- "Abbey Normal Golem Head"
		evt.Subtract("QBits", 732)         -- Abby normal head - I lost it
		evt.Add("QBits", 584)         -- Placed Golem Abbey normal head
		return
	end
::_92::
	evt.SetMessage(1174)         -- "You have no parts to assemble yet."
	do return end
::_71::
	if evt.Cmp("QBits", 578) then         -- Placed Golem torso
		if evt.Cmp("QBits", 579) then         -- Placed Golem left leg
			if evt.Cmp("QBits", 580) then         -- Placed Golem right leg
				if evt.Cmp("QBits", 581) then         -- Placed Golem left arm
					if evt.Cmp("QBits", 582) then         -- Placed Golem left leg
						if evt.Cmp("QBits", 583) then         -- Placed Golem head
							evt.Add("QBits", 586)         -- Finished constructing Golem with normal head
							evt.SetMessage(1175)         -- "You have all the parts together!  Now you just have to return to Master Grey for the animation process."
							evt.SetNPCTopic{NPC = 395, Index = 1, Event = 0}         -- "Golem"
							return
						end
						if evt.Cmp("QBits", 584) then         -- Placed Golem Abbey normal head
							evt.Add("QBits", 585)         -- Finished constructing Golem with Abbey normal head
							evt.SetMessage(1175)         -- "You have all the parts together!  Now you just have to return to Master Grey for the animation process."
							evt.SetNPCTopic{NPC = 395, Index = 1, Event = 0}         -- "Golem"
							return
						end
					end
				end
			end
		end
	end
	goto _92
end

evt.CanShowTopic[854] = function()
	if not evt.Cmp("QBits", 585) then         -- Finished constructing Golem with Abbey normal head
		return not evt.Cmp("QBits", 586)         -- Finished constructing Golem with normal head
	end
	return false
end

-- "Swap Heads"
Game.GlobalEvtLines:RemoveEvent(855)
evt.global[855] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 1442) then         -- "Abbey Normal Golem Head"
		evt.Subtract("Inventory", 1442)         -- "Abbey Normal Golem Head"
		evt.Subtract("QBits", 732)         -- Abby normal head - I lost it
		evt.ForPlayer("Current")
		evt.Add("Inventory", 1443)         -- "Golem head"
		evt.Add("QBits", 731)         -- Golem Head - I lost it
		evt.Subtract("QBits", 583)         -- Placed Golem head
		evt.Add("QBits", 584)         -- Placed Golem Abbey normal head
		evt.SetMessage(1176)         -- "You remove the normal head and replace it with the dented head."
	elseif evt.Cmp("Inventory", 1443) then         -- "Golem head"
		evt.Subtract("Inventory", 1443)         -- "Golem head"
		evt.Subtract("QBits", 731)         -- Golem Head - I lost it
		evt.ForPlayer("Current")
		evt.Add("Inventory", 1442)         -- "Abbey Normal Golem Head"
		evt.Add("QBits", 732)         -- Abby normal head - I lost it
		evt.Subtract("QBits", 584)         -- Placed Golem Abbey normal head
		evt.Add("QBits", 583)         -- Placed Golem head
		evt.SetMessage(1177)         -- "You remove the dented head and replace it with the normal head."
	else
		evt.SetMessage(1178)         -- "I fear that talking will fail with these ruffians, my lords.  May I suggest violence?"
	end
end

evt.CanShowTopic[855] = function()
	if evt.Cmp("QBits", 583) then         -- Placed Golem head
		return evt.Cmp("Inventory", 1442)         -- "Abbey Normal Golem Head"
	elseif not evt.Cmp("QBits", 584) then         -- Placed Golem Abbey normal head
		return false
	else
		return evt.Cmp("Inventory", 1443)         -- "Golem head"
	end
end

-- "Castle Harmondale"
Game.GlobalEvtLines:RemoveEvent(856)
evt.global[856] = function()
	evt.SetMessage(1178)         -- "I fear that talking will fail with these ruffians, my lords.  May I suggest violence?"
	evt.SetNPCTopic{NPC = 397, Index = 0, Event = 871}         -- "Butler" : "Castle Harmondale"
	evt.MoveNPC{NPC = 397, HouseId = 240}         -- "Butler" -> "On the House"
end

-- "Rescue Dwarves"
Game.GlobalEvtLines:RemoveEvent(857)
evt.global[857] = function()
	evt.SetMessage(1181)         --[[ "So…The new lords of Harmondale I have before me.  Not impressed.  Doubt other kings think much of you either.  Hrmph.  Probably get yourselves killed soon.  But maybe there's more than meets the eye here.  Yes.  Maybe you can do something for me, and I for you.  Medusas have taken my mines in eastern Bracada.  Turned a few of my people to stone.  Dangerous monsters, don't want to lose more lives on a rescue.  Ok to lose yours though.  

Take this elixir and pour it on the statues.  Wake them up.  Then I will fix up your castle.  Give you respect.  Go now, and beware the griffins in Bracada.  " ]]
	evt.Set("QBits", 588)         -- "Rescue the dwarves from the Red Dwarf Mines and return to the Dwarf King in Stone City in the Barrow Downs."
	evt.Subtract("QBits", 658)         -- "Talk to the Dwarves in Stone City in the Barrow Downs to find a way to repair Castle Harmondale."
	evt.Add("Inventory", 1431)         -- "Elixir"
	evt.Add("QBits", 742)         -- Elixir - I lost it
	evt.SetNPCTopic{NPC = 398, Index = 0, Event = 858}         -- "Hothfarr IX" : "Rescue Dwarves"
end

-- "Rescue Dwarves"
Game.GlobalEvtLines:RemoveEvent(858)
evt.global[858] = function()
	if evt.Cmp("NPCs", 399) then         -- "Drathen Keldin"
		if evt.Cmp("NPCs", 400) then         -- "Jaycen Keldin"
			if evt.Cmp("NPCs", 401) then         -- "Yarrow Keldin"
				if evt.Cmp("NPCs", 402) then         -- "Fausil Keldin"
					if evt.Cmp("NPCs", 403) then         -- "Red Keldin"
						if evt.Cmp("NPCs", 404) then         -- "Thom Keldin"
							if evt.Cmp("NPCs", 405) then         -- "Arvin Keldin"
								evt.SetMessage(1182)         --[[ "Welcome back, Lords of Harmondale!  Now, I will help you.  My engineer will work for you.  Fix up your castle.  You have my thanks.  You are welcome here forever..  

Oh, and before I forget .. take this teleportal key to Emerald Island.  Don't know where you can use it, but you might find it helpful in the future. Perhaps you should see Illene Farswell in Harmondale.  She may know where you can use this key. 

Hmmph.  One more thing.  Your work has interested the other courts.  They will send ambassadors to you now--check your throne room.  Watch your back, my friends." ]]
								evt.Add("History4", 0)
								evt.Add("Gold", 5000)
								evt.Subtract("QBits", 588)         -- "Rescue the dwarves from the Red Dwarf Mines and return to the Dwarf King in Stone City in the Barrow Downs."
								evt.Subtract("Reputation", 5)
								evt.ForPlayer("All")
								evt.Add("Awards", 4)         -- "Rescued the dwarves from the Red Dwarf Mine"
								evt.Add("Experience", 12500)
								evt.Subtract("Inventory", 1431)         -- "Elixir"
								evt.Subtract("QBits", 742)         -- Elixir - I lost it
								evt.Set("QBits", 610)         -- Built Castle to Level 2 (rescued dwarf guy)
								evt.Subtract("NPCs", 399)         -- "Drathen Keldin"
								evt.MoveNPC{NPC = 60, -- ERROR: Not found
HouseId = 999}         -- "Drathen Keldin"
								evt.MoveNPC{NPC = 406, HouseId = 1169}         -- "Ellen Rockway" -> "Throne Room"
								evt.MoveNPC{NPC = 407, HouseId = 1169}         -- "Alain Hani" -> "Throne Room"
								evt.Subtract("NPCs", 400)         -- "Jaycen Keldin"
								evt.Subtract("NPCs", 401)         -- "Yarrow Keldin"
								evt.Subtract("NPCs", 402)         -- "Fausil Keldin"
								evt.Subtract("NPCs", 403)         -- "Red Keldin"
								evt.Subtract("NPCs", 404)         -- "Thom Keldin"
								evt.Subtract("NPCs", 405)         -- "Arvin Keldin"
								evt.SetNPCTopic{NPC = 398, Index = 0, Event = 0}         -- "Hothfarr IX"
								evt.SetNPCGreeting{NPC = 398, Greeting = 203}         -- "Hothfarr IX" : "Welcome, Harmondale!  Stone city is at your disposal."
								evt.ForPlayer(0)
								evt.Add("Inventory", 1466)         -- "Emerald Is. Teleportal Key"
								return
							end
						end
					end
				end
			end
		end
	end
	evt.SetMessage(1183)         -- "Back again, eh?  Your part of the bargain isn't finished.  No help 'til you're done.  "
end

-- "Use Elixir"
evt.CanShowTopic[859] = function()
	return evt.Cmp("Inventory", 1476)         -- "Elixir Placeholder"
end

Game.GlobalEvtLines:RemoveEvent(859)
evt.global[859] = function()
	evt.Set("NPCs", 399)         -- "Drathen Keldin"
	evt.SetNPCGreeting{NPC = 399, Greeting = 204}         -- "Drathen Keldin" : "Thanks for rescuing me.  I am at your service."
end

-- "Use Elixir"
evt.CanShowTopic[860] = function()
	return evt.Cmp("Inventory", 1476)         -- "Elixir Placeholder"
end

Game.GlobalEvtLines:RemoveEvent(860)
evt.global[860] = function()
	evt.Set("NPCs", 400)         -- "Jaycen Keldin"
	evt.SetNPCGreeting{NPC = 400, Greeting = 205}         -- "Jaycen Keldin" : "Thanks for rescuing me.  I owe you my life."
end

-- "Use Elixir"
evt.CanShowTopic[861] = function()
	return evt.Cmp("Inventory", 1476)         -- "Elixir Placeholder"
end

Game.GlobalEvtLines:RemoveEvent(861)
evt.global[861] = function()
	evt.Set("NPCs", 401)         -- "Yarrow Keldin"
	evt.SetNPCGreeting{NPC = 401, Greeting = 205}         -- "Yarrow Keldin" : "Thanks for rescuing me.  I owe you my life."
end

-- "Use Elixir"
evt.CanShowTopic[862] = function()
	return evt.Cmp("Inventory", 1476)         -- "Elixir Placeholder"
end

Game.GlobalEvtLines:RemoveEvent(862)
evt.global[862] = function()
	evt.Set("NPCs", 402)         -- "Fausil Keldin"
	evt.SetNPCGreeting{NPC = 402, Greeting = 205}         -- "Fausil Keldin" : "Thanks for rescuing me.  I owe you my life."
end

-- "Use Elixir"
evt.CanShowTopic[863] = function()
	return evt.Cmp("Inventory", 1476)         -- "Elixir Placeholder"
end

Game.GlobalEvtLines:RemoveEvent(863)
evt.global[863] = function()
	evt.Set("NPCs", 403)         -- "Red Keldin"
	evt.SetNPCGreeting{NPC = 403, Greeting = 205}         -- "Red Keldin" : "Thanks for rescuing me.  I owe you my life."
end

-- "Use Elixir"
evt.CanShowTopic[864] = function()
	return evt.Cmp("Inventory", 1476)         -- "Elixir Placeholder"
end

Game.GlobalEvtLines:RemoveEvent(864)
evt.global[864] = function()
	evt.Set("NPCs", 404)         -- "Thom Keldin"
	evt.SetNPCGreeting{NPC = 404, Greeting = 205}         -- "Thom Keldin" : "Thanks for rescuing me.  I owe you my life."
end

-- "Use Elixir"
evt.CanShowTopic[865] = function()
	return evt.Cmp("Inventory", 1476)         -- "Elixir Placeholder"
end

Game.GlobalEvtLines:RemoveEvent(865)
evt.global[865] = function()
	evt.Set("NPCs", 405)         -- "Arvin Keldin"
	evt.SetNPCGreeting{NPC = 405, Greeting = 205}         -- "Arvin Keldin" : "Thanks for rescuing me.  I owe you my life."
end

-- "An invitation…"
Game.GlobalEvtLines:RemoveEvent(866)
evt.global[866] = function()
	evt.SetMessage(1184)         -- "I bring greetings from Queen Catherine, the rightful ruler of all Erathia.  She has taken up residence at Gryphonheart Castle in Steadwick. She is currently involved in matters of State and cannot spare the time to grant you an audience.  If the Queen needs you, she shall summon you."
end

-- "We've received the Blessings!"
-- "Artifact"
evt.CanShowTopic[868] = function()
	return evt.Cmp("Inventory", 1436)         -- "Gryphonheart's Trumpet"
end

Game.GlobalEvtLines:RemoveEvent(868)
evt.global[868] = function()
	evt.SetMessage(1188)         -- "[Lady Ellen gasps in delight] You have Gryphonheart's Trumpet!  This is wonderful!  When it disappeared from the strongbox, we thought it had been stolen by the enemy!  Thank you for bringing it back to us!"
	evt.Add("Gold", 5000)
	evt.ForPlayer("All")
	evt.Add("Experience", 10000)
	evt.Subtract("Inventory", 1436)         -- "Gryphonheart's Trumpet"
	evt.Subtract("QBits", 591)         -- "Retrieve Gryphonheart's Trumpet from the battle in the Tularean Forest and return it to whichever side you choose."
	evt.Set("QBits", 596)         -- Gave artifact to humans
	evt.SetNPCTopic{NPC = 406, Index = 2, Event = 0}         -- "Ellen Rockway"
end

-- "We've received the Blessings!"
Game.GlobalEvtLines:RemoveEvent(869)
evt.global[869] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 807) or not evt.Cmp("QBits", 808) or not evt.Cmp("QBits", 809) or not evt.Cmp("QBits", 810) then
	return
end
	evt.SetMessage(1151)         --[[ "Ok then.  Here’s your briefing.

We have recently discovered that the Strange Temple is being used as a ‘staging area’ for a group known as The Corruption. This group has joined forces with the Devil-King Xenoflex to form an unholy alliance. They are currently raising an army of Golems, Devils, Angels, and other creatures of the land, both Light and Dark.  Once at-strength, they plan on storming Erathia like a plague of locusts and seizing power throughout all lands. To make things worse, The Corruption discovered some ancient weapons and is attempting to reproduce them en-mass in order to equip their army. And at the center of this unseemly coalition is one of The Pit’s own … Judas the Geek! He has betrayed all of Erathia!!

What I need you to do is to proceed to the residence of Judas, find the hidden teleport therein, and enter the Strange Temple. Once in the temple, destroy all creatures within, retrieve the ancient weapons, and return to me. Should you encounter the traitor, terminate him … with extreme prejudice." ]]
	evt.MoveNPC{NPC = 424, HouseId = 0}         -- "Maximus"
	evt.Set("QBits", 811)         -- "Clear out the Strange Temple,  retrieve the ancient weapons, and return to Maximus in The Pit"
end

-- "An invitation…"
Game.GlobalEvtLines:RemoveEvent(870)
evt.global[870] = function()
	evt.SetMessage(1191)         -- "Though Avlee is not currently in charge of Harmondale, my King, Eldrich Parson of Avlee, lays claim to this territory as our rightful domain.  The reasons are complicated, but boil down to the simple fact that Erathia stole our land in the Timber Wars many years ago, and we will not give up until we have it back.  You'd be well served to stay out of this conflict.  However, if my King needs you, he will summon you."
end

-- "Castle Harmondale"
Game.GlobalEvtLines:RemoveEvent(871)
evt.global[871] = function()
	if evt.Cmp("QBits", 647) then         -- Player castle goblins are all dead
		evt.SetMessage(1179)         --[[ "Thank heavens you've cleaned them out!  Now we need to find a way to clean up the castle and rebuild the damaged sections.  The only people I can think of who would have the inclination and the ability to do this are the Dwarves in Stone City, located in the Barrow Downs to the south.  The entrance to Stone City lies in the center of the Barrow Downs on one of the largest hills.

Oh, by the way … an angel appeared to me a few hours ago.  He said that he needs to speak to the new lords of Harmondale and that he would be waiting for you inside of the castle.  If I were you, I’d talk with him before going to see the Dwarf King. " ]]
		evt.ForPlayer("All")
		evt.Add("Experience", 5000)
		evt.Subtract("QBits", 587)         -- "Clean out Castle Harmondale and return to the Butler in the tavern, On the House, in Harmondale."
		evt.Add("Awards", 3)         -- "Cleared out Castle Harmondale"
		evt.MoveNPC{NPC = 397, HouseId = 1169}         -- "Butler" -> "Throne Room"
		evt.SetNPCTopic{NPC = 397, Index = 0, Event = 0}         -- "Butler"
		evt.SetNPCGreeting{NPC = 397, Greeting = 201}         -- "Butler" : "You rang, my lords?"
		evt.Set("QBits", 658)         -- "Talk to the Dwarves in Stone City in the Barrow Downs to find a way to repair Castle Harmondale."
	else
		evt.SetMessage(1178)         -- "I fear that talking will fail with these ruffians, my lords.  May I suggest violence?"
	end
end

-- "Artifact"
evt.CanShowTopic[872] = function()
	return evt.Cmp("Inventory", 1436)         -- "Gryphonheart's Trumpet"
end

Game.GlobalEvtLines:RemoveEvent(872)
evt.global[872] = function()
	evt.SetMessage(1195)         -- "You have Gryphonheart's Trumpet!  Excellent!  We lost track of it during the raid, and were afraid that one of the Erathians got away with it.  Thank you very much for your help!"
	evt.Add("Gold", 5000)
	evt.ForPlayer("All")
	evt.Add("Experience", 10000)
	evt.Subtract("Inventory", 1436)         -- "Gryphonheart's Trumpet"
	evt.Subtract("QBits", 591)         -- "Retrieve Gryphonheart's Trumpet from the battle in the Tularean Forest and return it to whichever side you choose."
	evt.Set("QBits", 597)         -- Gave artifact to elves
	evt.SetNPCTopic{NPC = 407, Index = 2, Event = 0}         -- "Alain Hani"
end

-- "No Thanks."
Game.GlobalEvtLines:RemoveEvent(873)
evt.global[873] = function()
	evt.ForPlayer("All")
	if evt.Cmp("QBits", 850) then         -- BDJ Final
		evt.Subtract("QBits", 861)         -- One Use
		evt.SetNPCTopic{NPC = 1249, Index = 0, Event = 837}         -- "The Coding Wizard" : "Let's Continue."
	elseif evt.Cmp("QBits", 849) then         -- BDJ 3
		evt.Set("QBits", 850)         -- BDJ Final
		evt.SetNPCTopic{NPC = 1249, Index = 0, Event = 800}         -- "The Coding Wizard" : "New Profession."
	elseif evt.Cmp("QBits", 848) then         -- BDJ 2
		evt.Set("QBits", 849)         -- BDJ 3
		evt.SetNPCTopic{NPC = 1249, Index = 0, Event = 800}         -- "The Coding Wizard" : "New Profession."
	else
		evt.Set("QBits", 848)         -- BDJ 2
		evt.SetNPCTopic{NPC = 1249, Index = 0, Event = 800}         -- "The Coding Wizard" : "New Profession."
	end
	evt.SetNPCTopic{NPC = 1249, Index = 1, Event = 0}         -- "The Coding Wizard"
	evt.SetNPCTopic{NPC = 1249, Index = 2, Event = 0}         -- "The Coding Wizard"
	evt.SetNPCTopic{NPC = 1249, Index = 3, Event = 0}         -- "The Coding Wizard"
	evt.SetMessage(1202)         -- "Ok then.  Let's move on."
end

-- "So you're the new lords of Harmondale."
Game.GlobalEvtLines:RemoveEvent(874)
evt.global[874] = function()
	evt.SetMessage(1198)         -- "[Queen Catherine inclines her head regally] You are the lot that won Lord Markham's silly contest, I see.  I must admit I had little faith until the Dwarf King recognized you as the rightful rulers of Harmondale.  You must have done something to win his respect, or he would have nothing to do with you.  I'm still not sure what he saw in you, but perhaps there really is something of substance here.  Only time will tell.  If I have a need for your services, I'll summon you.  You are dismissed."
end

-- "Bow Expert"
Game.GlobalEvtLines:RemoveEvent(875)
evt.global[875] = function()
	evt.SetMessage(1246)         -- "The only teacher that I know of is the renown Zedd True Shot.  You can find him on Emerald Island.  He's also the Warrior Mage promoter. "
end

-- "Let's Go!"
Game.GlobalEvtLines:RemoveEvent(876)
evt.global[876] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 1477) then         -- "Control Cube"
		evt.SetMessage(1230)         -- "Gladly, friends!"
		evt.SetMonGroupBit{NPCGroup = 57, Bit = const.MonsterBits.Invisible, On = true}         -- "Group for M1"
		evt.Set("NPCs", 373)         -- "Duke Bimbasto"
		evt.SetNPCTopic{NPC = 373, Index = 1, Event = 0}         -- "Duke Bimbasto"
	else
		evt.SetMessage(1245)         -- "We cannot leave until we have the Control Cube."
	end
end

-- "Let's Go!"
Game.GlobalEvtLines:RemoveEvent(877)
evt.global[877] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 1477) then         -- "Control Cube"
		evt.SetMessage(1230)         -- "Gladly, friends!"
		evt.SetMonGroupBit{NPCGroup = 58, Bit = const.MonsterBits.Invisible, On = true}         -- "Group fo M2"
		evt.Set("NPCs", 374)         -- "Sir Vilx of Stone City"
		evt.SetNPCTopic{NPC = 374, Index = 1, Event = 0}         -- "Sir Vilx of Stone City"
	else
		evt.SetMessage(1245)         -- "We cannot leave until we have the Control Cube."
	end
end

-- "Congratulations!"
Game.GlobalEvtLines:RemoveEvent(878)
evt.global[878] = function()
	evt.ForPlayer("All")
	if evt.Cmp("QBits", 611) then         -- Chose the path of Light
		evt.SetMessage(1228)         --[[ "You have saved Erathia, adventurers!  From henceforth, you shall be known as ‘The Heroes of Erathia’!  You may now travel safely anywhere in The Pit without harm or molestation.  However, don’t ‘pick a fight’ with our locals or all bets are off!!

Because of your service, heroes, I hereby grant all members of your party the Ancient Weapon skill and all magic users among your party the mastery in the Dark Magic skill. You can use our promoters to advance in the ancient weapon skill.  Use your new skills wisely!

Oh! and Lord Archibald, himself, has place a reward for you in the House that once belonged to Judas.  It’s in the chest on the second floor.  You may retrieve the reward at any time.

After you have rested, return to Celeste for your next assignment."" ]]
		evt.Subtract("QBits", 811)         -- "Clear out the Strange Temple,  retrieve the ancient weapons, and return to Maximus in The Pit"
		evt.Set("QBits", 815)         -- Reward
		evt.Set("BlasterSkill", 1)
		evt.Set("Awards", 119)         -- "Declared Heroes of Erathia"
		evt.Add("Experience", 200000)
		evt.Add("QBits", 1606)         -- "Joined the Dark Guild"
		evt.ForPlayer(0)
		if evt.Cmp("FireSkill", 1) then
			goto _15
		end
		if evt.Cmp("BodySkill", 1) then
			goto _15
		end
		goto _16
	end
	if not evt.Cmp("QBits", 612) then         -- Chose the path of Dark
		return
	end
	evt.SetMessage(1229)         --[[ "You have saved Erathia, adventurers!  From henceforth, you shall be known as ‘The Heroes of Erathia’!  You may now travel safely anywhere in Celeste without harm or molestation.  However, don’t ‘pick a fight’ with our locals or all bets are off!!

Because of your service, heroes, I hereby grant all members of your party the Ancient Weapon skill and all magic users among your party mastery in the Light Magic skill. You can use our promoters to advance in the ancient weapon skills.  Use your new skills wisely!

Oh! and Gavin Magnus, himself, has place a reward for you in the House that once belonged to Robert the Wise.  It’s in the chest on the second floor.  You may retrieve the reward at any time.

After you have rested, return to The Pit for your next assignment." ]]
	evt.Subtract("QBits", 811)         -- "Clear out the Strange Temple,  retrieve the ancient weapons, and return to Maximus in The Pit"
	evt.Set("QBits", 815)         -- Reward
	evt.Set("BlasterSkill", 1)
	evt.Set("Awards", 119)         -- "Declared Heroes of Erathia"
	evt.Add("Experience", 200000)
	evt.Add("QBits", 1605)         -- "Joined the Light Guild"
	evt.ForPlayer(0)
	if evt.Cmp("FireSkill", 1) then
		goto _57
	end
	if evt.Cmp("BodySkill", 1) then
		goto _57
	end
::_58::
	evt.ForPlayer(1)
	if evt.Cmp("FireSkill", 1) then
		goto _62
	end
	if evt.Cmp("BodySkill", 1) then
		goto _62
	end
::_63::
	evt.ForPlayer(2)
	if evt.Cmp("FireSkill", 1) then
		goto _67
	end
	if evt.Cmp("BodySkill", 1) then
		goto _67
	end
::_68::
	evt.ForPlayer(3)
	if evt.Cmp("FireSkill", 1) then
		goto _72
	end
	if evt.Cmp("BodySkill", 1) then
		goto _72
	end
::_73::
	evt.ForPlayer("All")
	evt.MoveNPC{NPC = 419, HouseId = 1059}         -- "Resurectra" -> "House Devine"
	evt.SetNPCTopic{NPC = 419, Index = 0, Event = 0}         -- "Resurectra"
	evt.SetNPCTopic{NPC = 419, Index = 1, Event = 0}         -- "Resurectra"
	evt.SetNPCTopic{NPC = 419, Index = 2, Event = 0}         -- "Resurectra"
	evt.SetNPCTopic{NPC = 419, Index = 3, Event = 323}         -- "Resurectra" : "Ancient Weapon Grandmaster"
	evt.MoveNPC{NPC = 420, HouseId = 1060}         -- "Crag Hack" -> "Morningstar Residence"
	evt.SetNPCTopic{NPC = 420, Index = 0, Event = 0}         -- "Crag Hack"
	evt.SetNPCTopic{NPC = 420, Index = 1, Event = 0}         -- "Crag Hack"
	evt.SetNPCTopic{NPC = 420, Index = 2, Event = 0}         -- "Crag Hack"
	evt.SetNPCTopic{NPC = 420, Index = 3, Event = 321}         -- "Crag Hack" : "Ancient Weapon Expert"
	evt.SetNPCTopic{NPC = 421, Index = 1, Event = 322}         -- "Sir Caneghem" : "Ancient Weapon Master"
	evt.SetNPCGreeting{NPC = 420, Greeting = 357}         -- "Crag Hack" : "Welcome back  Heroes!   What can I do for you?"
	evt.SetNPCGreeting{NPC = 419, Greeting = 357}         -- "Resurectra" : "Welcome back  Heroes!   What can I do for you?"
	do return end
::_15::
	if evt.Player == 5 then
	for _, pl in Party do
		local s, m = SplitSkill(pl.Skills[const.Skills.Dark])
		pl.Skills[const.Skills.Dark] = JoinSkill(math.max(s, 8), math.max(m, const.Master))
	end
else
	local pl = Party[evt.Player]
	local s, m = SplitSkill(pl.Skills[const.Skills.Dark])
	pl.Skills[const.Skills.Dark] = JoinSkill(math.max(s, 8), math.max(m, const.Master))
end
::_16::
	evt.ForPlayer(1)
	if evt.Cmp("FireSkill", 1) then
		goto _20
	end
	if evt.Cmp("BodySkill", 1) then
		goto _20
	end
::_21::
	evt.ForPlayer(2)
	if evt.Cmp("FireSkill", 1) then
		goto _25
	end
	if evt.Cmp("BodySkill", 1) then
		goto _25
	end
::_26::
	evt.ForPlayer(3)
	if evt.Cmp("FireSkill", 1) then
		goto _30
	end
	if evt.Cmp("BodySkill", 1) then
		goto _30
	end
::_31::
	evt.ForPlayer("All")
	evt.MoveNPC{NPC = 423, HouseId = 1074}         -- "Kastore" -> "Sand Residence"
	evt.SetNPCTopic{NPC = 423, Index = 0, Event = 0}         -- "Kastore"
	evt.SetNPCTopic{NPC = 423, Index = 1, Event = 0}         -- "Kastore"
	evt.SetNPCTopic{NPC = 423, Index = 2, Event = 0}         -- "Kastore"
	evt.SetNPCTopic{NPC = 423, Index = 3, Event = 323}         -- "Kastore" : "Ancient Weapon Grandmaster"
	evt.MoveNPC{NPC = 425, HouseId = 1078}         -- "Dark Shade" -> "Hostel"
	evt.SetNPCTopic{NPC = 425, Index = 0, Event = 0}         -- "Dark Shade"
	evt.SetNPCTopic{NPC = 425, Index = 1, Event = 0}         -- "Dark Shade"
	evt.SetNPCTopic{NPC = 425, Index = 2, Event = 0}         -- "Dark Shade"
	evt.SetNPCTopic{NPC = 425, Index = 3, Event = 321}         -- "Dark Shade" : "Ancient Weapon Expert"
	evt.SetNPCTopic{NPC = 424, Index = 1, Event = 322}         -- "Maximus" : "Ancient Weapon Master"
	evt.SetNPCGreeting{NPC = 425, Greeting = 357}         -- "Dark Shade" : "Welcome back  Heroes!   What can I do for you?"
	evt.SetNPCGreeting{NPC = 423, Greeting = 357}         -- "Kastore" : "Welcome back  Heroes!   What can I do for you?"
	evt.MoveNPC{NPC = 419, HouseId = 220}         -- "Resurectra" -> "Throne Room"
	evt.Subtract("QBits", 814)         -- Small House only Once
	do return end
::_57::
	evt.Set("LightSkill", 136)
	goto _58
::_62::
	evt.Set("LightSkill", 136)
	goto _63
::_67::
	evt.Set("LightSkill", 136)
	goto _68
::_72::
	evt.Set("LightSkill", 136)
	goto _73
::_20::
	if evt.Player == 5 then
	for _, pl in Party do
		local s, m = SplitSkill(pl.Skills[const.Skills.Dark])
		pl.Skills[const.Skills.Dark] = JoinSkill(math.max(s, 8), math.max(m, const.Master))
	end
else
	local pl = Party[evt.Player]
	local s, m = SplitSkill(pl.Skills[const.Skills.Dark])
	pl.Skills[const.Skills.Dark] = JoinSkill(math.max(s, 8), math.max(m, const.Master))
end
	goto _21
::_25::
	if evt.Player == 5 then
	for _, pl in Party do
		local s, m = SplitSkill(pl.Skills[const.Skills.Dark])
		pl.Skills[const.Skills.Dark] = JoinSkill(math.max(s, 8), math.max(m, const.Master))
	end
else
	local pl = Party[evt.Player]
	local s, m = SplitSkill(pl.Skills[const.Skills.Dark])
	pl.Skills[const.Skills.Dark] = JoinSkill(math.max(s, 8), math.max(m, const.Master))
end
	goto _26
::_30::
	if evt.Player == 5 then
	for _, pl in Party do
		local s, m = SplitSkill(pl.Skills[const.Skills.Dark])
		pl.Skills[const.Skills.Dark] = JoinSkill(math.max(s, 8), math.max(m, const.Master))
	end
else
	local pl = Party[evt.Player]
	local s, m = SplitSkill(pl.Skills[const.Skills.Dark])
	pl.Skills[const.Skills.Dark] = JoinSkill(math.max(s, 8), math.max(m, const.Master))
end
	goto _31
end

-- "Congratulations!"
-- "Artifact"
evt.CanShowTopic[880] = function()
	return evt.Cmp("Inventory", 1436)         -- "Gryphonheart's Trumpet"
end

Game.GlobalEvtLines:RemoveEvent(880)
evt.global[880] = function()
	evt.SetMessage(287)         -- "My loyal subjects!  You were the ones who took the Trumpet!  Good work.  We thought it lost forever.  Once again, my purser will deposit gold in your account.  5,000 gold, to be exact."
	evt.Add("BankGold", 5000)
	evt.Subtract("Reputation", 5)
	evt.ForPlayer("All")
	evt.Add("Experience", 10000)
	evt.Subtract("Inventory", 1436)         -- "Gryphonheart's Trumpet"
	evt.Subtract("QBits", 591)         -- "Retrieve Gryphonheart's Trumpet from the battle in the Tularean Forest and return it to whichever side you choose."
	evt.Set("QBits", 596)         -- Gave artifact to humans
	evt.SetNPCTopic{NPC = 408, Index = 4, Event = 0}         -- "Queen Catherine"
end

-- "You're the new lords,huh?"
Game.GlobalEvtLines:RemoveEvent(881)
evt.global[881] = function()
	evt.SetMessage(275)         -- "Welcome.  I understand you've been appointed Lords of Harmondale by that idiot Markham.  You know, I WILL restore Avlee's rule over Harmondale--the only question is whether you are with me, or against me.  If you're with me, I will ensure that you retain your post.  Against me, and I will have done with you once my armies occupy your lands.    [King Parson smiles affably] So, of course you're with me!  If I have a need for your services, I'll summon you.  You are dismissed."
end

-- "Map"
Game.GlobalEvtLines:RemoveEvent(882)
evt.global[882] = function()
	evt.SetMessage(277)         --[[ "Well, Seekers, I see you’ve finally arrived.  I’ve been waiting for this moment for ages! 

What?!  You think that all of us have wings and just fly around the countryside impressing the Young?  We can take any form we desire.  We often appear as peasants and beggars so that we may move freely amongst your kind.  Besides, I rather enjoy the shocked look of these foul winged beasts as their perceived ‘easy prey’ sends them to their deaths!  If you have some time on your hands, lure some of these beasties to me, stand back, and watch me in action.  I'm very good, you know!  Besides, I need some entertainment! 

But enough about me.  You came in search of The Map, I guess.  Here it is.  Return it to my kin in Castle Harmondale for your promotion and reward.  Adou. " ]]
	evt.ForPlayer("Current")
	evt.Add("Inventory", 1541)         -- "Map to Treasure"
	evt.SetNPCTopic{NPC = 1247, Index = 0, Event = 0}         -- "Map Giver"
end

-- "Most Excellent!!"
Game.GlobalEvtLines:RemoveEvent(883)
evt.global[883] = function()
	evt.SetMessage(1220)         -- "YOU ARE HEROES!!!  Your work against the devils was masterful!  And the rescue of King Roland was as delightful as it was unexpected.  History will never forget your names for doing what you just did!  I, for one, am very proud to know you.  "
	evt.Add("Gold", 50000)
	evt.Subtract("Reputation", 10)
	evt.ForPlayer("All")
	evt.Add("Experience", 500000)
	evt.Subtract("QBits", 616)         -- "Go to Colony Zod in the Land of the Giants and slay Xenofex then return to Resurectra in Castle Lambent in Celeste."
	evt.Set("QBits", 632)         -- Got Hive part
	evt.SetNPCTopic{NPC = 419, Index = 1, Event = 919}         -- "Resurectra" : "Final Task"
	evt.Add("Awards", 21)         -- "Slayed Xenofex"
	evt.Subtract("QBits", 617)         -- Slayed Xenofex
	evt.Add("SkillPoints", 100)
end

-- "Let's Go!"
Game.GlobalEvtLines:RemoveEvent(884)
evt.global[884] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 1477) then         -- "Control Cube"
		evt.SetMessage(1230)         -- "Gladly, friends!"
		evt.SetMonGroupBit{NPCGroup = 60, Bit = const.MonsterBits.Invisible, On = true}         -- "Group for Malwick's Assc."
		evt.Set("NPCs", 376)         -- "Pascal the Mad Mage"
		evt.SetNPCTopic{NPC = 376, Index = 1, Event = 0}         -- "Pascal the Mad Mage"
	else
		evt.SetMessage(1245)         -- "We cannot leave until we have the Control Cube."
	end
end

-- "Let's Go!"
Game.GlobalEvtLines:RemoveEvent(885)
evt.global[885] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 1477) then         -- "Control Cube"
		evt.SetMessage(1230)         -- "Gladly, friends!"
		evt.SetMonGroupBit{NPCGroup = 61, Bit = const.MonsterBits.Invisible, On = true}         -- "Southern Village Group in Harmondy"
		evt.Set("NPCs", 359)         -- "Baron BunGleau"
		evt.SetNPCTopic{NPC = 359, Index = 1, Event = 0}         -- "Baron BunGleau"
	else
		evt.SetMessage(1245)         -- "We cannot leave until we have the Control Cube."
	end
end

-- "Let's Go!"
Game.GlobalEvtLines:RemoveEvent(886)
evt.global[886] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 1477) then         -- "Control Cube"
		evt.SetMessage(1230)         -- "Gladly, friends!"
		evt.SetMonGroupBit{NPCGroup = 59, Bit = const.MonsterBits.Invisible, On = true}         -- "Group for M3"
		evt.Set("NPCs", 357)         -- "Lord Godwinson"
		evt.SetNPCTopic{NPC = 357, Index = 1, Event = 0}         -- "Lord Godwinson"
	else
		evt.SetMessage(1245)         -- "We cannot leave until we have the Control Cube."
	end
end

-- "Artifact"
evt.CanShowTopic[887] = function()
	return evt.Cmp("Inventory", 1436)         -- "Gryphonheart's Trumpet"
end

Game.GlobalEvtLines:RemoveEvent(887)
evt.global[887] = function()
	evt.SetMessage(288)         -- "Ah, the Trumpet!  You captured it!  We weren't sure how things turned out when news of the human raid reached us.  Thank you again, my friends.  My factor will deposit 5,000 gold in your account for your services."
	evt.Add("BankGold", 5000)
	evt.Subtract("Reputation", 5)
	evt.ForPlayer("All")
	evt.Add("Experience", 10000)
	evt.Subtract("Inventory", 1436)         -- "Gryphonheart's Trumpet"
	evt.Subtract("QBits", 591)         -- "Retrieve Gryphonheart's Trumpet from the battle in the Tularean Forest and return it to whichever side you choose."
	evt.Set("QBits", 597)         -- Gave artifact to elves
	evt.SetNPCTopic{NPC = 409, Index = 4, Event = 0}         -- "ElfKing"
end

-- "Hint"
Game.GlobalEvtLines:RemoveEvent(888)
evt.global[888] = function()
	if evt.Cmp("QBits", 610) then         -- Built Castle to Level 2 (rescued dwarf guy)
		evt.SetMessage(290)         --[[ "Once again, the Human kingdom of Erathia and the Elvish kingdom of Harmondale are fighting.  As the local Judge, it has fallen to me to patch up their differences and bring the two sides to the negotiating table.  The two sides are so evenly matched that either could prevail.  [The judge leans closer to you, lowering his voice] And I'll tell you something else--I don't much care anymore who wins.  They are like children fighting over a toy.  Neither really wants Harmondale--they just want to deny it to the other.  

So, you're on your own.  Whatever actions you take now in support of one side or another could really make a difference.  Just remember that they couldn't possibly care less what happens to you or who rules in Harmondale.  Protect yourselves and your people first.  We didn't have this conversation." ]]
	else
		evt.SetMessage(289)         --[[ "If there is one piece of advice I could give you, it would be to fix your castle.  I don't know how you're going to find the gold and workers to do it, as only wealthy nobles and kings can afford such large scale projects.  I suppose it's the old chicken and egg question...you must appear noble to gain wealth and respect, but you must have wealth and respect in order to appear noble.  

In any event, if you expect to be lords of Harmondale for more than a few months, you need to find a way to prove you're not just lucky peasants.  You must prove that you're fit to rule." ]]
	end
end

-- "I lost it"
Game.GlobalEvtLines:RemoveEvent(889)
evt.global[889] = function()
	evt.SetMessage(1572)         -- "That's too bad, children.  You really ought to take better care of your toys!  It looks like you are S.O.L."
end

-- "Artifact"
evt.CanShowTopic[890] = function()
	return evt.Cmp("Inventory", 1436)         -- "Gryphonheart's Trumpet"
end

Game.GlobalEvtLines:RemoveEvent(890)
evt.global[890] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 1436) then         -- "Gryphonheart's Trumpet"
		evt.SetMessage(291)         -- "You were wise to return the Trumpet to me.  Now I can use it to help shore up the weak side in this conflict and promote peace.  Thank you.  "
		evt.Set("QBits", 659)         -- Gave artifact to arbiter
		evt.Add("Experience", 12500)
		evt.Subtract("Inventory", 1436)         -- "Gryphonheart's Trumpet"
		evt.Subtract("QBits", 591)         -- "Retrieve Gryphonheart's Trumpet from the battle in the Tularean Forest and return it to whichever side you choose."
		evt.SetNPCTopic{NPC = 413, Index = 2, Event = 0}         -- "Judge Grey"
	end
end

-- "I choose you!"
Game.GlobalEvtLines:RemoveEvent(891)
evt.global[891] = function()
	evt.Subtract("NPCs", 416)         -- "Judge Fairweather"
	evt.MoveNPC{NPC = 416, HouseId = 244}         -- "Judge Fairweather" -> "Familiar Place"
	evt.SetNPCGreeting{NPC = 416, Greeting = 219}         -- "Judge Fairweather" : "We need to go to Judge Grey's old house in Harmondale.  Only then can I start my new job and begin to ""sort out this mess"".  [Heh!]"
	evt.SetNPCGreeting{NPC = 417, Greeting = 217}         -- "Judge Sleen" : "We need to go to Judge Grey's old house in Harmondale.  Only then can I start my new job and begin to ""sort out this mess"".  [Heh!]"
	evt.Set("NPCs", 417)         -- "Judge Sleen"
	evt.SetMessage(292)         -- "A wise decision.  You won't regret this--believe me.  I knew you were going to make this decision, and my bags are already packed and ready to go.  All you need to do now is get me to my new home, and I'll take care of the rest."
	evt.SetNPCTopic{NPC = 417, Index = 0, Event = 0}         -- "Judge Sleen"
	evt.SetNPCTopic{NPC = 416, Index = 0, Event = 893}         -- "Judge Fairweather" : "I choose you!"
end

-- "Hint"
Game.GlobalEvtLines:RemoveEvent(892)
evt.global[892] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 622) then         -- Finished Necro Proving Grounds
		evt.SetMessage(293)         -- "Your first order of business is to talk to Lord Ironfist and complete his 'mission.'  Once your ability and loyalty are proven, you will be allowed to help in more…interesting… ways."
	elseif not evt.Cmp("QBits", 623) then         -- Finished Necro Task 2 - Temple of Light
		evt.SetMessage(294)         -- "Each of the advisors to Lord Ironfist has a task for you, complete each one.  Talk to Kastore, Dark Shade, and Maaximus for more information.  The completion of these tasks is vital for our future."
	elseif not evt.Cmp("QBits", 624) then         -- Finished Necro Task 3 - Soul Jars
		evt.SetMessage(294)         -- "Each of the advisors to Lord Ironfist has a task for you, complete each one.  Talk to Kastore, Dark Shade, and Maaximus for more information.  The completion of these tasks is vital for our future."
	elseif not evt.Cmp("QBits", 625) then         -- Finished Necro Task 4 - Clanker's Lab
		evt.SetMessage(294)         -- "Each of the advisors to Lord Ironfist has a task for you, complete each one.  Talk to Kastore, Dark Shade, and Maaximus for more information.  The completion of these tasks is vital for our future."
	elseif not evt.Cmp("QBits", 630) then         -- Killed Good MM3 Person
		evt.SetMessage(295)         -- "Judas the Geek has a mission of great importance.  Everything we've staked so far rests on its completion.  Prepare well for his task or you will certainly fail."
	elseif not evt.Cmp("QBits", 632) then         -- Got Hive part
		evt.SetMessage(296)         -- "Xenofex and the rest of the Kreegan must be put down; go to their 'hive' in the Land of the Giants and put a stop to Xenofex and his minions once and for all."
	elseif evt.Cmp("QBits", 633) then         -- Got the sci-fi part
		evt.SetMessage(298)         -- "Bring the Oscillation Overthruster back to Kastore with all possible speed!  Every moment you dally allows a chance for failure!"
	else
		evt.SetMessage(297)         -- "You will need to visit the craft that brought Kastore and his men to Erathia to continue.  Go west of Avlee, and make sure to be properly outfitted."
	end
end

-- "I choose you!"
Game.GlobalEvtLines:RemoveEvent(893)
evt.global[893] = function()
	evt.Subtract("NPCs", 417)         -- "Judge Sleen"
	evt.MoveNPC{NPC = 417, HouseId = 243}         -- "Judge Sleen" -> "The Snobbish Goblin"
	evt.SetNPCGreeting{NPC = 417, Greeting = 216}         -- "Judge Sleen" : "Free"
	evt.SetNPCGreeting{NPC = 416, Greeting = 220}         -- "Judge Fairweather" : "We need to go to Judge Grey's old house in Harmondale.  Only then can I start my new job and put this horrible war to an end."
	evt.Set("NPCs", 416)         -- "Judge Fairweather"
	evt.SetMessage(292)         -- "A wise decision.  You won't regret this--believe me.  I knew you were going to make this decision, and my bags are already packed and ready to go.  All you need to do now is get me to my new home, and I'll take care of the rest."
	evt.SetNPCTopic{NPC = 416, Index = 0, Event = 0}         -- "Judge Fairweather"
	evt.SetNPCTopic{NPC = 417, Index = 0, Event = 891}         -- "Judge Sleen" : "I choose you!"
end

-- "Hint"
Game.GlobalEvtLines:RemoveEvent(894)
evt.global[894] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 626) then         -- Finished Wizard Proving Grounds
		evt.SetMessage(1205)         -- "First, you need to speak to Gavin Magnus in Celeste and complete his training.  After you have proven your ability and loyalty you will learn more about your role in the future of Erathia."
	elseif not evt.Cmp("QBits", 627) then         -- Finished Wizard Task 2 - Temple of Dark
		evt.SetMessage(1206)         -- "Each of Gavin's advisors has a task for you.  Talk to Resurectra, Sir Caneghem, and Crag Hack for more information.  Do not fail in these missions- in them rests the balance of the future."
	elseif not evt.Cmp("QBits", 628) then         -- Finished Wizard Task 3 - Wine Cellar
		evt.SetMessage(1206)         -- "Each of Gavin's advisors has a task for you.  Talk to Resurectra, Sir Caneghem, and Crag Hack for more information.  Do not fail in these missions- in them rests the balance of the future."
	elseif not evt.Cmp("QBits", 629) then         -- Finished Wizard Task 4 - Soul Jars
		evt.SetMessage(1206)         -- "Each of Gavin's advisors has a task for you.  Talk to Resurectra, Sir Caneghem, and Crag Hack for more information.  Do not fail in these missions- in them rests the balance of the future."
	elseif not evt.Cmp("QBits", 631) then         -- Killed Evil MM3 Person
		evt.SetMessage(1207)         -- "Robert the Wise has a regrettable, but necessary, mission for you to complete.  For any of our plans to continue, this mission must succeed.  Prepare most carefully for the task, or you invite certain failure."
	elseif not evt.Cmp("QBits", 632) then         -- Got Hive part
		evt.SetMessage(1208)         -- "The Kreegan, the Devils, and their leader Xenofex must be destroyed completely for the plan to have any long-term benefit.  You will find their 'hive' in the Land of the Giants."
	elseif evt.Cmp("QBits", 633) then         -- Got the sci-fi part
		evt.SetMessage(1210)         -- "Bring the Oscillation Overthruster back to Resurectra immediately!  Every moment wastes valuable time!"
	else
		evt.SetMessage(1209)         -- "To the west of Avlee lies the craft that Resurectra and her associates used to come to Erathia.  Visit the ship and retrieve the Oscillation Overthruster to insure our victory.  Make sure to be properly outfitted for the journey."
	end
end

-- "Proving Grounds"
Game.GlobalEvtLines:RemoveEvent(895)
evt.global[895] = function()
	evt.SetMessage(1211)         -- "The Test involves entering the 'front door' of the Walls of Mist, and exiting through the 'back door'.  I use the word 'door' loosely--you'll see when you get there.  You will not need your weapons.  You will fail the test if you kill any creature in the Walls of Mist.  If you can complete this task, you will be given membership in the Guild of Light. Good luck."
	evt.Set("QBits", 613)         -- "Complete the Walls of Mist without killing a single opponent and return to Gavin Magnus in Castle Lambent in Celeste."
	evt.Subtract("QBits", 664)         -- "Enter Celeste from the grand teleporter in the Bracada Desert, then talk to Gavin Magnus in Castle Lambent in Celeste."
	evt.SetNPCTopic{NPC = 418, Index = 0, Event = 896}         -- "Gavin Magnus" : "Proving Grounds"
end

-- "Proving Grounds"
Game.GlobalEvtLines:RemoveEvent(896)
evt.global[896] = function()
	if evt.Cmp("QBits", 614) then         -- Completed Proving Grounds without killing a single creature
		evt.SetMessage(1212)         -- "You passed the Test!  That's quite an achievement--few succeed as quickly as you did.  My advisors are now eager to speak to  you; they can be found in the four houses on the eastern side of Celeste.  Once again, congratulations!"
		evt.Subtract("QBits", 613)         -- "Complete the Walls of Mist without killing a single opponent and return to Gavin Magnus in Castle Lambent in Celeste."
		evt.SetNPCTopic{NPC = 418, Index = 0, Event = 0}         -- "Gavin Magnus"
		evt.Add("History10", 0)
		evt.ForPlayer("All")
		evt.Add("Experience", 50000)
		evt.Add("QBits", 626)         -- Finished Wizard Proving Grounds
		evt.Add("Awards", 6)         -- "Completed Wizard Proving Grounds"
		evt.SetNPCGreeting{NPC = 418, Greeting = 223}         -- "Gavin Magnus" : "Welcome back, my friends.  My advisors are anxious to speak with you.  "
		evt.MoveNPC{NPC = 419, HouseId = 1062}         -- "Resurectra" -> "Hostel"
		evt.MoveNPC{NPC = 420, HouseId = 1063}         -- "Crag Hack" -> "Hostel"
		evt.MoveNPC{NPC = 421, HouseId = 1064}         -- "Sir Caneghem" -> "Hostel"
		evt.MoveNPC{NPC = 421, HouseId = 1064}         -- "Sir Caneghem" -> "Hostel"
		evt.SetNPCGreeting{NPC = 419, Greeting = 226}         -- "Resurectra" : "Always a pleasure to see you, Lords."
		evt.SetNPCGreeting{NPC = 420, Greeting = 229}         -- "Crag Hack" : "It's good to see you again, lords.  I hope all is well with you and your realm."
		evt.SetNPCGreeting{NPC = 421, Greeting = 232}         -- "Sir Caneghem" : "Ah, welcome back my lords.  I hope all is well."
		evt.SetNPCGreeting{NPC = 422, Greeting = 235}         -- "Robert the Wise" : "I'm happy you're still alive and working for the Light.  Come and see me when you've finished my friend's tasks."
		evt.Add("QBits", 1605)         -- "Joined the Light Guild"
	else
		evt.SetMessage(1213)         -- "Remember, you must enter through the front door of the Walls of Mist, and exit through the back door.  You must not kill any creatures in the Walls of Mist.  When you have done this, return to me."
	end
end

-- "Temple of the Dark"
evt.CanShowTopic[897] = function()
	return evt.Cmp("QBits", 626)         -- Finished Wizard Proving Grounds
end

Game.GlobalEvtLines:RemoveEvent(897)
evt.global[897] = function()
	evt.SetMessage(1214)         -- "We need your help retrieving half of a key to a very important place from our enemies, the Necromancers.  Like us, they have enshrined their half of the key in their highest temple--The Temple of the Dark.  I'm under no illusions this will be easy.  Take your time and act when you're prepared.  Also, bring our half of the key to us, as well.  It is enshrined in the Temple of the Light.  Since you're our ally, no one should trouble you when you go there to fetch the key.  By the same token, please don't harm any of them, either."
	evt.Set("QBits", 615)         -- "Retrieve the altar piece from the Temple of Light in Celeste and the Temple of Dark in the Pit and return them to Resurectra in Castle Lambent in Celeste."
	evt.SetNPCTopic{NPC = 419, Index = 0, Event = 898}         -- "Resurectra" : "Temple of the Dark"
end

-- "Temple of the Dark"
Game.GlobalEvtLines:RemoveEvent(898)
evt.global[898] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 1478) then         -- "Altar Piece"
		if evt.Cmp("Inventory", 1479) then         -- "Altar Piece"
			evt.SetMessage(1218)         -- "I knew you could do it!  Never doubted you for a second!  [You hand her the key halves, and she joins them by running a finger along the crack between them.  It mends before your eyes, good as new] Finally!  One piece of the plan is in place.  Your assistance has been invaluable.  We are already in your debt, and I expect we'll be even deeper in debt before our plan comes to fruition.  So have faith in us awhile longer--the future we're planning will astound you!"
			evt.Subtract("Inventory", 1478)         -- "Altar Piece"
			evt.Subtract("Inventory", 1479)         -- "Altar Piece"
			evt.Subtract("QBits", 744)         -- Altar Piece (Good) - I lost it
			evt.Subtract("QBits", 745)         -- Altar Piece (Evil) - I lost it
			evt.Add("History12", 0)
			evt.Add("Experience", 50000)
			evt.SetNPCTopic{NPC = 419, Index = 0, Event = 0}         -- "Resurectra"
			evt.Subtract("QBits", 615)         -- "Retrieve the altar piece from the Temple of Light in Celeste and the Temple of Dark in the Pit and return them to Resurectra in Castle Lambent in Celeste."
			evt.Set("QBits", 627)         -- Finished Wizard Task 2 - Temple of Dark
			evt.Set("Awards", 19)         -- "Retrieved Both Temple Pieces"
			evt.SetNPCGreeting{NPC = 419, Greeting = 227}         -- "Resurectra" : "Always a pleasure to see you, Lords."
			evt.ForPlayer("Current")
			evt.Subtract("Reputation", 5)
		else
			evt.SetMessage(1216)         -- "Well, I'm glad you found our half of the key, but you still need their half.  Hold onto it until you get the other half.  When you have both halves, return to me.  I will make them whole."
		end
	elseif evt.Cmp("Inventory", 1479) then         -- "Altar Piece"
		evt.SetMessage(1217)         -- "Good work on retrieving their half of the key, but you still need ours.  It is located in the Temple of the Light here in Celeste."
	else
		evt.SetMessage(1215)         -- "No key halves yet, I see.  Well, take your time.  It must be done eventually, and sooner is better than later, but later is better than being chained to an altar and sacrificed by the High Priest of the Dark in one of their bloody rituals.  Just bring back both halves of the key from the temples of Dark and Light, and try not to get yourselves killed doing it."
	end
end

-- ""
-- ""
-- "Vampires"
evt.CanShowTopic[901] = function()
	return evt.Cmp("QBits", 626)         -- Finished Wizard Proving Grounds
end

Game.GlobalEvtLines:RemoveEvent(901)
evt.global[901] = function()
	evt.SetMessage(1222)         -- "Our allies in Tatalia have been complaining for some time of a mysterious presence.  There have been numerous deaths and disappearances for the last few months, and they've asked us if we knew anything about it.  I think I do.  I suspect a vampire is preying on Tatalia.  I don't have time to pursue the question myself, but to keep our allies happy, I'm asking you to please look into it.  It's possible the monster's presence has deeper implications than just bad luck for Tatalia."
	evt.Set("QBits", 618)         -- "Investigate the Wine Cellar in Tatalia and return to Crag Hack in Castle Lambent in Celeste."
	evt.SetNPCTopic{NPC = 420, Index = 0, Event = 902}         -- "Crag Hack" : "Vampires"
end

-- "Vampires"
Game.GlobalEvtLines:RemoveEvent(902)
evt.global[902] = function()
	if evt.Cmp("QBits", 619) then         -- Slayed the vampire
		evt.SetMessage(1223)         -- "Just as I suspected!  Good work.  With the death of the Vampire, Tatalia can sleep a bit easier now.  Queen Catherine is grateful as well, and has been making moves to further strengthen the ties between Bracada and Erathia."
		evt.Add("Gold", 20000)
		evt.Add("History13", 0)
		evt.Subtract("Reputation", 5)
		evt.ForPlayer("All")
		evt.Add("Experience", 50000)
		evt.Add("Awards", 22)         -- "Solved the Mystery of the Wine Cellar"
		evt.SetNPCTopic{NPC = 420, Index = 0, Event = 0}         -- "Crag Hack"
		evt.SetNPCGreeting{NPC = 420, Greeting = 230}         -- "Crag Hack" : "It's good to see you again, lords.  I hope all is well with you and your realm."
		evt.Subtract("QBits", 618)         -- "Investigate the Wine Cellar in Tatalia and return to Crag Hack in Castle Lambent in Celeste."
		evt.Add("QBits", 628)         -- Finished Wizard Task 3 - Wine Cellar
	else
		evt.SetMessage(1224)         -- "Keep looking for that Vampire.  I'm sure that's our problem, and he must be somewhere in or near Tatalia.  "
	end
end

-- "Soul Jars"
evt.CanShowTopic[903] = function()
	return evt.Cmp("QBits", 626)         -- Finished Wizard Proving Grounds
end

Game.GlobalEvtLines:RemoveEvent(903)
evt.global[903] = function()
	evt.SetMessage(1225)         -- "The plan involves stealing the soul jars the Necromancers rely on to prolong their miserable lives.  They have them hidden somewhere in their Guild Castle, and are probably not prepared for the kind of small scale assault you people are so good at.  A quick strike--in and out--should do the trick.  Don't hang around the castle too long, or reinforcements will arrive, and try to get it right the first time, or they will permanently double their patrols.  Once you have the soul jars, bring them back here so we can dispose of them properly."
	evt.Set("QBits", 620)         -- "Retrieve the Case of Soul Jars from Castle Gloaming in the Pit and return to Sir Caneghem in Celeste."
	evt.SetNPCTopic{NPC = 421, Index = 0, Event = 904}         -- "Sir Caneghem" : "Soul Jars"
end

-- "Soul Jars"
Game.GlobalEvtLines:RemoveEvent(904)
evt.global[904] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 1404) then         -- "Case of Soul Jars"
		evt.SetMessage(1226)         -- "[Sir Caneghem looks at the jars curiously, as though observing a poisonous snake behind glass] So these are soul jars.  I expected something more…impressive, I suppose.  Good job!  [he takes the case of jars] I will make sure these jars are never seen again."
		evt.Subtract("Inventory", 1404)         -- "Case of Soul Jars"
		evt.Subtract("QBits", 743)         -- Lich Jar Case - I lost it
		evt.Add("History11", 0)
		evt.Add("Experience", 50000)
		evt.Subtract("QBits", 620)         -- "Retrieve the Case of Soul Jars from Castle Gloaming in the Pit and return to Sir Caneghem in Celeste."
		evt.Add("QBits", 629)         -- Finished Wizard Task 4 - Soul Jars
		evt.SetNPCTopic{NPC = 421, Index = 0, Event = 769}         -- "Sir Caneghem" : "Erathia has been betrayed!"
		evt.MoveNPC{NPC = 424, HouseId = 1071}         -- "Maximus" -> "Hostel"
		evt.Add("Awards", 24)         -- "Retrieved Soul Jars"
		evt.ForPlayer("Current")
		evt.Subtract("Reputation", 5)
		evt.SetNPCGreeting{NPC = 427, Greeting = 251}         -- "Archibald Ironfist" : "Back for more target practice?  You know, if you wait long enough, my people will regenerate.  Bigger challenge then."
		evt.MoveNPC{NPC = 427, HouseId = 0}         -- "Archibald Ironfist"
		evt.SetNPCTopic{NPC = 427, Index = 1, Event = 0}         -- "Archibald Ironfist"
		evt.SetNPCTopic{NPC = 424, Index = 0, Event = 772}         -- "Maximus" : "Dangerous Mission"
	else
		evt.SetMessage(1227)         -- "Be well prepared when you go for the jars.  Their security won't be so lax if you have to retreat and return.  "
	end
end

-- "Strike the Devils"
Game.GlobalEvtLines:RemoveEvent(905)
evt.global[905] = function()
	if not evt.Cmp("QBits", 838) then         -- Resurectra
		evt.SetMessage(1219)         --[[ "Our plans rapidly approach their conclusion, but there is a hitch.  You have defeated the unholy alliance of The Corruption, but the traitor Judas has escaped and taken refuge with Xenofex and his Devil minions. They still represent a terrible threat, and though they are licking their wounds from our recent victory, will one day regain their strength and devastate the world.  If anything we do is to have lasting effect, we must first destroy these monsters for once and for all.

You are strong, but not strong enough to defeat the devils on your own.  They are vulnerable to the brand of magic most commonly wielded by the Necromancers, and less so by our own Wizards.  It is imperative that you infiltrate the Devil's base and kill their leader Xenofex and the traitor, Judas.  That should end their threat to this world for some time.  The Warlocks have dug a tunnel from their volcano to the Land of the Giants-- the land the Devils claim as their own.  Perhaps you can use that." ]]
		evt.Set("QBits", 616)         -- "Go to Colony Zod in the Land of the Giants and slay Xenofex then return to Resurectra in Castle Lambent in Celeste."
		evt.Set("QBits", 838)         -- Resurectra
	elseif evt.Cmp("QBits", 617) then         -- Slayed Xenofex
		evt.SetMessage(1220)         -- "YOU ARE HEROES!!!  Your work against the devils was masterful!  And the rescue of King Roland was as delightful as it was unexpected.  History will never forget your names for doing what you just did!  I, for one, am very proud to know you.  "
		evt.Add("Gold", 50000)
		evt.Subtract("Reputation", 10)
		evt.ForPlayer("All")
		evt.Add("Experience", 500000)
		evt.Subtract("QBits", 616)         -- "Go to Colony Zod in the Land of the Giants and slay Xenofex then return to Resurectra in Castle Lambent in Celeste."
		evt.Set("QBits", 632)         -- Got Hive part
		evt.SetNPCTopic{NPC = 419, Index = 1, Event = 919}         -- "Resurectra" : "Final Task"
		evt.Add(-- ERROR: Not found
"Awards", 83886128)
	else
		evt.SetMessage(1221)         -- "I guess there's no hurry getting this job done, but we don't want the Necromancers to grow bored waiting for us to do our part and destroy the blocker.  So, please, as soon as you feel ready you must attack the Devils.  Remember that the Warlocks have dug a tunnel from their volcano to the land of the Devils.  You should be able to use that to get yourselves there."
	end
end


-- ERROR: Not found

-- "Beacon Fires"
Game.GlobalEvtLines:RemoveEvent(1256)
evt.global[1256] = function()
	evt.SetMessage(1635)         -- "If you seek aid from Erathia, light the beacon fires near the roads to the Barrow Downs, Erathia, and the Tularean Forest.  The Erathian forces near here will see the fires and rush to your aid!"
end

-- ERROR: Unknown command: 0:10 (0xA0)
-- ERROR: Invalid command size: 2560:160 (Cmd00)
-- ERROR: Not found

-- ERROR: Invalid command size: 40970:0 (SetSnow)
-- ERROR: Not found

evt.global[42397] = function()
	evt.SetSnow{EffectId = 18, On = true}
end

-- "Strike the Devils"
-- "Soul Jars"
evt.CanShowTopic[911] = function()
	return evt.Cmp("QBits", 622)         -- Finished Necro Proving Grounds
end

Game.GlobalEvtLines:RemoveEvent(911)
evt.global[911] = function()
	evt.SetMessage(1239)         -- "Archibald has asked us to find a source of soul jars for his necromancers.  These are the jars that are needed to complete the Ritual that gives them eternal life, and we're almost out.  There are far more candidates for Lichdom than we have jars, so some of our necromancers are facing the grim possibility of real death.  The makers of the jars are the Warlocks.  Go to them and convince them to give us the jars.  If they won't hand them over, take the jars by force-- I'm done negotiating prices with them."
	evt.Set("QBits", 636)         -- "Retrieve the Case of Soul Jars from the Warlocks in Thunderfist Mountain and bring them to Maximus in the Pit."
	evt.SetNPCTopic{NPC = 424, Index = 0, Event = 912}         -- "Maximus" : "Soul Jars"
end

-- "Soul Jars"
Game.GlobalEvtLines:RemoveEvent(912)
evt.global[912] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 1404) then         -- "Case of Soul Jars"
		evt.SetMessage(1240)         -- "[Maximus takes the case of jars with obvious delight] Nice work.  I won't even ask what you had to do to get them.  Success speaks for itself.  "
		evt.Subtract("Inventory", 1404)         -- "Case of Soul Jars"
		evt.Subtract("QBits", 743)         -- Lich Jar Case - I lost it
		evt.Add("History18", 0)
		evt.Add("Experience", 50000)
		evt.Subtract("QBits", 636)         -- "Retrieve the Case of Soul Jars from the Warlocks in Thunderfist Mountain and bring them to Maximus in the Pit."
		evt.Add("QBits", 624)         -- Finished Necro Task 3 - Soul Jars
		evt.Add("Awards", 24)         -- "Retrieved Soul Jars"
		evt.SetNPCTopic{NPC = 424, Index = 0, Event = 770}         -- "Maximus" : "Erathia has been betrayed!"
		evt.MoveNPC{NPC = 421, HouseId = 1064}         -- "Sir Caneghem" -> "Hostel"
		evt.ForPlayer("Current")
		evt.Subtract("Reputation", 5)
		evt.SetNPCTopic{NPC = 421, Index = 0, Event = 771}         -- "Sir Caneghem" : "Dangerous Mission"
	else
		evt.SetMessage(1241)         -- "You don't have to be nice about getting the jars from them--just get the jars any way you can.  We can renegotiate peace with them if we must, just like we renegotiate the price for each purchase of soul jars."
	end
end

-- "Clanker's Laboratory"
evt.CanShowTopic[913] = function()
	return evt.Cmp("QBits", 622)         -- Finished Necro Proving Grounds
end

Game.GlobalEvtLines:RemoveEvent(913)
evt.global[913] = function()
	evt.SetMessage(1242)         -- "Lord Archibald has another request--the creatures that have inhabited Clanker's laboratory must be evicted--and the teleport shield brought down.  The laboratory is on an island east of Pierpont in the Tularean Forest.  Be careful--the monsters in that lab were created by Clanker himself, and some of them are much more powerful than their more common fellows elsewhere in the world.  Take whatever you like from the place.  Lord Archibald is only interested in the real estate and the laboratory equipment.  Once the shield is down, Lord Archibald will be able to begin moving necromancers and equipment inside via Lloyd's Beacon. "
	evt.Set("QBits", 637)         -- "Destroy the magical defenses inside Clanker's Laboratory and return to Dark Shade in the Pit."
	evt.SetNPCTopic{NPC = 425, Index = 0, Event = 914}         -- "Dark Shade" : "Clanker's Laboratory"
end

-- "Clanker's Laboratory"
Game.GlobalEvtLines:RemoveEvent(914)
evt.global[914] = function()
	if evt.Cmp("QBits", 638) then         -- Destroyed the magical defenses in Clanker's Lab
		evt.SetMessage(1243)         -- "It's good to see we can count on you.  So few of our allies are as reliable and capable as yourselves.  Thank you very much for your aid."
		evt.Add("History21", 0)
		evt.Subtract("Reputation", 5)
		evt.ForPlayer("All")
		evt.Add("Experience", 50000)
		evt.Subtract("QBits", 637)         -- "Destroy the magical defenses inside Clanker's Laboratory and return to Dark Shade in the Pit."
		evt.Add("QBits", 625)         -- Finished Necro Task 4 - Clanker's Lab
		evt.SetNPCTopic{NPC = 425, Index = 0, Event = 0}         -- "Dark Shade"
		evt.SetNPCGreeting{NPC = 425, Greeting = 245}         -- "Dark Shade" : "Welcome, allies.  Always good to have you back."
		evt.Add("Awards", 26)         -- "Cleaned out Clanker's Laboratory"
	else
		evt.SetMessage(1244)         -- "This is a simple task--get a move on!  Once again, the laboratory on an island east of Pierpont in the Tularean Forest.  Get the shield lowered, and your part of the job is done."
	end
end

-- "Robert the Wise"
evt.CanShowTopic[915] = function()
	if not evt.Cmp("QBits", 622) then         -- Finished Necro Proving Grounds
		return false
	elseif not evt.Cmp("QBits", 623) then         -- Finished Necro Task 2 - Temple of Light
		return false
	elseif not evt.Cmp("QBits", 624) then         -- Finished Necro Task 3 - Soul Jars
		return false
	else
		return evt.Cmp("QBits", 625)         -- Finished Necro Task 4 - Clanker's Lab
	end
end

Game.GlobalEvtLines:RemoveEvent(915)
evt.global[915] = function()
	evt.SetMessage(1245)         -- "We cannot leave until we have the Control Cube."
	evt.Set("QBits", 639)         -- "Assassinate Robert the Wise in his house in Celeste and return to Tolberti in the Pit."
	evt.SetNPCTopic{NPC = 426, Index = 0, Event = 916}         -- "Tolberti" : "Robert the Wise"
end

-- "Robert the Wise"
Game.GlobalEvtLines:RemoveEvent(916)
evt.global[916] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 1477) then         -- "Control Cube"
		evt.SetMessage(1247)         --[[ "I understand your enthusiasm adventurers.  But you are far too inexperienced for the required promotion task.  Travel about on the mainland, gain some real-world experience, and return to the ‘EI’.  Then we’ll discuss the promotion.

So I’ll await your return?  Good.  See you soon." ]]
		return
	end
	evt.SetMessage(1246)         -- "The only teacher that I know of is the renown Zedd True Shot.  You can find him on Emerald Island.  He's also the Warrior Mage promoter. "
	evt.Subtract("Inventory", 1477)         -- "Control Cube"
	evt.Add("History23", 0)
	evt.Add("Experience", 250000)
	evt.Subtract("QBits", 639)         -- "Assassinate Robert the Wise in his house in Celeste and return to Tolberti in the Pit."
	evt.Add("QBits", 630)         -- Killed Good MM3 Person
	evt.Add("Awards", 27)         -- "Assassinated Robert the Wise"
	for pl = 0, Party.High do
		evt.ForPlayer(pl)
		if not evt.Cmp("BlasterSkill", 1) then
			evt.Set("BlasterSkill", 1)
		end
	end
	evt.SetNPCTopic{NPC = 423, Index = 3, Event = 323}         -- "Kastore" : "Ancient Weapon Grandmaster"
	evt.SetNPCTopic{NPC = 424, Index = 1, Event = 322}         -- "Maximus" : "Ancient Weapon Master"
	evt.SetNPCTopic{NPC = 425, Index = 1, Event = 321}         -- "Dark Shade" : "Ancient Weapon Expert"
	evt.SetNPCGreeting{NPC = 426, Greeting = 0}         -- "Tolberti" : ""
	evt.Subtract("Reputation", 5)
	evt.SetNPCTopic{NPC = 426, Index = 0, Event = 0}         -- "Tolberti"
end

-- "Breeding Pit"
evt.CanShowTopic[917] = function()
	return not evt.Cmp("QBits", 611)         -- Chose the path of Light
end

Game.GlobalEvtLines:RemoveEvent(917)
evt.global[917] = function()
	evt.SetMessage(1248)         -- "Yes, the test.  It's simple.  Near the center of the city is a place we call the Breeding Zone.  There's a lot of foul monsters in the pit, and they regenerate constantly.  It makes for a good source of slaves, spare parts, and target practice.  All of our necromancers are tested there when they want to rise above the level of initiate.  I'm sure you'll pass the test.  Just jump in the pit and find a way out.  Kill anything you want down there.  Show no mercy.  When you escape, crawl out of the pit and come see me again.  If you complete this, I will give you membership in the Guild of Dark. *If* you complete this..."
	evt.Set("QBits", 640)         -- "Complete the Breeding Zone and return to Archibald in the Pit."
	evt.Subtract("QBits", 663)         -- "Enter the Pit from the Hall of the Pit in the Deyja Moors, then talk to Archibald in Castle Gloaming in the Pit."
	evt.SetNPCTopic{NPC = 427, Index = 0, Event = 918}         -- "Archibald Ironfist" : "Breeding Pit"
end

-- "Breeding Pit"
Game.GlobalEvtLines:RemoveEvent(918)
evt.global[918] = function()
	if evt.Cmp("QBits", 641) then         -- Completed Breeding Pit.
		evt.SetMessage(1249)         -- "You show promise, my friends.  A fine performance.  I think it will be sufficient proof of your skill for my advisors.  They are quite eager to assign tasks to you now; they can be found in the four houses in the western side of the Pit.  And don't worry.  Rewards will follow, of course."
		evt.Add("History17", 0)
		evt.ForPlayer("All")
		evt.Add("Experience", 50000)
		evt.Add("Awards", 28)         -- "Completed Necromancer Breeding Pit"
		evt.Subtract("QBits", 640)         -- "Complete the Breeding Zone and return to Archibald in the Pit."
		evt.Add("QBits", 622)         -- Finished Necro Proving Grounds
		evt.SetNPCTopic{NPC = 427, Index = 0, Event = 0}         -- "Archibald Ironfist"
		evt.SetNPCGreeting{NPC = 427, Greeting = 252}         -- "Archibald Ironfist" : "Welcome back, allies.  My advisors are eager to speak with you."
		evt.MoveNPC{NPC = 423, HouseId = 1079}         -- "Kastore" -> "Hostel"
		evt.MoveNPC{NPC = 424, HouseId = 1071}         -- "Maximus" -> "Hostel"
		evt.MoveNPC{NPC = 425, HouseId = 1078}         -- "Dark Shade" -> "Hostel"
		evt.MoveNPC{NPC = 424, HouseId = 1071}         -- "Maximus" -> "Hostel"
		evt.SetNPCGreeting{NPC = 423, Greeting = 238}         -- "Kastore" : "[Kastore smiles] Welcome back, allies.  I trust you are well?"
		evt.SetNPCGreeting{NPC = 424, Greeting = 241}         -- "Maximus" : "Glad to have you back, allies."
		evt.SetNPCGreeting{NPC = 425, Greeting = 244}         -- "Dark Shade" : "Welcome, allies.  Always good to have you back."
		evt.SetNPCGreeting{NPC = 426, Greeting = 247}         -- "Tolberti" : "Glad you're still on our side!  Come and see me when you're done with my associates' missions."
		evt.Add("QBits", 1606)         -- "Joined the Dark Guild"
	else
		evt.SetMessage(1250)         -- "I am beginning to suspect my allies were right about you.  Can't you pass this simple test?  Are you too afraid, or too feeble to succeed?  Perhaps we need new allies?"
	end
end

-- "Final Task"
Game.GlobalEvtLines:RemoveEvent(919)
evt.global[919] = function()
	evt.SetMessage(1251)         --[[ "The time has come to achieve our Goal.  The reason we have sent you on all these missions is simple:  we have been busy gathering the parts needed to open a gate to the Ancients--the ones who colonized this world ages ago.  Unfortunately, our former compatriots also seek those parts for their own dark dreams.  They wish to rebuild the Heavenly Forge from the times before the Silence, and use it to duplicate the weapons we brought with us to your world.  We have been competing with them for these parts, but at last we have what we need.  

Except for one thing.  We have been unable to find the Oscillation Overthruster on your world.  All would be lost, but there is one such device aboard the Lincoln--the vehicle that brought us to your world.  It is in the sea west of Avlee and secured against entry, even from ourselves.  Now you must wear our environment suits, enter the ship, and return with the Overthruster; you will find these suits in the chest outside this throne room.  For the suit to function properly you must not be wearing any equipment.  As for us, we must stand watch at the gate, and battle our former comrades.  " ]]
	evt.Add("History26", 0)
	evt.Set("QBits", 642)         -- "Go to the Lincoln in the sea west of Avlee and retrieve the Oscillation Overthruster and return it to Resurectra in Celeste."
	evt.SetNPCTopic{NPC = 419, Index = 1, Event = 920}         -- "Resurectra" : "Final Task"
end

-- "Final Task"
Game.GlobalEvtLines:RemoveEvent(920)
evt.global[920] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 1407) then         -- "Oscillation Overthruster"
		evt.Subtract("Inventory", 1407)         -- "Oscillation Overthruster"
		evt.Subtract("QBits", 747)         -- Wetsuit - I lost it
		evt.Set("QBits", 886)         -- End Game
		evt.SetNPCTopic{NPC = 419, Index = 1, Event = 0}         -- "Resurectra"
		evt.ShowMovie{DoubleSize = 1, ExitCurrentScreen = true, Name = "\"Endgame 1 Good\" "}
		evt.SetNPCGroupNews{NPCGroup = 61, NPCNews = 84}         -- "Southern Village Group in Harmondy" : "I heard there was a gate built to the Ancients!  I wonder what they look like."
		evt.SetNPCGroupNews{NPCGroup = 62, NPCNews = 84}         -- "Main village in Harmondy" : "I heard there was a gate built to the Ancients!  I wonder what they look like."
		evt.SetNPCGroupNews{NPCGroup = 63, NPCNews = 84}         -- "Tent camp in Erathia" : "I heard there was a gate built to the Ancients!  I wonder what they look like."
		evt.SetNPCGroupNews{NPCGroup = 64, NPCNews = 84}         -- "Stedwick Group" : "I heard there was a gate built to the Ancients!  I wonder what they look like."
		evt.SetNPCGroupNews{NPCGroup = 65, NPCNews = 84}         -- "Stilt city dwellers in the Tularean Forest" : "I heard there was a gate built to the Ancients!  I wonder what they look like."
		evt.SetNPCGroupNews{NPCGroup = 66, NPCNews = 84}         -- "Group walkers in the Tularean forest" : "I heard there was a gate built to the Ancients!  I wonder what they look like."
		evt.SetNPCGroupNews{NPCGroup = 67, NPCNews = 84}         -- "Northern town on Deyja" : "I heard there was a gate built to the Ancients!  I wonder what they look like."
		evt.SetNPCGroupNews{NPCGroup = 68, NPCNews = 84}         -- "Southern town in Deyja" : "I heard there was a gate built to the Ancients!  I wonder what they look like."
		evt.SetNPCGroupNews{NPCGroup = 69, NPCNews = 86}         -- "Stable and Tele dwellers in Bracada" : "Congratulations on completing the gate!  Erathia is in your debt!"
		evt.SetNPCGroupNews{NPCGroup = 70, NPCNews = 86}         -- "Eastern village and boat dwellers in Bracada" : "Congratulations on completing the gate!  Erathia is in your debt!"
		evt.SetNPCGroupNews{NPCGroup = 71, NPCNews = 86}         -- "Ridge walkers in Bracada" : "Congratulations on completing the gate!  Erathia is in your debt!"
		evt.SetNPCGroupNews{NPCGroup = 72, NPCNews = 86}         -- "Peasents up till town fountain in Celeste" : "Congratulations on completing the gate!  Erathia is in your debt!"
		evt.SetNPCGroupNews{NPCGroup = 73, NPCNews = 86}         -- "Peasents after town fountain in Celeste" : "Congratulations on completing the gate!  Erathia is in your debt!"
		evt.SetNPCGroupNews{NPCGroup = 74, NPCNews = 84}         -- "Peasents in first area of the pit" : "I heard there was a gate built to the Ancients!  I wonder what they look like."
		evt.SetNPCGroupNews{NPCGroup = 75, NPCNews = 84}         -- "Peasents in the second area of the pit" : "I heard there was a gate built to the Ancients!  I wonder what they look like."
		evt.SetNPCGroupNews{NPCGroup = 76, NPCNews = 84}         -- "Peasents in the third area of the pit" : "I heard there was a gate built to the Ancients!  I wonder what they look like."
		evt.SetNPCGroupNews{NPCGroup = 77, NPCNews = 84}         -- "Peasents in main town of nighon" : "I heard there was a gate built to the Ancients!  I wonder what they look like."
		evt.SetNPCGroupNews{NPCGroup = 78, NPCNews = 84}         -- "Peasents in western town of Nighon" : "I heard there was a gate built to the Ancients!  I wonder what they look like."
		evt.SetNPCGroupNews{NPCGroup = 79, NPCNews = 84}         -- "Peasents in Eastern village of Nighon" : "I heard there was a gate built to the Ancients!  I wonder what they look like."
		evt.SetNPCGroupNews{NPCGroup = 80, NPCNews = 84}         -- "Peasents in the Mercenary guild village" : "I heard there was a gate built to the Ancients!  I wonder what they look like."
		evt.SetNPCGroupNews{NPCGroup = 81, NPCNews = 84}         -- "Peasents in the wharf town" : "I heard there was a gate built to the Ancients!  I wonder what they look like."
		evt.SetNPCGroupNews{NPCGroup = 82, NPCNews = 84}         -- "Peasents in the village area" : "I heard there was a gate built to the Ancients!  I wonder what they look like."
		evt.SetNPCGroupNews{NPCGroup = 83, NPCNews = 84}         -- "Peasents in the Dock area" : "I heard there was a gate built to the Ancients!  I wonder what they look like."
		evt.Set(-- ERROR: Not found
"Awards", 108)
		evt.EnterHouse(600)         -- Win Good
	else
		evt.SetMessage(1253)         -- "Don't forget you'll need the wetsuits to get to the Lincoln.  These suits are in the chest outside this throne room and the Lincoln is in the sea west of Avlee.  Return here with the Overthruster as soon as possible."
	end
end

-- "Final Task"
Game.GlobalEvtLines:RemoveEvent(921)
evt.global[921] = function()
	evt.SetMessage(1254)         --[[ "Our finest hour is upon us.  While you have been taking care of all those important tasks, my compatriots and I have been struggling with our former friends for the parts we need to rebuild the Heavenly Forge of legend.  By former friends, I mean the four chief advisors to King Magnus of the Wizards.  They have a plan to build a gate to the Ancients.  They could have stood with us, but threw it all away on some vague hope of a 'better future'.  But you!  You have stood with us all this time.

Only one task remains--we need the Oscillation Overthruster from our old vehicle, the Lincoln.  We have been unable to find one on your world.  The ship is in the sea west of Avlee and secured against entry, even from ourselves.  Now you must wear our environment suits, enter the ship, and return with the Overthruster.  Our old environments suits have been prepared for you in the chest outside this throne room.  For the suit to function properly you must not be wearing any equipment.We will stand watch over the Forge, and defend it against our enemies.  Bring us the Overthruster, my friends, and together, we shall rule the world!" ]]
	evt.Add("History27", 0)
	evt.Set("QBits", 643)         -- "Go to the Lincoln in the sea west of Avlee and retrieve the Oscillation Overthruster and return it to Kastore in the Pit."
	evt.SetNPCTopic{NPC = 423, Index = 1, Event = 922}         -- "Kastore" : "Final Task"
end

-- "Final Task"
Game.GlobalEvtLines:RemoveEvent(922)
evt.global[922] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 1407) then         -- "Oscillation Overthruster"
		evt.Subtract("Inventory", 1407)         -- "Oscillation Overthruster"
		evt.Subtract("QBits", 747)         -- Wetsuit - I lost it
		evt.Subtract("QBits", 748)         -- Final Part - I lost it
		evt.SetNPCTopic{NPC = 423, Index = 1, Event = 0}         -- "Kastore"
		evt.ShowMovie{DoubleSize = 1, ExitCurrentScreen = true, Name = "\"Endgame 2 Evil\" "}
		evt.SetNPCGroupNews{NPCGroup = 61, NPCNews = 85}         -- "Southern Village Group in Harmondy" : "I've heard rumors of goblins and undead armed with ancient weapons threatening to conquer Erathia!  How dreadful!"
		evt.SetNPCGroupNews{NPCGroup = 62, NPCNews = 85}         -- "Main village in Harmondy" : "I've heard rumors of goblins and undead armed with ancient weapons threatening to conquer Erathia!  How dreadful!"
		evt.SetNPCGroupNews{NPCGroup = 63, NPCNews = 85}         -- "Tent camp in Erathia" : "I've heard rumors of goblins and undead armed with ancient weapons threatening to conquer Erathia!  How dreadful!"
		evt.SetNPCGroupNews{NPCGroup = 64, NPCNews = 85}         -- "Stedwick Group" : "I've heard rumors of goblins and undead armed with ancient weapons threatening to conquer Erathia!  How dreadful!"
		evt.SetNPCGroupNews{NPCGroup = 65, NPCNews = 85}         -- "Stilt city dwellers in the Tularean Forest" : "I've heard rumors of goblins and undead armed with ancient weapons threatening to conquer Erathia!  How dreadful!"
		evt.SetNPCGroupNews{NPCGroup = 66, NPCNews = 85}         -- "Group walkers in the Tularean forest" : "I've heard rumors of goblins and undead armed with ancient weapons threatening to conquer Erathia!  How dreadful!"
		evt.SetNPCGroupNews{NPCGroup = 67, NPCNews = 87}         -- "Northern town on Deyja" : "Congratulations on completing the forge!  Victory will surely be ours!"
		evt.SetNPCGroupNews{NPCGroup = 68, NPCNews = 87}         -- "Southern town in Deyja" : "Congratulations on completing the forge!  Victory will surely be ours!"
		evt.SetNPCGroupNews{NPCGroup = 69, NPCNews = 85}         -- "Stable and Tele dwellers in Bracada" : "I've heard rumors of goblins and undead armed with ancient weapons threatening to conquer Erathia!  How dreadful!"
		evt.SetNPCGroupNews{NPCGroup = 70, NPCNews = 85}         -- "Eastern village and boat dwellers in Bracada" : "I've heard rumors of goblins and undead armed with ancient weapons threatening to conquer Erathia!  How dreadful!"
		evt.SetNPCGroupNews{NPCGroup = 71, NPCNews = 85}         -- "Ridge walkers in Bracada" : "I've heard rumors of goblins and undead armed with ancient weapons threatening to conquer Erathia!  How dreadful!"
		evt.SetNPCGroupNews{NPCGroup = 72, NPCNews = 85}         -- "Peasents up till town fountain in Celeste" : "I've heard rumors of goblins and undead armed with ancient weapons threatening to conquer Erathia!  How dreadful!"
		evt.SetNPCGroupNews{NPCGroup = 73, NPCNews = 85}         -- "Peasents after town fountain in Celeste" : "I've heard rumors of goblins and undead armed with ancient weapons threatening to conquer Erathia!  How dreadful!"
		evt.SetNPCGroupNews{NPCGroup = 74, NPCNews = 87}         -- "Peasents in first area of the pit" : "Congratulations on completing the forge!  Victory will surely be ours!"
		evt.SetNPCGroupNews{NPCGroup = 75, NPCNews = 87}         -- "Peasents in the second area of the pit" : "Congratulations on completing the forge!  Victory will surely be ours!"
		evt.SetNPCGroupNews{NPCGroup = 76, NPCNews = 87}         -- "Peasents in the third area of the pit" : "Congratulations on completing the forge!  Victory will surely be ours!"
		evt.SetNPCGroupNews{NPCGroup = 77, NPCNews = 85}         -- "Peasents in main town of nighon" : "I've heard rumors of goblins and undead armed with ancient weapons threatening to conquer Erathia!  How dreadful!"
		evt.SetNPCGroupNews{NPCGroup = 78, NPCNews = 85}         -- "Peasents in western town of Nighon" : "I've heard rumors of goblins and undead armed with ancient weapons threatening to conquer Erathia!  How dreadful!"
		evt.SetNPCGroupNews{NPCGroup = 79, NPCNews = 85}         -- "Peasents in Eastern village of Nighon" : "I've heard rumors of goblins and undead armed with ancient weapons threatening to conquer Erathia!  How dreadful!"
		evt.SetNPCGroupNews{NPCGroup = 80, NPCNews = 85}         -- "Peasents in the Mercenary guild village" : "I've heard rumors of goblins and undead armed with ancient weapons threatening to conquer Erathia!  How dreadful!"
		evt.SetNPCGroupNews{NPCGroup = 81, NPCNews = 85}         -- "Peasents in the wharf town" : "I've heard rumors of goblins and undead armed with ancient weapons threatening to conquer Erathia!  How dreadful!"
		evt.SetNPCGroupNews{NPCGroup = 82, NPCNews = 85}         -- "Peasents in the village area" : "I've heard rumors of goblins and undead armed with ancient weapons threatening to conquer Erathia!  How dreadful!"
		evt.SetNPCGroupNews{NPCGroup = 83, NPCNews = 85}         -- "Peasents in the Dock area" : "I've heard rumors of goblins and undead armed with ancient weapons threatening to conquer Erathia!  How dreadful!"
		evt.EnterHouse(601)         -- Win Evil
	else
		evt.SetMessage(1256)         -- "Don't forget you'll need the environmental suits to get to the Lincoln.  These suits are in the chest outside the throne room, and the Lincoln is in the sea west of Avlee.  What else do you need to know?"
	end
end

-- "Enter Temple of Light"
Game.GlobalEvtLines:RemoveEvent(923)
evt.global[923] = function()
	evt.MoveToMap{X = -6784, Y = -2832, Z = 1649, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "T01.blv"}
end

-- "Enter Temple of Dark"
Game.GlobalEvtLines:RemoveEvent(924)
evt.global[924] = function()
	evt.MoveToMap{X = 0, Y = -4059, Z = 513, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "T02.blv"}
end

-- "Thomas Grey"
Game.GlobalEvtLines:RemoveEvent(925)
evt.global[925] = function()
	evt.SetMessage(1385)         -- "Thomas Grey runs the School of Sorcery.  If you're looking for promotion to Wizard or Honorary Wizard, he's your man.  His room is right through the door behind me."
end

-- "Book Shop"
evt.CanShowTopic[926] = function()
	return not evt.Cmp("QBits", 657)         -- Membership to the School of Sorcery Scroll Shop
end

Game.GlobalEvtLines:RemoveEvent(926)
evt.global[926] = function()
	evt.SetMessage(1386)         -- "Would you like a membership to the School of Sorcery Scroll Shop?  A membership allows you free access to the scrolls available in our library.  It costs 5000 gold for a six month membership, but the shop stocks once per week."
	evt.SetNPCTopic{NPC = 620, Index = 1, Event = 927}         -- "Eric Swarrel" : "Book Shop"
end

-- "Book Shop"
Game.GlobalEvtLines:RemoveEvent(927)
evt.global[927] = function()
	if evt.Cmp("Gold", 5000) then
		evt.SetMessage(1387)         -- "Here's the membership, remember it only lasts for six months.  Check the shelves in the front rooms here to see what is available."
		evt.Set("QBits", 657)         -- Membership to the School of Sorcery Scroll Shop
		evt.Subtract("Gold", 5000)
		evt.SetNPCTopic{NPC = 620, Index = 1, Event = 0}         -- "Eric Swarrel"
	else
		evt.SetMessage(1388)         -- "You don't have enough gold-- it's no use trying to fool a Wizard."
	end
end

-- "Zokarr's Bones"
evt.CanShowTopic[928] = function()
	return evt.Cmp("QBits", 566)         -- "Retrieve the bones of the Dwarf King from the tunnels between Stone City and Nighon and place them in their proper resting place in the Barrow Downs, then return to Anthony Green in the Tularean Forest."
end

Game.GlobalEvtLines:RemoveEvent(928)
evt.global[928] = function()
	evt.SetMessage(1389)         -- "You want to bury the bones of Zokarr IV in our old barrows?  No dwarf here will brave the dangers, but Zokarr deserves to be laid to rest in the right place.  Look for the secret barrow, the one with only one entrance.  In there is a coffin waiting for Zokarr's bones."
	evt.Add("Inventory", 1428)         -- "Zokarr IV's Skull"
	evt.Add("QBits", 740)         -- Dwarf Bones - I lost it
	evt.SetNPCTopic{NPC = 398, Index = 1, Event = 0}         -- "Hothfarr IX"
end

-- "Quest"
Game.GlobalEvtLines:RemoveEvent(929)
evt.global[929] = function()
	evt.SetMessage(1390)         -- "We have no one to turn to but you, the new Lords of Harmondale. The Lantern of Light is a treasured holy relic, used by the temples of Erathia.  Its value is more symbolic than of power-- without it the temples servants lose faith.  This Lantern disappeared while being brought to this temple from the temple in Stone City.  We believe it was lost somewhere in the maze-like Barrows.  Please find it and return it to us."
	evt.SetNPCTopic{NPC = 432, Index = 0, Event = 930}         -- "Tarin Withern" : "Quest"
	evt.Set("QBits", 667)         -- "Retrieve the Lantern of Light from the Barrow Downs and return it to Tarin Withern in Harmondale."
end

-- "Quest"
Game.GlobalEvtLines:RemoveEvent(930)
evt.global[930] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 1450) then         -- "Lantern of Light"
		evt.SetMessage(1392)         -- "Thank you, Lords of Harmondale.  The Lantern's return will bolster our faith and allows us to continue our services.  Please take this small reward as a token of our gratitude."
		evt.Subtract("Inventory", 1450)         -- "Lantern of Light"
		evt.Add("Awards", 30)         -- "Returned Withern's Lantern"
		evt.Add("Experience", 5000)
		evt.ForPlayer("Current")
		evt.Add("Gold", 1000)
		evt.Subtract("QBits", 667)         -- "Retrieve the Lantern of Light from the Barrow Downs and return it to Tarin Withern in Harmondale."
		evt.SetNPCTopic{NPC = 432, Index = 0, Event = 0}         -- "Tarin Withern"
		evt.SetNPCGreeting{NPC = 432, Greeting = 267}         -- "Tarin Withern" : "Thanks for returning the Lantern of Light.  Ceremonies can continue normally at the temple!"
		evt.Subtract("Reputation", 5)
	else
		evt.SetMessage(1391)         -- "Have you found the Lantern of Light?  We're certain it was lost in the maze of Barrows in the Barrow Downs."
	end
end

-- "Quest"
Game.GlobalEvtLines:RemoveEvent(931)
evt.global[931] = function()
	evt.SetMessage(1393)         -- "My, brother, Haldar passed away last month.  The family was sending his remains to me to be put to final rest.  Something happened to those delivering these remains to me; they disappeared in Nighon and not been heard from since. I fear my brothers soul will never rest unless they are found!  Please return Haldar to me if you find him? I will reward you well for this!"
	evt.SetNPCTopic{NPC = 433, Index = 0, Event = 932}         -- "Mazim Dusk" : "Quest"
	evt.Set("QBits", 668)         -- "Retrieve Haldar's Remains from the Maze in Nighon and return them to Mazim Dusk in Nighon."
end

-- "Quest"
Game.GlobalEvtLines:RemoveEvent(932)
evt.global[932] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 1430) then         -- "Haldar's Remains"
		evt.SetMessage(1395)         -- "Thank you for returning my ""brother's"" remains!  He was a promising Warlock and his life was ended to soon.  Now that I have his remains, I will attempt to bring him back as a Lich, and together we will seek greater power and glory!"
		evt.Subtract("Inventory", 1430)         -- "Haldar's Remains"
		evt.Add("Awards", 32)         -- "Returned Haldar's Remains"
		evt.Add("Experience", 50000)
		evt.ForPlayer("Current")
		evt.Add("Gold", 35000)
		evt.Subtract("QBits", 668)         -- "Retrieve Haldar's Remains from the Maze in Nighon and return them to Mazim Dusk in Nighon."
		evt.SetNPCTopic{NPC = 433, Index = 0, Event = 0}         -- "Mazim Dusk"
		evt.SetNPCGreeting{NPC = 433, Greeting = 269}         -- "Mazim Dusk" : "My thanks for returning Haldar's remains!"
		evt.Subtract("Reputation", 5)
	else
		evt.SetMessage(1394)         -- "Did you find Haldar's Remains?  His soul must be in sheer agony!  Please find the jar with his remains!"
	end
end

-- "Quest"
Game.GlobalEvtLines:RemoveEvent(933)
evt.global[933] = function()
	evt.SetMessage(1396)         -- "My lords, I was beset by foul bandits when I returned from Avlee and they took everything I had brought with me from the Elves.  They even took my signet ring!  Without it I cannot continue my business because I cannot seal contracts between myself and other merchants.  I've heard the bandits base themselves out of a camp in Erathia, but I'm no warrior-- I'd not last a minute against them.  Please go to Erathia and see this justice done!"
	evt.SetNPCTopic{NPC = 434, Index = 0, Event = 934}         -- "Davrik Peladium" : "Quest"
	evt.Set("QBits", 669)         -- "Retrieve Davrik's Signet ring from the Bandit Caves in the northeast of Erathia and return it to Davrik Peladium in Erathia."
end

-- "Quest"
Game.GlobalEvtLines:RemoveEvent(934)
evt.global[934] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 1408) then         -- "Signet Ring"
		evt.SetMessage(1398)         --[[ "My ring!  Thank you lords.  I can now continue my business and recover my losses, and you have made the trading routes safer for all the merchants! 

Take this key as your reward." ]]
		evt.Subtract("Inventory", 1408)         -- "Signet Ring"
		evt.Add("Awards", 34)         -- "Returned Lord Davrik's signet Ring"
		evt.Add("Experience", 5000)
		evt.ForPlayer("Current")
		evt.Add("Inventory", 1472)         -- "Home Key"
		evt.Add("Gold", 5000)
		evt.Subtract("QBits", 669)         -- "Retrieve Davrik's Signet ring from the Bandit Caves in the northeast of Erathia and return it to Davrik Peladium in Erathia."
		evt.SetNPCTopic{NPC = 434, Index = 0, Event = 0}         -- "Davrik Peladium"
		evt.MoveNPC{NPC = 434, HouseId = 0}         -- "Davrik Peladium"
		evt.Subtract("Reputation", 5)
	else
		evt.SetMessage(1397)         -- "You don't have my ring yet?  The bandits are south of Castle Gryphonheart in Erathia.  Please help me, I don't have anyone else to turn to."
	end
end

-- "Quest"
Game.GlobalEvtLines:RemoveEvent(935)
evt.global[935] = function()
	evt.SetMessage(1399)         -- "So you are the Lords of Harmondale, eh?  You don’t look like much; we shall see how history judges you!  I myself am a historian and collector of rare historical items.  Lord Markham also collects such items of interest and there is one item in particular that would complete my collection, Parson's Quill-- the Quill used to sign the Treaty of Pierpont ending the first Timber War.  I know you have dealt with Lord Markham before, it's how you became Lords of this land after all, and if you would take this letter to Lord Markham in Tatalia, I'm sure he would respond favorably.  I would be even more in your debt if Lord Markham sends this item back with you!  I would be sure to favorably record your heroic acts and deeds!"
	evt.SetNPCTopic{NPC = 435, Index = 0, Event = 936}         -- "Norbert Thrush" : "Thrush's Letter"
	evt.Set("QBits", 670)         -- "Take Sealed Letter to Lord Markham in Lord Markham's Manor in Tatalia for collector Norbert Thrush."
	evt.Add("Inventory", 1416)         -- "Letter from Norbert Thrush to Lord Markham"
end

-- "Thrush's Letter"
Game.GlobalEvtLines:RemoveEvent(936)
evt.global[936] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 1405) then         -- "Parson's Quill"
		evt.SetMessage(1401)         -- "The actual Peacock feather that was used to sign the Treaty of Pierpont.  My collection is complete!  I will be sure to record your activities and deeds correctly and justly so that all will know you as the true Lords of Harmondale!"
		evt.Subtract("Inventory", 1405)         -- "Parson's Quill"
		evt.Add("Awards", 38)         -- "Returned Parson's Quill to Norbert Thrush"
		evt.Add("Experience", 5000)
		evt.ForPlayer("Current")
		evt.Add("Gold", 2000)
		evt.Subtract("QBits", 671)         -- "Return Parson's Quill to Norbert Thrush in Erathia."
		evt.SetNPCTopic{NPC = 435, Index = 0, Event = 0}         -- "Norbert Thrush"
		evt.SetNPCGreeting{NPC = 435, Greeting = 273}         -- "Norbert Thrush" : "Thank you for returning the Parson's Quill sent by Lord Markham.  You help has made my collection complete!"
		evt.Subtract("Reputation", 5)
	else
		evt.SetMessage(1400)         -- "Did Lord Markham refuse to give you the Quill, or have you not even visited him yet?  His Manor is in Tatalia, please don't forget to help me."
	end
end

-- "Quest"
Game.GlobalEvtLines:RemoveEvent(937)
evt.global[937] = function()
	evt.ForPlayer("All")
	evt.SetMessage(1402)         -- "A letter from Norbert Thrush the Historian? Let me see it.  [Lord Markham scans the letter briefly] Hmmmmm…he wants the Peacock feather that was used to sign the Treaty of Pierpont, does he.  Well, seeing as though he has a supposed original of the Treaty, I guess the feather should go to him.  He has promised me anything else in his collection.  Take this to him and tell him that I will come collect from him shortly!"
	evt.Subtract("Inventory", 1416)         -- "Letter from Norbert Thrush to Lord Markham"
	evt.ForPlayer("Current")
	evt.Add("Inventory", 1405)         -- "Parson's Quill"
	evt.Subtract("QBits", 670)         -- "Take Sealed Letter to Lord Markham in Lord Markham's Manor in Tatalia for collector Norbert Thrush."
	evt.Set("QBits", 671)         -- "Return Parson's Quill to Norbert Thrush in Erathia."
	evt.SetNPCTopic{NPC = 340, Index = 4, Event = 0}         -- "Lord Markham"
end

evt.CanShowTopic[937] = function()
	return evt.Cmp("Inventory", 1416)         -- "Letter from Norbert Thrush to Lord Markham"
end

-- "Quest"
Game.GlobalEvtLines:RemoveEvent(938)
evt.global[938] = function()
	evt.SetMessage(1403)         -- "I hear you folk are the new Lords of Harmondale, eh?  Perhaps you could do me a large favor, and help yourselves in the process.  To the north, in Avlee, lies the Hall under the Hill, the domain of the Faerie King.  He owes me a debt from a previous service of mine, and I would like to collect it.  Unfortunately, the faeries in the Hall and the tricks they play frighten me to death.  If you would deliver this letter to the Faerie King, and return what he gives you to me, I'd be very grateful.  You would also have the chance to meet the Faerie King for yourselves."
	evt.Add("QBits", 691)         -- "Take the sealed letter to the Faerie King in the Hall under the Hill in Avlee."
	evt.Add("Inventory", 1409)         -- "Letter from Johann Kerrid to the Faerie King"
	evt.SetNPCTopic{NPC = 436, Index = 0, Event = 940}         -- "Johann Kerrid" : "Quest"
end

-- "Pipes"
Game.GlobalEvtLines:RemoveEvent(939)
evt.global[939] = function()
	evt.ForPlayer("All")
	evt.SetMessage(1003)         -- "So, Johann be wanting the Faerie Pipes, eh?  I can't say I'm surprised--he wouldn't come here himself, the coward.  The Pipes will cost you, though… all your food.  Of course, I've got some delightful food down below, should thee be wanting to restock your packs."
	evt.Subtract("Inventory", 1409)         -- "Letter from Johann Kerrid to the Faerie King"
	evt.Add("Experience", 2000)
	evt.ForPlayer("Current")
	evt.Add("Inventory", 1435)         -- "Faerie Pipes"
	evt.SetNPCTopic{NPC = 391, Index = 1, Event = 0}         -- "Faerie King"
	evt.Subtract("QBits", 691)         -- "Take the sealed letter to the Faerie King in the Hall under the Hill in Avlee."
	evt.Add("QBits", 692)         -- "Take the Faerie Pipes to Johann Kerrid in the Tularean Forest."
	evt.Set("Food", 0)
end

evt.CanShowTopic[939] = function()
	return evt.Cmp("Inventory", 1409)         -- "Letter from Johann Kerrid to the Faerie King"
end

-- "Quest"
Game.GlobalEvtLines:RemoveEvent(940)
evt.global[940] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 1435) then         -- "Faerie Pipes"
		evt.SetMessage(1404)         -- "Excellent!  The Pipes!  You don't know what this means to me.  Here, take this as a reward and thank you again for your help in this!"
		evt.Subtract("Inventory", 1435)         -- "Faerie Pipes"
		evt.Add("Experience", 5000)
		evt.ForPlayer("Current")
		evt.Add("Awards", 39)         -- "Returned Faerie Pipes to Johann Kerrid"
		evt.Add("Gold", 1000)
		evt.Subtract("QBits", 692)         -- "Take the Faerie Pipes to Johann Kerrid in the Tularean Forest."
		evt.SetNPCTopic{NPC = 436, Index = 0, Event = 0}         -- "Johann Kerrid"
		evt.SetNPCGreeting{NPC = 436, Greeting = 275}         -- "Johann Kerrid" : "Thank you so much for returning the Faerie Pipes to me!  I would have never been able to brave the Hall under the Hill myself."
		evt.Subtract("Reputation", 5)
	else
		evt.SetMessage(1405)         -- "Don't forget to give the letter to the Faerie King.  Without it, he probably won't even want to talk to you."
	end
end

-- "Quest"
evt.CanShowTopic[941] = function()
	if not evt.Cmp("QBits", 695) then         -- Failed either goto or do guild quest
		return evt.Cmp("QBits", 611)         -- Chose the path of Light
	end
	return false
end

Game.GlobalEvtLines:RemoveEvent(941)
evt.global[941] = function()
	evt.SetMessage(1406)         -- "We request your services for only one small task.  In Castle Lambent rests a valuable tapestry taken from an attack on Watchtower 3 years ago.  I would like you to get the tapestry for me, as you must have *some* access to the Castle-- my normal associates can't even come near the place.  I hear a large band of goblins and renegade swordsmen are about... it would be a shame if they happened to find a way to Harmondale.  You have one month to get the tapestry.  Don't be late."
	evt.Set("QBits", 694)         -- "Steal the Tapestry from your associate's Castle and return it to Niles Stantley in the Mercenary Guild in Tatalia."
	evt.Set("Counter5", 0)
	evt.SetNPCTopic{NPC = 438, Index = 0, Event = 943}         -- "Niles Stantley" : "Quest"
end

-- "Quest"
evt.CanShowTopic[942] = function()
	if not evt.Cmp("QBits", 695) then         -- Failed either goto or do guild quest
		return evt.Cmp("QBits", 612)         -- Chose the path of Dark
	end
	return false
end

Game.GlobalEvtLines:RemoveEvent(942)
evt.global[942] = function()
	evt.SetMessage(1407)         -- "We request your services for one task.  A rare and valuable tapestry rests in Castle Gloaming, an antique from near the Silence stolen from the wizards some time ago.  I would like you to get the tapestry for me, as my normal associates don't have access to Castle Gloaming.  In return, I'll make sure that the large band of renegade swordsmen and goblins near Harmondale don't accidentally stumble upon your quiet, little village.  You have one month; don't be late."
	evt.Set("QBits", 694)         -- "Steal the Tapestry from your associate's Castle and return it to Niles Stantley in the Mercenary Guild in Tatalia."
	evt.Set("Counter5", 0)
	evt.SetNPCTopic{NPC = 438, Index = 1, Event = 943}         -- "Niles Stantley" : "Quest"
end

-- "Quest"
Game.GlobalEvtLines:RemoveEvent(943)
evt.global[943] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Counter5", 672) then
		evt.SetMessage(1409)         -- "I see.  Well, it would appear that the band of renegades has indeed discovered your little town, and has begun looting.  You may find your bank account a little, well, pinched.  Consider this a lesson in punctuality.  Go now and have a pleasant, pleasant day."
		evt.Add("QBits", 695)         -- Failed either goto or do guild quest
	elseif evt.Cmp("Inventory", 1422) then         -- "Big Tapestry"
		evt.SetMessage(1408)         -- "Excellent!  I see that you can be trusted to perform well when called upon.  I'll keep that in mind the next time I need a job done.  Your reward is nothing more than status quo-- things could be much worse than they already are.  Go now, I have no more time for you."
		evt.Subtract("Inventory", 1422)         -- "Big Tapestry"
		evt.Add("Reputation", 5)
		evt.Add("QBits", 702)         -- Finished with Malwick & Assc.
		evt.Subtract("QBits", 694)         -- "Steal the Tapestry from your associate's Castle and return it to Niles Stantley in the Mercenary Guild in Tatalia."
		evt.SetNPCTopic{NPC = 438, Index = 0, Event = 0}         -- "Niles Stantley"
		evt.SetNPCTopic{NPC = 438, Index = 1, Event = 0}         -- "Niles Stantley"
		evt.SetNPCTopic{NPC = 438, Index = 2, Event = 0}         -- "Niles Stantley"
	else
		evt.SetMessage(1011)         -- "You don't have the tapestry yet, and the clock is ticking.  It would be prudent to keep to the task at hand rather than bothering me with your babble."
	end
end

-- "Quest"
Game.GlobalEvtLines:RemoveEvent(944)
evt.global[944] = function()
	evt.SetMessage(1410)         -- "A few years back, while mining underneath Stone City, we came upon quite a shock.  It seems that the Warlocks from Nighon had burrowed under the sea to make a sneak attack upon the shores of Erathia.  Their careless tunneling has sunken the earth around here until now the areas around the old dwarven barrows and, of course, Stone City, rest far above the terrain.  We discovered a force of troglodytes in our mining areas, with a tunnel leading back to Nighon.  If you could help us by ridding the tunnels of the troglodytes, we could get back to mining.  Can you help us?"
	evt.Set("QBits", 698)         -- "Kill all the Troglodytes underneath Stone City and return to Spark Burnkindle in Stone City."
	evt.SetNPCTopic{NPC = 439, Index = 0, Event = 945}         -- "Spark Burnkindle" : "Quest"
end

-- "Quest"
Game.GlobalEvtLines:RemoveEvent(945)
evt.global[945] = function()
	if not evt.CheckMonstersKilled{CheckType = 2, Id = 411, Count = 0} then
		evt.SetMessage(1411)         -- "There are still troglodytes roaming the lower mine levels.  Please remove them!"
	elseif not evt.CheckMonstersKilled{CheckType = 2, Id = 412, Count = 0} then
		evt.SetMessage(1411)         -- "There are still troglodytes roaming the lower mine levels.  Please remove them!"
	elseif evt.CheckMonstersKilled{CheckType = 2, Id = 413, Count = 0} then
		evt.SetMessage(1412)         -- "They're gone?  Routed back into the connecting tunnels to Nighon!  Excellent!  We can get back to mining immediately!  Thank you so much for your help; take this as a reward for your services."
		evt.Add("Gold", 2500)
		evt.ForPlayer("All")
		evt.Add("Experience", 5000)
		evt.Subtract("QBits", 698)         -- "Kill all the Troglodytes underneath Stone City and return to Spark Burnkindle in Stone City."
		evt.Set("Awards", 40)         -- "Troglodyte Slayer"
		evt.SetNPCTopic{NPC = 439, Index = 0, Event = 0}         -- "Spark Burnkindle"
		evt.Subtract("Reputation", 10)
		evt.SetNPCGreeting{NPC = 439, Greeting = 279}         -- "Spark Burnkindle" : "Thank you for helping us by getting rid of those nasty Troglodytes!"
	else
		evt.SetMessage(1411)         -- "There are still troglodytes roaming the lower mine levels.  Please remove them!"
	end
end

-- "The Kennel"
Game.GlobalEvtLines:RemoveEvent(946)
evt.global[946] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 1584) then         -- "Journal of Experiments"
		evt.SetMessage(1030)         -- "The Journal!!!  I knew you were up to the task.  You have done the crown a great service.  I hereby grant you the title of ‘The Queen’s Champions’."
		evt.Subtract("QBits", 541)         -- "Kill the creatures in the Kennel and return to Queen Catherine with the Journal of Experiments.."
		evt.Add("Experience", 50000)
		evt.Set("Awards", 121)         -- "Declared the Queen’s Champions"
		evt.SetNPCTopic{NPC = 408, Index = 0, Event = 0}         -- "Queen Catherine"
		evt.SetNPCGreeting{NPC = 408, Greeting = 135}         -- "Queen Catherine" : "The door to the west leads to the local Tavern.  The tavern is a safe place to sleep at night, and to buy food so you can sleep outdoors.  You can often meet interesting people in taverns, or catch the local gossip if you're looking for something to do.  To enter the tavern, just click on the front door."
		evt.Subtract("Inventory", 1584)         -- "Journal of Experiments"
	else
		evt.SetMessage(1029)         --[[ " During our recent disputes with the Elves, we began conducting experiments to produce the ultimate combat instrument, a creature with no fear and great predatory abilities.  These experiments were conducted in an abandoned tomb appropriately renamed ‘the Kennel’, located along the southeastern shore of the Erathian River.

Well, our experiments were far too successful and the creatures turned on their handlers and devoured them. I have sent small contingents of my personal retinue to dispense of these creatures, but none has returned.  I assume them all dead.

I need you to proceed to the Kennel, eliminate all creatures, obtain the Journal of Experiments, and return to me.  The reward will be commensurate with your efforts.

Oh! before I forget.  The entrance to the Kennel is secured by a cipher lock.  The combination is Top, Right, Bottom, Left, Center.  Good luck!" ]]
		evt.Set("QBits", 541)         -- "Kill the creatures in the Kennel and return to Queen Catherine with the Journal of Experiments.."
	end
end

-- "Control Cube"
Game.GlobalEvtLines:RemoveEvent(947)
evt.global[947] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 1477) then         -- "Control Cube"
		if evt.Cmp("Awards", 127) then         -- "Declared Friends of ‘The Game’"
			evt.Subtract("NPCs", 360)         -- "Zedd True Shot"
			evt.Subtract("NPCs", 357)         -- "Lord Godwinson"
			evt.Subtract("NPCs", 359)         -- "Baron BunGleau"
			evt.Subtract("NPCs", 374)         -- "Sir Vilx of Stone City"
			evt.Subtract("NPCs", 373)         -- "Duke Bimbasto"
			evt.Subtract("NPCs", 376)         -- "Pascal the Mad Mage"
			evt.SetMessage(1186)         -- "Excellent!  Now that we have the Control Cube, you need to see Resurectra in Castle Lambent.  She will provide details on your next assignment."
			evt.Subtract("QBits", 874)         -- " Enter the Treasury in Deja, find the key and enter the Vault, retrieve the Control Cube, and return to Robert the Wise in Celeste."
			evt.Subtract("Inventory", 1477)         -- "Control Cube"
			evt.SetNPCTopic{NPC = 422, Index = 0, Event = 0}         -- "Robert the Wise"
			evt.MoveNPC{NPC = 422, HouseId = 0}         -- "Robert the Wise"
			evt.Set("Awards", 122)         -- "Retrieved Control Cube"
			evt.Add("Experience", 500000)
			evt.SetNPCTopic{NPC = 419, Index = 1, Event = 905}         -- "Resurectra" : "Strike the Devils"
		else
			evt.Set("Awards", 128)         -- "Hall of Shame Award ‘Unfaithful Friends’"
			evt.Subtract("Inventory", 1477)         -- "Control Cube"
			evt.Set("Eradicated", 0)
		end
	elseif not evt.Cmp("QBits", 874) then         -- " Enter the Treasury in Deja, find the key and enter the Vault, retrieve the Control Cube, and return to Robert the Wise in Celeste."
		evt.SetMessage(961)         --[[ "Our preparations are nearing completion.  However we first need to obtain an artifact known as the ‘Control Cube’.  This artifact is guarded by Jester’s Folly, a dragon of such power that all other creatures flee from its presence!  This dragon resides in the Vault, a cavern deep within the bowls of Deja. The entrance to the Vault is guarded by the Treasury, a bulwark fortress built by the Necromancers to protect the artifact.

We need your party to break into the Treasury, find the key, enter the Vault, slay Jester’s Folly, retrieve the Control Cube, and return to me.

Duke Bimbasto and Sir Vilx.., Erathia's Greatest Champions, have offered their assistance.  They will meet you at the entrance to the Treasury.

Be careful on this quest.  The dangers are many, and the foes are plenty." ]]
		evt.Set("QBits", 874)         -- " Enter the Treasury in Deja, find the key and enter the Vault, retrieve the Control Cube, and return to Robert the Wise in Celeste."
		evt.SetNPCGreeting{NPC = 422, Greeting = 137}         -- "Robert the Wise" : "You must bring the Control Cube to me."
	end
end

-- "Mourning"
Game.GlobalEvtLines:RemoveEvent(948)
evt.global[948] = function()
	evt.SetMessage(1645)         -- "Pardon me, strangers, but I'm not feeling very sociable right now.  My brother Elrond has recently departed this world and my grief is great at his passing."
	evt.SetNPCTopic{NPC = 624, Index = 0, Event = 1257}         -- "Darron Temper" : "Can we help?"
end

-- "Quest"
Game.GlobalEvtLines:RemoveEvent(949)
evt.global[949] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 1453) then         -- "Arcomage Deck"
		evt.SetMessage(1357)         -- "Dead?  Oh dear!  Those are certainly his cards, though.  I don't want the cards; you can have them-- that game has cost me enough now.  Oh, poor Elron!  I have a little money you can keep for your help, and thank you for finding out what happened to Elron."
		evt.Add("Experience", 2000)
		evt.ForPlayer("Current")
		evt.Subtract("QBits", 706)         -- "Find the fate of Darron's brother in the White Cliff Caves, then return to Darron Temper in Harmondale."
		evt.Add("Gold", 750)
		evt.SetNPCTopic{NPC = 624, Index = 0, Event = 0}         -- "Darron Temper"
		evt.Subtract("Reputation", 5)
	else
		evt.SetMessage(1356)         -- "Still no sign of him?  I understand.  If you do happen to find out what happened to him, please let me know."
	end
end

-- "Quest"
evt.CanShowTopic[1063] = function()
	return evt.Cmp("QBits", 611)         -- Chose the path of Light
end

Game.GlobalEvtLines:RemoveEvent(1063)
evt.global[1063] = function()
	evt.SetMessage(1358)         -- "The School of Sorcery here in the Bracada Desert collects a number of odd magical paraphernalia.  A few years ago an item of particular interest was stolen from the School by raiders from Deyja.  This item, the Seasons' Stole, was worn by Priests of the Sun during religious ceremonies at the turn of the seasons.  As a representative of the School of Sorcery, I'm authorized to reward you for its return.  Our last information placed the stolen Stole in the Hall of the Pit; I would suggest checking there first."
	evt.Add("QBits", 707)         -- "Retrieve the Seasons' Stole from the Hall of the Pit and return it to Gary Zimm in the Bracada Desert."
	evt.SetNPCTopic{NPC = 625, Index = 0, Event = 1064}         -- "Gary Zimm" : "Quest"
end

-- "Quest"
Game.GlobalEvtLines:RemoveEvent(1064)
evt.global[1064] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 1440) then         -- "Season's Stole"
		evt.SetMessage(1360)         -- "Excellent!  This most certainly is the Seasons' Stole.  Here is your reward; you've done both the School of Sorcery and myself a great service."
		evt.Subtract("Inventory", 1440)         -- "Season's Stole"
		evt.Add("Experience", 7500)
		evt.ForPlayer("Current")
		evt.Add("Gold", 7500)
		evt.Subtract("QBits", 707)         -- "Retrieve the Seasons' Stole from the Hall of the Pit and return it to Gary Zimm in the Bracada Desert."
		evt.Add("Awards", 52)         -- "Retrieved the Seasons' Stole"
		evt.Subtract("Reputation", 5)
		evt.SetNPCTopic{NPC = 625, Index = 0, Event = 0}         -- "Gary Zimm"
	else
		evt.SetMessage(1359)         -- "Don't forget there is a reward for the Seasons' Stole if you are able to find it and return it to me."
	end
end

-- "Elsie Pederton"
Game.GlobalEvtLines:RemoveEvent(1065)
evt.global[1065] = function()
	evt.SetMessage(1419)         -- "The Master instructor of the Staff, Elsie Pederton, can be found in the Bracada Desert, on a ridge in the southwest region."
	evt.Set("AutonotesBits", 323)         -- "The Master instructor of the Staff, Elsie Pederton, can be found in the Bracada Desert, on a ridge in the southwest region."
end

-- "Jillian Mithrit"
Game.GlobalEvtLines:RemoveEvent(1066)
evt.global[1066] = function()
	evt.SetMessage(1420)         -- "The ultimate teacher in the ways of the Staff, Jillian Mithrit, can be found in the elven territory of Avlee.  Her home is in the city in the northeast."
	evt.Set("AutonotesBits", 324)         -- "The ultimate teacher in the ways of the Staff, Jillian Mithrit, can be found in the elven territory of Avlee.  Her home is in the city in the northeast."
end

-- "Swordsmanship"
Game.GlobalEvtLines:RemoveEvent(1067)
evt.global[1067] = function()
	evt.SetMessage(1421)         -- "As you can see, the Master instructor of the Sword, Tugor Slicer, maintains his residence with my brother and myself here on Emerald Island.  Return to us when you need advancement with the blade."
	evt.Set("AutonotesBits", 325)         -- "The Master instructor of the Sword, Tugor Slicer, lives with the Telmar brothers on Emerald Island."
end

-- "Chadric Townsaver"
Game.GlobalEvtLines:RemoveEvent(1068)
evt.global[1068] = function()
	evt.SetMessage(1422)         -- "The Grandmaster of the Sword, Chadric Townsaver, can be found in a small village in Welnin, just south of the city of Harmondale."
	evt.Set("AutonotesBits", 326)         -- "The Grandmaster of the Sword, Chadric Townsaver, can be found in a small village in Welnin, just south of the city of Harmondale."
end

-- "Aznog Slasher"
Game.GlobalEvtLines:RemoveEvent(1069)
evt.global[1069] = function()
	evt.SetMessage(1423)         -- "The Master tutor of the Dagger, Aznog Slasher, can be found in the northern region of Nighon."
	evt.Set("AutonotesBits", 327)         -- "The Master tutor of the Dagger, Aznog Slasher, can be found in the northern region of Nighon."
end

-- "Tonken Fist"
Game.GlobalEvtLines:RemoveEvent(1070)
evt.global[1070] = function()
	evt.SetMessage(1424)         -- "The Grandmaster of the Dagger, Token Fist, can be found in city of Tidewater in Tatalia.  Rumor has it that the Master Thief in the depths of the Erathian Sewers beneath the capitol city of Steadwick can also instruct at this level."
	evt.Set("AutonotesBits", 328)         -- "The Grandmaster of the Dagger, Token Fist, can be found in city of Tidewater in Tatalia.  Rumor has it that the Master Thief in the depths of the Erathian Sewers beneath the capitol city of Steadwick can also instruct at this level."
end

-- "Dalin Keenedge"
Game.GlobalEvtLines:RemoveEvent(1071)
evt.global[1071] = function()
	evt.SetMessage(1425)         -- "The Master Instructor of all that is the Axe, Dalin Keenedge, can be found in the northeast corner of Stone City."
	evt.Set("AutonotesBits", 329)         -- "The Master Instructor of all that is the Axe, Dalin Keenedge, can be found in the northeast corner of Stone City."
end

-- "Karn Stonecleaver"
Game.GlobalEvtLines:RemoveEvent(1072)
evt.global[1072] = function()
	evt.SetMessage(1426)         -- "The ultimate teacher of the uses of the Axe, Karn Stonecleaver, can be found in the snowy heights of the northeast region of Tatalia."
	evt.Set("AutonotesBits", 330)         -- "The ultimate teacher of the uses of the Axe, Karn Stonecleaver, can be found in the snowy heights of the northeast region of Tatalia."
end

-- "Claderin Silverpoint"
Game.GlobalEvtLines:RemoveEvent(1073)
evt.global[1073] = function()
	evt.SetMessage(1427)         -- "The Master teacher, Claderin Silverpoint, can be found in the northeast section of the city of Pierpont in the elven region of the Tularean Forest. There he will further you knowledge of the Spear."
	evt.Set("AutonotesBits", 331)         -- "The Master teacher, Claderin Silverpoint, can be found in the northeast section of the city of Pierpont in the elven region of the Tularean Forest. There he will further you knowledge of the Spear."
end

-- "Seline Falconeye"
Game.GlobalEvtLines:RemoveEvent(1074)
evt.global[1074] = function()
	evt.SetMessage(1428)         -- "The Grandmaster of the Spear, Selene Falconeye, makes her home in the northeast corner of Stone City."
	evt.Set("AutonotesBits", 332)         -- "The Grandmaster of the Spear, Selene Falconeye, makes her home in the northeast corner of Stone City."
end

-- "Lanshee Ravensight"
Game.GlobalEvtLines:RemoveEvent(1075)
evt.global[1075] = function()
	evt.SetMessage(1429)         -- "The Master tutor of the Bow, Lanshee Ravensight, lives in the northern regions of Nighon."
	evt.Set("AutonotesBits", 333)         -- "The Master tutor of the Bow, Lanshee Ravensight, lives in the northern regions of Nighon."
end

-- "Cardric the Steady"
Game.GlobalEvtLines:RemoveEvent(1076)
evt.global[1076] = function()
	evt.SetMessage(1430)         -- "The Grandmaster of the Bow, Cardric the Steady, can be found just to the southeast of the castle in the city of Harmondale."
	evt.Set("AutonotesBits", 334)         -- "The Grandmaster of the Bow, Cardric the Steady, can be found just to the southeast of the castle in the city of Harmondale."
end

-- "Brother Rothham"
Game.GlobalEvtLines:RemoveEvent(1077)
evt.global[1077] = function()
	evt.SetMessage(1431)         -- "The Master instructor of the Mace, Brother Rothham, can be found in the southern region of the swamps of Tatalia."
	evt.Set("AutonotesBits", 335)         -- "The Master instructor of the Mace, Brother Rothham, can be found in the southern region of the swamps of Tatalia."
end

-- "Patwin Fellbern"
Game.GlobalEvtLines:RemoveEvent(1078)
evt.global[1078] = function()
	evt.SetMessage(1432)         -- "The Grandmaster of the Mace, Patwin Felburn, teaches from his home in the goblin village found in the eastern area of the Deyja. "
	evt.Set("AutonotesBits", 336)         -- "The Grandmaster of the Mace, Patwin Felburn, teaches from his home in the goblin village found in the eastern area of Deyja."
end

-- "Isram Gallowswell"
Game.GlobalEvtLines:RemoveEvent(1079)
evt.global[1079] = function()
	evt.SetMessage(1433)         -- "My Master, Isram Gallowswell, can be found in the snowy heights of the northeast area of Tatalia. You will gain further instruction in the Shield there."
	evt.Set("AutonotesBits", 337)         -- "My Master, Isram Gallowswell, can be found in the snowy heights of the northeast area of Tatalia. You will gain further instruction in the Shield there."
end

-- "Fedwin Smithson"
Game.GlobalEvtLines:RemoveEvent(1080)
evt.global[1080] = function()
	evt.SetMessage(1434)         -- "The Grandmaster of the Shield, Fedwin Smithson, can be found on the eastern island of the Evenmorn Islands."
	evt.Set("AutonotesBits", 338)         -- "The Grandmaster of the Shield, Fedwin Smithson, can be found on the eastern island of the Evenmorn Islands."
end

-- "Rabisa Nedlon"
Game.GlobalEvtLines:RemoveEvent(1081)
evt.global[1081] = function()
	evt.SetMessage(1435)         -- "The Master tutor of Leather Armor, Rabisa Neldon, lives in the northern regions of Nighon."
	evt.Set("AutonotesBits", 339)         -- "The Master tutor of Leather Armor, Rabisa Neldon, lives in the northern regions of Nighon."
end

-- "Miyon the Quick"
Game.GlobalEvtLines:RemoveEvent(1082)
evt.global[1082] = function()
	evt.SetMessage(1436)         -- "The Grandmaster of Leather Armor, Miyon the Quick, can be found in the eastern section of the city of Pierpont in the elven region of the Tularean Forest."
	evt.Set("AutonotesBits", 340)         -- "The Grandmaster of Leather Armor, Miyon the Quick, can be found in the eastern section of the city of Pierpont in the elven region of the Tularean Forest."
end

-- "Medwari Dragontracker"
Game.GlobalEvtLines:RemoveEvent(1083)
evt.global[1083] = function()
	evt.SetMessage(1437)         -- "The Master instructor of uses of Chain Armor, Medwari Dragontracker, can be found in the elven territory of Avlee.  His home is in the city in the northeast."
	evt.Set("AutonotesBits", 341)         -- "The Master instructor of uses of Chain Armor, Medwari Dragontracker, can be found in the elven territory of Avlee.  His home is in the city in the northeast."
end

-- "Halian Nevermore"
Game.GlobalEvtLines:RemoveEvent(1084)
evt.global[1084] = function()
	evt.SetMessage(1438)         -- "The Grandmaster instructor of Chain Armor, Halian Nevermore, maintains his residence in a large city in the northwest region of Deyja."
	evt.Set("AutonotesBits", 342)         -- "The Grandmaster instructor of Chain Armor, Halian Nevermore, maintains his residence in a large city in the northwest region of Deyja."
end

-- "Dekian Forgewright"
Game.GlobalEvtLines:RemoveEvent(1085)
evt.global[1085] = function()
	evt.SetMessage(1439)         -- "My Master, Dekian Forgewright, makes his home in Erathia in the capitol city of Steadwick. He can provide further instruction in the uses of Plate Armor."
	evt.Set("AutonotesBits", 343)         -- "My Master, Dekian Forgewright, makes his home in Erathia in the capitol city of Steadwick. He can provide further instruction in the uses of Plate Armor."
end

-- "Brand the Maker"
Game.GlobalEvtLines:RemoveEvent(1086)
evt.global[1086] = function()
	evt.SetMessage(1440)         -- "The Grandmaster of Plate Armor, Brand the Maker, can be found in the Bracada desert, on a ridge in the central region."
	evt.Set("AutonotesBits", 344)         -- "The Grandmaster of Plate Armor, Brand the Maker, can be found in the Bracada desert, on a ridge in the central region."
end

-- "Ashen Temper"
Game.GlobalEvtLines:RemoveEvent(1087)
evt.global[1087] = function()
	evt.SetMessage(1441)         -- "The Master tutor of Fire Magic, Ashen Temper, can be found in  her home in the Tularean Forest ."
	evt.Set("AutonotesBits", 345)         -- "The Master tutor of Fire Magic, Ashen Temper, can be found in her home in the Tularean Forest "
end

-- "Blayze "
Game.GlobalEvtLines:RemoveEvent(1088)
evt.global[1088] = function()
	evt.SetMessage(1442)         -- "The Grandmaster of Fire Magic, Blayze, makes his home on Emerald Island."
	evt.Set("AutonotesBits", 346)         -- "The Grandmaster of Fire Magic, Blayze, makes his home in Emerald Island."
end

-- "Rislyn Greenstorm"
Game.GlobalEvtLines:RemoveEvent(1089)
evt.global[1089] = function()
	evt.SetMessage(1443)         -- "The Master tutor of Air Magic, Rislyn Greenstorm, lives in the elven territory of Avlee.  His home is in the city in the northeast."
	evt.Set("AutonotesBits", 347)         -- "The Master tutor of Air Magic, Rislyn Greenstorm, lives in the elven territory of Avlee.  His home is in the city in the northeast."
end

-- "Gayle"
Game.GlobalEvtLines:RemoveEvent(1090)
evt.global[1090] = function()
	evt.SetMessage(1444)         -- "The Grandmaster of Air Magic, Gayle, can be found in a tower in the Bracada desert, on a ridge in the northern region."
	evt.Set("AutonotesBits", 348)         -- "The Grandmaster of Air Magic, Gayle, can be found in a tower in the Bracada desert, on a ridge in the northern region."
end

-- "Tobren Rainshield"
Game.GlobalEvtLines:RemoveEvent(1091)
evt.global[1091] = function()
	evt.SetMessage(1445)         -- "The Master tutor of the uses of Water Magic, Tobren Rainshield, travels with the Lady Margaret which docks in Emerald Island."
	evt.Set("AutonotesBits", 349)         -- "The Master tutor of the uses of Water Magic, Tobren Rainshield, travels with the Lady Margaret.  The fine Lady docks in Emerald Island."
end

-- "Torrent"
Game.GlobalEvtLines:RemoveEvent(1092)
evt.global[1092] = function()
	evt.SetMessage(1446)         -- "The Grandmaster of Water Magic, Torrent, lives on a ridge, south of Harmondale, overlooking the city."
	evt.Set("AutonotesBits", 350)         -- "The Grandmaster of Water Magic, Torrent, lives on a ridge, south of Harmondale, overlooking the city."
end

-- "Lara Stonewright"
Game.GlobalEvtLines:RemoveEvent(1093)
evt.global[1093] = function()
	evt.SetMessage(1447)         -- "The Master tutor of Earth Magic, Lara Stonewright, makes her home in the elven territory of the Tularean Forest.  Her residence is in the city of Pierpont."
	evt.Set("AutonotesBits", 351)         -- "The Master tutor of Earth Magic, Lara Stonewright, makes her home in the elven territory of the Tularean Forest.  Her residence is in the city of Pierpont."
end

-- "Avalanche"
Game.GlobalEvtLines:RemoveEvent(1094)
evt.global[1094] = function()
	evt.SetMessage(1448)         -- "The Grandmaster instructor of Earth Magic, Avalanche, maintains his residence in the western region of the Deyja."
	evt.Set("AutonotesBits", 352)         -- "The Grandmaster instructor of Earth Magic, Avalanche, maintains his residence in the western region of the Deyja."
end

-- "Heather Dreamwright"
Game.GlobalEvtLines:RemoveEvent(1095)
evt.global[1095] = function()
	evt.SetMessage(1449)         -- "The Master who taught me, Heather Dreamwright, makes her home in Erathia, somewhere in the capitol city of Steadwick.  Further knowledge of Spirit Magic can be gained there."
	evt.Set("AutonotesBits", 353)         -- "The Master who taught me, Heather Dreamwright, makes her home in Erathia, somewhere in the capitol city of Steadwick.  Further knowledge of Spirit Magic can be gained there."
end

-- "Benjamin the Balanced"
Game.GlobalEvtLines:RemoveEvent(1096)
evt.global[1096] = function()
	evt.SetMessage(1450)         -- "The ultimate teacher in the ways of Spirit Magic, Benjamin the Balanced, can be found in the elven territory of the Tularean Forest.  His home is in the city of Pierpont."
	evt.Set("AutonotesBits", 354)         -- "The ultimate teacher in the ways of Spirit Magic, Benjamin the Balanced, can be found in the elven territory of the Tularean Forest.  His home is in the city of Pierpont."
end

-- "Myles Featherwind"
Game.GlobalEvtLines:RemoveEvent(1097)
evt.global[1097] = function()
	evt.SetMessage(1451)         -- "The Master teacher in the ways of Mind Magic, Myles Featherwind, can be found in the elven territory of Avlee.  His home is in the city to the northeast."
	evt.Set("AutonotesBits", 355)         -- "The Master teacher in the ways of Mind Magic, Myles Featherwind, can be found in the elven territory of Avlee.  His home is in the city to the northeast."
end

-- "Xavier Bremen"
Game.GlobalEvtLines:RemoveEvent(1098)
evt.global[1098] = function()
	evt.SetMessage(1452)         -- "The Grandmaster of Mind Magic, Xavier Bremen, can be found in the snowy heights of the northeast area of Tatalia. "
	evt.Set("AutonotesBits", 356)         -- "The Grandmaster of Mind Magic, Xavier Bremen, can be found in the snowy heights of the northeast area of Tatalia. "
end

-- "Brother Bombah"
Game.GlobalEvtLines:RemoveEvent(1099)
evt.global[1099] = function()
	evt.SetMessage(1453)         -- "The Master teacher in the ways of Body Magic, Brother Bombah, can be found in the swampy regions of Tatalia.  His home is somewhere in the southern region."
	evt.Set("AutonotesBits", 357)         -- "The Master teacher in the ways of Body Magic, Brother Bombah, can be found in the swampy regions of Tatalia.  His home is somewhere in the southern region."
end

-- "Tempus"
Game.GlobalEvtLines:RemoveEvent(1100)
evt.global[1100] = function()
	evt.SetMessage(549)         -- "The Grandmaster teacher in the ways of Body Magic, Tempus, can be found in the elven territory of Avlee.  His home is on an island somewhere in the central bay."
	evt.Set("AutonotesBits", 358)         -- "The Grandmaster teacher in the ways of Body Magic, Tempus, can be found in the elven territory of Avlee.  His home is on an island somewhere in the central bay."
end

-- "Samuel Benson"
Game.GlobalEvtLines:RemoveEvent(1101)
evt.global[1101] = function()
	evt.SetMessage(1454)         -- "The Master of the Identify Item skill, Samuel Benson, can be found on a ridge in the central region of the Bracada desert."
	evt.Set("AutonotesBits", 359)         -- "The Master of the Identify Item skill, Samuel Benson, can be found on a ridge in the central region of the Bracada desert."
end

-- "Payge Blueswan"
Game.GlobalEvtLines:RemoveEvent(1102)
evt.global[1102] = function()
	evt.SetMessage(1455)         -- "The Grandmaster of the Identify Item skill, Payge Blueswan, can be found in the elven territory of Avlee.  His home is just northwest of the elven city of Spaward."
	evt.Set("AutonotesBits", 360)         -- "The Grandmaster of the Identify Item skill, Payge Blueswan, can be found in the elven territory of Avlee.  His home is just northwest of the elven city of Spaward."
end

-- "Bethold Caverhill"
Game.GlobalEvtLines:RemoveEvent(1103)
evt.global[1103] = function()
	evt.SetMessage(1456)         -- "The Master of the Merchant skill, Berthold Caverhill, can be found on the eastern most island of the Evenmorn Islands."
	evt.Set("AutonotesBits", 361)         -- "The Master of the Merchant skill, Berthold Caverhill, can be found on the eastern most island of the Evenmorn Islands."
end

-- "Brigham the Frugal"
Game.GlobalEvtLines:RemoveEvent(1104)
evt.global[1104] = function()
	evt.SetMessage(1457)         -- "The Grandmaster of the Merchant skill, Brigham the Frugal, can be found in a tower in the Bracada desert, on a ridge in the northern region."
	evt.Set("AutonotesBits", 362)         -- "The Grandmaster of the Merchant skill, Brigham the Frugal, can be found in a tower in the Bracada desert, on a ridge in the northern region."
end

-- "Thomas Moore"
Game.GlobalEvtLines:RemoveEvent(1105)
evt.global[1105] = function()
	evt.SetMessage(1458)         -- "The Master teacher of the Repair Item Skill, Thomas Moore, can be found in the swampy delta of the southern region of Tatalia."
	evt.Set("AutonotesBits", 363)         -- "The Grandmaster of the Merchant skill, Brigham the Frugal, can be found in a tower in the Bracada desert, on a ridge in the northern region."
end

-- "Gareth the Fixer"
Game.GlobalEvtLines:RemoveEvent(1106)
evt.global[1106] = function()
	evt.SetMessage(1459)         -- "The Grandmaster of the Repair Item Skill, Gareth the Fixer, teaches from his home in the capitol city of Steadwick in Erathia."
	evt.Set("AutonotesBits", 364)         -- "The Grandmaster of the Repair Item Skill, Gareth the Fixer, teaches from his home in the capitol city of Steadwick in Erathia."
end

-- "Wanda Foestryke"
Game.GlobalEvtLines:RemoveEvent(1107)
evt.global[1107] = function()
	evt.SetMessage(1460)         -- "The Master of the of the art of Body Building, Wanda Foestryke, can be found in the goblin village in eastern DeyJa Moor."
	evt.Set("AutonotesBits", 365)         -- "The Master of the of the art of Body Building, Wanda Foestryke, can be found in the goblin village in eastern Deyja."
end

-- "Evandar Thomas"
Game.GlobalEvtLines:RemoveEvent(1108)
evt.global[1108] = function()
	evt.SetMessage(1461)         -- "The Grandmaster of the Body Building skill, Evander Thomas, makes his home in the eastern regions of Nighon."
	evt.Set("AutonotesBits", 366)         -- "The Grandmaster of the Body Building skill, Evander Thomas, makes his home in the eastern regions of Nighon."
end

-- "Tessa Greensward"
Game.GlobalEvtLines:RemoveEvent(1109)
evt.global[1109] = function()
	evt.SetMessage(1462)         -- "The Master of Meditation, Tessa Greensward, can be found on a ridge in the southeast region of the Bracada desert."
	evt.Set("AutonotesBits", 367)         -- "The Master of Meditation, Tessa Greensward, can be found on a ridge in the southeast region of the Bracada desert."
end

-- "Kaine"
Game.GlobalEvtLines:RemoveEvent(1110)
evt.global[1110] = function()
	evt.SetMessage(1463)         -- "The Grandmaster of Meditation, Kaine, can be found in the elven territory of Avlee.  His home is on an island somewhere in the central bay."
	evt.Set("AutonotesBits", 368)         -- "The Grandmaster of Meditation, Kaine, can be found in the elven territory of Avlee.  His home is on an island somewhere in the central bay."
end

-- "Garret Dotes"
Game.GlobalEvtLines:RemoveEvent(1111)
evt.global[1111] = function()
	evt.SetMessage(1464)         -- "The Master of the Perception Skill, Garret Dotes, can be found in the elven area of the Tularean Forest.  His home is in the Elven city of Pierpont."
	evt.Set("AutonotesBits", 369)         -- "The Master of the Perception Skill, Garret Dotes, can be found in the elven area of the Tularean Forest.  His home is in the Elven city of Pierpont."
end

-- "Petra Cleareye"
Game.GlobalEvtLines:RemoveEvent(1112)
evt.global[1112] = function()
	evt.SetMessage(1465)         -- "The Grandmaster of the Skill of Perception, Petra Cleareye, can be found in the city in the northwest region of the Deyja."
	evt.Set("AutonotesBits", 370)         -- "The Grandmaster of the Skill of Perception, Petra Cleareye, can be found in the city in the northwest region of Deyja."
end

-- "Lenord Skinner"
Game.GlobalEvtLines:RemoveEvent(1113)
evt.global[1113] = function()
	evt.SetMessage(1466)         -- "The Master of Disarm Trap Skill, Lenord Skinner, lives on a ridge, south of Harmondale, overlooking the city."
	evt.Set("AutonotesBits", 371)         -- "The Master of Disarm Trap Skill, Lenord Skinner, lives on a ridge, south of Harmondale, overlooking the city."
end

-- "Silk Quicktoungue"
Game.GlobalEvtLines:RemoveEvent(1114)
evt.global[1114] = function()
	evt.SetMessage(1467)         -- "The Grandmaster of the Disarm Trap Skill, Silk Quicktoungue, makes his home in the southern region of Nighon."
	evt.Set("AutonotesBits", 372)         -- "The Grandmaster of the Disarm Trap Skill, Silk Quicktoungue, makes his home in the southern region of Nighon."
end

-- "Oberic Crane"
Game.GlobalEvtLines:RemoveEvent(1115)
evt.global[1115] = function()
	evt.SetMessage(1468)         -- "The Master of the Dodging Skill, Oberic Crane, can be found on the eastern most island of the Evenmorn Islands"
	evt.Set("AutonotesBits", 373)         -- "The Master of the Dodging Skill, Oberic Crane, can be found on the eastern most island of the Evenmorn Islands"
end

-- "Kenneth Wain"
Game.GlobalEvtLines:RemoveEvent(1116)
evt.global[1116] = function()
	evt.SetMessage(1469)         -- "The Grandmaster of the Dodging Skill, Kenneth Wain, can be found in the capitol city of Steadwick, in Erathia."
	evt.Set("AutonotesBits", 374)         -- "The Grandmaster of the Dodging Skill, Kenneth Wain, can be found in the capitol city of Steadwick, in Erathia."
end

-- "Ulbrecht the Brawler"
Game.GlobalEvtLines:RemoveEvent(1117)
evt.global[1117] = function()
	evt.SetMessage(1470)         -- "The Master of Unarmed Combat, Ulbrecht the Brawler, can be found on the eastern most island of the Evenmorn Islands."
	evt.Set("AutonotesBits", 375)         -- "The Master of Unarmed Combat, Ulbrecht the Brawler, can be found on the eastern most island of the Evenmorn Islands."
end

-- "Norris "
Game.GlobalEvtLines:RemoveEvent(1118)
evt.global[1118] = function()
	evt.SetMessage(1471)         -- "The Grandmaster of Unarmed Combat, Norris, can be found in the capitol city of Steadwick, in Erathia."
	evt.Set("AutonotesBits", 376)         -- "The Grandmaster of Unarmed Combat, Norris, can be found in the capitol city of Steadwick, in Erathia."
end

-- "Jeni Swiftfoot"
Game.GlobalEvtLines:RemoveEvent(1119)
evt.global[1119] = function()
	evt.SetMessage(1472)         -- "The Master instructor of the Identify Monster Skill, Jeni Swiftfoot, lives in the elven territory of Avlee.  Her home is in the city in the northeast."
	evt.Set("AutonotesBits", 377)         -- "The Master instructor of the Identify Monster Skill, Jeni Swiftfoot, lives in the elven territory of Avlee.  Her home is in the city in the northeast."
end

-- "Raven the Hunter"
Game.GlobalEvtLines:RemoveEvent(1120)
evt.global[1120] = function()
	evt.SetMessage(1473)         -- "The Grandmaster of the Identify Monster Skill, Raven the Hunter, can be found in a small village to the south of Harmondale."
	evt.Set("AutonotesBits", 378)         -- "The Grandmaster of the Identify Monster Skill, Raven the Hunter, can be found in a small village to the south of Harmondale."
end

-- "Paula Brightspear"
Game.GlobalEvtLines:RemoveEvent(1121)
evt.global[1121] = function()
	evt.SetMessage(1474)         -- "The Master tutor of the Armsmaster Skill, Paula Brightspear, lives in the elven territory of Avlee.  Her home is in the city in the northeast."
	evt.Set("AutonotesBits", 379)         -- "The Master tutor of the Armsmaster Skill, Paula Brightspear, lives in the elven territory of Avlee.  Her home is in the city in the northeast."
end

-- "Lasiter the Slayer"
Game.GlobalEvtLines:RemoveEvent(1122)
evt.global[1122] = function()
	evt.SetMessage(1475)         -- "The Grandmaster of the Armsmaster Skill, Lasiter the Slayer, makes his home in the eastern region of Eeofol."
	evt.Set("AutonotesBits", 380)         -- "The Grandmaster of the Armsmaster Skill, Lasiter the Slayer, makes his home in the eastern region of Eeofol."
end

-- "Leane Shadowrunner"
Game.GlobalEvtLines:RemoveEvent(1123)
evt.global[1123] = function()
	evt.SetMessage(1476)         -- "The Master tutor of the Stealing Skill, Leane Shadowrunner, makes her home in the goblin village in the eastern region of the Deyja."
	evt.Set("AutonotesBits", 381)         -- "The Master tutor of the Stealing Skill, Leane Shadowrunner, makes her home in the goblin village in the eastern region of the Deyja."
end

-- "Everil Nightwalker"
Game.GlobalEvtLines:RemoveEvent(1124)
evt.global[1124] = function()
	evt.SetMessage(1477)         -- "The Grandmaster teacher of the art of Stealing, Everil Nightwalker, can be found in the swampy delta of the southern region of Tatalia."
	evt.Set("AutonotesBits", 382)         -- "The Grandmaster teacher of the art of Stealing, Everil Nightwalker, can be found in the swampy delta of the southern region of Tatalia."
end

-- "Elzbet Winterspoon"
Game.GlobalEvtLines:RemoveEvent(1125)
evt.global[1125] = function()
	evt.SetMessage(1478)         -- "The Master of Alchemy, Elzbet Winterspoon, can be found in the western region of Nighon."
	evt.Set("AutonotesBits", 383)         -- "The Master of Alchemy, Elzbet Winterspoon, can be found in the western region of Nighon."
end

-- "Lucid Apple"
Game.GlobalEvtLines:RemoveEvent(1126)
evt.global[1126] = function()
	evt.SetMessage(1479)         -- "The Grandmaster instructor of Alchemy, Lucid Apple, can be found in the elven territory of Avlee.  His home is on an island somewhere in the central bay."
	evt.Set("AutonotesBits", 384)         -- "The Grandmaster instructor of Alchemy, Lucid Apple, can be found in the elven territory of Avlee.  His home is on an island somewhere in the central bay."
end

-- "Dorothy Senjac"
Game.GlobalEvtLines:RemoveEvent(1127)
evt.global[1127] = function()
	evt.SetMessage(1480)         -- "The Master of Learning, Dorothy Senjac, can be found in the southeast region of Nighon."
	evt.Set("AutonotesBits", 385)         -- "The Master of Learning, Dorothy Senjac, can be found in the southeast region of Nighon."
end

-- "William Davies"
Game.GlobalEvtLines:RemoveEvent(1128)
evt.global[1128] = function()
	evt.SetMessage(1481)         -- "The Grandmaster of Learning, William Smithson, instructs from his home on the eastern island of the Evenmorn Islands."
	evt.Set("AutonotesBits", 386)         -- "The Grandmaster of Learning, William Smithson, instructs from his home on the eastern island of the Evenmorn Islands."
end

-- "Helena Morningstar"
Game.GlobalEvtLines:RemoveEvent(1129)
evt.global[1129] = function()
	evt.SetMessage(1482)         -- "The Master of Light Magic, Helena Mornigstar, can be found in the cloud city of Celeste!"
	evt.Set("AutonotesBits", 387)         -- "The Master of Light Magic, Helena Mornigstar, can be found in the cloud city of Celeste!"
end

-- "Gavin Magnus"
Game.GlobalEvtLines:RemoveEvent(1130)
evt.global[1130] = function()
	evt.SetMessage(1483)         -- "The Grand Master of Light Magic can be found in the wizards castle, Castle Lambent."
	evt.Set("AutonotesBits", 388)         -- "The Grand Master of Light Magic can be found in the wizards castle, Castle Lambent."
end

-- "Seth Darkenmore"
Game.GlobalEvtLines:RemoveEvent(1131)
evt.global[1131] = function()
	evt.SetMessage(1484)         -- "The Master of Dark, Seth Darkenmore, can be found in The Pit beneath Deyja!"
	evt.Set("AutonotesBits", 389)         -- "The Master of Dark, Seth Darkenmore, can be found in The Pit beneath Deyja!"
end

-- "Archibald"
Game.GlobalEvtLines:RemoveEvent(1132)
evt.global[1132] = function()
	evt.SetMessage(1485)         -- "The Grand Master of Dark Magic can be found in the necromancer castle, Castle Gloaming.  At times Archibald has been know to take the journey to Clankers Lab."
	evt.Set("AutonotesBits", 390)         -- "The Grand Master of Dark Magic can be found in the necromancer castle, Castle Gloaming.  At times Archibald has been know to take the journey to Clankers Lab."
end

-- "Empty Barrel"
Game.GlobalEvtLines:RemoveEvent(1133)
evt.global[1133] = function()
	evt.StatusText(1486)         -- "Empty Barrel"
end

-- "Red Barrel"
Game.GlobalEvtLines:RemoveEvent(1134)
evt.global[1134] = function()
	evt.StatusText(1487)         -- "+5 Might permanent"
	evt.Add("BaseMight", 5)
	evt.Set("AutonotesBits", 289)         -- "Red liquid grants Might."
	evt.ChangeEvent(1133)         -- "Empty Barrel"
end

-- "Yellow Barrel"
Game.GlobalEvtLines:RemoveEvent(1135)
evt.global[1135] = function()
	evt.StatusText(1488)         -- "+5 Accuracy permanent"
	evt.Add("BaseAccuracy", 5)
	evt.Set("AutonotesBits", 293)         -- "Yellow liquid grants Accuracy."
	evt.ChangeEvent(1133)         -- "Empty Barrel"
end

-- "Blue Barrel"
Game.GlobalEvtLines:RemoveEvent(1136)
evt.global[1136] = function()
	evt.StatusText(1489)         -- "+5 Personality permanent"
	evt.Add("BasePersonality", 5)
	evt.Set("AutonotesBits", 291)         -- "Blue liquid grants Personality."
	evt.ChangeEvent(1133)         -- "Empty Barrel"
end

-- "Orange Barrel"
Game.GlobalEvtLines:RemoveEvent(1137)
evt.global[1137] = function()
	evt.StatusText(1490)         -- "+5 Intellect permanent"
	evt.Add("BaseIntellect", 5)
	evt.Set("AutonotesBits", 290)         -- "Orange liquid grants Intellect."
	evt.ChangeEvent(1133)         -- "Empty Barrel"
end

-- "Green Barrel"
Game.GlobalEvtLines:RemoveEvent(1138)
evt.global[1138] = function()
	evt.StatusText(1491)         -- "+5 Endurance permanent"
	evt.Add("BaseEndurance", 5)
	evt.Set("AutonotesBits", 292)         -- "Green liquid grants Endurance."
	evt.ChangeEvent(1133)         -- "Empty Barrel"
end

-- "Purple Barrel"
Game.GlobalEvtLines:RemoveEvent(1139)
evt.global[1139] = function()
	evt.StatusText(1492)         -- "+5 Speed permanent"
	evt.Add("BaseSpeed", 5)
	evt.Set("AutonotesBits", 294)         -- "Purple liquid grants Speed."
	evt.ChangeEvent(1133)         -- "Empty Barrel"
end

-- "White Barrel"
Game.GlobalEvtLines:RemoveEvent(1140)
evt.global[1140] = function()
	evt.StatusText(1493)         -- "+5 Luck permanent"
	evt.Add("BaseLuck", 5)
	evt.Set("AutonotesBits", 295)         -- "White liquid grants Luck."
	evt.ChangeEvent(1133)         -- "Empty Barrel"
end

-- "Empty Cauldron"
Game.GlobalEvtLines:RemoveEvent(1141)
evt.global[1141] = function()
	evt.StatusText(1494)         -- "Empty Cauldron"
end

-- "Steaming Cauldron"
Game.GlobalEvtLines:RemoveEvent(1142)
evt.global[1142] = function()
	evt.StatusText(1495)         -- "+10 Fire Resistance permanent"
	evt.Add("FireResistance", 10)
	evt.Set("AutonotesBits", 296)         -- "Steaming liquid grants Fire Resistance."
	evt.ChangeEvent(1141)         -- "Empty Cauldron"
end

-- "Frosty Cauldron"
Game.GlobalEvtLines:RemoveEvent(1143)
evt.global[1143] = function()
	evt.StatusText(1496)         -- "+10 Water Resistance permanent"
	evt.Add("WaterResistance", 10)
	evt.Set("AutonotesBits", 297)         -- "Frosty liquid grants Water Resistance."
	evt.ChangeEvent(1141)         -- "Empty Cauldron"
end

-- "Shocking Cauldron"
Game.GlobalEvtLines:RemoveEvent(1144)
evt.global[1144] = function()
	evt.StatusText(1497)         -- "+10 Air Resistance permanent"
	evt.Add("AirResistance", 10)
	evt.Set("AutonotesBits", 298)         -- "Shocking liquid grants Air Resistance."
	evt.ChangeEvent(1141)         -- "Empty Cauldron"
end

-- "Dirty Cauldron"
Game.GlobalEvtLines:RemoveEvent(1145)
evt.global[1145] = function()
	evt.StatusText(1498)         -- "+10 Earth Resistance permanent"
	evt.Add("EarthResistance", 10)
	evt.Set("AutonotesBits", 299)         -- "Dirty liquid grants Earth Resistance."
	evt.ChangeEvent(1141)         -- "Empty Cauldron"
end

-- "Trash Heap"
Game.GlobalEvtLines:RemoveEvent(1146)
evt.global[1146] = function()
	local i
	i = Game.Rand() % 3
	if i == 1 then
		if not evt.Cmp("PerceptionSkill", 1) then
			evt.Set("DiseasedGreen", 0)
			evt.StatusText(1499)         -- "Diseased!"
		end
		evt.GiveItem{Strength = 1, Type = const.ItemType.Armor_, Id = 0}
		goto _15
	elseif i == 2 then
		if not evt.Cmp("PerceptionSkill", 1) then
			evt.Set("DiseasedGreen", 0)
			evt.StatusText(1499)         -- "Diseased!"
		end
		evt.GiveItem{Strength = 2, Type = const.ItemType.Armor_, Id = 0}
		goto _15
	end
	if not evt.Cmp("PerceptionSkill", 1) then
		evt.Set("DiseasedYellow", 0)
		evt.StatusText(1499)         -- "Diseased!"
	end
	evt.GiveItem{Strength = 3, Type = const.ItemType.Armor_, Id = 0}
::_15::
	evt.ChangeEvent(1161)         -- "Trash Heap"
end

-- "Trash Heap"
Game.GlobalEvtLines:RemoveEvent(1147)
evt.global[1147] = function()
	local i
	i = Game.Rand() % 3
	if i == 1 then
		if not evt.Cmp("PerceptionSkill", 1) then
			evt.Set("DiseasedGreen", 0)
			evt.StatusText(1499)         -- "Diseased!"
		end
		evt.GiveItem{Strength = 1, Type = const.ItemType.Weapon_, Id = 0}
		goto _15
	elseif i == 2 then
		if not evt.Cmp("PerceptionSkill", 1) then
			evt.Set("DiseasedGreen", 0)
			evt.StatusText(1499)         -- "Diseased!"
		end
		evt.GiveItem{Strength = 2, Type = const.ItemType.Weapon_, Id = 0}
		goto _15
	end
	if not evt.Cmp("PerceptionSkill", 1) then
		evt.Set("DiseasedYellow", 0)
		evt.StatusText(1499)         -- "Diseased!"
	end
	evt.GiveItem{Strength = 3, Type = const.ItemType.Weapon_, Id = 0}
::_15::
	evt.ChangeEvent(1161)         -- "Trash Heap"
end

-- "Trash Heap"
Game.GlobalEvtLines:RemoveEvent(1148)
evt.global[1148] = function()
	local i
	i = Game.Rand() % 3
	if i == 1 then
		if not evt.Cmp("PerceptionSkill", 1) then
			evt.Set("DiseasedGreen", 0)
			evt.StatusText(1499)         -- "Diseased!"
		end
		evt.GiveItem{Strength = 1, Type = const.ItemType.Misc, Id = 0}
		goto _15
	elseif i == 2 then
		if not evt.Cmp("PerceptionSkill", 1) then
			evt.Set("DiseasedGreen", 0)
			evt.StatusText(1499)         -- "Diseased!"
		end
		evt.GiveItem{Strength = 2, Type = const.ItemType.Misc, Id = 0}
		goto _15
	end
	if not evt.Cmp("PerceptionSkill", 1) then
		evt.Set("DiseasedYellow", 0)
		evt.StatusText(1499)         -- "Diseased!"
	end
	evt.GiveItem{Strength = 3, Type = const.ItemType.Misc, Id = 0}
::_15::
	evt.ChangeEvent(1161)         -- "Trash Heap"
end

-- "Trash Heap"
Game.GlobalEvtLines:RemoveEvent(1161)
evt.global[1161] = function()
	local i
	i = Game.Rand() % 2
	if i == 1 then
		if not evt.Cmp("PerceptionSkill", 1) then
			evt.Set("DiseasedGreen", 0)
			evt.StatusText(1499)         -- "Diseased!"
			return
		end
	end
	evt.StatusText(1500)         -- "Nothing Here"
end

-- "Campfire"
Game.GlobalEvtLines:RemoveEvent(1162)
evt.global[1162] = function()
	evt.Add("Food", 2)
	if evt.Cmp("PerceptionSkill", 1) then
		evt.GiveItem{Strength = 2, Type = const.ItemType.Ring_, Id = 0}
		evt.ChangeEvent(0)
	else
		evt.ChangeEvent(0)
	end
end

-- "Campfire"
Game.GlobalEvtLines:RemoveEvent(1163)
evt.global[1163] = function()
	evt.Add("Food", 1)
	if evt.Cmp("PerceptionSkill", 1) then
		evt.GiveItem{Strength = 1, Type = const.ItemType.Ring_, Id = 0}
		evt.ChangeEvent(0)
	else
		evt.ChangeEvent(0)
	end
end

-- "Food Bowl"
Game.GlobalEvtLines:RemoveEvent(1164)
evt.global[1164] = function()
	evt.Add("Inventory", 1432)         -- "Red Delicious Apple"
	evt.ChangeEvent(0)
end

-- "Empty Cask"
Game.GlobalEvtLines:RemoveEvent(1165)
evt.global[1165] = function()
	evt.StatusText(1503)         -- "Empty Cask"
end

-- "Cask"
Game.GlobalEvtLines:RemoveEvent(1166)
evt.global[1166] = function()
	local i
	i = Game.Rand() % 6
	if i >= 3 and i <= 5 then
		i = Game.Rand() % 6
		if i >= 3 and i <= 5 then
			evt.Set("PoisonedGreen", 0)
			evt.StatusText(1501)         -- "Poisoned!"
		else
			evt.Set("Drunk", 0)
			evt.StatusText(1502)         -- "Drunk!"
		end
	else
		i = Game.Rand() % 6
		if i == 1 or i == 2 then
			evt.Add("Inventory", 1004)         -- "Vial of Troll Blood"
		elseif i == 3 or i == 4 then
			evt.Add("Inventory", 1019)         -- "Vial of Ooze Endoplasm"
		elseif i == 5 then
			evt.Add("Inventory", 1020)         -- "Mercury"
		else
			evt.Add("Inventory", 1016)         -- "Vial of Devil Ichor"
		end
	end
	evt.ChangeEvent(1165)         -- "Empty Cask"
end

-- "Mushroom"
Game.GlobalEvtLines:RemoveEvent(1167)
evt.global[1167] = function()
	evt.Add("Inventory", 1017)         -- "Mushroom"
	evt.ChangeEvent(0)
end

-- "Lord Markham"
Game.GlobalEvtLines:RemoveEvent(1168)
evt.global[1168] = function()
	evt.SetMessage(1505)         -- "So YOU'RE the ones that won Lord Markham's contest!  How do you like your winnings so far?  Had enough winning?  If I were you, I'd give him a piece of my mind!  His mansion is in Tatalia, near the wharf."
end

-- "The Master Thief"
Game.GlobalEvtLines:RemoveEvent(1169)
evt.global[1169] = function()
	evt.SetMessage(1506)         -- "Watch your wallet while you're here, my friends--Steadwick abounds in thieves.  As a matter of fact, we are the world capital of thieves!  It's common knowledge that Bill Lasker, the Master Thief, lives in the sewers beneath Steadwick."
end

-- "Watchtowers"
evt.CanShowTopic[1170] = function()
	if not evt.Cmp("QBits", 708) then         -- Find second entrance to Watchtower6
		return evt.Cmp("QBits", 531)         -- "Go to Watchtower 6 in the Deyja Moors, and move the weight from the top of the tower to the bottom of the tower.  Then return to William Lasker in the Erathian Sewers."
	end
	return true
end

Game.GlobalEvtLines:RemoveEvent(1170)
evt.global[1170] = function()
	if evt.Cmp("QBits", 708) then         -- Find second entrance to Watchtower6
		evt.SetMessage(1548)         -- "Glad you found the way in the back door.  You probably avoided a really nasty ambush that way.  I hope my advice was useful!"
	else
		evt.SetMessage(1507)         -- "Back when I was in the army, I was assigned to scout out the watchtowers in Deyja.  <chuckling> It's no good trying to go through the front door, so I usually looked around for another way in.  Those Necromancers are so cowardly, they always have an escape route.  And a way out is also a way in..."
	end
end

-- "Quest"
Game.GlobalEvtLines:RemoveEvent(1171)
evt.global[1171] = function()
	evt.SetMessage(1508)         -- "The sacred relic of the Order of Fire, the Scroll of Mage Wonka, has been lost for many years.  The caravan that was transporting this relic from Harmondale to Bracada never made it out of the Barrow Downs.  Find the Lost Scroll of Wonka and return it to me and I will grant all Elemental Magic users in your party Expert Fire Magic with a Skill of ‘8’."
	evt.Add("QBits", 784)         -- "Find the Lost Scroll of Wonka and return it to Blayze on Emerald Island."
	evt.SetNPCTopic{NPC = 478, Index = 1, Event = 2000}         -- "Blayze " : "We've found the Lost Scroll!"
end

-- "Now that's what I call 'fun'!"
Game.GlobalEvtLines:RemoveEvent(1172)
evt.global[1172] = function()
	evt.SetMessage(1187)         --[[ "Hope ya don’t mind that I left ya and went ahead to scout out the area.  Thanks for the help in dispatching them Water Elementals.

I guess we’re gonna hafta run this here ‘gauntlet’, huh?  We’ll I’m a little ‘long in the tooth’ to be runnin’, although thar’s nothin’ wrong with my sword arm.  So if ya don’t mind, I’ll stay here and keep this area safe for our exit.  When ya find the key, don’t wait for me.  I’ll join ya as you exit to the Coding Fortress.

Oh, by the way.  There’s a scroll in that chest over thar that lists some rules for this place.  I suggest ya read it so’s we don’t get into any more trouble than we need to in here.

See ya on the way back my friends." ]]
	evt.SetNPCTopic{NPC = 357, Index = 1, Event = 0}         -- "Lord Godwinson"
end

-- "Buy Speed Boost Potent"
Game.GlobalEvtLines:RemoveEvent(1173)
evt.global[1173] = function()
	local i
	evt.ForPlayer("All")
	i = Game.Rand() % 6
	if i >= 2 and i <= 5 then
		evt.SetMessage(1197)         -- "I just sold my only one.  Come back in an hour."
	elseif evt.Cmp("Gold", 10000) then
		evt.SetMessage(1201)         -- "Here's your Potent of Speed Boost.  It's good doing business with you!"
		evt.ForPlayer("Current")
		evt.Subtract("Gold", 10000)
		evt.Add("Inventory", 244)         -- "Speed Boost"
	else
		evt.SetMessage(1200)         -- "You don't have enough gold!"
	end
end

-- ERROR: Invalid command size: 43016:1 (Cmd00)
-- ERROR: Not found

-- "A word of Caution!"
Game.GlobalEvtLines:RemoveEvent(1174)
evt.global[1174] = function()
	evt.SetMessage(1631)         --[[ "Oh! and stay clear of Pascal and his minions of conjured Trolls!  Pascal is really quite ‘mad’ and his minions are somewhat stupid.  If you get too close to them in the heat of Battle, they may attack you!  If this occurs, all of your allies will become your enemies and you will fail the Test of Friendship!

And remember your objective!  Get the cube and gather your friends back into your party.  Once this is done you can dispatch the remaining foes if you like.

When it’s time to leave, you **must** use the exit to Celeste located immediately behind you in company with all six friends!  Don’t leave this cave by any other means or you will fail The Test and The Game!

Good luck, adventurers!" ]]
	evt.SetMonGroupBit{NPCGroup = 57, Bit = const.MonsterBits.Hostile, On = false}         -- "Group for M1"
	evt.SetMonGroupBit{NPCGroup = 58, Bit = const.MonsterBits.Hostile, On = false}         -- "Group fo M2"
	evt.SetMonGroupBit{NPCGroup = 59, Bit = const.MonsterBits.Hostile, On = false}         -- "Group for M3"
	evt.SetMonGroupBit{NPCGroup = 60, Bit = const.MonsterBits.Hostile, On = false}         -- "Group for Malwick's Assc."
	evt.SetMonGroupBit{NPCGroup = 61, Bit = const.MonsterBits.Hostile, On = false}         -- "Southern Village Group in Harmondy"
	evt.SetMonGroupBit{NPCGroup = 62, Bit = const.MonsterBits.Hostile, On = false}         -- "Main village in Harmondy"
end

-- "EMPTY"
-- "EMPTY"
-- "EMPTY"
-- ERROR: Invalid command size: 44040:1 (Cmd00)
-- ERROR: Not found

-- "Monk Training"
Game.GlobalEvtLines:RemoveEvent(1178)
evt.global[1178] = function()
	evt.SetMessage(1515)         -- "If you're looking for a teacher to begin serious monk training, speak with Bartholomew Hume--you can find him in the Bracada."
end

-- "Medusas"
Game.GlobalEvtLines:RemoveEvent(1179)
evt.global[1179] = function()
	evt.SetMessage(1521)         -- "There is a breed of Medusa infesting the Red Dwarf Mines that is immune to magic.  These monsters are a real terror!  I can only thank the Gods that these creatures haven't escaped the mine.  What would we do then, beat them to death with our staves?"
end

-- "Temple of Baa"
evt.CanShowTopic[1180] = function()
	if not evt.Cmp("QBits", 1574) then         -- "Promoted to Master"
		if not evt.Cmp("QBits", 1575) then         -- "Promoted to Honorary Master"
			return evt.Cmp("QBits", 540)         -- "Go to the Temple of Baa in Avlee and kill the High Priest of Baa, then return to Bartholomew Hume in Harmondale."
		end
	end
	return true
end

Game.GlobalEvtLines:RemoveEvent(1180)
evt.global[1180] = function()
	if not evt.Cmp("Inventory", 1332) then         -- "Cloak of the Sheep"
		if not evt.Cmp("QBits", 1574) then         -- "Promoted to Master"
			if not evt.Cmp("QBits", 1575) then         -- "Promoted to Honorary Master"
				evt.SetMessage(1517)         -- "A few years back, a weird cult called the Temple of Baa moved into the area.  At first they seemed popular, what with their free offers of healing, but it soon became clear they were devoted to darkness.  No one goes up there very much, now, and it seems that whatever evil gods were backing them have withdrawn their support.  But they're up there still, lurking in the shadows.  Creepy."
				return
			end
		end
	end
	evt.SetMessage(1551)         -- "The Baa cult is gone?  Well that IS good news!  Everyone is in your debt, whether they know it or not.  "
end

-- "Missing Sheep"
evt.CanShowTopic[1181] = function()
	if not evt.Cmp("QBits", 1574) then         -- "Promoted to Master"
		if not evt.Cmp("QBits", 1575) then         -- "Promoted to Honorary Master"
			return evt.Cmp("QBits", 540)         -- "Go to the Temple of Baa in Avlee and kill the High Priest of Baa, then return to Bartholomew Hume in Harmondale."
		end
	end
	return true
end

Game.GlobalEvtLines:RemoveEvent(1181)
evt.global[1181] = function()
	if not evt.Cmp("Inventory", 1332) then         -- "Cloak of the Sheep"
		if not evt.Cmp("QBits", 1574) then         -- "Promoted to Master"
			if not evt.Cmp("QBits", 1575) then         -- "Promoted to Honorary Master"
				evt.SetMessage(1518)         -- "Lots of sheep have gone missing since the Baa cult moved in--and I mean lots.  No doubt they were taken to the Baa temple for sacrifice.  I'm going to go broke if someone doesn't do something about those cultists!"
				return
			end
		end
	end
	evt.SetMessage(1552)         -- "Glad to hear the Baa cult has gone missing, instead of my sheep!  Good job!"
end

-- "Ciphers"
Game.GlobalEvtLines:RemoveEvent(1182)
evt.global[1182] = function()
	evt.SetMessage(1519)         -- "Ssspies abound in places like this, my friendsss.  If you wish your letters and communiqués to remain sssecret, you should use a cipher when you write.  There is a book in the Castle library that will explain everything, my friendsss."
end

-- "The nature of ooze"
Game.GlobalEvtLines:RemoveEvent(1183)
evt.global[1183] = function()
	evt.SetMessage(1520)         --[[ "Eight years ago, we sent a team of scholars to what is now the Red Dwarf Mine to study the strange creatures that would occasionally show up there.  

The first thing we noticed was that Ooze ectoplasm makes an excellent potion catalyst.  The second was that ooze just can't be physically damaged--they split apart or squish, then run back together. If you want to kill one, you'll have to do it with magic." ]]
end

-- "Medusas"
Game.GlobalEvtLines:RemoveEvent(1184)
evt.global[1184] = function()
	evt.SetMessage(1521)         -- "There is a breed of Medusa infesting the Red Dwarf Mines that is immune to magic.  These monsters are a real terror!  I can only thank the Gods that these creatures haven't escaped the mine.  What would we do then, beat them to death with our staves?"
end

-- "Titans' Stronghold"
Game.GlobalEvtLines:RemoveEvent(1185)
evt.global[1185] = function()
	evt.SetMessage(1522)         -- "If you head south past the Wyvern Plains, don't go knocking at the door of that huge fortress you'll see standing in the middle of the water.  It's the Titan's Stronghold, and they don't much like visitors."
end

-- "The Arena"
Game.GlobalEvtLines:RemoveEvent(1186)
evt.global[1186] = function()
	evt.SetMessage(1523)         -- "Arena fighting is available to anyone who wants to practice against any kind of opponent.  You can get to the arena by visiting a stable on any Sunday and asking them to take you there.  "
end

-- "Arena Championships"
Game.GlobalEvtLines:RemoveEvent(1187)
evt.global[1187] = function()
	evt.SetMessage(1524)         -- "Arena Champships are held on each Sunday.  They are open to all--but be careful!  Your opponents are chosen by the Arena management, not you!"
end

-- "Haunted Mansion"
Game.GlobalEvtLines:RemoveEvent(1188)
evt.global[1188] = function()
	evt.SetMessage(1525)         -- "Every graveyard or ancestral burial place seems to have a haunted house nearby--and ours is no exception.  There is a mansion near one of the plateaus on the surface in the northwest.  It is most certainly haunted."
end

-- "Ghosts"
Game.GlobalEvtLines:RemoveEvent(1189)
evt.global[1189] = function()
	evt.SetMessage(1526)         -- "Fear the touch of the Ghost as you fear the loss of your life.  It inflicts terrible spiritual wounds and drains your youth before your eyes!"
end

-- "Secret passage"
Game.GlobalEvtLines:RemoveEvent(1190)
evt.global[1190] = function()
	evt.SetMessage(1527)         -- "A few wars ago, my great grandfather worked on an escape tunnel from the Elvish castle to the Tularean Caves.  I don't think it's ever been used--no attack on the castle has ever brought it down--but it sure is an interesting piece of history, don't you think?"
end

-- "Faeries"
Game.GlobalEvtLines:RemoveEvent(1191)
evt.global[1191] = function()
	if evt.Cmp("QBits", 709) then         -- Entered Faerie Mound
		evt.SetMessage(1553)         -- "I'm impressed--very few actually make it inside the fairy mound, or get very far."
	else
		evt.SetMessage(1528)         -- "They say that elves are faeries, but in truth we are only distantly related.  The true faeries don't live in civilization, and they're just like the stories say--playful, cruel, magical, and dangerous.  But if you really want to meet them, you could visit them in their Hall under the Hill, as they call it.  It is just outside of the village, to the North and West.  It will be challenging to get to the front door... "
	end
end

-- "Mad Forest"
Game.GlobalEvtLines:RemoveEvent(1192)
evt.global[1192] = function()
	if not evt.Cmp("Inventory", 1402) then         -- "Heart of the Wood"
		if not evt.Cmp("QBits", 1580) then         -- "Promoted to Ranger Lord"
			if not evt.Cmp("QBits", 1581) then         -- "Promoted to Honorary Ranger Lord"
				if not evt.Cmp("Awards", 23) then         -- "Retrieved the Heart of the Wood"
					evt.SetMessage(1529)         -- "A while ago, I saw some men come to the Tularean Forest at night with axes and torches, following some sort of map.  When they left, they were laughing and happy.  It looked like they were carrying a big green rock.  My brother says they were a band of mercenaries from Tatalia.  Anyway, the next day was when the forest went mad.  It's too dangerous to go there now."
					return
				end
			end
		end
	end
	evt.SetMessage(1554)         -- "The forest is much safer now, thanks you to!  The oldest tree is very happy with you, and has included you in its history recitals."
end

-- "Oldest Tree"
Game.GlobalEvtLines:RemoveEvent(1193)
evt.global[1193] = function()
	evt.SetMessage(1530)         -- "The Tularean Forest is so old that it has developed a mind…sort of.  The forest is vaguely aware of who walks through it, but only one part of the forest can communicate with people.  That's the oldest tree.  If you want to have a very long and slow conversation, it will be happy to oblige.  Look for it on an island to the south east of the forest.  It's larger than the rest of the trees.  You can't miss it."
end

-- "Bounty Hunting"
Game.GlobalEvtLines:RemoveEvent(1194)
evt.global[1194] = function()
	evt.SetMessage(1531)         -- "Anyone needing to earn some spare cash can visit a town hall in any major city to pick up a bounty hunting assignment.  City councils are always fearful of the latest man eating monster or bandit or mad wizard, and set bounties on the creature that is bothering them most this month.  There's no rhyme or reason to their choices, so don't try to figure it out.  They often pay quite well."
end

-- "Warrior Mage Promotion"
Game.GlobalEvtLines:RemoveEvent(1195)
evt.global[1195] = function()
	evt.ForPlayer("Current")
	if evt.Cmp("Experience", 15000) then
		evt.ForPlayer("All")
		evt.SetMessage(1640)         -- "I knew there was something 'special' about you, adventurers!   And I see you have the experience necessary to tackle the Warrior Mage promotion task.  So let's begin, shall we?"
		evt.SetNPCTopic{NPC = 360, Index = 1, Event = 817}         -- "Zedd True Shot" : "Warrior Mage"
	else
		evt.SetMessage(1247)         --[[ "I understand your enthusiasm adventurers.  But you are far too inexperienced for the required promotion task.  Travel about on the mainland, gain some real-world experience, and return to the ‘EI’.  Then we’ll discuss the promotion.

So I’ll await your return?  Good.  See you soon." ]]
	end
end

-- "Tidewater Caverns"
Game.GlobalEvtLines:RemoveEvent(1196)
evt.global[1196] = function()
	evt.SetMessage(1533)         -- "Pirates been operating out of the tidewater caverns for twenty years.  They're not Regnans, and they aren't part of Bill Lasker's men, but they're still pretty mean.  You want to get in there, just get yourself out to the islands to the west."
end

-- "Evenmorn Islands"
Game.GlobalEvtLines:RemoveEvent(1197)
evt.global[1197] = function()
	if not evt.Cmp("Inventory", 1485) then         -- "Map to Evenmorn Island"
		if not evt.Cmp("QBits", 1607) then         -- "Promoted to Priest"
			if not evt.Cmp("QBits", 1608) then         -- "Promoted to Honorary Priest"
				evt.SetMessage(1534)         -- "Evenmorn Island isn't lost, so much as hard to get to.  It is surrounded by treacherous reefs, sandbars, whirlpools, and sharks.  If it's dangerous, the Island is surrounded by it.  There are only one or two safe ways in, and the map for those ways was stolen by pirates during the chaos of the recent wars.  They probably still have the map in their caves.  "
				return
			end
		end
	end
	evt.SetMessage(1555)         -- "Oh, so the map is found?  What will you do with your newfound treasure?  Share it, I hope!"
end

-- "Reef Maps"
Game.GlobalEvtLines:RemoveEvent(1198)
evt.global[1198] = function()
	if not evt.Cmp("Inventory", 1485) then         -- "Map to Evenmorn Island"
		if not evt.Cmp("QBits", 1607) then         -- "Promoted to Priest"
			if not evt.Cmp("QBits", 1608) then         -- "Promoted to Honorary Priest"
				evt.SetMessage(1535)         -- "The boat captains would be happy to take any paying fare to Evenmorn island, but they don't have proper maps.  There's no way anyone is going to risk their ship in the reefs around the Island unless they have the map!"
				return
			end
		end
	end
	evt.SetMessage(1556)         -- "Now that you have the map, I guess you'll be going there soon.  Be careful--they say the island is cursed!"
end

-- "The Curse"
Game.GlobalEvtLines:RemoveEvent(1199)
evt.global[1199] = function()
	evt.SetMessage(1557)         -- "If you don't mind the swamp and fog, Evenmorn Island is a great place to live.  Of course, the Curse doesn't help--ghosts and skeletons roam the island freely--but other than that, the neighbors keep to themselves.  The Churches of the Sun and the Moon don't even fight each other very much anymore.  <Heh!> probably means they're running out of adherents..."
end

-- "Golem parts"
Game.GlobalEvtLines:RemoveEvent(1200)
evt.global[1200] = function()
	evt.SetMessage(1536)         -- "Well, I don't have any golem parts--I never took that class--but there are students all over Bracada who have spare golem parts lying around.  They aren't worth anything unless you have them all, so they'll probably just give them to you for free."
end

-- "Golems"
Game.GlobalEvtLines:RemoveEvent(1201)
evt.global[1201] = function()
	evt.SetMessage(1537)         -- "You see all those golems walking around Bracada?  Every single one of them was made by the School.  Not bad for students, eh?  They don't have much to say, but they're tough guardians and can tell when a follower of Darkness is near.  You should see them go into action when one of those Necromancers or Warlocks wanders into our lands.  Zowwwwwieeee!"
end

-- "We need your help!"
Game.GlobalEvtLines:RemoveEvent(1202)
evt.global[1202] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 244) then         -- "Speed Boost"
		evt.SetMessage(1194)         --[[ "The Speed Boost potent!  Good!  Give me a minute to complete the elixir.

[]
[]
[]

There you go!  Here’s the Plague Elixir.

Now hurry back to Stone City!" ]]
		evt.Subtract("Inventory", 244)         -- "Speed Boost"
		evt.SetNPCTopic{NPC = 547, Index = 1, Event = 0}         -- "Lucid Apple"
		evt.ForPlayer("Current")
		evt.Add("Inventory", 1075)         -- "Plague Elixir"
		evt.SetNPCTopic{NPC = 398, Index = 0, Event = 1203}         -- "Hothfarr IX" : "We have the Plague Elixir!"
	else
		evt.SetMessage(1193)         --[[ "What’s the problem, adventurers? [You tell Lucid the conditions in Stone City].  Plague!  This is not good, not good at all!  And of course I’ll help.  Give me a minute to see what I have on hand.[Lucid begins to rummage through her inventory, searching through bottles, boxes, barrels, shelves and drawers, all-the-while humming a tune from CCR.]

I can mix-up a Plague Elixir that can be added to the water supply.  It will cure the population of Stone City within one day.  However, I am missing one ‘ingredient’ – a Speed Boost potent.  Bring me this potent with all haste.

[You ask Lucid where you can obtain this potent.]

If you have the skill and ingredients, you can mix one up yourself from a Haste Potent combined with an Orange Potent.  Otherwise, check out the local shops.  As a last resort, find a Wandering Peddler.  Sometimes they carry various potents. This time of year they seem to ‘congregate’ in Steadwick.

Good luck!" ]]
	end
end

-- "We have the Plague Elixir!"
Game.GlobalEvtLines:RemoveEvent(1203)
evt.global[1203] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 1075) then         -- "Plague Elixir"
		evt.SetMessage(1199)         --[[ "The Plague Elixir!

[You relate the information from Lucid about how to use this elixir.  The King turns to his personal advisor.]

Have the guards pour this elixir into the underground stream immediately!  Don’t waste a single drop!

[The King turns back to you]

Bless the fates, you have saved my people and my kingdom!  Your bravery, courage and resourcefulness have earned you the title ‘Friend of Hothfarr, King of Dwarves, and Savior of Stone City’!

For this service to The Crown, I present you with a set of four rings of rather plain stature, but of powerful enchantment. You may claim these rings in the two chests outside of my Throne Room.

Oh. Be careful.  The chests are ‘trapped’." ]]
		evt.Add("Experience", 100000)
		evt.Add("Gold", 5000)
		evt.Set("Awards", 125)         -- "Proclaimed Friend of Hothfarr, King of Dwarves and Savior of Stone City"
		evt.Subtract("QBits", 882)         -- "Obtain Plague Elixir from Lucid Apple in Avlee and deliver it to King Hothffar in Stone City within two days."
		evt.Set("QBits", 880)         -- Barrow Normal
		evt.Subtract("Inventory", 1075)         -- "Plague Elixir"
		evt.SetNPCTopic{NPC = 398, Index = 0, Event = 0}         -- "Hothfarr IX"
		evt.SetNPCGreeting{NPC = 398, Greeting = 145}         -- "Hothfarr IX" : "Welcome back Friends of Hothfarr and Saviors of Stone City!  The city is at your disposal."
	end
end

-- "Soul Jars"
Game.GlobalEvtLines:RemoveEvent(1204)
evt.global[1204] = function()
	evt.SetMessage(1540)         -- "The only people in the world who make soul jars are the Warlocks of Nighon.  It is a secret of their profession--which is strange, since they have absolutely no use for them.  Still, we are forced to bargain for the jars in order to advance our craft.  Of course, we have wrested the jars from them, from time to time...but then they raise their prices in revenge.  It must be our fate to suffer so."
end

-- "The Rituals"
Game.GlobalEvtLines:RemoveEvent(1205)
evt.global[1205] = function()
	evt.SetMessage(1541)         -- "Every Necromancer aspires to be a Lich one day.  All you need is a Soul Jar, knowledge of the Ritual, and the magical skill to survive the journey to the Land of the Dead and return.  The body withers while the soul lives on in a glorious state free from hunger, disease, and injury.  Only shallow and superficial people would mind what the Ritual does to one's appearance.  True practitioners hardly notice."
end

-- "Circle of stone"
Game.GlobalEvtLines:RemoveEvent(1206)
evt.global[1206] = function()
	if not evt.Cmp("QBits", 1613) then         -- "Promoted to Great Druid"
		if not evt.Cmp("QBits", 1614) then         -- "Promoted to Honorary Great Druid"
			evt.SetMessage(1542)         -- "Three circles of stones were built by the Druids long ago.  Since hearing of their locations ruins ascension attempts for would be Great Druids, I can only give you a general clue--All are in the open, unhidden and bare, and all are distant from settlements.  To tell you more would spoil your Ascension."
			return
		end
	end
	evt.SetMessage(1560)         -- "Since you've discovered the circles on your own they have worked their magic on you.  I hope you will refrain from telling others of their whereabouts, as I have done for you."
end

-- "Summer Circle"
Game.GlobalEvtLines:RemoveEvent(1207)
evt.global[1207] = function()
	evt.SetMessage(1543)         -- "Originally, there were four Circles of Stone, one for each Cardinal direction and season, but the Eastern Circle was destroyed somewhere in Nighon during the wars between the Churches of the Sun and the Moon."
end

-- "The graveyard"
Game.GlobalEvtLines:RemoveEvent(1208)
evt.global[1208] = function()
	evt.SetMessage(1544)         -- "The graveyard does indeed hold the bones of the ancient King, but the hallowed land will curse any who disturb it.  I don't envy you this task.  Each grave you open will unleash its curse, and possibly some other trap.  Best be sure you're opening the correct grave when you begin to dig."
end

-- "Barrow Navigation"
Game.GlobalEvtLines:RemoveEvent(1209)
evt.global[1209] = function()
	evt.SetMessage(1545)         -- "Though the barrows were built to deter thieves, a way was needed to navigate them during burials and ceremonies.  Near each of the gates you'll find a plaque.  These plaques are cryptic, but they will keep you from losing your way, as long as you use them.  No thief yet has realized their significance, so once they enter the barrows, they never leave."
end

-- "Land of the Titans"
Game.GlobalEvtLines:RemoveEvent(1210)
evt.global[1210] = function()
	evt.SetMessage(1546)         -- "We built a tunnel leading from our Thunderfist Mountain to the Land of the Giants during the War.  It was there we discovered the Kreegan, and more titans and dragons then you can imagine.  I suppose one who's familiar is to be a dragon could find eggs in one of the dragon caves of that terrible land.  'Ware the mother..."
end

-- "The Mega Dragon"
Game.GlobalEvtLines:RemoveEvent(1211)
evt.global[1211] = function()
	evt.SetMessage(1547)         -- "I've heard legends that there is a dragon in the Land of the Titans greater than any that have come before.  Lesser dragons and titans do battle on the slopes of the mountain in which its cave resides.  This dragon is so huge, and so mighty that the other dragons feed it for fear it will one day leave its cave and devour them all in its fury.  The dragons believe it is a god.  If that is so, imagine its treasure..."
end

-- "Quest"
Game.GlobalEvtLines:RemoveEvent(1212)
evt.global[1212] = function()
	evt.SetMessage(1561)         -- "During the wars between the Temples of the Sun and Moon, three statuettes were stolen from the shrines in the Bracada Desert, Tatalia, and Avlee.  I represent a group of Druids that want these shrines back to their original form-- it is critical for their worship.  To this end, I am offering a substantial reward for anyone that will find the statuettes and place them on the shrines."
	evt.Set("QBits", 712)         -- "Retrieve the three statuettes and place them on the shrines in the Bracada Desert, Tatalia, and Avlee, then return to Thom Lumbra in the Tularean Forest."
	evt.SetNPCTopic{NPC = 627, Index = 0, Event = 1213}         -- "Thom Lumbra" : "Quest"
end

-- "Quest"
Game.GlobalEvtLines:RemoveEvent(1213)
evt.global[1213] = function()
	if evt.Cmp("QBits", 713) then         -- Placed item 617 in out14(statue)
		if evt.Cmp("QBits", 714) then         -- Place item 618 in out13(statue)
			if evt.Cmp("QBits", 715) then         -- Place item 619 in out06(statue)
				evt.SetMessage(1563)         -- "Great work!  The Druids are so pleased, they threw in a little extra for your fine performance.  Take this… you most certainly deserve it."
				evt.Add("Gold", 50000)
				evt.Subtract("Reputation", 10)
				evt.ForPlayer("All")
				evt.Subtract("QBits", 712)         -- "Retrieve the three statuettes and place them on the shrines in the Bracada Desert, Tatalia, and Avlee, then return to Thom Lumbra in the Tularean Forest."
				evt.Add("Experience", 50000)
				evt.Add("Awards", 53)         -- "Found and placed all the statuettes"
				evt.SetNPCGreeting{NPC = 627, Greeting = 289}         -- "Thom Lumbra" : "Excellent work; my associates are quite pleased."
				evt.SetNPCTopic{NPC = 627, Index = 0, Event = 0}         -- "Thom Lumbra"
				return
			end
		end
	end
	evt.SetMessage(1562)         -- "All three statuettes are not placed.  I cannot reward partial success.  Return when you have placed all three."
end

-- "Quest"
Game.GlobalEvtLines:RemoveEvent(1214)
evt.global[1214] = function()
	evt.SetMessage(1564)         -- "As you may have already guessed, I'm a collector of fine art.  Currently, I am looking for a set of paintings, one of King Roland, one of his brother Archibald, and one of the angel statue in the courtyard of Castle Ironfist.  This set is of great value, and, as a collector, I'm willing to pay quite handsomely for it.  If you should gather the entire set of paintings bring them back to me and I'll be sure to compensate you well for your effort."
	evt.Set("QBits", 716)         -- "Retrieve the three paintings and return them to Ferdinand Visconti in Tatalia."
	evt.SetNPCTopic{NPC = 628, Index = 0, Event = 1215}         -- "Ferdinand Visconti" : "Quest"
end

-- "Quest"
Game.GlobalEvtLines:RemoveEvent(1215)
evt.global[1215] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 1423) then         -- "Angel Statue Painting"
		if evt.Cmp("Inventory", 1424) then         -- "Archibald Ironfist Painting"
			if evt.Cmp("Inventory", 1425) then         -- "Roland Ironfist Painting"
				evt.SetMessage(1567)         -- "Wonderful!  This set has eluded me for years!  You more than deserve the reward I promised; here, hopefully this will be sufficient."
				evt.Subtract("Inventory", 1423)         -- "Angel Statue Painting"
				evt.Subtract("Inventory", 1424)         -- "Archibald Ironfist Painting"
				evt.Subtract("Inventory", 1425)         -- "Roland Ironfist Painting"
				evt.ForPlayer("Current")
				evt.Add("Gold", 50000)
				evt.Subtract("Reputation", 10)
				evt.ForPlayer("All")
				evt.Subtract("QBits", 716)         -- "Retrieve the three paintings and return them to Ferdinand Visconti in Tatalia."
				evt.Add("Experience", 50000)
				evt.Add("Awards", 55)         -- "Retrieved the complete set of paintings"
				evt.SetNPCGreeting{NPC = 628, Greeting = 291}         -- "Ferdinand Visconti" : "Thank you for your assistance in completing my collection.  You have my gratitude forever!"
				evt.SetNPCTopic{NPC = 628, Index = 0, Event = 0}         -- "Ferdinand Visconti"
				return
			end
		end
	end
	evt.SetMessage(1566)         -- "Remember, I need the complete set of paintings-- they aren't worth much by themselves.  When you have the rest, bring them all to me."
end

-- "Arcomage Tounament"
Game.GlobalEvtLines:RemoveEvent(1216)
evt.global[1216] = function()
	evt.SetMessage(1568)         -- "To be declared ArcoMage Champion, you must win a game of ArcoMage in every tavern on, in, and under the continent of Erathia.  There are 13 such taverns sponsoring ArcoMage events.  When you have accomplished this in Elrond's name, return to me and I shall bestow upon you great rewards."
	evt.Set("QBits", 717)         -- "Honor Elrond's memory by winning the Arcomage Championship, then return to Darron Temper in Pierpont."
	evt.SetNPCTopic{NPC = 624, Index = 0, Event = 1217}         -- "Darron Temper" : "Quest"
end

-- "Quest"
Game.GlobalEvtLines:RemoveEvent(1217)
evt.global[1217] = function()
	if evt.Cmp("QBits", 750) then         -- Won all Arcomage games
		evt.SetMessage(1570)         -- "Congratulations!  You have brought honor to Elrond's name by becoming the ArcoMage Champion!  Your reward is waiting in a chest outside of our summer home in Erathia."
		evt.Subtract("QBits", 717)         -- "Honor Elrond's memory by winning the Arcomage Championship, then return to Darron Temper in Pierpont."
		evt.Add("Gold", 100000)
		evt.Subtract("Reputation", 10)
		evt.ForPlayer("All")
		evt.Add("Experience", 50000)
		evt.Add("QBits", 756)         -- Finished ArcoMage Quest - Get the treasure
		evt.Add("Awards", 41)         -- "ArcoMage Champion"
		evt.SetNPCGreeting{NPC = 624, Greeting = 293}         -- "Darron Temper" : "Welcome ArcoMage Champions!"
		evt.SetNPCTopic{NPC = 624, Index = 0, Event = 0}         -- "Darron Temper"
	else
		evt.SetMessage(1569)         -- "You must claim a victory at ALL 13 taverns.  Until you do, you cannot be declared ArcoMage Champion."
	end
end

-- "Stone City"
Game.GlobalEvtLines:RemoveEvent(1218)
evt.global[1218] = function()
	evt.SetMessage(1573)         -- "People say the Dwarves live in the barren lands south of Harmondale, but that's not exactly true--They live UNDER them.  Look for their front gate in the center of the Barrow Downs where three bridges meet."
end

-- "Stone City"
Game.GlobalEvtLines:RemoveEvent(1219)
evt.global[1219] = function()
	evt.SetMessage(1574)         -- "Ever since the Warlocks of Nighon tunneled through Stone City from their island, travelers have been asking to pass through the city to get to Nighon.  The Dwarf King hates this, and would like to charge a hefty fee for people seeking to enter Stone City.  He has not started charging however, fearing political and possible violent repercussions with the Warlocks of Nighon."
end

-- "Passage to Nighon"
Game.GlobalEvtLines:RemoveEvent(1220)
evt.global[1220] = function()
	evt.SetMessage(1575)         -- "The Warlocks of Nighon live in Thunderfist Mountain--an extinct volcano on a large island a few miles from the mainland.  During the recent wars, the Warlocks tunneled through Stone City to transport their forces across the channel.  Those tunnels are still open and can be traversed."
end

-- "Warlock's Tunnels"
Game.GlobalEvtLines:RemoveEvent(1221)
evt.global[1221] = function()
	evt.SetMessage(1576)         -- "During the War, the Warlocks tunneled from Nighon through Stone City to get to the mainland and seize territory.  Even though they were pushed back to their island by Erathia, the tunnels remain."
end

-- "Barrows"
Game.GlobalEvtLines:RemoveEvent(1222)
evt.global[1222] = function()
	evt.SetMessage(1577)         -- "Dwarves live under the ground of the Barrow Downs--a barren collection of ancient gravesites built by their race centuries ago to honor fallen kings and heroes.  Not all of the barrows can be reached on the surface--many are magically connected to each other through a system of teleporters and traps that protect the graves from those who would rob them.  If you look closely at the walls you should see markings that might help you navigate."
end

-- "Medusas"
Game.GlobalEvtLines:RemoveEvent(1223)
evt.global[1223] = function()
	if evt.Cmp("QBits", 610) then         -- Built Castle to Level 2 (rescued dwarf guy)
		evt.SetMessage(1607)         -- "The Lords of Harmondale!  Heroes, I say!  My cousin was one of the ones you rescued!  We are in your debt!"
	else
		evt.SetMessage(1578)         -- "We were making a fortune in the Red Dwarf Mines until the Medusas came!  We had to run before they turned everyone to stone.  Without our mining, we have almost no way to make a living.  Not the way for a proper Dwarf to live, I say!"
	end
end

-- "Red Dwarf Mines"
Game.GlobalEvtLines:RemoveEvent(1224)
evt.global[1224] = function()
	if evt.Cmp("QBits", 610) then         -- Built Castle to Level 2 (rescued dwarf guy)
		evt.SetMessage(1608)         -- "Thank you for delivering our people from the medusas!  The Dwarves of Stone City will not forget you!"
	else
		evt.SetMessage(1579)         -- "Bracada leased the land where we started the Red Dwarf Mine to us a few years ago.  That was until the Medusas came and took the mines from our people.  Only the Gods know what horrors go on in there now.  The mines were in the Northeast corner of Bracada."
	end
end

-- "The Statues"
Game.GlobalEvtLines:RemoveEvent(1225)
evt.global[1225] = function()
	if evt.Cmp("QBits", 610) then         -- Built Castle to Level 2 (rescued dwarf guy)
		evt.SetMessage(1609)         -- "We owe you much for your daring rescue of our people.  Rebuilding your castle was the least we could do for you."
	else
		evt.SetMessage(1580)         -- "When the Medusas took the Red Dwarf Mines from us, not everyone escaped.  There are still several statues in the mines.  They can be rescued if their statues haven't been broken yet, but you would have to fight through the Medusas to do it."
	end
end

-- "Stone City"
Game.GlobalEvtLines:RemoveEvent(1226)
evt.global[1226] = function()
	evt.SetMessage(1581)         -- "Do you like our city?  It's not just a hole in the ground--it's a home in the ground!  Dwarves have been working this mountain for centuries!  There isn't much mining left here, though, and what there is happens to be in unstable and unsafe tunnels.  Be careful if you go to the lower levels."
end

-- "Harmondale"
Game.GlobalEvtLines:RemoveEvent(1227)
evt.global[1227] = function()
	if not evt.Cmp("QBits", 611) then         -- Chose the path of Light
		if not evt.Cmp("QBits", 612) then         -- Chose the path of Dark
			evt.SetMessage(1582)         -- "Respectfully, my lords, I must say that no one expects you to last long because no other lords of Harmondale have lasted long.  The fighting and politics between Erathia and Avlee will claim you sooner or later.  Probably sooner."
			return
		end
	end
	evt.SetMessage(1610)         -- "Good day, my lords.  I must say the people are changing their minds about your chances of survival.  Everyone is saying how wonderful it is to have stable rulers in the Castle!"
end

-- "Rebellions"
Game.GlobalEvtLines:RemoveEvent(1228)
evt.global[1228] = function()
	evt.SetMessage(1583)         -- "Rebellions here in Harmondale are rare, but we've had a couple of big ones!  Most of the time lords here don't last long enough to rebel against, but there've been some wicked ones!  Not that I think you're wicked, my lords."
end

-- "Castle Harmondale"
Game.GlobalEvtLines:RemoveEvent(1229)
evt.global[1229] = function()
	if evt.Cmp("QBits", 610) then         -- Built Castle to Level 2 (rescued dwarf guy)
		evt.SetMessage(1611)         -- "It's good to see the Castle rebuilt and those loathsome goblin bandits evicted.  Things are looking better around here since you took over!"
	else
		evt.SetMessage(1584)         -- "It's good to see someone in Harmondale again, my lords.  The castle's been standing empty since the War, except for the goblins.  But they don't count, I suppose."
	end
end

-- "Tularean Caves"
Game.GlobalEvtLines:RemoveEvent(1230)
evt.global[1230] = function()
	evt.SetMessage(1585)         -- "What with all the wars that Avlee gets itself into all the time, and all the high taxes, I've moved to Harmondale to stay.  Harmondale sees a lot of violence, but at least they don't conscript.  You know, there's been so many wars in Avlee that one of the kings had a tunnel dug from his castle to the caves in the North just in case the castle was taken AGAIN."
end

-- "White Cliff Caves"
Game.GlobalEvtLines:RemoveEvent(1231)
evt.global[1231] = function()
	evt.SetMessage(1586)         -- "A ways outside of Harmondale there's a cave system called the White Cliff Caves.  The entrance has been magically warded for as long as I can remember.  Recently, the Mad Mage Pascal, Diviner of Strange Flesh, has removed the ward and sent an entire army of Trolls into the cave.  Travelers report that they have heard sounds of a fierce battle being waged near the entrance.  I'd avoid that area, if I were you!"
end

-- "Fort Riverstride"
Game.GlobalEvtLines:RemoveEvent(1232)
evt.global[1232] = function()
	if evt.Cmp("QBits", 595) then         -- Gave false Loren to Catherine (betray)
		evt.SetMessage(1612)         -- "I've heard Fort Riverstride was taken with the aid of treachery!  What a shame that those wretches were able to wring concessions from the Queen in exchange for the return of what was already ours!"
	else
		evt.SetMessage(1587)         -- "Did you notice that covered bridge on the way from Harmondale to Steadwick?  It's called Fort Riverstride, and it protects us from surprise Elvish attacks coming through Harmondale.  There's so many traps and tricks inside there, they say it will never fall without the help of treachery.  "
	end
end

-- "The Arena"
Game.GlobalEvtLines:RemoveEvent(1233)
evt.global[1233] = function()
	evt.SetMessage(1588)         -- "There's a Fountain just outside of the School of Sorcery in Bracada that will immediately teleport you to the Arena.   It's a good way to get some experience under your belt; ....  if you survive the encounters!"
end

-- "The Arbiter"
evt.CanShowTopic[1234] = function()
	return evt.Cmp("QBits", 610)         -- Built Castle to Level 2 (rescued dwarf guy)
end

Game.GlobalEvtLines:RemoveEvent(1234)
evt.global[1234] = function()
	if evt.Cmp("QBits", 646) then         -- Arbiter Messenger only happens once
		evt.SetMessage(1616)         -- "The death of Judge Grey was a blow to all of us.  I hope his replacement does his legacy justice."
	else
		evt.SetMessage(1589)         -- "Because of all the tension in the air, Erathia and Avlee hired an arbiter to help them work out their differences.  He's staying in the ""House of Stars"" on the eastern edge of Harmondale territory.  Maybe he has some advice for you."
	end
end

-- "Lost and Found"
Game.GlobalEvtLines:RemoveEvent(1235)
evt.global[1235] = function()
	evt.SetMessage(1590)         -- "If you ever feel like you need advice on what next to do, or you've lost something important, go visit the Arbiter in the House of Stars near the Eastern edge of Harmondale territory.  He often knows where lost items went, or has advice on what you need to do.  I'm sure you'll find him helpful."
end

-- "The Choice"
evt.CanShowTopic[1236] = function()
	return evt.Cmp("QBits", 646)         -- Arbiter Messenger only happens once
end

Game.GlobalEvtLines:RemoveEvent(1236)
evt.global[1236] = function()
	if not evt.Cmp("QBits", 611) then         -- Chose the path of Light
		if not evt.Cmp("QBits", 612) then         -- Chose the path of Dark
			evt.SetMessage(1591)         -- "The death of Judge Grey, Arbiter of Harmondale, has put the War on hold.  It's like the whole world is holding its breath, waiting for you to make a choice.  Better be careful who you choose--this sounds like a big one, my Lords."
			return
		end
	end
	evt.SetMessage(1617)         -- "It looks like the consequences of your choice are just beginning, my lords.  I hope you chose wisely."
end

-- "Proving Grounds"
Game.GlobalEvtLines:RemoveEvent(1237)
evt.global[1237] = function()
	evt.SetMessage(1592)         -- "The proving grounds, called the Walls of Mist,  is the place where all the wizards in Celeste have to go before they learn the High Art.  I hear it is much more of a moral test than a physical one.  You aren't allowed to kill any of the monsters in the maze."
end

-- "Celeste"
Game.GlobalEvtLines:RemoveEvent(1238)
evt.global[1238] = function()
	evt.SetMessage(1593)         -- "The city of Celeste has been home to the Light for centuries.  It was established by King Magnus II  in 499 as the centerpiece to the Kingdom of Bracada, and as a beacon of hope to the rest of the world.  "
end

-- "The Pit"
Game.GlobalEvtLines:RemoveEvent(1239)
evt.global[1239] = function()
	evt.SetMessage(1594)         -- "What you see on the surface in Deyja is only a small part of the true Kingdom of Death.  There is an underground city they call the Pit.  It can be reached from the surface only by way of the Hall of the Pit in Northern Deyja.  "
end

-- "Celeste"
Game.GlobalEvtLines:RemoveEvent(1240)
evt.global[1240] = function()
	evt.SetMessage(1595)         -- "Celeste is the magical city built by the Wizards of Bracada centuries ago, and anchored half in the mountains, and half in mist high above Bracada.  You must use one of their teleporters to get there--you can find it near the center of Bracada."
end

-- "Mysterious Murders"
evt.CanShowTopic[1241] = function()
	return evt.Cmp("QBits", 610)         -- Built Castle to Level 2 (rescued dwarf guy)
end

Game.GlobalEvtLines:RemoveEvent(1241)
evt.global[1241] = function()
	if evt.Cmp("QBits", 619) then         -- Slayed the vampire
		evt.SetMessage(1618)         -- "So it was a vampire that was killing all those people!  I hear you're the ones to get rid of it, too!  Thanks!  Everyone feels much safer now."
	else
		evt.SetMessage(1596)         -- "There was another murder, recently, that's been all the talk around town.  Another body--young woman, so I hear--was found near the sewers.  Drained of blood, for the love of Light!  It's those thieves living' in the sewers I tell you!  Rats, they are.  Someone should go down there and put them out of business!"
	end
end

-- "The Kreegan"
Game.GlobalEvtLines:RemoveEvent(1242)
evt.global[1242] = function()
	evt.SetMessage(1597)         -- "During the War, the Warlocks had dealings with some strange creatures commonly known as devils in the mountains south of Avlee.  It's impossible to get there from the mainland, but the Warlocks dug a tunnel under the sea from their island that leads to the devil's home."
end

-- "Losing the War"
Game.GlobalEvtLines:RemoveEvent(1243)
evt.global[1243] = function()
	evt.SetMessage(1598)         -- "We…overplayed our hand during the War, and failed to win any territory on the mainland.  Our ""allies"", the Kreegan, turned out to be very untrustworthy.  People from Enroth call them devils--now we know why.  At just the moment when we needed them most, they turned and ran, leaving us to face the wrath of the armies of Erathia and Avlee.  Next time, we won't be so trusting."
end

-- "Falling out in Deyja"
evt.CanShowTopic[1244] = function()
	return evt.Cmp("QBits", 710)         -- Archibald in Clankers Lab now
end

Game.GlobalEvtLines:RemoveEvent(1244)
evt.global[1244] = function()
	evt.SetMessage(1599)         -- "There's been quite a bit of activity in Deyja, people are saying.  It seems that Archibald Ironfist, the leader of Deyja (and former King of Enroth) has left the Pit for an island off the Eastern shore of Avlee.  A lot of Necromancers followed him there--seems there's some sort of split going on."
end

-- "Roland of Enroth"
evt.CanShowTopic[1245] = function()
	if not evt.Cmp("QBits", 611) then         -- Chose the path of Light
		if not evt.Cmp("QBits", 612) then         -- Chose the path of Dark
			return false
		end
	end
end

Game.GlobalEvtLines:RemoveEvent(1245)
evt.global[1245] = function()
	if evt.Cmp("QBits", 752) then         -- Talked to Roland
		evt.SetMessage(1619)         -- "They say you are being credited with rescuing King Roland!  That's quite a feather in your cap, my lords!  QUITE a feather!"
	else
		evt.SetMessage(1600)         -- "Rumors have been trickling out of Nighon that King Roland of Enroth may still be alive.  Some Warlocks have said that they personally saw him when they met with the foul Kreegan.  The rumors also say that the Kreegan are keeping him in a cage and mistreating him horribly."
	end
end

-- "Soul Jars"
Game.GlobalEvtLines:RemoveEvent(1246)
evt.global[1246] = function()
	evt.SetMessage(1601)         -- "A Soul Jar is what a Necromancer needs to complete the Ritual and become a Lich--an immortal undead monster that retains its mind and memories from life.  It's pretty obvious that this is not a desirable condition for most people, which is why the market for these artifacts isn't very good.  Nonetheless, Necromancers will do almost anything to get more--their profession's very existence depends on them."
end

-- "Warlocks"
Game.GlobalEvtLines:RemoveEvent(1247)
evt.global[1247] = function()
	evt.SetMessage(1604)         -- "Although the Warlocks are technically servants of the Dark, they usually aren't violent.  They will defend themselves if attacked, of course, but they won't start a fight unless you start it first.  They're quite reasonable, as a matter of fact, and they take their business seriously.  I've found dealing with them to be quite pleasant."
end

-- "We Found a lost ONE!"
Game.GlobalEvtLines:RemoveEvent(1248)
evt.global[1248] = function()
	evt.SetMessage(1190)         --[[ "Hey good buddies. That’s Super!  Great!  Peachy Keen!  Boss!  Radical!

Now you need to report these lost ONES, and any other problems, comments, and/or thoughts to Big Daddy Jim as a BLOG response at the following site:

http://hosted.filefront.com/BigDaddyJim

Muchas Gracias!  Many Thanks! And all that stuff ...." ]]
end

-- "Expert Teachers"
Game.GlobalEvtLines:RemoveEvent(1249)
evt.global[1249] = function()
	evt.SetMessage(1620)         -- "Looking for Expert instruction in one of your Skills?  Expert teachers for most Skills can be found in Harmondale, Erathia and the Tularean Forest. "
end

-- "Missing People"
Game.GlobalEvtLines:RemoveEvent(1250)
evt.global[1250] = function()
	evt.SetMessage(1602)         -- "People have been disappearing recently.  Not just one or two, but several every day!  They go to bed at night, and the next day they aren't seen and their houses are empty!  I certainly wish someone would find out what it happening!"
end

-- "Make Weapon"
Game.GlobalEvtLines:RemoveEvent(501)
evt.global[501] = function()
	if evt.Cmp("Inventory", 1493) then         -- "Stalt-laced ore"
		evt.Subtract("Inventory", 1493)         -- "Stalt-laced ore"
		evt.GiveItem{Strength = 6, Type = const.ItemType.Weapon_, Id = 0}
		evt.SetMessage(1621)         -- "Here's your weapon; if you find more ore, I'll be happy to make you more weapons."
	elseif evt.Cmp("Inventory", 1492) then         -- "Erudine-laced ore"
		evt.Subtract("Inventory", 1492)         -- "Erudine-laced ore"
		evt.GiveItem{Strength = 5, Type = const.ItemType.Weapon_, Id = 0}
		evt.SetMessage(1621)         -- "Here's your weapon; if you find more ore, I'll be happy to make you more weapons."
	elseif evt.Cmp("Inventory", 1491) then         -- "Kergar-laced ore"
		evt.Subtract("Inventory", 1491)         -- "Kergar-laced ore"
		evt.GiveItem{Strength = 4, Type = const.ItemType.Weapon_, Id = 0}
		evt.SetMessage(1621)         -- "Here's your weapon; if you find more ore, I'll be happy to make you more weapons."
	elseif evt.Cmp("Inventory", 1490) then         -- "Phylt-laced ore"
		evt.Subtract("Inventory", 1490)         -- "Phylt-laced ore"
		evt.GiveItem{Strength = 3, Type = const.ItemType.Weapon_, Id = 0}
		evt.SetMessage(1621)         -- "Here's your weapon; if you find more ore, I'll be happy to make you more weapons."
	elseif evt.Cmp("Inventory", 1489) then         -- "Siertal-laced ore"
		evt.Subtract("Inventory", 1489)         -- "Siertal-laced ore"
		evt.GiveItem{Strength = 2, Type = const.ItemType.Weapon_, Id = 0}
		evt.SetMessage(1621)         -- "Here's your weapon; if you find more ore, I'll be happy to make you more weapons."
	elseif evt.Cmp("Inventory", 1488) then         -- "Iron-laced ore"
		evt.Subtract("Inventory", 1488)         -- "Iron-laced ore"
		evt.GiveItem{Strength = 1, Type = const.ItemType.Weapon_, Id = 0}
		evt.SetMessage(1621)         -- "Here's your weapon; if you find more ore, I'll be happy to make you more weapons."
	else
		evt.SetMessage(1622)         -- "You need ore for me to create weapons.  The better the ore, the better the weapon I can make."
	end
end

-- "Make Armor"
Game.GlobalEvtLines:RemoveEvent(502)
evt.global[502] = function()
	if evt.Cmp("Inventory", 1493) then         -- "Stalt-laced ore"
		evt.Subtract("Inventory", 1493)         -- "Stalt-laced ore"
		evt.GiveItem{Strength = 6, Type = const.ItemType.Armor_, Id = 0}
		evt.SetMessage(1623)         -- "Here's your armor; if you find more ore, I'll be happy to make you more armor."
	elseif evt.Cmp("Inventory", 1492) then         -- "Erudine-laced ore"
		evt.Subtract("Inventory", 1492)         -- "Erudine-laced ore"
		evt.GiveItem{Strength = 5, Type = const.ItemType.Armor_, Id = 0}
		evt.SetMessage(1623)         -- "Here's your armor; if you find more ore, I'll be happy to make you more armor."
	elseif evt.Cmp("Inventory", 1491) then         -- "Kergar-laced ore"
		evt.Subtract("Inventory", 1491)         -- "Kergar-laced ore"
		evt.GiveItem{Strength = 4, Type = const.ItemType.Armor_, Id = 0}
		evt.SetMessage(1623)         -- "Here's your armor; if you find more ore, I'll be happy to make you more armor."
	elseif evt.Cmp("Inventory", 1490) then         -- "Phylt-laced ore"
		evt.Subtract("Inventory", 1490)         -- "Phylt-laced ore"
		evt.GiveItem{Strength = 3, Type = const.ItemType.Armor_, Id = 0}
		evt.SetMessage(1623)         -- "Here's your armor; if you find more ore, I'll be happy to make you more armor."
	elseif evt.Cmp("Inventory", 1489) then         -- "Siertal-laced ore"
		evt.Subtract("Inventory", 1489)         -- "Siertal-laced ore"
		evt.GiveItem{Strength = 2, Type = const.ItemType.Armor_, Id = 0}
		evt.SetMessage(1623)         -- "Here's your armor; if you find more ore, I'll be happy to make you more armor."
	elseif evt.Cmp("Inventory", 1488) then         -- "Iron-laced ore"
		evt.Subtract("Inventory", 1488)         -- "Iron-laced ore"
		evt.GiveItem{Strength = 1, Type = const.ItemType.Armor_, Id = 0}
		evt.SetMessage(1623)         -- "Here's your armor; if you find more ore, I'll be happy to make you more armor."
	else
		evt.SetMessage(1624)         -- "You need ore for me to create armor.  The better the ore, the better the armor I can make."
	end
end

-- "Make Item"
Game.GlobalEvtLines:RemoveEvent(503)
evt.global[503] = function()
	if evt.Cmp("Inventory", 1493) then         -- "Stalt-laced ore"
		evt.Subtract("Inventory", 1493)         -- "Stalt-laced ore"
		evt.GiveItem{Strength = 6, Type = const.ItemType.Misc, Id = 0}
		evt.SetMessage(1625)         -- "Here is your item; if you find more ore, I'll be happy to make you more items."
	elseif evt.Cmp("Inventory", 1492) then         -- "Erudine-laced ore"
		evt.Subtract("Inventory", 1492)         -- "Erudine-laced ore"
		evt.GiveItem{Strength = 5, Type = const.ItemType.Misc, Id = 0}
		evt.SetMessage(1625)         -- "Here is your item; if you find more ore, I'll be happy to make you more items."
	elseif evt.Cmp("Inventory", 1491) then         -- "Kergar-laced ore"
		evt.Subtract("Inventory", 1491)         -- "Kergar-laced ore"
		evt.GiveItem{Strength = 4, Type = const.ItemType.Misc, Id = 0}
		evt.SetMessage(1625)         -- "Here is your item; if you find more ore, I'll be happy to make you more items."
	elseif evt.Cmp("Inventory", 1490) then         -- "Phylt-laced ore"
		evt.Subtract("Inventory", 1490)         -- "Phylt-laced ore"
		evt.GiveItem{Strength = 3, Type = const.ItemType.Misc, Id = 0}
		evt.SetMessage(1625)         -- "Here is your item; if you find more ore, I'll be happy to make you more items."
	elseif evt.Cmp("Inventory", 1489) then         -- "Siertal-laced ore"
		evt.Subtract("Inventory", 1489)         -- "Siertal-laced ore"
		evt.GiveItem{Strength = 2, Type = const.ItemType.Misc, Id = 0}
		evt.SetMessage(1625)         -- "Here is your item; if you find more ore, I'll be happy to make you more items."
	elseif evt.Cmp("Inventory", 1488) then         -- "Iron-laced ore"
		evt.Subtract("Inventory", 1488)         -- "Iron-laced ore"
		evt.GiveItem{Strength = 1, Type = const.ItemType.Misc, Id = 0}
		evt.SetMessage(1625)         -- "Here is your item; if you find more ore, I'll be happy to make you more items."
	else
		evt.SetMessage(1626)         -- "You need ore for me to create items.  The better the ore, the better the items I can make."
	end
end

-- "Signal "
Game.GlobalEvtLines:RemoveEvent(504)
evt.global[504] = function()
	evt.SetMessage(1627)         -- "The signal rocket on the west side of the island should be set of to warn ships off from approaching to close to that side of the island.  The reefs off the west coast have proven deadly in the past."
end

-- "Dragon Flies"
Game.GlobalEvtLines:RemoveEvent(505)
evt.global[505] = function()
	evt.SetMessage(1628)         -- "Beware the marshes of the southern tip of the island.  A tribe of Goblins has taken up residence there!  "
end

-- "Fallen Trees"
Game.GlobalEvtLines:RemoveEvent(506)
evt.global[506] = function()
	evt.SetMessage(1629)         -- "Fallen or dead trees can sometimes be the hiding place of some treasure or trinket.  However, it can also be home to insects or worse!"
end

-- "Bracada Teleporters"
Game.GlobalEvtLines:RemoveEvent(1251)
evt.global[1251] = function()
	evt.SetMessage(1630)         -- "The teleporters of central Bracada can get you to numerous locations in the desert.  Just check the pillar in front of the teleporter for the location it will take you to.  Be careful however, some of the teleporters haven't been working correctly and will not show the destination!"
end

-- "Castle Upgrade"
evt.CanShowTopic[1252] = function()
	if not evt.Cmp("QBits", 610) then         -- Built Castle to Level 2 (rescued dwarf guy)
		return false
	end
end

Game.GlobalEvtLines:RemoveEvent(1252)
evt.global[1252] = function()
	if evt.Cmp("Awards", 28) then         -- "Completed Necromancer Breeding Pit"
		evt.SetMessage(1631)         --[[ "Oh! and stay clear of Pascal and his minions of conjured Trolls!  Pascal is really quite ‘mad’ and his minions are somewhat stupid.  If you get too close to them in the heat of Battle, they may attack you!  If this occurs, all of your allies will become your enemies and you will fail the Test of Friendship!

And remember your objective!  Get the cube and gather your friends back into your party.  Once this is done you can dispatch the remaining foes if you like.

When it’s time to leave, you **must** use the exit to Celeste located immediately behind you in company with all six friends!  Don’t leave this cave by any other means or you will fail The Test and The Game!

Good luck, adventurers!" ]]
	elseif evt.Cmp("Awards", 6) then         -- "Completed Wizard Proving Grounds"
		evt.SetMessage(1632)         -- "My Lords!  Gavin Magnus sent engineers and artisans to upgrade Castle Harmondale!  Now we have an upstairs and downstairs!  The artisans are setting up shop in the entry hall and will have many wonderful items for sale!  The workers, however, discovered an older area to the castle--a torture chamber and dungeon.  It isn't a pretty sight, I'm afraid."
	else
		evt.SetMessage(1636)         -- "My Lords. Castle Harmondale stands ready."
	end
end

-- "Pedestals"
Game.GlobalEvtLines:RemoveEvent(1253)
evt.global[1253] = function()
	evt.SetMessage(1637)         -- "Pedestals can be found through out the land that can lend you temporary protection from certain types of magic. "
end

-- "Disputed Land"
Game.GlobalEvtLines:RemoveEvent(1254)
evt.global[1254] = function()
	evt.SetMessage(1633)         -- "My Lords ::bows:: Now that you have cleared Castle Harmondale of the vandals and thieves, you should concentrate on removing the goblins from the area surrounding Harmondale.  To the east of here is the center of the disputed region.  Many great battles have been waged there between the forces of King Eldrich of the Elves and Queen Catherine of Erathia.  The goblins have taken the ruined fort in this area an use it to attack any travelers attempting to reach Harmondale!"
end

-- "Castle Harmondale"
Game.GlobalEvtLines:RemoveEvent(1255)
evt.global[1255] = function()
	evt.SetMessage(1634)         -- "My Lords, remember Castle Harmondale is YOURS.  Feel free to relax while you're here.  Your sleep will never be disturbed by attacking monsters, nor will anything you decide to store in the castle's chests ever be stolen or removed.  You are home."
end

-- "Pay 1000 Gold"
Game.GlobalEvtLines:RemoveEvent(513)
evt.global[513] = function()
	if evt.Cmp("Gold", 1000) then
		evt.SetMessage(1642)         -- "This 1000 gold will go a long way to keeping zombies off the roads.  Thank you for your contribution."
		evt.Subtract("Gold", 1000)
		evt.Set("QBits", 761)         -- Don't get ambushed
	else
		evt.SetMessage(1659)         -- "I can see your heart is in the right place, but your purse obviously isn't.  If you don't have the money, just say so.  In any event, good luck dealing with the zombies.  Ta-ta!"
	end
	evt.SetNPCTopic{NPC = 461, Index = 0, Event = 0}         -- "Lunius Shador"
	evt.SetNPCTopic{NPC = 461, Index = 1, Event = 0}         -- "Lunius Shador"
end

-- "Don't Pay"
Game.GlobalEvtLines:RemoveEvent(514)
evt.global[514] = function()
	evt.SetMessage(1643)         -- "That's a shame.  What a coincidence, I think I see some zombies on the roads.  Perhaps next time you'll be more inclined to contribute."
	evt.SetNPCTopic{NPC = 461, Index = 0, Event = 0}         -- "Lunius Shador"
	evt.SetNPCTopic{NPC = 461, Index = 1, Event = 0}         -- "Lunius Shador"
end

-- "Recent Loss"
Game.GlobalEvtLines:RemoveEvent(515)
evt.global[515] = function()
	evt.SetMessage(1644)         -- "My husband Darron recently lost his brother in a freak accident.  So overwhelming is his grief that he spends his days wandering aimlessly about Pierpont.  Poor soul!"
end

-- "Can we help?"
Game.GlobalEvtLines:RemoveEvent(1257)
evt.global[1257] = function()
	evt.SetMessage(1355)         -- "That's very kind of you.  But no .... I've got to deal with his absence in my own way and time.  Wait!!  perhaps you can assist me by honoring my brother's name.  You see, Elron, was an avid Arcomage player.  Horribly addicting game, if I do say so.  Here, take his Arcomage deck and win the Arcomage tournament in his name.  He'd like that.  Thank you."
	evt.ForPlayer("Current")
	evt.Add("Inventory", 1453)         -- "Arcomage Deck"
	evt.SetNPCTopic{NPC = 624, Index = 0, Event = 1216}         -- "Darron Temper" : "Arcomage Tounament"
end

-- "Disarm Trap Expert"
Game.GlobalEvtLines:RemoveEvent(1258)
evt.global[1258] = function()
	evt.SetMessage(1646)         -- "Bill Lasker is the only one who can provide this advancement.  Seek him out in the Erathian Sewers."
end

-- "Courier Delivery"
Game.GlobalEvtLines:RemoveEvent(1259)
evt.global[1259] = function()
	evt.ForPlayer("All")
	if evt.Cmp("QBits", 789) then         -- Courier Quest 4
		evt.SetMessage(2750)         --[[ "My! Aren't you a fine-looking group of adventurers!  Zowie!  Fine, supple, strong; beauty at its best!  It’s always grand to meet others of the same calaibre as myself.  They should call ‘our kind’ the ‘Beautiful Ones’.  My name is Agatha.  Good to feast my eyes on you all. 

Now, onto the task at-hand.  My twin sister Rena lives here in Deja with her husband, Jayce Kedrin.  Rena and I are not identical twins and she was not ‘blessed’ with the ‘looks’ in our family as was I.  She’s, well, kind of plain.  Some might call her a real ‘Bow Wow’, if you know what I mean.  She’s the proverbial ‘two-bag date’.  Anywise, her birthday is upon us and I have purchased a special concoction called ‘Beauty Cream’ from Licia Rivenrock.  She’s indeed a Master Herbalist and her ‘cream’ is reported to do wonders with even the most ‘ordinary’ of subjects. I need you to pick up the order from Licia and deliver it to my sister.  Licia runs a business called ‘The House of Remedies’ in the Barrow Downs.

Oh! And my sister will provide you with the customary fee upon delivery. " ]]
		evt.SetNPCTopic{NPC = 548, Index = 0, Event = 0}         -- "Agatha Putnam"
		return
	end
	if evt.Cmp("QBits", 788) then         -- Courier Quest 3
		if evt.Cmp("Inventory", 1576) then         -- "Recipe"
			evt.SetMessage(2749)         -- "The recipe!  You made good time on this delivery.  Great service!  Thanks.  Here's your fee."
			evt.Subtract("Inventory", 1576)         -- "Recipe"
			evt.ForPlayer("Current")
			evt.Add("Gold", 5000)
			evt.SetNPCTopic{NPC = 1244, Index = 0, Event = 0}         -- "Alice the Chef"
			evt.Set("QBits", 792)         -- Courier Quest 3 complete
		else
			evt.SetMessage(2747)         -- "Welcome to Alice’s Restaurant … where you can get anything you want!  Well, that is, except me. I’m Alice.  Today’s special is broiled filet of Troll, smothered in toad stools with …  Oh, I’m sorry.  You’re the couriers, aren’t you!  What I need you to do is to pickup a recipe from Peni Pretty in Erathia and return it to me.  The standard delivery fee will be paid upon receipt of the recipe."
		end
		return
	end
	if evt.Cmp("QBits", 787) then         -- Courier Quest 2
		if evt.Cmp("Inventory", 1366) then         -- "Talisman (repaired)"
			evt.SetMessage(2745)         -- "The talisman, good as new!  Thanks.  Here’s your payment."
			evt.Subtract("Inventory", 1366)         -- "Talisman (repaired)"
			evt.ForPlayer("Current")
			evt.Add("Gold", 5000)
			evt.SetNPCTopic{NPC = 377, Index = 0, Event = 0}         -- "Bartholomew Hume"
			evt.Set("QBits", 791)         -- Courier Quest 2 complete
			return
		end
		if not evt.Cmp("Inventory", 1365) then         -- "Talisman (broken)"
			evt.ForPlayer("Current")
			evt.Add("Inventory", 1365)         -- "Talisman (broken)"
		end
		evt.SetMessage(2744)         -- "Ahh,the Couriers in-training!  Your arrival is most propitious!   I need you to deliver this broken talisman to Douglas Iversen in Harmondale.  Wait while he repairs the item and return it to me.  Upon its return, I’ll give you the standard courier fee."
		return
	end
	if not evt.Cmp("QBits", 786) then         -- Courier Quest 1
		return
	end
	if evt.Cmp("Inventory", 1575) then         -- "Signed Contract"
		evt.SetMessage(1648)         --[[ "Thanks for returning this contract to me.  Here's your reward, as promised. 

Oh! and I found the crossword puzzle answer.  Freddie the Freeloader was a Red Skeleton." ]]
		evt.Subtract("Inventory", 1575)         -- "Signed Contract"
		evt.ForPlayer("Current")
		evt.Add("Gold", 5000)
		evt.SetNPCTopic{NPC = 580, Index = 0, Event = 0}         -- "Taren the Lifter"
		evt.Set("QBits", 790)         -- Courier Quest 1 complete
		return
	end
	if not evt.Cmp("Inventory", 1574) then         -- "Unsigned Contract"
		evt.ForPlayer("Current")
		evt.Add("Inventory", 1574)         -- "Unsigned Contract"
	end
	evt.SetMessage(1647)         --[[ "Ahh, the new Courier Initiates arrive at last! I need to have a contract delivered to Mortie Ottin in Pierpont, signed by him, and returned to me post haste.  This is a very time sensitive task that needs to be completed within the month.  I will provide you with the customary payment when the contract is returned to me. 

Oh, before ya leave, maybe you can help me.  I'm 'stuck' on a crossword puzzle question.  Do you know the color of the Skeleton named 'Freddy the Freeloader'?  Didn't think so, but it was worth a try.  See you on your return trip." ]]
end

-- "Courier Delivery"
Game.GlobalEvtLines:RemoveEvent(1260)
evt.global[1260] = function()
	evt.ForPlayer("All")
	if evt.Cmp("QBits", 789) then         -- Courier Quest 4
		if evt.Cmp("QBits", 794) then         -- Rena Quest
			evt.SetMessage(2752)         --[[ "A delivery for me?  Must be my birthday present from Agie. Oh my!  A bottle of the legendary ‘Beauty Cream’.  I’m so excited about this!  Here, let me have it.  [Rena takes the bottle and gulps down the entire content] 

Oh!  I feel so …. strange.  Here, take your delivery fee and leave now.  I’m going to take a little nap.  Visit me later to see the results of the ‘miracle treatment’.  By for now …. " ]]
			evt.Set("QBits", 793)         -- Courier Quest 4 complete
			evt.Subtract("Inventory", 1074)         -- "Beauty Creme"
			evt.ForPlayer("Current")
			evt.Add("Gold", 5000)
			evt.SetNPCTopic{NPC = 1245, Index = 0, Event = 0}         -- "Rena Putnum Kedrin"
			evt.MoveNPC{NPC = 1245, HouseId = 0}         -- "Rena Putnum Kedrin"
			evt.MoveNPC{NPC = 1246, HouseId = 974}         -- "Rena Putnum Kedrin" -> "Kedrin Residence"
		else
			evt.SetMessage(2751)         --[[ "Hi, I’m Licia.  Can I interest you in some of my herbal remedies?  Perhaps some Love Potent #9?  Or a bottle of my patented ‘potency formula’ named ‘Argaiv’?  

Oh, of course not.  You’re the couriers here for a pick up, aren’t you.  Well here’s the bottle of Beauty Cream, and here’s your Deja Teleportal Key.  Good luck on your journey back to Deja."" ]]
			evt.Set("QBits", 794)         -- Rena Quest
			evt.SetNPCTopic{NPC = 1245, Index = 0, Event = 1260}         -- "Rena Putnum Kedrin" : "Courier Delivery"
			evt.ForPlayer("Current")
			evt.Add("Inventory", 1074)         -- "Beauty Creme"
			evt.Add("Inventory", 1468)         -- "Deja Teleportal Key"
			evt.SetNPCTopic{NPC = 738, Index = 0, Event = 0}         -- "Licia Rivenrock"
		end
	elseif evt.Cmp("QBits", 788) then         -- Courier Quest 3
		evt.ForPlayer("Current")
		evt.Add("Inventory", 1576)         -- "Recipe"
		evt.SetMessage(2748)         -- "Oh, the couriers!  I suspect you’re here for the recipe?  Here you are.  And here’s the Avlee Teleportal Key."
		evt.Add("Inventory", 1469)         -- "Avlee Teleportal Key"
		evt.SetNPCTopic{NPC = 781, Index = 0, Event = 0}         -- "Peni Pretty"
	elseif evt.Cmp("QBits", 787) then         -- Courier Quest 2
		evt.Subtract("Inventory", 1365)         -- "Talisman (broken)"
		evt.ForPlayer("Current")
		evt.Add("Inventory", 1366)         -- "Talisman (repaired)"
		evt.SetMessage(2746)         -- "What have we here?  Oh, I see.  This will be easy to fix.  [Iversen takes the talisman into the back room and returns in a few minutes]  There ya go, good as new!  Return this to Master Hume for your reward.  Here's your second teleportal key."
		evt.Add("Inventory", 1471)         -- "Bracada Teleportal Key"
		evt.SetNPCTopic{NPC = 467, Index = 0, Event = 0}         -- "Douglas Iverson"
	elseif evt.Cmp("QBits", 786) then         -- Courier Quest 1
		if evt.Cmp("Inventory", 1574) then         -- "Unsigned Contract"
			evt.Subtract("Inventory", 1574)         -- "Unsigned Contract"
			evt.ForPlayer("Current")
			evt.Add("Inventory", 1575)         -- "Signed Contract"
			evt.SetMessage(1649)         --[[ "The contract ... finally!  Here, let me look it over.  Looks good .. [Mortie signs the contract and returns it to you]  Return this contract to Taren with all haste.    Here's your first teleportal key.  It will save you some travel time in the delivery.

Oh, and a word about the Teleportal Hub.  The hub can take you to several locations.  Make sure that your party leader (active character) is equipped with only one key -that of your desired destination.  Otherwise you may be transported elsewhere."" ]]
			evt.Add("Inventory", 1467)         -- "Tatalia Teleportal Key"
			evt.SetNPCTopic{NPC = 446, Index = 0, Event = 0}         -- "Mortie Ottin"
		else
			evt.SetMessage(1650)         -- "Where's the contract?  Oh, sorry ... I mistook you for the couriers from Taren in Tatalia."
		end
	end
end

-- "The Courier Guild"
Game.GlobalEvtLines:RemoveEvent(1261)
evt.global[1261] = function()
	evt.SetMessage(1651)         --[[ "Welcome, adventurers!  I'm Sarah, the Founding Matron and Gran Mouma of the Courier Guild.  The Courier Guild consists of an elite company of Master Couriers who enjoy certain travel privileges throughout the remote areas of Erathia.   Membership to the guild is 500 gold, non-refundable.  With your initial membership, you become a Courier Initiate and receive the Home Key, which entitles you to use all Home Portals to return you to Steadwick.

To become a Master Courier, you must complete four courier assignments.  The completion of each assignment will provide you with (1) a 5000 gold delivery fee and (2) a unique teleportal key that activates the Teleportal Hub in Harmondale."" ]]
	evt.SetNPCTopic{NPC = 1242, Index = 0, Event = 1262}         -- "Sarah" : "Join the Guild"
end

-- "Join the Guild"
Game.GlobalEvtLines:RemoveEvent(1262)
evt.global[1262] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Gold", 500) then
		evt.Set("QBits", 785)         -- "Complete four Courier Guild missions."
		evt.ForPlayer("Current")
		evt.Subtract("Gold", 500)
		evt.Add("Inventory", 1472)         -- "Home Key"
		evt.SetMessage(1652)         -- "A wise decision on your part!  Here’s your Home Key.  Guard it carefully, because it is irreplaceable."
		evt.SetNPCTopic{NPC = 1242, Index = 0, Event = 1263}         -- "Sarah" : "Courier Assignment"
	else
		evt.SetMessage(1063)         -- "You don't have enough gold!"
	end
end

-- "Courier Assignment"
Game.GlobalEvtLines:RemoveEvent(1263)
evt.global[1263] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 793) then         -- Courier Quest 4 complete
		if evt.Cmp("QBits", 792) then         -- Courier Quest 3 complete
			evt.SetMessage(947)         --[[ "Now to your final assignment.  This one’s a bit tricky, I’m afraid, and somewhat dangerous.  In the mid-western region of Deja there is a small, unnamed village of four or five shanties.  Journey to this village and find Agatha Putnam.  She’ll provide details of your final delivery.  After you’ve completed this assignment, use the Deja Home Portal to return to me for your promotion to Master Courier. 

Oh!  And watch out for the hostiles in this area!  Good luck." ]]
			evt.SetNPCTopic{NPC = 548, Index = 0, Event = 1259}         -- "Agatha Putnam" : "Courier Delivery"
			evt.SetNPCTopic{NPC = 738, Index = 0, Event = 1260}         -- "Licia Rivenrock" : "Courier Delivery"
			evt.MoveNPC{NPC = 1245, HouseId = 974}         -- "Rena Putnum Kedrin" -> "Kedrin Residence"
			evt.Set("QBits", 789)         -- Courier Quest 4
		elseif evt.Cmp("QBits", 791) then         -- Courier Quest 2 complete
			evt.SetMessage(1655)         -- "I see you are well on your way to Master Courier.  Good!  Your third delivery takes you to the town of Spaward in Avlee.  You need to locate Alice's Restaurant  (where you can get anything you want) and just ask Alice.  She'll brief you on the details of the delivery."
			evt.SetNPCTopic{NPC = 1244, Index = 0, Event = 1259}         -- "Alice the Chef" : "Courier Delivery"
			evt.SetNPCTopic{NPC = 781, Index = 0, Event = 1260}         -- "Peni Pretty" : "Courier Delivery"
			evt.Set("QBits", 788)         -- Courier Quest 3
		elseif evt.Cmp("QBits", 790) then         -- Courier Quest 1 complete
			evt.SetMessage(1654)         -- "Good job on your first assignment!  For your next delivery, you must journey to the Bracada Desert and seek out Bartholomew Hume, the Roving Monk. You can normally find him near the Crystal Caravans.  He will provide you with details of the delivery. Bracada does have a Home Portal, in case you need to return here during your assignment.""
			evt.SetNPCTopic{NPC = 377, Index = 0, Event = 1259}         -- "Bartholomew Hume" : "Courier Delivery"
			evt.SetNPCTopic{NPC = 467, Index = 0, Event = 1260}         -- "Douglas Iverson" : "Courier Delivery"
			evt.Set("QBits", 787)         -- Courier Quest 2
		else
			evt.SetMessage(1653)         -- "Your first assignment takes you to Tatalia.  When you arrive, seek out Taren.  He will provide you with details of the delivery.  Tatalia does have a Home Portal, in case you need to return here during your assignment."
			evt.MoveNPC{NPC = 580, HouseId = 1048}         -- "Taren the Lifter" -> "Taren's House"
			evt.SetNPCTopic{NPC = 446, Index = 0, Event = 1260}         -- "Mortie Ottin" : "Courier Delivery"
			evt.Set("QBits", 786)         -- Courier Quest 1
		end
		return
	end
	evt.SetMessage(948)         --[[ "Congratulations!  You’ve completed all four assignments in record time, just as the Erathian Festival of the Five Moons is ending!   You are now ready to join the ranks of our elite guild. I hereby promote you to the rank of Master Courier!  Welcome to the Guild! 

Now just one more thing.  Our couriers used to service the Evenmorn Islands. Unfortunately through a series of miss-haps, all keys to the island chain were lost, stolen, or destroyed.   If you ever come across one of these keys, please bring it back to me so that I can make a copy of it.  I will reward you handsomely in gold.  Good luck, Master Couriers!"" ]]
	evt.Subtract("QBits", 785)         -- "Complete four Courier Guild missions."
	evt.Subtract("QBits", 786)         -- Courier Quest 1
	evt.Subtract("QBits", 787)         -- Courier Quest 2
	evt.Subtract("QBits", 788)         -- Courier Quest 3
	evt.Subtract("QBits", 789)         -- Courier Quest 4
	evt.Subtract("QBits", 790)         -- Courier Quest 1 complete
	evt.Subtract("QBits", 791)         -- Courier Quest 2 complete
	evt.Subtract("QBits", 792)         -- Courier Quest 3 complete
	evt.Subtract("QBits", 793)         -- Courier Quest 4 complete
	evt.Subtract("QBits", 794)         -- Rena Quest
	evt.SetNPCTopic{NPC = 387, Index = 0, Event = 842}         -- "Thomas Grey" : "Wizard"
	evt.SetNPCTopic{NPC = 380, Index = 0, Event = 817}         -- "Steagal Snick" : "Warrior Mage"
	evt.SetNPCTopic{NPC = 389, Index = 0, Event = 848}         -- "Anthony Green" : "Great Druid"
	evt.SetNPCTopic{NPC = 382, Index = 0, Event = 823}         -- "Frederick Org" : "Cavalier"
	evt.SetNPCTopic{NPC = 384, Index = 0, Event = 829}         -- "Ebednezer Sower" : "Hunter"
	evt.SetNPCTopic{NPC = 377, Index = 1, Event = 808}         -- "Bartholomew Hume" : "Initiate"
	evt.Set("QBits", 795)         -- End of Festival
	for pl = 0, Party.High do
		evt.ForPlayer(pl)
		evt.Add("Experience", 20000)
		evt.Add("Awards", 118)         -- "Promoted to Master Courier"
	end
	evt.SetNPCTopic{NPC = 1242, Index = 0, Event = 1264}         -- "Sarah" : "Lost Key"
end

-- "Lost Key"
Game.GlobalEvtLines:RemoveEvent(1264)
evt.global[1264] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 1470) then         -- "Evenmorn Teleportal Key"
		evt.SetMessage(949)         -- "I see you’ve recovered the Evenmorn key.  Great!  This is indeed a good day for The Guild!  Let me make a copy of the key.  Here’s your reward, as promised."
		evt.ForPlayer("Current")
		evt.Add("Gold", 10000)
		evt.SetNPCTopic{NPC = 1242, Index = 0, Event = 0}         -- "Sarah"
	else
		evt.SetMessage(2743)         -- "Please continue to search for the Evenmorn Key."
	end
end

-- "Purchase 50 food for 500 gold"
Game.GlobalEvtLines:RemoveEvent(1265)
evt.global[1265] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("Gold", 500) then
		evt.SetMessage(1063)         -- "You don't have enough gold!"
	elseif evt.Cmp("Food", 50) then
		evt.SetMessage(977)         -- "Your packs are full!"
	else
		evt.ForPlayer("Current")
		evt.Subtract("Gold", 500)
		evt.Set("Food", 50)
	end
end

-- "I feel Pretty!"
Game.GlobalEvtLines:RemoveEvent(1266)
evt.global[1266] = function()
	evt.SetMessage(2753)         --[[ "I feel pretty, oh so pretty.  I feel pretty .. and witty .. and gay!  And I pity any girl that's in need today. Tra-la-la-la-la-la-lala!! 

I feel stunning,oh so stunning.  Feel like running and jumping for joy!  ....." ]]
end

-- "Promotions"
Game.GlobalEvtLines:RemoveEvent(1267)
evt.global[1267] = function()
	evt.SetMessage(954)         -- "Sorry, promotions are not available during the Festival of the Five Moons.  Come back after the holidays."
end

-- "Boat Schedule"
Game.GlobalEvtLines:RemoveEvent(1268)
evt.global[1268] = function()
	evt.SetMessage(1656)         -- "You can charter a boat from this port to Erathia on Tuesdays, Thursdays and Saturdays. Boats for the Bracada Desert leave on Mondays and Wednesdays. Boats leave for Avlee on Friday only. If you have completed the Priest quest you can charter a boat to Evenmorn Island on Sundays."
end

-- "Nighon Tunnel"
Game.GlobalEvtLines:RemoveEvent(1269)
evt.global[1269] = function()
	evt.SetMessage(1657)         -- "If you are looking to make it quickly to Nighon through the tunnels below, you should take the left fork of the Nighon Tunnel.  Many have taken the right fork and have never been heard from again.  Then again they may have made it to Nighon only to be taken by the Warlocks!"
end

-- "Harmodale Teleportal Hub"
Game.GlobalEvtLines:RemoveEvent(1270)
evt.global[1270] = function()
	if evt.Cmp("Inventory", 1466) then         -- "Emerald Is. Teleportal Key"
		evt.SetMessage(2738)         -- "I see you have the Emerald Island teleportal key.  You cannot use this key in the Harmondale Hub.  It only works at the teleport platform north of the Crystal Caravan."
	else
		evt.SetMessage(1658)         -- "The well in this area is a Teleportal Hub used by the Courier Guild. The hub can take you to Bracada, Evenmorn Islands, Deja, Tatalia, and Avlee.  The keys required to use the hub are only issued to guild members in good standing.  The guild's main office is in Steadwick (Erathia proper), accross the way from the Griffin's Rest."
	end
end

-- "Haste Pedestal"
Game.GlobalEvtLines:RemoveEvent(1271)
evt.global[1271] = function()
	evt.CastSpell{Spell = 5, Mastery = const.GM, Skill = 5, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Haste"
end

-- "Earth Resistance Pedestal"
Game.GlobalEvtLines:RemoveEvent(1272)
evt.global[1272] = function()
	evt.CastSpell{Spell = 36, Mastery = const.GM, Skill = 5, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Earth Resistance"
end

-- "Day of the Gods Pedestal"
Game.GlobalEvtLines:RemoveEvent(1273)
evt.global[1273] = function()
	evt.CastSpell{Spell = 83, Mastery = const.GM, Skill = 5, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Day of the Gods"
end

-- "Shield Pedestal"
Game.GlobalEvtLines:RemoveEvent(1274)
evt.global[1274] = function()
	evt.CastSpell{Spell = 17, Mastery = const.GM, Skill = 5, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Shield"
end

-- "Water Resistance Pedestal"
Game.GlobalEvtLines:RemoveEvent(1275)
evt.global[1275] = function()
	evt.CastSpell{Spell = 25, Mastery = const.GM, Skill = 5, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Water Resistance"
end

-- "Fire Resistance Pedestal"
Game.GlobalEvtLines:RemoveEvent(1276)
evt.global[1276] = function()
	evt.CastSpell{Spell = 3, Mastery = const.GM, Skill = 5, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Fire Resistance"
end

-- "Heroism Pedestal"
Game.GlobalEvtLines:RemoveEvent(1277)
evt.global[1277] = function()
	evt.CastSpell{Spell = 51, Mastery = const.GM, Skill = 5, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Heroism"
end

-- "Immolation Pedestal"
Game.GlobalEvtLines:RemoveEvent(1278)
evt.global[1278] = function()
	evt.CastSpell{Spell = 8, Mastery = const.GM, Skill = 5, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Immolation"
end

-- "Mind Resistance Pedestal"
Game.GlobalEvtLines:RemoveEvent(1279)
evt.global[1279] = function()
	evt.CastSpell{Spell = 58, Mastery = const.GM, Skill = 5, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Mind Resistance"
end

-- "Body Resistance Pedestal"
Game.GlobalEvtLines:RemoveEvent(1280)
evt.global[1280] = function()
	evt.CastSpell{Spell = 69, Mastery = const.GM, Skill = 5, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Body Resistance"
end

-- "Stone Skin Pedestal"
Game.GlobalEvtLines:RemoveEvent(1281)
evt.global[1281] = function()
	evt.CastSpell{Spell = 38, Mastery = const.GM, Skill = 5, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Stone Skin"
end

-- "Air Resistance Pedestal"
Game.GlobalEvtLines:RemoveEvent(1282)
evt.global[1282] = function()
	evt.CastSpell{Spell = 14, Mastery = const.GM, Skill = 5, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Air Resistance"
end

-- "Game of Might"
Game.GlobalEvtLines:RemoveEvent(1283)
evt.global[1283] = function()
	if evt.Cmp("PlayerBits", 31) then
		evt.StatusText(1664)         -- "You have already won!"
	elseif evt.Cmp("CurrentMight", 25) then
		evt.Add("SkillPoints", 3)
		evt.StatusText(1665)         -- "You win!  +3 Skill Points"
		evt.Set("PlayerBits", 31)
	else
		evt.StatusText(1660)         -- "You have failed the game!"
	end
end

-- "Game of Endurance"
Game.GlobalEvtLines:RemoveEvent(1284)
evt.global[1284] = function()
	if evt.Cmp("PlayerBits", 32) then
		evt.StatusText(1664)         -- "You have already won!"
	elseif evt.Cmp("CurrentEndurance", 25) then
		evt.Add("SkillPoints", 3)
		evt.StatusText(1665)         -- "You win!  +3 Skill Points"
		evt.Set("PlayerBits", 32)
	else
		evt.StatusText(1660)         -- "You have failed the game!"
	end
end

-- "Game of Intellect"
Game.GlobalEvtLines:RemoveEvent(1285)
evt.global[1285] = function()
	if evt.Cmp("PlayerBits", 33) then
		evt.StatusText(1664)         -- "You have already won!"
	elseif evt.Cmp("CurrentIntellect", 25) then
		evt.Add("SkillPoints", 3)
		evt.StatusText(1665)         -- "You win!  +3 Skill Points"
		evt.Set("PlayerBits", 33)
	else
		evt.StatusText(1660)         -- "You have failed the game!"
	end
end

-- "Game of Personality"
Game.GlobalEvtLines:RemoveEvent(1286)
evt.global[1286] = function()
	if evt.Cmp("PlayerBits", 34) then
		evt.StatusText(1664)         -- "You have already won!"
	elseif evt.Cmp("CurrentPersonality", 25) then
		evt.Add("SkillPoints", 3)
		evt.StatusText(1665)         -- "You win!  +3 Skill Points"
		evt.Set("PlayerBits", 34)
	else
		evt.StatusText(1660)         -- "You have failed the game!"
	end
end

-- "Game of Accuracy"
Game.GlobalEvtLines:RemoveEvent(1287)
evt.global[1287] = function()
	if evt.Cmp("PlayerBits", 35) then
		evt.StatusText(1664)         -- "You have already won!"
	elseif evt.Cmp("CurrentAccuracy", 25) then
		evt.Add("SkillPoints", 3)
		evt.StatusText(1665)         -- "You win!  +3 Skill Points"
		evt.Set("PlayerBits", 35)
	else
		evt.StatusText(1660)         -- "You have failed the game!"
	end
end

-- "Game of Speed"
Game.GlobalEvtLines:RemoveEvent(1288)
evt.global[1288] = function()
	if evt.Cmp("PlayerBits", 36) then
		evt.StatusText(1664)         -- "You have already won!"
	elseif evt.Cmp("CurrentSpeed", 25) then
		evt.Add("SkillPoints", 3)
		evt.StatusText(1665)         -- "You win!  +3 Skill Points"
		evt.Set("PlayerBits", 36)
	else
		evt.StatusText(1660)         -- "You have failed the game!"
	end
end

-- "Game of Luck"
Game.GlobalEvtLines:RemoveEvent(1289)
evt.global[1289] = function()
	if evt.Cmp("PlayerBits", 37) then
		evt.StatusText(1664)         -- "You have already won!"
	elseif evt.Cmp("CurrentLuck", 25) then
		evt.Add("SkillPoints", 3)
		evt.StatusText(1665)         -- "You win!  +3 Skill Points"
		evt.Set("PlayerBits", 37)
	else
		evt.StatusText(1660)         -- "You have failed the game!"
	end
end

-- "Contest of Might"
Game.GlobalEvtLines:RemoveEvent(1290)
evt.global[1290] = function()
	if evt.Cmp("PlayerBits", 38) then
		evt.StatusText(1664)         -- "You have already won!"
	elseif evt.Cmp("CurrentMight", 50) then
		evt.Add("SkillPoints", 5)
		evt.StatusText(1666)         -- "You win!  +5 Skill Points"
		evt.Set("PlayerBits", 38)
	else
		evt.StatusText(1661)         -- "You have failed the contest!"
	end
end

-- "Contest of Endurance"
Game.GlobalEvtLines:RemoveEvent(1291)
evt.global[1291] = function()
	if evt.Cmp("PlayerBits", 39) then
		evt.StatusText(1664)         -- "You have already won!"
	elseif evt.Cmp("CurrentEndurance", 50) then
		evt.Add("SkillPoints", 5)
		evt.StatusText(1666)         -- "You win!  +5 Skill Points"
		evt.Set("PlayerBits", 39)
	else
		evt.StatusText(1661)         -- "You have failed the contest!"
	end
end

-- "Contest of Intellect"
Game.GlobalEvtLines:RemoveEvent(1292)
evt.global[1292] = function()
	if evt.Cmp("PlayerBits", 40) then
		evt.StatusText(1664)         -- "You have already won!"
	elseif evt.Cmp("CurrentIntellect", 50) then
		evt.Add("SkillPoints", 5)
		evt.StatusText(1666)         -- "You win!  +5 Skill Points"
		evt.Set("PlayerBits", 40)
	else
		evt.StatusText(1661)         -- "You have failed the contest!"
	end
end

-- "Contest of Personality"
Game.GlobalEvtLines:RemoveEvent(1293)
evt.global[1293] = function()
	if evt.Cmp("PlayerBits", 41) then
		evt.StatusText(1664)         -- "You have already won!"
	elseif evt.Cmp("CurrentPersonality", 50) then
		evt.Add("SkillPoints", 5)
		evt.StatusText(1666)         -- "You win!  +5 Skill Points"
		evt.Set("PlayerBits", 41)
	else
		evt.StatusText(1661)         -- "You have failed the contest!"
	end
end

-- "Contest of Accuracy"
Game.GlobalEvtLines:RemoveEvent(1294)
evt.global[1294] = function()
	if evt.Cmp("PlayerBits", 42) then
		evt.StatusText(1664)         -- "You have already won!"
	elseif evt.Cmp("CurrentAccuracy", 50) then
		evt.Add("SkillPoints", 5)
		evt.StatusText(1666)         -- "You win!  +5 Skill Points"
		evt.Set("PlayerBits", 42)
	else
		evt.StatusText(1661)         -- "You have failed the contest!"
	end
end

-- "Contest of Speed"
Game.GlobalEvtLines:RemoveEvent(1295)
evt.global[1295] = function()
	if evt.Cmp("PlayerBits", 43) then
		evt.StatusText(1664)         -- "You have already won!"
	elseif evt.Cmp("CurrentSpeed", 50) then
		evt.Add("SkillPoints", 5)
		evt.StatusText(1666)         -- "You win!  +5 Skill Points"
		evt.Set("PlayerBits", 43)
	else
		evt.StatusText(1661)         -- "You have failed the contest!"
	end
end

-- "Contest of Luck"
Game.GlobalEvtLines:RemoveEvent(1296)
evt.global[1296] = function()
	if evt.Cmp("PlayerBits", 44) then
		evt.StatusText(1664)         -- "You have already won!"
	elseif evt.Cmp("CurrentLuck", 50) then
		evt.Add("SkillPoints", 5)
		evt.StatusText(1666)         -- "You win!  +5 Skill Points"
		evt.Set("PlayerBits", 44)
	else
		evt.StatusText(1661)         -- "You have failed the contest!"
	end
end

-- "Test of Might"
Game.GlobalEvtLines:RemoveEvent(1297)
evt.global[1297] = function()
	if evt.Cmp("PlayerBits", 45) then
		evt.StatusText(1664)         -- "You have already won!"
	elseif evt.Cmp("CurrentMight", 100) then
		evt.Add("SkillPoints", 7)
		evt.StatusText(1667)         -- "You win!  +7 Skill Points"
		evt.Set("PlayerBits", 45)
	else
		evt.StatusText(1662)         -- "You have failed the test!"
	end
end

-- "Test of Endurance"
Game.GlobalEvtLines:RemoveEvent(1298)
evt.global[1298] = function()
	if evt.Cmp("PlayerBits", 46) then
		evt.StatusText(1664)         -- "You have already won!"
	elseif evt.Cmp("CurrentEndurance", 100) then
		evt.Add("SkillPoints", 7)
		evt.StatusText(1667)         -- "You win!  +7 Skill Points"
		evt.Set("PlayerBits", 46)
	else
		evt.StatusText(1662)         -- "You have failed the test!"
	end
end

-- "Test of Intellect"
Game.GlobalEvtLines:RemoveEvent(1299)
evt.global[1299] = function()
	if evt.Cmp("PlayerBits", 47) then
		evt.StatusText(1664)         -- "You have already won!"
	elseif evt.Cmp("CurrentIntellect", 100) then
		evt.Add("SkillPoints", 7)
		evt.StatusText(1667)         -- "You win!  +7 Skill Points"
		evt.Set("PlayerBits", 47)
	else
		evt.StatusText(1662)         -- "You have failed the test!"
	end
end

-- "Test of Personality"
Game.GlobalEvtLines:RemoveEvent(1300)
evt.global[1300] = function()
	if evt.Cmp("PlayerBits", 48) then
		evt.StatusText(1664)         -- "You have already won!"
	elseif evt.Cmp("CurrentPersonality", 100) then
		evt.Add("SkillPoints", 7)
		evt.StatusText(1667)         -- "You win!  +7 Skill Points"
		evt.Set("PlayerBits", 48)
	else
		evt.StatusText(1662)         -- "You have failed the test!"
	end
end

-- "Test of Accuracy"
Game.GlobalEvtLines:RemoveEvent(1301)
evt.global[1301] = function()
	if evt.Cmp("PlayerBits", 49) then
		evt.StatusText(1664)         -- "You have already won!"
	elseif evt.Cmp("CurrentAccuracy", 100) then
		evt.Add("SkillPoints", 7)
		evt.StatusText(1667)         -- "You win!  +7 Skill Points"
		evt.Set("PlayerBits", 49)
	else
		evt.StatusText(1662)         -- "You have failed the test!"
	end
end

-- "Test of Speed"
Game.GlobalEvtLines:RemoveEvent(1302)
evt.global[1302] = function()
	if evt.Cmp("PlayerBits", 50) then
		evt.StatusText(1664)         -- "You have already won!"
	elseif evt.Cmp("CurrentSpeed", 100) then
		evt.Add("SkillPoints", 7)
		evt.StatusText(1667)         -- "You win!  +7 Skill Points"
		evt.Set("PlayerBits", 50)
	else
		evt.StatusText(1662)         -- "You have failed the test!"
	end
end

-- "Test of Luck"
Game.GlobalEvtLines:RemoveEvent(1303)
evt.global[1303] = function()
	if evt.Cmp("PlayerBits", 51) then
		evt.StatusText(1664)         -- "You have already won!"
	elseif evt.Cmp("CurrentLuck", 100) then
		evt.Add("SkillPoints", 7)
		evt.StatusText(1667)         -- "You win!  +7 Skill Points"
		evt.Set("PlayerBits", 51)
	else
		evt.StatusText(1662)         -- "You have failed the test!"
	end
end

-- "Challenge of Might"
Game.GlobalEvtLines:RemoveEvent(1304)
evt.global[1304] = function()
	if evt.Cmp("PlayerBits", 52) then
		evt.StatusText(1664)         -- "You have already won!"
	elseif evt.Cmp("CurrentMight", 200) then
		evt.Add("SkillPoints", 10)
		evt.StatusText(1668)         -- "You win!  +10 Skill Points"
		evt.Set("PlayerBits", 52)
	else
		evt.StatusText(1663)         -- "You have failed the challenge!"
	end
end

-- "Challenge of Endurance"
Game.GlobalEvtLines:RemoveEvent(1305)
evt.global[1305] = function()
	if evt.Cmp("PlayerBits", 53) then
		evt.StatusText(1664)         -- "You have already won!"
	elseif evt.Cmp("CurrentEndurance", 200) then
		evt.Add("SkillPoints", 10)
		evt.StatusText(1668)         -- "You win!  +10 Skill Points"
		evt.Set("PlayerBits", 53)
	else
		evt.StatusText(1663)         -- "You have failed the challenge!"
	end
end

-- "Challenge of Intellect"
Game.GlobalEvtLines:RemoveEvent(1306)
evt.global[1306] = function()
	if evt.Cmp("PlayerBits", 54) then
		evt.StatusText(1664)         -- "You have already won!"
	elseif evt.Cmp("CurrentIntellect", 200) then
		evt.Add("SkillPoints", 10)
		evt.StatusText(1668)         -- "You win!  +10 Skill Points"
		evt.Set("PlayerBits", 54)
	else
		evt.StatusText(1663)         -- "You have failed the challenge!"
	end
end

-- "Challenge of Personality"
Game.GlobalEvtLines:RemoveEvent(1307)
evt.global[1307] = function()
	if evt.Cmp("PlayerBits", 55) then
		evt.StatusText(1664)         -- "You have already won!"
	elseif evt.Cmp("CurrentPersonality", 200) then
		evt.Add("SkillPoints", 10)
		evt.StatusText(1668)         -- "You win!  +10 Skill Points"
		evt.Set("PlayerBits", 55)
	else
		evt.StatusText(1663)         -- "You have failed the challenge!"
	end
end

-- "Challenge of Accuracy"
Game.GlobalEvtLines:RemoveEvent(1308)
evt.global[1308] = function()
	if evt.Cmp("PlayerBits", 56) then
		evt.StatusText(1664)         -- "You have already won!"
	elseif evt.Cmp("CurrentAccuracy", 200) then
		evt.Add("SkillPoints", 10)
		evt.StatusText(1668)         -- "You win!  +10 Skill Points"
		evt.Set("PlayerBits", 56)
	else
		evt.StatusText(1663)         -- "You have failed the challenge!"
	end
end

-- "Challenge of Speed"
Game.GlobalEvtLines:RemoveEvent(1309)
evt.global[1309] = function()
	if evt.Cmp("PlayerBits", 57) then
		evt.StatusText(1664)         -- "You have already won!"
	elseif evt.Cmp("CurrentSpeed", 200) then
		evt.Add("SkillPoints", 10)
		evt.StatusText(1668)         -- "You win!  +10 Skill Points"
		evt.Set("PlayerBits", 57)
	else
		evt.StatusText(1663)         -- "You have failed the challenge!"
	end
end

-- "Challenge of Luck"
Game.GlobalEvtLines:RemoveEvent(1310)
evt.global[1310] = function()
	if evt.Cmp("PlayerBits", 58) then
		evt.StatusText(1664)         -- "You have already won!"
	elseif evt.Cmp("CurrentLuck", 200) then
		evt.Add("SkillPoints", 10)
		evt.StatusText(1668)         -- "You win!  +10 Skill Points"
		evt.Set("PlayerBits", 58)
	else
		evt.StatusText(1663)         -- "You have failed the challenge!"
	end
end

-- "Traitor!"
evt.CanShowTopic[1311] = function()
	return evt.Cmp("Inventory", 1518)         -- "Letter to Hairbaugh"
end

Game.GlobalEvtLines:RemoveEvent(1311)
evt.global[1311] = function()
	evt.SetMessage(1669)         -- "What!  You wouldn't believe this fabrication would you?  I would never dream of sabotaging your rule here!  Gaahh!  Prepare to die!"
	evt.SetMonGroupBit{NPCGroup = 84, Bit = const.MonsterBits.Invisible, On = true}         -- ""
	evt.SetMonGroupBit{NPCGroup = 85, Bit = const.MonsterBits.Invisible, On = false}         -- ""
end

-- "SAVE you Game!"
Game.GlobalEvtLines:RemoveEvent(1312)
evt.global[1312] = function()
	evt.SetMessage(1670)         -- "Because of the dangers that you are about to face, it would be a good idea to SAVE your Game.  If anything goes 'wrong', you can always reload your SAVED Game.  Just a word to the wise."
end

-- "Challenges"
Game.GlobalEvtLines:RemoveEvent(1313)
evt.global[1313] = function()
	evt.SetMessage(1671)         -- "Scattered around the land are the Challenges.  If your ability is great enough, and you best the challenge, you will be award skill points to do with as you wish!"
end

-- HARMONDALE TELEPORTAL HUB --

local indexes = {[0] = "A", "B", "C", "D", "E", "F"}
-- "Go back"
evt.global[1993] = function()
	for i = 0, 2 do
		Game.NPC[1255]["Event" .. indexes[i] ] = 1995 + i
	end
	Game.NPC[1255]["Event" .. indexes[3] ] = 1994
end

-- "More destinations"
evt.global[1994] = function()
	for i = 0, 1 do
		Game.NPC[1255]["Event" .. indexes[i] ] = 1998 + i
	end
	Game.NPC[1255]["Event" .. indexes[2] ] = 1993
	Game.NPC[1255]["Event" .. indexes[3] ] = 0
end

evt.CanShowTopic[1995] = function()
	return evt.All.Cmp("Inventory", 1467)
end

-- "Tatalia"
evt.global[1995] = function()
	evt.MoveToMap{X = 6604, Y = -8941, Z = 0, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "7Out13.odm"}
end

evt.CanShowTopic[1996] = function()
	return evt.All.Cmp("Inventory", 1469)
end

-- "Avlee"
evt.global[1996] = function()
	evt.MoveToMap{X = 14414, Y = 12615, Z = 0, Direction = 768, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "Out14.odm"}
end

evt.CanShowTopic[1997] = function()
	return evt.All.Cmp("Inventory", 1468)
end

-- "Deyja"
evt.global[1997] = function()
	evt.MoveToMap{X = 4586, Y = -12681, Z = 0, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "7Out05.odm"}
end

evt.CanShowTopic[1998] = function()
	return evt.All.Cmp("Inventory", 1471)
end

-- "Bracada Desert"
evt.global[1998] = function()
	evt.MoveToMap{X = 8832, Y = 18267, Z = 0, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "7Out06.odm"}
end

evt.CanShowTopic[1999] = function()
	return evt.All.Cmp("Inventory", 1470)
end

-- "Evenmorn Island"
evt.global[1999] = function()
	evt.MoveToMap{X = 17161, Y = -10827, Z = 0, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "Out09.odm"}
end

-- "We've found the Lost Scroll!"
evt.global[2000] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 1540) then         -- "Lost Scroll of Wonka"
		evt.SetMessage(2732)         -- "You must bring the Lost Scroll of Wonka to me to collect your reward."
		return
	end
	evt.SetMessage(2733)         --[[ "“Well I’ll be … ya found the Lost Scroll! <he he> I guess it’s not lost anymore, huh!  [smile]  Excuse me for a moment while I verify the authenticity.

Blayze retires to a back room.  In a few moments he begins an incantation in slow, guttural tones.

‘Oooompa … Looompa … Looompidi Dooo, I’ve got some arcane magic for you’.  Blayze repeats this phrase several times, increasing the intoning speed  with each utterance.  Building to a fever pitch, he commands  ‘Come forth ye Everlasting Gobstopper!  Come forth now!!!’

Blaze returns from the back room, chewing gum and popping bubbles, a broad smile on his face.  Yep, that’s it.  Well done adventurers!!  As promised, here’s your reward.”" ]]
	for _, pl in Party do
	local s, m = SplitSkill(pl.Skills[const.Skills.Fire])
	if s ~= 0 then
		pl.Skills[const.Skills.Fire] = JoinSkill(math.max(s, 8), math.max(m, const.Expert))
	end
end
	evt.ForPlayer("All")
	evt.Subtract("QBits", 784)         -- "Find the Lost Scroll of Wonka and return it to Blayze on Emerald Island."
	evt.Subtract("Inventory", 1540)         -- "Lost Scroll of Wonka"
	evt.Add("Awards", 129)         -- "Recovered the Lost Scroll of  Wonka"
	evt.SetNPCTopic{NPC = 478, Index = 1, Event = 0}         -- "Blayze "
	evt.Add("Experience", 40000)
end

-- "Promotion to Water Magic Master"
evt.global[2001] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 1361) then         -- "Watcher's Ring of Elemental Water"
		evt.SetMessage(2736)         -- "I see that you've returned with the Watcher's Ring of Elemental Water. Good!    Use the power of this ring wisely, my students in the pursuit of Truth, Justice, and the Erathian Way!  Now I can promote you to Master level  if  you are already an Expert  with a skill of at least '7'  and have been promoted in your chosen profession..  Oh, and my fee is 4000  gold.  Gotta make a living, you know."
		evt.Add("Experience", 30000)
		evt.SetNPCTopic{NPC = 483, Index = 0, Event = 343}         -- "Tobren Rainshield" : "Water Magic Master"
		return
	end
	if not evt.Cmp("Inventory", 1128) then         -- "Water Walk"
		evt.ForPlayer("Current")
		evt.Add("Inventory", 1128)         -- "Water Walk"
	end
	evt.SetMessage(2735)         -- "Before I can promote you to Master of Water Magic, you must prove yourself worthy.  Retrieve the Watcher's Ring of Elemental Water and return it to me.  The Ring is guarded by a powerful Sylph who lives on an island west of Spaward in the Bay of Avlee"
end

-- "The Greatest Hero"
evt.global[2002] = function()
	evt.StatusText(985)         --[[ "Sir BunGleau, Baron of Post Lost, was the greatest Hero in Erathia's history.  So great were his deeds and so noble his demeanor that the Saints of Selinas offered him a shiny panoply endowed with boons beyond measure.  But the humble knight refused their offer, remarking that he could not, in good conscience, wear such a flamboyant display of privilege.  So the Saints offered to enchant the armor with invisibility if he would but openly wear the gauntlets to signify their blessing upon him.  To this he agreed. 

When he retired, the Saints hid his armor and placed six scrolls about the countryside.  It is said that if the secret of these scrolls is unlocked, it will reveal the location of a map indicating where this treasure may be found.  " ]]
	evt.SetNPCGreeting{NPC = 1243, Greeting = 125}         -- "Messenger of the Saints" : "Greetings again, friends."
	evt.SetNPCTopic{NPC = 1243, Index = 0, Event = 801}         -- "Messenger of the Saints" : "Crusader"
end

