;;; ----------------------------------------------------------------------------
;;; zaratan.ava.tf
;;; Specific variables/macroes for zaratan
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; Gear stuff
;;; ----------------------------------------------------------------------------
/load -q char/zaratan.gear.ava.tf
; Misc other triggers/aliases
;/def -wzaratan zaratanlvl = get all.levelgear %lootContainer%;rem %{ac_head}%;rem %{ac_neck1}%;wear all.levelgear
;/def -wzaratan zaratanunlvl = rem all.levelgear%;put all.levelgear %lootContainer%;wear %{ac_head}%;wear %{ac_neck1} 

/alias aoe \
  /aoe %{1}%;\
  /set zaratan_auto_cast 1%;\
  /if ({auto_aoe} == 1) /send wear light=gt aoe%;\
  /else /send wear fire=gt noaoe%;\
  /endif

/def -wzaratan -au -p9 -F -mglob -t'Your force shield shimmers then fades away.' zaratan_focidrop = \
    /if ({running} == 1) /send racial fly%;/endif

/test zaratanMidSpell := (zaratanMidSpell | 'disintegrate')
/test zaratanAOESpell := (zaratanAOESpell | 'acid rain')
/def zaratanmidround = /send -wzaratan c %{zaratanMidSpell}
/def zaratanaoespell = /send -wzaratan c %{zaratanAOESpell}

/def -wzaratan zaratanSetMySpell = \
    /let newSpell=='%{*}'%;\
    /if ({newSpell} !/ {zaratanMidSpell}) \
        /send a 1=a 1 c '%{*}' \%1%;\
    /endif
/def -wzaratan zaratanSetMyAOESpell = \
    /let newSpell=='%{*}'%;\
    /if ({newSpell} !/ {zaratanAOESpell}) \
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
;    /def -wzaratan -n1 -mregexp -t'^You already are amplifying your spells\!$' gag_already_amplifying%;\
    /clrq%;\
;    wear fire%;\
;    amplify on%;\
    /setMySpell fireball%;\
    /set automidround=0%;\
    /amid %{*}%;\
    /addq /amid

;;; ----------------------------------------------------------------------------
;;; zaratanPromptHookCheck is called from the prompt_hook via /promptHookCheck
;;; What we want to do here is just turn off surge when Feir is < 10000 mana.
;;; ----------------------------------------------------------------------------
;/set zaratanPromptHookCheckToggle=1
;/set zaratanManaThreshold=11000
;/def zaratanPromptHookCheck = \
;    /if ({curr_mana} < {zaratanManaThreshold} & {max_mana} > {zaratanManaThreshold} & {zaratanPromptHookCheckToggle} == 1) \
;        /echo -pw @{hCmagenta}Mana below threshold (%{zaratanManaThreshold}). Turning @{hCred}OFF@{hCmagenta} surge.  Will turn toggle back on when mana is full.@{n}%;\
;        /send -wzaratan surge off%;\
;        /set zaratanPromptHookCheckToggle=0%;\
;        /def full_mana_action=/set zaratanPromptHookCheckToggle=1%%;/echo -pw @{hCmagenta}Surge/Mana toggle check back @{hCgreen}ON@{hCmagenta}.@{n}%;\
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

;;; ----------------------------------------------------------------------------
;;; Green Dragon triggers
;;; ----------------------------------------------------------------------------

/def -wzaratan -Fp5 -au -P0h -t"calls forth acid to scour away his foes!" zaratan_highlight_acid_rain

/def -wzaratan -mglob -p1 -t"Mayflower, Explorer and Trailblazer exclaims 'Follow me for Ocean Transport!'" mayflower_timed_follow = \
    /if ({leader} =~ "Self") /repeat -0:0:04 1 /send follow mayflower%;/endif

/def -wzaratan -mglob -p1 -t"Mayflower, Explorer and Trailblazer says 'All aboard! Last call for Ocean Transport! If you aren't coming, go back to the geyser.'" mayflower_setup = \
    /send cast invis%;\
    /if ({leader} =~ "Self") /send west=fol self=linkrefresh group=sleep%;/endif

;; Load in the variables saved from previous state.
/loadCharacterState zaratan

