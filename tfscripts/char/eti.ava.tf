;;; ----------------------------------------------------------------------------
;;; eti.ava.tf
;;; Specific variables/macroes for eti
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; Gear stuff
;;; ----------------------------------------------------------------------------
/load -q char/eti.gear.ava.tf
; Misc other triggers/aliases
;/def -weti etilvl = get all.levelgear %lootContainer%;rem %{ac_head}%;rem %{ac_neck1}%;wear all.levelgear
;/def -weti etiunlvl = rem all.levelgear%;put all.levelgear %lootContainer%;wear %{ac_head}%;wear %{ac_neck1} 

/test etiMidSpell := (etiMidSpell | 'maelstrom')
/test etiAOESpell := (etiAOESpell | 'meteor swarm')
/def etimidround = /send -weti c %{etiMidSpell}
/def etiaoespell = /send -weti c %{etiAOESpell}

/def -weti etiSetMySpell = \
    /let newSpell=='%{*}'%;\
    /if ({newSpell} !/ {etiMidSpell}) \
        /send a 1=a 1 c '%{*}'%;\
    /endif
/def -weti etiSetMyAOESpell = \
    /let newSpell=='%{*}'%;\
    /if ({newSpell} !/ {etiAOESpell}) \
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
;    /def -weti -n1 -mregexp -t'^You already are amplifying your spells\!$' gag_already_amplifying%;\
    /clrq%;\
;    wear fire%;\
;    amplify on%;\
    /setMySpell fireball%;\
    /set automidround=0%;\
    /amid %{*}%;\
    /addq /amid

;;; ----------------------------------------------------------------------------
;;; etiPromptHookCheck is called from the prompt_hook via /promptHookCheck
;;; What we want to do here is just turn off surge when Feir is < 10000 mana.
;;; ----------------------------------------------------------------------------
/set etiPromptHookCheckToggle=1
/set etiManaThreshold=11000
/def etiPromptHookCheck = \
    /if ({curr_mana} < {etiManaThreshold} & {max_mana} > {etiManaThreshold} & {etiPromptHookCheckToggle} == 1) \
        /echo -pw @{hCmagenta}Mana below threshold (%{etiManaThreshold}). Turning @{hCred}OFF@{hCmagenta} surge.  Will turn toggle back on when mana is full.@{n}%;\
        /send -weti surge off%;\
        /set etiPromptHookCheckToggle=0%;\
        /def full_mana_action=/set etiPromptHookCheckToggle=1%%;/echo -pw @{hCmagenta}Surge/Mana toggle check back @{hCgreen}ON@{hCmagenta}.@{n}%;\
    /endif

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

/alias adi \
    /clrq%;\
    wear fire%;\
    /setMySpell disintegrate%;\
    /set automidround=0%;\
    /amid %{*}%;\
    di %{*}%;\
    /addq /amid

/alias arain \
    /clrq%;\
    /setMyAOESpell acid rain%;\
    wear light%;\
    rain %{*}

/def -weti -Fp5 -au -P0h -t"calls forth acid to scour away his foes!" eti_highlight_acid_rain

/def -p4 -mglob -t"Paxon calls forth acid to scour away its foes!" eti_acid_rain =\
    /if ({multi} == 1) \
        /send cast firestorm%;\
    /endif

/def -weti -mglob -p1 -t"Mayflower, Explorer and Trailblazer exclaims 'Follow me for Ocean Transport!'" mayflower_timed_follow = \
    /if ({leader} =~ "Self") /repeat -0:0:04 1 /send follow mayflower%;/endif

/def -weti -mglob -p1 -t"Mayflower, Explorer and Trailblazer says 'All aboard! Last call for Ocean Transport! If you aren't coming, go back to the geyser.'" mayflower_setup = \
    /send cast invis%;\
    /if ({leader} =~ "Self") /send west=fol self=linkrefresh group%;/endif

;;; ----------------------------------------------------------------------------
;;;; Misc other triggers/aliases
;;; ----------------------------------------------------------------------------
/def -weti detects = c infravision%;c 'detect hidden'%;c 'detect invis'

;;; scripts to bipass migraine effects if stuff is stacked
/def -weti -p900 -mregexp -ahCwhite -t"^You feel a slight headache growing stronger..." migraine_disconnect_eti = \
	    /if ({running}=1) /rc%;quicken off%;surge off%;c 'magic missile'%;/endif

;; Load in the variables saved from previous state.
/loadCharacterState eti

