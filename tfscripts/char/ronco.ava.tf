;;; ronco.ava.tf
;;; Specific variables/macroes for Ronco

/load -q char/ronco.gear.ava.tf

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


/def maul = /auto maul %1
/def flay = /auto flay %1
/def rundmg = /maul %1%;/flay %1%;/cast %1%;/assist

/def -wronco -mregexp -p9 -F -t"^You start fighting .*\." ronco_autoflay =\
  /let roncoHPThresholdPercent=$[{max_hp} * {roncoHPThreshold} / 100]%;\
  /if ({curr_hp} > {roncoHPThresholdPercent} & {ronco_auto_flay} == 1) /send flay%;/endif
/def -wronco -mregexp -p9 -F -t"^You pounce on .*, claws flying!" ronco_autoflay2 =\
  /let roncoHPThresholdPercent=$[{max_hp} * {roncoHPThreshold} / 100]%;\
  /if ({curr_hp} > {roncoHPThresholdPercent} & {ronco_auto_flay} == 1) /send flay%;/endif
/def -wronco -mregexp -p9 -t"^You attempt a pounce, but .* evades!" ronco_autoflay3=\
  /let roncoHPThresholdPercent=$[{max_hp} * {roncoHPThreshold} / 100]%;\
  /if ({curr_hp} > {roncoHPThresholdPercent} & {ronco_auto_flay} == 1) /send flay%;/endif

;;; ----------------------------------------------------------------------------
;;; roncoPromptHookCheck is called from the prompt_hook via /promptHookCheck
;;; What we want to do here is just turn off auto-cast when Ronco is < 75% hp.
;;; ----------------------------------------------------------------------------
/set roncoPromptHookCheckToggle=1
; Threshold is a percent of max HP
/set roncoHPThreshold=78
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

/def ronco_char_status = \
  /set status_misc=$[getStanceStatus()]%;\
  /if ({status_misc} =~ "No Stance") /set status_misc=$[getSpellDuration()]%;/endif%;\
  /let curStanceLen=$[strlen({status_misc})]%;\
  /status_edit_misc %{curStanceLen}

;; Load in the variables saved from previous state.
/loadCharacterState ronco
