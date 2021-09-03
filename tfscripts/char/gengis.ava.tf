;;; gengis.ava.tf
;;; April 08, 2004:	Morphed at level 695: 4062 hp  20262 mana   5156mv
;;; March 25, 2010:     Remorted Sprite (worshipped Tul-Sith from level 10,
;;;                         devoted at Hero 1.)
;;; June 03, 2010 :     Morphed at level 999.  
;; 
/require healer.tf

/def -F -wgengis -mglob -t"Welcome to the AVATAR System, Lord Gengis." gengis_lord999_login = \
    /hook_resize%;\
    /let logincharname=${world_character}%;\
    /let logincharname=$[tolower({logincharname})]%;\
    /set myname=%{logincharname}%;\
    /def -hload -ag ~gagload%;\
    /undef ~gagload%;\
    /atitle (%mytier %mylevel)%;\
    /send worth 
/load -q char/gengis.gear.ava.tf

/def -wgengis gengisunlvl = \
    /def -wgengis -n2 -p10 -ag -mregexp -t"^Playerinfo (cleared|line added)\." duskrta_playerinfo_gag%;\
    /let levelDiff=$[{mylevel} - 999]%;\
    /send playeri clear=playeri + |w|Level 125(|g|999|w|+|g|%{levelDiff}|w|: |g|%{mylevel}|w|) Sprite Priest%;\
    /send unlvl
    
/def -wgengis grheal = /noheal%;/graction /addheal

/def gengissanc = \
    /if ({currentPosition} =~ "stand" & {mudLag} < 3) /send preach sanc%;\
    /else /send quicken 9=c innocence=quicken off=preach sanc%;\
    /endif

/def -wgengis gsup = \
    filter +spellother%; \
    gtell |c|Ok, here comes spells, sleep if you want to avoid spam.  If you are a Lord, you may want to |y|remove capes|c| and turn off savespell.|w|%; \
    preach water breath%;preach iron skin%;preach fortitudes%;remove all.cape%;preach foci%;wear all.cape%;preach aegis%;preach sanct%;preach holy sight%; \
    filter -spellother


;;; ----------------------------------------------------------------------------
;;; combat assistance aliases
;;; ----------------------------------------------------------------------------
/alias inno \
    /if ({#} > 1 | {1} > 0) \
        /let _quicken=1%;\
        quicken %1%;\
        /shift%;\
    /endif%;\
    c innocence %1%;\
    /if ({_quicken} = 1) quicken off%;/endif

/alias pinno \
    /if ({#} = 1 | {1} > 0) \
        /let _quicken=1%;\
        quicken %1%;\
        /shift%;\
    /endif%;\
    preach innocence%;\
    /if ({_quicken} = 1) quicken off%;/endif

;;; ----------------------------------------------------------------------------
;;; preached healing aliases
;;; ----------------------------------------------------------------------------
/alias pcl \
    /if ({#} > 1 | {1} > 0) \
        /let _augment=1%;\
        augment %1%;\
        /shift%;\
    /endif%;\
    preach cure light%;\
    /if ({_augment} = 1) augment off%;/endif
/alias pcc \
    /if ({#} > 1 | {1} > 0) \
        /let _augment=1%;\
        augment %1%;\
        /shift%;\
    /endif%;\
    preach cure critical%;\
    /if ({_augment} = 1) augment off%;/endif
/alias phe \
    /if ({#} > 1 | {1} > 0) \
        /let _augment=1%;\
        augment %1%;\
        /shift%;\
    /endif%;\
    preach heal%;\
    /if ({_augment} = 1) augment off%;/endif
/alias pdiv \
    /if ({#} > 1 | {1} > 0) \
        /let _augment=1%;\
        augment %1%;\
        /shift%;\
    /endif%;\
    preach divinity%;\
    /if ({_augment} = 1) augment off%;/endif
/alias pcomf \
    /if ({#} > 1 | {1} > 0) \
        /let _augment=1%;\
        augment %1%;\
        /shift%;\
    /endif%;\
    preach comfort%;\
    /if ({_augment} = 1) augment off%;/endif

;;; ----------------------------------------------------------------------------
;;; offensive spell aliases
;;; ----------------------------------------------------------------------------
/alias wf \
    /if ({#} > 1 | {1} > 0) surge %1%;/endif%;\
    c 'white fire'%;\
    /if ({#} > 1 | {1} > 0) surge off%;/endif
/alias wl \
    /if ({#} > 1 | {1} > 0) quicken %1%;/endif%;\
    c 'white light'%;\
    /if ({#} > 1 | {1} > 0) quicken off%;/endif

;;; scripts to bipass migraine effects if stuff is stacked
/def -wgengis -p900 -mregexp -ahCwhite -t"^You feel a slight headache growing stronger\.\.\." gengis_migraine = /if ({running}=1) c 'water breath'%;/endif

;;; ----------------------------------------------------------------------------
;;; Autohealing setup
;;; ----------------------------------------------------------------------------
/def goodtank = \
    /set comfGain=1698%;\
    /set divGain=376%;\
    /set healGain=188%;\
    /set cureCriticalGain=111%;\
    /set cureSeriousGain=74%;\
    /set cureLightGain=37
/def eviltank = \
    /set comfGain=1500%;\
    /set divGain=157%;\
    /set healGain=78%;\
    /set cureCriticalGain=46%;\
    /set cureSeriousGain=31%;\
    /set cureLightGain=15

/def -mglob -p1 -ag -wgengis -t"Wow, that takes talent." autoheal_toggle = \
    /if ({autoheal}=1 & {healToggle}=0) /set healToggle=1%;/endif

;;; --- do some things when told to return to Thorngate
/def -p90 -au -F -mregexp -t"\*?([a-zA-Z]+)\*? tells the group 'home'" gengis_auto_leader_homeshift = \
    /if (({P1} =~ {leader}) & ($(/getvar auto_home) == 1)) /healbot off%;/endif
/def -p90 -au -F -mregexp -t"\*?([a-zA-Z]+)\*? tells the group 'plane thorn'" gengis_auto_leader_planeshift = \
    /if (({P1} =~ {leader}) & ($(/getvar auto_home) == 1)) /healbot off%;/endif

;; Load in the variables saved from previous state.
/loadCharacterState gengis
