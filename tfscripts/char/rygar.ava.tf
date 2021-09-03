;;; read in Rygar's gear file
;; good poison combo: venom wield/ virus offhand
/load -q char/rygar.gear.ava.tf

/require rogue.tf

/set poisonkit=toxifier

/def -p50 -au -wrygar -mregexp -t"A female lizardman thief hunts for treasure\." rygar_atarg_female_lizardman = bs female!%;/aq /find female

;; auto-stab armorphous orb mob
/def -p50 -au -wrygar -mregexp -t"A rapidly changing blob floats here\." rygar_atarg_orb_changeling = /send bs changeling%;/cast on%;/aq /cast off

;; Load in the variables saved from previous state.
/loadCharacterState rygar
