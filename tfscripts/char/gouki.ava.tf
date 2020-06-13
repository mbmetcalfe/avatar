;;; gouki.ava.tf
;;; Specific variables/macroes for gouki

;;; read in gouki's gear file
/load -q char/gouki.gear.ava.tf

/require monk.tf
/set monkHandMod=stone fist
;/set monkHandMod=dagger hand

;;; set up other variables

/def -wgouki ba = /send wear all.shield=bash %1=stand=remove all.shield
/alias endur /send get seven %lootContainer=wear seven=c endurance=wear %{ac_feet}=put  seven %lootContainer

/def -wgouki goukimidround = kick

;; Temp triggers until he gets more mvs
/def -wgouki -mregexp -p1 -au -t"^You feel less durable\.$" gouki_endurance_fall = \
    /send get seven %{main_bag}=wear seven%;\
    /set enduranceleft=-1
/def -wgouki -mregexp -p1 -au -t"^You feel energized\.$" endurance_up = \
    /send wear %{hit_feet}=wear %{ac_feet}=put seven %{main_bag}=config +savespell%;\
    /set enduranceleft=999

/def -wgouki -au -p9 -F -mglob -t'Your force shield shimmers then fades away.' gouki_focidrop = \
    /if ({running} == 1) /send racial fly%;/endif


;; Load in the variables saved from previous state.
/loadCharacterState gouki
