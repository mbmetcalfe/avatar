;;; ----------------------------------------------------------------------------
;;; ava-macro.tf
;;; General macroes
;;; ----------------------------------------------------------------------------
;;; Set default variables
;/set lootContainer=loot
;/set unbrandishContainer=girdle

;;; ----------------------------------------------------------------------------
;;; Macroes to abuse spellbots for heals
;;; ----------------------------------------------------------------------------
/def divme2 = \
    /let augLevel=2%;\
    /if ({#} == 1) /let augLevel=%{1}%;/endif%;\
    /send tell teacup %{augLevel}=tell kaliver d%{augLevel}=tell styrr %{augLevel}=tell duckstar div%{augLevel}=tell tarlock div%{augLevel}=tell idle div%{augLevel}%;\
    /send tell armathus div%{augLevel}=tell quempel div%{augLevel}=tell stahp div%{augLevel}=tell gobo div%{augLevel}%;\
    /send tell Aerniil div%{augLevel}=tell textual div%{augLevel}%=tell barkhound %{augLevel}
/def divme = /divme2 %{1}%;tel izar heal
/def invigme = /send tell aset invig=tell teacup invig=tell izar invig=tell duckstar invig=tell styrr invig=tell armathus invig=tell quempel invig=tell kaliver rejuv=tell idle invig=tell barkhound rejuvenate=tell textual invig=tell Aerniil INVIG

;;; ----------------------------------------------------------------------------
;;; Aliases to view some history
;;; ----------------------------------------------------------------------------
/def logtell = /log tell%;/recall -mregexp 0- tells you%;/recall -mregexp 0- You dream of%;/log off
/def loggt = /log grouptell%;/recall -w%1 -t 0- *tell* the group*%;/log off
;; /def simm = /recall -t -mregexp 0- ^([a-zA-Z\ \-\,\.]+)(\-\:|\*\*).*$
/def simm = /recall -t -mregexp 0- ^([a-zA-Z\ \-\,\.]+)\-\:.*$$
/def shost = /recall -t -mregexp 0- ^([a-zA-Z\ \-\,\.]+)\*\*.*$$
/def ssen = /recall -t -mregexp 0- ^([a-zA-Z\ \-\,\.]+)\-\-.*$$
;;/def spray = /recall -t -mregexp 0- ^([a-zA-Z\ \-\,\.]+)\>\>.*$
/def spray = /recall -t -mregexp 0- ^([a-zA-Z\ \-\,\.]+)(\>\>| prays ).*$$
/def schat = /recall -t -mregexp 0- ^([a-zA-Z\ \-\,\.\]+) [n]?chats '.*'$$
/def ssay = /recall -t -mregexp 0- ^([a-zA-Z\ \-\,\.]+) (say|ask|exclaim)[s]? '.*'$$
/def sgt = /recall -w%1 -t 0- *tell* the group*
/def sbc = /recall -w%1 -t -mregexp 0- ^\{(An Immortal|A staff member|[a-zA-Z]+)\} .*$$
/def sbuddy = /sbc %*
/def shero = /recall -w%1 -t -mregexp 0- ^([a-zA-Z\ \-\,\.]+)\>.*$$
/def slord = /recall -w%1 -t -mregexp 0- ^\\(([a-zA-Z\ \-\,\.]+)\\) .*$$
/def sgains = /recall -w%1 -t -mglob 0- *Your gain is*
/def stell = /recall -w%1 -mregexp -t 0- ^([a-zA-Z\ ]+) (tell [a-zA-Z]+|dream of|tells you|is asleep, but you tell)
/def slgchat = /recall -t -mregexp 0- ^([a-zA-Z\ \-\,\.\]+) (azure|gold|silver|team)chats '.*'$$
/def search = /recall -t -mglob 0- *%{*}*

;;; ----------------------------------------------------------------------------
;;; input history
;;; ----------------------------------------------------------------------------
/def history = /recall -qi -mregexp #0- .*
/def hist = /history %*

;;; ----------------------------------------------------------------------------
;;;Aliases
;;; ----------------------------------------------------------------------------
/alias fhog emote 's hands suddenly flare with power!
/alias fgem \
    /if ({#} == 0) /echo -pw %%% @{hCred}fgem @{xCyellow}[gem to fake drop]@{n}%;\
    /else emote leaves behind a perfect %{*}!%;\
    /endif
/alias fgem2 \
    /if ({#} == 0) /echo -pw %%% @{hCred}fgem2 @{xCyellow}[gem to fake drop]@{n}%;\
    /else emote |n|'s fleeting spirit crystallizes into a perfect %{*}!%;\
    /endif

/alias b  wear shield%;bash %1%;stand%;wear %{offhand}
/alias ba bash %1%;stand
/alias bj get blackjack %lootContainer%;wear blackjack%;blackjack %*%;rem blackjack%;put blackjack %lootContainer%;wear %unbrandish
/alias g2 config -autosplit%;get all corpse%;config +autosplit
/alias g config -autosplit%;get all %world_character%;config +autosplit
/alias ms  move%;sneak
/alias unl unlock %1%;open %1
/alias unlall unl n%;unl e%;unl s%;unl w%;unl n%;unl u%;unl d
/alias o open %1
/alias oall open n%;open e%;open s%;open w%;open n%;open u%;open d
/alias res  rescue %1
/alias qua /send get %1 %lootContainer=quaff %1
/alias cross /send get marble %lootContainer=wear marble=brandish=wear %unbrandish=put marble %lootContainer
/alias crum /send get crumple %lootContainer=recite crumple %1
/alias frag /send get fragment %lootContainer=recite fragment %1
/alias setoffhand  /set offhand %1%;/echo -w -aB -p Ok.  Offhand weapon set to %1.
/alias setwield /set wield %1%;/echo -w -aB -p Ok.  Wielded weapon set to %1.
/alias whios whois %*
/def chksev = get carved %lootContainer=get all carved=put all.small %lootContainer
/def chkscorp = get arm %lootContainer=get all arm=put arm %lootContainer=put all.scorp %lootContainer
/alias awe /send quicken %1=c awe=quicken off

/alias budzaff buddyset vikalpa%;buddylist
/alias budgene buddyset |bp|terror%;buddylist
/alias bl /send buddylist
/alias bc /send buddy %*

;;; ----------------------------------------------------------------------------
;;; Portal/nexus aliases
;;; ----------------------------------------------------------------------------
/alias eport enter portal
/alias enex enter nexus
/alias ast c astral %*
/alias nex c nexus %*
/alias port c portal %*
/alias tele c teleport %*

;;; ----------------------------------------------------------------------------
;;; mob targetting stuff
;;; ----------------------------------------------------------------------------
;/set action=kill %1
;/set leader=Self

;;; ----------------------------------------------------------------------------
;;; Auto-assist macro to toggle assistance
;;; ----------------------------------------------------------------------------
;/set autokill=0
/def assist = \
    /toggle autokill%;\
    /echoflag %autokill Auto-@{hCred}Assist@{n}%;\
    /statusflag %autokill Assist

;;; /ki used in the target triggers in targets.tf
/def ki = \
    /set targetMob=%* %; \
    /if ({autokill} == 1 & {mudLag} < 3) \
        /eval %{action} %; \
    /else \
            /echo -pw %%% @{hCgreen}Target: @{nCwhite}%*%; \
    /endif
/def -i targetthis = /eval %{action} 
/def -b'^K' assisttank = /targetthis %{targetMob}

;;; ----------------------------------------------------------------------------
;;; chase fleeing mob and kill it when you press ctrl+F
;;; ----------------------------------------------------------------------------
/def chase = \
    /toggle autochase%;\
    /echoflag %{autochase} @{hCCyan}Automatically chase fleeing mobs@{n}
/def -mregexp -F -p5 -t"has fled (east|north|west|south|up|down)\!" mob_flee = \
    /set mob_flee_dir=%{P1}%;\
    /if ({autochase} == 1) /send %{mob_flee_dir}=ki %{targetMob}%;/endif

/def -mregexp -F -p5 -t"flees (east|north|west|south|up|down) in terror!" mob_flee2 = \
    /set mob_flee_dir=%{P1}%;\
    /if ({autochase} == 1) /send %{mob_flee_dir}=ki %{targetMob}%;/endif

/def -b'^F' mob_flee_chase = /eval %{mob_flee_dir}%;/targetthis %{targetMob}

/alias ki \
    /set targetMob=%1 %; \
    /if ({leader} =~ "Self") \
        /send ki %1 %; \
    /else \
        /eval %{action} %; \
    /endif

;;; ----------------------------------------------------------------------------
;;; Group/leader defines
;;; /settrigger leader attack trigger
;;; /setaction commands to perform on leader's trigger
;;; ----------------------------------------------------------------------------
/def settrigger = \
    /if ({#}=0) /echo -pw %%% @{Cwhite}/settrigger PATTERN@{n}%;\
    /else /def -mregexp -ag -t"^%{*}" lead_kill = /ki %%P1%;\
    /endif
/def setaction = /set action=%{*} %; \
    /if ({leader} =~ "Self") \
        alias ki%;alias att %; \
        alias ki gt k %%1.:%%action %; \
        alias att gt k %%1. %; \
    /endif %; \
    /echo -w -aB -p %% Ok.  Action set to %{*}.

/def initspam = \
    /if ({1} =~ "full") /let cToggle=+%;/else /let cToggle=-%;/endif%;\
    config -battleself%;\
    config -battleother%;\
    config +battlenone%;\
    config +brief%;\
    filter %{cToggle}spellother%;\
    filter %{cToggle}objectother%;\
    filter %{cToggle}roomindiv

; Note read aliases
/alias nos note scan
/alias nca note catchup all%;board 7

; Enchant aliases
/alias ea c 'enchant armor' %1
/alias eb c 'enchant bow' %1
/alias ew c 'enchant weapon' %1

; Healing spell aliases
/alias cc c 'cure crit' %1
/alias cs c 'cure serious' %1
/alias div c divinity %1
/alias he c heal %1
/alias hii c 'heal ii' %1
/alias mcc c 'mass cure crit'
/alias mdiv c 'mass divinity'
/alias mhe c 'mass heal'
/alias rc \
    /if ({#} > 1 | {1} > 0) \
        /let _quicken=1%;\
        quicken %1%;\
        /shift%;\
    /endif%;\
    c 'remove curse' %1%;\
    /if ({_quicken} = 1) quicken off%;/endif


; Aliases for protection-type spells
/alias conc c concentrate
/alias stone c 'stone skin' %1
/alias dark c 'dark embrace' %1
/alias is c 'iron skin' %1
/alias evil c 'protection evil'
/alias good c 'protection good'
/alias har c 'holy armor' %1
/alias hau c 'holy aura' %1
/alias holies har %1 %; hau %1
/def invinc=c invincibility %1
/alias foci \
    /if ({mytier} =~ "lord" & {#}=0) /send remove all.cape%;/endif%;\
    /if ({myclass} =~ "bci" & {#}=0) sfoci%;\
    /else c foci %1%;\
    /endif%;\
    /if ({mytier} =~ "lord" & {#}=0) /send wear all.cape%;/endif
/alias forti c fortitudes %1
/alias awen c awen %1
/alias gills c 'water breath' %1
/alias enstr c 'enhanced strength' %1
/alias enshi c 'energy shield' %1
/alias reg c 'regeneration' %1
/alias sfoci \
    /if ({myclass} =~ "psi" | {myclass} =~ "mnd" | {myclass} =~ "bci") \
        c 'enhanced strength' %1%;c levitation %1%; \
        /if ({#} = 0) c 'ectoplasmic form'%; /endif %;\
    /else \
        c giant %1%;c fly %1%; \
        /if ({#} = 0) c 'pass door'%; /endif %;\
    /endif%; \
    /if ({#} = 0) \
        /if ({myclass} =~ "bci") \
            /echo -pw %%% @{Cwhite}Need to find alternative method for @{Cmagenta}stone skin@{Cwhite}, @{Cmagenta}shield@{n}%;\
        /else \
            c 'stone skin'%;\
            c 'shield'%;\
        /endif%;\
    /endif%; \
    c shield %1%;

/alias sawen \
    holies %1%;c arm %1%;c bless %1%; \
    /if ({#} = 0) \
        /if ({myclass} =~ "bci") \
            /echo -pw %%% @{Cwhite}Need to find alternative method for @{Cmagenta}protection evil@{Cwhite}/@{Cmagenta}good@{n}%;\
        /elseif ({myrace} !~ "hob" & {myclass} !~ "shf") \
            c 'protection evil'%;\
        /else \
            c 'protection good'%;\
        /endif%;\
    /endif

/alias sforti \
    c 'adrenaline pump' %1%;c anticipate %1%;c biofeedback %1%; \
    c 'calcify flesh' %1%;c 'mental barrier' %1%;c 'body brace' %1%; \
    c 'energy shield' %1%; \
    /if ({#} = 0) c displacement %; /endif

/def steel = c 'steel skeleton' %1

/def sanc = \
    /if /ismacro %{myname}sanc%; /then /%{myname}sanc%; \
    /else \
        /if (regmatch({myclass},{monType})) \
        c 'iron monk'%; \
        /else c sanctuary %; \
        /endif%; \
    /endif
/def fren = \
    /if /ismacro %{myname}fren%; /then /%{myname}fren%; \
    /else c frenzy %{1}%;\
    /endif

/def im = c 'iron monk'
/def pray = c prayer

/def sup = \
    /if ({mytier} =~ "hero") /send config +savespell%;/endif%;\
    /if ({myclass} !~ "wzd") c 'iron skin'%; /endif%; \
    c bark%;\
    c concentrate%;\
    c confidence%;\
    /if ({myclass} !~ "bci") \
        foci%; \
    /else \
        sfoci%;\
    /endif%;\
    /if ({myclass} !~ "wzd") forti%; /endif%; \
    /if ({myclass} =~ "cle" | {myclass} =~ "dru") /invinc %; \
    /elseif ({myclass} =~ "psi" | {myclass} =~ "mnd" | \
            ({myclass} =~ "bci" & {mytier} =~ "lord")) \
        /steel %; \
        c 'illusory shield'%;\
    /elseif ({myclass} =~ "mon" & {mytier} =~ "lord") \
        c consummation%; \
        c 'blind devotion'%; \
    /elseif ({myclass} =~ "mag" | {myclass} =~ "wzd") \
        c 'mystical barrier'%; \
        c 'astral shield'%; \
    /elseif ({myclass} =~ "ran" | {myclass} =~ "dru") c farsight%; \
    /endif%; \
    /if ({myclass} =~ "prs") \
        c aegis%; \
    /elseif ({myclass} =~ "bci") \
        sawen%;\
    /else \
        c awen%;\
    /endif %; \
    /if ({myclass} =~ "cle" | {myclass} =~ "dru" | {myclass} =~ "ran" | \
         {myclass} =~ "mon" | {myclass} =~ "prs" | {myclass} =~ "wzd" ) \
        c acumen%; \
    /endif%; \
    /if ({myclass} =~ "psi" | {myclass} =~ "mag" | {myclass} =~ "asn" | \
         {myclass} =~ "ran" | {myclass} =~ "wzd" | {myclass} =~ "mnd" | \
         {myclass} =~ "sor") \
        c savvy%; \
    /endif%;\
    /if ({myclass} =~ "bci") c nightcloak%;/endif%;\
    gills

/def sup2 = \
    /echo -pw %%% @{hCwhite}Don't forget to Sanc!@{n}%; \
    /if ({mytier} =~ "hero") /send config +savespell%;/endif%;\
    bark%;c conc%;foci%;\
    /if ({myclass} !~ "wzd") is%;forti%; /endif%; \
    /if ({myclass} =~ "prs") c aegis%; \
    /elseif ({myclass} !~ "sor") sawen%; \
    /else c 'protection good'%;\
    /endif%; \
    /if ({myclass} =~ "cle" | {myclass} =~ "dru") /invinc %; \
    /elseif (({myclass} =~ "psi" | {myclass} =~ "mnd") | \
             ({myclass} =~ "bci" & {mytier} =~ "lord")) \
        /steel %; \
        /if ({myclass} !~ "bci") \
            c 'illusory shield'%;\
        /endif%;\
    /elseif ({myclass} =~ "mon" & {mytier} =~ "lord") \
        c consummation%; \
        c 'blind devotion'%; \
    /elseif ({myclass} =~ "mag" | {myclass} =~ "wzd" | {myclass} =~ "sor") \
        c 'mystical barrier'%; \
        /if ({myclass} !~ "sor") \
            c 'astral shield'%;\
            c 'death shroud'%;\
        /endif%; \
    /elseif ({myclass} =~ "ran") c farsight%;\
    /elseif ({myclass} =~ "bci") c nightcloak%;\
    /endif%; \
    /if ({myclass} =~ "cle" | {myclass} =~ "dru" | {myclass} =~ "ran" | \
         {myclass} =~ "mon" | {myclass} =~ "prs") \
        c acumen%; \
    /endif%; \
    /if ({myclass} =~ "psi" | {myclass} =~ "mag" | {myclass} =~ "asn" | \
         {myclass} =~ "ran" | {myclass} =~ "wzd" | {myclass} =~ "mnd" | \
         {myclass} =~ "sor") \
        c savvy%; \
    /endif%;\
    gills

/def sepsup = \
    /echo -pw %%% @{hCwhite}Don't forget to Sanc!@{n}%; \
    /if ({myrace} !~ "tua" & {myrace} !~ "liz") gills%; /endif %; \
    /if ({myclass} !~ "wzd") is%;sforti%; /endif%; \
    bark%;conc%;c confidence%;sfoci%;awen%;\
    /if ({myclass} =~ "cle" | {myclass} =~ "prs" | {myclass} =~ "dru") /invinc %; \
    /elseif ({myclass} =~ "psi" | {myclass} =~ "mnd") /steel %; \
    /elseif ({myclass} =~ "mon" & {mytier} =~ "lord") \
        c consummation%; \
        c 'blind devotion'%; \
    /elseif ({myclass} =~ "mag" | {myclass} =~ "wzd") \
        c 'mystical barrier'%; \
        c 'astral shield'%; \
    /elseif ({myclass} =~ "ran") c farsight%; \
    /endif%; \
    /if ({myclass} =~ "cle" | {myclass} =~ "dru" | {myclass} =~ "ran" | \
         {myclass} =~ "mon" | {myclass} =~ "prs") \
        c acumen%; \
    /endif%; \
    /if ({myclass} =~ "psi" | {myclass} =~ "mag" | {myclass} =~ "asn" | \
         {myclass} =~ "ran" | {myclass} =~ "wzd" | {myclass} =~ "mnd" | \
         {myclass} =~ "sor") \
        c savvy%; \
    /endif

/def -i osup_tell = \
    /let spellupmsg=Spellup will include:%;\
    /if (${world_character}=~"JeKyll") \
        /let spellupmsg=%{spellupmsg} |w|Confidence|n|, |y|Barkskin|n|,%;\
    /endif%;\
    /if ({mytier}=~"lord") \
        /let spellupmsg=%{spellupmsg} |w|Iron Skin|n|,%;\
    /endif%;\
    /let spellupmsg=%{spellupmsg} |b|Water Breathing|n|,%;\
    /if ({myclass}=~"cle" | {myclass}=~"prs" | {myclass} =~ "dru") \
        /let spellupmsg=%{spellupmsg} |bw|Invincibility|n|,%;\
    /elseif ({myclass} =~ "psi" | {myclass} =~ "mnd") \
        /let spellupmsg=%{spellupmsg} |w|Steel Skeleton|n|,%;\
    /endif%;\
    /let spellupmsg=%{spellupmsg} |g|Foci|n|, |y|Fortitudes|n|,%;\
    /if ({myclass} =~ "prs") \
        /let spellupmsg=%{spellupmsg} |r|Aegis|n|, |bw|Sanctuary|n|,%;\
    /else \
        /let spellupmsg=%{spellupmsg} |r|Awen|n|,%;\
    /endif%;\
    /if ({myclass} =~ "mag") /let spellupmsg=%{spellupmsg} |y|astral shield|n|,%; /endif%; \
    /if ({myclass} =~ "cle" | {myclass} =~ "prs" | {myclass} =~ "dru") /let spellupmsg=%{spellupmsg} |w|Holy Sight|n|%; /endif%;\
    /def -mregexp -ag -p9 -n1 -t"^You tell %{1} '.*'" _tell_osup%;\
    tell %1 %{spellupmsg}
    
/def -i osup2_tell = \
    /let spellupmsg=Spellup will include:%;\
    /if (${world_character}=~"JeKyll") \
        /let spellupmsg=%{spellupmsg} |w|Confidence|n|, |y|Barkskin|n|,%;\
    /endif%;\
    /if ({mytier}=~"lord") \
        /let spellupmsg=%{spellupmsg} |w|Iron Skin|n|,%;\
    /endif%;\
    /let spellupmsg=%{spellupmsg} |b|Water Breathing|n|,%;\
    /if ({myclass}=~"cle" | {myclass}=~"prs" | {myclass} =~ "dru") \
        /let spellupmsg=%{spellupmsg} |bw|Invincibility|n|,%;\
    /elseif ({myclass} =~ "psi" | {myclass} =~ "mnd") \
        /let spellupmsg=%{spellupmsg} |w|Steel Skeleton|n|,%;\
    /endif%;\
    /let spellupmsg=%{spellupmsg} |g|Foci|n|, |y|Fortitudes|n|,%;\
    /if ({myclass} =~ "prs") \
        /let spellupmsg=%{spellupmsg} |r|Aegis|n|, |bw|Sanctuary|n|,%;\
    /else \
        /let spellupmsg=%{spellupmsg} |r|Split Awen |bk|(No Frenzy)|n|, |bw|Sanctuary|n|,%;\
    /endif%;\
    /if ({myclass} =~ "mag") /let spellupmsg=%{spellupmsg} |y|astral shield|n|,%; /endif%; \
    /if ({myclass} =~ "cle" | {myclass} =~ "prs" | {myclass} =~ "dru") /let spellupmsg=%{spellupmsg} |w|Holy Sight|n|%; /endif%;\
    /def -mregexp -ag -p9 -n1 -t"^You tell %{1} '.*'" _tell_osup2%;\
    tell %1 %{spellupmsg}

/def osup = \
    /if ({position} =~ "sleeping") /send wake%;/endif%;\
;    /osup_tell %1%;\
    quicken 3%;\
    /if ({mytier} =/ "lord" | ({myclass} =~ "psi" | {myclass} =~ "mnd")) \
        is %1%;\
    /endif%;\
    /if (${world_character}=~"JeKyll") c confidence %1%;/endif%;\
    c bark %1%;\
    /if ({myclass} =~ "cle" | {myclass} =~ "dru") /invinc %1 %; \
    /elseif ({myclass} =~ "psi" | {myclass} =~ "mnd") /steel %1 %; \
    /endif%; \
    quicken off%; \
    c foci %1%;c forti %1%; \
    /if ({myclass} =~ "prs") c aegis %1%; c sanctuary %1%; \
    /else c awen %1%; \
    /endif%; \
    /if ({myclass} =~ "mag") c 'astral shield' %1%; /endif%; \
    /q 3 gills %1%;\
    /if ({myclass} =~ "cle" | {myclass} =~ "prs" | {myclass} =~ "dru") c 'holy sight' %1%; /endif%;\
;    tell %1 Spellup complete.%;\
    /if ({position} =~ "sleeping") /send sleep%;/endif

/def osup2 = \
    /if ({position} =~ "sleeping") /send wake%;/endif%;\
;    /osup2_tell %1%;\
    quicken 3%;\
    /if ({mytier} =/ "lord" | ({myclass} =~ "psi" | {myclass} =~ "mnd")) \
        is %1%;\
    /endif%;\
    /if (${world_character}=~"JeKyll") c confidence %1%;/endif%;\
    c bark %1%;\
    /if ({myclass} =~ "cle" | {myclass} =~ "dru") /invinc %1%;\
    /elseif ({myclass} =~ "psi" | {myclass} =~ "mnd") /steel %1%;\
    /endif %; \
    quicken off%; \
    foci %1%; forti %1%; \
    /if ({myclass} =~ "prs") c aegis %1%; \
    /else quicken 3%;sawen %1%;quicken off%; \
    /endif %; \
    /if ({myclass} =~ "mag") c 'astral shield' %1%; /endif%; \
    /q 3 gills %1%;\
    c sanc %1%; \
    /if ({myclass} =~ "cle" | {myclass} =~ "prs" | {myclass} =~ "dru") c 'holy sight' %1%; /endif%;\
;    tell %1 Spellup complete.%;\
    /if ({position} =~ "sleeping") /send sleep%;/endif

; Offensive attack spell aliases
/alias ult c ultrablast %1
/alias pb c 'psionic blast' %1
/alias dm c 'dispel magic' %1
/alias ice c 'ice lance' %1
/alias danc c 'dancing weapon'
/alias mae c maelstrom %1
/alias cata c cataclysm
/alias disin c disint %1
/alias desi c desiccate %1

; Miscellaneous spell aliases
/alias far c 'farsight'

;;; ----------------------------------------------------------------------------
;;; Follow XX into portals/nexuses/etc
;;; ----------------------------------------------------------------------------
/def fport = \
    /toggle folport%;\
    /if ({folport} == 0) \
        /statusflag %{folport} f_%{followPorter}%;\
        /undef folleadport folleadsanct folleaddrink folleadrecall folleadtrickle folleaddrinkfountain%;\
        /undef folleadquaff folleadpentagram folleadshizaga folleadwerredan folleadsunlight folleaddarkpatch%;\
        /undef folleaddimtunnel folleadmemlane folleadmaelstrom folleadvortex folleadshimmeringmirror%;\
        /echo -pw %%% @{Cred}No longer automatically entering portals, etc.@{n}%;\
    /else \
        /set followPorter=%{1}%;\
        /statusflag %{folport} f_%{followPorter}%;\
        /def -mregexp -p1 -t"^%{followPorter} enters [a|an|the]+ ([a-z ]+)." folleadport = \
            /if ({folport} == 1) /send enter "%%P1"%%;/endif%;\
        /def -mregexp -p3 -t"^%{followPorter} enters a silver pentagram." folleadpentagram = \
            /if ({folport} == 1) /send enter pentagram%%;/endif%;\
        /def -mglob -t"%{followPorter} utters the word \'Sanctum\' and slowly fades from view\." folleadsanct = \
            /if ({folport} == 1 & {running}==1) /send recall set=sanctum=down=west%%;/endif%;\
        /def -mregexp -t"^%{followPorter} recalls\!" folleadrecall = \
            /if ({folport} == 1) /send recall%%;/endif%;\
        /def -p3 -mregexp -p0 -t"^%{followPorter} drinks ([a-zA-Z\ ]+) from (a fountain of the fates|a fountain of escape)\." folleaddrinkfountain = \
            /if ({folport} == 1) /send drink%%;/endif%;\
        /def -p2 -mregexp -p2 -t"^%{followPorter} drinks water from \." folleadtrickle = \
            /if ({folport} == 1) /send drink trickle%%;/endif%;\
        /def -p1 -mregexp -p1 -t"^%{followPorter} drinks ([a-zA-Z\ ]+) from .*\." folleaddrink = \
            /if ({folport} == 1) /send drink%%;/endif%;\
        /def -p2 -mregexp -p2 -t"^%{followPorter} drinks blood from a fountain of bile\." folleadquaff = \
            /if ({folport} == 1) /send quaff%%;/endif%;\
        /def -p3 -mregexp -t"^%{followPorter} enters the symbol of Shizaga." folleadshizaga = \
            /if ({folport} == 1) /send enter shizaga%%;/endif%;\
        /def -p3 -mregexp -t"^%{followPorter} enters the symbol of Werredan." folleadwerredan = \
            /if ({folport} == 1) /send enter werredan%%;/endif%;\
        /def -p3 -mregexp -t"^%{followPorter} enters a beam of sunlight." folleadsunlight = \
            /if ({folport} == 1) /send enter beam%%;/endif%;\
        /def -p3 -mregexp -t"^%{followPorter} enters a dark patch." folleaddarkpatch = \
            /if ({folport} == 1) /send enter patch%%;/endif%;\
        /def -p3 -mregexp -t"^%{followPorter} enters a dimly lit tunnel." folleaddimtunnel = \
            /if ({folport} == 1) /send enter passage%%;/endif%;\
        /def -p3 -mregexp -t"^%{followPorter} gives the fae rune for 'Hope' to the Memory of Kisestre." folleadmemlane = \
            /if ({folport} == 1) /send give hope good%%;/endif%;\
        /def -p3 -mregexp -t"^The swirling water sucks %{followPorter} away\!" folleadmaelstrom = \
            /if ({folport} == 1) /send enter maelstrom%%;/endif%;\
        /def -p3 -mregexp -t"^%{followPorter} enters a screaming vortex." folleadvortex = \
            /if ({folport} == 1) /send enter vortex%%;/endif%;\
        /def -p3 -mregexp -t"^%{followPorter} enters a shimmering mirror." folleadshimmeringmirror = \
            /if ({folport} == 1) /send enter mirror%%;/endif%;\
        /echo -pw %%% @{Cred}Will enter portals, recall, etc after @{hCYellow}%{followPorter}.@{n}%;\
    /endif

/def fshift = \
    /toggle folshift%;\
    /if ({folshift} == 0) \
        /statusflag %{folshift} s_%{followShifter}%;\
        /undef folleadhomeshift folleadplaneshift%;\
        /if /ismacro folleadhomeshift_fizz%; /then /undef folleadhomeshift_fizz%; /endif%;\
        /echo -pw %%% @{Cred}No longer automatically shifting to Thorngate.@{n}%;\
    /else \
        /set followShifter=%{1}%;\
        /statusflag %{folshift} s_%{followShifter}%;\
        /def -p99 -F -mregexp -t"^%{followShifter} utters the words, 'homeshift'" folleadhomeshift = \
            /if ({folshift} = 1) \
                /def -p99 -mregexp -n1 -t"Your spell fizzles\.\.\." folleadhomeshift_fizz = /send c planeshift thorngate=recall=e=e=sleep%%;\
                /send c homeshift=recall=e=e=sleep%%;\
            /endif%;\
        /def -p99 -F -mregexp -t"^%{followShifter} utters the words, 'planeshift'" folleadplaneshift = \
            /if ({folshift} = 1) \
                /send c planeshift thorngate=recall=e=e=sleep%%;\
            /endif%;\
        /echo -pw %%% @{Cred}Will Homeshift after @{hCYellow}%{followShifter}.@{n}%;\
    /endif

;;; ----------------------------------------------------------------------------
;;; Brandish stuff
;;; ----------------------------------------------------------------------------
;/set branLeft=0
/def -i setBranLeft = \
    /set branLeft %1%;\
    /set displayBranLeft=$[substr({brandish}, 0, 3)]:%{branLeft}

/def status_add_brandish = /status_add -x -BdisplayTNL displayBranLeft:8
/def status_rm_brandish = /status_rm displayBranLeft

/def bra = \
    get %brandish %{main_bag}%;remove %unbrandish%;wear %brandish%;brandish%;rem %brandish%;wear %unbrandish%; \
    /setBranLeft $[--branLeft]%; \
    /if ({branLeft} > 1) \
        put %brandish %{main_bag} %; \
    /else \
        /send get %{rechargeContainer} %{main_bag}=put %brandish %{rechargeContainer}=put %{rechargeContainer} %{main_bag}%; \
        /echo -pw %% @{hCwhite}%brandish @{hCred}needs to be recharged.  Placing it in @{hCwhite}%{rechargeContainer}@{n} %; \
        /if ({currentPosition} =~ "stand") /idbran%;\
        /else /aq /idbran%;\
        /endif%;\
    /endif

/def setbrandish = \
    /if ({#}=0) \
        /set brandish=%;\
        /setBranLeft 0%;\
        /status_rm_brandish%;\
    /endif%;\
    /if ({#}>=1) \
        /set brandish=%1%;\
        /let _brandleft=0%;\
        /if ({#}>=2) /let _brandleft=%2%;/endif%;\
        /setBranLeft %_brandleft%;\
        /status_add_brandish%;\
    /endif%;\
    /if ({#}=3) /set rechargeContainer=%3%;/endif%;\
    /branleft
 
/def branleft = \
    /if ({brandish} !~ "") \
        /echo -pw %% @{hCred}There are @{hCwhite}%branLeft @{hCred}brandishes left on @{hCwhite}%brandish@{hCred}.@{n}%;\
    /else \
        /echo -pw @{hCred}No brandish currently configured.@{n}%;\
    /endif

/def idbran = /setBranLeft 0%;get %brandish %{main_bag}%;c ident %brandish%;put %brandish %{main_bag}

; Spell mods: surge/quicken/augment
/alias surg surge %1%;%2 %3%;surge off
/alias quick quicken %1%;%2 %3%;quicken off
/alias aug augment %1%;%2 %3%;augment off 
; shorter versions
/def q = \
    /let spellPower=$(/first %{*})%; \
    /let spellCmd=$(/rest %{*})%; \
    quicken %spellPower%; \
    /eval %spellCmd%; \
    quicken off
/def a = \
    /let spellPower=$(/first %{*})%; \
    /let spellCmd=$(/rest %{*})%; \
    augment %spellPower%; \
    /eval %spellCmd%; \
    augment off
/def s = \
    /let spellPower=$(/first %{*})%; \
    /let spellCmd=$(/rest %{*})%; \
    surge %spellPower%; \
    /eval %spellCmd%; \
    surge off

;;; ----------------------------------------------------------------------------
;;; Echo if a variable is on or not with a message.
;;; /echoflag <variable> <message>
;;;    will display as follows: 
;;;        %%% <message> is ON|OFF
;;; ----------------------------------------------------------------------------
/def echoflag = \
    /let flag=$(/first %*)%;\
    /let msg=$(/rest %*)%;\
    /if ({flag} = 1) \
        /let msg=%msg is @{Cgreen}ON@{n}.%;\
    /else \
        /let msg=%msg is @{Cred}OFF@{n}.%;\
    /endif %; \
    /echo -pw %%% %msg

;;; ----------------------------------------------------------------------------
;;; Add/remove a toggle to the status bar
;;; /statusflag <toggle> <message>
;;; if <toggle> is 1, <message> gets added to the status bar
;;; if <toggle> is 0, the status bar message is removed
;;; ----------------------------------------------------------------------------
/def statusflag = \
    /let flag=$(/first %*)%;\
    /let msg=$(/rest %*)%;\
    /if ({flag} == 1) \
        /let _msgLen=$[strlen({msg})]%;\
        /set display%{msg}=%{msg}%;\
        /status_add -x -r1 -A display%{msg}:%{_msgLen}:Cgreen%;\
    /else \
        /status_rm display%{msg}%;\
        /unset display%{msg}%;\
    /endif

;;; ----------------------------------------------------------------------------
;;; Add/remove a toggle to the status bar
;;; /statusflag <toggle> <colour> <message>
;;; if <toggle> is 1, <message> gets added to the status bar
;;; if <toggle> is 0, the status bar message is removed
;;; ----------------------------------------------------------------------------
/def statusflagcolour = \
    /let flag=$(/first %*)%;\
    /let colour=$(/cadr %*)%;\
    /let msg=$(/cddr %*)%;\
    /if ({flag} == 1) \
        /let _msgLen=$[strlen({msg})]%;\
        /set display%{msg}=%{msg}%;\
        /status_add -x -r1 -A display%{msg}:%{_msgLen}:%{colour}%;\
    /else \
        /status_rm display%{msg}%;\
        /unset display%{msg}%;\
    /endif

;; Auto-sac corpses
;/set autosac=0
/def autosac = /toggle autosac %; /echoflag %autosac Auto-@{Cred}Sac@{n}

;;; ----------------------------------------------------------------------------
;;; regen reporting
;;; ----------------------------------------------------------------------------
/def clrregen = /unset last_hp %; /unset last_mana %; /unset last_move
/def sregen = \
    /let sregenchan=/echo%; \
    /if ({#} > 0) /let sregenchan=%*%; /endif %;\
    /let sregenmsg=|g|Regen Rate|w|: |r|%hpRegen|w| hp |y|%manaRegen|w| mana |g|%moveRegen|w| moves.%; \
    /if ({sregenchan} =~ "/echo") \
        /let sregenmsg=$[replace("|w|", "@{nCwhite}", {sregenmsg})] %;\
        /let sregenmsg=$[replace("|g|", "@{nCgreen}", {sregenmsg})] %;\
        /let sregenmsg=$[replace("|r|", "@{nCred}", {sregenmsg})] %;\
        /let sregenmsg=$[replace("|y|", "@{nCyellow}", {sregenmsg})] %;\
        /echo -pw %%% %sregenmsg%; \
    /else /eval %sregenchan %sregenmsg%; \
    /endif

/def toregen = \
    /let toregenchan=/echo%; \
    /if ({#} > 0) /let toregenchan=%*%; /endif %;\
    /let toregenmsg=|g|Tics to regen|w|: |r|$[({max_hp}-{curr_hp})/{hpRegen}]|w| hp  |y|%$[({max_mana}-{curr_mana})/{manaRegen}]|w| mana |g|$[({max_move}-{curr_move})/{moveRegen}]|w| moves.%; \
    /if ({toregenchan} =~ "/echo") \
        /let toregenmsg=$[replace("|w|", "@{nCwhite}", {toregenmsg})] %;\
        /let toregenmsg=$[replace("|g|", "@{nCgreen}", {toregenmsg})] %;\
        /let toregenmsg=$[replace("|r|", "@{nCred}", {toregenmsg})] %;\
        /let toregenmsg=$[replace("|y|", "@{nCyellow}", {toregenmsg})] %;\
        /echo -pw %%% %toregenmsg%; \
    /else /eval %toregenchan %toregenmsg%; \
    /endif

;;; ----------------------------------------------------------------------------
;;; Psion weapon grabbing scripts
;;; /chkpsi || psi to toggle grabbing automatically
;;; /psikey [char] to display weapon keys in gtell
;;; /psikeys to display weapon keys for all psions in group
;;; note: for /psikeys to work, you must first tally grouplist "/glast"
;;; F12 to pick up manually
;;; ----------------------------------------------------------------------------
/alias psi /chkpsis
/def psikey = \
    /if ($(/listvar -vmglob psi_%1) !~ "") \
        /eval gtell Weapon keys for |bc|%1|w|: |bw|$(/listvar -vmglob psi_%1)%; \
    /endif
/def psikeys = /mapcar /psikey %grouplist

;;; F12 key is bound to get weapons for psis in group.
;/def -ib'^[[24~' chkpsis = /chkpsiweaps %grouplist
/def chkpsis = /chkpsiweaps %grouplist
/def key_f12 = /chkpsiweaps %grouplist
/def getpsiweaps = \
    /set psicasting=%1 %; \
    /if ({psicasting} !~ {myname}) \
        /while ({#} - 1) \
            /send get %2=give %2 %{psicasting} %; \
            /shift %; \
        /done%; \
    /endif
/def chkpsiweaps = \
        /while ({#}) \
            /if ($(/listvar -vmglob psi_%1) !~ "") \
                /getpsiweaps $[substr($(/listvar -smglob psi_%1),4)] $(/listvar -vmglob psi_%1) %; \
            /endif %; \
            /shift %; \
        /done

/def psi = /toggle psichk%;/echoflag %psichk Get Psionicist Weapons
/def -mglob -F -p6 -t"*has fled*" flee_chkpsis = /chkpsis

;;; ----------------------------------------------------------------------------
;;; Misc macroes
;;; ----------------------------------------------------------------------------
/alias last /while ({#}) /send last %1 %; /shift %; /done
/alias whois \
    /def -ag -mglob -n2 -t"*Ok, your prompt is now set to *\." gag_prompt_config%; \
    config -prompt%;\
    /while ({#}) /send whois %1 %; /shift %; /done%; \
    config +prompt

/def noidle = save%;/repeat -0:01:35 1 /noidle

/def eq = \
    /if ({#} = 0) /send config +condition=eq=inv=config -condition%; \
    /else /send look %* eq%; \
    /endif
/alias eq \
    /if ({#} > 0) /eq %*%; \
    /else /send eq%; \
    /endif

;; level gear donning/removing
/def lvl = \
    /if /ismacro %{myname}lvl%; /then /%{myname}lvl%; \
    /else /send lvl%; \
    /endif%;\
    /def -n1 -mregexp -ag -p2 -t"You need [0-9]+ experience to level and have ([0-9]+) practices\." runstart_worth_pracs = /set max_prac=%%P1%;\
    /def -n1 -ag -mglob -p5 -t"You have * gold coins in hand and * gold coins in the bank\." runstart_gold%;\
    /send worth

/def unlvl = \
    /if /ismacro %{myname}unlvl%; /then /%{myname}unlvl%; \
    /else /send unlvl%; \
    /endif

;;; ----------------------------------------------------------------------------
;; A macro to swap game color codes |xx| to tf color codes.
;; Use it as follows:
;; /set mymsg=$(/chgcolor %{mymsg})
;;; ----------------------------------------------------------------------------
/def chgcolor = \
    /let inmsg=%{*}%; \
    /let outmsg=$[replace("|k|", "@{nCblack}", {inmsg})] %; \
    /let outmsg=$[replace("|b|", "@{nCblue}", {outmsg})] %; \
    /let outmsg=$[replace("|c|", "@{nCcyan}", {outmsg})] %; \
    /let outmsg=$[replace("|g|", "@{nCgreen}", {outmsg})] %; \
    /let outmsg=$[replace("|r|", "@{nCred}", {outmsg})] %; \
    /let outmsg=$[replace("|y|", "@{nCyellow}", {outmsg})] %; \
    /let outmsg=$[replace("|w|", "@{nCwhite}", {outmsg})] %; \
    /let outmsg=$[replace("|p|", "@{nCmagenta}", {outmsg})] %; \
    /let outmsg=$[replace("|n|", "@{n}", {outmsg})] %; \
    /let outmsg=$[replace("|bk|", "@{hCblack}", {outmsg})] %; \
    /let outmsg=$[replace("|bb|", "@{hCblue}", {outmsg})] %; \
    /let outmsg=$[replace("|bc|", "@{hCcyan}", {outmsg})] %; \
    /let outmsg=$[replace("|bg|", "@{hCgreen}", {outmsg})] %; \
    /let outmsg=$[replace("|br|", "@{hCred}", {outmsg})] %; \
    /let outmsg=$[replace("|by|", "@{hCyellow}", {outmsg})] %; \
    /let outmsg=$[replace("|bw|", "@{hCwhite}", {outmsg})] %; \
    /let outmsg=$[replace("|bp|", "@{hCmagenta}", {outmsg})] %; \
    /echo -pw %outmsg

;; macro to set up avatar config defaults
/def avadef = /send config +brief=config -battleself=config -battlenone=config -battleother=config -autosplit

;;; ----------------------------------------------------------------------------
;;; /togo - will display # of levels and experience until levelGoal is reached.
;;; ----------------------------------------------------------------------------
/set levelGoal=999
/def togo = \
    /let _togoChan=/echo%;\
    /if ({#}>0) /let _togoChan=%{*}%;/endif%;\
    /let _togoMsg=|g|$[({levelGoal} - {mylevel})] |w|levels to go (|g|$[({levelGoal} - {mylevel})*{myTnl} - ({myTnl} - {tnl})] |w|experience) until level |g|%{levelGoal}|n|%;\
    /if ({_togoChan} =~ "/echo") \
        /chgcolor %{_togoMsg}%;\
    /else \
        /eval %{_togoChan} %{_togoMsg}%; \
    /endif

/def rtogo = \
    /let _togoChan=/echo%;\
    /if ({#}>0) /let _togoChan=%{*}%;/endif%;\
    /let togoExp=$[({levelGoal} - {mylevel})*{myTnl} - ({myTnl} - {tnl})]%;\
    /let _togoMsg=|g|$[({levelGoal} - {mylevel})] |w|levels to go (|g|%{togoExp} |w|exp|w|, |g|$[{togoExp}/{xp}] |w|runs @ |g|%{xp} |w|exp/run|w|) until level |g|%{levelGoal}|n|%;\
    /unset togoExp%;\
    /if ({_togoChan} =~ "/echo") \
        /chgcolor %{_togoMsg}%;\
    /else \
        /eval %{_togoChan} %{_togoMsg}%; \
    /endif

/def dtogo = \
    /let _togoChan=/echo%;\
    /if ({#}>0) /let _togoChan=%{*}%;/endif%;\
    /let togoExp=$[({levelGoal} - {mylevel})*{myTnl} - ({myTnl} - {tnl})]%;\
    /let _togoMsg=|g|$[({levelGoal} - {mylevel})] |w|levels to go (|g|%{togoExp} |w|exp|w|, |g|$[{togoExp}/{totxp}] |w|days @ |g|%{totxp} |w|exp/day|w|) until level |g|%{levelGoal}|n|%;\
    /unset togoExp%;\
    /if ({_togoChan} =~ "/echo") \
        /chgcolor %{_togoMsg}%;\
    /else \
        /eval %{_togoChan} %{_togoMsg}%; \
    /endif

;;; ----------------------------------------------------------------------------
;; Show some status on the currently logged in character
;;; ----------------------------------------------------------------------------
/def whoami = \
    /let extraMsg=%;\
    /if ({autocast}=1) /let extraMsg=@{nCred}Cast@{nCcyan}.%;/endif%;\
    /if ({running}=1) /let extraMsg=%{extraMsg} @{nCcyan}Running@{nCcyan}.%;/endif%;\
    /if ({drone}=1) /let extraMsg=%{extraMsg} @{hCyellow}Drone@{nCcyan}.%;/endif%;\
    /if ({autoheal}=1) /let extraMsg=%{extraMsg} @{hCwhite}Healing@{nCcyan}.%;/endif%;\
    /if ({asleep}=1) /let extraMsg=%{extraMsg} @{hCblue}Sleeping@{nCcyan}.%;/endif%;\
    /if ({autobrandish}=1) /let extraMsg=%{extraMsg} @{nCWhite}Brandishing@{nCcyan}.%;/endif%;\
    /if ({atarg}=1) /let extraMsg=%{extraMsg} @{nCyellow}Targetting@{nCcyan}.%;/endif%;\
    /let tTier=$[strcat(toupper(substr(mytier, 0, 1)), substr(mytier, 1))]%;\
    /let tClass=$[strcat(toupper(substr(myclass, 0, 1)), substr(myclass, 1))]%;\
    /let tRace=$[strcat(toupper(substr(myrace, 0, 1)), substr(myrace, 1))]%;\
    /let tName=$[strcat(toupper(substr(myname, 0, 1)), substr(myname, 1))]%;\
    /echo -pw @{Ccyan}[%{mylevel} %{tTier} %{tClass} %{tRace}] %{tName}: %{extraMsg}@{n}

;; tag stuff
/def jekalttag = /send tag remove jekyll=tag set Jekyll |w|Alt of |r|Jekyll|w|.

;;; ----------------------------------------------------------------------------
;;; Keybindings
;;; ----------------------------------------------------------------------------
/def -b'^P' key_prev_hx = /dokey recallb
/def -b'^N' key_next_hx = /dokey recallf
;/dokey_wright
;/dokey_wleft

;;;
;; Used echo information about a skin item.
;; skinInfo(<mob>, <skins to item>)
;; skinInfo(<mob>, <skins to item>, <skinned item goes to>)
/def skinInfo = \
    /if ({#} == 2) \
        /echo -pw @{hCMagenta}[SKIN INFO]: Skin @{hCwhite}%{1} @{hCMagenta}to get @{hCwhite}%{2}@{hCMagenta}.@{n}%;\
    /elseif ({#} == 3) \
        /echo -pw @{hCMagenta}[SKIN INFO]: Skin @{hCwhite}%{1} @{hCMagenta}to get @{hCwhite}%{2}@{hCMagenta} for @{hCwhite}%{3}.@{n}%;\
    /endif

;; macro used for displaying quest info in a consistent manner.
/def questinfo = /echo -pw @{Cred}[QUEST INFO]: %{*}
