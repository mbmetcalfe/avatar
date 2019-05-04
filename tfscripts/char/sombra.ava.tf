;;; sombra.ava.tf
;;; Specific variables/macroes for Sombra

;;; read in Sombra's gear file
/load -q char/sombra.gear.ava.tf
/set hit_feet="fatewalkers mystical sandals"

/set grouped_fusilier=drunderhill
/def -p2 -ah -wsombra -mglob -t"* catches it\!" fusilier_mob_catch = \
    /addq get spear corpse#give spear %{grouped_fusilier}

;; Temp trigger until he gets more mvs
/def -wsombra -mregexp -p1 -au -t"^You feel less durable\.$" sombra_endurance_fall = \
    /send wear seven%;\
    /set enduranceleft=-1
/def -wsombra -mregexp -p1 -au -t"^You feel energized\.$" sombra_endurance_up = \
    /send wear %{hit_feet}%;\
    /set enduranceleft=999

/def sombrafren = /q 5 c frenzy

;; Load in the variables saved from previous state.
/loadCharacterState sombra
