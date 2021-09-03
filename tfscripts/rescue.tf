;;; ----------------------------------------------------------------------------
;;; rescue.tf
;;; Macroes/triggers for rescueing
;;; /clrres -- Clear rescue list.
;;; /rmres char -- remove "char" from rescue list.
;;; /addres char -- add "char" to rescue list
;;; /showres [channel] -- echo rescue list to [channel] if blank /echo.
;;; /lresc -- show s list of defined macroes for people to be rescued.
;;; ----------------------------------------------------------------------------

/def -wdhaatu -p99 -au -mregexp -t"^([a-zA-Z]+) pokes you in the ribs\.$" poke_resc = \
    /if /test $(/getvar auto_rescue) == 1%;/then resc %{P1}%;/endif

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

;;; ----------------------------------------------------------------------------
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
    /let resclist=$(/unique $[tolower(strcat({resclist}," ",{*}))])%;\
    /let resclen=$[strlen(resclist)]%;\
    /let resclist=$[substr(resclist, 0, $[resclen-1])]%;\
    /set %{this}_resclist=%resclist%;\
    /let resclist=$[replace(" ","|",%resclist)]%;\
    /echo -p @{Ccyan}%{this} Rescuing: @{Cwhite}%resclist@{n}%;\
    /def -w%{this} -mregexp -p7 -F -t"attack(s?) (strike|strikes|haven't hurt) ((?i)%resclist)" %{this}resc = /eval resc %%P3%%;/edit -c0 %{this}resc%%;/repeat -00:00:01 1 /edit -c100 %{this}resc%;\
    /def -w%{this} -mregexp -p7 -F -t" (turns to shoot|stands up and faces) ((?i)%resclist)" %{this}resc1 = /eval resc %%P2%;\
    /def -w%{this} -mregexp -p7 -F -t"((?i)%resclist)'s (backstab|pierce)" %{this}resc2 = /eval resc %%P1%;\
    /def -w%{this} -mregexp -p7 -F -t"((?i)%resclist) successfully rescues you from .*!" %{this}resc3 = /rmres -w%{this} %%P1

;/if /test ((%{this}_cast == 1) & ({currentPosition} =~ "fight") & ({mudLag} == 0) & (%{this}_auto_cast == 1))%;/then /castdmg%;/set %{this}_cast 2%;/endif
/def autores = \
    /auto rescue %1%;\
    /let this=$[world_info()]%;\
    /if /test (%{this}_auto_rescue == 0)%;/then \
        /edit -c0 %{this}resc%;\
        /edit -c0 %{this}resc1%;\
        /edit -c0 %{this}resc2%;\
        /edit -c0 %{this}resc3%;\
    /else \
        /edit -c100 %{this}resc%;\
        /edit -c100 %{this}resc1%;\
        /edit -c100 %{this}resc2%;\
        /edit -c100 %{this}resc3%;\
    /endif%;\
    /statusflagcolour $(/getvar auto_rescue) hCyellow AR
 
/def rmres = \
    /if (!getopts("w:", "a")) /let this=$[world_info()]%;/endif%;\
    /if /test opt_w =~ 'a'%;/then%;/let this=$[world_info()]%;\
    /else /let this=%{opt_w}%;\
    /endif%;\
    /let hlv=%{this}_resclist%;\
    /let resclist=$[expr(%hlv)]%;\
    /let pres=$[tolower(strip_attr(%{1}))]%;\
    /let resclist=$(/remove %{pres} %resclist)%;\
    /set %{this}_resclist=%resclist%;\
; call /addres with no arguments to adjust triggers
    /addres

/def clrres = \
    /let this=$[world_info()]%;\
    /if /ismacro %{this}resc %; /then /undef %{this}resc%;/undef %{this}resc1%;/undef %{this}resc2%;/undef %{this}resc3%;/endif%;\
    /set %{this}_resclist=%;\
;    /unset %{this}_resclist%;\
    /echo -p @{Ccyan}%{this} rescuing none.@{n}

; Add the whole group
/def grres = /clrres%;/addres %{grouplist}%;/rmres $[world_info()]
