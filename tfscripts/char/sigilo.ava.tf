;;; sigilo.ava.tf
;;; Specific variables/macroes for Sigilo

;;; read in Sigilo's gear file
;/load -q char/sigilo.gear.ava.tf
/set main_bag="bodybag body bag loot"
/set hit_feet="fatewalkers mystical sandals"

;; Temp triggers until he gets more mvs
/def -wsigilo -mregexp -p1 -au -t"^You feel less durable\.$" sigilo_endurance_fall = \
    /send wear seven%;\
    /set enduranceleft=-1
/def -wsigilo -mregexp -p1 -au -t"^You feel energized\.$" endurance_up = \
    /send wear %{hit_feet}=wear %{ac_feet}=config +savespell%;\
    /set enduranceleft=999

;; Temp trigger until he gets more mvs
/def -wsigilo -mregexp -p1 -au -t"^You feel less durable\.$" sigilo_endurance_fall = \
    /send wear seven%;\
    /set enduranceleft=-1
/def -wsigilo -mregexp -p1 -au -t"^You feel energized\.$" sigilo_endurance_up = \
    /send wear %{hit_feet}%;\
    /set enduranceleft=999

;/def sigilofren = /q 5 c frenzy

;; Load in the variables saved from previous state.
/loadCharacterState sigilo
