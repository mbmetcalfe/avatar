;;; ----------------------------------------------------------------------------
;;; loot.tf
;;; Auto-loot corpses
;;; ----------------------------------------------------------------------------

/set autoloot=1
/set autolkb=0

/def autoloot = /toggle autoloot %; \
	/let msg=% @{Ccyan}Autoloot is %; \
	/if ({autoloot} = 1) \
		/echo -p %msg @{Cgreen}ON@{Ccyan}.@{n} %; \
	/else \
		/echo -p %msg @{Cred}OFF@{Ccyan}.@{n} %; \
	/endif
/def autolkb = /toggle autolkb %; \
    /let msg=% @{Ccyan}Autoloot Lockboxes is %; \
    /if ({autolkb} = 1) \
        /echo -p %msg @{Cgreen}ON@{Ccyan}.@{n} %; \
    /else \
        /echo -p %msg @{Cred}OFF@{Ccyan}.@{n} %; \
    /endif

/def lootcor = \
	/if ({autoloot} = 1) \
		get %1 corpse %; \
		put %1 %lootContainer %; \
	/endif

;;; Auto-loot triggers	
;Loot corpse with fletch kits
/def -mregexp -t'^An archer is DEAD!!' lootarchercor = \
	/if ({myclass} =~ "arc"| {myclass} =~ "fus" | {myclass} =~ "asn" | {myclass} =~ "dru") \
		/lootcor kit %; \
	/endif
/def -mregexp -t'^Creela is DEAD!!' lootcreelacor = \
        /if ({myclass} =~ "arc"| {myclass} =~ "fus" | {myclass} =~ "asn" | {myclass} =~ "dru") \
		/lootcor kit %; \
	/endif

;; Weapon collecting triggers
;/def -mglob -t"A lieutenant is DEAD!!" gear_wpn_lie = /lootcor spear
;/def -mglob -t"General Rusla is DEAD!!" gear_wpn_rus = /lootcor spear
;/def -mglob -t"Crullius the white is DEAD!!" gear_wpn_crul = /lootcor dagger
/def -mglob -t"Killl'gher is DEAD!!" gear_wpn_killl = /lootcor claw
/def -mglob -t"Robber Barron is DEAD!!" gear_wpn_rob = /lootcor sword %; /lootcor bracer
/def -mglob -t"Ral*DEAD!!" gear_wpn_ral = /lootcor maelstrom
/def -mglob -t"Sword of Avengers is DEAD!!" gear_wpn_avenger = /lootcor avenger
;/def -mglob -t"The Frozen Demon Tourach is DEAD!!" gear_wpn_tourach = /lootcor tourach
;/def -mglob -t"Emperor's Peacekeeper is DEAD!!" gear_wpn_hsoj = /lootcor justice
/def -mglob -t"Kheffin is DEAD!!" gear_wpn_kheffin = /lootcor blade
/def -mglob -t"Kalimindroph is DEAD!!" gear_wpn_kali = /lootcor aranor
;/def -mglob -t"Statue of the Red Archer is DEAD!!" gear_wpn_redarcher = /lootcor bow
/def -mglob -t"The Robber Baron is DEAD!!" gear_wpn_robbbaron = /lootcor baron%;/lootcor bracer
/def -mglob -t"The Priestess Queen is DEAD!!" gear_wpn_priestsqueen = /lootcor moonlight
;/def -mglob -t"A Veiled guardian is DEAD!!" gear_wpn_veiledguardian = /lootcor sickle
/def -p1 -mglob -t'Queen Hcuyj is DEAD!' gear_wpn_queenhcuyj = /lootcor sceptre
/def -p1 -mglob -t"Regead the mage-priest is DEAD!!" gear_wpn_regead = /lootcor cordial
/def -mglob -t"A Naam'Sa warrior is DEAD!!" gear_wpn_naam_war = /lootcor spear
;/def -mglob -t'A masked rhinoceros rider is DEAD!!' gear_wpn_mask_rhino = /lootcor chakram
;/def -mglob -t'A masked psionicist rider is DEAD!!' gear_wpn_mask_psi = /lootcor chakram
/def -mglob -t"The Giants' Nightmare is DEAD!!" gear_wpn_giant_nightmaer = /lootcor david
;/def -mglob -t"A deep gnome mercenary is DEAD!!" gear_wpn_gnome_mercenary = /lootcor dagger


;; AC collecting triggers
/def -mglob -t"Aruna is DEAD!!" gear_ac_arun = /lootcor necklace
;/def -mglob -t"Arcanthra the Black is DEAD!!" gear_ac_arcan = /lootcor rune%;/lootcor stone
;/def -mglob -t"Blackhand, master-at-arms is DEAD!!" gear_ac_black = /lootcor rune
;/def -mglob -t"Grantus, dwarven military strategist is DEAD!!" gear_ac_grant = /lootcor rune
/def -mglob -t"Gunther the Knight is DEAD!!" gear_ac_gunth = /lootcor ring
/def -mglob -t"Carrion Crawler is DEAD!!" gear_ac_carr = /lootcor ring
/def -mglob -t"Sad man is DEAD!!" gear_ac_sad = /lootcor helm
/def -mglob -t"Nigurathus is DEAD!!" gear_ac_nig = /lootcor scale
/def -mglob -t"Jackal is DEAD!!" gear_ac_jack = /lootcor carb
/def -mglob -t"Panther is DEAD!!" gear_ac_path = /lootcor carb
;/def -mglob -t"The Cultist of Ecstasy is DEAD!!" gear_ac_cult3 = /lootcor gauntlet
;/def -mglob -t"A neonate Ecstasy Cultist is DEAD!!" gear_ac_cult4 = /lootcor gauntlet
;/def -mglob -t"Cultist is DEAD!!" gear_ac_cult = /lootcor gauntlet
;/def -mglob -t'An Ecstasy Cult member is DEAD!!' gear_ac_cult2 = /lootcor gauntlet
/def -mglob -t"Paladins ghost is DEAD!!" gear_ac_pala = /lootcor shield
;/def -mglob -t"Stoic guard is DEAD!!" gear_ac_stoic = /lootcor all.wrist %; /lootcor sword
/def -mglob -t"An Antharian Knight is DEAD!!" gear_ac_anthkni = /lootcor ring
/def -mglob -t"The Beast LeMans is DEAD!!" gear_ac_leman = /lootcor seal
/def -mglob -t"The paladin's ghost is DEAD!!" gear_ac_paladin = /lootcor shield
/def -mglob -t"Shogun Senjisama is DEAD!!" gear_ac_shogun = \
    /if ({autoloot} = 1) /send get bag corpse%;/endif
/def -mglob -t"The Sad Man is DEAD!!" gear_ac_sadman = /lootcor teardrop
;/def -mglob -t"Herr Kruger is DEAD!!" gear_ac_kruger = /lootcor bracer

;; Mana collecting triggers
;/def -mglob -t"The Lady Keren is DEAD!!" gear_mana_karen = /lootcor dress
;/def -mglob -t"King Ka'plar is DEAD!!" gear_mana_kap = /lootcor hood
;/def -mglob -t"Meliadus is DEAD!!" gear_mana_melia = /lootcor orb
;/def -mglob -t"Crawling Chaos is DEAD!!" gear_mana_crawl = /lootcor random
;/def -mglob -t"Giant water elemental is DEAD!!" gear_mana_water = /lootcor leggings
;/def -mglob -t"Eschard is DEAD!!" gear_mana_esch = /lootcor mantle%; /lootcor bladed
;/def -mglob -t"Dweller is DEAD!!" gear_mana_dwell = /lootcor talisman%; /lootcor scroll
;/def -mglob -t"Banshee Commander is DEAD!!" gear_mana_banshee = /lootcor helm
/def -mglob -t"Statue of Utami is DEAD!!" gear_mana_utami = /lootcor emerald
;/def -mglob -t"Ophanya is DEAD!!" gear_mana_ophan = /lootcor gauntlet
;/def -mglob -t"Githzerai Swordsman is DEAD!!" gear_mana_githsw = /lootcor bracer
;/def -mglob -t"High Priest of Hell is DEAD!!" gear_mana_priest = /lootcor robe
;/def -mglob -t"Zur'lithi is DEAD!!" gear_mana_zur = /lootcor belt
/def -mglob -t"Millament the mad Necromancer is DEAD!!" gear_mana_mill = /lootcor shroud %; /lootcor rib
/def -mglob -t"The beholder mother is DEAD!!" gear_mana_beholder = /lootcor eye
;/def -mglob -t"The Dweller is DEAD!!" gear_mana_talisman = /lootcor talisman%;/lootcor scroll

;; Dam collecting triggers
/def -mglob -t"Braugi is DEAD!!" gear_dam_brau = /lootcor ice
/def -mglob -t"Kroska is DEAD!!" gear_dam_krosk = /lootcor ice
;/def -mglob -t"*dark*master-at-arms*is DEAD!!" gear_dam_darkm = /lootcor brand%;/lootcor tornado
/def -mglob -t"Gruntha is DEAD!!" gear_dam_grun = /lootcor brand
/def -mglob -t"The Quest Master is DEAD!!" gear_dam_master = /lootcor torch
/def -mglob -t"Silver Knight is DEAD!!" gear_dam_kni = /lootcor breast
/def -mglob -t"King Saeran is DEAD!!" gear_dam_king = /lootcor cherubims
/def -mglob -t"A blazing man is DEAD!!" gear_dam_blaz = /lootcor pants
/def -mglob -t"Faralia is DEAD!!" gear_dam_fara = /lootcor glove
/def -mglob -t"The guild master is DEAD!!" gear_dam_guild = /lootcor tat
/def -mglob -t"Numenor is DEAD!!" gear_dam_numen = /lootcor robe
/def -mglob -t"Doom is DEAD!!" gear_dam_doom = /lootcor shard %; /lootcor collar
/def -mglob -t"Saeren the king is DEAD!!" gear_dam_saeren = /lootcor helm
/def -mglob -t"ManyJaws is DEAD!!" gear_dam_neck_teeth = /lootcor teeth
;;spiked sleeves

;; Hit collecting triggers
/def -mglob -t"Sabella is DEAD!!" gear_hit_sabella = /lootcor pendant

;; Misc collecting triggers
/def -mglob -t"An assassin is DEAD!!" gear_misc_assassin_toxifier = /lootcor toxifier
/def -mglob -t"An Arachnakan is DEAD!!" gear_misc_arachnakan = /lootcor fang
/def -mglob -t"Administrator Gru-Dzek is DEAD!!" gear_misc_admin = /lootcor wafer
/def -mglob -t"Heruta Skash Gzug is DEAD!!" gear_misc_master = /lootcor nectar
/def -mglob -t"*A pile of gold coins." gear_misc_coins = /if ({autoloot} = 1) /send get all.coins%; /endif
;/def -mglob -t"Cyskadella is DEAD!!" gear_misc_cysk = /if ({autoloot} = 1) /send get key cor%;/endif
/def -mglob -t'The master thief is DEAD!!' gear_misc_intruder = /lootcor lockpick
/def -mglob -t"The Demon Lord Typhus is DEAD!!" gear_misc_old_typhus = /lootcor staff
/def -mglob -t"The Lord Typhus' shadow is DEAD!!" gear_misc_typhus = /lootcor staff
/def -mglob -t"The grand templar is DEAD!!" gear_misc_templar = /lootcor flask
/def -mglob -t"Tryystania the DracoLich is DEAD!!" gear_misc_tryys = /if ({autoloot} = 1) /send get skull corpse%;/endif
/def -mglob -t"ArchBishop Morte is DEAD!!" gear_misc_archbishop = /if ({autoloot} = 1) /send get amulet corpse=unlock north=open north%;/endif
/def -mglob -t"Belag is DEAD!!" gear_misc_belag = /lootcor symbol
/def -mglob -t'A Glacial Guardian is DEAD!!' gear_misc_milk = /if ({autoloot} = 1) /send get milk cor%;/endif
/def -mglob -t"The Privateer Captain is DEAD!!" gear_misc_privateer = /lootcor bag
/def -mglob -t"A dragon Seer is DEAD!!" gear_misc_seer = /lootcor elixir
/def -mglob -t"The guardian of the white temple is DEAD!!" gear_misc_guardwhite = /lootcor cross
/def -mglob -t"The Obelische Priest is DEAD!!" gear_misc_obelische = /lootcor cloth
/def -mglob -t"A stone golem is DEAD!!" gear_misc_herbal_getscroll = /if ({autoloot} = 1) get scroll corpse%; /endif
/def -mglob -t"(Translucent) (Flying) The spectre of the shrine's last priest floats by, moaning." gear_misc_herbal_getbook = \
	/if ({autoloot} = 1) give scroll spectre%; /endif
/def -mglob -t"(Hide) (Sneak) A human ranger with a noble bearing is here." gear_misc_herbal_getherbal = \
	/if ({autoloot} = 1) vis%;give book von%;put herbal %lootContainer%; /endif
/def -mglob -t"     A crumpled scroll lies tossed in a corner." gear_misc_crumpscro = \
	/if ({autoloot} = 1) get crumple%;put crumple %lootContainer%; /endif
/def -mglob -p2 -t"*A silver altar pulses with a slow blue glow." gear_misc_crumbscro = /if ({autoloot} = 1) /send get all altar%;/endif
/def -mglob -t"A dark ring of ice-blue fire is DEAD!!" gear_misc_sulfurous_ashes = /lootcor all.ash

;; Eragora gear
/def -mglob -t"A strange force overpowers your senses as it comes nearer!" gear_eragora_toggle_autoloot = /send config +autoloot%;/aq config -autoloot
/def -mglob -t"An earth elemental is DEAD!!" gear_eragora_elemantal = /lootcor elemental
/def -mglob -t"Binbinka, the village shaman is DEAD!!" gear_eragora_binbin = /lootcor pearl cor
/def -mglob -t"* A barrel made from wooden lathes." gear_eragora_crab_meat = /if ({autoloot} = 1) /send open barrel=get meat barrel%;/endif

;;; Heartwood
/def -p1 -aB -mglob -t'     A single white feather lies amongst the forest leaves.' quest_heartwood_goose_feather = /send get goose
/def -p1 -aB -mglob -t'The mighty trees around you, their trunks so wide a family of giants' quest_heartwood_bark = /send get bark
/def -p1 -aB -mglob -t'A low hill rises up here, and despite the ancient forest close about,'  quest_heartwood_berries = /send get all shrub

;;; Deepways
;; In deepways, the caravan drops a treasure -- pretty heavy:
/def -mglob -t"As you wreak the caravan, a large amount" gear_misc_deepways_caravan = /if ({autoloot} = 1) /send get treasure%;/endif
/def -mglob -t"A large amount of coinage lies spilled across the floor." gear_misc_deepways_gold = /if ({autoloot} = 1) /send get treasure%;/endif
/def -mglob -t"*A pile of cash has spilled out over the floor." gear_misc_deepways_gold2 = /if ({autoloot} = 1) /send get cash%;/endif
/def -mglob -p1 -t"*A large amount of coinage lies spilled across the floor." gear_misc_deepways_gold3 = /if ({autoloot} == 1) /send get coin%;/endif
/def -mglob -p1 -t"The coins the mimic was using to lure" gear_misc_deepways_gold4 = /if ({autoloot} == 1) /send get coin%;/endif

;;; Storm Canyon gemstones
/def -mglob -t"Leaving nothing but silence the wind dies down." gem_storm_canyon1 = /if ({autoloot} = 1) get gem%;/endif
/def -mglob -t"For a few moments after the storm head dissolves its terrible" gem_storm_canyon2 = /if ({autoloot} = 1) get gem%;/endif
/def -mglob -t"As the last flash of light fades the rift returns to its" gem_storm_canyon3 = /if ({autoloot} = 1) get gem%;/endif

;;; Necropolis
/def -mglob -t"The General Commander for Veyah L'Aturii is DEAD!!" necropolis_loot_general_command = /lootcor ashe
/def -mglob -t"Golem guardian is DEAD!!" necropolis_loot_golem_guardian = /lootcor blade

/def -mglob -t"Groundskeeper Chalmers is DEAD!!" Aculeata_loot_chalmers = /lootcor talisman


;;; Poisons
/def -mglob -t"A trapdoor spider is DEAD!!" gear_poison_trapspider = /lootcor venom
/def -mglob -t"A Hezrou demon is DEAD!!" gear_poison_hezrou = /lootcor bile

;; Bag collecting Triggers
/def -mglob -t"Janos Ferenczy is DEAD!!" gear_bag_janos = /if ({autoloot} = 1) /send get urn cor%;/endif
/def -mglob -t"Zek Foener is DEAD!!" gear_bag_zek = /if ({autoloot} = 1) /send get jump cor%;/endif

;; Gear in The Rim
;;; Skin item for druid
/def -mglob -t"A glimmering starshark is DEAD!!" gear_therim_skin_orb = /if ({autoloot} = 1) /send get corpse%;/endif
/def -mglob -t"Corpse of a glimmering starshark falls to the ground." gear_therim_skin_orb2 = /if ({autoloot} = 1) /send get corpse%;/endif
/def -mglob -t"The storm wyrm Oeheliu is DEAD!!" gear_therim_spearhead = /lootcor spearhead%;/lootcor orb

;; Gear in Glyntaff Pass
;;; skin item for snow leopardskin
/def -mglob -t"A snow leopard is DEAD!!" gear_glyntaff_snow_leopard = /if ({autoloot} = 1) /send get corpse%;/endif
/def -mglob -t"A golden eagle is DEAD!!" gear_glyntaff_golden_eagle = /if ({autoloot} = 1) /send get corpse%;/endif


;;; Silly aliases to tell self how to get Orosca
/alias oros \
    /if ({1} =~ "1" | {1} =~ "necklace") oros1%;\
    /elseif ({1} =~ "2" | {1} =~ "brooch") oros2%;\
    /elseif ({1} =~ "3" | {1} =~ "tiara") oros3%;\
    /elseif ({1} =~ "4" | {1} =~ "bracelet") oros4%;\
    /elseif ({1} =~ "5" | {1} =~ "earring") oros5%;\
    /else /echo -pw %%% @{Cyellow}Orosca Quest: oros 1|2|3|4|5|necklace|brooch|tiara|bracelet|earring%;\
    /endif
/alias oros5 /echo -pw %%% @{Cyellow}Orosca Quest: emerald earring: tele diana, 9en\;o d\;dndww, kill artisan
/alias oros4 /echo -pw %%% @{Cyellow}Orosca Quest: emerald bracelet: tele orosca, 2nw\;o s\;s, kill old woman
/alias oros3 /echo -pw %%% @{Cyellow}Orosca Quest: emerald tiara: tele ent bank, 5s3wnwswsw2n, kill gold token.
/alias oros2 /echo -pw %%% @{Cyellow}Orosca Quest: emerald brooch: tele broo shaman, kill him (kill both for it to repop)
/alias oros1 /echo -pw %%% @{Cyellow}Orosca Quest: emerald necklace: tele king lion, s\;o d\;dese

/alias giveoros get "emerald necklace" %{main_bag}%;get "emerald tiara" %{main_bag}%;get "emerald brooch" %{main_bag}%;get "emerald earring" %{main_bag}%;get "emerald bracelet" %{main_bag}%;give emerald orosca

/def -mglob -p1 -t"Silk producer is DEAD!!" gear_quest_orosca_earring = /lootcor emerald
/def -mglob -p1 -t"The fortune teller is DEAD!!" gear_quest_orosca_bracelet = /lootcor emerald
/def -mglob -p1 -t"The diseased Broo Shaman is DEAD!!" gear_quest_orosca_brooch = /lootcor emerald
/def -mglob -p1 -t"Animated Quest Sword is DEAD!!" gear_quest_orosca_tiara = /lootcor emerald
/def -mglob -p1 -t"     A priceless antique emerald necklace has been dropped here." gear_quest_orosca_necklace = /if ({autoloot} = 1) /send get "emerald necklace"=put "emerald necklace" %{lootContainer}%;/endif

/def -mglob -p1 -t"A lizardwoman thief is DEAD!!" gear_misc_silver_lockpick = /lootcor lockpick

;;; Lordly level stuff
/def -mglob -p1 -t"The flames subside, leaving a crystalline wand in their wake." gear_lord_crystal_wand = /if ({autoloot} = 1) /send get wand%; /endif
/def -mglob -p1 -t"* leaves behind * ashes!" gear_misc_ashes = /if ({autoloot} == 1) /send get ashes%;/endif
/def -mglob -p1 -t"A gith thief is DEAD!!" gear_lord_thief_corpse = \
    /if ({autoloot} == 1) /send get corpse%;/endif

