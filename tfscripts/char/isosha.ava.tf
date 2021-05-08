;;; read in Isosha's gear file
/load -q char/isosha.gear.ava.tf

/require archer.tf

/def -mglob -p1 -wisosha -t"The Office of the High Clerist" autols_crullius = \
    /if ({leader} !~ "Self") ls west crullius%;/endif
/def -mglob -p1 -wisosha -t"The Temple's Second Floor" autols_arcanthrus_grantus = \
    /if ({leader} !~ "Self") ls south arc%;ls south grant%;/endif
/def -mglob -p1 -wisosha -t"The family graveyard" autols_eater = \
    /if ({leader} !~ "Self") ls north eater%;/endif

;; bow/xbow swapping when aggied
;/def -wisosha -p9 -ag -mregexp -F -t"\'s attac.* strikes? you [0-9]* (time|times), with .* [a-zA-Z]*(\.|\!)$" archer_aggie_swap_bow = \
;    /if ({xbowon}=0 & {leader} !~ "Self" & {running}=1) xbow%;/aq bow%;/endif
;/def -wisosha -p9 -ag -mregexp -F -t"\'s attacks haven\'t hurt you\!$" archer_nil_aggie_swap_bow = \
;    /if ({xbowon}=0 & {leader} !~ "Self" & {running}=1) xbow%;/aq bow%;/endif
;/def -wisosha -p9 -ag -mregexp -F -t"([a-zA-Z]+) successfully rescues you from the .*\!" archer_rescued_swap_bow = \
;    /if ({xbowon}=1 & {leader} !~ "Self" & {running}=1) bow%;/clrq%;/endif

;; Stance triggers
/set isosha_off_stance=column
/def -mglob -au -p1 -wisosha -t"One of your Exhaust timers has elapsed. (echelon)" isosha_echelon_exhaust_up = /if ({refreshmisc} == 1) /send stance echelon%;/endif
/def -mglob -au -p1 -wisosha -t"You drop out of echelon formation." isosha_echelon_down = /if ({refreshmisc} == 1) /send stance %{isosha_off_stance}%;/endif

/def isosha_char_status = /stance_char_status

;; Load in the variables saved from previous state.
/loadCharacterState isosha
