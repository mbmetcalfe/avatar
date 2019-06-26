;;; iratavo.ava.tf
;;; Specific variables/macroes for Iratavo

;;; read in Iratavo's gear file
/load -q char/iratavo.gear.ava.tf

;/def iratavosanc = get wafer %{main_bag}%;eat wafer
/def iratavomidround = /send -wiratavo c 'ice lance'

;; Temp trigger until he gets more mvs
/def -wiratavo -mregexp -p1 -au -t"^You feel less durable\.$" iratavo_endurance_fall = \
    /send wear seven%;\
    /set enduranceleft=-1
/def -wiratavo -mregexp -p1 -au -t"^You feel energized\.$" endurance_up = \
    /send wear %{hit_feet}%;\
    /set enduranceleft=999

;; Load in the variables saved from previous state.
/loadCharacterState iratavo
