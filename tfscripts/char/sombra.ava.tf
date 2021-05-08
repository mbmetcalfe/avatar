;;; sombra.ava.tf
;;; Specific variables/macroes for Sombra

;;; read in Sombra's gear file
/load -q char/sombra.gear.ava.tf
/set hit_feet="fatewalkers mystical sandals"

/def sombrafren = /q 5 c frenzy

;; Load in the variables saved from previous state.
/loadCharacterState sombra
