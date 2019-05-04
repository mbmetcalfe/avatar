;;; eronak.ava.tf
;;; Specific variables/macroes for Eronak
;;; Dec 12, 2004: Hero 503 (4284hps) Died to UD @ 
;;; Dec 29, 2004: Hero 605 (5009hps) Killed UD
;;; Aug 23, 2010: Lord 69, Updated version, reroll:
;;;   Before: 32314 hp   4188 ma 32353 mv
;;;   After:  32137 hp   4284 ma 32629 mv

;;; read in Eronak's gear file
/load -q char/eronak.gear.ava.tf
/require monk.tf

/def -weronak eronaklvl = /send get all.levelgear %lootContainer=wear levelgear
/def -weronak eronakunlvl = /send rem all.levelgear=put all.levelgear %lootContainer=wear %{ac_about}

/def -weronak ba = /send wear all.shield=bash %1=stand=remove all.shield

;;; Macro to hold actions to try and perform mid-round.
;;; Use /amid to toggle this macro firing mid-round.
/def eronakmidround = /send -weronak kick

;; Load in the variables saved from previous state.
/loadCharacterState eronak
