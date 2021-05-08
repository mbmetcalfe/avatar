;;; gouki.ava.tf
;;; Specific variables/macroes for gouki

;;; read in gouki's gear file
/load -q char/gouki.gear.ava.tf

/require monk.tf
/set monkHandMod=stone fist
;/set monkHandMod=dagger hand

/def -wgouki -p1 -au -mregexp -t"^([a-zA-Z]+) pokes you in the ribs\.$" gouki_poke_resc = \
  /if ({gouki_auto_rescue} == 1) /send rescue %{P1}%;/endif

/def -wgouki ba = /send wear all.shield=bash %1=stand=remove all.shield

/def -wgouki -au -p9 -F -mglob -t'Your force shield shimmers then fades away.' gouki_focidrop = \
    /if ({running} == 1) /send racial fly%;/endif


;; Load in the variables saved from previous state.
/loadCharacterState gouki
