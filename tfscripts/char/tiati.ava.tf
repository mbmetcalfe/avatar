;;; tiati.ava.tf
;;; Specific variables/macroes for Tiati

;;; read in Tiat's gear file
/load -q char/tiati.gear.ava.tf

; auto-set lord-leadership skill
/def -mregexp -wtiati -F -t'^You join ([a-zA-Z]+)\'s group.' tiati_set_leadership = /send leadership switch lieutenant

;; Load in the variables saved from previous state.
/loadCharacterState tiati