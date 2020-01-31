;;; nimble.ava.tf
;;; Specific variables/macroes for nimble

;;; read in nimble's gear file
/load -q char/nimble.gear.ava.tf

/require monk.tf

;;; set up other variables

/def -wnimble ba = /send wear all.shield=bash %1=stand=remove all.shield
/alias endur /send get seven %lootContainer=wear seven=c endurance=wear %{ac_feet}=put  seven %lootContainer

/def -wnimble nimblemidround = kick

;; Load in the variables saved from previous state.
/loadCharacterState nimble
