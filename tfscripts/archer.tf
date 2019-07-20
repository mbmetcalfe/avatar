;;; ----------------------------------------------------------------------------
;;; archer.tf
;;; Archer triggers
;;; ----------------------------------------------------------------------------
;;; Mark this file as already loaded, for /require.
/loaded __TFSCRIPTS__/archer.tf

/alias xbow \
    get "%{boltType} bolt" %{quiver_bag}%;\
    wield %{arc_xbow}%;\
    wear "%{boltType} bolt"%;\
    /set xbowon=1

/alias bow \
    wield %{arc_wield}%;\
    wear %{unbrandish}%;\
    put all.bolt %{quiver_bag}%;\
    /set xbowon=0

/def swap = \
    /let arrowType=%{1}%;\
    /let braceType=arrow%;\
    /if ({myclass} =~ "fus") /let braceType=stone%;/endif%;\
    get "%{arrowType} %{braceType}" %{quiver_bag}%;\
    wear "%{arrowType} %{braceType}"%;\
    get "all.%{arrowType} %{braceType}" %quiver_bag%;\
    put all.%{braceType} %quiver_bag%;\
    /set unbrandish=%{arrowType} %{braceType}

/def -p0 -mregexp -t"([a-zA-Z\*]+) tells the group '(.*) arrows?'" drone_arrow_swap = \
    /let arrowType=%{P2}%;\
    /if (regmatch({myclass},{arcType})) /swap %{arrowType}%;/endif
/def -p0 -mregexp -t"([a-zA-Z\*]+) tells the group 'arrows?'" drone_reequip_arrows = \
    /if (regmatch({myclass},{arcType})) \
        /send get "%{unbrandish}" %{quiver_bag}=wear "%{unbrandish}"%;\
    /endif

/def -mregexp -p4 -t'([a-zA-Z0-9\' ]*) has fled (north|south|east|west|up|down)!' lstrig = \
    /let _fleeDir=%{P2}%;\
    /if ({myclass} =~ "asn" & {mylevel}>=250 & {autols} = 1) \
        snipe %{_fleeDir} %targetMob knee%;\
    /elseif ((regmatch({myclass},{arcType})) & {autols} = 1) \
        ls %{_fleeDir} %targetMob %; \
    /endif

/def -mregexp -t"^\*?([a-zA-Z]+)\*? tells the group '(snipe|ls) ([a-zA-Z]+) ([a-zA-Z0-9\.]+)'$" gtlstrig = \
    /let _leader=%{P1}%;\
    /let tAction=%{P2}%;\
    /let mobDir=%{P3}%;\
    /let longshotMob=%{P4}%;\
    /if ((regmatch({myclass},{arcType})) & {autols} = 1 & {_leader} =~ {leader}) \
        %{tAction} %{mobDir} %{longshotMob} %{avs_spot}%;\
    /endif

/def -mregexp -t'A brace of ([a-zA-Z ]+) (bolt|arrow|sling stone)s (is here|are la?ying on the ground)\.' grabarrowtrig = \
    /let arrowType=%{P2}%;\
    /if (({autoloot}=1) & (regmatch({myclass},{arcType}))) \
        /send get "%{arrowType}"%;\
    /endif

/def -mregexp -t'^You fire at ([a-zA-Z\.\-\,\' ]+) and miss!' miss1trig = \
    /if (({autoloot}=1) & (regmatch({myclass},{arcType}))) \
        /addq get all.brace%;\
    /endif

;;; ----------------------------------------------------------------------------
;;; Learning triggers
;;; ----------------------------------------------------------------------------
/def -mglob -ah -t'Your knowledge of * has improved\!' fletchknowledge

;;; ----------------------------------------------------------------------------
;;; Map lore triggers.
;;; ----------------------------------------------------------------------------
/def -mglob -ah -t'You sense a change in terrain\.' terrainchg
/def -mglob -t'You shorten the length of your stride\.' farstridefall = farstride

;;; ----------------------------------------------------------------------------
;;; macro to toggle auto-longshot
;;; ----------------------------------------------------------------------------
/def autols = \
    /toggle autols%;\
    /echoflag %autols Auto-@{Ccyan}Longshot%;\
    /statusflag %autols aLS

;;; ----------------------------------------------------------------------------
;;; auto-held for archer
;;; ----------------------------------------------------------------------------
/def autohold = /toggle autohold%;/echoflag %autohold Auto-Hold Shot
/alias ahold /autohold%;/aq /autohold

;;; ----------------------------------------------------------------------------
;;; auto-aim for assassin
;;; /autoaim [spot] - Toggles auto-aim; if spot is supplied, sets the spot to vital.
;;; ----------------------------------------------------------------------------
/alias aaim /set autoaim=1%;/aq /autoaim
/def autoaim = \
    /toggle autoaim%;\
    /if ({#}=1) /set avs_spot=%1%;/endif%;\
    /echoflag %autoaim Auto-Aimed Shot (%avs_spot)

;;; ----------------------------------------------------------------------------
;;; Auto-fletching trigger
;;; ----------------------------------------------------------------------------
/def _varietyCommand=inven
/def afletch = /toggle autofletch%;/echoflag %autofletch Auto-@{hCyellow}Fletch@{n}

/def -mregexp -t"You don\'t have enough mana to make ([a-zA-Z]+) ([a-zA-Z ]+)\." archer_nofletchmana = \
    /let _arrowType=$[strip_attr({P1})]%;\
    /let _projectileType=$[strip_attr({P2})]%;\
    /if ({_projectileType} =~ "sling stones") /let _projectileType=stones%;/endif%;\
    /if ({autofletch} == 1) \
        /def full_mana_action = /echo -pw [full_mana_action] @{Cyellow}fletch %{_projectileType} '%{arrowlevel} %{_arrowType}'%;stand;fletch %{_projectileType} '%{arrowlevel} %{_arrowType}'%;\
        /send sleep%;\
    /endif

/def -mregexp -t"You fail to produce anything worth shooting\." archer_autofletch_nothing = \
    /set tofletch=$[--tofletch] %; \
    /set totalfletched=$[totalfletched+numfletched]%; \
    /if ({autofletch} == 1 & {tofletch} > 0) \
        /echo -pw [archer_autofletch_nothing] @{Cyellow}fletch %fletchtype '%arrowlevel %arrowtype'%;\
        fletch %fletchtype '%arrowlevel %arrowtype'%;\
        /if (mod(tofletch,5) == 0) /_varietyCommand%;/endif%;\
    /else \
        /send rem fletch=put fletch %{main_bag}=wear %unbrandish%; \
    /endif%; \
    /flstat %{fletchtype}s

;fletch bolts 'lordly piercing'
;Your efforts produced 1 lordly explosive arrow
;Your efforts produced 1 explosive arrow
/def -mregexp -t"Your efforts produced ([0-9]+) (.*) (arrow|bolt|stone)s?" archer_autofletch = \
    /let numfletched=%P1%; \
    /set tofletch=$[--tofletch] %; \
    /set totalfletched=$[totalfletched+numfletched]%; \
    /if ({autofletch} == 1 & {tofletch} > 0) \
        /echo -pw [archer_autofletch] @{Cyellow}%fletchtype '%arrowlevel %arrowtype'%;\
        fletch %fletchtype '%arrowlevel %arrowtype'%;\
        /if (mod(tofletch,5) == 0) /_varietyCommand%;/endif%;\
    /else \
        /send rem fletch=put fletch %{main_bag}=wear %unbrandish%; \
    /endif%; \
    /flstat %{P2} %{P3}s

/def -i -mglob -t"You discard your empty toolkit." archer_nofletchkit = \
    /if ({autofletch} = 1 & {tofletch} > 0) \
        /echo -pw [archer_nofletchkit] @{Cyellow}fletch %fletchtype '%arrowlevel %arrowtype'%;\
        /send get fletch %{main_bag}=wear fletch=fletch %fletchtype '%arrowlevel %arrowtype'%; \
    /endif

/alias mkarrow \
    /if ({#} < 3) \
        /echo -p %%% @{hCred}Syntax: @{nCwhite}mkarrow @{xCyellow}<num> <arrow|bolt|stone> <type> [lordly|heroic]%; \
    /else \
        /test fletchStart := (time())%; \
        /set autofletch=1%;/set totalfletched=0%; \
        /set tofletch=%1%;/set fletchtype=%2%;/set arrowtype=%3%; \
        /if ({#} == 4) /set arrowlevel=%{4}%;/else /unset arrowlevel%;/endif%;\
        /echo -pw [mkarrow] @{Cyellow}fletch %fletchtype '%arrowlevel %arrowtype'%; \
        /send get fletch %{main_bag}=wear fletch=fletch %fletchtype '%arrowlevel %arrowtype'%; \
    /endif

/def flstat = \
    /let t1=%{1}%;/let t2=%{2}%;\
    /if ({1} =~ "") /let t1=%{arrowtype}%;/endif%;\
    /if ({2} =~ "") /let t2=%{fletchtype}%;/endif%;\
    /let fletchmsg=Fletched @{Cyellow}%totalfletched@{n} %{t1} %{t2}.%; \
    /if ({tofletch} > 0) \
        /let fletchmsg=%fletchmsg  @{Cyellow}%tofletch @{n}fletch rounds to go.%; \
    /endif%; \
    /set fletchTime=$[time() - fletchStart]%; \
    /let fletchTimeMsg=@{Cgreen}$[mod(fletchTime/60,60)] @{Cwhite}mins  @{Cgreen}$[mod(fletchTime,60)] @{Cwhite}secs.%; \
    /echo -p %%% %{fletchmsg}  %fletchTimeMsg

