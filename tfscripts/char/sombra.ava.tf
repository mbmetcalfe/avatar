;;; sombra.ava.tf
;;; Specific variables/macroes for Sombra

;;; read in Sombra's gear file
/load -q char/sombra.gear.ava.tf
/set hit_feet="fatewalkers mystical sandals"

/def sombrafren = /q 5 c frenzy %1

; Hero stance management
/set next_bld_stance=bladedance
/def -wsombra -mregexp -au -t"^One of your Exhaust timers has elapsed. \(dervish dance\)$" sombra_dervish_back =\
  /if ({refreshmisc}=1) /send stance dervish%;/endif

/def -wsombra -mglob -au -t"You stop using dervish dance." sombra_dervish_down = \
  /if ({refreshmisc}=1) /send stance %{next_bld_stance}%;/endif

;; Load in the variables saved from previous state.
/loadCharacterState sombra
