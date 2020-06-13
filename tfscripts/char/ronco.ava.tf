;;; ronco.ava.tf
;;; Specific variables/macroes for Ronco

/load -q char/ronco.gear.ava.tf

;; Temp triggers until he gets more mvs
/def -wronco -mregexp -p1 -au -t"^You feel less durable\.$" ronco_endurance_fall = \
    /send wear seven%;\
    /set enduranceleft=-1
/def -wronco -mregexp -p1 -au -t"^You feel energized\.$" ronco_endurance_up = \
    /send wear %{hit_feet}=config +savespell%;\
    /set enduranceleft=999

; Tear triggers
/def -wronco -mglob -t"One of your Exhaust timers has elapsed. (tear)" ronco_tear_ready = \
    /if ({refreshmisc} == 1) \
        /refreshSkill tear%;\
    /endif
/def -wronco -mglob -t"You tear * from the corpse * and eat it!" ronco_tear_up = /send aff ?tear

; Flay and maul triggers
;You prepare to flay your enemy's hide...
;You flay Crullius the White's hide!
;You prepare to dispense a savage mauling...

;;; ----------------------------------------------------------------------------
;;; roncoPromptHookCheck is called from the prompt_hook via /promptHookCheck
;;; What we want to do here is just turn off auto-cast when Ronco is < 75% hp.
;;; ----------------------------------------------------------------------------
/def amaul = /auto maul %1
/set roncoPromptHookCheckToggle=1
; Threshold is a percent of max HP
/set roncoHPThreshold=75
/def roncoPromptHookCheck = \
    /let roncoHPThresholdPercent=$[{max_hp} * {roncoHPThreshold} / 100]%;\
    /if ({curr_hp} < {roncoHPThresholdPercent} & {roncoPromptHookCheckToggle} == 1 & {ronco_auto_maul} == 1 & {ronco_auto_cast} == 1) \
        /echo -pw @{Cred}[CHAR INFO]: @{hCmagenta}HP below threshold.@{n}%;\
        /cast off%;\
        /set roncoPromptHookCheckToggle=0%;\
    /elseif ({curr_hp} > {roncoHPThresholdPercent} & {roncoPromptHookCheckToggle} == 0 & {ronco_auto_maul} == 1 & {ronco_auto_cast} == 0) \
        /echo -pw @{Cred}[CHAR INFO]: @{hCmagenta}HP above threshold.@{n}%;\
        /cast on%;\
        /set roncoPromptHookCheckToggle=1%;\
    /endif

;; Load in the variables saved from previous state.
/loadCharacterState ronco
