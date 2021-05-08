;;; ----------------------------------------------------------------------------
;;; statler.ava.tf
;;; Specific variables/macroes for statler
;;; ----------------------------------------------------------------------------
;;; 20160810: Morphed at level 319: 13430 hp 16228 mana 
;;; 20160904: Remorted to liz sor
;;; 20190520: Morphed at level 502: 8158 hp 27486 ma
;;; 20190627: Remorted to tua sor

;;; ----------------------------------------------------------------------------
;;; Gear stuff
;;; ----------------------------------------------------------------------------
/load -q char/statler.gear.ava.tf
; Misc other triggers/aliases
;/def -wstatler statlerlvl = get all.levelgear %lootContainer%;rem %{ac_head}%;rem %{ac_neck1}%;wear all.levelgear
;/def -wstatler statlerunlvl = rem all.levelgear%;put all.levelgear %lootContainer%;wear %{ac_head}%;wear %{ac_neck1} 

;/test statlerMidSpell := (statlerMidSpell | 'vampire touch')
/test statlerAOESpell := (statlerAOESpell | 'pillar of flame')
/def statlermidround = /send -wstatler c %{statlerMidSpell}
/def statleraoespell = /send -wstatler c %{statlerAOESpell}

/def wa = stand%;/mana2ac

;;; ----------------------------------------------------------------------------
;;; statlerPromptHookCheck is called from the prompt_hook via /promptHookCheck
;;; What we want to do here is just turn off surge when Feir is < 10000 mana.
;;; ----------------------------------------------------------------------------
;/set statlerPromptHookCheckToggle=1
;/set statlerManaThreshold=10000
;/def statlerPromptHookCheck = \
;    /if ({curr_mana} < {statlerManaThreshold} & {max_mana} > {statlerManaThreshold} & {statlerPromptHookCheckToggle} == 1) \
;        /echo -pw @{hCmagenta}Mana below threshold (%{statlerManaThreshold}). Turning @{hCred}OFF@{hCmagenta} surge.  Will turn toggle back on when mana is full.@{n}%;\
;        /send -wstatler surge off%;\
;        /set statlerPromptHookCheckToggle=0%;\
;        /def full_mana_action=/set statlerPromptHookCheckToggle=1%%;/echo -pw @{hCmagenta}Surge/Mana toggle check back @{hCgreen}ON@{hCmagenta}.@{n}%;\
;    /endif

;;; ----------------------------------------------------------------------------
;;; Hero spell aliases
;;; ----------------------------------------------------------------------------
/alias torm \
    /if ({#} > 1 | {1} > 0) surge %1%;/endif%;\
    /setMySpell torment%;\
    c torm %2%;\
    /if ({#} > 1 | {1} > 0) surge off%;/endif

/def -wstatler statlerSetMySpell = \
    /let newSpell=='%{*}'%;\
    /if ({newSpell} !/ {statlerMidSpell}) \
        /send a 1=a 1 c '%{*}' \%1%;\
    /endif
/def -wstatler statlerSetMyAOESpell = \
    /let newSpell=='%{*}'%;\
    /if ({newSpell} !/ {statlerAOESpell}) \
        /send a 2=a 2 c '%{*}' \%1%;\
    /endif

/def -wstatler -Fp5 -au -P0h -t"calls forth acid to scour away his foes!" statler_highlight_acid_rain

;;
/def -wstatler -mregexp -au -t"^\*Sal\* tells the group \'calm\'" statler_calm_gt = /if ({running}==1) /send quicken 9=c calm=quicken off%;/endif

; Temp trigger to swap to ac when Nit does
;/def -wstatler -mglob -t"^(Roku|Nit) smoothes out its clothes." nit_smooth_to_ac = /mana2ac

/def -wstatler -mglob -p1 -t"Mayflower, Explorer and Trailblazer exclaims 'Follow me for Ocean Transport!'" mayflower_timed_follow = \
    /if ({leader} =~ "Self") /repeat -0:0:04 1 /send follow mayflower%;/endif

/def -wstatler -mglob -p1 -t"Mayflower, Explorer and Trailblazer says 'All aboard! Last call for Ocean Transport! If you aren't coming, go back to the geyser.'" mayflower_setup = \
    /send cast invis%;\
    /if ({leader} =~ "Self") /send west=fol self=linkrefresh group%;/endif

;;; scripts to bipass migraine effects if stuff is stacked
/def -wstatler -p1900 -mregexp -auCwhite -t"^You feel a slight headache growing stronger\.\.\." statler_migraine = \
    /if ({running}=1) quicken off%;surge off%;c 'chill touch'%;/endif

;; Load in the variables saved from previous state.
/loadCharacterState statler

