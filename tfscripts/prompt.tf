;;; ----------------------------------------------------------------------------
;;; prompt.tf
;;; ----------------------------------------------------------------------------
/set lvlon=0

;; default tnlthreshold
/set tnlthreshold=100
/set ticktoggle=0
/def stnl = \
    /if ({1} !~ "") /set tnlthreshold=%1%; /endif%; \
    /echo -p %%% @{Ccyan}TNL threshold set to: @{hCwhite}%tnlthreshold@{nCcyan}.@{n}

/def setprompt = /send prompt <%%h/%%H %%m/%%M %%w/%%W %%v/%%V %%T>%%n%;/send config +prompt%;/setprompt2
/def setprompt2 = /send prompt2 <Pos: %%e Lag: %%s S:%%S Q:%%Q A:%%A>%%n%;/send config +prompt2
/def setimmprompt = /send prompt <Room: %%R | %%z | I:%%i>%%n
/def setimmprompt2 = /send prompt2 <Room: %%R | %%z | I:%%i>%%n

;;; aliases to display a different prompt
/def percentprompt = /def show_prompt = /prompt  %{prompt_bits}<%{curr_hp}/%{max_hp}hp(%{per_hp}%%) %{curr_mana}/%{max_mana}m(%{per_mana}%%) %{curr_mhp}/%{max_mhp}mon(%{per_mhp}%%) %{curr_move}/%{max_move}mv(%{per_move}%%) %{tnl}tnl>@{nC}
/def normalprompt = /def show_prompt = /prompt  %{prompt_bits}<%{curr_hp}/%{max_hp}hp %{curr_mana}/%{max_mana}m %{curr_mhp}/%{max_mhp}mon %{curr_move}/%{max_move}mv %{tnl}tnl>

;;;; need to strip off mud colors:  /set var %Px and then $[strip_attr({var})]

;; default prompt
/def show_prompt = /prompt  %{prompt_bits}<%{curr_hp}/%{max_hp}hp %{curr_mana}/%{max_mana}m %{curr_mhp}/%{max_mhp}mon %{curr_move}/%{max_move}mv %{tnl}tnl>
/def show_prompt = \
    /if ({curr_mhp} !~ "-") \
        /prompt  %{prompt_bits}<%{curr_hp}/%{max_hp}hp %{curr_mana}/%{max_mana}m %{curr_mhp}/%{max_mhp}mon %{curr_move}/%{max_move}mv %{tnl}tnl>%;\
    /else \
        /prompt  %{prompt_bits}<%{curr_hp}/%{max_hp}hp %{curr_mana}/%{max_mana}m %{curr_move}/%{max_move}mv %{tnl}tnl>%;\
    /endif

/def show_imm_prompt = \
    /if ({invis_level} > 0)\
        /prompt %{prompt_bits}<Room: %{room_vnum} | {%{area_range}} %{area_name} | [%{invis_level}]>%;\
    /else \
        /prompt %{prompt_bits}<Room: %{room_vnum} | {%{area_range}} %{area_name}>%;\
    /endif

/def -mregexp -F -ag -t"^<Room: ([0-9]+) \| \{(.*)\} (.*) \| I:[\*]*([0-9\-]+)>" imm_prompt_hook = \
;    /unset prompt_bits%;/unset room_vnum%;\
;    /unset area_range%;/unset area_name%;/set invis_level=0%;\
    /set room_vnum=%P1%;\
    /set area_range=%P2%;\
;    /set area_range=$[replace("  ", "-", {P3})]%;\
    /set area_name=$(/rest %{P3})%;\
    /set invis_level=%P4%;\
    /set prompt_bits=%;\
    /if ({pl} =/ "*$*") /set prompt_bits=%{prompt_bits}S%;/endif%;\
    /if ({pl} =/ "*<D>*") /set prompt_bits=%{prompt_bits}D%;/endif%;\
    /if ({pl} =/ "*!*") /set prompt_bits=%{prompt_bits}!%;/endif%;\
    /if ({pl} =/ "*#*") /set prompt_bits=%{prompt_bits}#%;/endif%;\
    /if ({pl} =/ "*@*") /set prompt_bits=%{prompt_bits}@%;/endif%;\
    /set status_fields=@world:6:Cgreen :1 prompt_bits:5:hCyellow "Room: " room_vnum:8:Cyellow :1 "Range: " area_range:6:Ccyan :1 "Area: " area_name:15:Cmagenta :1 "Invis: " invis_level:3:Cred%;\
    /if ({visual} =~ "off")  /show_imm_prompt%; /endif

/def -mregexp -F -ag -t"^<A:(.*) S:(.*) Q:(.*)>" prompt2_hook = \
;    /unset auglevel%;/unset surglevel%;/unset quicklevel%;\
    /set auglevel=%P1%;/set surglevel=%P2%;/set quicklevel=%P3

;; myTnl is hard-coded for now.
/set myTnl 1000

;; Monitor changing trigger -- just here since the variable is used here.
/def -mregexp -p1 -t"^Okay, you are now monitoring ([a-zA-Z]+)\." monitor_change = \
    /set currentMonitor=%P1
/def -mglob -p1 -t"Okay, monitor turned off." monitor_change_off = /unset currentMonitor

;;; ----------------------------------------------------------------------------
;;; Autohealing 
;;; ----------------------------------------------------------------------------
;; Defaults
;; To toggle automatic healing you need to add a personal trigger for "hop self":
;/def -mglob -p1 -ag -wgengis -t"Wow, that takes talent." autoheal_toggle = \
;    /if ({autoheal}=1) /set healToggle=1%;/endif
; hop self seems to echo to others now, try this:
;/def -mglob -p1 -ag -wmaxine -t"Punch whom?" autoheal_toggle = \
;    /if ({autoheal}=1) /set healToggle=1%;\
;    /else /echo -pw @{Cgreen}Punch whom?@{n}%;/endif


/set healToggle=0
/set autoheal=0
/set healRedux=100
/set comfGain=1500
/set divGain=200
/set healGain=100
/set cureLightGain=25

/def -i promptHookCheck= \
    /eval /set _promptHookCheckName=${world_name}%;\
    /if /ismacro generalPromptHookCheck%; /then \
        /generalPromptHookCheck%;\
    /endif%;\
    /if /ismacro %{_promptHookCheckName}PromptHookCheck%; /then \
        /%{_promptHookCheckName}PromptHookCheck%;\
    /endif%;\
    /unset _promptHookCheckName

/def -mregexp -F -ag -t"<([-0-9]+)/([-0-9]+) ([-0-9]+)/([-0-9]+) ([-0-9]+)/([-0-9]+) ([-0-9]+)/([-0-9]+) ([0-9]+)>" prompt_hook = \
    /set prompt_bits=%;\
    /if ({PL} =/ "*\$*") /set prompt_bits=%{prompt_bits}S%;/endif%;\
    /if ({PL} =/ "*\<D\>*") /set prompt_bits=%{prompt_bits}D%;/endif%;\
    /if ({PL} =/ "*\!*") /set prompt_bits=%{prompt_bits}!%;/endif%;\
    /if ({PL} =/ "*\#*") /set prompt_bits=%{prompt_bits}#%;/endif%;\
    /if ({PL} =/ "*\@*") /set prompt_bits=%{prompt_bits}@%;/endif%;\
    /if ({PL} =/ "*\[*S\]*") /set prompt_bits=%{prompt_bits}t%;/endif%;\
    /if ({PL} =/ "*\[*D\]*") /set prompt_bits=%{prompt_bits}d%;/endif%;\
    /if ({PL} =/ "*\**") /set prompt_bits=%{prompt_bits}*%;/endif%;\
    /if ({PL} =/ "*\^*") /set prompt_bits=%{prompt_bits}^%;/endif%;\
    /if ({PL} =/ "*\?*") /set prompt_bits=%{prompt_bits}?%;/endif%;\
    /set curr_hp=$[strip_attr({P1})]%;/set max_hp=$[strip_attr({P2})]%;\
    /set curr_mana=$[strip_attr({P3})]%;/set max_mana=$[strip_attr({P4})]%;\
    /set curr_mhp=$[strip_attr({P5})]%;/set max_mhp=$[strip_attr({P6})]%;\
    /set curr_move=$[strip_attr({P7})]%;/set max_move=$[strip_attr({P8})]%;\
    /set tnl=$[strip_attr({P9})]%;/set displayTNL=TNL:%{tnl}%;\
    /if (ticktoggle=1) /set ticktoggle=0%;\
    /else \
        /if ((next_tick) & (curr_hp > last_hp | curr_mana > last_mana | curr_move > last_move)) \
            /tickset%; \
        /endif%; \
        /if (curr_hp > last_hp) /set hpRegen=$[curr_hp-last_hp]%;\
        /elseif (curr_hp < last_hp) /set damtaken=$[damtaken+last_hp-currhp] %; \
        /endif %; \
        /if (curr_mana > last_mana) /set manaRegen=$[curr_mana-last_mana]%;/endif %; \
        /if (curr_move > last_move) /set moveRegen=$[curr_move-last_move]%;/endif %; \
        /set last_hp=%curr_hp %; \
        /set last_mana=%curr_mana %; \
        /set last_move=%curr_move %; \
    /endif%;\
    /if ({tnl} <= {tnlthreshold} & lvlon=0) \
        /set lvlon=1 %; \
        /lvl %; \
    /elseif ({tnl} > {tnlthreshold} & lvlon=1) \
        /set lvlon=0 %; \
        /unlvl %;\
    /endif %; \
;;; Autohealing checks
    /if ({autoheal}=1 & {healToggle}=1 & ({curr_mhp} < {max_mhp}-{healRedux})) \
        /if ({mytier} =/ "lord") \
            /if ({curr_mhp} < {max_mhp}-({comfGain}*3)) \
                c comfort %{currentMonitor}%;\
            /endif%;\
            /if ({curr_mhp} < {max_mhp}-({comfGain}*2)) \
                c comfort %{currentMonitor}%;\
            /endif%;\
            /if ({curr_mhp} < {max_mhp}-({comfGain})) \
                c comfort %{currentMonitor}%;\
                /set healToggle=0%;\
                /send punch%;\
            /endif%;\
        /else \
            /if ({curr_mhp} < {max_mhp}-({divGain}+{healGain}+{cureLightGain})) \
                c divinity %{currentMonitor}%;\
            /endif%;\
            /if ({curr_mhp} < {max_mhp}-({healGain}+{cureLightGain})) \
                c heal %{currentMonitor}%;\
            /endif%;\
            /if ({curr_mhp} < {max_mhp}-{cureLightGain}) \
                c 'cure light' %{currentMonitor}%;\
                /set healToggle=0%;\
                /send punch%;\
            /endif%;\
        /endif%;\
    /endif%;\
    /set nexttic=$[next_tick - $(/time @)]%;\
    /if ({nexttic} >= 20) /status_edit nexttic:4:Cgreen%;\
    /elseif ({nexttic} <= 10) /status_edit nexttic:4:Cred%;\
    /else /status_edit nexttic:4:Cyellow%;\
    /endif%;\
    /let per_hp=$[trunc(100.0*{curr_hp}/{max_hp})] %; \
    /if ({max_mana} <= 0 ) /let per_mana=0%;\
    /else /let per_mana=$[trunc((100.0*{curr_mana})/{max_mana})]%;\
    /endif%;\
    /let per_move=$[trunc((100.0*{curr_move})/{max_move})] %; \
    /let per_mhp=$[(curr_mhp=~"-"?"0":(trunc((100.0*{curr_mhp})/{max_mhp})))] %; \
    /let per_tnl=$[trunc((100.0*{tnl})/{myTnl})] %; \
    /if ({per_hp} >= 90) /status_edit curr_hp:6:Cgreen%;\
    /elseif ({per_hp} <= 30) /status_edit curr_hp:6:Cred%;\
    /else /status_edit curr_hp:6:Cyellow%;\
    /endif%;\
    /if ({per_mana} >= 90) /status_edit curr_mana:6:Cgreen%;\
    /elseif ({per_mana} <= 30) /status_edit curr_mana:6:Cred%;\
    /else /status_edit curr_mana:6:Cyellow%;\
    /endif%;\
    /if ({per_move} >= 90) /status_edit curr_move:6:Cgreen%;\
    /elseif ({per_move} <= 30) /status_edit curr_move:6:Cred%;\
    /else /status_edit curr_move:6:Cyellow%;\
    /endif%;\
    /if ({per_mhp} >= 90) /status_edit curr_mhp:6:Cgreen%;\
    /elseif ({per_mhp} <= 30) /status_edit curr_mhp:6:Cred%;\
    /else /status_edit curr_mhp:6:Cyellow%;\
    /endif%;\
    /if ({per_tnl} >= 90) /status_edit displayTNL:9:Cgreen%;\
    /elseif ({per_tnl} <= 30) /status_edit displayTNL:9:Cred%;\
    /else /status_edit displayTNL:9:Cyellow%;\
    /endif%;\
    /if ({per_mana}=100) \
        /if /ismacro full_mana_action%; /then /full_mana_action%;/undef full_mana_action%;/endif%;\
    /endif%;\
    /if ({per_hp}=100) \
        /if /ismacro full_hp_action%; /then /full_hp_action%;/undef full_hp_action%;/endif%;\
    /endif%;\
    /if ({per_move}=100) \
        /if /ismacro full_move_action%; /then /full_move_action%;/undef full_move_action%;/endif%;\
    /endif%;\
    /promptHookCheck%;\
    /if ({visual} =~ "off")  /show_prompt%; /endif

;;; ----------------------------------------------------------------------------
;;; Extra prompt
;;; ----------------------------------------------------------------------------
;;You do not have enough mana to cast heal.
/def -mregexp -F -ag -p5 -t"\<Pos: (STUN!|DROWN|Busy|Fight|Sleep|Stand|Rest|DYING) Lag: (\d+) S:(off|[1-5]) Q:(off|[1-9]) A:(off|[1-5])\>" extra_prompt_hook = \
    /set currentPosition=$[tolower(strip_attr({P1}))]%;\
    /set mudLag=$[strip_attr({P2})]%;\
    /let _surgeLevel=$[strip_attr({P3})]%;/if ({_surgeLevel} =~ "off") /let _surgeLevel=0%;/endif%;\
    /let _quickenLevel=$[strip_attr({P4})]%;/if ({_quickenLevel} =~ "off") /let _quickenLevel=0%;/endif%;\
    /let _augmentLevel=$[strip_attr({P5})]%;/if ({_augmentLevel} =~ "off") /let _augmentLevel=0%;/endif%;\
    /let _sup=%;\
    /let _displaySpellMods=%;\
    /if ({_surgeLevel} !~ "off" & {_surgeLevel} > 0) \
        /let _displaySpellMods=S%{_surgeLevel}%;\
        /let _sup= %;\
    /endif%;\
    /if ({_quickenLevel} !~ "off" & {_quickenLevel} > 0) \
        /let _displaySpellMods=%{_displaySpellMods}%{_sup}Q%{_quickenLevel}%;\
        /let _sup= %;\
    /endif%;\
    /if ({_augmentLevel} !~ "off" & {_augmentLevel} > 0) \
        /let _displaySpellMods=%{_displaySpellMods}%{_sup}A%{_augmentLevel}%;\
    /endif%;\
    /let _prevModLen=$[strlen({displaySpellMods})]%;\
    /let _newModLen=$[strlen({_displaySpellMods})]%;\
    /set displaySpellMods=%{_displaySpellMods}%;\
    /if ({_prevModLen} > 0 & {_newModLen} == 0) \
        /status_rm_spell_mod%;\
    /elseif ({_prevModLen} > 0 & {_newModLen} > 0) \
        /status_edit_spell_mod %{_newModLen}%;\
    /elseif ({_prevModLen} == 0 & {_newModLen} > 0) \
        /status_add_spell_mod%;\
    /endif%;\
    /let this=$[tolower(world_info())]%;\
    /set displayLag=Lag:%{mudLag}%;\
    /set %{this}_wait %{mudLag}%;\
    /set %{this}_pos %{currentPosition}%;\
    /if /test {mudLag} > 0%;/then /set %{this}_cast 1%;/endif%;\
    /if /test (({mudLag} == 0) & ({currentPosition} =~ "stand"))%;/then /set %{this}_cast 1%;/endif%;\
    /if /test ((%{this}_cast == 1) & ({currentPosition} =~ "fight") & ({mudLag} == 0) & (%{this}_auto_cast == 1))%;/then /castdmg%;/set %{this}_cast 2%;/endif

;/def -F -mregexp -ag -t"^p2> ([0-9]*) ([A-Za-z]*)\s*$" prompt2 = \
;  /let this=$[tolower(world_info())]%;\
;  /let wait $[strip_attr({P1})]%;\
;  /let pos $[strip_attr({P2})]%;\
;  /set %{this}_wait %wait%;\
;  /set %{this}_pos %pos%;\
;  /if /test {wait} > 0%;/then /set %{this}_cast 1%;/endif%;\
;  /if /test (({wait} == 0) & ({pos} =~ "Stand"))%;/then /set %{this}_cast 1%;/endif%;\
;  /if /test ((%{this}_cast == 1) & ({pos} =~ "Fight") & ({wait} == 0) & (%{this}_auto_cast == 1))%;/then /castdmg%;/set %{this}_cast 2%;/endif

/def status_add_lag = /status_add -x -r1 -B displayLag:7:Cwhite
/def status_rm_lag = /status_rm displayLag

/def status_add_spell_mod = /status_add -x -r1 -Aexits displaySpellMods:9:Cyellow
/def status_rm_spell_mod = /status_rm displaySpellMods
/def status_edit_spell_mod = /status_edit -r1 displaySpellMods:%{1}:Cyellow

/def status_add_exits = /status_add -x -r1 -AdisplayLag exits:9:Ccyan
/def status_rm_exits = /status_rm exits

/def status_add_misc = /status_add -x -r1 -Aexits status_misc:8:Cmagenta
/def status_edit_misc = /status_edit -r1 status_misc:%{1}:Cmagenta
/def status_rm_misc = /status_rm status_misc

/def status_add_world = /status_add -xB -r1 @world:13:Cred
/def status_rm_world = /status_rm @world
/def status_edit_world = /status_edit -r1 @world:%{1}:Cred

;; Add/remove monitored people to status line 3.
/set numMonitors=0
/def addmon = \
    /if ({#} != 2) /echo -pw /addmon [name] [HP|MN|MV]@{n}%;\
    /else \
        /if ({status_height} < 3) /set status_height=3%;/endif%;\
        /let _lcname=$[tolower({1})]%;\
        /let _ucstat=$[toupper({2})]%;\
        /let _tmsg=$(/listvar -vmglob displayMonitor%{_ucstat}_%{_lcname}) %; \
        /let _msgLen=$[strlen({_tmsg})]%;\
        /status_add -x -r2 -A displayMonitor%{_ucstat}_%{_lcname}:%{_msgLen}:Cgreen%;\
        /set numMonitors=$[++numMonitors]%;\
    /endif
/def rmmon = \
    /if ({#} != 2) /echo -pw /rmmon [name] [HP|MN|MV]@{n}%;\
    /else \
        /let _lcname=$[tolower({1})]%;\
        /let _ucstat=$[toupper({2})]%;\
        /status_rm displayMonitor%{_ucstat}_%{_lcname}%;\
        /unset displayMonitor%{_ucstat}_%{_lcname}%;\
        /set numMonitors=$[--numMonitors]%;\
        /if ({numMonitors} == 0) /set status_height=2%;/endif%;\
    /endif

;; Configure the prompt display
/def my_default_prompt = \
    /status_defaults%;\
    /clock off%;\
    /status_rm @more%;\
    /status_rm @world%;\
    /status_rm @read%;\
    /status_rm @active%;\
    /status_rm @log%;\
    /status_rm @mail%;\
    /status_rm @clock%;\
    /status_add -B prompt_bits:5:hCyellow :1 nexttic:4 :1 curr_hp:6 "/":1:Cyellow max_hp:6:Cgreen "hp":2:Cyellow :1 curr_mana:5 "/":1:Cyellow max_mana:5:Cgreen "ma":2:Cyellow :1 curr_move:5 "/":1:Cyellow max_move:5:Cgreen "mv":2:Cyellow :1 curr_mhp:6 "/":1:Cyellow max_mhp:6:Cgreen "mo":2:Cyellow :1 displayBranLeft:8 displayTNL:9 :1 displayXP:9:Cyellow%;\
    /status_add_lag%;/status_add_exits%;/status_add_spell_mod%;\
    /status_add_world%;\
    /status_add -x -r1 -A@world mytier:4:Cgreen%;\
    /status_add -x -r1 -Amytier mylevel:4:CCyan
