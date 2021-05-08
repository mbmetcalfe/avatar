;;; ----------------------------------------------------------------------------
;;; paxon.ava.tf
;;; Specific variables/macroes for Paxon
;;; ----------------------------------------------------------------------------
; insigs
; * Sept Arak'Tki Surveyor
; * Sept Tlan'Kle'Sha Ally
; * Sept Xkra'Zvim Retainer | Sept Xkra'Zvim Do-Gooder
; * Sept Nik'Avrym Problem-Solver
; Need to answer 2 questions for ^
; 1. Was the name of the last king of the dwarven kingdom sometimes referred to as Kangtan? - Juargan
; 2. I'm green and I'm black and I'm red - but generally I'm brown, 
;    I come from a bush, and am in a bag in a pot - but mostly I'm in a cup, What am I? -- tea 
; * Sept N'Tel'Sha Retainer
; Sept Kwa'Xulu Agent | Sept Kwa'Xulu Operative | Sept Kwa'Xulu Traitor | Sept N'Tel'Sha Master Spy

;;; ----------------------------------------------------------------------------
;;; Gear stuff
;;; ----------------------------------------------------------------------------
/load -q char/paxon.gear.ava.tf
; Misc other triggers/aliases
;/def -wpaxon paxonlvl = get all.levelgear %lootContainer%;rem %{ac_head}%;rem %{ac_neck1}%;wear all.levelgear
;/def -wpaxon paxonunlvl = rem all.levelgear%;put all.levelgear %lootContainer%;wear %{ac_head}%;wear %{ac_neck1} 
/def -wpaxon paxonSetMySpell = \
    /let newSpell=='%{*}'%;\
    /if ({newSpell} !/ {paxonMidSpell}) \
        /send a 1=a 1 c '%{*}'%;\
    /endif
/def -wpaxon paxonSetMyAOESpell = \
    /let newSpell=='%{*}'%;\
    /if ({newSpell} !/ {paxonAOESpell}) \
        /send a 2=a 2 c '%{*}'%;\
    /endif

;;; ----------------------------------------------------------------------------
;;; paxonPromptHookCheck is called from the prompt_hook via /promptHookCheck
;;; What we want to do here is just turn off surge when paxon is < 10000 mana.
;;; ----------------------------------------------------------------------------
/set paxonPromptHookCheckToggle=1
/set paxonManaThreshold=10000
/def paxonPromptHookCheck = \
    /if ({curr_mana} < {paxonManaThreshold} & {max_mana} > {paxonManaThreshold} & {paxonPromptHookCheckToggle} == 1) \
        /echo -pw @{hCmagenta}Mana below threshold. Turning @{hCred}OFF@{hCmagenta} surge.  Will turn toggle back on when mana is full.@{n}%;\
        /send -wpaxon surge off%;\
        /set paxonPromptHookCheckToggle=0%;\
        /def full_mana_action=/set paxonPromptHookCheckToggle=1%%;/echo -pw @{hCmagenta}Surge/Mana toggle check back @{hCgreen}ON@{hCmagenta}.@{n}%;\
        /if ({multi} == 1) /send gtell Mana low, turning surge off%;/endif%;\
    /endif

/alias airgear c 'air armor'%;c 'air hammer'%;c 'air shield'%;c 'magic light'
/def wa = stand%;/mana2ac

;/def -wpaxon -p9 -ag -mregexp -F -t"\'s attac.* strikes? you [0-9]* (time|times), with .* [a-zA-Z]*(\.|\!)$" paxon_aggie_swap_flash = \
;    /if ({running}==1) /q 6 c flash%;/endif
;/def -wpaxon -p9 -ag -mregexp -F -t"\'s attacks haven\'t hurt you\!$" paxon_nil_aggie_flash = \
;    /if ({running}==1) /q 6 c flash%;/endif

;;; ----------------------------------------------------------------------------
;;; Hero spell aliases
;;; ----------------------------------------------------------------------------
/alias di \
    /if ({#} > 1 | {1} > 0) surge %1%;/endif%;\
    c disintegrate %2%;\
    /if ({#} > 1 | {1} > 0) surge off%;/endif
/alias rain \
    /if ({#} > 1 | {1} > 0) surge %1%;/endif%;\
    c 'acid rain'%;\
    /if ({#} > 1 | {1} > 0) surge off%;/endif
/alias fs \
    /if ({#} > 1 | {1} > 0) surge %1%;/endif%;\
    c 'firestorm'%;\
    /if ({#} > 1 | {1} > 0) surge off%;/endif

;;; ----------------------------------------------------------------------------
;;; Lord spell aliases
;;; ----------------------------------------------------------------------------
/alias met /if ({#} > 1 | {1} > 0) surge %1%;/endif%;c 'meteor swarm'%;/if ({#} > 1 | {1} > 0) surge off%;/endif

/def -wpaxon tmae = \
    /if ({autocast}=1) \
    	c mae%;inv%;\
    	/repeat -0:00:35 1 /tmae%; \
    /endif

/def -wpaxon -mregexp -t"^Your innate mental strength defeats ([a-zA-Z]+)'s frenzy spell\!" paxon_tranquil_frenzy = /send emote is filled with rage!

/def chargeit = charge fire flametongue%;/def full_mana_action = wake%%;charge light arc

;; refresh sneak if running
/def -p9 -t"You feel less fatigued. (sneak)" paxon_refresh_sneak = /if ({running}==1) /send racial sneak%;/endif

;; Load in the variables saved from previous state.
/loadCharacterState paxon

