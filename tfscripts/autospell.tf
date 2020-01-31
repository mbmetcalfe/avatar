;;; ----------------------------------------------------------------------------
;;; autospell.tf
;;; Auto Spell scripts
;;; ----------------------------------------------------------------------------
/load -q settings.tf

/def drone = \
    /set droneLevel=thorngate%;\
    /if ({#}=1) /set droneLevel=$[tolower({1})]%; /endif%;\
    /toggle drone%; \
    /if ({drone}=1) \
        /send rest=where=sleep%;\
        /send config +noautomove%;\
        /echoflag %drone @{Cyellow}Drone Mode @{Cwhite}(@{Cyellow}Level: @{Cred}%{droneLevel}@{Cwhite})@{n}%;\
    /else \
        /unset droneToSend%;/unset droneSendPlane%;\
        /if /ismacro full_mana_action%; /then /undef full_mana_action%;/endif%;\
        /echoflag %drone @{Cyellow}Drone Mode@{n}%;\
        /echo -p @{Cwhite}Setting Non-@{Cyellow}Drone Mode@{Cwhite} if there is a server-side @{Cyellow}dronetitleoff @{Cwhite}alias.@{n}%;\
        /send dronetitleoff%;\
        /send config -noautomove%;\
    /endif%;\
    /statusflag %drone Drone%;\
    /droneconfig

/def mydrone = \
    /let this=$[tolower(world_info())]%;\
    /auto drone %{1}%;\
    /if /ismacro %{this}drone%; /then /%{this}drone %{1}%; /else /echo -pw @{Cred}[CHAR INFO]: @{hCred}/%{this}drone not defined.@{n}%;/endif%;\
    /let auto_tr_v %{this}_auto_drone%;\
    /let auto_tr $[expr({auto_tr_v})]%;\
    /statusflag %{auto_tr} myDrone

/def dronereset = \
    /if ({drone} = 1) \
        /unset droneToSend%;/unset droneSendPlane%;\
        /trackoff%;/relog%;\
        /if ({running}=1) /runend%;/endif%;\
        /if ({folport}=1) /fport%;/endif%;\
        /if ({autokill}=1) /assist%;/endif%;\
        /if ({autowalk}=1) /autowalk%;/endif%;\
        /if ({autopick}=1) /autopick%;/endif%;\
        /if ({autocast}=1) /acast%;/endif%;\
        /send rest=where=follow self=sleep=config -savespell%;\
        /send config -noautomove%;\
        /if ({#}=1) \
            /def -mregexp -ag -p1 -n1 -t"You tell %{1} in your dreams.*" _drone_tell_reset%;\
            /send tell %{1} Reset complete.%;\
        /else /echo -pw %%% @{Cmagenta}Drone has been reset.@{n}%;\
        /endif%;\
    /else /echo -pw %%% @{Cmagenta}Nice try, Bot triggers are not currently active.@{n}%;\
    /endif%;\
    /droneconfig

/def -wgengis gengisspells = gtell |bc|marv|W|->|c|Invincibility|w|. |bp|sworship|w|->|p|SpellUp|w|.%; \
    gtell |bg|admire|w|->|g|Aegis|w|.
/def -washa ashaspells = gtell |bc|marv|w| to be put on list for: |c|Steel Skeleton|w|.
/def -wtahn tahnspells = gtell |bc|marv|w| to be put on list for: |c|Steel Skeleton|w|.
/def -wjekyll jekyllspells = \
    gtell |bc|marv|w|->|c|Invincibility|w|. |bg|chop|w|->|g|Confidence|w|. |br|bark|w|->|r|Barkskin|w|.%; \
    gtell |bp|sworship|w|->|p|SpellUp|w|.  |by|boogie|w|->|y|Sep|r|Awen|y|SpellUp|w|.
/def -wpaxon maxinespells = gtell |bc|marv|w|->|c|Invincibility|n|. |br|bark|w|->|r|Barkskin|n|.
/def -wkaboo kaboospells = gtell |bc|marv|w| to be put on list for: |c|barkskin|w|.
/def -wbauchan bauchanspells = gtell |bc|marv|w| to be put on list for: |c|barkskin|w|.
/def -wmahal mahalspells = gtell |bc|marv|w| to be put on list for: |c|barkskin|w|.
/def -wskia skiaspells = gtell |bc|marv|w| to be put on list for: |c|Steel Skeleton|w|.

/def spells = \
    /if ({drone} = 1) \
        /if /ismacro %{myname}spells%; /then /eval /%{myname}spells%; /endif%; \
    /endif
/def tospell = /echo -p %% @{Ccyan}In the Queue to be spelled: @{hCwhite}%spellqueue@{nCcyan}.@{n}
/def clrspell = /unset spellqueue%; /echo -p %% @{Ccyan}Spell Queue cleared.@{n}
;;; F11 key is bound to spellup spell queue with spell set in "my_spell".
;;; give_spell should be set in characters file "char/charname.ava.tf"
/def -i spellqueue = /sq %my_spell
/def key_f11 = /spellqueue

;;; /sq [spell] - spellup spell queue.  If spell given, will use that spell.
;;;               Otherwise, it uses value in my_spell by default (set in
;;;               characters file "char/charname.ava.tf"
/def sq = \
    /set give_spell=%my_spell%; \
    /if ({*} !~ "") /set give_spell=%*%; /endif%; \
    /if ({spellqueue} !~ "") \
        /echo -pw %% @{Ccyan}Spelling @{hCwhite}$[replace(" ", ", ", {spellqueue})] @{nCcyan}with @{hCwhite}%give_spell@{nCcyan}.@{n}%; \
        /mapcar /myspell %spellqueue%; \
        /clrspell%; \
    /else \
        /echo -pw %% @{Ccyan}Spell is empty.@{n}%; \
    /endif%;\
    /unset give_spell
/def myspell = c %give_spell %1

/def -ahCmagenta -mregexp -t"([a-zA-Z]*) says to you, \'Ah dahling, you look MAHVELLOUS\!\'" addtospellqueue = \
    /let spellrcv=$[tolower({P1})]%; \
    /if ({drone} = 1) \
       /addspellQ %spellrcv%; \
    /endif
/def addspellQ = \
    /let toadd=$[tolower({1})]%; \
    /let t_toadd=<%toadd<%; \
    /let t_iglist=<$[replace(" ", "<", {ignore_spells_list})]<%; \
    /let t_spqueue=<$[replace(" ", "<", {spellqueue})]<%; \
    /if (regmatch({t_toadd}, {t_iglist})) \
        /echo -p %% @{Ccyan}HAHA!  HA!  No spells for @{hCwhite}%toadd@{nCcyan}!@{n}%; \
    /elseif (!regmatch({t_toadd}, {t_spqueue})) \
        /echo -p %% @{Ccyan}Adding @{hCwhite}%toadd @{nCcyan}to the Spell Queue.@{n}%; \
        /set spellqueue=%spellqueue %toadd%; \
    /else /echo -p %% @{Ccyan}Already added @{hCwhite}%toadd @{nCcyan}to the Spell Queue.@{n}%; \
    /endif
    
;;; ----------------------------------------------------------------------------
;;; Stormlord drone scripts
;;; ----------------------------------------------------------------------------
/def -mglob -wtorvald -p5 -t"The spring shower begins to break." drone_stm_spring_rain_break = \
    /if ({drone} == 1) c 'spring rain'%;/endif
/def -mglob -wtorvald -p5 -t"You do not have enough mana to cast spring rain." drone_stm_spring_rain_no_mana = \
    /if ({drone} == 1) \
        /send sleep%;\
        /def full_mana_action=stand%%;c stratum spring%%;c 'spring rain'%;\
    /endif
/def -mglob -wtorvald -p5 -t" One of your Exhaust timers has elapsed. (stratum)" drone_stm_spring_rain_stratum = \
    /if ({drone} == 1 & {currentPosition} =~ "stand") \
        /send c stratum spring%;\
    /endif

;;; ----------------------------------------------------------------------------
;;; Drone triggers via socials
;;; ----------------------------------------------------------------------------
/def -wgengis -mregexp -t"([a-zA-Z]+) admires your skill\.'" gengisaegis = \
    /if ({drone} = 1 & {running}=0) stand%;c aegis %{P1}%;sleep%;/endif

/def -mregexp -wjekyll -t"([a-zA-Z]+) screams in pain from the sunlight!" jekyll_darkembrace = \
    /if ({drone}=1) c 'dark embrace' %{P1}%; /endif

/def -wjekyll -mregexp -t"^([a-zA-Z]+) makes (his|her|its) hand flat and does a karate chop to your neck!" jekyllconfidence = \
    /if ({drone} = 1) \
        /send tell %{P1} |w|Confidence: |n| +STR that can be stacked as long as it is cast BEFORE |w|Foci|n|%;\
        stand%;c confidence %{P1}%;sleep%;\
    /endif
/def -wjekyll -mregexp -t"^([a-zA-Z]+) barks at you." jekyllbarkskin = \
    /if ({drone} = 1) stand%;c barkskin %{P1}%;sleep%;/endif
/def -wmaxine -mregexp -t"^([a-zA-Z]+) barks at you." maxinebarkskin = \
    /if ({drone} = 1) stand%;c barkskin %{P1}%;sleep%;/endif

/def -mregexp -p6 -F -t"^([a-zA-Z]+) beckons for you to follow (him|her|it)\." drone_beckon = \
    /if ({drone}=1 & {running}=0) \
        /if ({P1} !~ {leader} & {leader}!~"Self") \
            /send gtell |c|So long, |bw|%{leader}|c|.  My services are required elsewhere.|n|%;/endif%;\
        /if ({position}!~"standing") /send stand%; /endif%;\
        /send follow self=follow %{P1}%;\
        /if ({position}!~"standing" & {running}=0) /send sleep%; /endif%;\
    /endif

/def -wtahn -mregexp -t"You swat at your ear, a buzzing noise is coming from ([a-zA-Z]+)." tahnsteel = \
    /if ({drone} = 1) stand%;c 'steel skeleton' %P1%;sleep%;/endif

;;; ----------------------------------------------------------------------------
;;; Auto heal scripts
;;; /aheal [threshold] - toggles auto-healing
;;;     threshold - if monitor
;;; Triggers:
;;;    gtell heal|div|cc|sanc|touch|rejuv <target> - cast given spell on <target>
;;;    gtell heal|div|cc|touch|rejuv - cast given spell on person that sent gtell
;;; ----------------------------------------------------------------------------
;;; Autoheal toggle
/def aheal = \
    /toggle autoheal%;\
    /set healToggle=%{autoheal}%;\
    /if ({#}=1) /set healRedux=%1%;/endif%;\
    /echoflag %autoheal Auto-@{hCWhite}Healing (HP Reduction: @{hCred}%healRedux@{hCWhite})@{n}%;\
    /statusflag %autoheal Heal_%{healRedux}

/def autocure = \
    /toggle autocure%;\
    /set cureToggle=%{autocure}%;\
    /echoflag %autocure Auto-@{hCWhite}Curing@{n}%;\
    /statusflag %autocure aCure

;;; ----------------------------------------------------------------------------
;;; Drone triggers via the SAY channel
;;; ----------------------------------------------------------------------------
/def -mregexp -t"([a-zA-Z]+) says '(heal|div|cc|cl|fren[zy]*|sanc|touch|rejuv|invig)'" auto_heal_say = \
    /if ({drone} = 1 | {autoheal} = 1) \
        /if ({P2} =~ "cc") c 'cure crit' %P1 %; \
        /elseif ({P2} =~ "cl") c 'cure light' %P1 %; \
        /else c %P2 %P1 %; \
        /endif%; \
    /endif

/def -mregexp -t"([a-zA-Z]+) says '(heal|div|cc|cl|fren[zy]*|sanc|touch|rejuv|pp|por[tal]*|nex[us]*|invig) ([a-zA-Z]+)'" auto_heal_other_say = \
    /let this=$[tolower(world_info())]%;\
    /if ({drone} = 1 | {autoheal} = 1 | %{this}_auto_drone = 1) \
        /if ({P2} =~ "cc") c 'cure crit' %P3 %; \
        /elseif ({P2} =~ "cl") c 'cure light' %P3 %; \
        /elseif ({P2} =~ "pp" | {P2} =~ "por[tal]*") c portal %P3 %; \
        /elseif ({P2} =~ "nex[us]*") c nexus %P3%;\
        /else c %P2 %P3 %; \
        /endif%; \
    /endif

;;; ----------------------------------------------------------------------------
;;; Drone triggers via the GROUPTELL channel
;;; ----------------------------------------------------------------------------
/def -mregexp -t"\*?([a-zA-Z]+)\*? tells the group '(heal|div|cc|fren[zy]*|sanc|touch|invig)'" auto_heal_gt = \
    /let _commander=$[strip_attr({P1})]%;\
    /let _command=$[strip_attr({P2})]%;\
    /let this=$[tolower(world_info())]%;\
    /if /test ({drone} = 1 | {autoheal} = 1 | (%{this}_auto_drone == 1))%;/then \
        /if ({_command} =~ "cc") c 'cure crit' %_commander %; \
        /elseif ({_command} =~ "touch" & {myclass} =~ "prs") c 'pure touch' %_commander %; \
        /else c %_command %_commander %; \
        /endif %; \
    /endif

/def -mregexp -t"([\*a-zA-Z]+) tells the group '(heal|div|cc|fren[zy]*|sanc|touch|rejuv|pp|por[tal]*|nex[us]*|invig) ([0-9a-zA-Z\ \!\.]+)'" auto_heal_other_gt = \
    /let _command=$[strip_attr({P2})]%;\
    /let _commandParam=$[strip_attr({P3})]%;\
    /let this=$[tolower(world_info())]%;\
    /if /test ({drone} = 1 | {autoheal} = 1 | (%{this}_auto_drone == 1))%;/then \
        /if ({_command} =~ "cc") c 'cure crit' %_commandParam %; \
        /elseif ({_command} =~ "touch" & {myclass} =~ "prs") c 'pure touch' %_commandParam %; \
        /elseif ({_command} =~ "pp" | {_command} =~ "por[tal]*") c portal %_commandParam%;/send nod%;\
        /elseif ({_command} =~ "nex[us]*") c nexus %_commandParam%;/send nod%;\
        /else c %_command %_commandParam %; \
        /endif%; \
    /endif

/def -wgengis -mregexp -t"\*?([a-zA-Z]+)\*? tells the group 'preach ?(up|all|sanc|frenzy|div|aegis|foci|fort[itudes]*|bless|invig|dark embrace|iron skin|holy aura|holy armor|armor|fly|water breath|water|invinc|holy sight|comf|clarify|absolve|panacea)([1-5]?)'" drone_priest_preach_grouptells = \
    /let _commander=$[strip_attr({P1})]%;\
    /let _command=$[strip_attr({P2})]%;\
    /let _commandParam=$[strip_attr({P3})]%;\
    /if ({drone} = 1 & {_commander} =~ {leader} & {running}=0) \
        /send stand%;\
        /if ({_command} =~ "all" | {_command} =~ "up") \
            /send gtell |bw|%{leader}|c| has requested the group get spells.|n|%;\
            /gsup%;\
            /send gtell |c|Ok. There you go.  If you weren't ready, blame |bw|%{leader}|c|.|n|=follow self%;\
        /else \
            /if ({_commandParam} > 0 & {_commandParam} < 6) /send augment %_commandParam%; /endif%;\
            /send gtell And, |bw|%{leader} |n|came forth and they said, grant them "|g|%{_command}|n|"!!%;\
            preach %{_command}%;\
            /if ({_commandParam} > 0 & {_commandParam} < 6) /send augment off%; /endif%;\
        /endif%;\
        /send sleep%;\
    /endif%;\
    /if ({drone} = 1 & {DBMODE} =/ "on" & {running}=0) \
;         /quote -S /echo !mysql -u %{DB_USERNAME} --password=%{DB_PASSWORD} %{DB_NAME} -s -e "insert into drone_commands (name, command) values ('%{_commander}', 'preach %{P2} %{_commandParam}')"%;\
    /endif

/def -i myundef = /while ({#}) /if /ismacro %1%;/then /undef %1%;/endif%;/shift%;/done

;;; ----------------------------------------------------------------------------
;;; Drone triggers via the TELLS
;;; ----------------------------------------------------------------------------
/def -mregexp -ag -p1 -t"You tell [a-zA-Z]+ in your dreams 'I would like to help you with that, but I cannot seem to find you." drone_gag_not_here_tell

/def -mregexp -ag -p1 -t"([a-zA-Z]+) tells you '([fF][uU][lL][lL]|spells|splitspells|split|[sS]anc|fren[zy]*|div|help|commands|light|sleep|repmana|report|status|decurse|rc|cp|cd|cb|cure ?poison|cure ?disease|cure ?blind|awen|foci|fort[itudes]*|sepawen|bless|invig|bark|conf[idence]*|dark[ embrace]*|iron skin|holy aura|holy armor|holy sight|hos|hs|armor|fly|water breath|water|invinc|holy sight|reset|home|thorn|mid|shrine|comf|art[ificer]*)([2-5]?)'" drone_midgaardia_tells = \
    /let _commander=$[strip_attr({P1})]%;\
    /let _command=$[strip_attr({P2})]%;\
    /let _commandAugment=$[strip_attr({P3})]%;\
    /if ({drone} = 1) /echo -pw @{Cyellow}Commander: %{_commander}, Command: %{_command}, Augment: %{_commandAugment}%;/endif%;\
    /if (({_command} =~ "commands" | {_command} =~ "help") & {drone} = 1 & {running}=0) \
        /def -mregexp -ag -p1 -n3 -t"You tell %{_commander} in your dreams.*" _drone_tell_commands%;\
        /if ({myclass} =~ "prs") \
            tell %_commander |n|Via |by|tell|p|: |w|spells|n|, |w|sanc|n|, |w|absolve|n|, |w|aegis|n|, |w|clarify|n|, |w|intervention|n|, |w|panacea|n|%;\
        /else \
            tell %_commander |n|Via |by|tell|p|: |w|spells|n|/|w|splitspells|n|, |w|sanc|n|, |w|frenzy|N|%; \
        /endif%;\
        tell %_commander |w|div|n|, |w|de|r|curse|n|, |w|cure |r|poison|n|, |w|cure |r|disease|n|, |w|cure |r|blind|n|, |w|pp|n|||w|nexus <target>|n|, |w|repmana|N|%;\
        tell %_commander |w|sepawen|n|, |w|bless|n|, |w|invig|n|, |w|etc...|N|%;\
    /elseif (({_command} =~ "report" | {_command} =~ "repmana" | {_command} =~ "status") & {drone} = 1 & {running}=0) \
        /def -mregexp -ag -p1 -n1 -t"You tell %{_commander} in your dreams.*" _drone_tell_repmana%;\
        /send tell %{_commander} Plane: |w|%{currentplane}|n|; |w|%{curr_mana}|bp|/|y|%{max_mana}|n| mana.%;\
    /elseif ({_command} =~ "reset" & {drone} = 1 & {running}=0) \
        /dronereset %{_commander}%;\
    /elseif ({droneLevel} !~ "thorngate" & ({_command} =/ "home" | {_command} =/ "thorn" | {_command} =/ "shrine") & {running}=0) \
        /def -mregexp -ag -p1 -n1 -t"%{_commander} is asleep, but you tell (him|her|it) 'Sorry, bot mode is currently confined to Midgaard.'" _drone_tell_nothorn%;\
        /send tell %{_commander} Sorry, bot mode is currently confined to Midgaard.%;\
    /elseif ({_command} =/ "fren*" & {myclass} =/ "prs" & {drone} = 1 & {running}=0) \
        /def -mregexp -ag -p1 -n1 -t"You tell %{_commander} in your dreams.*" _drone_tell_nofrenzy4u%;\
        tell %_commander Alas, I am a priest and priests do not get the frenzy spell so I can not cast it upon thee.%;\
    /elseif ({drone} = 1 & {running}=0) \
        /def -mregexp -ag -p1 -n1 -t"^%{_commander} is not here\!" %{_commander}_not_here = tell %{_commander} I would like to help you with that, but I cannot seem to find you.%;\
        /send stand%;\
        /if ({_command} =~ "sleep") \
            /send sleep%; \
        /elseif ({_command} =~ "spells" | {_command} =~ "full") \
            /if ({curr_mana} > 1900) \
                /def -mregexp -ag -p1 -n1 -t"^(%{_commander} is asleep, but you tell (him|her|it)|You Tell %{_commander}) 'Spellup will include: (Confidence,| )(Barkskin,| )Iron Skin, Water Breathing, Invincibility, Foci, Fortitudes, Awen, Holy Sight'" _drone_tell_osup_spells_%{_commander}%;\
                /def -mregexp -ag -p1 -n1 -t"^(%{_commander} is asleep, but you tell (him|her|it)|You Tell %{_commander}) 'Spellup complete.'" _drone_tell_osup_complete_%{_commander}%;\
                /osup %_commander%;\
            /else \
                /def -mregexp -ag -p1 -n1 -t"You tell %{_commander} in your dreams.*" _drone_tell_osup%;\
                /def -mregexp -ag -p1 -n1 -t"(%{_commander} is asleep, but you tell (him|her|it)|You Tell %{_commander}) 'Sorry, I need more mana first.'" _drone_tel_osup2_%{_commander}%;\
                tell %_commander Sorry, I need more mana first.%;\
            /endif%;\
        /elseif ({_command} =~ "splitspells" | {_command} =~ "split") \
            /if ({curr_mana} > 1900) \
                /osup2 %_commander%;\
                /def -mregexp -ag -p1 -n1 -t"^(%{_commander} is asleep, but you tell (him|her|it)|You Tell %{_commander}) 'Spellup will include: (Confidence,| )(Barkskin,| )Iron Skin, Water Breathing, Invincibility, Foci, Fortitudes, Split Awen (No Frenzy), Sanctuary, Holy Sight'" _drone_tell_osup_spells_%{_commander}%;\
                /def -mregexp -ag -p1 -n1 -t"^(%{_commander} is asleep, but you tell (him|her|it)|You Tell %{_commander}) 'Spellup complete.'" _drone_tell_osup_complete_%{_commander}%;\
            /else \
                /def -mregexp -ag -p1 -n1 -t"You tell %{_commander} in your dreams.*" _drone_tell_osup2%;\
                /def -mregexp -ag -p1 -n1 -t"%(%{_commander} is asleep, but you tell (him|her|it)|You Tell %{_commander}) 'Sorry, I need more mana first.'" _drone_tel_osup2_%{_commander}%;\
                tell %_commander Sorry, I need more mana first.%;\
            /endif%;\
        /elseif ({_command} =~ "decurse" | {_command} =~ "rc") \
            /if ({myclass} =~ "prs") c absolve %{_commander}%;\
            /else c 'remove curse' %{_commander}%;\
            /endif%;\
        /elseif ({_command} =~ "cure ?poison" | {_command} =~ "cp") \
            /if ({myclass} =~ "prs") c panacea %{_commander}%;\
            /else c 'cure poison' %{_commander}%;\
            /endif%;\
        /elseif ({_command} =~ "cure ?disease" | {_command} =~ "cd") \
            /if ({myclass} =~ "prs") c panacea %{_commander}%;\
            /else c 'cure disease' %{_commander}%;\
            /endif%;\
        /elseif ({_command} =~ "cure ?blind" | {_command} =~ "cb") \
            /if ({myclass} =~ "prs") c panacea %{_commander}%;\
            /else c 'cure blindness' %{_commander}%;\
            /endif%;\
        /elseif ({_command} =~ "holy sight" | {_command} =~ "hs" | {_command} =~ "hos") \
            c 'holy sight' %{_commander}%;\
        /elseif ({_command} =~ "light") \
            c 'magic light' %{_commander}%;\
        /elseif ({_command} =/ "home" | {_command} =/ "thorn") \
            /if ({currentplane} !~ "thorngate") \
                /send stand=c homeshift=east=east=where%;\
            /endif%;\
        /elseif ({_command} =/ "mid") \
            /if ({currentplane} !~ "midgaardia") \
                /send stand=c planeshift midgaard=sanctum=where=d=w%;\
            /endif%;\
        /elseif ({_command} =/ "shrine") \
            /if ({currentplane} !~ "thorngate") \
                /send stand=c homeshift=east=east=where%;\
            /endif%;\
            /send c 'create shrine'%;\
        /elseif ({_command} =/ "sepawen") \
            sawen %{_commander}%;\
        /else \
            /let cSpell=$[({_command}=~"div"&{currentplane}!~"midgaardia")?"comfort":({_command}=~"comf"&{currentplane}!~"thorngate")?"div":{_command}]%;\
            /if ({_commandAugment} > 0 & {_commandAugment} < 6) /send augment %_commandAugment%; /endif%;\
            c '%{cSpell}' %_commander%;\
            /if ({_commandAugment} > 0 & {_commandAugment} < 6) /send augment off%; /endif%;\
        /endif%;\
        /send sleep%;\
    /endif%;\
    /if ({drone} = 1 & {DBMODE} =/ "on" & {running}=0) \
;         /quote -S /echo !mysql -u %{DB_USERNAME} --password=%{DB_PASSWORD} %{DB_NAME} -s -e "insert into drone_commands (name, command) values ('%{_commander}', '%{_command} %{_commandAugment}')"%;\
    /else \
        /def -mglob -ag -p1 -n1 -t"*Sorry, bot mode is currently disabled*" _tmp_bot_off_tell = /undef _drone_tell_nobot%;\
        /def -mregexp -ag -p1 -n1 -t"%{_commander} is asleep, but you tell (him|her|it) 'Sorry, bot mode is currently disabled.  Try again later.'" _drone_tell_nobot = /undef _tmp_bot_off_tell%;\
        /send tell %{_commander} Sorry, bot mode is currently disabled.  Try again later.%;\
    /endif

/def -mregexp -ag -p1 -F -t"([a-zA-Z]+) tells you '(thren[ody]*|req[uiem]*|salv[ation]*) ([a-zA-Z]+)'" drone_lord_misc_tells = \
    /if ({drone} = 1 & {currentplane} !~ "thorngate" & {running}=0) \
        /send tell %{P1} That spell is only available on Thorngate.%;\
    /elseif ({drone} == 1 & {running}=0) \
        /send stand=cast '%{P2}' %{P3}=sleep%;\
        /if ({DBMODE} =/ "on") \
;             /quote -S /echo !mysql -u %{DB_USERNAME} --password=%{DB_PASSWORD} %{DB_NAME} -s -e "insert into drone_commands (name, command) values ('%{P1}', '%{P2} %{P3}')"%;\
        /endif%;\
    /endif

/def -p9 -F -q -ag -mregexp -t"\[LORD INFO\]\: ([A-Za-z]+) initiates a Threnody dirge for corpse of ([A-Za-z]+) in (.*)\." drone_lord_help_threnody = \
    /if ({P1} !~ ${world_name} & {drone} == 1 & {currentplane} =~ "thorngate" & {running}==0) \
        /send stand=cast 'threnody' %{P2}=sleep%;\
    /endif

;; Send scripts
/def -mregexp -ag -p1 -F -t"([a-zA-Z]+) tells you 'send ([a-zA-Z]+) ([a-zA-Z]+)'" drone_lord_send_tell = \
    /if ({drone} = 1 & {currentplane} !~ "thorngate" & {running}=0) \
        /send tell %{P1} |w|Send |n|is only available on Thorngate.%;\
    /elseif ({drone} = 1 & {running}=0) \
        /set droneToSend=$[tolower(strip_attr({P2}))]%;\
        /set droneSendPlane=$[tolower(strip_attr({P3}))]%;\
;        /echo -pw @{Cyellow}Commander: %{P1}, Command: send, Argument: %{droneToSend} %{droneSendPlane}%;\
        /send gtell |y|%{P1} |c|has requested that I send |y|%{droneToSend} |c|to |y|%{droneSendPlane}|c|.|n|%;\
        /send group%;\
    /endif

/def -mregexp -p1 -F -t'\|[ ]*[0-9]+[ ]+[a-zA-Z]+[ ]+([a-zA-Z ]+)[ ]+(STUN|DROWN|Busy|Fight|Sleep|Stand|Rest)[ ]+([0-9\-]+)/([0-9\-]+)[ ]+([0-9\-]+)/([0-9\-]+)[ ]+([0-9\-]+)/([0-9\-]+)(.*)' drone_lord_send_from_grouplist = \
    /let lcgroupiename=$[tolower(replace(" ", "", strip_attr({P1})))]%;\
;    /echo -pw @{Cyellow}Groupie: %{lcgroupiename}, Command: send, Argument: %{droneToSend} %{droneSendPlane}%;\
    /if ({drone} = 1 & {running}=0 & {currentplane} =~ "thorngate" & {droneToSend} !~ "" & {droneSendPlane} !~ "" & regmatch({droneToSend}, {lcgroupiename})) \
        /send gtell |c|Ok, sending |y|%{droneToSend} |c|to |y|%{droneSendPlane}|c|. Safe Travels.|n|%;\
        /send stand=cast 'send' %{droneToSend} %{droneSendPlane}=follow self=sleep%;\
        /unset droneToSend%;/unset droneSendPlane%;\
    /endif
    
/def -wgengis -mregexp -ag -p1 -F -t"([a-zA-Z]+) tells you '(abs[olve]*|aegis|clar[ify]*|interv[ention]*|pana[cea]*|sol[itude]*)'" drone_priest_tells = \
    /let _commander=$[strip_attr({P1})]%;\
    /let _command=$[strip_attr({P2})]%;\
    /echo -pw @{Cyellow}Commander: %{_commander}, Command: %{_command}, Augment: %{_commandAugment}%;\
    /if ({drone} = 1 & {_command} =~ "solitude" & {currentplane} !~ "thorngate" & {running}=0) \
        /send tell %{_commander} |w|Solitude |n|is only available on Thorngate.%;\
    /elseif ({drone} = 1 & {running}=0) \
        /send stand=cast '%{_command}' %{_commander}=sleep%;\
        /if ({_command} =/ "interv[ention]*") \
            /def -mglob -ag -p5 -n1 -t"Your intervention spell is still exhausted." intervention_%{_commander} = \
                /send tell %{_commander} Intervention is still in exhaust - try again later.%%;\
                /undef intervention2_%{_commander}%;\
            /def -mglob -ag -p5 -n1 -t"The Gods agree to intervene on behalf of %{_commander}!" intervention2_%{_commander} = \
                /undef intervention_%{_commander}%;\
        /endif%;\
        /if ({DBMODE} =/ "on") \
;             /quote -S /echo !mysql -u %{DB_USERNAME} --password=%{DB_PASSWORD} %{DB_NAME} -s -e "insert into drone_commands (name, command) values ('%{_commander}', '%{_command}')"%;\
        /endif%;\
    /endif

/def -wgengis -mregexp -ag -p1 -F -t"([a-zA-Z]+) tells you 'preach (all|sanc|frenzy|div|aegis|foci|fort[itudes]*|bless|invig|iron skin|holy aura|holy armor|armor|fly|water breath|water|invinc|holy sight|comf|clarify|absolve|panacea)([1-5]?)'" drone_priest_preach_tells = \
    /let _commander=$[strip_attr({P1})]%;\
    /let _command=$[strip_attr({P2})]%;\
    /let _commandParam=$[strip_attr({P3})]%;\
    /if ({drone} = 1 & {_commander} =~ {leader} & {running}=0) \
        /send stand%;\
        /if ({_command} =~ "all") \
            /send gtell |bw|%{leader}|c| has requested the group get spells.|n|%;\
            /gsup%;\
            /send gtell |c|Ok. There you go.  If you weren't ready, blame |bw|%{leader}|c|.|n|=follow self%;\
        /else \
            /if ({_commandParam} > 0 & {_commandParam} < 6) /send augment %_commandParam%; /endif%;\
            /send gtell And, |bw|%{leader} |n|came forth and they said, grant them "|g|%{_command}|n|"!!%;\
            preach %{_command}%;\
            /if ({_commandParam} > 0 & {_commandParam} < 6) /send augment off%; /endif%;\
        /endif%;\
        /send sleep%;\
    /elseif ({drone} = 1 & {_commander} !~ {leader} & {running}=0) \
        tell %{1} I only preach for my group leader.  Beckon me and I shall follow you.%;\
    /endif%;\
    /if ({drone} = 1 & {DBMODE} =/ "on" & {running}=0) \
;         /quote -S /echo !mysql -u %{DB_USERNAME} --password=%{DB_PASSWORD} %{DB_NAME} -s -e "insert into drone_commands (name, command) values ('%{_commander}', 'preach %{_command} %{_commandParam}')"%;\
    /endif

/def -mregexp -p1 -ag -t"([a-zA-Z]+) tells you 'seal (por[tal]*|nex[us]*)'" drone_seal = \
    /if ({drone} = 1 & {running}=0) \
        /send stand%;\
        /if ({P2} =/ "por*") /let transType=portal%;\
        /else /let transType=nexus%;\
        /endif%;\
        /send say |w|Sealing |g|%{transType} |w|for |bg|%{P1}|w|"|n|=c seal %{P2}%;\
        /send sleep%;\
    /endif

/def -mregexp -p1 -ag -t"([a-zA-Z]+) tells you '(nex[us]*|por[tal]*|pp) (.*)'" drone_portal = \
    /if ({drone} = 1 & {running}=0) \
;        /if ({position} =~ "sleeping") \
;            /let priorPosition="sleeping"%;\
;            /send stand%;\
;        /endif%;\
        /send stand%;\
        /if ({P2} =/ "p*") /let transType=portal%;\
        /else /let transType=nexus%;\
        /endif%;\
        /send say |w|Opening up a %{transType} for |bg|%{P1} |w|to "|g|%{P3}|w|"|n|=c %{transType} %{P3}%;\
;        /if ({priorPosition} =~ "sleeping") /send sleep%;/endif%;\
        /send sleep%;\
    /endif%;\
    /if ({drone} = 1 & {DBMODE} =/ "on" & {running}=0) \
;         /quote -S /echo !mysql -u %{DB_USERNAME} --password=%{DB_PASSWORD} %{DB_NAME} -s -e "insert into drone_commands (name, command) values ('%{P1}', '%{P2} %{P3}')"%;\
    /endif

;;; ----------------------------------------------------------------------------
;;; Drone supporting triggers
;;; ----------------------------------------------------------------------------
/def -i droneconfig = \
    /set currentplane=%{1}%;\
    /send tag remove bot%;\
    /if ({drone} == 1) \
        /send tag set bot |c|Currently botting on |y|%{currentplane}|n|%;\
    /endif
/def -ag -mregexp -t"^Tag with label bot removed." gag_remove_bot_tag
/def -ag -mregexp -t"^You have no tag with label bot." gag_no_bot_tag
/def -ag -mregexp -t"^New tag created:" gag_new_tag_created
/def -ag -mregexp -t"^bot \-" gag_new_tag_bot 
/def -ag -mregexp -t"^bot \- (midgaardia|thorngate)" gag_plane_bot_tag

/def -mglob -p5 -t"You form a magical vortex and step into it..." drone_shift = /send where
/def -mregexp -p5 -t"(You become your true self again|But you are already there|The Center of Thorngate Square)" drone_thorngate = \
    /droneconfig thorngate

/def -mglob -p5 -t"The Flying Citadel of Zin *" drone_midgaardia = \
    /droneconfig midgaardia

/def -mregexp -p5 -t"Players near you in (.*) Plane, Area" drone_plane_where = \
    /set currentplane=$[strip_attr(tolower({P1}))]%;\
    /if ({drone}=1) \
        /droneconfig %{currentplane}%;\
        /if ({currentplane} =~ "thorngate") \
            /send dronetitlethornon%;\
        /elseif ({currentplane} =~ "midgaardia") \
            /send dronetitleon%;\
        /endif%;\
    /endif

;; anti-invis trigger
/def -mglob -p1 -t"You fade out of existence." drone_anti_invis = \
    /if ({drone}=1 & {running}=0) \
        /send stand=vis=sleep%;\
    /endif

;;; ----------------------------------------------------------------------------
;;; Ignore-Spells list.
;;; Used to add people to the no-spell list for idiots that won't get steel/invinc/...
;;; /addignore char[s]  - to add char[s] to the ignore list.
;;; /rmignore char      - to remove someone from the ignore list.
;;; /ignoresave         - to save current Ignore-List to file.
;;; /reignore           - load Ignore-List from file.
;;; /ignorelist         - show current chars in Ignore-List.
;;; ----------------------------------------------------------------------------
/def addignore = \
        /let lcval=$[tolower({*})]%; \
        /echo -p %% @{Ccyan}Adding @{hCwhite}%lcval @{nCcyan}to the Ignore-Spells List.@{n}%; \
        /set ignore_spells_list=%ignore_spells_list %lcval%; \
        /ignoresave
/def rmignore = \
        /set ignore_spells_list=$(/remove %1 %ignore_spells_list)%; \
        /ignoresave
/def ignoresave = \
        /set ignore_spells_list=$(/unique %ignore_spells_list)%; \
        /echo -p %% @{Ccyan}Saving Ignore-Spells List to "@{hCwhite}.ignorelist@{nCcyan}"@{n}%; \
        /sys echo "/set ignore_spells_list="%ignore_spells_list > .ignorelist
/def reignore = \
        /echo -p %% @{Ccyan}Loading Ignore-Spells List from "@{hCwhite}.ignorelist@{nCcyan}"@{n}%; \
        /load -q .ignorelist
/def ignorelist = \
        /echo -p %% @{Ccyan}Ignore-Spells List: @{hCwhite}%ignore_spells_list@{n}
; Load the ignore list
/reignore
