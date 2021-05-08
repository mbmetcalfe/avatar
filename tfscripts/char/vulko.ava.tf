;;; vulko.ava.tf
;;; Specific variables/macroes for vulko

;;; read in vulko's gear file
/load -q char/vulko.gear.ava.tf
/require healer.tf

;;; ----------------------------------------------------------------------------
;;; Autohealing setup
;;; ----------------------------------------------------------------------------
/set comfGain=955
/set divGain=262
/set healGain=131
/set cureCriticalGain=67
/set cureSeriousGain=45
/set cureLightGain=26

/test vulkoMidSpell := (vulkoMidSpell | 'phlebotomize')
/test vulkoAOESpell := (vulkoAOESpell | 'pillar of flame')
/def vulkomidround = /send -wvulko c %{vulkoMidSpell}
/def vulkoaoespell = /send -wvulko c %{vulkoAOESpell}

/alias fin c 'final rites' %1
; Heroic aliases
/alias sang \
    /if ({#} = 1) augment %1%;/endif%;\
    c 'sanguen pax' pool%;\
    /if ({#} = 1) augment off%;/endif
/alias nova \
    /if ({#} = 1) surge %1%;/endif%;\
    c 'blood nova' pool%;\
    /if ({#} = 1) surge off%;/endif

/alias fins \
    c 'final rite' %1%;\
    /aq sang %2

; Lordly aliases
/alias vit \
    /if ({#} = 1) augment %1%;/endif%;\
    c 'vitae flux' pool%;\
    /if ({#} = 1) augment off%;/endif

/def -mglob -p5 -t"You need to target approriate bloody remains!" vulko_target_another_pool = /echo -pw @{hCwhite}THERE IS A POOL HERE. TRY: c 'vitae flux' 2.pool

/alias fine \
    c 'final rite' %1%;\
    /aq vit %2
/alias fines \
    fine %1 %2%;\
    /send stance soul=c 'soul shackle' %1
/alias shack /send stance soul=c 'soul shackle' %1
/alias vgo /cast on%;/aq /cast off%;/send =

/alias mm /if ({#} > 1 | {1} > 0) surge %1%;/endif%;c 'memento mori' pool%;/if ({#} > 1 | {1} > 0) surge off%;/endif

; /finalrites - automatically cast final rites when starting a fight.
; /sang       - automatically cast sanguen pax when a mob dies or if you see a pool in the room
; /phleb      - when mob is pretty hurt|awful start auto casting (alias 1 server-side)
;               turn off auto-cast when mob dies
; /shack      - when mob is at big nasty wounds go into shackle stance and cast shackle.
; /runheal    - Toggle /finalrites, /sang, and /phleb all at once.
/def finalrites = /auto finalrites %1
/def sang = /auto sang %1
/def phleb = /auto phleb %1
/def shack = /auto shackle %1
/def -wvulko runheal = /finalrites %1%;/sang %1%;/phleb %1%;/shack %1%;/assist

/alias shack /send stance soul=c 'soul shackle' %1

/def -wvulko -F -mregexp -t"^You start fighting " vulko_auto_finalrites=\
  /if /test $(/getvar auto_finalrites) == 1%;/then /send cast 'final rites'%;/endif

/set viz_pool_spell=vitae flux
;/def -wvulko -mglob -p200 -ah -t"*has been marked with final rites." vulko_auto_sanguen = \
;  /if /test $(/getvar auto_sang) == 1%;/then /aq c '%{viz_pool_spell}' pool%;/endif
/def -wvulko -mglob -p200 -ah -t"There is a sickly red glow as a blood pool congeals!" vulko_auto_sanguen = \
  /if /test $(/getvar auto_sang) == 1%;/then c '%{viz_pool_spell}' pool%;/endif

/def -wvulko -mregexp -ahCred -t"\([ 0-9]+\) \(Magical\) An eerie pool of blood has formed here\!$" vulko_auto_multi_sang_pool = \
    /if /test $(/getvar auto_sang) == 1%;/then /for i 1 %{P1} c '%{viz_pool_spell}' pool%;/endif
/def -wvulko -mregexp -ahCred -t"An eerie pool of blood has formed here\!$" vulko_auto_sang_pool = \
  /if /test $(/getvar auto_sang) == 1%;/then c '%{viz_pool_spell}' pool%;/endif
/def -wvulko -F -mregexp -p999 -aCmagenta -t"has some big nasty wounds and scratches" vulko_shackle_start = \
  /if /test $(/getvar auto_shackle) == 1%;/then /send stance soul=c 'soul shackle'%;/shack off%;/aq /shack on%;/endif
;/def -wvulko -F -mregexp -p999 -auCmagenta -t" has been soul shackled!" vulko_soul_stance_start = \
;  /if /test $(/getvar auto_shackle) == 1%;/then /send stance soul%;/endif

/def -wvulko -F -mregexp -p999 -aCred -t"(looks pretty hurt|in awful condition)" vulko_auto_phleb = \
  /if ({running} == 1 & {vulko_auto_cast} == 0 & {vulko_auto_phleb} == 1)\
    /cast on%;/aq /cast off%;/send =%;\
  /endif

  
/def -mglob -p1 -ag -wvulko -t"Punch whom?" autoheal_toggle = \
    /if ({autoheal}=1) /set healToggle=1%;\
    /else /echo -pw @{Cgreen}Punch whom?@{n}%;/endif

;;; ----------------------------------------------------------------------------
;;; scripts to bipass migraine effects if stuff is stacked
/def -wvulko -p900 -mregexp -ahCwhite -t"^You feel a slight headache growing stronger..." migraine_disconnect_vulko = \
    /if ({running}==1) c 'water breath'%;/endif

;; Load in the variables saved from previous state.
/loadCharacterState vulko
