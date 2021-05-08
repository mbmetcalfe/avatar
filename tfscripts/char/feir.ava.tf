;;; ----------------------------------------------------------------------------
;;; feir.ava.tf
;;; Oct 29, 2009: Renamed from spyki to feir.
;;; Jan 8, 2005: Hero 613 Mage -> Wizard rebuild:
;;;		Before: 1189 hp   4196 ma   2889 mv
;;;		After:   478 hp   4796 ma   2666 mv
;;; Jan, 2005:	Hero 709: You lose 132 hero levels!
;;; Feb, 2005:	Hero 685: You lose 147 hero levels!
;;; May 28, 2005: Morphed from level 777.
;;; 20050108: Hero 613 Mage -> Wizard rebuild:
;;;    Before: 1189 hp   4196 ma   2889 mv
;;;    After:   478 hp   4796 ma   2666 mv
;;; 200501xx: Hero 709: You lose 132 hero levels!
;;; 200502xx: Hero 685: You lose 147 hero levels!
;;; 20050528: Morphed from level 777.
;;; xxxxxxxx: Rebuilt back to mage.
;;; ----------------------------------------------------------------------------
/def -F -wfeir -mglob -t"Welcome to the AVATAR System, Lord Feir." feir_lord999_login = \
  /hook_resize%;\
  /let logincharname=${world_character}%;\
  /let logincharname=$[tolower({logincharname})]%;\
  /set myname=%{logincharname}%;\
  /def -hload -ag ~gagload%;\
  /undef ~gagload%;\
  /atitle (%mytier %mylevel)%;\
  /send worth
/load -q char/feir.gear.ava.tf

/def -wfeir feirunlvl = \
  /def -wfeir -n2 -p10 -ag -mregexp -t"^Playerinfo (cleared|line added)\." feir_playerinfo_gag%;\
  /let levelDiff=$[{mylevel} - 999]%;\
  /send playeri clear=playeri + |w|Level 125(|g|999|w|+|g|%{levelDiff}|w|: |g|%{mylevel}|w|) Sprite Mage

/alias di surge %1%;c disint %2%;surge 1
/alias rain surge %1%;c 'acid rain'%;surge 1
/alias mae surge %1%;c maelstrom %2%;surge 1
/alias met surge %1%;c 'meteor swarm'%;surge 1

/test feirMidSpell := (feirMidSpell | "maelstrom")
/test feirAOESpell := (feirAOESpell | "meteor swarm")
/def feirmidround = /send -wfeir c %{feirMidSpell}
/def feiraoespell = /send -wfeir c %{feirAOESpell}

/def -wfeir feirSetMySpell = \
    /let newSpell=='%{*}'%;\
    /if ({newSpell} !/ {feirMidSpell}) \
        /send a 1=a 1 c '%{*}'%;\
    /endif
/def -wfeir feirSetMyAOESpell = \
    /let newSpell=='%{*}'%;\
    /if ({newSpell} !/ {feirAOESpell}) \
        /send a 2=a 2 c '%{*}'%;\
    /endif

;;; ----------------------------------------------------------------------------
;;; feirPromptHookCheck is called from the prompt_hook via /promptHookCheck
;;; What we want to do here is just turn off surge when Feir is < 10000 mana.
;;; ----------------------------------------------------------------------------
/set feirPromptHookCheckToggle=1
/set feirManaThreshold=9000
/def feirPromptHookCheck = \
    /if ({curr_mana} < {feirManaThreshold} & {max_mana} > {feirManaThreshold} & {feirPromptHookCheckToggle} == 1) \
        /echo -pw @{hCmagenta}Mana below threshold (%{feirManaThreshold}). Turning @{hCred}OFF@{hCmagenta} surge.  Will turn toggle back on when mana is full.@{n}%;\
        /send -wfeir surge off%;\
        /set feirPromptHookCheckToggle=0%;\
        /def full_mana_action=/set feirPromptHookCheckToggle=1%%;/echo -pw @{hCmagenta}Surge/Mana toggle check back @{hCgreen}ON@{hCmagenta}.@{n}%%;/aq surge 2%;\
        /if ({multi} == 1) /send gtell Mana low, turning surge off%;/endif%;\
    /endif
    
;;; ----------------------------------------------------------------------------
;;;; Misc other triggers/aliases
;;; ----------------------------------------------------------------------------
/def -wfeir detects = c infravision%;c 'detect hidden'%;c 'detect invis'

;;; scripts to bipass migraine effects if stuff is stacked
/def -wfeir -p900 -mregexp -ahCwhite -t"^You feel a slight headache growing stronger..." migraine_disconnect_feir = \
    /if ({running}=1) c 'water breathing'%;/endif

;/def i-wfeir -F -mglob -p5 -t"You form a magical vortex and step into it..." feir_shift = \


;; Load in the variables saved from previous state.
/loadCharacterState feir
