;;; ----------------------------------------------------------------------------
;;; shubie.ava.tf
;;; Specific variables/macroes for shubie
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; Gear stuff
;;; ----------------------------------------------------------------------------
/load -q char/shubie.gear.ava.tf

/alias aoe \
  /aoe %{1}%;\
  /set shubie_auto_cast 1%;\
  /if ({auto_aoe} == 1) /send wear light=gt aoe%;\
  /else /send wear fire=gt noaoe%;\
  /endif

/def -wshubie -au -p9 -F -mglob -t'Your force shield shimmers then fades away.' shubie_focidrop = \
  /if ({running} == 1) /send racial fly%;/endif

/test shubieMidSpell := (shubieMidSpell | 'disintegrate')
/test shubieAOESpell := (shubieAOESpell | 'acid rain')
/def shubiemidround = /send -wshubie c %{shubieMidSpell}
/def shubieaoespell = /send -wshubie c %{shubieAOESpell}

/def -wshubie shubieSetMySpell = \
    /let newSpell=='%{*}'%;\
    /if ({newSpell} !/ {shubieMidSpell}) \
        /send a 1=a 1 c '%{*}' \%1%;\
    /endif
/def -wshubie shubieSetMyAOESpell = \
    /let newSpell=='%{*}'%;\
    /if ({newSpell} !/ {shubieAOESpell}) \
        /send a 2=a 2 c '%{*}'%;\
    /endif

/alias airgear c 'air armor'%;c 'air hammer'%;c 'air shield'%;c 'magic light'
/def -wshubie wa = stand%;/mana2ac

;;; ----------------------------------------------------------------------------
;;; shubiePromptHookCheck is called from the prompt_hook via /promptHookCheck
;;; What we want to do here is just turn off surge when Feir is < 10000 mana.
;;; ----------------------------------------------------------------------------
/set shubiePromptHookCheckToggle=1
/set shubieManaThreshold=250
/def shubiePromptHookCheck = \
    /if ({curr_mana} < {shubieManaThreshold} & {max_mana} > {shubieManaThreshold} & {shubiePromptHookCheckToggle} == 1 & {shubie_auto_cast} == 1) \
        /cast off%;\
        /echo -pw @{hCmagenta}Mana below threshold (%{shubieManaThreshold}). Turning @{hCred}OFF@{hCmagenta} surge.  Will turn toggle back on when mana is full.@{n}%;\
        /send -wshubie surge off%;\
        /set shubiePromptHookCheckToggle=0%;\
        /def full_mana_action=/set shubiePromptHookCheckToggle=1%%;/echo -pw @{hCmagenta}Surge/Mana toggle check back @{hCgreen}ON@{hCmagenta}.@{n}%;\
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
/def -wshubie -mregexp -t"^(Nit|Roku) smoothes out its clothes\." nit_smooth_to_ac = /if ({running}==1) /mana2ac%;/endif

; Swap to mana when leader does
/def -wshubie -mregexp -t"^(Nit|Roku) takes it easy and relaxes." leader_swap_to_mana = /if ({running}==1) /ac2mana%;sleep%;/endif

/def -wshubie -mglob -p1 -t"Mayflower, Explorer and Trailblazer exclaims 'Follow me for Ocean Transport!'" mayflower_timed_follow = \
    /if ({leader} =~ "Self") /repeat -0:0:04 1 /send follow mayflower%;/endif

/def -wshubie -mglob -p1 -t"Mayflower, Explorer and Trailblazer says 'All aboard! Last call for Ocean Transport! If you aren't coming, go back to the geyser.'" mayflower_setup = \
    /send vis=move=move=sneak=sneak%;\
    /if ({leader} =~ "Self") /send west=fol self=linkrefresh group=sleep%;/endif

;; AOE when Fierlo does
/def -wshubie -mglob -p5 -au -t"A black haze emanates from Fierlo!" shubie_aoe_on = /if /test $(/getvar auto_cast) == 1%;/then /aoe on%;/aq /aoe off%;/endif 

;; trigger to wear rune of life (has detect invis) back on after getting holy sight
;/def life = /auto life %1
;/def -wshubie -au -t"Teacup nods in agreement with you."=/if /test $(/getvar auto_life) == 1%;/then remove all.life%;/endif
;/def -wshubie -au -t"Your awareness improves."=/if /test $(/getvar auto_life) == 1%;/then wear all.life%;/endif


/def -wshubie runcast = /auto runcast %1
/def -wshubie -F -mregexp -t"^You start fighting " shubie_auto_runcast_toggle = /if /test $(/getvar auto_runcast) == 1%;/then /repeat -0:00:3 1 /cast on%%;/aq /cast off%;/endif

;; Load in the variables saved from previous state.
/loadCharacterState shubie

