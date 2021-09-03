;;; dhaatu.ava.tf
;Aug 14, 2014 - evolved to stone giant - level 29 lord
; before:  35092/58744 hp 464/607 mana 15803/15821 mv 1020 TNL.
; after ath reroll: 41831/57008 hp 620/620 mana 13012/15619 mv 1428 TNL.
;May 22, 2015 - evolved to fire giant - level 178 lord no reroll done
;May 27, 2015 - remorted to paladin
;Nov 23, 2019: Changed worship from Werredan to Kra

;;; gear file
/load -q char/dhaatu.gear.ava.tf
/set lootContainer=loot

/def -wdhaatu -p1 -au -mregexp -t"^([a-zA-Z]+) pokes you in the ribs\.$" dhaatu_poke_resc = /if ({dhaatu_auto_rescue} == 2) /send rescue %{P1}%;/endif

;; Wear seneca robe to bipass curse on the ofcol rings
/def -wdhaatu -p0 -mglob -ag -h'SEND wear all' hook_dhaatu_wear_all = /send wear all=get "robes sustainment" %{main_bag}=wear "robes sustainment"=wear "robe greatness"=put "robes sustainment" %{main_bag}

;/set dhaatu_prayer_boon=Precision
/def boon = /setvar prayer_boon %*
/def -wdhaatu -au -mregexp -p10 -F -t"^(Werredan|Bhyss|Shizaga|Gorn|Kra|Tul\-Sith|Quixoltan)\'s presence disappears\.$" dhaatu_prayer_drop = \
    /if ({repray} == 1) /refreshSkill c prayer %{dhaatu_prayer_boon}%;/endif

/def -wdhaatu -au -p9 -F -mglob -t'Your force shield shimmers then fades away.' dhaatu_focidrop = \
    /if ({running} == 1) /send racial fly%;/endif

/def -mglob -wdhaatu -p5 -F -t"One of your Exhaust timers has elapsed. (shoulder burden)" dhaatu_keep_shoulder_burden = \
    /if ({dhaatu_reshoulder} == 1) \
        c 'shoulder burden'%;\
    /endif
/def -wdhaatu reshoulder = /toggle dhaatu_reshoulder%;/echoflag %dhaatu_reshoulder Re-@{hCblue}Shoulder Burden@{n}

;; Autohealing variables
; Kra War Oath levels:
/set divGain=162
/set healGain=79
/set cureLightGain=21

/def -mglob -p1 -ag -wdhaatu -t"Punch whom?" dhaatu_autoheal_toggle = \
  /if ({autoheal}=1) /set healToggle=1%;\
  /else /echo -pw @{Cgreen}Punch whom?@{n}%;/endif

;; Load in the variables saved from previous state.
/loadCharacterState dhaatu
