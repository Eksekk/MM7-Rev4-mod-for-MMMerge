# MM7-Rev4-mod-for-MMMerge
A conversion of MM7 Rev4 mod for MMMerge with additional optional features

# Disclaimer
Currently the mod is targeted towards playing one party the entire time (not changing any members). If you try to mix and match players, you won't be able to get [free skills/promotions/class change] second time, only first time will work. Sorry. This is a major limitation and will change in the future.

# Changes from vanilla rev4
I added some new features, mainly intended to introduce some new content and balance a few things, as well as add few features that I always wanted to add.

To change settings, open Data/Tables/ModSettings.txt with Grayface's TxtEdit and modify whatever you'd like.

## Difficulty
The mod features difficulty levels! You can choose to have harder game if you'd like. Currently there are 3 levels - easy, medium and hard. Set difficulty before starting game or at any point with game turned off by changing line "Rev4ForMergeDifficulty" in ModSettings to 0 for easy, 1 for medium, or 2 for hard. (Note: due to extra map spawns depending on difficulty and getting performed at first map visit, it's best to decide one difficulty and maybe reduce it if you're having problems rather than constantly switch back and forth. Though, if you want to do this there's nothing and noone stopping you.)

Most difficulty elements (as well as my own additions to the game) can be overridden and disabled by ModSettings.txt, so you can fine-tune your experience. 

Easy will be mostly like vanilla (only with slightly increased mapstats spawns due to five players in party and other changes making game easier). At least, that is the intended result, now it's probably easier than vanilla rev4 (if we exclude carnage bows from the equation).

Medium introduces:
* less powerful free skill boosts. They make up some of the flavor of Rev4 for me, but the difficulty decrease is too high. Change Rev4ForMergeNerfSkillBoosts option to anything other than 1 to disable this.
* removing some of endgame items just lying on the ground or being in chest on starting maps. Also a part of flavor, see above. Change Rev4ForMergeRemoveFreeEndgameItems option to anything other than 1 to disable this.
* meditation SP regen is nerfed from mastery + floor(skill / 10) to mastery - 2 + floor(skill / 10) (mastery starts with Novice on 1, and then increases by 1), and only if you actually have at least master meditation. Change Rev4ForMergeNerfMeditationSPRegen option to anything other than 1 to disable this.
* all damage to monsters is decreased by 15% (set Rev4ForMergeNerfDamage option to anything other than 1 to disable it).
* Most MM7 outdoor maps have extra monster spawns, usually guarding most of currently free to explore locations. Note: some spawns are very difficult and are not intended to be fought right away. It's perfectly fine to just grab the loot and run away. Change Rev4ForMergeExtraMonsterSpawns option to anything other than 1 to disable.
* Most of gold gains (selling/gold piles/quest rewards/wells) is reduced to 75% of original value.
* Normal map spawnpoints spawn more monsters. You can lower the amount a bit by setting Rev4ForMergeSmallerMapstatsSpawnIncrease to 1 (but still more will spawn than on easy).
* You can hire only 3 NPCs at the same time instead of 4. To always allow 4, set Rev4ForMergeDecreaseMaxHiredNpcAmount to 0.

Hard introduces (see above how to disable specific changes):
* even less powerful free skill boosts.
* removing most of free endgame items. (Note that carnage bows need extra option to be replaced, it's Rev4ForMergeRemoveBowsOfCarnage. Set it to 0 to keep them, even if other items will be removed).
* meditation SP regen is completely removed.
* all damage to monsters decreased by 30%.
* extra monster spawns create more and stronger monsters than on Normal.
* Most of gold gains (selling/gold piles/quest rewards/wells) is reduced to 50% of original value.
* Normal map spawnpoints spawn even more monsters. See above about option to set smaller spawns.
* You can hire only 2 NPCs at the same time instead of 4.

Note: by default item removal function replaces them with appropriate-leveled item of same type, still a bit stronger than what you would find normally, but not endgame-leveled. If you wish to annihilate them completely instead, change Rev4ForMergeRandomizeRemovedItems to anything other than 1.

In addition, I added bosses to some game areas, which are just single stronger monsters than usual of their kind. They are here mainly to make debuff spells, such as slow, shrinking ray, dark grasp, useful. They are affected by difficulty, lower difficulty will cause some of their stats to be weaker. If you want to disable them, the option to set to 0 is Rev4ForMergeAddBosses.

To compensate for difficulty a bit and allow stronger overall builds than on easy, experience gained from monsters is increased by 15% on medium and by 30% on hard.

## Other balance-affecting changes
Note: currently this usually means that these changes just affect balance, **not necessarily** make things more balanced ;) I plan to fix this eventually.

**Item bonuses**:
* I added dark and light resistance item bonuses. They technically already worked, but nothing increased them. Hopefully clearing the Pit now won't be such headache :) Option to disable is Rev4ForMergeAddDarkLightResistances
* There's new numeric (+5/+10/+17 etc.) item bonus: resistance penetration (only for spell damage). It works exactly as you imagine, reducing effective monster resistance to given element by bonus amount (but no lower than 0). The reduction isn't party wide, every member can have different penetration values. If a monster is immune, resistance penetration will work as if he had base 200 resistance. To disable it, change Rev4ForMergeAddResistancePenetration to anything other than 1. Existing resistance penetration items won't disappear, but they won't work and game won't generate new ones. Note that all map loot (ground and chests) is generated when you first enter an area and then doesn't change unless respawn happens.
* There's new special bonus "of Permanence". It provides immunity from dispel magic, always for the character that wears such item, and for party-wide buffs the chance to resist is \[characters wearing item with the bonus\]/\[party size\]. To disable it, set Rev4ForMergeEnableDispelImmunityEnchantment to 0. (See note above about existing items).
* New spcbonus "Blessed <item name>" provides immunity to curses. Option to disable is Rev4ForMergeEnableCurseImmunityEnchantment.
* Mana and hit points regeneration items now stack linearly, with each item providing larger bonus and including previous bonuses (they are +1 regen/+2 regen/+3 regen etc.) This makes them much more useful, especially if you use higher difficulty (less meditation regen). Set Rev4ForMergeManaHealthRegenStacking to anything other than 1 to disable.
* "of Doom" enchantment now gives three times the bonus it was assigned. Hopefully this will sometimes make player consider using it rather than always selling like I did. ModSettings option to disable: Rev4ForMergeMiscBalanceChanges.
* "of the Gods" now gives +25 to all stats. Option to disable as above.
* Heroism, Bless and Stoneskin potions have been buffed. Now instead of 5 effect they provide 5 + ceil(power / 3). Hopefully this will make them more usable.

**Spells**:
* Spells damage is slightly increased. This is done mainly because Rev4 boosted weapon users with higher base damage and higher armsmaster levels, but changing spell damage was probably too difficult at this time and they were boosted by adding guaranteed 4 elemental magic rings. ModSettings option to disable is Rev4ForMergeChangeSpellDamage.
* Resistances are buffed from 1/2/3/4 per skill to 5 + 2/3/4/5 per skill. Hopefully this will make them usable even before you have expert and not fall off in the endgame. (Day of protection is not boosted currently).
* Most buff spells and Enchant Item have reduced recovery values if you're out of combat (enemy detector is green). This is mainly a QoL feature to allow quickly buffing up before fight. Set Rev4ForMergeReduceBuffsRecoveryOutOfCombat to 0 to disable.
* Similar to the above, regeneration can be cast on all party members with ctrl-click, and fire aura can be cast on all characters' equipped weapon type with ctrl-click. Mana cost and recovery will be adjusted appropriately.
* Spell effect (damage & healing) is slightly increased by intellect and personality (exact formula is: every 10 points in sum of those stats adds 1% effect). Set Rev4ForMergeIntellectPersonalityIncreaseSpellEffect to 0 to disable.
* Assorted spell changes disableable by Rev4ForMergeMiscSpellChanges:
    * Some spells are also buffed. Stoneskin now gives 5 + 2 AC points per skill. Hopefully it will be more enticing to use now.
    * Paralyze duration is nerfed from 3min/skill to 1min/skill.
    * Cure weakness at GM affects entire party. Now if you don't want to use Hour of Power for whatever reason, keeping haste up won't be too big annoyance.
    * Remove fear also cures entire party at GM.
* Shared life overflow is fixed. Now HP which gets wasted in vanilla (because you had one character or more with very low HP and one or more with very big) will be redistributed back to characters that need it. To disable, set Rev4ForMergeFixSharedLifeOverflow to 0.
* I changed how healing spells work, or rather, given healing to some other spells. Full list will be added soon.
    * Resurrection is special:
        * no weakness on cast
        * death is cured unconditionally (useful if you cast it on death only)
        * lower recovery (by 85%) - 150 instead of 1000
        * higher cost (by 166%) if character is in good condition (not dead and not eradicated) - 80 instead of 30
        * restores hefty amount of hit points
    Intended use is as a big, expensive "combat heal" or plain status cure with lower spell cost.

**Skills**
* Identify monster is completely remade in this mod. Not only you can always see full info, even on novice (if you have the skill), you also have increased chance per skill point to be able to. I changed that because ID monster being possibly useful only on GM annoyed me. Also, the highest skill level will be shared, so character with 1 skill or even without will still be able to identify if there's someone in party with enough skill level (or GM, which makes ID always work). You'll also be able to see reduced resistances (only for the identifying character!), if you enable resistance penetration, and skill/mastery of spells the monster casts. But the main selling point is, you'll now be able to perform critical hits by having ID monster! The chance is fixed and depends on mastery, and damage bonus depends on skill, mastery, and skill bonus (+IDMonster items). Note that in this case skill sharing (taking into account the highest among party) won't work, because it would obviously be OP (I don't know if it isn't OP already, will check that in the playthrough). So, now you have a reason to pursue ID monster on all characters! Obviously, this can be disabled with Rev4ForMergeRemakeIdentifyMonster option (put anything different than 1). ID monster mechanics will be as in vanilla, with few small differences: skill level and mastery will still be shared, extended spell info will be displayed and, if you enabled them, reduced resistances as well.
* Base alchemy skill is boosted to add 2 * skill to potion strength. Item/NPC bonuses are still counted * 1. This is done to make investing in alchemy skill more useful (mastery alone is useful already). To disable, change Rev4ForMergeBoostBaseAlchemySkill to 0.
* GM masteries are restricted to second promotion only, and M to first or second. That means before any promotion the max mastery you can learn will usually be Expert. To disable, set Rev4ForMergeRestrictMasteries to 0.
* GM leather now gives skill * 4 elemental resistances. That hopefully will make GM actually worth getting. Option to disable as above. Option to disable is Rev4ForMergeMiscBalanceChanges.
* Perception now gives you a chance to completely avoid being affected by monster bonuses (only for the character that has the skill). Chance increases both with skill and mastery. Some example chances: 1 Novice = 5.5%, 4 Expert = 22%, 7 Master = 41.86%, 10 Grandmaster = 64.33%, 19 Grandmaster = 98.68%. Skill bonuses are factored in, but only as if they were on Novice. To disable, set Rev4ForMergeBoostPerception to 0.

**Monsters**
* DrainSP effect is nerfed in this mod, I found it too obnoxious. Now it reduces your mana by 25% of maximum each time it is applied, not less than zero, instead of zeroing it completely. The option to disable it is Rev4ForMergeNerfDrainSp.
* You can remove multilooting "bug". To do so, set Rev4ForMergeRemoveMultilooting to 1.
* Anti-frustration option: monster stealing is removed. It's just too annoying bonus, because you can lose anything, it's not too bad if you lose some random item you found which would get sold anyways, but most players keep some items in inventory constantly (for swapping or books to learn later) and losing those is just rough, especially that you don't know what exactly was stolen unless you remember every item from your inventory. The end result for me was that I needed to reload every time I noticed "monster bonus applied" animation when near thieves. Of course, monster stats will be slightly boosted to compensate for the change. If you wish to keep stealing and old stats, set Rev4ForMergeRemoveMonsterStealing to 0.

**Misc**
* Evenmorn Island has respawn time as in vanilla. The reason is respawn every time is very, very annoying and abuse-prone (you can just grab the outdoor chests unlimited amount of times and there's even one genie lamp which could provide unlimited skillpoints, not counting monster experience). For now it's always vanilla respawn time, non-switchable (I will probably add option to change it later). I also assume BDJ might have decided that because one final battle happens there and he might want it to be always available to fight in. I might change that the instant respawn happens only after you are ready for that battle.
* Stat breakpoint rewards are increased in this mod. Now it's much more worth it to pump stats, and artifacts like "+100 might" might actually be useful. Of course, if this option is enabled, Day of the Gods is nerfed. Still will be useful though. Change Rev4ForMergeChangeStatisticBreakpoints to anything other than 1 to disable.
* Free skill boosts/quests now refund skill points you've invested in the skill which could have been given for free. No more problems due to forgetting to not invest in a skill right now! If you want to turn it off, there's option Rev4ForMergeRefundSkillpoints, set it to anything other than 1.

## Other changes
* Genie lamps have default behavior from MM7 in this mod. I found out that randomizing it meant, for me personally, that I need to savescum for skill points. Other rewards were just not interesting enough. If you prefer Merge behavior, change option "UseOriginalGenieLamps" to something other than 1.
* Some dungeons are duplicated (Tularean Caves, Clanker's Lab, Wromthrax's Cave, Dragon Caves in Eofol). That is, the dungeon is used normally as in Rev4, and clicking on the door/entrance of these dungeons (which usually gives message like "it's blocked") will move you into vanilla Merge version of dungeon. They are the main vessel I base my custom quests on, due to (until recently) lack of 3D modeling skills and (still effective) low creativity.

## Quests
I added five new quests:
* for attaining grandmastery in dark magic (even for clerics!) and possibility to become a lich, given by NPC in the Pit in the later stages of the game.
* I won't spoil another, I will only say it is given by NPC in Tularean Forest and intended for midgame.
* There's also one requiring duplicated dungeons (more info below) to be enabled. You can guess what that means. It's intended for lategame, even at the level of killing Xenofex. You'll probably be able to experience an epic battle like the one already included in base Rev4 (and without severe annoyances like dispel magic or drainSP, unless I will add item bonuses protecting from them)
* The fourth quest also requires duplicated dungeons, and is given in Nighon. Intended for midgame-lategame.
* The fifth quest again requires duplicating dungeons and is given in Harmondale. Intended for midgame.

# Changes from vanilla Merge/Revamp
* Ghost Ring and Faerie Ring now only give +50% bonus instead of 100%. That was definitely too OP.

# Some notes
* Disarm trap expert only learnable in Erathian Sewers only applies to Antagarich RN, but I might change it in the future (it's easy to do), the same situation is with fire expert and master elemental magics (on Antagarich most require completing quest first, on other continents they don't).
* Currently class changing feature supports all classes. Contrary to Rev4 mod, requirements have been relaxed and you'll be able to change class even if not fully promoted or not promoted at all. Note that there is limitation that you'll be able to change classes only with one set of PCs (the one you complete The Gauntlet with).
* Like above, currently custom Rev4 skill barrels and other enhancing events provide effect only once, to the party you are currently having, so you can't dismiss somebody, hire someone else and use the boost again. I may change it at a future date.
* This mod incorporates some optional fixes from GrayFace's patch, namely fixes Bracada teleporters so instead of two teleporting to temple one teleports to shops. Also dock teleporter is fixed to teleport on the ground so you don't take fall damage upon moving forward.
* Since Rev4 uses some item graphics&descriptions from MM8/MM6, when using it in Merge some items would be duplicated. I opted for restoring original MM7 look&description in such cases.
* Harmondale Teleportal Hub is made modern and less cumbersome to use. Now it might be faster to actually use the hub than stables, because it doesn't anymore require key juggling to get to desired location - you can select it directly.

# Credits
* **cthscr** (helping me in various issues)
* CognitiveDesign (helping me in various issues)
* GrayFace (helping me in various issues). This mod also makes heavy use of various tools for MM6-8 modding made by Grayface (especially scripting).
* kromz (playtesting and bug hunting)
* some ideas <del>stolen from</del> inspired by [Elemental Mod for MM7](https://www.celestialheavens.com/forum/10/17167), [MM7 Reimagined](https://www.celestialheavens.com/forum/10/17225), [MM7 Refilled for the Merge](https://www.celestialheavens.com/forum/10/17218) and [MAW mod for MM6](https://www.celestialheavens.com/forum/10/17617)

Big thank you to everyone on this list, without you this mod couldn't be created!