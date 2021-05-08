;;; ----------------------------------------------------------------------------
;;; matanca.ava.tf
;;; Specific variables/macroes for matanca
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; Gear stuff
;;; ----------------------------------------------------------------------------
/load -q char/matanca.gear.ava.tf

/alias aoe \
  /aoe %{1}%;\
  /set matanca_auto_cast 1%;\
  /if ({auto_aoe} == 1) /send wear light=gt aoe%;\
  /else /send wear fire=gt noaoe%;\
  /endif

/def -wmatanca -au -p9 -F -mglob -t'Your force shield shimmers then fades away.' matanca_focidrop = \
  /if ({running} == 1) /send racial fly%;/endif

/test matancaMidSpell := (matancaMidSpell | 'disintegrate')
/test matancaAOESpell := (matancaAOESpell | 'acid rain')
/def matancamidround = /send -wmatanca c %{matancaMidSpell}
/def matancaaoespell = /send -wmatanca c %{matancaAOESpell}

/def -wmatanca matancaSetMySpell = \
    /let newSpell=='%{*}'%;\
    /if ({newSpell} !/ {matancaMidSpell}) \
        /send a 1=a 1 c '%{*}' \%1%;\
    /endif
/def -wmatanca matancaSetMyAOESpell = \
    /let newSpell=='%{*}'%;\
    /if ({newSpell} !/ {matancaAOESpell}) \
        /send a 2=a 2 c '%{*}'%;\
    /endif

/alias airgear c 'air armor'%;c 'air hammer'%;c 'air shield'%;c 'magic light'
/def -wmatanca wa = stand%;/mana2ac

;;; ----------------------------------------------------------------------------
;;; matancaPromptHookCheck is called from the prompt_hook via /promptHookCheck
;;; What we want to do here is just turn off surge when Feir is < 10000 mana.
;;; ----------------------------------------------------------------------------
/set matancaPromptHookCheckToggle=1
/set matancaManaThreshold=250
/def matancaPromptHookCheck = \
    /if ({curr_mana} < {matancaManaThreshold} & {max_mana} > {matancaManaThreshold} & {matancaPromptHookCheckToggle} == 1 & {matanca_auto_cast} == 1) \
        /cast off%;\
        /echo -pw @{hCmagenta}Mana below threshold (%{matancaManaThreshold}). Turning @{hCred}OFF@{hCmagenta} surge.  Will turn toggle back on when mana is full.@{n}%;\
        /send -wmatanca surge off%;\
        /set matancaPromptHookCheckToggle=0%;\
        /def full_mana_action=/set matancaPromptHookCheckToggle=1%%;/echo -pw @{hCmagenta}Surge/Mana toggle check back @{hCgreen}ON@{hCmagenta}.@{n}%;\
        /runcast off%;\
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

; Temp trigger to swap to ac when leader does
/def -wmatanca -mregexp -t"^(Nit|Roku) smoothes out its clothes\." nit_smooth_to_ac = /if ({running}==1) /mana2ac%;/endif

; Swap to mana when leader does
/def -wmatanca -mregexp -t"^(Nit|Roku) takes it easy and relaxes." leader_swap_to_mana = /if ({running}==1) /ac2mana%;sleep%;/endif

/def -wmatanca -mglob -p1 -t"Mayflower, Explorer and Trailblazer exclaims 'Follow me for Ocean Transport!'" mayflower_timed_follow = \
    /if ({leader} =~ "Self") /repeat -0:0:04 1 /send follow mayflower%;/endif

/def -wmatanca -mglob -p1 -t"Mayflower, Explorer and Trailblazer says 'All aboard! Last call for Ocean Transport! If you aren't coming, go back to the geyser.'" mayflower_setup = \
    /send vis=move=move=sneak=sneak%;\
    /if ({leader} =~ "Self") /send west=fol self=linkrefresh group=sleep%;/endif

;; AOE when Fierlo does
/def -wmatanca -mglob -p5 -au -t"A black haze emanates from Fierlo!" matanca_aoe_on = /if /test $(/getvar auto_cast) == 1%;/then /aoe on%;/aq /aoe off%;/endif 

;; trigger to wear rune of life (has detect invis) back on after getting holy sight
;/def life = /auto life %1
;/def -wmatanca -au -t"Teacup nods in agreement with you."=/if /test $(/getvar auto_life) == 1%;/then remove all.life%;/endif
;/def -wmatanca -au -t"Your awareness improves."=/if /test $(/getvar auto_life) == 1%;/then wear all.life%;/endif


/def -wmatanca runcast = /auto runcast %1
/def -wmatanca -F -mregexp -t"^You start fighting " matanca_auto_runcast_toggle = /if /test $(/getvar auto_runcast) == 1%;/then /repeat -0:00:3 1 /cast on%%;/aq /cast off%;/endif

;; Load in the variables saved from previous state.
/loadCharacterState matanca

