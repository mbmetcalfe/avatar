;;; ----------------------------------------------------------------------------
;;; paxan.ava.tf
;;; Specific variables/macroes for paxan
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; Gear stuff
;;; ----------------------------------------------------------------------------
/load -q char/paxan.gear.ava.tf
; Misc other triggers/aliases
;/def -wpaxan paxanlvl = get all.levelgear %lootContainer%;rem %{ac_head}%;rem %{ac_neck1}%;wear all.levelgear
;/def -wpaxan paxanunlvl = rem all.levelgear%;put all.levelgear %lootContainer%;wear %{ac_head}%;wear %{ac_neck1} 

/alias aoe \
  /aoe %{1}%;\
  /set paxan_auto_cast 1%;\
  /if ({auto_aoe} == 1) /send wear light=gt aoe%;\
  /else /send wear fire=gt noaoe%;\
  /endif

/def -wpaxan -au -p9 -F -mglob -t'Your force shield shimmers then fades away.' paxan_focidrop = \
    /if ({running} == 1) /send racial fly%;/endif

/test paxanMidSpell := (paxanMidSpell | 'disintegrate')
/test paxanAOESpell := (paxanAOESpell | 'acid rain')
/def paxanmidround = /send -wpaxan c %{paxanMidSpell}
/def paxanaoespell = /send -wpaxan c %{paxanAOESpell}

/def -wpaxan paxanSetMySpell = \
    /let newSpell=='%{*}'%;\
    /if ({newSpell} !/ {paxanMidSpell}) \
        /send a 1=a 1 c '%{*}' \%1%;\
    /endif
/def -wpaxan paxanSetMyAOESpell = \
    /let newSpell=='%{*}'%;\
    /if ({newSpell} !/ {paxanAOESpell}) \
        /send a 2=a 2 c '%{*}'%;\
    /endif

/alias airgear c 'air armor'%;c 'air hammer'%;c 'air shield'%;c 'magic light'
/def wa = stand%;/mana2ac

;;; ----------------------------------------------------------------------------
;;; paxanPromptHookCheck is called from the prompt_hook via /promptHookCheck
;;; What we want to do here is just turn off surge when Feir is < 10000 mana.
;;; ----------------------------------------------------------------------------
;/set paxanPromptHookCheckToggle=1
;/set paxanManaThreshold=11000
;/def paxanPromptHookCheck = \
;    /if ({curr_mana} < {paxanManaThreshold} & {max_mana} > {paxanManaThreshold} & {paxanPromptHookCheckToggle} == 1) \
;        /echo -pw @{hCmagenta}Mana below threshold (%{paxanManaThreshold}). Turning @{hCred}OFF@{hCmagenta} surge.  Will turn toggle back on when mana is full.@{n}%;\
;        /send -wpaxan surge off%;\
;        /set paxanPromptHookCheckToggle=0%;\
;        /def full_mana_action=/set paxanPromptHookCheckToggle=1%%;/echo -pw @{hCmagenta}Surge/Mana toggle check back @{hCgreen}ON@{hCmagenta}.@{n}%;\
;    /endif

/def -wpaxan -Fp5 -au -P0h -t"calls forth acid to scour away his foes!" paxan_highlight_acid_rain

/def -wpaxan -mglob -p1 -t"Mayflower, Explorer and Trailblazer exclaims 'Follow me for Ocean Transport!'" mayflower_timed_follow = \
    /if ({leader} =~ "Self") /repeat -0:0:04 1 /send follow mayflower%;/endif

/def -wpaxan -mglob -p1 -t"Mayflower, Explorer and Trailblazer says 'All aboard! Last call for Ocean Transport! If you aren't coming, go back to the geyser.'" mayflower_setup = \
    /send cast invis%;\
    /if ({leader} =~ "Self") /send west=fol self=linkrefresh group=sleep%;/endif

;; Load in the variables saved from previous state.
/loadCharacterState paxan

