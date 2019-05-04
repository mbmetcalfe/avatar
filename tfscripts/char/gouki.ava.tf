;;; gouki.ava.tf
;;; Specific variables/macroes for gouki

;;; read in gouki's gear file
/load -q char/gouki.gear.ava.tf

/require monk.tf

;;; set up other variables

/def -wgouki ba = /send wear all.shield=bash %1=stand=remove all.shield
/alias endur /send get seven %lootContainer=wear seven=c endurance=wear %{ac_feet}=put  seven %lootContainer

/def -wgouki goukimidround = kick

;; Load in the variables saved from previous state.
/loadCharacterState gouki
