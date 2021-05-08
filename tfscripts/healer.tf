;; File: healer.tf
;; File used for macroes/triggers useful for healer-type characters
/loaded __TFSCRIPTS__/healer.tf

/set healerlist=Cleric Druid Paladin Priest Vizier

;; spell queue spell to give.
/set my_spell=invincibility

/alias hos c 'holy sight' %*
/alias invinc c invinc %1
; Alias to get/recite a scroll -- it doesn't discriminate on what scroll it pulls from loot bag.
/alias scr get scroll %{main_bag}%;recite scroll %1
/alias zap get %1 %{main_bag}%;wear %1%;/send zap %2%;wear %unbrandish%;put %1 %{main_bag}

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
/alias hii c 'heal ii' %1
/alias mcc c 'mass cure crit'
/alias mdiv c 'mass divinity'
/alias mhe c 'mass heal'

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
/alias cs \
    /if ({#} > 1 | {1} > 0) \
        /let _augment=1%;\
        augment %1%;\
        /shift%;\
    /endif%;\
    c 'cure serious' %1%;\
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
    /if ({myclass} =~ "prs") c clarify %1%;\
    /else c 'cure blindness' %1%;\
    /endif%;\
    /if ({_quicken} = 1) quicken off%;/endif

/alias cd \
    /if ({#} > 1 | {1} > 0) \
        /let _quicken=1%;\
        quicken %1%;\
        /shift%;\
    /endif%;\
    /if (regmatch({myclass}, "mon shf")) c medicine %1%;\
    /elseif ({myclass} =~ "prs") c panacea %1%;\
    /else c 'cure disease' %1%;\
    /endif%;\
    /if ({_quicken} = 1) quicken off%;/endif

/alias cp \
    /if ({#} > 1 | {1} > 0) \
        /let _quicken=1%;\
        quicken %1%;\
        /shift%;\
    /endif%;\
    /if (regmatch({myclass},"rip sor")) c 'cell adjustment' %1%;\
    /elseif (regmatch({myclass}, "mon shf")) c medicine %1%;\
    /elseif ({myclass} =~ "prs") c panacea %1%;\
    /else c 'cure poison' %1%;\
    /endif%;\
    /if ({_quicken} = 1) quicken off%;/endif

;;; --
;;; Priest specific stuff
;;;
/alias p /send preach %*
/alias pt c 'pure touch' %*
/alias cla c clarify %*
/alias pan c panacea %*
/alias pcc preach cure critical
/alias phe preach heal
/alias pdiv preach div
/alias pto preach pure touch
/alias pinn preach innocence
/alias inno /if ({myclass} =~ "prs") c innocence %{*}%;/else /send innocence *{*}%;/endif
/alias psanc /send quicken 9=c innocence=quicken off=preach sanc

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
/def -mglob -aCwhite -p99 -F -t'Your grim harvest comes to an end.' aura_grim_harvest_down = \
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

; triggers to check healing need every 15 seconds
; when running the prs, turn on with /healbot, then start with a gt with no message:
; /healbot
; gt
;
; after we see the "Leader's group:" line, wait a second and then run /checkheal, which checks db for who to heal
/def healbot = \
  /auto healbot %1%;\
  /let this=$[world_info()]%;\
  /let auto_tr_v %{this}_auto_healbot%;\
  /let auto_tr $[expr({auto_tr_v})]%;\
  /statusflag %{auto_tr} aHeal

/def -i rpt_heal_proc = /send-gmcp char.group.list%;/send -w%{1} gt
/def -F -mregexp -t"^([A-Za-z]*)'s group:" heal_bot_grouplist =\
  /let this=$[world_info()]%;\
  /if /test %{this}_auto_healbot == 1%;/then /repeat -w%{this} -00:00:01 1 /checkheal%;/endif
/def -F -mregexp -t"^Tell your group what?" heal_bot_tell_group=\
  /let this=$[world_info()]%;\
;  /if /test %{this}_auto_healbot == 1%;/then /repeat -w%{this} -00:00:15 1 /rpt_heal_proc %{this}%;/endif
  /if /test %{this}_auto_healbot == 1%;/then /repeat -w%{this} -00:00:15 1 /send -w%{this} gt=gr%;/endif

;; trigger for the 'local' world that executes commands returned from the server
/def -wlocal -mregexp -t"^/echo(.*)$" local_echo =/echo %P1
/def -wlocal -mregexp -t"^([a-z]*):(.*)$" local_execute=/send -w%P1 %P2%;/echo -w%P1 %P2

;
;; intervention self                                                                                                   
/def intervention = /auto intervention %1
/def -mregexp -t"^You are no longer due divine intervention\.$" intervention_down =\
    /if /test $(/getvar auto_intervention) == 1%;/then /if ({refreshmisc}=1) c intervention%;/endif%;/endif

;; Attempt to save someone who gets kathunk'ed
/def -ah -mregexp -t"^[a-zA-Z\ \,\.\- ]+\'s tail brutally cripples ([a-zA-Z]+)\!  They stagger\." other_kathunk
