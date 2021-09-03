;-------------------------------------------------------------------------------
;;; duskrta.ava.tf
;; Duskrta: Wrongdoing, evil action, misdeed, sin; external sins of the body 
;;          and the mouth; a light sin.
;; Hero 1:     314 hp, 704 m, 482 mv.
;; Hero 101:   644 hp, 1428 m, 1496 mv.
;; Hero 999:   3725 hp, 8037 m, 4177 mv.
;; 20091207: Killed UD (Hero 585) - Started with fear/flash, then q6 torment
;;          After UD died: 1570/2813 hp 922/4995 mana
;; 20140829: Automorphed (4 levels): 5601 hp 36275 mana 6280 mv
;; 20190927: Lord 999:   9692 hp, 44210 m, 10105 mv.
;; Aug 29, 2014 - Automorphed (4 levels): 5601 hp 36275 mana 6280 mv
;-------------------------------------------------------------------------------
/def -F -wduskrta -mglob -t"Welcome to the AVATAR System, Lord Duskrta." duskrta_lord999_login = \
    /hook_resize%;\
    /let logincharname=${world_character}%;\
    /let logincharname=$[tolower({logincharname})]%;\
    /set myname=%{logincharname}%;\
    /def -hload -ag ~gagload%;\
    /undef ~gagload%;\
    /atitle (%mytier %mylevel)%;\
    /send worth

;;; ----------------------------------------------------------------------------
;;; Gear stuff
;;; ----------------------------------------------------------------------------
;/load -q char/duskrta.gear.ava.tf
/set main_bag "floating icesphere loot"
/load -q char/lord.ac3.ava.tf

;Level 125(999) High Elf Sorcerer
/def -wduskrta duskrtaunlvl = \
    /def -wduskrta -n2 -p10 -ag -mregexp -t"^Playerinfo (cleared|line added)\." duskrta_playerinfo_gag%;\
    /let levelDiff=$[{mylevel} - 999]%;\
    /send playeri clear=playeri + |w|Level 125(|g|999|w|+|g|%{levelDiff}|w|: |g|%{mylevel}|w|) High Elf Sorcerer
;/def -wduskrta duskrtalvl = /send wear levelgear

;;; ----------------------------------------------------------------------------
;;; duskrtaPromptHookCheck is called from the prompt_hook via /promptHookCheck
;;; What we want to do here is just turn off surge when duskrta is < 10000 mana.
;;; ----------------------------------------------------------------------------
/set duskrtaPromptHookCheckToggle=1
/set duskrtaManaThreshold=9000
/def duskrtaPromptHookCheck = \
    /if ({curr_mana} < {duskrtaManaThreshold} & {max_mana} > {duskrtaManaThreshold} & {duskrtaPromptHookCheckToggle} == 1) \
        /echo -pw @{hCmagenta}Mana below threshold (%{duskrtaManaThreshold}). Turning @{hCred}OFF@{hCmagenta} surge.  Will turn toggle back on when mana is full.@{n}%;\
        /send -wduskrta surge off%;\
        /set duskrtaPromptHookCheckToggle=0%;\
        /def full_mana_action=/set duskrtaPromptHookCheckToggle=1%%;/echo -pw @{hCmagenta}Surge/Mana toggle check back @{hCgreen}ON@{hCmagenta}.@{n}%%;/addq surge 2%;\
        /if ({multi} == 1) /send gtell Mana low, turning surge off%;/endif%;\
    /elseif ({curr_mana} > {duskrtaManaThreshold} & {max_mana} > {duskrtaManaThreshold} & {duskrtaPromptHookCheckToggle} == 0) \
        /echo -pw @{hCmagenta}Mana above threshold (%{duskrtaManaThreshold}). Turning @{hCgreen}ON@{hCmagenta} surge.@{n}%;\
        /send -wduskrta surge 2%;\
        /set duskrtaPromptHookCheckToggle=1%;\
        /if ({multi} == 1) /send gtell Mana low, turning surge off%;/endif%;\
    /endif

/def duskrtaThreshold = \
        /echo -pw @{hCmagenta}Mana above threshold (%{duskrtaManaThreshold}). Turning @{hCgreen}ON@{hCmagenta} surge.@{n}%;\
        /send -wduskrta surge 2%;\
        /set duskrtaPromptHookCheckToggle=1%;\
        /if ({multi} == 1) /send gtell Mana low, turning surge off%;/endif

;-------------------------------------------------------------------------------
;;; spell aliases
;-------------------------------------------------------------------------------
/alias immo /send c immolation %1
/alias vamp \
    /if ({#} > 1 | {1} > 0) surge %1%;/endif%;\
    c 'vampire touch' %2%;\
    /if ({#} > 1 | {1} > 0) surge off%;/endif

/alias torm \
    /if ({#} > 1 | {1} > 0) surge %1%;/endif%;\
    c 'torment' %2%;\
    /if ({#} > 1 | {1} > 0) surge off%;/endif

/alias brim \
    /if ({#} > 1 | {1} > 0) surge %1%;/endif%;\
    c 'brimstone' %2%;\
    /if ({#} > 1 | {1} > 0) surge off%;/endif
/def tbrim = /if ({autocast}=1) c brim%;inv%;/repeat -0:00:35 1 /tbrim%;/endif

/def duskrtamidround = /send -wduskrta c %{duskrtaMidSpell}
;;; ----------------------------------------------------------------------------
;;; duskrtaPromptHookCheck is called from the prompt_hook via /promptHookCheck
;;; What we want to do here is just turn off surge when Duskrta is < 10000 mana.
;;; ----------------------------------------------------------------------------
/set duskrtaPromptHookCheckToggle=1
/set duskrtaManaThreshold=10000
/def duskrtaPromptHookCheck = \
    /if ({curr_mana} < {duskrtaManaThreshold} & {max_mana} > {duskrtaManaThreshold} & {duskrtaPromptHookCheckToggle} == 1) \
        /echo -pw @{hCmagenta}Mana below threshold. Turning @{hCred}OFF@{hCmagenta} surge.  Will turn toggle back on when mana is full.@{n}%;\
        /send -wduskrta surge off%;\
        /set duskrtaPromptHookCheckToggle=0%;\
        /def full_mana_action=/set duskrtaPromptHookCheckToggle=1%%;/addq surge 2%%;/echo -pw @{hCmagenta}Surge/Mana toggle check back @{hCgreen}ON@{hCmagenta}.@{n}%;\
    /endif

;-------------------------------------------------------------------------------
/alias ratt get rattle %main_bag%;wear rattle%;zap %1%;wear %unbrandish%;put rattle %main_bag

;-------------------------------------------------------------------------------

/def -F -mglob -t"You vampire touch * with *!" vamptouch_ticktoggle = /set ticktoggle=1
;/def -mglob -t"You summon a meandering pillar of flame\!" pillar_of_flames_tickoff = \
;    /set autolkb=0
;/def -mglob -t"Your pillar of flame peters out and vanishes\." pillar_of_flams_tickon = /tickon


;/def -wduskrta -p9 -ag -mregexp -F -t"\'s attac.* strikes? you [0-9]* (time|times), with .* [a-zA-Z]*(\.|\!)$" duskrta_aggie_swap_flash = \
;    /if ({running}==1) /q 6 c flash%;/endif
;/def -wduskrta -p9 -ag -mregexp -F -t"\'s attacks haven\'t hurt you\!$" duskrta_nil_aggie_flash = \
;    /if ({running}==1) /q 6 c flash%;/endif

/def -wduskrta -mregexp -t"^Your innate mental strength defeats ([a-zA-Z]+)'s frenzy spell\!" duskrta_tranquil_frenzy = /send emote is filled with rage!

/def -wduskrta -mglob -t"One of your Exhaust timers has elapsed. (unholy bargain)" duskrta_unholy_bargain_avail = \
    /if ({refreshmisc} == 1) /refreshSpell 'unholy bargain'%;/endif

/def -wduskrta -p5 -au -mregexp -t"^Djehuti gives you a shroud of shadow." duskrta_djehuti_gives_shroud = \
    /setMySpell brimstone
    

;; Load in the variables saved from previous state.
/loadCharacterState duskrta
