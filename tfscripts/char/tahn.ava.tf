;-------------------------------------------------------------------------------
;;; tahn.ava.tf
;;; Specific variables/macroes for Tahn
;-------------------------------------------------------------------------------
/require psionic.tf

;;; read in Tahn's gear file
/load -q char/tahn.gear.ava.tf
;-------------------------------------------------------------------------------
/alias bio /send look %1 description
/alias ps quicken 9%;c psyphon %1%;quicken off
;-------------------------------------------------------------------------------
/alias mw c mindwipe %2
/alias frac \
    /if ({#} > 1 | {1} > 0) surge %1%;/endif%;\
   c fracture %2%;\
    /if ({#} > 1 | {1} > 0) surge off%;/endif
;-------------------------------------------------------------------------------
/def -wtahn -p6 -mregexp -ah -t"You psyphon (.*) with (.*) intensity." tahn_psyphon_mob = \
    /set ticktoggle=1%;\
    /repeat -00:00:03 1 /sregen

;;; scripts to bipass migraine effects if stuff is stacked
/def -wtahn -p900 -mregexp -ahCwhite -t"^You feel a slight headache growing stronger..." tahn_migraine_disconnect = \
    /if ({running}=1) /rc%;quicken off%;surge off%;c 'psychic drain'%;/endif

/set tahnMidSpell='fracture'
/def tahnmidround = /send -wtahn c %{tahnMidSpell}

;;; ----------------------------------------------------------------------------
;;; tahnPromptHookCheck is called from the prompt_hook via /promptHookCheck
;;; What we want to do here is just turn off surge when tahn is < 10000 mana.
;;; ----------------------------------------------------------------------------
/set tahnPromptHookCheckToggle=1
/set tahnManaThreshold=10000
/def tahnPromptHookCheck = \
    /if ({curr_mana} < {tahnManaThreshold} & {max_mana} > {tahnManaThreshold} & {tahnPromptHookCheckToggle} == 1) \
        /echo -pw @{hCmagenta}Mana below threshold. Turning @{hCred}OFF@{hCmagenta} surge.  Will turn toggle back on when mana is full.@{n}%;\
        /send -wtahn surge off%;\
        /set tahnPromptHookCheckToggle=0%;\
        /def full_mana_action=/set tahnPromptHookCheckToggle=1%%;/echo -pw @{hCmagenta}Surge/Mana toggle check back @{hCgreen}ON@{hCmagenta}.@{n}%;\
        /if ({multi} == 1) /send gtell Mana low, turning surge off%;/endif%;\
    /endif

;; Load in the variables saved from previous state.
/loadCharacterState tahn

