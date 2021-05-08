;;; ----------------------------------------------------------------------------
;;; rogue.tf
;;; Rogue-type triggers/macroes
;;; ----------------------------------------------------------------------------
;;; Mark this file as already loaded, for /require.
/loaded __TFSCRIPTS__/rogue.tf
/set lockpick_chest=lockpick
/set lockpick_door=lockpick

/alias sur \
    /set targetMob=%1 %; \
    /send sur %1

/alias pick \
    /send get "%{lockpick_chest}" %{main_bag}=wear "%{lockpick_chest}"=pick %1=rem "%{lockpick_chest}"=put "%{lockpick_chest}" %{main_bag}=wear %unbrandish
/alias pickdoor \
    /send get "%{lockpick_door}" %{main_bag}=wear "%{lockpick_door}"=pick %1=rem "%{lockpick_door}"=put "%{lockpick_door}" %{main_bag}=wear %unbrandish
/alias pickchest \
    /send get "%{lockpick_chest}" %{main_bag}=wear "%{lockpick_chest}"=pick %1=rem "%{lockpick_chest}"=put "%{lockpick_chest}" %{main_bag}=wear %unbrandish

/def pw = \
    get "%{poisonkit}" %{main_bag}%;\
    wear "%{poisonkit}"%;\
    get %2 %{main_bag}%; \
    rem %1%;poison %1 %2%; \
    wear %1%;remove "%{poisonkit}"%; \
    wear %{hit_held}%;put "%{poisonkit}" %{main_bag}

/def autopick=/toggle autopick%;/echoflag %autopick Automatically @{hCyellow}Lock-Picking@{n}
/set lockbox=lockbox
/def setlockboxtype = /set lockbox=%{*}%;/echo -pw Lockbox item set to: %{lockbox}

/def apick = \
    /autopick%;\
    /if ({autopick} == 1) \
        /setup_autopick%;\
        /send config -prompt=get "%{lockpick_chest}" %{main_bag}=wear "%{lockpick_chest}"=inspect %lockbox%;\
    /else \
        /send config +prompt=remove "%{lockpick_chest}"=put "%{lockpick_chest}" %{main_bag}=wear %{unbrandish}%; \
        /cleanup_autopick%;\
    /endif

/def lkb = pick %1.lockbox%;open %1.lockbox%;get all %1.lockbox
/def -i setup_autopick = \
    /def -ag -p9 -F -mregexp -t"^You pick the lock on a small wooden lockbox\." gag_lockpick_pick%;\
    /def -ag -p9 -F -mregexp -t"^\\*Click\\*" gag_lockpick_click%;\
    /def -ag -p9 -F -mregexp -t"^You open a small wooden lockbox\." gag_lockpick_open%;\
    /def -ag -p9 -F -mregexp -t"^You close a small wooden lockbox\." gag_lockpick_close%;\
    /def -ag -p9 -F -mregexp -t"^You drop a small wooden lockbox\." gag_lockpick_drop%;\
    /def -ag -p9 -F -mregexp -t"^You inspect a small wooden lockbox for traps\." gag_lockpick_inspect%;\
    /def -ag -p9 -F -mregexp -t"^The a small wooden lockbox is not trapped\." gag_lockpick_not_trapped%;\
    /def -ag -p9 -mregexp -t"^You kneel down and begin to disarm a small wooden lockbox\." gag_lockpick_begin_disarm%;\
    /def -ag -p9 -mregexp -t"^You disarm the (.+) mechanism\." gag_lockpick_disarm_mechanism%;\
    /def -ag -p9 -mregexp -t"^You successfully dismantle the (.+)\." gag_lockpick_dismantle_trap%;\
    /def -ag -p9 -mregexp -t"^You stand up and wipe the sweat from your brow\." gag_lockpick_done_disarm%;\
    /def -ahCred -p9 -mregexp -t"^You get an red\-brown vial of healing from a small wooden lockbox\." apick_div_pot = put all.red-brown %%{main_bag}%;\
    /def -abhCred -p9 -mregexp -t"^You get a practice ticket from a small wooden lockbox\.$$" apick_practice_ticket = put practice %%{main_bag}

/def -i cleanup_autopick = /undef gag_lockpick_pick gag_lockpick_click gag_lockpick_open \
    gag_lockpick_close gag_lockpick_drop gag_lockpick_inspect gag_lockpick_not_trapped \
    gag_lockpick_begin_disarm gag_lockpick_disarm_mechanism gag_lockpick_dismantle_trap \
    gag_lockpick_done_disarm apick_div_pot apick_practice_ticket

;;; ----------------------------------------------------------------------------
;;; Auto lockpicking script
;;; ----------------------------------------------------------------------------
/def -p99 -mregexp -t"^\*?([a-zA-Z]+)\*? tells the group 'pick ([neswud]?|north|east|south|west|up|down)'" autopick_gtell = \
    /let pickdir=%{P2}%;\
    /if ({autopick} == 1 & {P1} =~ {leader} & regmatch({myclass},{rogType})) \
        pickdoor %{pickdir}%;\
    /endif

/def -mregexp -t'^The .* looks like it is armed with a ([a-zA-Z ]+) trap\.$' traptype = \
    /let traptype=%P1 %; \
    /if ({autopick} == 1) \
        /send get disarming %{main_bag}=wear disarming=dismantle %traptype %lockbox %; \
        /send rem disarming=put disarming %{main_bag}=wear %{lockpick_chest}=pick %lockbox%;\
    /endif

/def -mglob -t'The * is not trapped.' lockpick_notrap = \
    /if ({autopick}=1) /send pick %lockbox%; /endif

/def -mglob -t"You couldn't make the lock turn on *\." lockpick_nounlock = \
    /if ({autopick} == 1) \
        /send pick %lockbox%;\
    /endif

/def -mglob -t"You pick the lock on *." lockpick_picked = \
    /send open %lockbox=get all %lockbox=put all.red-brown %{main_bag}=drop all.vial=close %lockbox=drop %lockbox%; \
    /if ({autopick} == 1) \
        /if (regmatch({myclass},{rogType})) /send inspect %lockbox%; \
        /else /send pick %lockbox%; \
        /endif%;\
    /endif

/def -mglob -t"* is not locked." lockpick_not_locked = \
    /send open %lockbox=get all %lockbox=put all.red-brown %{main_bag}=drop all.vial=close %lockbox=drop %lockbox%; \
    /if ({autopick} == 1) \
        /if (regmatch({myclass},{rogType})) /send inspect %lockbox%; \
        /else /send pick %lockbox%; \
        /endif%;\
    /endif

/def -mregexp -t'([a-zA-Z ]+) breaks off in the lock\!' lockpick_broken = \
    /if ({autopick} == 1) \
        /send get "%{lockpick_chest}" %{main_bag}=wear "%{lockpick_chest}"%;\
    /endif

/def -mregexp -t'You set off a trap\!' lockpick_set_off_trap = \
    /if ({autopick} == 1) \
        /send inspect %lockbox%;\
    /endif

/def -mglob -t"You are not carrying *!" lockpick_not_carrying = \
    /if ({autopick} == 1) /apick%;/endif

;;; ----------------------------------------------------------------------------
/def -mregexp -t"(Alert what now\?|You feel less perceptive|The only thing you notice is that your boots are untied)" alert_trig = \
    /set ticktoggle=1%;\
    /if ({refreshmisc} == 1) \
        /refreshSkill alertness%;\
    /endif

/def -p1 -mglob -t"* dodges at the last second\!" attack_dodged = /set adodged=$[++adodged]

;;; ----------------------------------------------------------------------------
;;; Sort poison script
;;; /sortpoison [item to sort]
;;; ----------------------------------------------------------------------------
/set sortpoisonitem=fang
/def sortpoison = \
    /if ({#}=1) /set sortpoisonitem=%*%; /endif%;\
    /toggle sortpoison%;\
    /echoflag %sortpoison @{hCyellow}Sort Poison (@{nCred}Item: %{sortpoisonitem}@{hCyellow})@{n}%;\
    /if ({sortpoison}=1) \
        /def -mregexp -p4 -ahCyellow -t"^It carries roughly [0-9]+ doses of ([a-zA-Z \-]+), .*" sort_poison = \
            /send put %%sortpoisonitem %%P1=examine %%sortpoisonitem%;\
        get all.satchel %{main_bag}%;\
        examine %sortpoisonitem%;\
    /else \
        /undef sort_poison%;\
        put all.satchel %{main_bag}%;\
    /endif

;;; ----------------------------------------------------------------------------
;;; auto-vital shot stuff
;;; ----------------------------------------------------------------------------
/set avs_spot=head
;;; /avs [spot] - Toggles auto-vital; if spot is supplied, sets the spot to vital.
/alias avs /avs%;/aq /avs
/def avs = \
    /toggle autovs%;\
    /if ({#}=1) /set avs_spot=%1%;/endif%;\
    /echoflag %autovs Auto-Vital Shot (%avs_spot)

;;; ----------------------------------------------------------------------------
;;; Targetting script.
;;; /atarg - Toggle if auto-targetting is on.  If off, Ctrl-H to fire the macro.
;;; /targ [target to add]
;;;  - No target shows current targets
;;;  - With target, appends to the end of the target list.
;;;  - Trigger will only fire 'if' targets set and you follow the leader.
;;;  - If you want to do something besides 'kill targets', set alias on hit (e.g. alias hit bs %1)
;;; ----------------------------------------------------------------------------
/def atarg = \
    /toggle atarg%;\
    /echoflag %atarg Auto-@{Cyellow}Targetting@{n}%;\
    /statusflag %atarg Target%;\
    /if ({atarg}=1 & {#}>0) /targ %*%;/endif

;; New auto-targetting/stab macro
/def stab = \
  /if (!getopts("w:", "a")) /let this=$[world_info()]%;/endif%;\
  /if /test opt_w =~ 'a'%;/then%;/let this=$[world_info()]%;\
  /else /let this=%{opt_w}%;\
  /endif%;\
  /auto -w%{this} stab %1%;\
  /let auto_tr_v %{this}_auto_stab%;\
  /let auto_tr $[expr({auto_tr_v})]%;\
  /statusflag %{auto_tr} Stab

/def chkassa=/if (!getopts("w:", "a")) /let this=$[world_info()]%;/endif%;\
  /echo -p [DEBUG:] /chkassa HIT%;\
  /if /test opt_w =~ 'a'%;/then%;\
    /let this=$[world_info()]%;\
  /else \
    /let this=%opt_w%;\
  /endif%;\
  /if /test %{this}_auto_stab == 1%; /then /echo stabbing%;/endif%;\
  /let mbm_v %{this}_auto_stab%;\
  /let mbm $[expr({mbm_v})]%;\
  /eval /echo -p STAB: %{this}, 1: %{1}, 2: %{2}, auto: %{this}_auto_stab : %{mbm}%;\
;  /let mt $(/getvar tank)%;
  /if /test %{this}_auto_stab == 1 %; /then /repeat -%2 1 /send -w%{this} hit %1%;/endif

/def targ = \
    /if ({#} > 0) \
        /if ({1} =~ "clear") /unset autotargets%;\
        /elseif ({1} =~ "help") \
            /echo -pw %%% @{hCyellow}/targ @{nCred}[targets]@{n}%;\
            /echo -pw %%% @{hCyellow}CTRL+H @{nCred}-> Invoke 'hit' alias to all targets.%;\
            /echo -pw %%% @{hCyellow}CTRL+B @{nCred}-> Invoke surprise attack to all targets.%;\
            /echo -pw %%% @{hCyellow}CTRL+ @{nCred}-> Disengage to last room, then slip back to target last mob (%{_disengage_dir}, %{_slip_mob}).%;\
        /else /set autotargets=%autotargets %*%;\
        /endif%;\
    /endif%;\
    /echo -p %%% @{Cyellow}Targets: @{hCred}%{autotargets}
    
/def -mregexp -p7 -ag -t'You follow ([A-Za-z]+) (north|south|east|west|up|down).$' auto_assass = \
    /if ({P1} =~ {leader} & {autotargets} !~ "" & {atarg} = 1) /hitem %{autotargets}%; /endif%;\
    /echo -pw @{Cgreen}You follow @{hCyellow}%{P1} @{hCred}%{P2}%;\
    /set _slip_dir=%{P2}%;\
    /if ({_slip_dir} =~ "north") /set _disengage_dir=south%;\
    /elseif ({_slip_dir} =~ "east") /set _disengage_dir=west%;\
    /elseif ({_slip_dir} =~ "south") /set _disengage_dir=north%;\
    /elseif ({_slip_dir} =~ "west") /set _disengage_dir=east%;\
    /elseif ({_slip_dir} =~ "up") /set _disengage_dir=down%;\
    /elseif ({_slip_dir} =~ "down") /set _disengage_dir=up%;\
    /else /set _disengage_dir=na%;\
    /endif

/def hitem = \
    /if ({mudLag} < 5) \
        /while ({#}) /send hit %1%;/shift%;/done%;\
    /endif
;; CTRL-H to invoke the hit for all targets.  Add a server-side 'hit' alias
;; to do something other than the default hit (i.e alias hit surprise %1)
/def -b'^H' -i mhitem = /hitem %autotargets

;; CTRL-B to sneak attack defined targets
/def surpem = /while ({#}) /send surprise %1%;/shift%;/done
/def -b'^B' -i msurpem = /surpem %autotargets

;;; ----------------------------------------------------------------------------
;;; Slip/Disengage
;;; /aslip - Toggle if auto-slipping is on.  If off, Ctrl-o to fire the macro.
;;; If auto-slip is off, CTRL-I to initiate
;;; ----------------------------------------------------------------------------
/def aslip = \
    /toggle aslip%;\
    /echoflag %{aslip} Auto-@{Cyellow}Slip@{n}%;\
    /statusflag %{aslip} aSlip

/def slip = \
    /if ({#} = 2) \
        /set _disengage_dir=%{1}%;\
        /set _slip_mob=%{2}%;\
    /elseif ({#} = 1) \
        /set _slip_mob=%{1}%;\
    /else \
        /echo -pw %%% @{Cyellow}Disengaging @{hCred}%{_disengage_dir} @{nCyellow}.  Slipping @{hCred}%{_slip_mob}@{n}%;\
    /endif%;\
    /if ({_disengage_dir} =~ "north") /set _slip_dir=south%;\
    /elseif ({_disengage_dir} =~ "east") /set _slip_dir=west%;\
    /elseif ({_disengage_dir} =~ "south") /set _slip_dir=north%;\
    /elseif ({_disengage_dir} =~ "west") /set _slip_dir=east%;\
    /elseif ({_disengage_dir} =~ "up") /set _slip_dir=down%;\
    /elseif ({_disengage_dir} =~ "down") /set _slip_dir=up%;\
    /else /set _slip_dir=na%;\
    /endif%;\
    /if ({_slip_dir} !~ "na") \
        /send disengage %{_disengage_dir}%;\
    /else /echo -pw %%% @{hCred} /slip [north|east|south|west|up|down] [mob]%;\
    /endif

;; Assassin's can bow stab, but need to remove bow: rem bow, slip dir mob, wield bow, assass mob
;; Suggested alias: a slip remove bow:slip %1 %2:wield bow
; Walk to a adjacent room instead of disengaging
/def slop = \
    /if ({#} = 2) \
        /set _disengage_dir=%{1}%;\
        /set _slip_mob=%{2}%;\
    /elseif ({#} = 1) \
        /set _slip_mob=%{1}%;\
    /else \
        /echo -pw %%% @{Cyellow}Disengaging @{hCred}%{_disengage_dir} @{nCyellow}.  Slipping @{hCred}%{_slip_mob}@{n}%;\
    /endif%;\
    /if ({_disengage_dir} =~ "north") /set _slip_dir=south%;\
    /elseif ({_disengage_dir} =~ "east") /set _slip_dir=west%;\
    /elseif ({_disengage_dir} =~ "south") /set _slip_dir=north%;\
    /elseif ({_disengage_dir} =~ "west") /set _slip_dir=east%;\
    /elseif ({_disengage_dir} =~ "up") /set _slip_dir=down%;\
    /elseif ({_disengage_dir} =~ "down") /set _slip_dir=up%;\
    /else /set _slip_dir=na%;\
    /endif%;\
    /if ({_slip_dir} !~ "na") \
        /send %{_disengage_dir}=slip %{_slip_dir} %{_slip_mob}=assassinate %{_slip_mob}%;\
    /else /echo -pw %%% @{hCred} /slip [north|east|south|west|up|down] [mob]%;\
    /endif

; If you have the solitude effect you don't need to disengage
/def -b'^O' key_slip = \
    /if ({solitudeleft} > 0 | {myclass} =~ "asn") /slop%;\
    /else /slip%;\
    /endif
    
/def -mglob -ah -t"You prepare to disengage from combat!" combat_prep_disengage
/def -mglob -ah -t"You did not manage to sneak away!" combat_fail_disengage = \
    /if ({_disengage_dir} !~ "na" & {aslip} == 1) /send disengage %{_disengage_dir}%;/endif

/def -mglob -ah -t"Having slipped up on your target's back you launch the attack!" combat_slip_attack = \
    /if ({_disengage_dir} !~ "na" & {aslip} == 1) \
        /send disengage %{_disengage_dir}%;\
    /endif

/def -ah -mglob -t"You disengage from combat!" combat_disengage = \
    /if ({_slip_dir} !~ "na" & {aslip} == 1) \
        /send slip %{_slip_dir} %{_slip_mob}=assassinate %{_slip_mob}%;\
    /endif

/def -ah -mglob -t"You did not manage to sneak up on your target!" combat_slip_fail = \
    /if ({_disengage_dir} !~ "na" & {aslip} == 1) \
        /send disengage %{_disengage_dir}%;\
    /endif

/def -ah -mglob -t"A moment's distraction and your disengagement attempt is ruined!" combat_distraction = \
    /if ({_disengage_dir} !~ "na" & {aslip} == 1) \
        /send disengage %{_disengage_dir}%;\
    /endif

/def -ah -mglob -t"You must be fighting already to use this skill." combat_out_of_combat
;    /if ({_disengage_dir} !~ "na" & {aslip} == 1) \
;        /slop%;\
;    /endif


;;; ----------------------------------------------------------------------------
;;; Macroes for default targetting for certain areas
;;; ----------------------------------------------------------------------------

;;; -----------------------------------
;;; Hero autoset targets
;;; -----------------------------------
/def targgraves = \
    /targ clear%;\
    /targ 2.wraith wraith 2.guard guard 2.drow drow 2.robber robber 2.scav scav
/def targmorte = \
    /targ clear%;\
    /targ 2.creature creature 2.giant giant grif orc garg
/def targdivide = \
    /targ clear%;\
    /targ 2.dwarf dwarf 2.bandit bandit cliff dervish
/def targverdant = \
    /targ clear%;\
    /targ 2.plant plant
/def targidol = \
    /targ clear%;\
    /targ 2.hunter hunter 2.priestess priestess 2.spider spider
/def targgoldenweb = \
    /targ clear%;\
    /targ 2.knight knight 2.web web
/def targtransforest = \
    /targ clear%;\
    /targ shad stone swi clo wy gho
/def targsummoning = \
    /targ clear%;\
    /targ assas mother grand command
/def targgreed = \
    /targ clear%;\
    /targ  pirate sailor man snake frog croc

;;; -----------------------------------
;;; Hero EHA
;;; -----------------------------------
/def targsemvida = \
    /targ clear%;\
    /targ 2.wra wra 2.spe spe hord ghost zomb rat
/def targaculeata = \
    /targ clear%;\
    /targ 2.was was

;;; -----------------------------------
;;; Lord autoset targets
;;; -----------------------------------
/def targkarn = \
    /targ clear%; \
    /targ sellah rogue akuma nightmare soul man cynic woman tcho priest devotee witch berserker
/def targarcadia = \
    /targ clear%;\
    /targ chim bale 2.chim 2.bale
/def targascension = \
    /targ clear%;\
    /targ delusion dog eidolon demon predator phantasm fiend reaper
/def targastral = \
    /targ clear%;\
    /targ fae guard
/def targfire = \
    /targ clear%;\
    /targ aut beast gate ral lan blaze fire sent spi sala gi wind dragon
/def targkzinti = \
    /targ clear%;\
    /targ 2.pyro pyro dark
/def targnoctopia = \
    /targ clear%;\
    /targ fae psi pet
/def targoutland = \
    /targ clear%;\
    /targ gi 2.gi
/def targstone = \
    /targ clear%;\
    /targ ele 2.ele
/def targtarterus = \
    /targ clear%;\
    /targ demo 2.demo
/def targwater = \
    /targ clear%;\
    /targ elemental 2.elemental wyrm viper
/def targreckoning = \
    /targ clear%;\
    /targ fire water ess djin earth golem wind
/def targcinder = \
    /targ clear%;\
    /targ carc cloud drake sent giant dwell drag flame fire beetle mummy wind tar spirit imp glut sala smoke soul cad
/def targunravelling = \
    /targ clear%;\
    /targ golem 2.golem wraith necro tent fae viper duke spellgua 2.fae beast masta 3.fae devil demon pet weaver beast

;;; ----------------------------------------------------------------------------
;;; Bladedancer scripts
;;; ----------------------------------------------------------------------------
/alias less /send bladetrance lighten
/alias deep /send bladetrance deepen
/alias bt /send bladetrance %1

;; recycle veil of blades
;/def -mregexp -t"^One of your Exhaust timers has elapsed\. \(veil of blades\)" veil_of_blades_exhaust_down = \
;    /set ticktoggle=1%;\
;    /if ({refreshmisc} == 1) \
;        /refreshSkill stance veil%;\
;    /endif

;;; Bladedtrance tracking
/def -i setBladetrance = \
    /if ({#} == 1) \
        /if ({1} == 0) /set bladetranceLevel=0%;\
        /else /set bladetranceLevel=$[{bladetranceLevel} + {1}]%;\
        /endif%;\
        /if ({bladetranceLevel} < 0) /set bladetranceLevel=0%;/endif%;\
    /endif%;\
    /set displayBladetranceLevel=Tr:%{bladetranceLevel}%;\
    /echo -pw Trance: %{displayBladetranceLevel}

/def -mregexp -ahCmagenta -p5 -t"^You sink deeper into a bladetrance.$" bld_bladetrance_deeper = /setBladetrance 1
/def -mregexp -ahCmagenta -p5 -t"^The depth of your bladetrance lessens.$" bld_bladetrance_lighten = /setBladetrance -1
/def -mregexp -ahCmagenta -p5 -t"^You are not even in a bladetrance.$" bld_bladetrance_none = /setBladetrance 0
/def -mregexp -ahCmagenta -p5 -t"^You emerge from your bladetrance into a vacant reality.$" bld_bladetrance_vacant = /setBladetrance 0
/def -mregexp -ahCmagenta -p5 -t"^Options: enter$" bld_bladetrance_options = /setBladetrance 0
/def -mregexp -ahCmagenta -p5 -t"^You sink into a bladetrance.$" bld_bladetrance_sink = /setBladetrance 1
/def -mregexp -ahCmagenta -p5 -t"^Thrown out of your bladetrance you are faced with a vacant reality.$" bld_bladetrance_break = /setBladetrance 0
/def -mregexp -ahCmagenta -p5 -t"^Any deeper and you will never get out.$" bld_bladetrance_max
/def -mregexp -ahCmagenta -p5 -t"^You are already in a bladetrance.$" bld_bladetrance_already
/def -mregexp -ahCmagenta -p5 -t"^Bladetrance depth: (\d+)$" bld_bladetrance_current_level = \
    /set bladetranceLevel=$[strip_attr({P1})]%;\
    /setBladetrance
/def -mregexp -ahCmagenta -p5 -t"^Your mind is still exhausted from the previous bladetrance.$" bld_bladetrance_exhaust

/def status_add_trance = /status_add -x -AdisplayXP displayBladetranceLevel:5:Cwhite
/def status_rm_trance = /status_rm displayBladetranceLevel
