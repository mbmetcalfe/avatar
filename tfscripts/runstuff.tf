;;; ----------------------------------------------------------------------------
;;; runstuff.tf
;;; 
;;; ----------------------------------------------------------------------------
/def -mregexp -p5 -t"^([a-zA-Z]+) beckons for you to follow (him|her|it)\." leader_beckon = \
    /if ({P1}=~{leader}) \
        /if ({position}!~"standing") /send stand%;/endif%;\
        /send follow %{leader}%;\
    /endif

;;; ----------------------------------------------------------------------------
;;; Autobrandish script - will brandish every 30 seconds
;;; ----------------------------------------------------------------------------
/def autobran = \
    /toggle autobrandish%;\
    /echoflag %autobrandish Auto-Brandish%;\
    /statusflag %autobrandish Brand
/def  tbra = \
    /if ({autobrandish}=1) \
        /bra%;\
        /repeat -0:00:31 1 /tbra%; \
    /else /echo -pw %%% Autobrandish is @{hCred}OFF@{n}!%;\
    /endif

;;; ----------------------------------------------------------------------------
;;; Perfect gem info
;;; ----------------------------------------------------------------------------
/def -mregexp -ah -t"([a-zA-Z0-9,\.\-\ \']+)'s fleeting spirit crystallizes into a a perfect (.*)\!" mob_pgem_drop = \
    /set pgems=%{pgems} %P2%;\
    /send get %P2
/def -mregexp -ah -t"([a-zA-Z0-9,\.\-\ \']+) leaves behind a perfect (amethyst|diamond|emerald|ruby|sapphire)\!$" pgem_drop = \
    /set pgems=%{pgems} %P2%;\
    /send get %P2

;;; ----------------------------------------------------------------------------
;;; Experience related triggers
;;; ----------------------------------------------------------------------------
/def -p5 -mregexp -t'^You receive ([0-9]+) experience points.$' rcvexp = \
    /setXp $[xp+{P1}]%;\
    /set lastXp=%{P1}%;\
    /set kills=$[++kills]%;\
    /if (regmatch({myclass},{arcType})) get all.brace corpse%;/endif%;\
    /if ({autosac} = 1) sacrifice corpse%;/endif%;\
    /if ({psichk} = 1) /chkpsis %; /endif%;\
    /if ({autolkb} = 1) get %lockbox corpse%;/endif%;\
    /performQ %; \
    /dochk

/def -p0 -mregexp -t'^You have received an award of ([0-9]+) experience points\!$' rcvexp2 = /setXp $[xp+{P1}]

;; Morph failers get reduced exp
/def -p0 -mregexp -t'^Your failed morph penalty reduces the experience gain to ([0-9]+).$' morphfail_rcvexp = \
    ;/setXp $[xp + lastXp*-1 + {P1}]%;\
    /set failXp=$[failXp+{P1}]

/def -p0 -mregexp -t'^Tul-Sith grants you ([0-9]+) exp!$' rcvhealexp = \
    /setXp $[xp+{P1}] %; \
    /set healxp=$[healxp+{P1}] %; \
    /set numheal=$[++numheal] %; \
    /if ({P1} > {maxheal}) \
        /set maxheal %P1 %;\
    /endif

/def -mregexp -p0 -t"^Death sucks ([0-9]+) experience points from you as payment for resurrection\." death_exploss = \
    /setXp $[xp-{P1}]%; \
    /set deaths=$[++deaths]%; \
    /set deathxp=$[deathxp+{P1}]

/def -p0 -mregexp -t'^You flee! What a COWARD! You lose ([0-9]+) exps!$' flee1trig = \
    /setXp $[xp-{P1}]%; \
    /set numflee=$[++numflee]%; \
    /set fleexp=$[fleexp+{P1}]%;\
    /if ({myclass} =~ "arc" | {myclass} =~ "fus") /send cover%; /endif

;;; ----------------------------------------------------------------------------
;;; Death Field tracking
;;; ----------------------------------------------------------------------------
/def -mregexp -p0 -ah -t"^Bhyss has come for you, ([a-zA-Z]+)\." deathfield_maxhpredux = \
    /set dfbhysscount=$[++bhysscount]
/def -mglob -p0 -ah -t'You get caught in your own death field\!' deathfield_caught = \
    /set dfcaughtcount=$[++dfcaughtcount]

/def rgains = \
    /let echochan=/echo%; \
    /if ({#} > 0) /let echochan=%*%; /endif %; \
    /let gainsmsg=|w|Gains: |bp|%{levels} |w|levels, |bp|%{hpgains} |w|hp, |bp|%{managains} |w|m, |bp|%{pracgains} |w|pracs.%; \
    /if ({echochan} =~ "/echo") \
        /let newmsg=$[replace("|bp|", "@{hCmagenta}", {gainsmsg})] %; \
        /let newmsg=$[replace("|w|", "@{nCwhite}", {newmsg})] %; \
        /echo -pw %%% %newmsg %; \
    /else \
        /eval %echochan %gainsmsg %; \
    /endif

/def gains = \
    /let echochan=/echo%; \
    /if ({#} > 0) /let echochan=%*%; /endif %; \
    /let gainsmsg=|w|Total Gains: |bp|%{totlevels} |w|levels, |bp|%{tothpgains} |w|hp, |bp|%{totmanagains} |w|m, |bp|%{totpracgains} |w|pracs.%; \
    /if ({echochan} =~ "/echo") \
        /let newmsg=$[replace("|bp|", "@{hCmagenta}", {gainsmsg})] %; \
        /let newmsg=$[replace("|w|", "@{nCwhite}", {newmsg})] %; \
        /echo -pw %%% %newmsg %; \
    /else \
        /eval %echochan %gainsmsg %; \
    /endif
        
/def rdeaths = \
    /let echochan=/echo%; \
    /if ({#} > 0) /let echochan=%*%; /endif %; \
    /if ({deaths} > 0) \
        /let deathmsg=|r|Died |k|%deaths |r|times losing |k|%deathxp |r|exp.%; \
        /if ({echochan} =~ "/echo") \
            /let newmsg=$[replace("|k|", "@{Cblack}", {deathmsg})] %; \
            /let newmsg=$[replace("|r|", "@{Cred}", {newmsg})] %; \
            /echo -pw %%% %newmsg %; \
        /else /eval %echochan %deathmsg %; \
        /endif%; \
    /endif

/def deaths = \
    /let echochan=/echo%; \
    /if ({#} > 0) /let echochan=%*%; /endif %; \
    /if ({totdeaths} > 0) \
        /let deathmsg=|k|%totdeaths |r|total deaths losing |k|%totdeathxp |r|exp.%; \
        /if ({echochan} =~ "/echo") \
            /let newmsg=$[replace("|k|", "@{Cblack}", {deathmsg})] %; \
            /let newmsg=$[replace("|r|", "@{Cred}", {newmsg})] %; \
            /echo -pw %%% %newmsg %; \
        /else /eval %echochan %deathmsg %; \
        /endif%; \
    /endif

/def rdfstat = \
    /let echochan=/echo%; \
    /if ({#} > 0) /let echochan=%*%; /endif %; \
    /if ({dfbhysscount} > 0 | {dfcaughtcount} > 0) \
        /let dfmsg=|k|Bhyss has come for me |r|%dfbhysscount |k|times, and I got caught in my own |bk|death field |r|%dfcaughtcount |k|times.%; \
        /if ({echochan} =~ "/echo") \
            /let newmsg=$[replace("|k|", "@{nCblack}", {dfmsg})] %; \
            /let newmsg=$[replace("|bk|", "@{hCblack}", {newmsg})] %; \
            /let newmsg=$[replace("|r|", "@{nCred}", {newmsg})] %; \
            /echo -pw %%% %newmsg %; \
        /else /eval %echochan %dfmsg %; \
        /endif%; \
    /endif

/def dfstat = \
    /let echochan=/echo%; \
    /if ({#} > 0) /let echochan=%*%; /endif %; \
    /if ({totdfbhysscount} > 0 | {totdfcaughtcount} > 0) \
        /let dfmsg=|k|Bhyss has come for me |r|%totdfbhysscount |k|times, and I got caught in my own |bk|death field |r|%totdfcaughtcount |k|times.%; \
        /if ({echochan} =~ "/echo") \
            /let newmsg=$[replace("|k|", "@{nCblack}", {dfmsg})] %; \
            /let newmsg=$[replace("|bk|", "@{hCblack}", {newmsg})] %; \
            /let newmsg=$[replace("|r|", "@{nCred}", {newmsg})] %; \
            /echo -pw %%% %newmsg %; \
        /else /eval %echochan %dfmsg %; \
        /endif%; \
    /endif

;;; ----------------------------------------------------------------------------
;;; Run counter echo/reset macroes
;;; ----------------------------------------------------------------------------
/def rgain = \
    /let echochan=/echo%; \
    /if ({#} > 0) /let echochan=%*%; /endif %; \
    /let leader_lower=$[tolower({leader})]%; \
    /let thankee=$[{leader_lower}=~{myname} | {leader_lower}=~ "self"?"|w|for coming":{leader}] %; \
    /if ({kills} > 0) /let avg=$[xp/kills] %; /endif %; \
    /if ({running} == 1) \
        /set runElapsedTime=$[time() - runStart] %; \
    /endif%;\
    /let runmins=$[mod(runElapsedTime/60,60)]%; \
    /let runsecs=$[mod(runElapsedTime,60)]%; \
    /let runTimeMsg=|g|%runmins |w|mins |g|%runsecs |w|secs%; \
    /let rgainmsg=|g|%{xp}|w| exp (|g|%{levels} |w|levels) from |g|%{kills}|w| kills (|g|%{avg}|w| avg). Time: %{runTimeMsg}.%; \
    /let xgainmsg=%{xp} exp (%{levels} levels) from %{kills} kills (%{avg} avg). Time: %{runTimeMsg}.%; \
    /if ({kills} > 0) \
        /let killTime=$[runElapsedTime/kills] %; \
        /let killTime=$[substr({killTime}, 0, strstr({killTime}, ".") + 3)]%;\
        /let rgainmsg=%rgainmsg |g|%killTime |w|secs/kill. %; \
    /endif%; \
    /if ({runmins} > 0) \
        /let xppermin=$[xp/runmins]%; \
        /let rgainmsg=%rgainmsg |g|%xppermin |w|exp/min.%; \
    /endif%; \
    /let rgainmsg=%rgainmsg |w|Thanks |g|%{thankee}|w|.%; \
    /if ({myclass} =~ "prs") \
        /let rhealmsg=|bw|Run Heal Exp stats: |br|%{numheal} |bw|heals that gave exp giving |br|%{healxp}|bw| (|br|%{maxheal}|bw| Max). %; \
    /endif %; \
    /if ({pgems} !~ "") \
        /let rpgemmsg=|w|We received the following perfect gem(s): |g|%{pgems}|w|.%;\
    /endif%;\
    /if ({failXp} > 0) \
        /let rFailXpMsg=|w|Since I failed morph, I really only got |g|%{failXp}|w| exp|w|.%;\
    /endif%;\
    /if ({echochan} =~ "/echo") \
        /let newmsg=$[replace("|g|", "@{Cgreen}", {rgainmsg})] %; \
        /let newmsg=$[replace("|w|", "@{Cwhite}", {newmsg})] %; \
        /echo -pw %%% %newmsg %; \
        /if ({failXp} > 0) \
            /let rFailXpMsg=$[replace("|w|", "@{Cwhite}", {rFailXpMsg})]%;\
            /let rFailXpMsg=$[replace("|g|", "@{Cgreen}", {rFailXpMsg})]%;\
            /echo -pw %%% %rFailXpMsg%;\
        /endif%;\
        /if ({myclass} =~ "prs") \
            /let newmsg=$[replace("|bw|", "@{hCwhite}", {rhealmsg})] %; \
            /let newmsg=$[replace("|br|", "@{hCred}", {newmsg})] %; \
            /echo -pw %%% %newmsg %; \
        /endif %; \
        /if ({pgems} !~ "") \
            /let rpgemmsg=$[replace("|w|", "@{Cwhite}", {rpgemmsg})]%;\
            /let rpgemmsg=$[replace("|g|", "@{Cgreen}", {rpgemmsg})]%;\
            /echo -pw %%% %rpgemmsg%;\
        /endif%;\
    /elseif ({echochan} =~ "/xtitle") \
        /let xgainmsg=$[replace("|g|", "", {ngainmsg})] %; \
        /let xgainmsg=$[replace("|w|", "", {ngainmsg})] %; \
        /xtitle ${world_character}: %xgainmsg %; \
    /else \
        /eval %echochan %rgainmsg %; \
        /if ({failXp} > 0) \
            /eval %echochan %rFailXpMsg%;\
        /endif%;\
        /if ({myclass} =~ "prs") \
            /eval %echochan %rhealmsg %; \
        /endif %; \
        /if ({pgems} !~ "") \
            /eval %echochan %rpgemmsg%;\
        /endif %; \
    /endif

/def gain = \
    /let echochan=/echo%; \
    /if ({#} > 0) /let echochan=%*%; /endif %; \
    /if ({totkills} > 0) /let avg=$[totxp/totkills] %; /endif %; \
    /let gainmsg=|g|%{totxp}|w| exp (|g|%{totlevels} |w|levels) from |g|%{totkills}|w| kills (|g|%{avg}|w| avg) from |g|%{runs} |w|runs.%; \
    /if ({myclass} =~ "prs") \
        /let healmsg=|bw|Heal Exp: |br|%{totnumheal} |bw|heals that gave exp giving |br|%{tothealxp}|bw| (|br|%{maxheal}|bw| Max). %; \
    /endif %; \
    /if ({echochan} =~ "/echo") \
        /let newmsg=$[replace("|g|", "@{Cgreen}", {gainmsg})] %; \
        /let newmsg=$[replace("|w|", "@{Cwhite}", {newmsg})] %; \
        /echo -pw %%% %newmsg %; \
        /if ({myclass} =~ "prs") \
            /let newmsg=$[replace("|bw|", "@{hCwhite}", {healmsg})] %; \
            /let newmsg=$[replace("|br|", "@{hCred}", {newmsg})] %; \
            /echo -pw %%% %newmsg %; \
        /endif %; \
    /else \
        /eval %echochan %gainmsg %; \
        /if ({myclass} =~ "prs") \
            /eval %echochan %healmsg %; \
        /endif %; \
    /endif

/def -i setXp = \
    /set xp=%1%;\
    /set displayXP=XP:%{xp}

/def runreset = \
    /set totxp=$[totxp+xp]%;/unset pgems%; \
    /set totFailXp=$[totFailXp + failXp]%;\
    /set totkills=$[totkills+kills]%;/set totgolden=$[totgolden+golden] %; \
    /set totdeaths=$[totdeaths+deaths]%;/set totdeathxp=$[totdeathxp+deathxp]%; \
    /set totdfbhysscount=$[totdfbhysscount+dfbhysscount]%; \
    /set totdfcaughtcount=$[totdfcaughtcount+dfcaughtcount]%; \
    /set totresc=$[totresc+resc]%;/set totsucresc=$[totsucresc+sucresc] %; \
    /set totcritical=$[totcritical+critical]%; \
    /set tothpgains=$[tothpgains+hpgains]%;/set totmanagains=$[totmanagains+managains] %; \
    /set totmvgains=$[totmvgains+mvgains]%;/set totpracgains=$[totpracgains+pracgains] %; \
    /set totlevels=$[totlevels+levels] %;/set totruntime=$[totruntime+runTime]%; \
    /set totnumflee=$[totnumflee+numflee]%;/set totfleexp=$[totfleexp+fleexp]%; \
    /setXp 0%;/set kills=0%;/set critical=0%;/set levels=0%; \
    /set deaths=0%;/set deathxp=0%;/set failXp=0%; \
    /set dfbhysscount=0%;/set dfcaughtcount=0%; \
    /set golden=0%;/set resc=0%;/set sucresc=0 %; \
    /set hpgains=0%;/set managains=0%;/set mvgains=0%;/set pracgains=0%; \
    /set scrollcount=0%;/set potioncount=0%;/set stavecount=0%; \
    /set runElapsedTime=0%;\
    /if ({myclass} =~ "prs") \
        /set tothealxp=$[tothealxp+healxp] %; \
        /set totnumheal=$[totnumheal+numheal] %; \
        /set healxp=0%;/set numheal=0 %; \
    /endif %; \
    /echo -p % @{hCyellow}Run stats reset.@{n}

;;; By running /runreset twice, we clear all variables
/def totreset = \
    /damreset%;/runend%;/runreset%;\
    /set totxp=0%;/set totFailXp=0%;/set totkills=0%;/set runs=0 %; \
    /set tothpgains=0%;/set totmanagains=0%;/set totmvgains=0%; \
    /set totpracgains=0%;/set totlevels=0 %; \
    /set totnumflee=0%;/set totfleexp=0%; \
    /set totdeaths=0%;/set totdeathxp=0%; \
    /set totdfbhysscount=0%;/set totdfcaughtcount=0%; \
    /if ({myclass} =~ "prs") \
        /set tothealxp=0%;/set totnumheal=0 %; \
    /endif %; \
    /if ({drone} = 1) /set drone=0%;/endif%;\
    /clrres%;\
    /targ clear%;\
    /deathlist clear%;\
    /echo -p %%% @{hCyellow}All counters reset.@{n}

/def runstart = \
;;    /send affect%;\
    /set runs=$[++runs]%;\
    /runreset%;\
    /damreset%;\
    /set runStart=$[time()]%;\
    /set running=1%;\
    /statusflag %running Run%;\
    /echo -p @{hCyellow}% Run counters reset.@{n} %; \
    /set drone=0%;\
    /if ({leader} !~ "Self") \
        /if ({folport} == 0) /fport %{leader}%;/endif%;\
        /if ({asleep} == 0) /asleep%;/endif%;\
        /autorelog %{leader}%;\
    /endif%;\
    /if ({refreshmisc} == 0) /refreshmisc%;/endif%;\
    /if ({mytier} !~ "lord" & {resanc} = 0 & ({myclass} !~ "sor" | {myclass} !~ "bci" | {myclass} !~ "bzk")) /resanc %; /endif%;\
      /if ({myclass} =~ "pal" & {repray} = 0) /repray %; /endif%;\
    /if ({refren} = 0 & {leader} !~ "Self" & {myclass} !~ "bzk") /refren %; /endif%;\
    /if ({autokill} = 0 & {leader} !~ "Self" & {mytier} !~ "lord" & {myclass} !~ "prs") /assist %; /endif%;\
    /def -n1 -mregexp -ag -p2 -t"You need [0-9]+ experience to level and have ([0-9]+) practices\." runstart_worth_pracs = /set max_prac=%%P1%;\
    /def -n1 -ag -p5 -mglob -t"You have * gold coins in hand and * gold coins in the bank\." runstart_gold%;\
    /send worth

/def runend = \
    /if ({running} == 1) \
        /set runElapsedTime=$[time() - runStart] %; \
    /endif%;\
    /set running=0%;\
    /statusflag %running Run%;\
    /if ({autobrandish} = 1) /autobran %; /endif%;\
    /if ({autopick} = 1) /autopick %; /endif%;\
    /if ({resanc} = 1) /resanc %; /endif%;\
    /if ({repray} = 1) /repray %; /endif%;\
    /if ({refren} = 1) /refren %; /endif%;\
    /if ({folport} = 1) /fport %; /endif%;\
    /if ({folshift} == 1) /fshift%;/endif%;\
    /if ({arelog} = 1) /autorelog %;/endif%;\
    /if ({autokill} = 1) /assist %; /endif%;\
    /if ({autowalk} = 1) /autowalk %; /endif%;\
    /if ({atarg} = 1) /atarg %; /endif%;\
    /if ({aslip} == 1) /aslip%;/endif%;\
    /if ({autols} == 1) /autols%;/endif%;\
    /if ({autokill} = 1) /assist%;/endif%;\
    /if ({autochase} == 1) /chase%;/endif%;\
    /if ({asleep} = 1) /asleep %; /endif%;\
    /if ({autocast} = 1) /acast %; /endif%;\
    /if ({automidround} = 1) /amid%;/endif%;\
    /if ({autobrandish} = 1) /autobrandish %; /endif%;\
    /if ({drone} = 1) /drone %; /endif%;\
    /if ({autoheal} = 1) /aheal%;/endif%;\
    /if ({autocure} = 1) /autocure%;/endif%;\
    /if ({refreshmisc} = 1) /refreshmisc%;/endif%;\
    /if ({refreshAura} == 1) /refreshAura%;/endif%;\
    /let this=$[tolower(world_info())]%;\
    /if /test (%{this}_cast == 1 & %{this}_auto_cast == 1)%;/then /cast off%;/endif%;\
    /edit -c100 gear_misc_coins

;;; ----------------------------------------------------------------------------
;;; Rescue counting
;;; ----------------------------------------------------------------------------
/def -mregexp -F -ah -t"^You fail to rescue" failrescuetrig = /set resc=$[resc+1]
/def -mregexp -F -ah -t"^You successfully rescue" successrescuetrig = \
    /set sucresc=$[++sucresc] %; \
    /set resc=$[++resc]

;;; ----------------------------------------------------------------------------
;;; Healie stats
;;; ----------------------------------------------------------------------------
/def -mregexp -t"You recite (.*)\." recite_scroll = /set scrollcount=$[++scrollcount]
/def -mregexp -t"You quaff (.*)\." quaff_potion = /set potioncount=$[++potioncount]
/def -mregexp -t"You brandish (.*)\." brandish_staff = /set stavecount=$[++staveishcount]

/def healies = \
    /let hchan=/echo%; \
    /if ({#} > 0) /let hchan=%*%; /endif%; \
    /let hmsg=|w|Used |bc|%{scrollcount} |w|scrolls, |bc|%{potioncount} |w|potions, and |bc|%{stavecount} |w|staves.%; \
    /if ({hchan} =~ "/echo") \
        /let hmsg=$[replace("|bc|", "@{hCcyan}", {hmsg})]%; \
        /let hmsg=$[replace("|w|", "@{nCwhite}", {hmsg})]%; \
        /echo -pw %%% %hmsg%; \
    /else /eval %hchan %hmsg%; \
    /endif

;;; ----------------------------------------------------------------------------
;;; Groupie death list
;;; /gurn char to automatically gurney when "char" shifts
;;; /summ char to automatically summon when "char" shifts
;;; /deathlist [channel] - shows list of the dead.  If no channel, /echo -w by default
;;; /rmdeath char - to remove someone from list manually
;;; ----------------------------------------------------------------------------
/def gurn = \
    /if ({#} > 0) \
        /set autogurney=$[tolower({1})]%; \
        /echo -pw %%% @{hCred}Will gurney @{nCwhite}%autogurney @{hCred}when they shift.@{n}%; \
    /else \
        /unset autogurney%;\
        /echo -pw %%% @{hCred}Auto-Gurney is off.%; \
    /endif

/def summ = \
    /if ({#} > 0) \
        /let summonee=$[tolower({1})]%;\
        /def -mregexp -F -p7 -ag -t"\[LORD INFO]: ([a-zA-Z]+) has just shifted to (.+)\!" shift_summon = \
            /let lcshifter=$$[tolower({P1})]%%; \
            /if ({lcshifter} =~ "%{summonee}" & {currentPosition} =~ "stand" & {mudLag} <= 1) /send c summon %summonee%%; /endif%;\
        /echo -pw %%% @{hCred}Will summon @{nCwhite}%1 @{hCred}when they shift.@{n}%; \
    /else \
        /undef shift_summon%;\
        /echo -pw %%% @{hCred}Auto-Summon is off.%; \
    /endif

/def deathlist = \
    /if ({#}=1 & {1} =~ "clear") \
        /unset deathlist%;\
        /echo -pw %%% @{Ccyan}Death list has been cleared.%;\
    /else \
        /let echochan=/echo%; \
        /if ({#} > 0) /let echochan=%*%; /endif %; \
        /if ({deathlist} !~ "") \
            /let tDeathList=$[replace("<", " ", {deathlist})] %; \
            /let deathmsg=|c|R.I.P.: |w|%tDeathList%; \
            /if ({echochan} =~ "/echo") \
                /let deathmsg=$[replace("|c|", "@{Ccyan}", {deathmsg})] %; \
                /let deathmsg=$[replace("|w|", "@{Cwhite}", {deathmsg})] %; \
                /echo -pw %%% %deathmsg %; \
            /else \
                /eval %echochan %deathmsg %; \
            /endif%;\
        /endif%;\
    /endif

/def -mregexp -p0 -ag -t"^Your Gurney has moved ([A-Za-z]+) to (his|her|its) corpse." self_gurney_other = \
    /echo -pw @{Cgreen}Your Gurney has moved @{Cwhite}%P1 @{Cgreen}to %P2 corpse.%; \
    /unset autogurney%; \
    /rmdeath %P1

/def -mregexp -p0 -ag -t"^([A-Za-z]+) coalesces at ([A-Za-z]+)'s intervention\." char_gurnied = \
    /echo -pw @{Cwhite}%P1 @{Cgreen}coalesces at @{hCcyan}%{P2}'s @{nCgreen}intervention.%; \
    /unset autogurney%; \
    /rmdeath %P1
/def -mregexp -p0 -ag -t"^([A-Za-z]+)'s Gurney has moved you to your corpse\!" you_gurnied = /echo -pw @{hCcyan}%{P1}@{nCgreen}'s gurney has moved you to your corpse!@{n}


/def -mregexp -p0 -ag -t"\\[[A-Z]+ INFO\\]\: ([A-Za-z]+) casts eulogy, moving corpse of ([A-Za-z]+) to safety." char_eulogy = \
    /echo -pw @{Cred}[LORD INFO]: @{hCcyan}%P1 @{nCred}casts eulogy, moving corpse of @{hCcyan}%P2 @{nCred}to safety.%; \
    /rmdeath %P1

/def rmdeath = \
    /set deathlist=$(/remove %1 %deathlist)%;\
    /deathlist

;;; ----------------------------------------------------------------------------
;;; Lotto upgrade scripts
;;; /upg - Toggles building the upgrade list.  Note, once turned "on" it clears
;;;        the list.
;;; /upglist [chan] - display the list of upgraders.  If "chan" given, 
;;;                   displays list to "chan" (/echo -w by default).
;;; ----------------------------------------------------------------------------
/def upg = \
    /toggle upgflag%; \
    /echoflag %upgflag @{hCgreen}Upgrade List%; \
    /if ({upgflag} = 1) /unset upglist%; /endif

/def upglist = \
        /let tupglist=%upglist%; \
        /let upgcnt=0%; \
        /while ({tupglist} !~ "") \
            /let upgcnt=$[++upgcnt]%; \
            /let upgchar=$(/first %tupglist)%; \
            /let tupglist=$(/rest %tupglist)%; \
            /let upgmsg=%upgmsg %{upgcnt}-%{upgchar}.%; \
        /done%; \
        /if (({#} > 0) & ({upgmsg} !~ "")) \
            /eval %* %upgmsg%; \
        /elseif ({upgmsg} !~ "") \
            /echo -pw %%% Upgraders: @{Cyellow}%upgmsg@{n}%; \
        /endif%; \

/def -p1 -mregexp -t'([a-zA-Z]+) tell[s]* the group \'(me|ME|mE|Me)\'' upgrade_gtells = \
    /if ({P1} =~ "You") /let upgrader=%{myname}%; /else /let upgrader=%P1%;/endif%;\
    /addupg %upgrader
/def addupg = \
    /if ({upgflag} = 1) \
        /set upglist=%{upglist} %{*}%; \
        /set upglist=$(/unique %upglist)%; \
        /upglist%; \
    /endif

;;; ----------------------------------------------------------------------------
;;; Position Handling and auto sleep/wake triggers
;;; ----------------------------------------------------------------------------
/set asleep=0
/def asleep = \
    /toggle asleep%;\
    /echoflag %asleep Auto-@{hCblue}Sleep/Wake@{n}%;\
    /statusflag %asleep aSleep

/def -mregexp -t"(You sleep\.|You are already sleeping\.)" position_sleep = /set position=sleeping
/def -mregexp -t"(You stand up and face your attacker.|You wake and stand up.|You are already standing.)" position_standing = /set position=standing
/def -mregexp -t"^([a-zA-Z]+) wakes you\." position_woken = /set position=standing

/def -mregexp -t"^\*([a-zA-Z]+)\* tells the group '(Wake|wake|WAKE|WAKIE)([\.\!]*)'" leader_wake = \
    /if ({P1} =~ {leader} & {position} !~ "standing" & {asleep} = 1) \
        /if /ismacro %{myname}wake%; /then /%{myname}wake%; \
        /else \
            /send wake%;\
        /endif%;\
    /endif
/def -mregexp -t"^\*([a-zA-Z]+)\* tells the group '(sleep|SLEEP|Sleep)([\.\!]*)'" leader_sleep = \
    /if ({P1} =~ {leader} & {position} !~ "sleeping" & {asleep} = 1) \
        /if /ismacro %{myname}sleep%; /then /%{myname}sleep%; \
        /else \
            /send sleep%;\
        /endif%;\
    /endif

;;; ----------------------------------------------------------------------------
;;; Average gain reporting
;;; ----------------------------------------------------------------------------
/def agains = \
    /let gainsFile=gains-out.dat%;\
    /sys rm %gainsFile%; \
    /sys perl gains.pl %{*}%;\
    /repeat -0:0:01 1 /quote %{displaychan} '"%gainsFile"

/def mygains = /agains ${world_character} -t %{mytier} %{*}
/def mypgains = /agains ${world_character} -t %{mytier} %{*} -p %{levelGoal} -hp %{max_hp} -mana %{max_mana} -mv %{max_move} -class %{myclass}

/def -mregexp -p5 -t"^([a-zA-Z]+) drops [0-9]+ gold coins?\." leader_drop_gold = \
    /if ({P1} =~ {leader} & {autoloot} == 1) \
        /edit -c0 gear_misc_coins%;\
    /endif

; Send a note about a reboot run that has been done
/def rebootRun = \
    /if ({#} < 2) \
        /echo -pw %%% @{Cred}/rebootRun [Run Tag] [Led by]@{n}%;\
    /else \
        /send board 1=note to lord%;\
        /send note subject Reboot run: |w|%{1}|n|%;\
        /send note + Led by %{2}.%;\
        /send note send=board 7%;\
    /endif
    
