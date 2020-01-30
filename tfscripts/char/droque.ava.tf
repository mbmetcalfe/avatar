;;; droque.ava.tf
;;; Specific variables/macroes for droque

;;; read in droque's gear file
/load -q char/droque.gear.ava.tf

/def -wdroque wa = /send wake%;/mana2hit
/def -wdroque sle = /hit2mana%;/send sleep

;; Load in the variables saved from previous state.
/loadCharacterState droque
