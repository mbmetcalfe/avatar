;;; ----------------------------------------------------------------------------
;;; rescue.tf
;;; Macroes/triggers for rescueing
;;; /clrres -- Clear rescue list.
;;; /rmres char -- remove "char" from rescue list.
;;; /addres char -- add "char" to rescue list
;;; /showres [channel] -- echo rescue list to [channel] if blank /echo.
;;; /lresc -- show s list of defined macroes for people to be rescued.
;;; ----------------------------------------------------------------------------

/def clrresOld = /maplist /rmres %rescueList%;/unset rescueList

/def rmresOld = \
    /if /ismacro resc_stab_trig_%1 %; /then \
        /echo -p %%% @{Ccyan}Removing @{Cwhite}%1 @{Ccyan}from stabber rescue list.%; \
        /set rescueList=$(/remove %{1} %{rescueList})%; \
        /undef resc_stab_trig_%1 %; \
        /if /ismacro rescue_%1 %; /then \
            /undef rescue_%1 %; \
        /endif %; \
    /endif%;\
    /if /ismacro resc_flash_trig_%1 %; /then \
        /echo -p %%% @{Ccyan}Removing @{Cwhite}%1 @{Ccyan}from flasher rescue list.%; \
        /set rescueList=$(/remove %{1} %{rescueList})%; \
        /undef resc_flash_trig_%1 %; \
        /if /ismacro rescue_%1 %; /then \
            /undef rescue_%1 %; \
        /endif %; \
    /endif%;\
    /if /ismacro resc_trig_%1 %; /then \
        /set rescueList=$(/remove %{1} %{rescueList})%; \
        /echo -p %%% @{Ccyan}Removing @{Cwhite}%1 @{Ccyan}from rescue list.%; \
        /undef resc_trig_%1 %; \
        /undef resc_trig_2_%1 %; \
        /if /ismacro rescue_%1 %; /then \
            /undef rescue_%1 %; \
        /endif %; \
    /else \
        /echo -p %%% @{Cwhite}%1 @{Ccyan}was not in rescue list.%; \
    /endif
;A ghastly wasp turns to attack Irlihk!
/def -i addsingleres = \
    /if /!ismacro resc_trig_%1 %; /then \
        /set rescueList=%{rescueList} %{*}%; \
        /echo -p %%% @{Ccyan}Adding @{Cwhite}%1 @{Ccyan}to rescue list.%; \
        /def -mregexp -p7 -ag -F -t"^[-',A-Za-z ]+'s attack[s]* strike[s]* %1 [0-9]+ time[s]*, with [A-Za-z*]+ [a-z!.]+" resc_trig_%1 = \
            /do_rescue %1 %; \
        /def -mregexp -p7 -ag -t"^[-',A-Za-z ]+'s attack[s]* haven't hurt %1!" resc_trig_2_%1 = \
            /do_rescue %1 %; \
    /else \
        /echo -p %%% @{CWhite}%1 @{Ccyan}is already in rescue list.%; \
    /endif

/def -p1 -au -mregexp -t"^([a-zA-Z]+) pokes you in the ribs\.$" poke_resc = \
    /let resc_target=%{P1}%;\
    /if /test $(/getvar auto_rescue) == 1%;/then /send res %{resc_targe}%;/endif

/def addresOld = /while ({#}) /addsingleres %{1}%;/shift%;/done

/def -i addsinglestabres = \
    /if /!ismacro resc_stab_trig_%1 %; /then \
        /set rescueList=%{rescueList} %{*}%; \
        /echo -p %%% @{Ccyan}Adding @{Cwhite}%1 @{Ccyan}to stabber rescue list.%; \
        /def -mregexp -p7 -ag -F -t"^%1's (backstab|pierce) strikes.*!" resc_stab_trig_%1 = \
            /do_rescue %1 %; \
    /else \
        /echo -p %%% @{CWhite}%1 @{Ccyan}is already in stabber rescue list.%; \
    /endif
/def addstabres = /while ({#}) /addsinglestabres %{1}%;/shift%;/done

/def -i addsingleflashres = \
    /if /!ismacro resc_flash_trig_%1 %; /then \
        /set rescueList=%{rescueList} %{*}%;\
        /echo -p %%% @{Ccyan}Adding @{Cwhite}%1 @{Ccyan}to flashers rescue list.%; \
        /def -mregexp -p7 -F -t"^%1 emits a flash of unholy light!" resc_flash_trig_%1 = \
            /do_rescue %1%;\
    /else \
        /echo -p %%% @{CWhite}%1 @{Ccyan}is already in flashers rescue list.%; \
    /endif
/def addflashres = /while ({#}) /addsingleflashres %{1}%;/shift%;/done

;; /showres [channel] -- echo rescue list to [channel] if blank /echo.
/def showresOld = \
    /let echochan=/echo %; \
    /if ({#} > 0) /let echochan=%*%; /endif %; \
    /let rescmsg=|c|Rescue list: |w|%rescueList%; \
    /if ({echochan} =~ "/echo") \
        /let rescmsg=$[replace("|c|", "@{Ccyan}", {rescmsg})] %; \
        /let rescmsg=$[replace("|w|", "@{Cwhite}", {rescmsg})] %; \
        /echo -p %%% %rescmsg %; \
    /else \
        /eval %echochan %rescmsg %; \
    /endif

; Leaving this in here in case clear or remove doesn't work to see defined rescue trigs.
/def lresc = /list -s resc_trig_2_*

/def -i do_rescue = \
    /if /!ismacro rescue_%1 %; /then \
        /send resc %1 %; \
        /def rescue_%1 = 1 %; \
    /else \
        /echo -p %%% @{Ccyan}Still trying to rescue @{Cwhite}%1@{n} %; \
    /endif

/def -mregexp -F -p4 -t"You successfully rescue ([A-Za-z]+) from [-'A-Za-z ]+!" unresc_trig_1 = \
	/if /ismacro rescue_%{P1}%; /then /undef rescue_%{P1}%; /endif

/def -mregexp -F -p4 -t"You fail to rescue ([A-Za-z]+) from [-'A-Za-z ]+!" unresc_trig_2 = \
    /if /ismacro rescue_%{P1}%; /then /undef rescue_%{P1}%; /endif

/def -mregexp -F -p4 -t"([A-Za-z]+) doesn't NEED rescuing!" unresc_trig_3 = \
    /if /ismacro rescue_%{P1}%; /then /undef rescue_%{P1}%; /endif

/def -mregexp -F -p4 -t"[A-Za-z]+ rescues ([A-Za-z]+) from [-'A-Za-z ]+." unresc_trig_4 = \
    /if /ismacro rescue_%{P2}%; /then /undef rescue_%{P2}%; /endif

;todo: fix
/def -mregexp -F -p9 -t"([a-zA-Z]+) successfully rescues you from .*" unresc_trig_5 = \
    /if /ismacro resc_trig_%{P1}%; /then /rmres %{P1}%; /endif

/def -mregexp -F -p4 -t"([A-Za-z]+) doesn't need your help\." unresc_trig_6 = \
    /if /ismacro rescue_%{P1}%; /then /undef rescue_%{P1}%; /endif

;; -- if changes in damage-new.tf work, this triggers are no longer required
;; /undef autores1
;; /undef autores2
/def -p0 -ag -mregexp -F -t'(\'s attac.* strikes?) ([a-z|A-Z|0-9| |-]*) ([0-9]*) (time|times), with (.*) ([a-zA-Z]*)(\.|\!)$' autores1 = \
    /let T1=%PL%P1 %; \
    /let T2=%P2%; \
    /let T3=%P3%; \
    /let T4=%P4%; \
    /let T5=%P5%; \
    /let T6=%P6%; \
    /let T7=%P7%; \
    /let resctemp=<%P2< %; \
    /if ({P2} =~ "you")  \
        /echo -p @{hCred}%T1 %T2 %T3 %T4, with %T5 %{T6}%{T7}@{n} %; \
    /elseif ( regmatch(tolower({resctemp}),{groupies}) ) \
        /echo -p @{Cyellow}%T1 @{hCblue}%T2 @{nCyellow}%T3 %T4, with %T5 %{T6}%{T7}@{n} %; \
    /else \
        /echootherdam @{Cyellow}%T1 %T2 %T3 %T4, with @{nCgreen}%T5 @{Cyellow}%{T6}%{T7}@{n} %; \
    /endif

/def -p0 -ag -mregexp -F -t'(\'s attac.* have.* hurt) ([a-z|A-Z]*)!$' autores2 = \
    /let T1=%PL%P1 %; \
    /let T2=%P2 %; \
    /let resctemp=<%P2< %; \
    /if ({T2} =~ "you")  \
        /echo -p @{hCred}%T1 %T2!@{n} %; \
    /elseif ( regmatch(tolower({resctemp}),{groupies}) ) \
        /echo -p @{Cyellow}%T1 @{hCblue}%T2@{nCyellow}!@{n} %; \
    /else \
        /echootherdam @{Cyellow}%T1 %T2! %; \
    /endif
;;; covered in damage-new.tf I think
/undef autores1
/undef autores2

;;; ----------------------------------------------------------------------------
;;; New rescue code from Ebin, works with multiple sessions
;;; Usage, case does not matter with alt names. world specific
;;; /clrres -- Clear rescue list.
;;; /rmres char -- remove "char" from rescue list.
;;; /addres char -- add "char" to rescue list
;;; ----------------------------------------------------------------------------
/def showres = \
    /let this=$[world_info()]%;\
    /let rlv=%{this}_resclist%;\
    /let resclist=$[expr(%rlv)]%;\
    /let resclen=$[strlen(resclist)]%;\
    /let resclist=$[substr(resclist, 0, $[resclen])]%;\
    /echo -p @{Ccyan}%{this} Rescuing: @{Cwhite}%resclist@{n}

/def addres = \
    /let this=$[world_info()]%;\
    /let rlv=%{this}_resclist%;\
    /let resclist=$[expr(%rlv)]%;\
    /let resclist=$(/unique $[tolower(strcat({resclist}," ",{1}))])%;\
    /let resclen=$[strlen(resclist)]%;\
    /let resclist=$[substr(resclist, 0, $[resclen-1])]%;\
    /set %{this}_resclist=%resclist%;\
    /let resclist=$[replace(" ","|",%resclist)]%;\
    /echo -p @{Ccyan}%{this} Rescuing: @{Cwhite}%resclist@{n}%;\
    /def -w%{this} -mregexp -p7 -F -t"attack(s?) (strike|strikes|haven't hurt) ((?i)%resclist)" %{this}resc = /eval resc %%P3%%;/edit -c0 %{this}resc%%;/repeat -00:00:01 1 /edit -c100 %{this}resc%;\
    /def -w%{this} -mregexp -p7 -F -t" (turns to shoot|stands up and faces) ((?i)%resclist)" %{this}resc1 = /eval resc %%P2%;\
    /def -w%{this} -mregexp -p7 -F -t"((?i)%resclist)'s pierce" %{this}resc2 = /eval resc %%P1

;/if /test ((%{this}_cast == 1) & ({currentPosition} =~ "fight") & ({mudLag} == 0) & (%{this}_auto_cast == 1))%;/then /castdmg%;/set %{this}_cast 2%;/endif
/def autores = \
    /auto rescue %1%;\
    /let this=$[world_info()]%;\
    /if /test (%{this}_auto_rescue == 0)%;/then \
        /edit -c0 %{this}resc%;\
        /edit -c0 %{this}resc1%;\
        /edit -c0 %{this}resc2%;\
    /else \
        /edit -c100 %{this}resc%;\
        /edit -c100 %{this}resc1%;\
        /edit -c100 %{this}resc2%;\
    /endif
 
/def rmres = \
    /let this=$[world_info()]%;\
    /let hlv=%{this}_resclist%;\
    /let resclist=$[expr(%hlv)]%;\
    /echo -p @{Ccyan}%resclist%;\
    /let resclist=$(/remove %{1} %resclist)%;\
    /set %{this}_resclist=%resclist%;\
    /addres

/def clrres = \
    /let this=$[world_info()]%;\
    /if /ismacro %{this}resc %; /then /undef %{this}resc%;/undef %{this}resc1%;/undef %{this}resc2%;/endif%;\
    /set %{this}_resclist=%;\
;    /unset %{this}_resclist%;\
    /echo -p @{Ccyan}%{this} rescuing none.@{n}
