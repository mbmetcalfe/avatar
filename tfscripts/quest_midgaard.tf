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
/def -ag -Ph -F -t'luscious crab meat(.*)' h_midgaard_great_summoning_001 = /test $[echoGearItem({PL}, "luscious crab meat",  "quest", {P1})]
/def -ag -Ph -F -t'the mantle of the master arcanist(.*)' h_midgaard_great_summoning_002 = /test $[echoGearItem({PL}, "the mantle of the master arcanist",  "quest", {P1})]


/def -mregexp -p1 -t"^Flex Glitterwing says 'Go and ask him politely if he'd be kind enough to borrow it\. Come back wearing it and pray that you return in time\!'$" quest_summoning_001 = \
    /questinfo Summoning Quest: Need to wear the mantle of the master arcanist.@{n}

/def -mregexp -p1 -t"^Flex Glitterwing beckons you to follow him\.$" quest_summoning_002 = \
    /if ({autoquest} == 1) /repeat -00:00:05 1 /send follow flex%;\
    /else /questinfo Summoning Quest: follow flex%;\
    /endif

/def -mregexp -p1 -t"^Flex Glitterwing exclaims 'Just \.\.\. a \.\. bit \.\. morreee\!'$" quest_summoning_002 = \
    /if ({autoquest} == 1) /repeat -00:00:05 1 /send invoke%;\
    /else /questinfo Summoning Quest: invoke%;\
    /endif

;; -----------------------------------------------------------------------------
;;; Deepways Quests
;;; Wiki: http://avatar.melanarchy.info/index.php/Category:Deepways
;; -----------------------------------------------------------------------------
;; Lizard kspawn chain
/def -mregexp -t"A mated pair of cave lizards creep along the ceiling." deepways_mated_lizard_info = /test skinInfo("mated pair cave lizards", "a pair of cave lizard skins", "Jon (lizardskin belt)")
/def -mregexp -t"A pack of cave lizards are out hunting." deepways_pack_lizard_info = /test skinInfo("pack of lizards", "a stack of cave lizard skins", "Rojer (lizardskin jerkin)")
/def -mregexp -t"A solitary cave lizard tastes the air for danger." deepways_solitary_lizard_info = /test skinInfo("solitary cave lizard", "a cave lizard skin", "Alain (alain's papers)")

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

