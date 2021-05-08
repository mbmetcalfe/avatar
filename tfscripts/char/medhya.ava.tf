;;; medhya.ava.tf
;;; Specific variables/macroes for Medhya

/require psionic.tf

/load -q char/medhya.gear.ava.tf

/alias ps quicken 9%;c psyphon %1%;quicken off

/def -wmedhya -p6 -mregexp -ah -t"You psyphon (.*) with (.*) intensity." medhya_psyphon_mob = \
    /set ticktoggle=1%;\
    /repeat -00:00:03 1 /sregen

;; Turn Medhya's drone on with /auto drone on

; rename it for now, while he's running alt
/def medhyadrone = \
  /if ({medhya_auto_drone}=1) \
      /send config +noautomove=title |n|: BUZZ FOR STEEL%;\
      /send get lens %{main_bag}=wear lens%;\
  /else \
      /send title reset=config -noautomove%;\
      /send rem lens=put lens %{main_bag}=wear "hat faded yellow sea bleached"%;\
  /endif%;\
  /send tag remove bot%;\
  /if ({medhya_auto_drone} == 1) \
      /send tag set bot |c|Currently botting. Buzz for steel.|n|%;\
  /endif

/def -wmedhya -mregexp -t"You swat at your ear, a buzzing noise is coming from ([a-zA-Z]+)." medhyasteel =\
    /if ({medhya_auto_drone} = 1) stand%;c 'steel skeleton' %P1%;sleep%;/endif

/def -wmedhya runcast = /auto runcast %1
/def -wmedhya -F -mregexp -t"^You start fighting " medhya_auto_runcast_toggle = /if /test $(/getvar auto_runcast) == 1%;/then /repeat -0:00:3 1 /cast on%%;/aq /cast off%;/endif

;;; ----------------------------------------------------------------------------
;;; medhyaPromptHookCheck is called from the prompt_hook via /promptHookCheck
;;; What we want to do here is just turn off surge when Feir is < 10000 mana.
;;; ----------------------------------------------------------------------------
/set medhyaPromptHookCheckToggle=1
/set medhyaManaThreshold=250
/def medhyaPromptHookCheck = \
  /if ({curr_mana} < {medhyaManaThreshold} & {max_mana} > {medhyaManaThreshold} & {medhyaPromptHookCheckToggle} == 1 & {medhya_auto_cast} == 1) \
    /cast off%;\
    /echo -pw @{hCmagenta}Mana below threshold (%{medhyaManaThreshold}). Turning @{hCred}OFF@{hCmagenta} surge.  Will turn toggle back on when mana is full.@{n}%;\
    /send -wmedhya surge off%;\
    /set medhyaPromptHookCheckToggle=0%;\
    /def full_mana_action=/set medhyaPromptHookCheckToggle=1%%;/echo -pw @{hCmagenta}Surge/Mana toggle check back @{hCgreen}ON@{hCmagenta}.@{n}%;\
    /runcast off%;\
  /endif

;; Load in the variables saved from previous state.
/loadCharacterState medhya

