;-------------------------------------------------------------------------------
;;; illum.ava.tf
;-------------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; Gear stuff
;;; ----------------------------------------------------------------------------
/load -q char/illum.gear.ava.tf

;-------------------------------------------------------------------------------
;;; spell aliases
;-------------------------------------------------------------------------------
/alias immo /send c immolation %1
/alias vamp \
    /if ({#} > 1 | {1} > 0) surge %1%;/endif%;\
    c 'vampire touch' %2%;\
    /if ({#} > 1 | {1} > 0) surge off%;/endif

;;; ----------------------------------------------------------------------------
;;; illumPromptHookCheck is called from the prompt_hook via /promptHookCheck
;;; What we want to do here is just turn off surge when Illum is < 10000 mana.
;;; ----------------------------------------------------------------------------
;/set illumPromptHookCheckToggle=1
;/set illumManaThreshold=10000
;/def illumPromptHookCheck = \
;    /if ({curr_mana} < {illumManaThreshold} & {max_mana} > {illumManaThreshold} & {illumPromptHookCheckToggle} == 1) \
;        /echo -pw @{hCmagenta}Mana below threshold (%{illumManaThreshold}). Turning @{hCred}OFF@{hCmagenta} surge.  Will turn toggle back on when mana is full.@{n}%;\
;        /send -willum surge off%;\
;        /set illumPromptHookCheckToggle=0%;\
;        /def full_mana_action=/set illumPromptHookCheckToggle=1%%;/echo -pw @{hCmagenta}Surge/Mana toggle check back @{hCgreen}ON@{hCmagenta}.@{n}%%;/addq surge 2%;\
;        /if ({multi} == 1) /send gtell Mana low, turning surge off%;/endif%;\
;    /elseif ({curr_mana} > {illumManaThreshold} & {max_mana} > {illumManaThreshold} & {illumPromptHookCheckToggle} == 0) \
;        /echo -pw @{hCmagenta}Mana above threshold (%{illumManaThreshold}). Turning @{hCgreen}ON@{hCmagenta} surge.@{n}%;\
;        /send -willum surge 2%;\
;        /set illumPromptHookCheckToggle=1%;\
;        /if ({multi} == 1) /send gtell Mana low, turning surge off%;/endif%;\
;    /endif

;;; Hero version
/set illumManaThreshold=250
/def illumPromptHookCheck = \
    /if ({curr_mana} < {illumManaThreshold} & {max_mana} > {illumManaThreshold} & {illumPromptHookCheckToggle} == 1 & {illum_auto_cast} == 1) \
        /cast off%;\
        /echo -pw @{hCmagenta}Mana below threshold (%{illumManaThreshold}). Turning @{hCred}OFF@{hCmagenta} surge.  Will turn toggle back on when mana is full.@{n}%;\
        /send -willum surge off%;\
        /set illumPromptHookCheckToggle=0%;\
        /def full_mana_action=/set illumPromptHookCheckToggle=1%%;/echo -pw @{hCmagenta}Surge/Mana toggle check back @{hCgreen}ON@{hCmagenta}.@{n}%;\
        /runcast off%;\
    /endif

/def illumThreshold = \
        /echo -pw @{hCmagenta}Mana above threshold (%{illumManaThreshold}). Turning @{hCgreen}ON@{hCmagenta} surge.@{n}%;\
        /send -illum surge 2%;\
        /set illumPromptHookCheckToggle=1%;\
        /if ({multi} == 1) /send gtell Mana low, turning surge off%;/endif

/def -willum runcast = /auto runcast %1
/def -willum -i togglecast = /if /test ($(/getvar pos) =~ "fight")%;/then /cast on%;/aq /cast off%;/else /echo -pw Position: $(/getvar pos)%;/endif 
;/def -willum -F -mregexp -t"^You start fighting " illum_auto_runcast_toggle = /if /test $(/getvar auto_runcast) == 1%;/then /repeat -0:00:3 1 /cast on%%;/aq /cast off%;/endif
/def -willum -F -mregexp -t"^You start fighting " illum_auto_runcast_toggle = /if /test $(/getvar auto_runcast) == 1%;/then /repeat -0:00:3 1 /togglecast%;/endif

;-------------------------------------------------------------------------------
/alias ratt get rattle %main_bag%;wear rattle%;zap %1%;wear %unbrandish%;put rattle %main_bag

;-------------------------------------------------------------------------------

/def -willum -mglob -t"One of your Exhaust timers has elapsed. (unholy bargain)" illum_unholy_bargain_avail = \
    /if ({refreshmisc} == 1) /refreshSpell 'unholy bargain'%;/endif

/def -willum -au -p9 -F -mglob -t'Your force shield shimmers then fades away.' illum_focidrop = /if ({running} == 1) /send racial fly%;/endif

;; Mayflower things
/def -willum -mglob -p1 -t"Mayflower, Explorer and Trailblazer exclaims 'Follow me for Ocean Transport!'" illum_mayflower_timed_follow = \
  /if ({leader} =~ "Self") /repeat -0:0:04 1 /send follow mayflower%;/endif

/def -willum -mglob -p1 -t"Mayflower, Explorer and Trailblazer says 'All aboard! Last call for Ocean Transport! If you aren't coming, go back to the geyser.'" illum_mayflower_setup = \
  /send cast invis%;\
  /if ({leader} =~ "Self") /send west=fol self=linkrefresh group%;/endif

;; Load in the variables saved from previous state.
/loadCharacterState illum
