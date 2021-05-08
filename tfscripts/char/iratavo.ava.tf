;;; iratavo.ava.tf
;;; Specific variables/macroes for Iratavo

;;; read in Iratavo's gear file
/load -q char/iratavo.gear.ava.tf

;/def iratavosanc = get wafer %{main_bag}%;eat wafer

;; Load in the variables saved from previous state.
/loadCharacterState iratavo
