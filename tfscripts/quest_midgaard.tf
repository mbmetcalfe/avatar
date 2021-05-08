;; -----------------------------------------------------------------------------
;;; quest_midgaard.tf
;;; This script will contain some helpful triggers/macroes to automate some of
;;; the quests in Midgaard
;; -----------------------------------------------------------------------------

;; -----------------------------------------------------------------------------
;;; The Great Summoning Quest
;;; Wiki: http://avatar.melanarchy.info/index.php/Great_Summoning_Quest
;;; Google doc: https://docs.google.com/document/d/1upv2WNslMGqTl_BCuKaNwON-aiTOguAiFeJ9U6ztqsc/edit#heading=h.vi78dj9eafsx
;; -----------------------------------------------------------------------------
/def checklistSummoning = \
    /echo -pw @{Cwhite}-----------------------------------------------------------------------------%;\
    /echo -pw @{Cred}The Great Summoning quest checklist:%;\
    /echo -pw @{Cyellow}  1. Whale Whisper%;\
    /echo -pw @{Cyellow}  2. a green book%;\
    /echo -pw @{Cyellow}  3. iron blade%;\
    /echo -pw @{Cyellow}  4. toxic gland%;\
    /echo -pw @{Cyellow}  5. a sprite ribcage%;\
    /echo -pw @{Cyellow}  6. luscious crab meat%;\
    /echo -pw @{Cyellow}  7. Necromancer's Claw%;\
    /echo -pw @{Cyellow}  8. the mantle of the master arcanist%;\
    /echo -pw @{Cyellow}  9. As many dragon items worn as you can find: %;\
    /echo -pw @{Cyellow}     dragonscale skirt, dragonscale sleeves, ice scale bracers, %;\
    /echo -pw @{Cyellow}     tiamat mask, golden dragonscale boots, a golden dragonscale torso.%;\
    /echo -pw @{Cwhite}-----------------------------------------------------------------------------@{n}

;;; Log quest tickets for Sanctuary insig
/def -ag -Ph -F -t'luscious crab meat(.*)' h_midgaard_great_summoning_001 = /test $[echoGearItem({PL}, "luscious crab meat",  "quest", {P1}, {PR})]
/def -ag -Ph -F -t'the mantle of the master arcanist(.*)' h_midgaard_great_summoning_002 = /test $[echoGearItem({PL}, "the mantle of the master arcanist",  "quest", {P1}, {PR})]

;;; Sem Vida
;/def -ag -Ph -F -t"a bit of dimly glowing essence(.*)" h_midgaard_sem_vida_001 = /test $[echoGearItem({PL}, "a bit of dimly glowing essence",  "token-exp", strcat({P1}, " (+30 hp -5ac OR +30 mana +3 hr/dr)"), {PR})]


/def -mregexp -au -p1 -t"^Flex Glitterwing says 'Go and ask him politely if he'd be kind enough to borrow it\. Come back wearing it and pray that you return in time\!'$" quest_summoning_001 = \
    /questinfo Summoning Quest: Need to wear the mantle of the master arcanist. If already wearing it, might have to leave/come back to room.

/def -mregexp -au -p1 -t"^Flex Glitterwing beckons you to follow him\.$" quest_summoning_003 = \
  /if ({autoquest} == 1) /repeat -00:00:05 1 /send follow flex%;\
  /else /questinfo Summoning Quest: follow flex%;\
  /endif

/def -mregexp -au -p1 -t"^Flex Glitterwing exclaims 'Just \.\.\. a \.\. bit \.\. morreee\!'$" quest_summoning_004 = \
  /if ({autoquest} == 1) \
    /repeat -00:00:05 1 /send invoke%;\
    /autoquest%;\
  /else /questinfo Summoning Quest: invoke%;\
  /endif

;; Green Dragon: 3en
;; Give item: toxic gland
/def -mregexp -au -p1 -t"^Azlaroc says 'Once I get that gland...'" quest_summoning_005 = \
  /if ({autoquest} == 1) /repeat -00:00:05 1 /send up%;\
  /else /questinfo Summoning Quest: up%;\
  /endif
/def -mregexp -au -p1 -t"^Fortunately, while he is preoccupied, he doesn't notice you\." quest_summoning_006 =\
  /if ({autoquest} == 1) /repeat -00:00:05 1 /send give gland azlaroc%;\
  /else /questinfo Summoning Quest:give gland azlaroc%;\
  /endif
/def -mregexp -au -p1 -t"^Finally set, he turns to you\." quest_summoning_007 =\
  /if ({autoquest} == 1) /send down%;\
  /else /questinfo Summoning Quest: down%;\
  /endif

;; Black Dragon: 8e3sw
;; Wear and give item: sprite ribcage
/def -mregexp -au -p1 -t"^Ramahdon yells 'As if the master of the Black Circle would perish from starvation atop a stone shaft. Don't waste my time\.'" quest_summoning_008 = \
  /if ({autoquest} == 1) /repeat -00:00:05 1 /send wear sprite=up%;\
  /else /questinfo Summoning Quest: wear sprite, up%;\
  /endif
/def -mregexp -au -p1 -t"^The Black Dragon Kahbyss says 'You are allowed to present your gift to me now. Delay and suffer the consequences\.'" quest_summoning_009 = \
  /if ({autoquest} == 1) /repeat -00:00:05 1 /send rem sprite=give sprite kahbyss%;\
  /else /questinfo Summoning Quest: rem sprite, give sprite kahbyss%;\
  /endif
/def -mregexp -au -p1 -t"^Kahbyss yells 'Can we end this soon\? I need to be elsewhere\!'" quest_summoning_010 = \
  /if ({autoquest} == 1) /send down%;\
  /else /questinfo Summoning Quest: down%;\
  /endif

;; Blue Dragon: 2ese2s
;; Give item: crab meat
/def -mregexp -au -p1 -t"^Gil\-Rillion says 'So\, come on up\, hero\, I require your assistance\.'" quest_summoning_011 = \
  /if ({autoquest} == 1) /repeat -00:00:05 1 /send up%;\
  /else /questinfo Summoning Quest: up%;\
  /endif
/def -mregexp -au -p1 -t"^The Blue Dragon Gil\-Rillion waves goodbye to you. Have a good journey\." quest_summoning_012 = \
  /if ({autoquest} == 1) /repeat -00:00:05 1 /send give crab gil-rillion%;\
  /else /questinfo Summoning Quest: give crab gil-rillion%;\
  /endif
/def -mregexp -au -p1 -t"^You hear some roaring that resembles screaming from a distant blackened shaft\." quest_summoning_013 = \
  /if ({autoquest} == 1) /send down%;\
  /else /questinfo Summoning Quest: down%;\
  /endif

;; Copper Dragon: 2es
;; Give item: iron blade
/def -mregexp -au -p1 -t"^Seraf yells 'Yeah\, yeah\.'" quest_summoning_014 = \
  /if ({autoquest} == 1) /repeat -00:00:05 1 /send up%;\
  /else /questinfo Summoning Quest: up%;\
  /endif
/def -mregexp -au -p1 -t"^The Copper Dragon Verdigris says 'Smart\, observant and willing\. All the traits I require\. Go\, and live to tell the tale\.'" quest_summoning_015 = \
  /if ({autoquest} == 1) /repeat -00:00:05 1 /send give blade verdigris%;\
  /else /questinfo Summoning Quest: give blade verdigris%;\
  /endif
/def -mregexp -au -p1 -t"^Verdigris yells 'Seraf, you breen\, I figured how to make my golems regenerate! Let's proceed with the ritual so I can get to it\.'" quest_summoning_016 = \
  /if ({autoquest} == 1) /repeat -00:00:05 1 /send down%;\
  /else /questinfo Summoning Quest: down%;\
  /endif

;; Gold Dragon: 3e2n2e
;; Wear items: Dragonscale skirt/sleeves
/def -mregexp -au -p1 -t"^Gil\-Rillion yells 'You're a tough dragon to please, Ramahdon\.'" quest_summoning_017 = \
  /if ({autoquest} == 1) /repeat -00:00:05 1 /send wear “heroic dragonscale dragon scale skirt”=wear “heroic dragonscale sleeves dragon scales”=up%;\
  /else /questinfo Summoning Quest: wear “heroic dragonscale dragon scale skirt”, wear “heroic dragonscale sleeves dragon scales”, up%;\
  /endif
/def -mregexp -au -p1 -t"^The Gold Dragon Ramahdon says 'Leave this place and do not come back if you value it\.'" quest_summoning_018 = \
  /if ({autoquest} == 1) /send down%;\
  /else /questinfo Summoning Quest: down%;\
  /endif

;; Silver Dragon: 4e2se2s
;; Wield/give Necromancer's claw
/def -mregexp -au -p1 -t"^Verdigris yells 'I don't know, Rauhn\. I'm betting there are all sorts of dubious claws lying around\.'" quest_summoning_019 = \
  /if ({autoquest} == 1) /repeat -00:00:05 1 /send wield necromancer=up%;\
  /else /questinfo Summoning Quest: wield necromancer, up%;\
  /endif
/def -mregexp -au -p1 -t"^The Silver Dragon Rauhn exclaims 'Give me the claw, or else\!'" quest_summoning_020 = \
  /if ({autoquest} == 1) /repeat -00:00:05 1 /send rem necromancer=give necromancer rauhn%;\
  /else /questinfo Summoning Quest: rem necromancer, give necromancer rauhn%;\
  /endif
/def -mregexp -au -p1 -t"^The Silver Dragon Rauhn thanks you heartily\." quest_summoning_021 = \
  /if ({autoquest} == 1) /send down%;\
  /else /questinfo Summoning Quest: down%;\
  /endif

;; Brass Dragon; 8es
;; Give item: green book
/def -mregexp -au -p1 -t"^Nehemiah sits down and thinks deeply." quest_summoning_022 = \
  /if ({autoquest} == 1) /repeat -00:00:05 1 /send up%;\
  /else /questinfo Summoning Quest: up%;\
  /endif
/def -mregexp -au -p1 -t"^The Brass Dragon Nehemiah exclaims 'Go\!'" quest_summoning_023 = \
  /if ({autoquest} == 1) /repeat -00:00:05 1 /send give book nehemiah%;\
  /else /questinfo Summoning Quest: give book nehemiah%;\
  /endif
/def -mregexp -au -p1 -t"^The Brass Dragon Nehemiah thanks you heartily\." quest_summoning_024 = \
  /if ({autoquest} == 1) /send down%;\
  /else /questinfo Summoning Quest: down%;\
  /endif

;; White Dragon: en6e
;; Wear and give item: Whale whisper
/def -mregexp -au -p1 -t"^Seraf screams so loudly you decide to walk away\. Fast\." quest_summoning_025 = \
  /if ({autoquest} == 1) /repeat -00:00:05 1 /send whisper=up%;\
  /else /questinfo Summoning Quest: wear whisper, up%;\
  /endif
/def -mregexp -au -p1 -t"^The White Dragon Seraf exclaims\ 'Give me the spear\, I want to lay my eyes on it and feast upon the Stormkeep's demise\!'" quest_summoning_026 = \
  /if ({autoquest} == 1) /repeat -00:00:05 1 /send remove whisper=give whisper seraf%;\
  /else /questinfo Summoning Quest: remove whisper, give whisper seraf%;\
  /endif
/def -mregexp -au -p1 -t"^Seraf yells 'I have an invasion to lead and a certain dragon to skin\! Let's get this over with\, immediately\!'" quest_summoning_027 = \
  /if ({autoquest} == 1) /send down%;\
  /else /questinfo Summoning Quest: down%;\
  /endif


;; -----------------------------------------------------------------------------
;;; Deepways Quests
;;; Wiki: http://avatar.melanarchy.info/index.php/Category:Deepways
;; -----------------------------------------------------------------------------
;; Lizard kspawn chain
/def -mregexp -t"A mated pair of cave lizards creep along the ceiling." deepways_mated_lizard_info = \
    /test skinInfo("mated pair cave lizards", "a pair of cave lizard skins", "Jon (lizardskin belt)")%;\
    /if ({autoquest} == 1 & regmatch({myclass},"arc fus")) skco%;/endif
/def -mregexp -t"A pack of cave lizards are out hunting." deepways_pack_lizard_info = \
    /test skinInfo("pack of lizards", "a stack of cave lizard skins", "Rojer (lizardskin jerkin)")%;\
    /if ({autoquest} == 1 & regmatch({myclass},"arc fus")) skco%;/endif
/def -mregexp -t"A solitary cave lizard tastes the air for danger." deepways_solitary_lizard_info = \
    /test skinInfo("solitary cave lizard", "a cave lizard skin", "Alain (alain's papers)")%;\
    /if ({autoquest} == 1 & regmatch({myclass},"arc fus")) skco%;/endif

/def -mglob -t"A lizard hunter is hunting lizards." deepways_alain_info = \
    /questinfo Alain: Give him a cave lizard skin to get alain's papers.  Kill him to spawn Jon.%;\
    /if ({autoquest} == 1) /send give "stack cave lizard" alain%;/endif
/def -mglob -t"A hunter checks his traps for lizards." deepways_jon_info = \
    /questinfo Jon: Give him a pair of cave lizard skins to get a lizardskin belt.  Kill him to spawn Rojer.%;\
    /if ({autoquest} == 1) /send give "pair cave lizard skins" jon%;/endif%;\
/def -mglob -t"A hunter checks for signs of lizard spoor."  deepways_rojer_info = \
    /questinfo Rojer: Give him a stack of cave lizard skins to get a lizardskin jerkin.  Kill him to allow Alain to repop?%;\
    /if ({autoquest} == 1) /send give "cave lizard skin" rojer%;/endif

;; Darklin kspawn chain for darklinscale lamellar
/def -mregexp -t"A wave of darklins come skittering towards you." deepways_wave_darklin_info = /questinfo Kill the Wave of Darklins to spawns a Swarm of Darklins (darklinscale lamellar quest)
/def -mregexp -t"A swarm of darklins scurry through the caves." deepways_swarm_darklin_info = /questinfo Kill the Swarm of Darklins to spawns a Plague of Darklins (darklinscale lamellar quest)
/def -mregexp -t"A plague of darklins are here to deliver judgement." deepways_plague_darklin_info = /test skinInfo("plague of darklins", "darklinscale lamellar")
/def -mglob -p99 -F -t"A plague of darklins is DEAD!!" deepways_plague_darklin_dead_info = /test skinInfo("plague of darklins", "darklinscale lamellar")

;; Spider kspawn chain for crystal wristguard
/def -mglob -t"A giant black spider creeps along the wall." deepways_giant_spider_info = /questinfo Spawns monstrous wolf spider (crystal wristguard quest)
/def -mglob -t"A gigantic hairy spider stalks its prey - which could be you!" deepways_gigantic_spider_info = /questinfo Spawnshuge crystal spider (crystal wristguard quest)
/def -mglob -t"An enormous crystal spider is out hunting." deepways_enourmous_spider_info = /test skinInfo("huge crystal spider", "crystal wristguard")
/def -mglob -p99 -F -t"A huge crystal spider is DEAD!!" deepways_plague_crystal_spider_dead_info = /test skinInfo("huge crystal spider", "crystal wristguard")

;; Gnome kspawn chain for cat's eye gemstone
/def -mglob -t"A team of deep gnomes explore the deepways for riches." deepways_dgn_exploration_team_info = /questinfo Spawns Deep Gnome Excavation Team (Cat's Eye Gemstone)
/def -mglob -p99 -F -t"A deep gnome exploration team is DEAD!!" deepways_dgn_exploration_team_dead_info = /questinfo Spawns Deep Gnome Excavation Team (Cat's Eye Gemstone)
/def -mglob -t"A team of deep gnomes head off to begin excavating." deepways_dgn_excavation_team_info = /questinfo Spawns Deep Gnome Recovery (Cat's Eye Gemstone)
/def -mglob -p99 -F -t"A deep gnome excavation team is DEAD!!" deepways_dgn_excavation_team_dead_info = /questinfo Spawns Deep Gnome Recovery (Cat's Eye Gemstone)
/def -mglob -t"A team of deep gnomes are hauling their wealth home." deepways_dgn_recovery_team_info = /questinfo Drops a Cat's Eye Gemstone
/def -mglob -p99 -F -t"The survivors flee, but in their panic they leave something behind." deepways_dgn_recovery_dead_team_info = /if ({autoloot} == 1) /send get "gemstone catseye cats eye"%;/endif

;; Bat kspawn chains for Batwing Cape
/def -mglob -t"A flock of bats flap madly around your head!" deepways_vamp_flock_info = /questinfo Spawns Cloud Of Vampire Bats (Batwing Cape)
/def -mglob -t"A cloud of bats makes it difficult to see." deepways_vamp_cloud_info = /questinfo Spawns Thirst Of Vampire Bats (Batwing Cape)
/def -mglob -t"A thirst of vampire bats want to drink your blood!" deepways_vamp_thirst_info = /test skinInfo("thirst of vampire bats", "Batwing Cape")
/def -mglob -p99 -F -t"A thirst of vampire bats is DEAD!!" deepways_plague_crystal_spider_dead_info = /test skinInfo("thirst of vampire bats", "Batwing Cape")

;; Orphanage Quest
/def -mglob -p5 -ah -t"An orphan holds something that OBVIOUSLY doesn't belong to them." quest_orphanage_tickle_rascal = \
    /if ({autoquest} == 1) /send tickle rascal=tickle rascal=tickle rascal%;\
    /else /questinfo Tickle that rascale!!%;/endif


;; Bane Chromatic Dragon Quest
/def -mglob -p5 -ah -t"The High Priest of Quixoltan says 'May Quixoltan judge you worthy.'" quest_bane_autoloot_on = /send config +autoloot

;; Paladin related quests
;; As Arcanthra falls to the ground, a piece of paper drops from her fist.
;; note to give to Torrak for healing bonus on weapon.
;; Take note to Torrak and he'll get you to return to divide to kill Crullius
/def -mglob -p5 -ah -t"As Arcanthra falls to the ground, a piece of paper drops from her fist." quest_pal_torrak = /send get paper
