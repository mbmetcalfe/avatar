;;; read in Muerte's gear file
/load -q char/muerte.gear.ava.tf

/require rogue.tf
/require archer.tf

/unalias ls
/def muertefren = /q 5 c frenzy %1

; wear ebonies after mob death to get faster stabs when moving rooms
;/def -wmuerte -F -au -p6 -mregexp -t'^You receive ([0-9]+) experience points.$' muerte_prep_stab = /send wear "ebony arrows"

;/def -mglob -wmuerte -p0 -t"You feel less fatigued\." racial_frenzy_fatigue = \
;    /if ({refren} = 1) /send racial frenzy %; /endif
/def -mglob -wmuerte -p0 -t"You feel less fatigued. (frenzy)" racial_frenzy_fatigue = \
    /if ({refren} = 1) /send racial frenzy %; /endif

;;; Reputation macroes
/def -mglob -p5 -ah -wmuerte -t"Your reputation grows\.\.\." reputation_gain

/def -mregexp -p9 -wmuerte -t"^([a-zA-Z0-9\.\-\,\' ]+) is hurt and suspicious" mobsusp_kiaim = \
    kill %{targetMob}%;aim

/def -mglob -p1 -wmuerte -t"The Office of the High Clerist" autols_crullius = \
    /if ({leader} !~ "Self") ls west crullius%;/endif
/def -mglob -p1 -wmuerte -t"The Temple's Second Floor" autols_arcanthrus_grantus = \
    /if ({leader} !~ "Self") ls south arc%;ls south grant%;/endif
/def -mglob -p1 -wmuerte -t"The family graveyard" autols_eater = \
    /if ({leader} !~ "Self") ls north eater%;/endif
;/def -wmuerte muertelvl = /send get all.levelgear %lootContainer=wear hat=wear crucifix
;/def -wmuerte muerteunlvl = /send rem all.levelgear=put all.levelgear %lootContainer=wear crescent=wear circlet

;; Load in the variables saved from previous state.
/loadCharacterState muerte
