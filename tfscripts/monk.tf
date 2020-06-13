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

;; TODO: Create macro to quickly modify secondary ctr to use when mob is pushed.
/def -p1 -mregexp -t'Your counterattack knocks (.*) down!' ctrpushed = \
    /set ctrpush=$[++ctrpush]%; \
    /send ctr kick stay%;\
    /addq ctr push stay

/def -ag -mregexp -t"You are prepared to use ([a-zA-Z]+)\." monk_current_ctr = \
    /echo -p @{Cyellow}You are prepared to use @{hCgreen}%P1@{nCyellow}.@{n}
/def -ahCyellow -p5 -mregexp -t"You will continue using this [a-zA-Z]+ until you change it\." monk_current_ctr_stay

;;; ----------------------------------------------------------------------------
;;; Monk Qi/Chakra stuff
;;; Abilities that yield Inner Qi include kick, rescue, trip, toss, shatter strike, and chakra strike.
;;; ----------------------------------------------------------------------------
/def -mregexp -t"^[-'A-Za-z ]+'s (green|purple|red|white|yellow) chakra pulses with (brilliant |)energy." chakra_scan = /set last_chakra_scan=%{P1}

;; Chakra scan to see what colours to drain
/alias qs /send look %{1} chakra

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
/alias qsi \
    /let _color=%{last_chakra_scan}%;\
    /if ({#}=2) /send qi strike %{1} %{2}%;\
    /elseif ({#}=1) /send qi strike %{1} %{last_chakra_scan}%;\
    /else /send qi strike %{last_chakra_scan}%;\
    /endif%;

/alias qt /send qi thrust %{1}
/alias qp /send qi punch %{1}

;;; Outer Qi techniques
;; Spirit blast -- single target damage
/alias qsb /send qi blast %{1}

;;; ----------------------------------------------------------------------------
;;; Qi prompt
;;; ----------------------------------------------------------------------------
/def setqiprompt = /send prompt2 <QiI: %%j/%%J QiO:%%k/%%K>%%n
/def -mregexp -F -ag -p5 -t"\<QiI\: ([0-9]+)\/([0-9]+) QiO\:([0-9]+)\/([0-9]+)\>" mon_qi_prompt_hook = \
    /set innerQi=$[strip_attr({P1})]%;/set maxInnerQi=$[strip_attr({P2})]%;\
    /set outerQi=$[strip_attr({P3})]%;/set maxOuterQi=$[strip_attr({P4})]%;\
    /set displayInnerQi=i[%{innerQi}/%{maxInnerQi}]%;\
    /set displayOuterQi=o[%{outerQi}/%{maxOuterQi}]

/def status_add_mon = \
    /status_add -x -r1 -A displayInnerQi:7%;\
    /status_add -x -r1 -AdisplayInnerQi:7 -s1 displayOuterQi:7
/def status_rm_mon = /status_rm displayInnerQi%;/status_rm displayOuterQi

