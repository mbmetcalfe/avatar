;;; ---------------------------------------------------------------------------
;;; spellinfo.tf
;;; Miscellaneous triggers and macroes to deal with spells/affects
;;; ---------------------------------------------------------------------------
;; Class types
/set arcType=arc asn dru fus
/set cleType=cle dru pal prs viz
/set magType=mag stm sor wzd
/set monType=mon shf
/set psiType=mnd psi
/set rogType=asn bci rog shf bld
/set noWorshipType=mnd viz

;; Perform any necessary checks.
/def chk = /toggle dochecks%;/echoflag %dochecks Perform Checks
/def dochk = \
    /if ({dochecks}=1) \
;;;    /if ({heichk}=1) heighten %; /endif%; \
        /if ({sanctleft} < 0 & {resanc} = 1) \
            /sanc%;\
        /endif%; \
        /if ({frenleft} < 0 & {refren} = 1) c frenzy%; /endif%; \
        /if ({mysticalleft} < 0 & {refreshmisc} = 1 & regmatch({myclass},{magType})) \
            c 'mystical barrier'%;\
        /endif%; \
    /endif
/def refreshmisc = /toggle refreshmisc%;/echoflag %{refreshmisc} Refresh Miscellaneous

;/def -mglob -t"Nah\.\.\. You feel too relaxed\.\.\." chk_resting = /if ({dochecks} = 1) stand%;/dochk%;rest %; /endif
;/def -mglob -t"You can\'t do that in your sleep\." chk_sleeping = /if ({dochecks} = 1) stand%;/dochk%;sleep %; /endif

;;; ---------------------------------------------------------------------------
;;; Echo missing spells.
;;; ---------------------------------------------------------------------------
/def missing = \
    /if ({fortleft} < 0) /echo -pw % @{Cwhite}Fortitudes @{nCwhite}missing.@{n} %; \
    /endif %; \
    /if (({awenleft} < 0 & {aegisleft} < 0) & \
        ({armorleft} < 0 | {holyarmorleft} < 0 | {holyauraleft} < 0 | {blessleft} < 0)) \
        /echo -pw % @{Cred}Awen@{nCwhite}/@{Cred}Aegis @{nCwhite}missing.@{n} %; \
    /endif %; \
    /if ({focileft} < 0) /echo -pw % @{hCgreen}Foci @{nCwhite}missing.@{n} %; \
    /endif %; \
    /if ({frenleft} < 0) /echo -pw % @{hCred}Frenzy @{nCwhite}missing.@{n}%; \
    /endif %; \
    /if ({myclass} =~ "pal") \
        /if ({fervorleft} < 0) \
            /echo -pw % @{hCcyan}Fervor @{nCwhite}missing.@{n}%; \
        /endif%;\
        /if ({holyzealleft} < 0) \
            /echo -pw % @{hCmagenta}Holy Zeal @{nCwhite}missing.@{n}%; \
        /endif%;\
    /endif%;\
    /if (({racialfrenleft} < 0) & (({myrace}=~"kzn") | ({myrace}=~"orc") | ({myrace}=~"hor") | ({myrace}=~"hob"))) \
        /if ({racialfren} < 0) \
            /echo -pw % @{hCred}Racial Frenzy  @{nCwhite}missing.@{n} %; \
        /else \
            /echo -pw % @{hCred}Racial Frenzy @{nCwhite}is missing but can be reapplied in @{hCred}%{racialfren} @{nCwhite}hours. %; \
        /endif %; \
    /endif %; \
    /if ({canProwl} = 1 & {myrace} =~ "bkd") \
        /if ({racialProwl} < 0) /echo -pw % @{Cblack}Racial Prowl @{nCwhite}missing.@{n}%;\
        /else /echo -pw % @{Cblack}Racial Prowl @{nCwhite}is missing but can be reapplied in @{Cblack}%{racialprowl} @{nCwhite}hours.%;\
        /endif%;\
    /endif%;\
    /if ({sanctleft} < 0) /echo -pw % @{hCwhite}Sanctuary @{nCwhite}missing.@{n} %; \
    /endif %; \
    /if ({ironleft} < 0) /echo -pw % @{Cyellow}Iron Skin @{nCwhite}missing.@{n} %; \
    /endif %; \
    /if ({steelleft} < 0) /echo -pw % @{hCyellow}Steel Skeleton @{nCwhite}missing.@{n} %; \
    /endif %; \
    /if ({barkleft} < 0) /echo -pw % @{Cyellow}Barkskin @{nCwhite}missing.@{n} %; \
    /endif %; \
    /if ({regenleft} < 0) /echo -pw % @{Cmagenta}Regeneration @{nCwhite}missing.@{n} %; \
    /endif %; \
    /if ({blessleft} < 0) /echo -pw % @{hCcyan}Bless @{nCwhite}missing.@{n} %; \
    /endif %; \
    /if ({invincleft} < 0) /echo -pw % @{hCwhite}Invincibility @{nCwhite}missing.@{n} %; \
    /endif %; \
    /if ({waterleft} < 0 & ({myrace} !~ "tua" | {myrace} !~ "liz")) \
        /echo -pw % @{hCblue}Water Breath @{nCwhite}missing.@{n} %; \
    /endif %; \
    /if ({concleft} < 0) /echo -pw % @{Cwhite}Concentrate @{nCwhite}missing.@{n} %; \
    /endif %; \
    /if ({prayerleft} < 0 & regmatch({myclass}, {noWorshipType}) == 0) \
        /echo -pw % @{Ccyan}Prayer @{nCwhite}missing.@{n} %; \
    /endif %; \
    /if ({mysticalleft} < 0 & regmatch({myclass},{magType}) & {myclass} !~ "stm") \
        /echo -pw % @{Cmagenta}Mystical Barrier @{nCwhite}missing.@{n} %; \
    /endif%; \
    /if ({illusoryshieldleft} < 0 & regmatch({myclass},{psiType})) \
        /echo -pw % @{Cmagenta}Illusory Shield @{nCwhite}missing.@{n} %; \
    /endif%; \
    /if ({astralshieldleft} < 0 & regmatch({myclass},{magType}) & {myclass} !~ "sor") \
        /echo -pw % @{hCmagenta}Astral Shield @{nCwhite}missing.@{n}%; \
    /endif%; \
    /if ({savvyleft} < 0 & ({myclass} =~ "asn" | {myclass} =~ "ran" | \
        regmatch({myclass},{magType}) | regmatch({myclass},{psiType}))) \
        /echo -pw % @{hCblue}Savvy @{nCwhite}missing.@{n}%; \
    /endif%; \
    /if ({acumenleft} < 0 & ({myclass} =~ "ran" | {myclass} =~ "mon" | \
             {myclass} =~ "wzd" | regmatch({myclass},{cleType}))) \
        /echo -pw % @{hCblue}Acumen @{nCwhite}missing.@{n}%; \
    /endif%; \
    /if ({savinggraceleft} < 0 & regmatch({myclass}, "cle pal prs viz")) \
        /echo -pw % @{hCRed}Saving Grace @{nCwhite}missing.@{n}%;\
    /endif%;\
    /if ({nightcloakleft} < 0 & {myclass} =~ "bci") \
        /echo -pw % @{hCyellow}Nightcloak @{nCwhite}missing.@{n}%; \
    /endif%;\
    /if ({mytier} =~ "lord" & {consummationleft} < 0 & ({myclass} =~ "mon" | {myclass} =~ "shf")) \
        /echo -pw % @{hCyellow}Consummation @{nCwhite}missing.@{n}%;\
    /endif%;\
    /if ({myclass} =~ "mon") \
        /if ({blinddevotionleft} < 0 & {mytier} =~ "lord") \
            /echo -pw % @{hCyellow}Blind Devotion @{nCwhite}missing.@{n}%;\
        /endif%;\
    /endif%;\
    /if ({myclass} =~ "mon" | {myclass} =~ "shf") \
        /if ({daggerhandleft} < 0 & {stonefistleft} < 0) \
            /echo -pw % @{hCmagenta}Dagger Hand @{nCwhite}| @{hCmagenta}Stone Fist @{nCwhite}missing.@{n}%;\
        /endif%;\
    /endif%;\
    /if ({myclass} =~ "sor") \
        /if ({deathshroudleft} < 0) \
            /echo -pw % @{hCblack}Death Shroud @{nCwhite}missing.@{n}%; \
        /endif%;\
        /if ({defiledfleshleft} < 0) \
            /echo -pw % @{hCred}Defiled Flesh @{nCwhite}missing.@{n}%; \
        /endif%;\
        /if ({immolationleft} < 0) \
            /echo -pw % @{hCyellow}Immolation @{nCwhite}missing.@{n}%; \
        /endif%;\
        /if ({astralprisonleft} < 0) \
            /echo -pw % @{hCyellow}Astral Prison @{nCwhite}missing.@{n}%; \
        /endif%;\
        /if ({taintleft} < 0) \
            /if ({exhaust_taint} < 0) \
                /echo -pw % @{hCyellow}Tainted Genius @{nCwhite}missing.@{n}%; \
            /else \
                /echo -pw % @{hCyellow}Taint Exhausts in @{nCwhite}%{exhaust_taint} @{hCyellow}hours.@{n}%;\
            /endif%;\
        /endif%;\
    /elseif ({myclass} =~ "psi") \
        /if ({fotmleft} < 0) \
            /echo -pw % @{hCmagenta}Fury of the Mind @{nCwhite}missing.@{n}%;\
        /endif%;\
        /if ({kineticchainleft} < 0) \
            /if ({exhaust_kineticchain} < 0) \
                /echo -pw % @{hCyellow}Kinetic Chain @{nCwhite}missing.@{n}%; \
            /else \
                /echo -pw % @{hCyellow}Kinetic Chain Exhausts in @{nCwhite}%{exhaust_kineticchain} @{hCyellow}hours.@{n}%;\
            /endif%;\
        /endif%;\
        /if ({stunningweaponleft} < 0 & {disablingweaponleft} < 0 & {distractingweaponleft} < 0) \
            /echo -pw % @{Cyellow}Missing Kinetic Enhancer (@{Cwhite}disabling@{Cyellow}|@{Cwhite}stunning@{Cyellow}|@{Cwhite}distracting@{Cyellow})@{n}%;\
        /endif%;\
    /elseif ({myclass} =~ "prs") \
        /if ({interventionleft} < 0) \
            /echo -pw % @{hCblue}Intervention @{nCwhite}missing.@{n}%;\
        /endif%;\
        /if ({exhaust_intervention} >= 0) \
            /echo -pw % @{hCblue}Intervention exhausts in @{nCwhite}%{exhaust_intervention} @{nCwhite}hours.@{n}%;\
        /endif%;\
    /elseif ({myclass} =~ "cle") \
        /if ({gloriousconquestleft} < 0) \
            /echo -pw % @{hCblue}Glorious Conquest @{nCwhite}missing.@{n}%;\
        /endif%;\
    /endif

;;; ---------------------------------------------------------------------------
;;; Reset durations
;;; ---------------------------------------------------------------------------
/set checkSpecific=0
/def -mglob -ahCwhite -t'You are not under the affects of any spells or skills.' durationreset2 = /durationreset
/def -mglob -ag -t'You are affected by:' durationreset = \
    /if ({affectspam} = 1) /echo -pw @{hCwhite}You are affected by:@{n}%;\
    /else /echo -pw @{hCwhite}You are affected by @{nCred}(Suppressed}@{hCwhite}:@{n}%;\
    /endif%;\
    /if ({checkSpecific} == 0)\
        /set frenleft=-1 %; /set sanctleft=-1 %; /set ironleft=-1 %; \
        /set steelleft=-1 %; /set barkleft=-1 %; /set concleft=-1 %; \
        /set regenleft=-1  %; /set invincleft=-1 %; /set fortleft=-1 %; \
        /set awenleft=-1 %; /set focileft=-1 %;/set aegisleft=-1 %;\
        /set waterleft=-1%;/set fervorleft=-1%;/set blessleft=-1%; \
        /set armorleft=-1%;/set holyarmorleft=-1%;/set holyauraleft=-1%;/set blessleft=-1%;\
        /set mysticalleft=-1 %; /set astralshieldleft=-1%;/set illusoryshieldleft=-1%;\
        /set defiledfleshleft=-1%;/set taintleft=-1%;/set exhaust_taint=-1%;\
        /set kineticchainleft=-1%;/set exhaust_kineticchain=-1%;\
        /set savinggraceleft=-1%;/set intervetionleft=-1%;/set exhaust_intervention=-1%;\
        /set fotmleft=-1%;/set gloriousconquestleft=-1%;\
        /set racialfren=-1 %; /set racialfrenleft=-1 %;\
        /set prayerleft=-1 %; /set prayaff=nothing %; \
        /set savvyleft=-1 %; /set acumenleft=-1 %; \
        /set consummationleft=-1%;/set blinddevotionleft=-1%;\
        /set nightcloakleft=-1%;/set deathshroudleft=-1%;/set immolationleft=-1%; \
        /set poisonleft=-1 %; /set poisonaff=nothing%;/set numpoison=0 %; \
        /set biotoxinleft=-1 %; /set biotoxinaff=nothing%;/set numbiotoxin=0 %; \
        /set toxinleft=-1 %; /set toxinaff=nothing%;/set numtoxin=0 %; \
        /set venomleft=-1 %; /set venomaff=nothing%;/set numvenom=0 %; \
        /set heartbaneleft=-1 %; /set heartbaneaff=nothing%;/set numheartbane=0 %; \
        /set doomtoxinleft=-1 %; /set doomtoxinaff=nothing%;/set numdoomtoxin=0 %; \
        /set plagueleft=-1 %; /set plagueaff=nothing%;/set numplague=0 %; \
        /set virusleft=-1 %; /set virusaff=nothing%;/set numvirus=0 %; \
        /set necrotialeft=-1 %; /set necrotiaaff=nothing%;/set numnecrotia=0 %; \
        /set fearleft=-1 %; /set fearaff=nothing %; \
        /set curseleft=-1 %; /set curseaff=nothing%;/set numcurse=0  %; \
        /set scrambleleft=-1 %; /set scrambleaff=nothing%;/set numscramble=0 %; \
        /set webleft=0%;/set webaff=nothing%;/set numweb=0%;\
        /set enduranceleft=-1%;/set enduranceaff=nothing%;\
        /set solitudeleft=-999%;/set holyzealleft=-1%;\
        /set racialprowl=-1%;/set canProwl=0%;\
        /set disablingweaponleft=-1%;/set stunningweaponleft=-1%;/set distractingweaponleft=-1%;\
        /set astralprisonleft=-1%;/set vilephilosophyleft=-1%;\
        /set sick_poison=0%;/set sick_disease=0%;/set sick_deathsdoor=0%;/set sick_web=0%;\
        /set sick_rupture=0%;/set sick_blind=0%;/unset sick_other%;\
        /set daggerhandleft=-1%;/set stonefistleft=-1%;\
    /else \
        /def generalPromptHookCheck = /set checkSpecific=0%;\
    /endif

;;; Savespell scripts
/def -p1 -mglob -t"You gain foci." savespell_gain_foci = \
  /if (mytier!~"lord") /send config +savespell%;/endif

/def -p1 -mglob -t"Teacup shoos you away, what a jerk!" check_affects = /send affect
/def -p1 -mglob -t"Yagharek tells the group 'And we're done!'" check_affects2 = /send affect
/def -p1 -mglob -t"Kaliver tells the group 'Last chance to config your savespell (if needed) before I cast sanc!'" check_affects2 = /send affect

;;; ---------------------------------------------------------------------------
;;; Script to cast any self buffs
;;; ---------------------------------------------------------------------------
;; Grab first item in the list and cast it as a spell.  If spell is multiple
;; words, enclose it with ''.
/def -i processBuffs = \
    /let _buffs=%{*}%;\
    /while (_buffs!~"") \
        /let off=$[strchr(_buffs,"#")]%; \
        /if (off>-1) \
            /let _this_buff=$[substr(_buffs,0,off)]%; \
            /let _buffs=$[substr(_buffs,off+1)]%; \
        /else \
            /let _this_buff=%_buffs%; \
            /let _buffs=%; \
        /endif%; \
        /eval cast '%{_this_buff}'%; \
    /done

/def selfbuff = \
    /if ({#}=1 & {1} =~ "show") \
        /let _mybuffs=$[replace("#", "@{Cwhite}, @{Ccyan}", self_buffs)]%;\
        /echo -pw %% My buffs: @{Ccyan}%{_mybuffs}@{n}%;\
    /else \
        /selfbuff show%;\
        /if ({mytier} !~ "lord") \
            /send config +savespell%;\
        /endif%;\
        /if ({#}=1 & {1} > 1) \
            /send quicken %{1}%;\
        /endif%;\
        /processBuffs %{self_buffs}%;\
        /if ({#}=1 & {1} > 1) /send quicken off%;/endif%;\
    /endif
    
;;; ---------------------------------------------------------------------------
;;; Spell fades
;;; ---------------------------------------------------------------------------
/def refreshSkill = \
    /if ({currentPosition} =~ "stand" & {mudLag} < 3) \
        /eval %{*}%;\
    /else \
        /aq %{*}%;\
    /endif
/def refreshSpell = \
    /if ({currentPosition} =~ "stand" & {mudLag} < 3) \
        cast %{*}%;\
    /else \
        /aq cast %{*}%;\
    /endif
/def -mglob -aCwhite -t'You feel less focused\.' concdrop = /set concleft=-1%;/set ticktoggle=1
/def -mglob -aCyellow -t'Your skin returns to normal\.' barkdrop = /set barkleft=-1%;/set ticktoggle=1
/def -mglob -aCmagenta -t'Your pulse slows and your body returns to normal\.' regendrop = /set regenleft=-1%;/set ticktoggle=1
/def -mglob -aCwhite -t'You feel more exposed as your Nightcloak fades.' nightcloakdrop = /set nightcloakleft=-1%;/set ticktoggle=1
/def -mregexp -aCwhite -p1 -t'Your illusory shield dissipates.' illusoryshielddrop = \
    /set illusoryshieldleft=-1%;\
    /if ({refreshmisc} == 1) c 'illusory shield'%;/endif
/def -mglob -aCwhite -t'You can no longer support your kinetic chain and it snaps.' kineticchaindrop = /set kineticchainleft=-1%;/set ticktoggle=1
/def -mglob -aCwhite -t'You no longer are attuned to the anger of your allies.' fotmdrop = /set fotmleft=-1%;/set ticktoggle=1
/def -mglob -t'You are no longer due divine intervention.' interventiondrop = /set interventionleft=-1
/def -mglob -t'Your force shield shimmers then fades away.' focidrop = /set focileft=-1%;/send config -savespell%;/set ticktoggle=1
/def -mregexp -t'^You no longer move hidden.' re_movehidden = \
    /refreshSkill move%;\
    /set movehiddenleft=-1%;/set ticktoggle=1
/def -mregexp -t'^You no longer feel stealthy.' re_sneak = \
    /refreshSkill sneak%;\
    /set sneakleft=-1%;/set ticktoggle=1
/def -mregexp -t'^You no longer move in the shadows.' re_shadow = \
    /refreshSkill shadow%;\
    /set shadowleft=-1%;/set ticktoggle=1

/def -mglob -ahCmagenta -t"Your mystical barrier shimmers and is gone." mysticaldrop = \
    /set mysticalleft=-1%;/set ticktoggle=1%;\
    /if ({refreshmisc} == 1) \
        /refreshSpell 'mystical barrier'%;\
    /endif

/def -mglob -ahCmagenta -t"The grey shroud of death fades." death_shroud_drop = \
    /set deathshroudleft=-1%;/set ticktoggle=1%; \
    /if ({refreshmisc} == 1) \
        /refreshSpell 'death shroud'%;\
    /endif
/def -mglob -ahCred -t"Your flesh heals of its defilement." defiled_flesh_drop = \
    /set defiledfleshleft=-1%;/set ticktoggle=1%;\
    /if ({refreshmisc} == 1) /refreshSpell 'defiled flesh'%;/endif

/def -mglob -ahCmagenta -t"You feel less zealous." holy_zeal_drop = \
    /set holyzealleft=-1%;/set ticktoggle=1%;\
    /if ({refreshmisc} == 1) \
        /refreshSpell 'holy zeal'%;\
    /endif

/def -p5 -mglob -t"You concentrate on the darker tenets of your vile philosophy." vilephilosophyup = /set vilephilosophy=999
/def -p5 -mglob -t"You purge your mind of some of your darker thoughts." vilephilosophydrop = \
    /set vilephilosophy=-1%;/set ticktoggle=1%; \
    /if ({refreshmisc} == 1) cast 'vile philosophy'%;/endif

/def -mglob -aCwhite -t"The soul screams in anguish as it is tied to you." immolationup = /set immolationleft=999
/def -mglob -aCwhite -t"The power of your immolation disappears." immolationdrop = /set immolationleft=-1%;/set ticktoggle=1

/def -mglob -ah -t"The prison shrinks into a floating red crystal. The soul pulses slowly." astralprisonup = /set astralprisonleft=999
/def -mglob -aCwhite -t"You already are leeching power off of a trapped soul." astralprisonup2 = /set astralprisonleft=999
/def -mglob -aCwhite -t"The time is ripe to trap a new soul." astralprisondrop = /set astralprisonleft=999

/def -mregexp -t"(Your senses return to normal|You fail to heighten your senses)" hei_trig = \
    /if ({refreshmisc} == 1) /refreshSkill heighten%;/endif%;\
    /set ticktoggle=1
;/def -mglob -t"Your senses return to normal." heitrig = /set heichk=1 %; /send hei
;/def -mglob -t"You fail to heighten your senses." heitrig2 = /send hei
/def -mregexp -t"^Your senses are (completely|partially|already) heightened[\.!]$" heitrig5 = /set heichk=0

;;; these next two detect fortitudes/awen drop, but it is a bad hack
/def -mglob -t'You no longer disperse energy\.' fortdrop = /set fortleft=-1%;/set ticktoggle=1
/def -mglob -t'You feel less protected\.' awendrop = /set awenleft=-1%;/set ticktoggle=1

/def -mregexp -aCcyan -t'^Almighty Gorn\'s presence disappears.' gorn_prayerdrop = \
    /set prayerleft=-1%;\
    /set ticktoggle=1%;\
    /set checkSpecific=1

/def -mglob -ahCwhite -t'The protective aura fades from around your body\.' sancdrop = \
    /set sanctleft=-1%;/set ticktoggle=1%; \
    /if ({resanc} == 1) \
        /refreshSkill /sanc%;\
    /else /send emote 's |bw|Sanctuary|n| is gone.%;\
    /endif

/def -mregexp -aCcyan -t"^(Werredan|Bhyss|Shizaga|Gorn|Kra|Tul\-Sith|Quixoltan)\'s presence disappears." prayer_drop = \
    /set prayerleft=-1%;\
    /set ticktoggle=1%;\
    /set checkSpecific=1

/def -mregexp -t"^(Werredan|Bhyss|Shizaga|Gorn|Kra|Tul\-Sith|Quixoltan)\'s fanatical blessing fades away." fervor_drop2 = \
    /set fervorleft=-1%;/set ticktoggle=1%;\
    /if ({refren} = 1) /refreshSpell fervor%;\
    /else /send emote 's |bc|Fervor|n| is gone.%;/endif

/def -mglob -ahCred -t'You slowly come out of your rage\.' frenzydrop = \
    /set frenleft=-1%;/set ticktoggle=1 %; \
    /if ({refren} = 1 & {myclass} =~ "pal") \
        /refreshSpell fervor%;\
    /elseif ({refren} = 1) \
        /refreshSkill /fren%;\
    /else /send emote 's |br|Frenzy|n| is gone.%;\
    /endif

/def -mglob -ahCwhite -t'Your Iron Monk style fades\.' monkgone = \
    /set sancteft=-1%;/set ticktoggle=1 %; \
    /if ({resanc} = 1) \
        /refreshSkill /im%;\
    /else /send emote 's |bw|Iron Monk|n| is gone.%;\
    /endif 

/def -mregexp -ahCMagenta -t'^The pink aura around you fades away.' pinkfade = /set ticktoggle=1
/def -mregexp -ahCblue -t'^Your lungs adapt to oxygen once again.' waterfade = /set waterleft=-1%;/set ticktoggle=1
/def -mregexp -ah -t'^You feel less sick.' feellesssick = /send emote 's |y|sickness |n|has been cleared.
/def -mregexp -ah -t'^Your sores vanish.' plaguedrop = /send emote 's |br|plague |n|has been cured.

;;; ---------------------------------------------------------------------------
;;; Spell Refresh
;;; ---------------------------------------------------------------------------
/def -mglob -aCblack -t"You cloak your presence." nightcloakup = /set nightcloakleft=999
/def -mglob -aCmagenta -t"You are surrounded by a mystical barrier." mysticalup = \
    /set mysticalleft=999%;\
    /set checkSpecific=1%;\
	/send aff ?foci=aff ?mystical barrier
/def -mregexp -ahCred -t"(You are filled with rage|You are already in a frenzy)" self_frenzied = \
	/set frenleft=999%;\
    /set checkSpecific=1%;\
    /send aff ?foci=aff ?frenzy
/def -mregexp -ahCcyan -t"^(Werredan|Shizaga|Gorn|Kra|Tul\-Sith|Quixoltan) causes you to rage in fanatical fervor." self_fervored = \
	/set fervorleft=999%;\
    /set checkSpecific=1%;\
    /send aff ?foci=aff ?fervor
/def -mregexp -ahCcyan -t"^(Werredan|Shizaga|Gorn|Kra|Tul\-Sith|Quixoltan) sees no need to bestow a blessing upon you." self_already_fervored = \
	/set fervorleft=999%;\
    /set checkSpecific=1%;\
    /send aff ?foci=aff ?fervor
/def -mregexp -ahCwhite -t"(You are surrounded by a white aura|You are surrounded by a black aura|You are already in sanctuary)" self_sancted = \
    /set sanctleft=999%;\
    /set checkSpecific=1%;\
    /send aff ?foci=aff ?sanctuary
/def -mglob -ahCwhite -t"* surrounds you with sanctuary\!" self_sancted2 = \
    /set sanctleft=999;\
    /set checkSpecific=1%;\
    /send aff ?foci=aff ?sanctuary
/def -mglob -ahCwhite -t"* is surrounded by *'s sanctuary." other_sancted
/def -mregexp -ahCwhite -t"(You are already Glowing|You concentrate on the Iron Monk style)" self_already_im = \
    /set sanctleft=999;\
    /set checkSpecific=1%;\
    /send aff ?foci=aff ?iron monk
/def -mregexp -aCWhite -t"(You now have a death shroud\.|You are already shrouded\.)" self_already_shrouded = /set deathshroudleft=999
/def -mregexp -t"(Your offering of flesh is eagerly accepted\!|You're about as defiled as you're going to get.)" self_defiled_flesh = /set defiledfleshleft=999
/def -mglob -aCwhite -t'You attune your mind to the anger of your allies.' fotmup = /set fotmleft=999
/def -mglob -aCwhite -t'You develop a strong kinetic link with your weapons.' kineticchainup = /set kineticchainleft=999
/def -mglob -aCwhite -t'You project your thoughts and an illusion appears.' illusoryshieldup = /set illusoryshieldleft=999
/def -mglob -t'The Gods agree to intervene on your behalf!' interventionup = \
    /set interventionleft=999%;\
    /set exhaust_intervention=3
/def -mregexp -t'^([a-zA-Z]+) is already protected by Divine Intervention\!' interventionalreadyup = \
    /if ({P1} =~ ${world_character}) \
        /set interventionleft=999%;\
        /set exhaust_intervention=3%;\
    /endif
/def -mglob -ahCmagenta -t"You are consumed by holy zeal." holy_zeal_up = \
	/set holyzealleft=999%;\
    /set checkSpecific=1%;\
    /send aff ?foci=aff ?zeal

/def -mregexp -t'^You pray to .* for the .* boon\.' prayer_up = \
    /set prayerleft=999%;\
    /set checkSpecific=1%;\
    /send aff ?foci=aff ?prayer

/def -mglob -ahCmagenta -t"You focus on the Stone Fist technique." stone_fist_up = /set stonefistleft=999
/def -mglob -ahCmagenta -t"You focus on the Dagger Hand technique." dagger_hand_up = /set daggerhandleft=999

;;; ---------------------------------------------------------------------------
;;; Exhaustion
;;; ---------------------------------------------------------------------------
/def -ag -mregexp -t"^Exhausted Spell: '([a-zA-Z\ ]+)'[ ]+unavailable for ([0-9]+) hours\." exhaust_left = \
    /if ({P1} =~ "tainted genius") \
        /set exhaust_taint=%P2%;\
    /elseif ({P1} =~ "kinetic chain") \
        /set exhaust_kineticchain=%P2%;\
    /elseif ({P1} =~ "intervention") \
        /set exhaust_intervention=%P2%;\
    /endif%;\
    /echo -pw @{Cred}Exhausted Spell: '@{hCwhite}%P1@{nCred}' unavailable for @{hCwhite}%P2@{nCred} hours.@{n}

;;; ---------------------------------------------------------------------------
;;; Specific spell highlight, etc
;;; ---------------------------------------------------------------------------
/def -mregexp -aCmagenta -p2 -t'^Spell: \'faerie fire\'  modifies armor class by ([0-9\-]+) for ([0-9]+) hours.' affpink
/def -mregexp -ag -p2 -t'^Spell: \'tainted genius\'  modifies experience gain multiplier by \* ([0-9]+) for ([0-9]+) hours.' taintleft = \
    /set taintleft=%P2%; \
    /if ({qryspell} =~ substr("tainted genius",0,strlen({qryspell}))) \
           /echo -pw @{hCwhite}Spell: '@{nCmagenta}tainted genius@{hCwhite}' modifies experience gain multiplier by @{nCwhite}%P1 @{hCwhite}for @{Cmagenta}%{P2} @{hCwhite}hours. %; \
        /set qryspellnum=$[--qryspellnum]%;\
        /if ({qryspellnum} <= 0) \
            /set qryspell=emptyvalue%;\
        /endif%;\
    /else \
        /echoaffects @{nCwhite}Spell: '@{nCmagenta}tainted genius@{nCwhite}' modifies experience gain multiplier by @{nCwhite}%P1 @{nCwhite}for @{Cmagenta}%{P2} @{nCwhite}hours. %; \
    /endif

/def -mregexp -ag -p2 -t'^Spell: \'nightcloak\'  modifies stealth by \+ ([0-9]+)\% for ([0-9]+) hours.' nightcloak_aff = \
    /set nightcloakleft=%P2%; \
    /if ({qryspell} =~ substr("nightcloak",0,strlen({qryspell}))) \
           /echo -pw @{hCwhite}Spell: '@{nCblack}nightcloak@{hCwhite}' modifies stealth by @{nCwhite}%P1 @{hCwhite}for @{Cblack}%{P2} @{hCwhite}hours. %; \
        /set qryspellnum=$[--qryspellnum]%;\
        /if ({qryspellnum} <= 0) \
            /set qryspell=emptyvalue%;\
        /endif%;\
    /else \
        /echoaffects @{nCwhite}Spell: '@{nCblack}nightcloak@{nCwhite}' modifies stealth by @{nCwhite}%P1 @{nCwhite}for @{Cblack}%{P2} @{nCwhite}hours. %; \
    /endif

/def -mregexp -ag -p2 -t'^Spell: \'regeneration\'  modifies ([a-zA-Z]+) regeneration by ([0-9\*\-\/ ]+) for ([0-9]+) hours.' regenleft = \
    /set regenleft=%P3%; \
    /if ({qryspell} =~ substr("regeneration",0,strlen({qryspell}))) \
        /echo -pw @{hCwhite}Spell: '@{nCmagenta}regeneration@{hCwhite}' modifies @{nCwhite}%P1 @{hCwhite}by @{Cwhite}%P2 @{hCwhite}for @{Cmagenta}%{P3} @{hCwhite}hours. %; \
        /set qryspellnum=$[--qryspellnum]%;\
        /if ({qryspellnum} <= 0) \
            /set qryspell=emptyvalue%;\
        /endif%;\
    /else \
        /echoaffects @{Cgreen}Spell: '@{Cmagenta}regeneration@{nCgreen}' modifies @{Cwhite}%P1 @{nCgreen}by @{Cwhite}%P2 @{nCgreen}for @{Cmagenta}%{P3} @{nCgreen}hours. %; \
    /endif

/def -mregexp -ag -p1 -t"^Spell: 'heartbane'  modifies hp for ([0-9]+) hours." heartbaneaff = \
    /set heartbaneleft=%P1 %; \
    /set heartbaneaff=hp %; \
    /if ({qryspell} =~ substr("heartbane",0,strlen({qryspell}))) \
        /echo -pw  @{hCwhite}Spell: '@{nCred}heartbane@{hCwhite}' modifies @{nCwhite}hp @{hCwhite}for @{nCred}%{P1} @{hCwhite}hours.%; \
        /set qryspellnum=$[--qryspellnum]%;\
        /if ({qryspellnum} <= 0) \
            /set qryspell=emptyvalue%;\
        /endif%;\
    /else \
        /echoaffects @{Cgreen}Spell: '@{Cred}heartbane@{nCgreen}' modifies @{Cwhite}hp @{nCgreen}for @{nCred}%{P1} @{nCgreen}hours.%; \
    /endif

;;; ---------------------------------------------------------------------------
;;; Solitude
;;; ---------------------------------------------------------------------------
;Spell: 'racial devour'  modifies melee power by + 10% for 1 hours.

/def -mregexp -ah -p99 -t'^Your solitude ends.' solitude_down = /set solitudeleft=-1%;/set ticktoggle=1
/def -mregexp -ah -p99 -t'^Suddenly, you feel very alone\!' solitude_up = /set solitudeleft=999

;;; ---------------------------------------------------------------------------
;;; Cleric auras
;;; ---------------------------------------------------------------------------
/def -mregexp -ag -p1 -t"^Spell: 'glorious conquest'  by \+ ([0-9]+)\% for ([0-9]+) hours." cle_aura_glorious_conquest_aff = \
    /set gloriousconquestleft=%{P2}%; \
    /if ({qryspell} =~ substr("glorious",0,strlen({qryspell}))) \
        /echo -pw @{hCwhite}Spell: '@{nCblue}glorious conquest@{hCwhite}' by @{nCwhite}%{P1} @{hCwhite}for @{hCwhite}for @{Cblue}%{P2} @{hCwhite}hours. %; \
        /set qryspellnum=$[--qryspellnum]%;\
        /if ({qryspellnum} <= 0) \
            /set qryspell=emptyvalue%;\
        /endif%;\
    /else \
        /echoaffects @{Cgreen}Spell: '@{Cblue}glorious conquest@{nCgreen}' by @{Cwhite}%{P1} @{nCgreen}for @{Cblue}%{P2} @{nCgreen}hours. %; \
    /endif

;;; ---------------------------------------------------------------------------
;;; General spell highlighting
;;; ---------------------------------------------------------------------------
/def -mregexp -ag -p1 -t'^Spell: \'([a-zA-Z ]+)\'  for ([0-9\-]+) hours.' spellforaff = \
    /let color=@{hCyellow} %; \
    /if ({P1} =~ "awen") \
        /set awenleft=%P2 %; \
        /let color=@{Cred} %; \
    /elseif ({P1} =~ "aegis") \
        /set aegisleft=%P2 %; \
        /let color=@{Cred} %; \
    /elseif ({P1} =~ "fortitudes") \
        /set fortleft=%P2 %; \
        /let color=@{Cwhite} %; \
    /elseif ({P1} =~ "foci") \
        /set focileft=%P2 %; \
        /let color=@{hCgreen} %; \
    /elseif ({P1} =~ "sanctuary") \
        /set sanctleft %P2 %; \
        /let color=@{hCwhite} %; \
        /if ({running} == 1 & {sanctleft} >= {focileft} & {resanc} == 1) /resanc%;/endif%;\
    /elseif ({P1} =~ "iron monk") \
        /set sanctleft=%P2 %; \
        /let color=@{hCwhite} %; \
        /if ({running} == 1 & {sanctleft} >= {focileft} & {resanc} == 1) /resanc%;/endif%;\
    /elseif ({P1} =~ "water breathing") \
        /set waterleft=%P2 %; \
        /let color=@{hCblue} %; \
    /elseif ({P1} =~ "demonfire") \
        /let color=@{Cblack} %; \
        /set demonfireleft=%P2 %; \
    /elseif ({P1} =~ "farstride") \
        /let color=@{Cgreen} %; \
    /elseif ({P1} =~ "mystical barrier") \
        /let color=@{Cmagenta} %; \
        /set mysticalleft=%P2 %; \
        /if ({running} == 1 & {mysticalleft} >= {focileft} & {refreshmisc} == 1) /refreshmisc%;/endif%;\
    /elseif ({P1} =~ "illusory shield") \
        /let color=@{Cmagenta} %; \
        /set illusoryshieldleft=%P2 %; \
    /elseif ({P1} =~ "astral shield") \
        /let color=@{hCmagenta} %; \
        /set astralshieldleft=%P2 %; \
    /elseif ({P1} =~ "consummation") \
        /let color=@{hCyellow}%; \
        /set consummationleft=%P2%; \
    /elseif ({P1} =~ "blind devotion") \
        /let color=@{hCyellow}%; \
        /set blinddevotionleft=%P2%; \
    /elseif ({P1} =~ "death shroud") \
        /let color=@{hCyellow}%; \
        /set deathshroudleft=%P2%; \
    /elseif ({P1} =~ "immolation") \
        /let color=@{hCyellow}%; \
        /set immolationleft=%P2%; \
    /elseif ({P1} =~ "astral prison") \
        /let color=@{hCyellow}%; \
        /set astralprisonleft=%P2%; \
    /elseif ({P1} =~ "kinetic chain") \
        /let color=@{hCyellow}%; \
        /set kineticchainleft=%P2%; \
    /elseif ({P1} =~ "fury of the mind") \
        /let color=@{hCyellow}%; \
        /set fotmleft=%P2%;\
    /elseif ({P1} =~ "intervention") \
        /let color=@{hCblue}%;\
        /set interventionleft=%P2%;\
    /elseif ({P1} =~ "stunning weapon") \
        /let color=@{Cyellow}%;\
        /set stunningweaponleft=%P2%;\
    /elseif ({P1} =~ "disabling weapon") \
        /let color=@{Cyellow}%;\
        /set disablingweaponleft=%P2%;\
    /elseif ({P1} =~ "distract weapon") \
        /let color=@{Cyellow}%;\
        /set distractingweaponleft=%P2%;\
    /endif%;\
    /if ({qryspell} =~ substr({P1},0,strlen({qryspell}))) \
        /echo -pw @{hCwhite}Spell: '%{color}%{P1}@{hCwhite}' for %{color}%{P2} @{hCwhite} hours.@{n}%; \
        /set qryspellnum=$[--qryspellnum]%;\
        /if ({qryspellnum} <= 0) \
            /set qryspell=emptyvalue%;\
        /endif%;\
    /else \
        /echoaffects @{Cgreen}Spell: '%{color}%{P1}@{nCgreen}' for %{color}%{P2} @{nCgreen} hours.%; \
    /endif

/def -mregexp -ag -p1 -t'^Spell: \'([a-zA-Z ]+)\' *continuous.' spellforaffcont = \
    /let colour=@{hCyellow}%;\
    /if ({P1} =~ "sanctuary") \
        /set sanctleft=999%;\
        /let colour=@{hCwhite}%;\
    /endif%;\
    /if ({qryspell} =~ substr({P1},0,strlen({qryspell}))) \
        /echo -pw @{hCwhite}Spell: '%{hCyellow}%{P1}@{hCwhite}' continuous.%;\
        /set qryspellnum=$[--qryspellnum]%;\
        /if ({qryspellnum} <= 0) \
            /set qryspell=emptyvalue%;\
        /endif%;\
    /else /echoaffects @{Cgreen}Spell: '%{colour}%P1@{nCgreen}' continuous.%;\
    /endif

/def -mregexp -ag -p1 -t'^Spell: \'([a-zA-Z ]+)\'  (seems|for) ([a-zA-Z\ ]+).' spellforaff2 = \
    /if ({P3} =/ "seemingly forever") /let durLeft=>50%;\
    /elseif ({P3} =/ "a very long time") /let durLeft=<51%;\
    /elseif ({P3} =/ "a long time") /let durLeft=<26%;\
    /elseif ({P3} =/ "a while") /let durLeft=<11%;\
    /elseif ({P3} =/ "a small amount of time") /let durLeft=<6%;\
    /elseif ({P3} =/ "a tiny amount of time") /let durLeft=<4%;\
    /elseif ({P3} =/ "to be wavering") /let durLeft=<2%;\
    /else /let durLeft=%{P3}%;\
    /endif%;\
    /if ({P1} =/ "poison") \
        /let color=@{Cred} %; \
        /set poisonleft=%durLeft %; \
        /set poisonaff=unknown%; \
        /set numpoison=$[++numpoison]%;\
    /elseif ({P1} =/ "biotoxin") \
        /let color=@{Cred} %; \
        /set biotoxinleft=%durLeft%; \
        /set biotoxinaff=unknown %; \
        /set numbiotoxin=$[++numbiotoxin]%;\
    /elseif ({P1} =/ "toxin") \
        /let color=@{Cred} %; \
        /set toxinleft=%durLeft%; \
        /set toxinaff=%unknown%; \
        /set numtoxin=$[++numtoxin]%;\
    /elseif ({P1} =/ "venom") \
        /let color=@{Cred} %; \
        /set venomleft=%P4 %; \
        /set venomaff=unknown%; \
    /elseif ({P1} =/ "doom toxin") \
        /let color=@{Cred} %; \
        /set doomtoxinleft=%durLeft %; \
        /set doomtoxinaff=unknwon%; \
        /set numdoomtoxin=$[++numdoomtoxin]%;\
    /elseif ({P1} =/ "plague") \
        /let color=@{Cred} %; \
        /set plagueleft=%durLeft%; \
        /set plagueaff=unknown%; \
        /set numplague=$[++numplague]%;\
    /elseif ({P1} =/ "virus") \
        /let color=@{Cred} %; \
        /set virusleft=%durLeft%; \
        /set virusaff=unknown%; \
        /set numvirus=$[++numvirus]%;\
    /elseif ({P1} =/ "necrotia") \
        /let color=@{Cred} %; \
        /set necrotialeft=%durLeft%; \
        /set necrotiaaff=unknown%; \
        /set numnecrotia=$[++numdnecrotia]%;\
    /elseif ({P1} =/ "fear") \
        /let color=@{Cblack} %; \
        /set fearleft=%durLeft%; \
        /set fearaff=unknown%; \
    /elseif ({P1} =/ "curse") \
        /let color=@{Cblack} %; \
        /set curseleft=%durLeft%; \
        /set curseaff=unknown%; \
        /set numcurse=$[++numcurse]%;\
    /elseif ({P1} =/ "scramble") \
        /let color=@{Cblack} %; \
        /set scrambleleft=%durLeft%; \
        /set scrambleaff=unknown%; \
        /set numscramble=$[++numscramble]%;\
    /elseif ({P1} =/ "web") \
        /let color=@{hCgreen} %; \
        /set webleft=%durLeft%; \
        /set webaff=unknown%; \
        /set numweb=$[++webnum]%;\
    /else /let color=@{hCyellow}%;\
    /endif %; \
    /if ({qryspell} =~ substr({P1},0,strlen({qryspell}))) \
        /echo -pw @{hCwhite}Spell: '%{color}%{P1}@{hCwhite}' for %{color}%{durLeft} @{hCwhite}hours.@{n}%; \
        /set qryspellnum=$[--qryspellnum]%;\
        /if ({qryspellnum} <= 0) \
            /set qryspell=emptyvalue%;\
        /endif%;\
    /else \
        /echoaffects @{Cgreen}Spell: '%{color}%{P1}@{nCgreen}' for %{color}%{durLeft} @{nCgreen} hours.%; \
    /endif

/def -mregexp -ag -p1 -t'^Spell: \'([a-zA-Z ]+)\'  modifies ([a-zA-Z ]+) by ([0-9\-\+\ \%]+) for ([0-9]+) hours.' spellforaffmod = \
    /let color=@{hCyellow}%;\
    /let _spell=$[strip_attr({P1})]%;\
    /if ({_spell} =~ "invincibility") \
        /let color=@{hCwhite} %; \
        /set invincleft=%P4 %; \
    /elseif ({_spell} =~ "frenzy") \
        /let color=@{hCred} %; \
        /set frenleft=%P4 %; \
        /if ({running} == 1 & {frenleft} >= {focileft} & {refren} == 1) /refren%;/endif%;\
    /elseif ({_spell} =~ "fervor") \
        /let color=@{hCcyan} %; \
        /set fervorleft=%P4 %; \
        /if ({running} == 1 & {fervorleft} >= {focileft} & {refren} == 1) /refren%;/endif%;\
    /elseif ({_spell} =~ "racial frenzy") \
        /let color=@{hCred} %; \
        /set racialfrenleft=%P4 %; \
        /if ({running} == 1 & {racialfrenleft} >= {focileft} & {refren} == 1) /refren%;/endif%;\
    /elseif ({_spell} =~ "dagger hand") \
        /let color=@{hCmagenta} %; \
        /set daggerhandleft=%P4 %; \
    /elseif ({_spell} =~ "stone fist") \
        /let color=@{hCmagenta}%;\
        /set stonefistleft=%P4%;\
    /elseif ({_spell} =~ "concentrate") \
        /let color=@{Cwhite} %; \
        /set concleft=%P4 %; \
    /elseif ({_spell} =~ "barkskin") \
        /let color=@{Cyellow} %; \
        /set barkleft=%P4 %; \
    /elseif ({_spell} =~ "iron skin") \
        /let color=@{Cyellow} %; \
        /set ironleft=%P4 %; \
    /elseif ({_spell} =~ "armor") \
        /let color=@{hCred} %; \
        /set armorleft=%P4 %; \
    /elseif ({_spell} =~ "holy armor") \
        /let color=@{hCred} %; \
        /set holyarmorleft=%P4 %; \
    /elseif ({_spell} =~ "holy aura") \
        /let color=@{hCred} %; \
        /set holyauraleft=%P4 %; \
    /elseif ({_spell} =~ "holy zeal") \
        /let color=@{hCmagenta}%;\
        /set holyzealleft=%{P4}%;\
        /if ({running} == 1 & {holyzealleft} >= {focileft} & {refreshmisc} == 1) /refreshmisc%;/endif%;\
    /elseif ({_spell} =~ "bless") \
        /let color=@{Ccyan} %; \
        /set blessleft=%P4 %; \
    /elseif ({_spell} =~ "steel skeleton") \
        /let color=@{Cyellow} %; \
        /set steelleft=%P4 %; \
    /elseif ({_spell} =~ "endurance") \
        /let color=@{hCgreen} %; \
        /set enduranceleft=%{P4}%;\
        /set enduranceaff=%{P2} by %{P3}%;\
    /elseif ({_spell} =~ "prayer") \
        /let color=@{Ccyan} %; \
        /set prayerleft=%P4 %; \
        /set prayaff=%P2 by %P3 %; \
        /if ({running} == 1 & {prayerleft} >= {focileft} & {repray} == 1) /repray%;/endif%;\
    /elseif ({_spell} =~ "savvy") \
        /let color=@{hCblue}%; \
        /set savvyleft=%P4%; \
    /elseif ({_spell} =~ "acumen") \
        /let color=@{hCblue}%; \
        /set acumenleft=%P4%; \
    /elseif ({_spell} =~ "solitude") \
        /let color=@{hCwhite} %; \
        /set solitudeleft=%P4%; \
        /set solitudeaff=%P2 by %P3%;\
    /elseif ({_spell} =~ "poison") \
        /let color=@{Cred} %; \
        /set poisonleft=%P4 %; \
        /set poisonaff=%P2 by %P3 %; \
        /set numpoison=$[++numpoison]%;\
    /elseif ({_spell} =~ "biotoxin") \
        /let color=@{Cred} %; \
        /set biotoxinleft=%P4 %; \
        /set biotoxinaff=%P2 by %P3 %; \
        /set numbiotoxin=$[++numbiotoxin]%;\
    /elseif ({_spell} =~ "toxin") \
        /let color=@{Cred} %; \
        /set toxinleft=%P4 %; \
        /set toxinaff=%P2 by %P3 %; \
        /set numtoxin=$[++numtoxin]%;\
    /elseif ({_spell} =~ "venom") \
        /let color=@{Cred} %; \
        /set venomleft=%P4 %; \
        /set venomaff=%P2 by %P3 %; \
    /elseif ({_spell} =~ "doom toxin") \
        /let color=@{Cred} %; \
        /set doomtoxinleft=%P4 %; \
        /set doomtoxinaff=%P2 by %P3 %; \
        /set numdoomtoxin=$[++numdoomtoxin]%;\
    /elseif ({_spell} =~ "plague") \
        /let color=@{Cred} %; \
        /set plagueleft=%P4 %; \
        /set plagueaff=%P2 by %P3 %; \
        /set numplague=$[++numplague]%;\
    /elseif ({_spell} =~ "virus") \
        /let color=@{Cred} %; \
        /set virusleft=%P4 %; \
        /set virusaff=%P2 by %P3 %; \
        /set numvirus=$[++numvirus]%;\
    /elseif ({_spell} =~ "necrotia") \
        /let color=@{Cred} %; \
        /set necrotialeft=%P4 %; \
        /set necrotiaaff=%P2 by %P3 %; \
        /set numnecrotia=$[++numdnecrotia]%;\
    /elseif ({_spell} =~ "fear") \
        /let color=@{Cblack} %; \
        /set fearleft=%P4 %; \
        /set fearaff=%P2 by %P3 %; \
    /elseif ({_spell} =~ "curse") \
        /let color=@{Cblack} %; \
        /set curseleft=%P4 %; \
        /set curseaff=%P2 by %P3 %; \
        /set numcurse=$[++numcurse]%;\
    /elseif ({_spell} =~ "scramble") \
        /let color=@{Cblack} %; \
        /set scrambleleft=%P4 %; \
        /set scrambleaff=%P2 by %P3 %; \
        /set numscramble=$[++numscramble]%;\
    /elseif ({_spell} =~ "web") \
        /let color=@{hCgreen} %; \
        /set webleft=%P4 %; \
        /set webaff=%P2 by %P3 %; \
        /set numweb=$[++webnum]%;\
    /elseif ({_spell} =~ "defiled flesh") \
        /let color=@{hCred}%; \
        /set defiledfleshleft=%P4%; \
    /elseif ({_spell} =~ "saving grace") \
        /let color=@{hCred}%;\
        /set savinggraceleft=%P4%;\
    /else \
        /if ({P2} =~ "armor class") \
        /let color=@{hCred}%; \
        /elseif ({P2} =~ "hit roll" | {P2} =~ "damage roll") \
            /let color=@{Ccyan}%; \
        /endif%; \
    /endif %; \
    /if ({qryspell} =~ substr({_spell},0,strlen({qryspell}))) \
        /echo -pw  @{hCwhite}Spell: '%{color}%{_spell}@{hCwhite}' modifies @{nCwhite}%P2 @{hCwhite}by @{nCwhite}%P3 @{hCwhite}for %{color}%{P4} @{hCwhite}hours.%; \
        /set qryspellnum=$[--qryspellnum]%;\
        /if ({qryspellnum} <= 0) \
            /set qryspell=emptyvalue%;\
        /endif%;\
    /else \
        /echoaffects @{Cgreen}Spell: '%{color}%{_spell}@{nCgreen}' modifies @{Cwhite}%P2 @{nCgreen}by @{Cwhite}%P3 @{nCgreen}for %{color}%{P4} @{nCgreen}hours.%; \
    /endif

;;; ---------------------------------------------------------------------------
;;; Racial affects
;;; ---------------------------------------------------------------------------
/def -mregexp -ag -t'^Racial ([a-zA-Z ]+) fatigue for ([0-9]+) hours.' racialaff = \
    /let color=@{hCyellow} %; \
    /if ({P1} =~ "frenzy") \
        /let color=@{hCred} %; \
        /set racialfren=%P2 %; \
    /endif %; \
    /if ({qryspell} =~ substr({P1},0,strlen({qryspell}))) \
        /echo -pw @{hCwhite}Spell: '%{color}%{P1}@{hCwhite}' for %{color}%{P2} @{hCwhite} hours.%; \
        /set qryspellnum=$[--qryspellnum]%;\
        /if ({qryspellnum} <= 0) \
            /set qryspell=emptyvalue%;\
        /endif%;\
    /else \
        /echoaffects @{Cgreen}Racial %{color}%{P1}@{nCgreen} fatigue for  %{color}%{P2} @{nCgreen}hours.%; \
    /endif

;;; ---------------------------------------------------------------------------
;;; Miscellaneous highlights
;;; ---------------------------------------------------------------------------
/def -mglob -aCcyan -t'Your prayer.*answered.' prayeranswer
/def -mglob -aCcyan -t'You make a mistake in your prayer\!' praymistake
/def -mglob -aCcyan -t'Almighty Gorn is.*sed.' gornpleased
/def -mglob -aCcyan -t'Your god\'s presence disappears\.' praydrop = \
    /set prayerleft=-1 %; \
    /if ({repray} = 1) \
        /pray %; \
    /endif
    
/def -mregexp -ah -t'^You envelop (.+) in sticky webs\!'

;;; ---------------------------------------------------------------------------
;;; macro to echo the affects spam.  Toggle the affects spam with /aff
;;; ---------------------------------------------------------------------------
/set affectspam=1
/def aff = \
    /toggle affectspam%; \
    /echoflag %affectspam @{Cyellow}Affects Spam@{n}%; \
    /if ({affectspam} = 1) /send affects%; /endif

/def -i echoaffects = \
    /if ({affectspam} = 1) /echo -pw %{*}@{n}%; /endif

;;; /qry spell - search for spell in affects
/set qryspell=emptyvalue
/def qry = \
    /set qryspell=%*%; \
    /set qryspellnum=3%;\
    /send affects
/def qry2 = \
    /set qryspellnum=%1%;\
    /set qryspell=%-1%;\
    /send affects

;;; ---------------------------------------------------------------------------
;;; Aliases to toggle respelling
;;; ---------------------------------------------------------------------------
/def resanc = /toggle resanc%;/echoflag %resanc Re-@{hCwhite}Sanctuary@{n}
/def refren = /toggle refren%;/echoflag %refren Re-@{hCred}Frenzy@{n}
/def repray = /toggle repray%;/echoflag %repray Re-@{hCcyan}Prayer@{n}

;;; ---------------------------------------------------------------------------
;;; Other useful aliases
;;; ---------------------------------------------------------------------------
/def prayaff = /echo -pw %% @{Ccyan}Prayer: @{Cwhite}%Prayaff@{Ccyan}.@{n}
/def gtprayaff = gtell |c|Prayer |w|modifies %Prayaff

/def sanctleft = \
    /if ({sanctleft} >= 0) \
        /echo -pw %%% @{hCwhite}Sancturay @{nCwhite}for @{hCwhite}%sanctleft @{nCwhite}hours. %; \
    /else \
        /echo -pw %%% @{Cwhite}You are not affected by @{hCwhite}Sanctuary@{nCwhite}. %; \
    /endif

/def echosick = \
    /if ({1} = 0) \
        /echo -pw %%% @{Cred}%echospell @{Cwhite}modifies @{Cred}%echoaff @{Cwhite}for @{Cred}%echoduration@{Cwhite}.@{n} %; \
    /else \
        gt |r|%echospell |w|for |r|%echoduration|w| hours. %; \
    /endif
/set negativespells=poison biotoxin toxin venom heartbane doomtoxin plague virus necrotia fear curse scramble web
/def echosick2 = \
    /let echochan=/echo%; \
    /if ({#} > 0) /let echochan=%*%; /endif %; \
    /if ({echochan} =~ "/echo") \
        /let sickmsg=$(/chgcolor %sickmsg)%; \
        /echo -pw %%% %sickmsg %; \
    /else \
        /eval %sickchan %sickmsg %; \
    /endif

/def -i sickness = \
    /let damchan=/echo%; \
    /if ({#} > 1) /let damchan=%-1%; /endif %; \
    /if ($(/listvar -vmglob totdmg_%1*) > 0) \
        /let grpdmgname=$[substr($(/listvar -smglob totdmg_%1*),7)] %; \
        /let gtotdmg=$[$(/listvar -vmglob totdmg_%1*) + $(/listvar -vmglob totodmg_%1*)]%; \
        /let ghits=$[$(/listvar -vmglob hits_%1*) + $(/listvar -vmglob ohits_%1*)] %; \
        /let avgdmg=$[trunc(gtotdmg/ghits)]%;\
        /quote -S /set avgdmgvar=!php getdmg.php %{avgdmg} %;\
        /let rtotdmg=$[trunc({gtotdmg}/1000)]%;\
        /let dammsg=%{grpdmgname}'s Dam: |g|%{rtotdmg}k |w|damage. Averaging |g|%{avgdmg}|w| which is |c|%{avgdmgvar}|w|.%; \
        /if ({damchan} =~ "/echo") \
            /let dammsg=$(/chgcolor %dammsg)%; \
            /echo -pw %%% %dammsg %; \
        /else \
            /eval %damchan %dammsg %; \
        /endif%; \
    /endif

;Just a /sick macro.
/def -i sicko = \
    /set sick_poison 0%;/set sick_disease 0%;/unset sick_curse%;/set sick_other 0%;/unset sick_msg%;\
    /def -Fp10 -t"You are affected by:" _sick_affected = \
        /def -Fp900 -mregexp -t"^Spell: '(poison|toxin|biotoxin|venom|heartbane|doom toxin)'.*" _sick_poison =/test $$$[++sick_poison] %%;\
        /def -Fp900 -mregexp -t"^Spell: '(virus|plague|necrotia)'.*" _sick_disease = /test $$$[++sick_disease]%%;\
        /def -Fp900 -mregexp -t"^Spell: 'curse'.*" _sick_cursed = /set sick_curse=|bk|I'm cursed%%;\
        /def -Fp900 -mregexp -t"^Spell: '(rupture|unrest|web|deaths door|faerie fire)'.*" _sick_other = /test $$$[++sick_other]%%;\
        /repeat -00:00:01 1 \
            /undef _sick_affected _sick_poison _sick_disease _sick_other _sick_cursed%%%;\
            /if ({sick_poison}>0) /set sick_msg=|g|%%%sick_poison |r|poisons|w|%%%;/endif%%%;\
            /if ({sick_disease}>0) /set sick_msg=%%%sick_msg |g|%%%sick_disease |r|diseases|w|%%%;/endif%%%;\
            /if ({sick_other}>0) /set sick_msg=%%%sick_msg |g|%%%sick_other |c|other ailments|w|%%%;/endif%%%;\
            /set sick_msg=%%%{sick_msg}%%%{sick_curse}%%%;\
            /if ({sick_msg}!~"") gtell |w|I am affected by: %%%{sick_msg} %%%{sick_curse}|n|%%%;/endif%;\
    /send affects

/def -Fp900 -mregexp -t"^Spell: '(poison|toxin|biotoxin|venom|heartbane|doom toxin)'.*" sick_poison = /test $[++sick_poison]
/def -Fp900 -mregexp -t"^Spell: '(virus|plague|necrotia)'.*" sick_disease = /test $[++sick_disease]
/def -Fp900 -mregexp -t"^Spell: 'deaths door'.*" sick_deathsdoor = /test $[++sick_deathsdoor]
/def -Fp900 -mregexp -t"^Spell: 'web'.*" sick_web = /test $[++sick_web]
/def -Fp900 -mregexp -t"^Spell: 'rupture'.*" sick_rupture = /test $[++sick_rupture]
/def -Fp900 -mregexp -t"^Spell: '(awe|calm|fear|scramble|curse|unrest|faerie fire)'.*" sick_other = /set sick_other=%{P1}. %{sick_other}

;/def echosick = \
;    /if ({1} = 0) \
;        /echo -pw %%% @{Cred}%echospell @{Cwhite}modifies @{Cred}%echoaff @{Cwhite}for @{Cred}%echoduration@{Cwhite}.@{n} %; \
;    /else \
;        gt |r|%echospell |w|for |r|%echoduration|w| hours. %; \
;    /endif

/def sick = \
    /if ({sick_poison} > 0) /let _sick_message=%{sick_poison} Poison. %{_sick_message}%;/endif%;\
    /if ({sick_disease} > 0) /let _sick_message=%{sick_disease} Disease. %{_sick_message}%;/endif%;\
    /if ({sick_deathsdoor} > 0) /let _sick_message=%{sick_deathsdoor} Death's Door. %{_sick_message}%;/endif%;\
    /if ({sick_web} > 0) /let _sick_message=%{sick_web} Web. %{_sick_message}%;/endif%;\
    /if ({sick_rupture} > 0) /let _sick_message=%{sick_rupture} Rupture. %{_sick_message}%;/endif%;\
    ;/let _otherLength=$[strlen(sic_other)]%;\
    /let _sick_message=%{_sick_message} %{sick_other}%;\
    /echo -pw @{Cred}[CHAR INFO]: Sickness: %{_sick_message}
/def cure = \
    /sick%;\
    /if ({sick_poison} > 0) /repeat -00:00:01 %{sick_poison} c 'cure poison'%;/endif%;\
    /if ({sick_disease} > 0) /repeat -00:00:01 %{sick_disease} c 'cure disease'%;/endif%;\
    /if ({sick_blind} == 1) c 'cure blindness'%;/endif

/def sick2 = \
    /let paramCount=%# %; \
    /if ({poisonleft} >= 0) \
        /set echospell=Poison %; \
        /set echoaff=%Poisonaff %; \
        /set echoduration=%Poisonleft %; \
        /echosick %ParamCount %; \
    /endif %; \
    /if ({biotoxinleft} >= 0) \
        /set echospell=Biotoxin %; \
        /set echoaff=%biotoxinaff %; \
        /set echoduration=%biotoxinleft %; \
        /echosick %ParamCount %; \
    /endif %; \
    /if ({toxinleft} >= 0) \
        /set echospell=Toxin %; \
        /set echoaff=%toxinaff %; \
        /set echoduration=%toxinleft %; \
        /echosick %ParamCount %; \
    /endif %; \
    /if ({venomleft} >= 0) \
        /set echospell=Venom %; \
        /set echoaff=%venomaff %; \
        /set echoduration=%venomleft %; \
        /echosick %ParamCount %; \
    /endif %; \
    /if ({heartbaneleft} >= 0) \
        /set echospell=Heartbane %; \
        /set echoaff=%heartbaneaff %; \
        /set echoduration=%heartbaneleft %; \
        /echosick %ParamCount %; \
    /endif %; \
    /if ({doomtoxinleft} >= 0) \
        /set echospell=Doom toxin %; \
        /set echoaff=%doomtoxinaff %; \
        /set echoduration=%doomtoxinleft %; \
        /echosick %ParamCount %; \
    /endif %; \
    /if ({plagueleft} >= 0) \
        /set echospell=Plague %; \
        /set echoaff=%Plagueaff %; \
        /set echoduration=%Plagueleft %; \
        /echosick %ParamCount %; \
    /endif %; \
    /if ({virusleft} >= 0) \
        /set echospell=Virus %; \
        /set echoaff=%virusaff %; \
        /set echoduration=%virusleft %; \
        /echosick %ParamCount %; \
    /endif %; \
    /if ({necrotialeft} >= 0) \
        /set echospell=Necrotia %; \
        /set echoaff=%necrotiaaff %; \
        /set echoduration=%necrotialeft %; \
        /echosick %ParamCount %; \
    /endif %; \
    /if ({fearleft} >= 0) \
        /set echospell=Fear %; \
        /set echoaff=%fearaff %; \
        /set echoduration=%fearleft %; \
        /echosick %ParamCount %; \
    /endif %; \
    /if ({curseleft} >= 0) \
        /set echospell=Curse %; \
        /set echoaff=%curseaff %; \
        /set echoduration=%curseleft %; \
        /echosick %ParamCount %; \
    /endif %; \
    /if ({scrambleleft} >= 0) \
        /set echospell=Scramble %; \
        /set echoaff=%scrambleaff %; \
        /set echoduration=%scrambleleft %; \
        /echosick %ParamCount %; \
    /endif %; \
    /unset echospell%;/unset echoaff%;/unset echoduration

/def sleft = \
    /let spellsleft=%awenleft %; \
    /if ({focileft} < {spellsleft}) /let spellsleft=%focileft %; /endif %; \
    /if ({fortleft} < {spellsleft}) /let spellsleft=%fortleft %; /endif %; \
    /if ({spellsleft} >= 0) \
        /echo -pw %%% @{hCgreen}Spells for @{Cred}%{spellsleft}@{Cgreen} hours.@{n} %; \
    /else \
        /echo -pw %%% @{hCgreen}Not affected by any macro spells.@{n} %; \
    /endif

;;; ---------------------------------------------------------------------------
;;; Poison/Disease stuff.
;;; ---------------------------------------------------------------------------
/set sickechochan=/echo
/set echoPoison 0
/def -i echopoison = /toggle echoPoison%;/echoflag %echoPoison Echo-@{hCred}Poison
/def sickchan = \
    /set sickechochan=%{*}%; \
    /echo -pw %%% @{Cyellow}Will echo sick cure info to: @{hCred}%{sickechochan}@{Cyellow}.@{n}

/def -i saypoison = \
    /let _poisoned=%{1}%;\
    /let _numPoison=%{2}%;\
    /let _cureType=%{3}%;\
    /if ({echoPoison}=1) \
        say |bg|%1 |y|has |br|%4 |y|and needs |br|%2 |y|'cure |br|%3|y|'.%; \
    /else \
        /echo -pw @{Cred}[GROUP INFO]: @{hCgreen}%1 @{nCyellow}has @{hCred}%4 @{nCyellow}and needs @{hCred}%2 @{nCyellow}'cure @{hCred}%3@{nCyellow}'.%; \
    /endif%;\
    /if ({autocure} == 1) \
        /for i 1 %{_numPoison} /aq c 'cure %{_cureType}' %{_poisoned}%;\
    /endif

/def -i sayother = \
    /let sickone=%1%;/let cure=%3%;/let countcure=%2%; \
    /let sickness=$(/cdddr %{*})%; \
    /let sickmsg=|bg|%sickone |y|has |br|%sickness |y|and needs |br|%countcure |y|'|bw|%{cure}|y|'.%; \
    /if ({sickone} =~ "I") \
        /let tsickmsg=$[replace("has", "have", {sickmsg})]%; \
        /let sickmsg=$[replace("needs", "need", {tsickmsg})]%; \
    /endif %; \
    /if ({sickechochan} =~ "/echo") \
        /let newmsg=$[replace("|bg|", "@{hCgreen}", {sickmsg})] %; \
        /let newmsg=$[replace("|y|", "@{nCyellow}", {newmsg})] %; \
        /let newmsg=$[replace("|br|", "@{hCred}", {newmsg})] %; \
        /let newmsg=$[replace("|bw|", "@{hCwhite}", {newmsg})] %; \
        /echo -pw %%% %newmsg %; \
    /else \
        /eval %sickechochan %sickmsg %; \
    /endif

/def -mregexp -t'^([a-z|A-Z|0-9| |-]*) shudders as the virus takes hold!' poison_other_virus = \
    /let poisoned=%P1 %; \
    /let spoisoned=<%P1< %; \
    /if ( regmatch(tolower({spoisoned}),{groupies}) ) \
        /saypoison %poisoned 3 disease virus%; \
    /endif

/def -mregexp -t'^([a-z|A-Z|0-9| |-]*) succumbs to a toxin and shudders\.' poison_other_toxin = \
    /let poisoned=%P1 %; \
    /let spoisoned=<%P1< %; \
    /if ( regmatch(tolower({spoisoned}),{groupies}) ) \
        /saypoison %poisoned 2 poison toxin%; \
    /endif

/def -mregexp -t'^([a-z|A-Z|0-9| |-]*) succumbs to biotoxin\.' poison_other_biotoxin = \
    /let poisoned=%P1 %; \
    /let spoisoned=<%P1< %; \
    /if ( regmatch(tolower({spoisoned}),{groupies}) ) \
        /saypoison %poisoned 2 poison biotoxin%; \
    /endif

/def -mregexp -ahCred -t'^([a-z|A-Z|0-9| |-]*) succumbs to poison and shivers.' poison_other_poison = \
    /let poisoned=%P1 %; \
    /let spoisoned=<%P1< %; \
    /if ( regmatch(tolower({spoisoned}),{groupies}) ) \
        /saypoison %poisoned 1 poison poison%; \
    /endif

/def -mregexp -t'^([a-z|A-Z|0-9| |-]*) clutches at ([a-z|A-Z|0-9| |-]*) heart in pain!' poison_other_heartbane = \
    /let poisoned=%P1 %; \
    /let spoisoned=<%P1< %; \
    /if ( regmatch(tolower({spoisoned}),{groupies}) ) \
        /saypoison %poisoned 1 poison heartbane%; \
    /endif

/def -mregexp -t'^Crying out in pain, ([a-z|A-Z|0-9| |-]*) succumbs to venom!' poison_other_venom = \
    /let poisoned=%P1 %; \
    /let spoisoned=<%P1< %; \
    /if ( regmatch(tolower({spoisoned}),{groupies}) ) \
        /saypoison %poisoned 1  poison venom%; \
    /endif

/def -mglob -t'You feel sick.' poison_self_poison = \
    /set sick_poison=2%;\
    /saypoison I 2 poison poison

/def -mglob -t'You feel slightly sick.' poison_self_doomtoxin = \
    /set sick_poison=2%;\
    /saypoison I 2 poison "doom toxin"

/def -mglob -ahCred -t'You feel very sick.' poison_self_venom_virus = \
    /echo -pw @{hCgreen}Virused (3 cure disease) or Venomed (1 cure poison)

/def -mregexp -ag -t'^([a-zA-Z\-\,\. ]+) (is|are) surrounded by a pink outline\.' pink_other = \
    /let pinked=%P1 %; \
    /let spinked=<%P1< %; \
    /echo -pw @{hCcyan}%{pinked} @{nCgreen}%P2 surrounded by a @{hCmagenta}pink outline@{nCgreen}.@{n}%; \
    /if ({spinked} =~ "You") \
        /sayother I 1 clarify "faerie fire"%; \
    /elseif (regmatch(tolower({spinked}),{groupies})) \
        /sayother %pinked 1 clarify "faerie fire"%; \
    /endif

/def -ag -mregexp -t'^([a-zA-Z\-\,\. ]+) (are|is) cursed with something\.\.\.' unrest_other = \
    /let cursed=%P1%;\
    /let scursed=<%P1<%;\
    /echo -pw @{hCwhite}%{cursed} @{nCgreen}%P2 cursed with something...@{n}%;\
    /if ({scursed} =~ "You") \
        /sayother I 1 clarify unrest%; \
    /elseif (regmatch(tolower({scursed}),{groupies})) \
        /sayother %cursed 1 clarify unrest%;\
    /endif

;;; web requires 3 panacea's
/def -ag -mregexp -t"^Sticky strands shoot forth from (.+) hands, smothering (.+) in a web!$" = \
    /let webber=%P1%; /let webbee=%P2%; \
    /set lcwebbee=$[tolower({webbee})] %; \
    /echo -pw @{Cgreen}Sticky strands shoot forth from @{Cwhite}%{webber} @{Cgreen}hands, smothering @{Ccyan}%{webbee} @{Cgreen}in a @{hCgreen}web@{nCgreen}!@{n}%; \
    /if ({webbee} =~ {myname}) \
        /sayother I 3 panacea web%; \
    /elseif (strstr({groupies},{webbee}) > -1) \
        /sayother %webbee 3 panacea web %; \
    /endif

/def -mregexp -ag -t"^The eyes of (.+) dim and turn milky white\." sick_blinded = \
    /let blinded=%P1 %; \
    /let sblinded=<%P1< %; \
    /echo -pw @{Cgreen}The eyes of @{hCcyan}%{blinded} @{nCwhite}dim @{Cgreen}and turn @{nCwhite}milky white.@{n}%; \
    /if (regmatch(tolower({sblinded}),{groupies})) \
        /sayother %blinded 1 PureTouch blind%; \
    /endif

/def -aufhCwhite -P -mregexp -t"You are blinded\!" self_blinded = \
    /set sick_blind=1%;\
    /sayother I 1 "cure blindness" "blindness"


/def -mregexp -ag -t"^([a-zA-Z]+) holds (his|her|its) breath for as long as (he|she|it) can\!" groupie_drowning = \
    /echo -pw @{hCcyan}%{P1} @{hCblue}holds their breath for as long as they can!@{n}

;; /mcost spell basecost - echoes cost for X spells, and total
/def mcost = \
    /if ({#} != 2) /echo -pw @{Cred}Syntax: /mcost spell basecost%;\
    /else \
        /let spell=%1%;/let basecost=%2%;\
        /let cost2=$[basecost * 2]%;/let cost3=$[basecost * 3]%;/let cost4=$[basecost * 4]%;\
        /let currmax=$[curr_mana/basecost]%;/let totmax=$[max_mana/basecost]%;\
        /echo -pw @{hCcyan}%{spell} @{nCwhite}costs: \
            1:@{nCyellow}%{basecost}@{nCwhite}   \
            2:@{nCyellow}%{cost2}@{nCwhite}   \
            3:@{nCyellow}%{cost3}@{nCwhite}   \
            4:@{nCyellow}%{cost4}@{nCwhite}   \
            Total:@{nCgreen}%{currmax}@{nCwhite} / @{nCgreen}%{totmax}@{nCwhite}.%;\
    /endif

/def rehog = \
    /toggle autohog%;\
    /echoflag %{autohog} Re-HoG
    
/def -mglob -p5 -t"With despair, you realize your hands are mortal again." hog_rehog = \
    /if ({autohog} == 1) /send hog%;/endif

/def -p5 -mglob -t"Your mind drifts off onto the joy of killing!" tainted_genius_up = \
    /stnl $[tnlthreshold*2]%;\
    /set taintleft=999

/def -p5 -mglob -t"Your mind drifts closer to sanity." tainted_genius_down = \
    /eval /echo -pw @{hCgreen}Set tnl to $[tnlthreshold/2]@{n}%;\
    /stnl $[tnlthreshold/2]%;\
    /set taintleft=-1

