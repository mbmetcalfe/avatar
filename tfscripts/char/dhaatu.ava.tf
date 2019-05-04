;;; dhaatu.ava.tf
;Aug 14, 2014 - evolved to stone giant - level 29 lord
; before:  35092/58744 hp 464/607 mana 15803/15821 mv 1020 TNL.
; after ath reroll: 41831/57008 hp 620/620 mana 13012/15619 mv 1428 TNL.
;May 22, 2015 - evolved to fire giant - level 178 lord no reroll done
;May 27, 2015 - remorted to paladin

;;; gear file
/load -q char/dhaatu.gear.ava.tf
/set lootContainer=loot

;; Temp triggers until he gets more mvs
/def -wdhaatu -mregexp -p1 -au -t"^You feel less durable\.$" dhaatu_endurance_fall = \
    /send wear seven=config +savespell%;\
    /set enduranceleft=-1
/def -wdhaatu -mregexp -p1 -au -t"^You feel energized\.$" endurance_up = \
    /send wear %{hit_feet}%;\
    /set enduranceleft=999

;Kra's presence disappears.
/def -wdhaatu -au -mregexp -p10 -F -t"^(Werredan|Bhyss|Shizaga|Gorn|Kra|Tul\-Sith|Quixoltan)\'s presence disappears\.$" dhaatu_prayer_drop = \
    /if ({repray} == 1) /refreshSkill c prayer precision%;/endif

/def -wdhaatu -au -p9 -F -mglob -t'Your force shield shimmers then fades away.' dhaatu_focidrop = \
    /if ({running} == 1) /send racial fly%;/endif

;; Load in the variables saved from previous state.
/loadCharacterState dhaatu
