;;; read in Skia's gear file
/load -q char/skia.gear.ava.tf

/require rogue.tf
/require psionic.tf

/set my_spell='steel skeleton'

/alias weak /q 7 c 'sense weakness' %1%;vs eye

/def -wskia wa = /send wake%;/mana2hit

;; Load in the variables saved from previous state.
/loadCharacterState skia