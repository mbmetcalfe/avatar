;;; ----------------------------------------------------------------------------
;;; File: monk.tf
;;; File used for macroes/triggers useful for monk-type characters
;;; ----------------------------------------------------------------------------
;;; Mark this file as already loaded, for /require.
/loaded __TFSCRIPTS__/monk.tf

;;; ----------------------------------------------------------------------------
;;; Stance aliases
;;; ----------------------------------------------------------------------------
/alias tiger /send stance tiger
/alias emu /send stance emu
/alias bear /send stance bear
;; shf stances
/alias vam /send stance vampire fang
/alias spec /send stance spectral fang

;;; ----------------------------------------------------------------------------
;;; Counter aliases
;;; add stay to the call to have it stay (i.e. ckick stay)
;;; ----------------------------------------------------------------------------
/alias cdis /send ctr disarm %1
/alias ckick /send ctr kick %1
/alias cpush /send ctr push %1
/alias ctrip /send ctr trip %1
/alias cshat /send ctr shatter %1

;;; ----------------------------------------------------------------------------
;;; Miscellaneous other aliases
;;; ----------------------------------------------------------------------------
/alias shat /send shatter %1

/def postpush = \
    /setvar postpush %1%;\
   /echo -pw @{Cred}[CHAR INFO:] After counterpush, you will @{Cwhite}ctr $(/getvar postpush)@{Cred}.@{n}

/def -p1 -mregexp -t'Your counterattack knocks (.*) down!' ctrpushed = \
    /set ctrpush=$[++ctrpush]%; \
    /send ctr $(/getvar postpush) stay%;\
    /addq ctr push stay

/def -p1 -mregexp -t'^You trip (.*) and (.*) goes down!' ctrtripped = \
    /set ctrtrip=$[++ctrtrip]%;\
    /if (regmatch({myclass}, "mon shf")) \
        /send ctr $(/getvar postpush) stay%;\
        /addq ctr trip stay%;\
    /endif

/def -ag -mregexp -t"You are prepared to use ([a-zA-Z]+)\." monk_current_ctr = \
    /echo -p @{Cyellow}You are prepared to use @{hCgreen}%P1@{nCyellow}.@{n}
/def -ahCyellow -p5 -mregexp -t"You will continue using this [a-zA-Z]+ until you change it\." monk_current_ctr_stay

;;; ----------------------------------------------------------------------------
;;; Monk Qi/Chakra stuff
;;; Abilities that yield Inner Qi include kick, rescue, trip, toss, shatter strike, and chakra strike.
;;; ----------------------------------------------------------------------------
/def -mregexp -t"^[-'A-Za-z ]+'s (green|purple|red|white|yellow) chakra pulses with (brilliant |)energy." chakra_scan = \
    /set last_chakra_scan=%{P1}%;\
    /if ({P1} =~ "green") /let drain_type=resistance to certain types of damage%;\
    /elseif ({P1} =~ "purple") /let drain_type=melee power%;\
    /elseif ({P1} =~ "red") /let drain_type=damage roll%;\
    /elseif ({P1} =~ "white") /let drain_type=armor class%;\
    /elseif ({P1} =~ "yellow") /let drain_type=damage soak%;\
    /endif%;\
    /echo -pw @{Cred}[CHAR INFO:] @{hCyellow}%{P1} @{nCred}empowers @{hCyellow}%{drain_type}@{xCred}.@{n}

;; Chakra scan to see what colours to drain
/alias qs /send look %{1} chakra
/alias qski qs %1%;/send kill %1

;; hand mods
/alias sf /send c 'stone fist'
/alias dh /send c 'dagger hand'

; You focus on the Dagger Hand technique.
/set monkHandMod=dagger hand
/def -mglob -p5 -t"Your hands return to normal." monk_hand_mod_fall =\
    /if ({refreshmisc} == 1) \
        /refreshSpell '%{monkHandMod}'%;\
    /endif

;;; Inner Qi techniques
;;CHAKRA STRIKE
;; syntax:   qi strike <target> <color>
;;     or    qi strike <color>
;; Name                 Cost  Qi Type   Command
;; chakra strike           1  Inner Qi  strike
;; crushing punch          2  Inner Qi  punch
;; unicorn thrust          2  Inner Qi  thrust
;; shadow blast            5  Outer Qi  blast
/def qiatk = \
    /setvar qiattack %1%;\
    /echo -pw @{Cred}[CHAR INFO:] Qi Attack command set to: @{Cwhite}$(/getvar qiattack)@{Cred}.@{n}

/alias qsi \
    /let _color=%{last_chakra_scan}%;\
    /if ({#}=2) /send qi strike %{1} %{2}%;\
    /elseif ({#}=1) /send qi strike %{1} %{last_chakra_scan}%;\
    /else /send qi strike %{last_chakra_scan}%;\
    /endif

/alias qd \
    /let _color=%{last_chakra_scan}%;\
    /if ({#}=2) /send qi drain %{1} %{2}%;\
    /elseif ({#}=1) /send qi drain %{1} %{last_chakra_scan}%;\
    /else /send qi drain %{last_chakra_scan}%;\
    /endif

;;; Inner Qi techniques
/alias qit /send qi thrust %{1}
/alias qip /send qi punch %{1}

;;; Outer Qi techniques
;; Shadow blast -- single target damage
/alias qib /send qi blast %{1}

;;; ----------------------------------------------------------------------------
;;; Qi prompt
;;; ----------------------------------------------------------------------------
/def setqiprompt = /send prompt2 <P:%%e L:%%s S:%%S Q:%%Q A:%%A QI: %%j/%%J QO:%%k/%%K>%%n
/def -mregexp -F -ag -p5 -t"\<P:(STUN!|DROWN|Busy|Fight|Sleep|Stand|Rest|DYING) L:(\d+) S:(off|[1-5]) Q:(off|[1-9]) A:(off|[1-5]) QI\: ([0-9]+)\/([0-9]+) QO\:([0-9]+)\/([0-9]+)\>" mon_qi_prompt_hook = \
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
    /set innerQi=$[strip_attr({P6})]%;/set maxInnerQi=$[strip_attr({P7})]%;\
    /set outerQi=$[strip_attr({P8})]%;/set maxOuterQi=$[strip_attr({P9})]%;\
    /set displayInnerQi=i[%{innerQi}/%{maxInnerQi}]%;\
    /set displayOuterQi=o[%{outerQi}/%{maxOuterQi}]%;\
    /let this=$[tolower(world_info())]%;\
    /set displayLag=Lag:%{mudLag}%;\
    /set %{this}_wait %{mudLag}%;\
    /set %{this}_pos %{currentPosition}%;\
    /if /test {mudLag} > 0%;/then /set %{this}_cast 1%;/endif%;\
    /if /test (({mudLag} == 0) & ({currentPosition} =~ "stand"))%;/then /set %{this}_cast 1%;/endif%;\
    /if /test ((%{this}_cast == 1) & ({currentPosition} =~ "fight") & ({mudLag} == 0) & (%{this}_auto_cast == 1))%;/then /castdmg%;/set %{this}_cast 2%;/endif

/def status_add_mon = \
    /status_add -x -r1 -A displayInnerQi:7%;\
    /status_add -x -r1 -AdisplayInnerQi:7 -s1 displayOuterQi:7
/def status_rm_mon = /status_rm displayInnerQi%;/status_rm displayOuterQi

