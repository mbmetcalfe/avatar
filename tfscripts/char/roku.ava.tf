;;; ----------------------------------------------------------------------------
;;; roku.ava.tf
;;; Specific variables/macroes for roku
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; Gear stuff
;;; ----------------------------------------------------------------------------
/load -q char/roku.gear.ava.tf
; Misc other triggers/aliases
;/def -wroku zokulvl = get all.levelgear %lootContainer%;rem %{ac_head}%;rem %{ac_neck1}%;wear all.levelgear
;/def -wroku rokuunlvl = rem all.levelgear%;put all.levelgear %lootContainer%;wear %{ac_head}%;wear %{ac_neck1} 

/test rokuMidSpell := (rokuMidSpell | 'disintegrate')
/test rokuAOESpell := (rokuAOESpell | 'acid rain')
/def rokumidround = /send -wroku c %{rokuMidSpell}
/def rokuaoespell = /send -wroku c %{rokuAOESpell}

/def -wroku rokuSetMySpell = \
    /let newSpell=='%{*}'%;\
    /if ({newSpell} !/ {rokuMidSpell}) \
        /send a 1=a 1 c '%{*}'%;\
    /endif
/def -wroku rokuSetMyAOESpell = \
    /let newSpell=='%{*}'%;\
    /if ({newSpell} !/ {rokuAOESpell}) \
        /send a 2=a 2 c '%{*}'%;\
    /endif

/alias airgear c 'air armor'%;c 'air hammer'%;c 'air shield'%;c 'magic light'
/def wa = stand%;/mana2ac

/alias fb \
    /if ({#} > 1 | {1} > 0) surge %1%;/endif%;\
    /setMySpell fireball%;\
    c 'fireball' %2%;\
    /if ({#} > 1 | {1} > 0) surge off%;/endif

/alias afb \
;    /def -wroku -n1 -mregexp -t'^You already are amplifying your spells\!$' gag_already_amplifying%;\
    /clrq%;\
;    wear fire%;\
;    amplify on%;\
    /setMySpell fireball%;\
    /set automidround=0%;\
    /amid %{*}%;\
    /addq /amid

;;; ----------------------------------------------------------------------------
;;; rokuPromptHookCheck is called from the prompt_hook via /promptHookCheck
;;; What we want to do here is just turn off surge when Feir is < 10000 mana.
;;; ----------------------------------------------------------------------------
;/set rokuPromptHookCheckToggle=1
;/set rokuManaThreshold=11000
;/def rokuPromptHookCheck = \
;    /if ({curr_mana} < {rokuManaThreshold} & {max_mana} > {rokuManaThreshold} & {rokuPromptHookCheckToggle} == 1) \
;        /echo -pw @{hCmagenta}Mana below threshold (%{rokuManaThreshold}). Turning @{hCred}OFF@{hCmagenta} surge.  Will turn toggle back on when mana is full.@{n}%;\
;        /send -wroku surge off%;\
;        /set rokuPromptHookCheckToggle=0%;\
;        /def full_mana_action=/set rokuPromptHookCheckToggle=1%%;/echo -pw @{hCmagenta}Surge/Mana toggle check back @{hCgreen}ON@{hCmagenta}.@{n}%;\
;    /endif

;;; ----------------------------------------------------------------------------
;;; Hero spell aliases
;;; ----------------------------------------------------------------------------
/alias di \
    /if ({#} > 1 | {1} > 0) surge %1%;/endif%;\
    /setMySpell disintegrate%;\
    c disintegrate %2%;\
    /if ({#} > 1 | {1} > 0) surge off%;/endif
/alias rain \
    /if ({#} > 1 | {1} > 0) surge %1%;/endif%;\
    /setMyAOESpell acid rain%;\
    c 'acid rain'%;\
    /if ({#} > 1 | {1} > 0) surge off%;/endif
/alias fs \
    /if ({#} > 1 | {1} > 0) surge %1%;/endif%;\
    /setMyAOESpell firestorm%;\
    c 'firestorm'%;\
    /if ({#} > 1 | {1} > 0) surge off%;/endif

/def -wroku rokuSetMySpell = \
    /let newSpell=='%{*}'%;\
    /if ({newSpell} !/ {rokuMidSpell}) \
        /send a 1=a 1 c '%{*}' \%1%;\
    /endif
/def -wroku rokuSetMyAOESpell = \
    /let newSpell=='%{*}'%;\
    /if ({newSpell} !/ {rokuAOESpell}) \
        /send a 2=a 2 c '%{*}'%;\
    /endif

;; Regular leader triggers
/def -wroku -p5 -au -mglob -t"Zaratan looks around and says, 'Damn I'm smooth!!'" roku_swap_to_ac =\
    /if ({running} == 1) /mana2ac%;/endif 
/def -wroku -p4 -au -mglob -t"Zaratan steps into a shimmering portal." roku_follow_zaratan =\
    /if ({running} == 1) /send c teleport zaratan%;/endif
/def -wroku -p5 -au -mglob -t"*Zaratan* tells the group 'aoe'" roku_leader_aoe_on =\
    /if ({running} == 1) /aoe on%;/send wear lightning%;/endif
/def -wroku -p5 -au -mglob -t"*Zaratan* tells the group 'noaoe'" roku_leader_aoe_off=\
    /if ({running} == 1) /aoe off%;/send wear fire%;/endif

/def -wroku -mglob -p1 -t"Mayflower, Explorer and Trailblazer exclaims 'Follow me for Ocean Transport!'" mayflower_timed_follow = \
    /if ({leader} =~ "Self") /repeat -0:0:04 1 /send follow mayflower%;/endif

/def -wroku -mglob -p1 -t"Mayflower, Explorer and Trailblazer says 'All aboard! Last call for Ocean Transport! If you aren't coming, go back to the geyser.'" mayflower_setup = \
    /send cast invis%;\
    /if ({leader} =~ "Self") /send west=fol self=linkrefresh group%;/endif

;; Load in the variables saved from previous state.
/loadCharacterState roku

