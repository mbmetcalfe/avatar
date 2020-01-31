;;; read in Muerte's gear file
/load -q char/bertrand.gear.ava.tf

/require rogue.tf
/require archer.tf

/unalias ls
;/def -mglob -wbertrand -p0 -t"You feel less fatigued\." racial_frenzy_fatigue = \
;    /if ({refren} = 1) /send racial frenzy %; /endif
/def -mglob -wbertrand -p0 -t"You feel less fatigued. (frenzy)" racial_frenzy_fatigue = \
    /if ({refren} = 1) /send racial frenzy %; /endif

;;; Reputation macroes
/def -mglob -p5 -ah -wbertrand -t"Your reputation grows\.\.\." reputation_gain

/def -mregexp -p9 -wbertrand -t"^([a-zA-Z0-9\.\-\,\' ]+) is hurt and suspicious" mobsusp_kiaim = \
    kill %{targetMob}%;aim

/def -mglob -p1 -wbertrand -t"The Office of the High Clerist" autols_crullius = \
    /if ({leader} !~ "Self") ls west crullius%;/endif
/def -mglob -p1 -wbertrand -t"The Temple's Second Floor" autols_arcanthrus_grantus = \
    /if ({leader} !~ "Self") ls south arc%;ls south grant%;/endif
/def -mglob -p1 -wbertrand -t"The family graveyard" autols_eater = \
    /if ({leader} !~ "Self") ls north eater%;/endif
/def -wbertrand bertrandlvl = /send get all.levelgear %lootContainer=wear hat=wear crucifix
/def -wbertrand bertrandunlvl = /send rem all.levelgear=put all.levelgear %lootContainer=wear wind=wear circlet


;; bow/xbow swapping when aggied
/def -wbertrand -p9 -ag -mregexp -F -t"\'s attac.* strikes? you [0-9]* (time|times), with .* [a-zA-Z]*(\.|\!)$" archer_aggie_swap_bow = \
    /if ({xbowon}=0 & {leader} !~ "Self" & {running}=1) xbow%;/aq bow%;/endif
/def -wbertrand -p9 -ag -mregexp -F -t"\'s attacks haven\'t hurt you\!$" archer_nil_aggie_swap_bow = \
    /if ({xbowon}=0 & {leader} !~ "Self" & {running}=1) xbow%;/aq bow%;/endif
/def -wbertrand -p9 -ag -mregexp -F -t"([a-zA-Z]+) successfully rescues you from the .*\!" archer_rescued_swap_bow = \
    /if ({xbowon}=1 & {leader} !~ "Self" & {running}=1) bow%;/clrq%;/endif

;;; Macro to hold actions to try and perform mid-round.
;;; Use /amid to toggle this macro firing mid-round.
/def bertrandmidround = /send -wbertrand aim

;; Load in the variables saved from previous state.
/loadCharacterState bertrand
