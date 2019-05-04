;;; odium.ava.tf
;;; Specific variables/macroes for Odium

;;; read in Odium's gear file
;/load -q char/odirum.gear.ava.tf

;;; set up other variables

/set grouped_fusilier=goblio
/def -p2 -ah -wodium -mglob -t"* catches it\!" fusilier_mob_catch = \
    /addq get spear corpse#give spear %{grouped_fusilier}

/def -wodium -p0 -mregexp -t"^\*?(Shaykh|Khyfa|Zaffer|Lokken|Xharnah)\*? tells the group 'get me'" zaffer_resc = \
    /send rescue %{P1}

/def rally = \
    /send rally%;\
    /if ({leader} !~ "Self") /send appoint %{leader}%;/endif

/def -p50 -au -wodium -mregexp -t"A female lizardman thief hunts for treasure\." odium_atarg_female_lizardman = b2 female!%;/aq /find female

;; Load in the variables saved from previous state.
/loadCharacterState odium
