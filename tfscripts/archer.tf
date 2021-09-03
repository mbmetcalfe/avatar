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

;; bow/xbow swapping when aggied
/def xbow = /auto xbow %1
/def -p9 -ag -mregexp -F -t"\'s attac.* strikes? you [0-9]* (time|times), with .* [a-zA-Z]*(\.|\!)$" archer_aggie_swap_bow = \
    /if ({xbowon}=0 & $(/getvar auto_xbow) == 1) xbow%;/aq bow%;/endif
/def -p9 -ag -mregexp -F -t"\'s attacks haven\'t hurt you\!$" archer_nil_aggie_swap_bow = \
    /if ({xbowon}=0 & $(/getvar auto_xbow) == 1) xbow%;/aq bow%;/endif
/def -p9 -ag -mregexp -F -t"([a-zA-Z]+) successfully rescues you from the .*\!" archer_rescued_swap_bow = \
    /if ({xbowon}=1 & $(/getvar auto_xbow) == 1) bow%;/clrq%;/endif

/def old_swap = \
    /let arrowType=%{1}%;\
    /let braceType=arrow%;\
    /if ({#} == 2) /let braceType=%{2}%;\
    /elseif ({myclass} =~ "fus") /let braceType=stone%;\
    /elseif ({myclass} =~ "sld") /let braceType=bolt%;\
    /endif%;\
    get "%{arrowType} %{braceType}" %{quiver_bag}%;\
    wear "%{arrowType} %{braceType}"%;\
    get "all.%{arrowType} %{braceType}" %quiver_bag%;\
    put all.%{braceType} %quiver_bag%;\
    /set unbrandish=%{arrowType} %{braceType}
/def swap = \
    /if (!getopts("w:", "a")) /let this=$[world_info()]%;/endif%;\
    /let arrowType=%{1}%;\
    /let braceType=arrow%;\
    /if ({#} == 2) /let braceType=%{2}%;\
    /elseif ({myclass} =~ "fus") /let braceType=stone%;\
    /elseif ({myclass} =~ "sld") /let braceType=bolt%;\
    /endif%;\
    /if (regmatch({myclass}, {arcType}))\
        /send -w%{this} get "%{arrowType} %{braceType}" %{quiver_bag}%;\
        /send -w%{this} wear "%{arrowType} %{braceType}"%;\
        /send -w%{this} get "all.%{arrowType} %{braceType}" %quiver_bag%;\
        /send -w%{this} put all.%{braceType} %quiver_bag%;\
        /set unbrandish=%{arrowType} %{braceType}%;\
    /else /echo -p @{hCmagenta}Suggested projectile type: @{xCwhite}%{arrowType}@{n}%;\
    /endif

/def -p0 -mregexp -t"([a-zA-Z\*]+) tells the group '(.*) arrows?'" drone_arrow_swap = \
    /let arrowType=%{P2}%;\
    /if (regmatch({myclass},{arcType})) /swap %{arrowType}%;/endif
/def -p0 -mregexp -t"([a-zA-Z\*]+) tells the group 'arrows?'" drone_reequip_arrows = \
    /if (regmatch({myclass},{arcType})) \
        /send get "%{unbrandish}" %{quiver_bag}=wear "%{unbrandish}"%;\
    /endif

/def -mregexp -p4 -t'([a-zA-Z0-9\' ]*) has fled (north|south|east|west|up|down)!' lstrig = \
    /let _fleeDir=%{P2}%;\
    /if ({myclass} =~ "asn" & {mylevel}>=250 & $(/getvar auto_ls) == 1) \
        snipe %{_fleeDir} %targetMob knee%;\
    /elseif ((regmatch({myclass},{arcType})) & $(/getvar auto_ls) == 1) \
        ls %{_fleeDir} %targetMob %; \
    /endif

/def -mregexp -t"^\*?([a-zA-Z]+)\*? tells the group '(snipe|ls) ([a-zA-Z]+) ([a-zA-Z0-9\.]+)'$" gtlstrig = \
    /let _leader=%{P1}%;\
    /let tAction=%{P2}%;\
    /let mobDir=%{P3}%;\
    /let longshotMob=%{P4}%;\
    /if ((regmatch({myclass},{arcType})) & $(/getvar auto_ls) == 1 & {_leader} =~ {leader}) \
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
    /auto ls %1%;\
    /statusflag $(/getvar auto_ls) aLS

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

; New arrow fletching macroes
/set fletch_count=0
/set fletch_max=15
/def fletch = /auto fletch %1

;/def -i flone = /send hold fletch=fletch %1 %2
/def -i flone = /if /test %{this}_auto_fletch == 1%;/then /send hold fletch=fletch %1 %2%;/endif
/def -i fletcharrow = /send wake=get all.fletch %{main_bag}%;/flone %1 %2%;/flone %1 %2%;/flone %1 %2%;/flone %1 %2%;/flone %1 %2%;/flone %1 %2%;/flone %1 %2%;/flone %1 %2%;/flone %1 %2%;/flone %1 %2%;/flone %1 %2%;/send rem fletch=put all.fletch %{main_bag}=sleep

/def -i fletchmacro = /let this=$[world_info()]%;/if /test %{this}_auto_fletch == 1%;/then /fletcharrow %1 %2%;/endif
/def -i fletchloop = /if /test fletch_count <= fletch_max%;/then /set fletch_count $[fletch_count+1]%;/fletchmacro %1 %2%;/repeat -1800 1 /fletchloop %1 %2%;/endif
/def mkarrow = /fletch on%;/set fletch_count 0%;/fletchloop %1 %2

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

/def -i ammo=/auto ammo %1
/def ammo_swap=/if (!getopts("w:", "a")) /let this=$[world_info()]%;/endif%;\
  /if /test opt_w =~ 'a'%;/then%;\
    /let this=$[world_info()]%;\
  /else \
    /let this=%opt_w%;\
  /endif%;\
  /if /test %{this}_auto_ammo == 1 %; /then /swap -w:{this} %1%;/endif

;; Trigger to drop the braces archers loot when grabbing braces
/def -mglob -p2 -t"You get a pair of spiked elbow braces from corpse of *." drop_elbow_braces = \
  /if ((regmatch({myclass},{arcType}))) /send drop elbow%;/endif
/def -mglob -p2 -t"You get a blue metal bracer from corpse of *." drop_blue_metal_bracer = \
  /if ((regmatch({myclass},{arcType}))) /send drop "blue bracer"%;/endif

;; Swap ammo if using wrong type.
/def -p10 -mglob -au -t"You have the wrong kind of ammo!" archer_wrong_ammo = /swap %{boltType}


;; Amp up some damage for certain mobs
; Ruin of the Arcanists
/def held = /auto held %1
/def -mregexp -p5 -au -F -t"^You start fighting (Shol, grandmaster of the guardian sect|A whirling water vortex|A crackling lightning automaton|A crashing water automaton|A sizzling automaton of acid|A bellowing air automaton|A mighty automaton of earth|A frosty ice automaton|A crash of glacial ice|A mighty earth juggernaut|A furious automaton of fire)\." arc_arcanist_ruins_auto_cast = \
    /if /test $(/getvar auto_held) == 1%;/then /send held%;/endif

; Sem Vida
/def -mregexp -p5 -au -F -t"^You start fighting (Groundskeeper Skaggs|Groundskeeper Chalmers)\." arc_sem_vida_auto_cast = \
    /if /test $(/getvar auto_held) == 1%;/then /send held%;/endif

; Necropolis
/def -mregexp -p5 -au -F -t"^You start fighting (a dark ring of ice-blue fire|the General Commander for Veyah L'Aturii)\." arc_necropolis_auto_cast = \
    /if /test $(/getvar auto_held) == 1%;/then /send held%;/endif

; Divide
/def -mregexp -p5 -au -F -t"^You start fighting (Arcanthra the Black|Crullius the White)\." arc_divide_held = \
    /if /test $(/getvar auto_held) == 1%;/then /send held%;/endif

; Morte
/def -mregexp -p5 -au -F -t"^You start fighting (Iadus, daughter of Collosus|Oborus, daughter of Collosus|the power liche, Azric|Collosus)\." arc_morte_held = \
    /if /test $(/getvar auto_held) == 1%;/then /send held%;/endif

; Alpha Thule
/def -mregexp -p5 -au -F -t"^You start fighting (The Celestial|An ancient sentinel|An Ancient)\." arc_alphathule_held = \
    /if /test $(/getvar auto_held) == 1%;/then /send held%;/endif

; Shogun
/def -mregexp -p5 -au -F -t"^You start fighting (The True Emperor)\." shogun_held = \
    /if /test $(/getvar auto_held) == 1%;/then /send held%;/endif

;; Soldier stance highlights
;Following your lead, Setho joins echelon formation!
;Nartaka tries to follow your lead, but fails to join echelon formation.
