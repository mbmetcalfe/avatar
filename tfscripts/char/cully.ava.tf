;;; cully.ava.tf
;;; Specific variables/macroes for Cully

;;; read in Cully's gear file
/load -q char/cully.gear.ava.tf

;;; set up other variables

/def cullymidround = /send -wcully smash

;; Load in the variables saved from previous state.
/loadCharacterState cully
