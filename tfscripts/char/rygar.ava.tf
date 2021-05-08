;;; read in Rygar's gear file
;; good poison combo: venom wield/ virus offhand
/load -q char/rygar.gear.ava.tf

/require rogue.tf

/set poisonkit=toxifier

/def -p50 -au -wrygar -mregexp -t"A female lizardman thief hunts for treasure\." rygar_atarg_female_lizardman = bs female!%;/aq /find female


;; Load in the variables saved from previous state.
/loadCharacterState rygar
