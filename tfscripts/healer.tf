;; File: healer.tf
;; File used for macroes/triggers useful for healer-type characters
/loaded __TFSCRIPTS__/healer.tf

/set healerlist=Cleric Druid Paladin Priest

;; spell queue spell to give.
/set my_spell=invincibility

/alias hos c 'holy sight' %*
/alias invinc c invinc %1

;;; ----------------------------------------------------------------------------
;; Autohealing defaults
;;; ----------------------------------------------------------------------------
;; To toggle automatic healing you need to add a personal triger for "hop self":
;/def -mglob -p1 -ag -wgengis -t"Wow, that takes talent." autoheal_toggle = \
;    /if ({autoheal}=1) /set healToggle=1%;/endif

/set divGain=200
/set healGain=100
/set cureLightGain=25
/def hgains = \
    /echo -pw %%% Healing Gains: @{Cwhite}Comf: @{Cgreen}%{comfGain} @{Cwhite}Div: @{Cgreen}%{divGain} @{Cwhite}Heal: @{Cgreen}%{healGain} \
                  @{Cwhite}CC: @{Cgreen}%{cureCriticalGain} @{Cwhite}CS: @{Cgreen}%{cureSeriousGain} \
                  @{Cwhite}CL: @{CGreen}%{cureLightGain}@{n}. 

;;; ----------------------------------------------------------------------------
;;; healing aliases
;;; ----------------------------------------------------------------------------
/alias comf \
    /if ({#} > 1 | {1} > 0) \
        /let _augment=1%;\
        augment %1%;\
        /shift%;\
    /endif%;\
    c comfort %1%;\
    /if ({_augment} = 1) augment off%;/endif
/alias div \
    /if ({#} > 1 | {1} > 0) \
        /let _augment=1%;\
        augment %1%;\
        /shift%;\
    /endif%;\
    c divinity %1%;\
    /if ({_augment} = 1) augment off%;/endif
/alias he \
    /if ({#} > 1 | {1} > 0) \
        /let _augment=1%;\
        augment %1%;\
        /shift%;\
    /endif%;\
    c heal %1%;\
    /if ({_augment} = 1) augment off%;/endif
/alias cc \
    /if ({#} > 1 | {1} > 0) \
        /let _augment=1%;\
        augment %1%;\
        /shift%;\
    /endif%;\
    c 'cure crit' %1%;\
    /if ({_augment} = 1) augment off%;/endif
/alias cl \
    /if ({#} > 1 | {1} > 0) \
        /let _augment=1%;\
        augment %1%;\
        /shift%;\
    /endif%;\
    c 'cure light' %1%;\
    /if ({_augment} = 1) augment off%;/endif

/alias invig \
    /if ({#} > 1 | {1} > 0) \
        /let _augment=1%;\
        augment %1%;\
        /shift%;\
    /endif%;\
    c invigorate %1%;\
    /if ({_augment} = 1) augment off%;/endif

/alias rejuv \
    /if ({#} > 1 | {1} > 0) \
        /let _augment=1%;\
        augment %1%;\
        /shift%;\
    /endif%;\
    c rejuvenate %1%;\
    /if ({_augment} = 1) augment off%;/endif

;;; ----------------------------------------------------------------------------
;;; curing aliases
;;; ----------------------------------------------------------------------------
/alias cb \
    /if ({#} > 1 | {1} > 0) \
        /let _quicken=1%;\
        quicken %1%;\
        /shift%;\
    /endif%;\
    c 'cure blindness' %1%;\
    /if ({_quicken} = 1) quicken off%;/endif

/alias cd \
    /if ({#} > 1 | {1} > 0) \
        /let _quicken=1%;\
        quicken %1%;\
        /shift%;\
    /endif%;\
    c 'cure disease' %1%;\
    /if ({_quicken} = 1) quicken off%;/endif

/alias cp \
    /if ({#} > 1 | {1} > 0) \
        /let _quicken=1%;\
        quicken %1%;\
        /shift%;\
    /endif%;\
    c 'cure poison' %1%;\
    /if ({_quicken} = 1) quicken off%;/endif

;;; ----------------------------------------------------------------------------
;;; Cleric Aura Handling.
;;; ----------------------------------------------------------------------------
/def refreshAura = \
    /if ({#} > 0) \
        /setMyClericAura %{*}%;\
    /endif%;\
    /toggle refreshAura%;\
    /let _aura=$(/listvar -v %{myname}ClericAuraSpell)%;\
    /eval /echoflag %refreshAura Refresh-Aura (%{_aura})@{n}
/def setMyClericAura = /set %{myname}ClericAuraSpell='%{*}'

/def -p99 -mglob -t"An artificer blessing surrounds yourself and your allies!" aura_artificer_up = \
    /set artificerblessingleft=999
/def -mglob -t"Your artificer blessing is no more." aura_artificer_drop = \
    /set artificerblessingleft=-1%;\
    /set ticktoggle=1%;\
    /if ({drone} == 1) \
        /send stand=c 'artificer blessing'=sleep%;\
    /elseif ({refreshAura} == 1) \
        /test refreshSpell(%{myname}ClericAuraSpell)%;\
    /endif

/def -mglob -aCwhite -p99 -F -t'You blaze with an aura of glory.' aura_glorious_conquest_up = \
    /set gloriousconquestleft=999
/def -mglob -aCwhite -p99 -F -t'An emptiness replaces your feeling of glory.' aura_glorious_conquest_down = \
    /set gloriousconquestleft=-1%;\
    /set ticktoggle=1%;\
    /if ({refreshAura} == 1) \
        /test refreshSpell(%{myname}ClericAuraSpell)%;\
    /endif

;A hallowed nimbus envelops you.
/def -mglob -aCwhite -p99 -F -t'A hallowed nimbus surrounds yourself and your allies!' aura_hallowed_nimbus_up = \
    /set hallowednimbusleft=999
;The hallowed nimbus flickers and fades away.
;Your hallowed nimbus is no more.
;The hallowed nimbus disappears.
/def -mglob -aCwhite -p99 -F -t'Your hallowed nimbus is no more.' aura_hallowed_nimbus_down = \
    /set hallowednimbusleft=-1%;\
    /set ticktoggle=1%;\
    /if ({refreshAura} == 1) \
        /test refreshSpell(%{myname}ClericAuraSpell)%;\
    /endif

;Kra surrounds you with a grim blessing. Let the harvest commence!
;cast 'grim harvest' activate
;Your grim blessing is unleashed!
;The grim aura disappears.
/def -mglob -aCwhite -p99 -F -t'surrounds you with a grim blessing. Let the harvest commence!' aura_grim_harvest_up = \
    /set grimharvestleft=999
;Kra surrounds you with a grim blessing. Let the harvest commence!
/def -mglob -aCwhite -p99 -F -t'The grim aura disappears.' aura_grim_harvest_down = \
    /set grimharvestleft=-1%;\
    /set ticktoggle=1%;\
    /if ({refreshAura} == 1) \
        /test refreshSpell(%{myname}ClericAuraSpell)%;\
    /endif


;Kra surrounds you with a malevolent blessing.

;;; ----------------------------------------------------------------------------
;;; Vizier Final Rites Handling
;;; ----------------------------------------------------------------------------
/def -mregexp -ahCwhite -p99 -t'has been marked with final rites\.$' final_rites_up 

;;; Lord auto-healing macros
;; /addheal name   Add name to heal list
;; /rmheal name    Remove name from heal list
;; /noheal         Remove everyone from heal list
;; /checkheal      Look at current world heal list and ask db who you need to comfort (or mass comf)
;;                 Should have in game alias of 'pc' for "c 'mass comfort'" or "preach comfort"
/def addheal=\
 /let this=$[world_info()]%;\
 /if (!getopts("w:", "a")) /let this=$[world_info()]%;/endif%;\
 /if /test opt_w =~ 'a'%;/then%;\
  /let this=$[world_info()]%;\
 /else \
   /let this=%opt_w%;\
 /endif%;\
 /let hlv=%{this}_heallist%;\
 /let heallist=$[expr(%hlv)]%;\
 /let heallist=$(/unique $[tolower(strcat({heallist}," ",{*}))])%;\
 /set %{this}_heallist=%heallist%;\
 /echo %{this} healing: %heallist

/def rmheal=\
 /let this=$[world_info()]%;\
 /if (!getopts("w:", "a")) /let this=$[world_info()]%;/endif%;\
 /if /test opt_w =~ 'a'%;/then%;\
  /let this=$[world_info()]%;\
 /else \
   /let this=%opt_w%;\
 /endif%;\
 /let hlv=%{this}_heallist%;\
 /let heallist=$[expr(%hlv)]%;\
 /echo %heallist%;\
 /let heallist=$(/remove %{1} %heallist)%;\
 /set %{this}_heallist=%heallist%;\
 /echo %{this} healing: %heallist

/def noheal = \
 /let this=$[world_info()]%;\
 /if (!getopts("w:", "a")) /let this=$[world_info()]%;/endif%;\
 /if /test opt_w =~ 'a'%;/then%;\
  /let this=$[world_info()]%;\
 /else \
   /let this=%opt_w%;\
 /endif%;\
 /set %{this}_heallist=%;\
 /echo -p @{Ccyan}%{this} healing none.@{n}

;; queries db for who to heal, only useful for lord really since the server sends back comforts
;; heals people in the list who are down more than 800 hps. does not augment.
/def checkheal=\
  /let this $[world_info()]%;\
 /if (!getopts("w:", "a")) /let this=$[world_info()]%;/endif%;\
 /if /test opt_w =~ 'a'%;/then%;\
  /let this=$[world_info()]%;\
 /else \
   /let this=%opt_w%;\
 /endif%;\
  /let htv %{this}_heallist%;\
  /let heallist=$[expr(htv)]%;\
  /let heallist=$[replace(" ","|",%heallist)]%;\
  /let heallen=$[strlen(heallist)]%;\
  /let heallist=$[substr(heallist, 0, $[heallen-1])]%;\
  /sendlocal heal:%{this}|%{heallist}

/def showheal = \
  /let this=$[world_info()]%;\
  /let htv %{this}_heallist%;\
  /let heallist=$[expr(htv)]%;\
  /let heallist=$[replace(" ","|",%heallist)]%;\
  /let heallen=$[strlen(heallist)]%;\
  /let heallist=$[substr(heallist, 0, $[heallen-1])]%;\
  /echo -p @{Ccyan}%{this} Healing: @{Cwhite}%heallist@{n}

;; trigger for the 'local' world that executes commands returned from the server
/def -wlocal -mregexp -t"^/echo(.*)$"=/echo %P1
/def -wlocal -mregexp -t"^([a-z]*):(.*)$"=/send -w%P1 %P2%;/echo -w%P1 %P2

