;;; ----------------------------------------------------------------------------
;;; highlights.tf
;;; Locate triggers / highlights
;;; ----------------------------------------------------------------------------
/def -mglob -ahb -t"The Black Staff of Typhus carried by The demon lord Typhus." high_old_typhus
/def -mglob -ahb -t"Black staff of Typhus carried by The Lord Typhus' shadow." high_typhus
/def -mglob -ahb -t"A very heavy purse carried by Oglethorpe, 1st Master Merchant of Freeport." high_oglethorpe
/def -mglob -ahb -t"Maelstrom, sword of the Balrog carried by Ral." high_ral
/def -mglob -ahb -t"Vorpal blade carried by a skeletal guard." high_apoc
/def -mglob -ahb -t"A flask of oil carried by Ajuu the Housewares Vendor." high_igecsoz
/def -mglob -ahb -t"A wafer with essence carried by Prad Azoz." high_padmasa
/def -mglob -ahb -t"A chained steel collar carried by The Doom." high_doom
/def -mglob -ahb -t"A pair of steel bracers carried by Herr Kruger." high_herrkruger
/def -mglob -ahb -t"The LeMans family seal carried by the Beast LeMans." high_lemans
/def -mglob -ahb -t"Carved bone necklace carried by Aruna." high_aruna
/def -mglob -ahb -t"The Unholy Shroud carried by Millament the mad Necromancer." high_millament
/def -mglob -ahb -t"Teardrop Helm carried by The Sad Man." high_sadman
/def -mglob -ahb -t"A flaming scimitar carried by Sieghard." high_hamlet
/def -mglob -ahb -t"A guitare carried by the wizard." high_hamlet2
/def -mglob -ahb -t"A Tattered Robe carried by Regimental Commander." high_saintblades
/def -mglob -ahb -t"A giantkin club carried by A hill giant." high_serpweyr
/def -mglob -ahb -t"The dark blade of kra carried by the dwarf assassin." high_divide

;; Heartwood
/def -mglob -ahb -t"A wide strip of vallenwood bark in Deep in the forest." high_heartwood_bark
/def -mglob -ahb -t"A goose feather in Deep in the forest." high_heartwood_goose_feather
/def -mglob -ahb -t"A handful of berries in Deep in the forest." high_heartwood_berries

;;; ----------------------------------------------------------------------------
;;; Channel highlights
;;; ----------------------------------------------------------------------------
; Grtz chan/info highlights
/def -mregexp -ag -t' town crier congratulates ([a-zA-Z]+) on (.*)!' gag_grtz
/def -ag -mglob -t"People who share your buddy value:" gag_buddyshare
/def -ag -mregexp -t"^\[GROUP INFO\]: ([a-zA-Z]*) \((Hero|Lord|Legend|level) ([0-9]*) ([a-zA-Z ]*)\) is looking for a group!" high_groupme = \
	/echo -pw @{Cred}[GROUP INFO]: @{hCyellow}%P1 @{nCred}(@{hCcyan}%P2 @{hCred}%P3 @{hCcyan}%P4@{nCred}) is looking for a group!@{n}

/def -ag -mregexp -t"^\[DEATH INFO\]: ([a-zA-Z]*) killed by (.+) in (.+) \(([0-9]*)\)\." high_deathinfo = \
    /echo -pw @{Cred}[DEATH INFO]: @{hCcyan}%P1 @{nCred}killed by @{hCyellow}%P2 @{nCred}in @{hCyellow}%P3 @{nCred}(%P4).@{n} %; \
    /let deadone=%P1%; \
    /let tdead=<%deadone<%; \
    /if (regmatch(tolower({tdead}),{groupies})) \
        /set deathlist=%{deathlist} %{deadone}%; \
        /set deathlist=$(/unique %deathlist)%; \
    /endif

/def -ag -mregexp -F -p0 -t"\[HERO INFO\]\: ([a-zA-Z]*) has just made level ([0-9]*)\!" level_lowmort = \
	/echo -pw @{Cred}[HERO INFO]: @{hCcyan}%P1 @{nCred}has just made level @{hCyellow}%P2@{nCred}!
/def -ag -mregexp -F -p0 -t"\[HERO INFO\]\: ([a-zA-Z]*) has just increased in power to (Hero|Lord|Legend) Level ([0-9]*)\!" level_nonmort = \
	/echo -pw @{Cred}[HERO INFO]: @{hCcyan}%P1 @{nCred}has just increased in power to @{hCyellow}%P2 @{nCred}Level @{hCyellow}%P3@{nCred}!

/def -mregexp -ag -t"\[LORD INFO\]: ([a-zA-Z]+) has just returned to (.*)\!" lord_thorn = \
	/echo -pw @{Cred}[LORD INFO]: @{hCcyan}%P1 @{nCred}has just returned to @{hCyellow}%P2@{Cred}!
/def -mregexp -F -ag -t"\[LORD INFO]: ([a-zA-Z]+) has just shifted to (.+)\!" lord_shift = \
    /echo -pw @{Cred}[LORD INFO]: @{hCcyan}%P1 @{nCred}has just shifted to @{hCyellow}%P2@{Cred}!%; \
    /set lcshifter=$[tolower({P1})]%; \
    /if ({lcshifter} =~ {autogurney} & {currentPosition} =~ "stand" & {mudLag} <= 1) \
        /send c gurney %{autogurney}%;\
    /endif

/def -aCyellow -p1 -mglob -t"* goldchats *" highlight_goldchat
/def -aCwhite -p1 -mglob -t"* silverchats *" highlight_silverchat
/def -aCblue -p1 -mglob -t"* azurechats *" highlight_azurechat

;;; ----------------------------------------------------------------------------
;;; Quest vial highlights (on ground and inventory).
;;; ----------------------------------------------------------------------------
/def -mregexp -ag -t"^([\(\)0-9 ]*)([a-zA-Z\(\) ]+)[aA]+[n]* (.*) vial (of healing|sits here\.)$" quest_pot_sub = \
    /let vialtype=%P3%; \
    /if ({vialtype} =~ "red striped") /let hspells=heal%;/let spcolor=@{Cred}%; \
    /elseif ({vialtype} =~ "orange-brown") /let hspells=cure serious%;/let spcolor=@{Cyellow}%; \
    /elseif ({vialtype} =~ "orange") /let hspells=heal, cure light, cure critical%;/let spcolor=@{Cyellow}%; \
    /elseif ({vialtype} =~ "light brown") /let hspells=cure light%;/let spcolor=@{Cyellow}%; \
    /elseif ({vialtype} =~ "yellow") /let hspells=heal, cure serious%;/let spcolor=@{Cyellow}%; \
    /elseif ({vialtype} =~ "yellow-brown") /let hspells=heal, cure light%;/let spcolor=@{Cyellow}%; \
    /elseif ({vialtype} =~ "yellow-orange") /let hspells=heal, cure critical%;/let spcolor=@{Cyellow}%; \
    /elseif ({vialtype} =~ "reddish-brown") /let hspells=cure critical%;/let spcolor=@{Cred}%; \
    /elseif ({vialtype} =~ "orange-red") /let hspells=cure critical, cure light%;/let spcolor=@{Cred}%; \
    /elseif ({vialtype} =~ "red-brown") /let hspells=div%;/let spcolor=@{Cred}%; \
    /elseif ({vialtype} =~ "red-orange") /let hspells=div, cure light%;/let spcolor=@{Cred}%;\
    /elseif ({vialtype} =~ "bright red") /let hspells=div, cure crit%;/let spcolor=@{hCred}%;\
    /elseif ({vialtype} =~ "fiery-red") /let hspells=div, cure crit, cure light%;/let spcolor=@{hCred}%;\
    /elseif ({vialtype} =~ "bright copper") /let hspells=div, heal, cure light%;/let spcolor=@{hCred}%;\
    /elseif ({vialtype} =~ "copper") /let hspells=div, heal%;/let spcolor=@{hCred}%;\
    /elseif ({vialtype} =~ "red") /let hspells=div, cure serious%;/let spcolor=@{hCred}%;\
    /elseif ({vialtype} =~ "silver") /let hspells=div, heal, cure serious%;/let spcolor=@{hCred}%;\
    /elseif ({vialtype} =~ "glowing gold") /let hspells=3x div%;/let spcolor=@{hCyellow}%;\
    /else /let hspells=N/A%;/let spcolor=@{Cwhite}%; \
    /endif%; \
    /echo -pw @{Cwhite}%{P1}%{P2}%{spcolor}%{vialtype} @{nCwhite}vial %P4 @{nCgreen}(%{spcolor}%{hspells}@{nCgreen})@{n}

;;; ----------------------------------------------------------------------------
;;; Stance highlights
;;; ----------------------------------------------------------------------------
;; TODO: Can these be changed to partials or a substitute
;; i.e. /def -PhCyellow -F -mregexp -t"^You adopt ([a-zA-Z\ ]+) stance\.$" highlight_stance_adopt
;;/def -PhCyellow -F -mregexp -t"^You adopt ([a-zA-Z\ ]+) stance\.$" highlight_stance_adopt = /test substitute(replace({P1}, @{Cgreen}{P1}, {P0}))
/def -mregexp -ag -t"You adopt ([a-zA-Z\ ]+) stance." highlight_stance_adopt = \
    /echo -pw @{hCgreen}You adopt @{nCyellow}%{P1} @{hCgreen}stance.@{n}
/def -mregexp -ag -t"You stop using ([a-zA-Z\ ]+)\." highlight_stance_stop = \
    /echo -pw @{hCgreen}You stop using @{nCyellow}%{P1}@{hCgreen}.@{n}
/def -mregexp -ag -t"Your ([a-zA-Z\ ]+) stance is still exhausted\." highlight_stance_exhausted = \
    /echo -pw @{hCgreen}Your @{nCyellow}%{P1}@{hCgreen} stance is still exhausted.@{n}
/def -mregexp -ag -t"You are already using ([a-zA-Z\ ]+) stance." highlight_stance_using = \
    /echo -pw @{hCgreen}You are already using @{nCyellow}%{P1}@{hCgreen} stance.@{n}

;;; ----------------------------------------------------------------------------
;;; Misc highlights
;;; ----------------------------------------------------------------------------
/def -mregexp -ag -F -p8 -t"^You see your quarry's trail head (north|south|east|west|up|down) from here!$" highlight_tracktrig = \
    /echo -pw @{hCgreen}You see your quarry's trail head @{nCyellow}%P1 @{hCGreen}from here!@{n}
/def -ag -mglob -t"No one with that name is playing." character_notonline
/def -abufhCred -P -mregexp -t"You are zapped by" self_zapped = /if ({running} == 1) get 1.%;/endif
/def -abufhCcyan -P -mregexp -t"disarms you and sends your weapon flying\!" self_disarmed = get %wield%;wield %wield
/def -abufCyellow -P -mregexp -t"You frantically attempt to remove" high_decepted
/def -p1 -mglob -ag -t"* flies out of *'s hand to attack *" gag_dwspam
/def -p0 -mglob -ag -t"* scans in all directions, looking for trouble\!" gag_scan_spam
/def -p1 -mglob -ar -t"*A large fountain sits here, depicting the three fates." fates_fountain
/def -p0 -mglob -ah -t"*A small fountain sits here, depicting the three fates." fates_fountain2
/def -mglob -p5 -aCcyan -t"* gasps with horror as * {shatters|shatter} *\!" high_shatter
/def -mglob -p5 -ahCwhite -t"Your * explodes into fragments." high_brandish_explode
/def -mglob -p5 -ahCwhite -t"Your * blazes bright and is gone." high_brrandish_blaze
/def -mregexp -p5 -abr -t"Moments before detonation, (.*)'s (.*?) vanishes suddenly!" high_detonate
/def -mregexp -p5 -abr -t"^The power stored in .* seems to diminish.$" high_shield_charges_dimishing

/def -PhCred -F -mregexp -t"\(Demonfire\)" high_dfire
/def -PCred -F -mregexp -t"[Ff]ighting!$" high_fighting
/def -PCmagenta -mregexp -F -t"PLAGUE" high_plague
/def -PCyellow -mregexp -F -t" is ([Rr]esting|[Ss]leeping) here\.?$" high_sleeping_resting_here
;/def -PCyellow -mregexp -F -t" [Ss]leeping\.?$" high_sleeping
/def -PhCgreen -F -mregexp -t"^Trapped in webs" high_webbed
/def -PhCblack -mregexp -F -t"\(Black Aura\)" high_blackaura
/def -PhCwhite -mregexp -F -t"\(White Aura\)" high_whiteaura
/def -PhCgreen -mregexp -F -t"\(Green Aura\)" high_endurance

;;; ----------------------------------------------------------------------------
;;; Healing highlights
;;; ----------------------------------------------------------------------------
/def -mglob -p6 -t"You feel better\!" high_curelight = /set ticktoggle=1
/def -mglob -p6 -t"A warm feeling fills your body\." high_heal = /set ticktoggle=1
/def -mglob -p6 -t"You tingle with renewed health\!" high_divinity = /set ticktoggle=1
/def -mglob -p6 -t"You lay your hands upon yourself\." high_medicine = /set ticktoggle=1
/def -mglob -p6 -aCgreen -t"You feel refreshed\!" high_refresh = /set ticktoggle=1

;;; ----------------------------------------------------------------------------
;;; threnody highlights
;;; ----------------------------------------------------------------------------
/def -q -mregexp -t"begin[s | ]+a dirge for corpse of [A-Za-z]+\.\.\." threnreset = /set threno=1
/def -q -ag -mregexp -t" mourn[s | ]+for corpse of ([A-Za-z]+)\.\.\." threncnt = \
    /set threno=$[++threno] %; \
    /echo -pw @{Ccyan}%threno@{Cwhite} - %PL threnodying @{Cyellow}%P1@{Cwhite}!@{n}
/def -F -p0 -q -ag -mregexp -t"\\[[A-Z]+ INFO\\]\: ([A-Za-z]+) finishes Threnody, moving corpse of ([A-Za-z]+) to safety\." thren_finished = \
    /echo -pw @{Cred}[LORD INFO]: @{hCcyan}%P1 @{nCred}finished threnody on @{Cwhite}%P2@{Cred}!@{n}%; \
    /if ({deathlist} !~ "") \
        /rmdeath %P2%;\
    /endif

/def -q -ag -mregexp -t"\[LORD INFO\]\: ([A-Za-z]+) initiates a Threnody dirge for corpse of ([A-Za-z]+) in (.*)\." threnstart = \
    /echo -pw @{Cred}[LORD INFO]: @{hCcyan}%P1 @{nCred}has started a Threnody for @{hCyellow}%P2@{nCred} in @{hCwhite}%P3@{nCred}.@{n}

;;; ----------------------------------------------------------------------------
;;; sharpen weapon highlights
;;; ----------------------------------------------------------------------------
/def -ahCred -mglob -t"You almost dull *, but Durr steadies your hand!" sharpen_almostdull
/def -ahCgreen -mglob -t"You smile as you feel the increased sharpness of *!" sharpen_normal
/def -ahCyellow -mglob -t"Despite your efforts, nothing happens to *" sharpen_nothing
/def -ahCred -mglob -t"You sigh as you realize you have slipped and dulled *!" sharpen_dull
/def -ahCyellow -mglob -t"The weapon is as sharp as it is going to get!" sharpen_done
/def -ahCgreen -mglob -t"Your hands tingle as a brilliant green light bursts from *!" sharpen_brill

;;; ----------------------------------------------------------------------------
;;; Examine-type highlights
;;; ----------------------------------------------------------------------------
/def -mregexp -aCyellow -t'^This has roughly [0-9]+ uses remaining.' useremain
/def -mglob -ahCyellow -t'Disarming traps.' disarmingtrap
/def -mregexp -aCyellow -t'^It has roughly [0-9]+ uses remaining.' fletchkitremain
/def -mregexp -ahCyellow -t'^Each one carries [a-zA-Z\-]+, a.*$' poisonarrowaff
/def -mregexp -ag -mregexp -t'^It (improves|facilitates) ([a-zA-Z ]+).' archermodsaff = /echo -pw @{Cyellow}It %P1 @{hCgreen}%P2@{nCyellow}.
/def -mregexp -ahCyellow -t'^It carries roughly [0-9]+ doses of [a-zA-Z \-]+, a.*$' poisonweapaff
/def -mregexp -ag -t'^Picking locks on ([a-zA-Z \-]+)' picklockaff = /echo -pw @{Cyellow}Picking locks on @{hCgreen}%P1@{nCyellow}.

;;; ----------------------------------------------------------------------------
;;; Poise/balance highlight
;;; ----------------------------------------------------------------------------
/def -mglob -ah -t'Using your skill, you balance your weapons with ease.' balanceease

/def -mglob -ahCred -p1 -t"* starts burning from unholy flames!" highlight_mob_burning
;;; ----------------------------------------------------------------------------------
;;; Non-Obvious/Aggresive Mob Name subs
;;; ----------------------------------------------------------------------------------
/set AggroString=@{hCcyan}(@{hCwhite}Aggro@{hCcyan})@{n}
;;; *** Zin's odditities
/def -ag -mglob -t"*This trog smells like a bed of roses\." sub_oddities_freak = \
    /echo -pw @{Ccyan}%{PL}This trog @{hCwhite}(freak)@{n}@{nCcyan} smells like a bed of roses.
/def -ag -mglob -t"*A giant casts 'create food' on others to amuse himself\." sub_oddities_peculiarity = \
    /echo -pw @{Ccyan}%{PL}A giant @{hCwhite}(peculiarity)@{n}@{nCcyan} casts 'create food' on others to amuse himself.
/def -ag -mglob -t"*An Orc is here, preaching Love and Understanding\." sub_oddities_abnormality = \
    /echo -pw @{Ccyan}%{PL}An Orc @{hCwhite}(abnormality)@{n}@{nCcyan} is here, preaching Love and Understanding.
/def -ag -mglob -t"*A sprite starts pushing you around the room. Almost daring you to fight\." sub_oddities_curiosity = \
    /echo -pw @{Ccyan}%{PL}A sprite @{hCwhite}(curiosity)@{n}@{nCcyan} starts pushing you around the room. Almost daring you to fight.
/def -ag -mglob -t"*A halfling trips over her own feet\." sub_oddities_irregularity = \
    /echo -pw @{Ccyan}%{PL}A halfling @{hCwhite}(irregularity)@{n}@{nCcyan} trips over her own feet.
/def -ag -mglob -t"*An Ogre admires her svelte and slim form\." sub_oddities_oddity = \
    /echo -pw @{Ccyan}%{PL}An Ogre @{hCwhite}(oddity)@{n}@{nCcyan} admires her svelte and slim form.
/def -ag -mglob -t"*You see a Troll doing a graceful pirouette\." sub_oddities_abnormality2 = \
    /echo -pw @{Ccyan}%{PL}You see a Troll @{hCwhite}(abnormality)@{n}@{nCcyan} doing a graceful pirouette.
/def -ag -mglob -t"*A kzinti wanders about, looking for her fur\." sub_oddities_curiosity2 = \
    /echo -pw @{Ccyan}%{PL}A kzinti @{hCwhite}(curiosity)@{n}@{nCcyan} wanders about, looking for her fur.
/def -ag -mglob -t"*An elf is here, trimming his mustache\." sub_oddities_peculiarity2 = \
    /echo -pw @{Ccyan}%{PL}An elf @{hCwhite}(peculiarity)@{n}@{nCcyan} is here, trimming his mustache.
/def -ag -mglob -t"*A drow is here, admiring her suntan\." sub_oddities_irregularity2 = \
    /echo -pw @{Ccyan}%{PL}A drow @{hCwhite}(irregularity)@{n}@{nCcyan} is here, admiring her suntan.
/def -ag -mglob -t"*A Dwarf with no beard strolls down the street\." sub_oddities_oddity2 = \
    /echo -pw @{Ccyan}%{PL}A Dwarf @{hCwhite}(oddity)@{n}@{nCcyan} with no beard strolls down the street.


;;; *** Divide
/def -p5 -F -ag -mglob -t"*Dead eyes and grinning teeth come rushing toward you\!" sub_divide_soulless = \
    /echo -pw @{Ccyan}%{PL}%{AggroString} @{hCmagenta}Soulless@{n} @{nCcyan}is here waiting for you to kill it.@{n}
/def -p5 -F -ag -mglob -t"*A strange vision, an absence of light, chills your marrow\." sub_divide_abysmal = \
    /echo -pw @{Ccyan}%{PL}%{AggroString} @{hCmagenta}Abysmal@{n} @{nCcyan}is here waiting for you to kill it.@{n}
/def -p5 -F -ag -mglob -t"*A nightmare advances, its huge belly dragging the ground\." sub_divide_insatiable = \
    /echo -pw @{Ccyan}%{PL}%{AggroString} @{hCmagenta}Insatiable@{n} @{nCcyan}is here waiting for you to kill it.@{n}
/def -p5 -F -ag -mglob -t"*A dark form stalks you amidst a whirling cloud of dust\." sub_divide_hundredhanded = \
    /echo -pw @{Ccyan}%{PL}%{AggroString} @{hCmagenta}Hundred-Handed@{n} @{nCcyan}is here waiting for you to kill it.@{n}
/def -p5 -F -ag -mglob -t"*Guarding the darkness, this beast destroys the light\." sub_divide_faceless = \
    /echo -pw @{Ccyan}%{PL}%{AggroString} @{hCmagenta}Faceless@{n} @{nCcyan}is here waiting for you to kill it.@{n}

;;; *** Morte aggros
/def -p5 -F -ag -mglob -t"*A bald headed man floats cross-legged above the ground, frowning\." sub_morte_baldman = \
    /echo -pw @{Ccyan}%{PL}%{AggroString}@{nCcyan} A bald headed @{hCcyan}man@{n}@{nCcyan} floats cross-legged above the ground, frowning.@{n}
/def -p5 -F -ag -mglob -t"*A black void writhes and transmutes, never holding its shape for long\." sub_morte_tchotcho = \
    /echo -pw @{Ccyan}%{PL}@{nCcyan}Tcho-Tcho writhes and transmutes, never holding its shape for long.@{n}
/def -p5 -F -ag -mglob -t"*A creature out of legend emerges from the shadows, enraged\!" sub_morte_legendarycreature = \
    /echo -pw @{Ccyan}%{PL}%{AggroString}@{nCcyan} A @{hCcyan}creature@{n}@{nCcyan} out of legend emerges from the shadows, enraged!@{n}
/def -p5 -F -ag -mglob -t"*A dog headed woman glares at you and attacks\!" sub_morte_dogheadwoman = \
    /echo -pw @{Ccyan}%{PL}%{AggroString}@{nCcyan} A dog headed @{hCcyan}woman@{n}@{nCcyan} glares at you and attacks!@{n}
/def -p5 -F -ag -mglob -t"*A giant bird flaps leathery serpent-like wings in anger\." sub_morte_serpentbird = \
    /echo -pw @{Ccyan}%{PL}%{AggroString}@{nCcyan} A giant @{hCcyan}bird@{n}@{nCcyan} flaps leathery serpent-like wings in anger.@{n}
/def -p5 -F -ag -mglob -t"*A giant looks blindly about, slowly blinking his single eye\." sub_morte_cyclops = \
    /echo -pw @{Ccyan}%{PL}%{AggroString}@{nCcyan} A @{hCcyan}giant@{n}@{nCcyan} looks blindly about, slowly blinking his single eye.@{n}
/def -p5 -F -ag -mglob -t"*A man-beast snarls at you and attacks\!" sub_morte_manbeast = \
    /echo -pw @{Ccyan}%{PL}%{AggroString}@{nCcyan} A @{hCcyan}man@{n}@{nCcyan}-beast snarls at you and attacks!@{n}
/def -p5 -F -ag -mglob -t"*A huge minotaur, rippling with muscle, tries to rip your arms off\." sub_morte_minotaur = \
    /echo -pw @{Ccyan}%{PL}%{AggroString}@{nCcyan} A huge @{hCcyan}minotaur@{n}@{nCcyan}, rippling with muscle, tries to rip your arms off.@{n}
/def -p5 -F -ag -mglob -t"*A nightmarish hound savagely attacks\!" sub_morte_nightmarehound = \
    /echo -pw @{Ccyan}%{PL}%{AggroString}@{nCcyan} A nightmarish @{hCcyan}hound@{n}@{nCcyan} savagely attacks!@{n}
/def -p5 -F -ag -mglob -t"*A huge creature smokes, steams, and snarls\." sub_morte_snarlcreature = \
    /echo -pw @{Ccyan}%{PL}%{AggroString}@{nCcyan} A huge @{hCcyan}creature@{n}@{nCcyan} smokes, steams, and snarls.@{n}
/def -p5 -F -ag -mglob -t"*A shaggy-haired beast staggers through the heat\." sub_morte_shaggybeaststagger = \
    /echo -pw @{Ccyan}%{PL}%{AggroString}@{nCcyan} A shaggy-haired beast staggers through the heat.@{n}
/def -p5 -F -ag -mglob -t"*A snake headed woman bathes in the stench of the painfall\." sub_morte_snakewoman = \
    /echo -pw @{Ccyan}%{PL}%{AggroString}@{nCcyan} A snake headed woman bathes in the stench of the painfall.@{n}
/def -p5 -F -ag -mglob -t"*A towering stone golem stalks the valley, looking for you\!" sub_morte_collosus = \
    /echo -pw @{Ccyan}%{PL}%{AggroString}@{hCcyan}Collosus@{n}@{nCcyan}, a towering stone golem stalks the valley, looking for you!@{n}
/def -p5 -F -ag -mglob -t"*Body of a lion, face of man, temper of a demon, the manticore attacks\!" sub_morte_manticore = \
    /echo -pw @{Ccyan}%{PL}%{AggroString}@{nCcyan} Body of a lion, face of man, temper of a demon, the @{hCcyan}manticore@{n}@{nCcyan} attacks!@{n}
/def -p5 -F -ag -mglob -t"*Breathing fire and bellowing, a chimera attacks\!" sub_morte_morte_chimera = \
    /echo -pw @{Ccyan}%{PL}%{AggroString}@{nCcyan} Breathing fire and bellowing, a @{hCcyan}chimera@{n}@{nCcyan} attacks!@{n}
/def -p5 -F -ag -mglob -t"*Feathers afire and teeth gleaming, a giant Roc attacks\!" sub_morte_giantroc = \
    /echo -pw @{Ccyan}%{PL}%{AggroString}@{nCcyan} Feathers afire and teeth gleaming, a giant @{hCcyan}Roc@{n}@{nCcyan} attacks!@{n}
/def -p5 -F -ag -mglob -t"*Fierce eyes show no mercy as a shaggy creature silently attacks\!" sub_morte_shaggycreature = \
    /echo -pw @{Ccyan}%{PL}%{AggroString}@{nCcyan} Fierce eyes show no mercy as a shaggy @{hCcyan}creature@{n}@{nCcyan} silently attacks!@{n}
/def -p5 -F -ag -mglob -t"*Lightning flashes and thunder booms as a massive giant approaches\." sub_morte_giantapproaching = \
    /echo -pw @{Ccyan}%{PL}%{AggroString}@{nCcyan} Lightning flashes and thunder booms as a massive @{hCcyan}giant@{n}@{nCcyan} approaches.@{n}
/def -p5 -F -ag -mglob -t"*Moving quickly for her stony bulk, Oborus attacks\!" sub_morte_oborus = \
    /echo -pw @{Ccyan}%{PL}%{AggroString}@{nCcyan} Moving quickly for her stony bulk, @{hCcyan}Oborus@{n}@{nCcyan} attacks!@{n}}
/def -p5 -F -ag -mglob -t"*With bloody drool dripping from his lips, a werewolf searches for more\." sub_morte_werewolf = \
    /echo -pw @{Ccyan}%{PL}%{AggroString}@{nCcyan} With bloody drool dripping from his lips, a @{hCcyan}werewolf@{n}@{nCcyan} searches for more.@{n}}
/def -p5 -F -ag -mglob -t"*Standing in the middle of the arena, a huge minotaur challenges all\." sub_morte_minotaurchallenge = \
    /echo -pw @{Ccyan}%{PL}%{AggroString}@{nCcyan} Standing in the middle of the arena, a huge minotaur challenges all.@{n}

;;; ***Battleground
/def -p5 -F -ag -mglob -t"*The Stone Giant leader makes some decisions. Very very slowly\." sub_battleground_crusher = \
    /echo -pw @{Ccyan}%{PL}%{AggroString}@{hCcyan} Crusher@{n}@{nCcyan}, the Stone Giant leader makes some decisions. Very very slowly.@{n}}
/def -p5 -F -ag -mglob -t"*A living groundswell of dirt and plant matter seeks to destroy all fauna\." sub_battleground_force = \
    /echo -pw @{Ccyan}%{PL}%{AggroString}@{hCcyan} Force of Nature @{nCcyan}seeks to destroy all fauna.@{n}

;;; *** Downward spiral
/def -p5 -F -ag -mglob -t"*The shadows move by themselves, surrounding you\." sub_dspiral_surrounddarkness = \
    /echo -pw @{Ccyan}%{PL}@{hCwhite}(@{nCcyan}Creeping Darkness@{hCwhite})@{nCcyan} The shadows move by themselves, surrounding you.@{n}
/def -p5 -F -ag -mglob -t"*The darkness appears to shift, enveloping you\." sub_dspiral_envelopdarkness = \
    /echo -pw @{Ccyan}%{PL}@{hCwhite}(@{nCcyan}Creeping Darkness@{hCwhite})@{nCcyan} The darkness appears to shift, enveloping you.@{n}
/def -p5 -F -ag -mglob -t"*The uncertainty of the unknown is laughing at you\." sub_dspiral_fear = \
    /echo -pw @{Ccyan}%{PL}@{hCwhite}(@{nCcyan}Fear@{hCwhite})@{nCcyan} The uncertainty of the unknown is laughing at you.@{n}
/def -p5 -F -ag -mglob -t"*You have a feeling like you've done this before\." sub_dspiral_monotony = \
    /echo -pw @{Ccyan}%{PL}@{hCwhite}(@{nCcyan}Monotony@{hCwhite})@{nCcyan} You have a feeling like you've done this before.@{n}
/def -p5 -F -ag -mglob -t"*You hear whispers coming from somewhere\." sub_dspiral_rumor = \
    /echo -pw @{Ccyan}%{PL}@{hCwhite}(@{nCcyan}Scathing Rumor@{hCwhite})@{nCcyan} You hear whispers coming from somewhere.@{n}
/def -p5 -F -ag -mglob -t"*Something plucks at your heart as you feel more alone than ever\." sub_dspiral_solitude = \
    /echo -pw @{Ccyan}%{PL}@{hCwhite}(@{nCcyan}Solitude@{hCwhite})@{nCcyan} lucent) (Sneak) Something plucks at your heart as you feel more alone than ever.@{n}
/def -p5 -F -ag -mglob -t"*You face an image of yourself\." sub_dspiral_mimic = \
    /echo -pw @{Ccyan}%{PL}@{hCwhite}(@{nCcyan}Mimic@{hCwhite})@{nCcyan} You face an image of yourself.@{n}

;;; *** Frozen Wastes
/def -p5 -F -ag -mglob -t"*A giant bear is standing here, thinking about killing you\." sub_frozenwastes_breen = \
    /echo -pw @{Ccyan}%{PL}A giant bear @{hCwhite}(breen)@{nCcyan} is standing here, thinking about killing you.

;;; *** Storm Canyon
/def -p5 -F -ag -mglob -t"*This assemblage of tiny ice needles pulses rapidly\." sub_storm_canyon_mother_of_storm = \
    /echo -pw @{Ccyan}%{PL}This assemblage of tiny ice needles pulses rapidly.  @{hCwhite}(@{hCred}WARNING: SPAWNS MOTHER OF STORMS -- DETONATION CASTING MOB@{hCwhite})@{n}
/def -p5 -F -ag -mglob -t"*This toppled over assemblage of frost and ice gleams weakly\." sub_storm_canyon_lightning_tempest = \
    /echo -pw @{CCyan}%{PL}This toppled over assemblage of frost and ice gleams weakly.  @{hCwhite} (@{hCred}WARNING: SPAWNS Lightning Tempest -- UNREST AND TORMENT CASTING MOB.@{hCwhite})@{n}

;;; *** Aculeata
/def -p5 -F -ag -mglob -t"*This wasp is horrendously overgrown!" sub_aculeata_overgrown_wasp = \
    /echo -pw @{Ccyan}%{PL}This (BACKSTABBING) wasp is horrendously overgrown!@{n}
/def -p5 -F -ag -mglob -t"*This wasp is positively enormous!" sub_aculeata_enormous_wasp = \
    /echo -pw @{Ccyan}%{PL}This (BACKSTABBING) wasp is positively enormous!

;;; *** Summoning
/def -ag -mglob -p99 -t"*You see a giant snake with humanoid arms, six short legs and three tails\." sub_summoning_guardian_behir = \
    /echo -pw @{Ccyan}%{PL}@{nCcyan} @{hCwhite}(@{nCcyan}Guardian Behir@{hCwhite})@{nCcyan}You see a giant snake with humanoid arms, six short legs and three tails@{n}
/def -p5 -F -ag -mglob -t"*A very large rock-like thing is here\." sub_summoning_motherxorn = \
    /echo -pw @{Ccyan}%{PL}%{AggroString}@{nCcyan} @{hCwhite}(@{nCcyan}Mother Xorn@{n}@{hCwhite})@{n}@{nCcyan}A very large rock-like thing is here.@{n}
/def -p5 -F -ag -mglob -t"*A huge snake-like creature crawls along on its six legs\." sub_summoning_behir = \
    /echo -pw @{Ccyan}%{PL}@{hCwhite}(@{nCcyan}Slithering Behir@{n}@{hCwhite})@{n}@{nCcyan} A huge snake-like creature crawls along on its six legs.@{n}
/def -p5 -F -ag -mglob -t"*A boulder suddenly splits open and tries to bite you\." sub_summoning_xorn = \
    /echo -pw @{Ccyan}%{PL}@{hCwhite}(@{nCcyan}Xorn@{n}@{hCwhite})@{n}@{nCcyan} A boulder suddenly splits open and tries to bite you.@{n}
/def -p5 -F -ag -mglob -t"*You see a hideous mouth erupt from the rock\." sub_summoning_nehemiah = \
    /echo -pw @{Ccyan}%{PL}@{hCwhite}(@{nCcyan}Xorn@{n}@{hCwhite})@{n}@{nCcyan} You see a hideous mouth erupt from the rock.@{n}
/def -p5 -F -ag -mglob -t"*A three-armed creature is here, gnawing on some iron ore." sub_summoning_xorn2 =\
    /echo -pw @{Ccyan}%{PL}@{hCwhite}(@{nCcyan}Xorn@{n}@{hCwhite})@{n}@{nCcyan} A three-armed creature is here, gnawing on some iron ore.@{n}

;;; ==== Eragora
;;; *** Kelp Grove
/def -p5 -mregexp -ahr -t"^The Kelp Grove \(Underwater\)$" highlight_eragora_kelp_grove = \
    /echo -pw @{Cred}[NAVIGATION INFO]: Directions to Explorers Respite: 2n4eudes%;\
    /if ({autowalk} == 1) 2n4eudes%;/endif
/def -p5 -mregexp -ahr -t"^Deep in the Kelp Grove \(Underwater\)$" highlight_eragora_deep_kelp_grove = \
    /echo -pw @{Cred}[NAVIGATION INFO]: Fastest stacking room.
/def -p5 -abh -mglob -t"With the grove wiped out, a manta ray is visible near the sunken ship." highlight_eragora_kelp_grove_manta

;;; *** Outland mobs
/def -ag -mglob -t"*The serene look of insanity, perhaps the last thing you ever see\." sub_outland_butcher = \
    /echo -pw @{Ccyan}%{PL}@{nCcyan}The serene @{hCwhite}(@{nCcyan}butcher@{hCwhite}) @{nCcyan}look of insanity, perhaps the last thing you ever see.
/def -ag -mglob -t"A massive githzerai swaggers toward you\." sub_outland_champion = \
    /echo -pw @{Ccyan}%{PL}@{nCcyan}A massive githzerai, @{hCwhite}(@{nCcyan}champion@{hCwhite}), swaggers toward you.

/def -ah -mglob -t"A royal half-orc guard blocks your path." erogora_guard_with_key_to_zurik

;;; *** Gags
/def -mregexp -ag -t"^A large number of [a-zA-Z]+'s wounds are healed." gag_heal
/def -mregexp -ag -t"^[a-zA-Z]+ is completely healed by Tul-Sith!" gag_comfort
/def -mregexp -ag -t"^[a-zA-Z]+'s wounds are greatly healed by Tul-Sith!" gag_comfort2
/def -mregexp -ag -t"^The eyes of [a-zA-Z]+ glow with a bluish light." gag_hos1
/def -mregexp -ag -t"^The eyes of [a-zA-Z]+ turn gold at the edges." gag_hos2
/def -mregexp -ag -t"^The eyes of [a-zA-Z]+ glow briefly with a yellowish light." gag_hos3
/def -mregexp -ag -t"^The eyes of [a-zA-Z]+ twinkle with a greenish light." gag_hos4
/def -mregexp -ag -t"[a-zA-Z]+'s eyes glow red." gag_hos5
/def -mregexp -ag -t"Your touch burns away the impurity within [a-zA-Z]+!" gag_puretouch
/def -mregexp -ag -t"^[a-zA-Z]+ prays to grant comfort to [a-zA-Z]+\!" gag_masscomfort
; rename gags
/def -ag -mglob -t"if the name is determined to be out of theme or objectionable, you are" gag_rename_line1
/def -ag -mglob -t"liable to invoke the wrath of the Gods.  This can result in the object" gag_rename_line2
/def -ag -mglob -t"being destroyed or possibly more severe penalties.  if you feel you" gag_rename_line3
/def -ag -mglob -t"have violated the restrictions, sacrifice it now." gag_rename_line4
/def -ag -mglob -t"See Help christen or Help onoma" gag_rename_line5

;;; ----------------------------------------------------------------------------
;;; Augment/Quicken/Surge highlights
;;; ----------------------------------------------------------------------------
/def -mregexp -ag -p0 -t"You aren't (Augmenting|Quickening|Surging), but you are set to do so at level ([1-9])\." spell_power_off = \
    /echo -pw %%% @{Ccyan}%{P1}: @{hCred}OFF@{nCcyan}.  Level: @{hCyellow}%{P2}@{nCcyan}.

/def -mregexp -ag -p0 -t"You will now attempt to (augment|quicken|surge) your spells by ([1-9])\." spell_power_on = \
    /echo -pw %%% @{Ccyan}%{P1}: @{hCgreen}ON@{nCcyan}.  Level: @{hCyellow}%{P2}@{nCcyan}.

/def -mregexp -ag -p0 -t"Tul-Sith says, 'You will now attempt to augment your healing spells by ([1-9]+)\.'" spell_augment_on = \
    /echo -pw %%% @{Ccyan}Augment: @{hCgreen}ON@{nCcyan}.  Level: @{hCyellow}%{P1}@{nCcyan}.

;;; ----------------------------------------------------------------------------
;;; Deception highlights
;;; ----------------------------------------------------------------------------
/def -mregexp -ahCyellow -t'^([a-zA-Z ]) is not deceived\.' deception_fail
/def -mregexp -ahCwhite -t'^([a-zA-Z ]) frantically attempts to remove (.*)\!'  deception_removed
/def -mregexp -ahCwhite -t'^([a-zA-Z ]) is so disgusted with (.*) she tries to drop it\!' deception_dropped
;; Scramble highlights
/def -mregexp -ahCyellow -t'^Your to scramble has failed due to tranquility\.' scramble_fail_tranq

;; bot gags
/def -ag -mregexp -t"^ASeT says 'tells work\!\!\!\!\!\! tell me help'" gag_aset_tells_work
/def -ag -mregexp -t"^ASeT asks everyone to vote at http\:\/\/www.topmudsites\.com\/vote\-snikt\.html" gag_aset_vote

/def -ag -mregexp -t"^Dox says 'Playerinfo me for spellbot details'" gag_dox_playerinfo_details
/def -ag -mregexp -t"^Dox says 'Let Kra Steel your Skeleton, or give you full spells\!  playerinfo me'" gag_dox_info
/def -ag -mregexp -t"^Dox says ' now offering  regen, tell me regenme when not in a group to get it'" gag_dox_info2
/def -ag -mregexp -t"^Dox says 'You must be group leader or not grouped AND i need to be asleep for it to work'" gag_dox_info3

;;; ----------------------------------------------------------------------------
;;; Identify highlights
;;; ----------------------------------------------------------------------------
/def -mregexp -aCyellow -t'^Weight ([0-9]+), value ([0-9]+), level ([0-9]+).' weight_value_level = \
    /set identifyLastItemWeight=$[strip_attr({P1})]%;\
    /set identifyLastItemValue=$[strip_attr({P2})]%;\
    /set identifyLastItemLevel=$[strip_attr({P3})]

/def -mregexp -aCyellow -t'^Armor class is ([0-9]+).' actrig
/def -mregexp -aCyellow -t'^\'enchant ([a-zA-Z ]+)\'Modifies ([a-zA-Z0-9 ]+) by ([0-9]+) continuous.' enchantmodtrig
/def -mregexp -aCyellow -t'^ Modifies ([a-zA-Z ]+) by ([0-9]+) continuous.' modtrig

;; Item mod highlighting
/def showItemLevel = \
    /toggle showItemLevel%;\
    /echoflag %{showItemLevel} Showing Level

/def -i echoItemLevel = \
    /if ({showItemLevel} == 1 & {identifyLastItemLevel} > 0) \
        /if ({#} > 0) \
            /echo -pw @{Cwhite}%%% @{Cgreen}%{*} - Level %{identifyLastItemLevel}@{n}%;\
        /else \
            /echo -pw @{Cwhite}%%% @{Cgreen}Item Level %{identifyLastItemLevel}@{n}%;\
        /endif%;\
    /endif

/def -ar -mregexp -t"^(.*) glows brightly\, then fades\.\.\.oops\." highlight_enchant_fade = \
    /if ({showItemLevel} == 1) \
        /set identifyLastItemLevel=$[++identifyLastItemLevel]%;\
        /echoItemLevel %{P1}%;\
    /endif

/def -ar -mregexp -t"Nothing seemed to happen\." highlight_enchant_nothing = \
    /if ({showItemLevel} == 1) \
        /echoItemLevel%;\
    /endif

/def -ar -mregexp -t"^.* flares blindingly\.\.\. and evaporates\!" highlight_enchant_evaporate = \
    /if ({showItemLevel} == 1) \
        /set identifyLastItemLevel=-1%;\
    /endif

/def -ar -mregexp -t"^.* shivers violently and explodes\!" highlight_enchant_explode = \
    /if ({showItemLevel} == 1) \
        /set identifyLastItemLevel=-1%;\
    /endif

/def -ar -mregexp -t"^(.*) glows blue." highlight_enchant_weapon_normal = \
    /if ({showItemLevel} == 1) \
        /set identifyLastItemLevel=$[++identifyLastItemLevel]%;\
        /echoItemLevel %{P1}%;\
    /endif

/def -ar -mregexp -t"^(.*) shimmers with a gold aura." highlight_enchant_armor_normal = \
    /if ({showItemLevel} == 1) \
        /set identifyLastItemLevel=$[++identifyLastItemLevel]%;\
        /echoItemLevel %{P1}%;\
    /endif

/def -ar -mregexp -t"^(.*) glows a brilliant (blue|yellow|gold)\!" highlight_enchant_brill = \
    /if ({showItemLevel} == 1) \
        /set identifyLastItemLevel=$[++identifyLastItemLevel]%;\
        /echoItemLevel %{P1}%;\
    /endif

;;; ----------------------------------------------------------------------------
;;; Fae Rune Displaying
;;; ----------------------------------------------------------------------------
/def -ag -Ph -F -t"the fae rune for '(Enslavement|Despair|Destruction|Fatigue|Regeneration)'(.*)" highlight_fae_rune_001 = /test $[echoGearItem(%{PL}, strcat("the fae rune for '", {P1}, "'"),  "token-qp", strcat({P2}, " (10QP)"))]
/def -ag -Ph -F -t"the fae rune for '(Fire|Disease|Insanity|Pain)'(.*)" highlight_fae_rune_002 = /test $[echoGearItem(%{PL}, strcat("the fae rune for '", {P1}, "'"),  "token-qp", strcat({P2}, " (5QP)"))]
/def -ag -Ph -F -t"the fae rune for '(Chaos|Obfuscation)'(.*)" highlight_fae_rune_003 = /test $[echoGearItem(%{PL}, strcat("the fae rune for '", {P1}, "'"),  "token-xp", strcat({P2}, " (400XP)"))]
/def -ag -Ph -F -t"the fae rune for '(Darkness|Drought|Fear|Charm|Entropy)'(.*)" highlight_fae_rune_004 = /test $[echoGearItem(%{PL}, strcat("the fae rune for '", {P1}, "'"),  "token-xp", strcat({P2}, " (300XP)"))]
/def -ag -Ph -F -t"the fae rune for '(Power|Wrath)'(.*)" highlight_fae_rune_005 = /test $[echoGearItem(%{PL}, strcat("the fae rune for '", {P1}, "'"),  "token-xp", strcat({P2}, " (250XP)"))]
/def -ag -Ph -F -t"the fae rune for '(Influence|Corruption)'(.*)" highlight_fae_rune_006 = /test $[echoGearItem(%{PL}, strcat("the fae rune for '", {P1}, "'"),  "token-xp", strcat({P2}, " (200XP)"))]
/def -ag -Ph -F -t"the fae rune for '(Misfortune|Blood|Silence|Apathy|Ice|Vengeance)'(.*)" highlight_fae_rune_007 = /test $[echoGearItem(%{PL}, strcat("the fae rune for '", {P1}, "'"),  "token-xp", strcat({P2}, " (100XP)"))]

;;; ----------------------------------------------------------------------------
;;; Gagging score screen items
;;; ----------------------------------------------------------------------------
/def -ag -mregexp -t"^Character created on:  .*" gag_score_created_on 
/def -ag -mregexp -t"^Buddy  :    .*" gag_score_buddy_channel

;;; 
;;; Deepways pointers
;;;
/def -mglob -p9 -F -t"A forest of fungus" deepways_exit_to_fungal_forest = \
    /echo -pw @{Cred}[AREA INFO]: [Exits: north east south] -- south exit goes to Fungal Forest

