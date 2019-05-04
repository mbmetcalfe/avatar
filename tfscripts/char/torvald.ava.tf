;;; ----------------------------------------------------------------------------
;;; torvald.ava.tf
;;; Specific variables/macroes for Torvald
;;; Oct. 10, 2014 Automorphed (2 levels): 11874 hp 21532 ma 6904 mv
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; Gear stuff
;;; ----------------------------------------------------------------------------
;/load -q char/torvald.gear.ava.tf
/cleangear
/set main_bag "jumpsuit white loot"
/load -q char/lord.ac3.ava.tf

/def -wtorvald torvaldunlvl = /send rem levelgear=wear %{ac_about}
/def -wtorvald torvaldlvl = /send wear levelgear
/def torvaldmidround = /send -wtorvald c thunderhead
/def strat=/send c stratum %{*}
/def thunderstrat=/strat spring%;/strat thunderhead

;;; ----------------------------------------------------------------------------
;;; Hero spell aliases
;;; Cloudburst - single target; Hail Storm - AoE
;;; ----------------------------------------------------------------------------
/alias di \
    /if ({#} > 1 | {1} > 0) surge %1%;/endif%;\
    c disintegrate %2%;\
    /if ({#} > 1 | {1} > 0) surge off%;/endif

/alias ahail \
    /clrq%;\
    /send wear lighting=c 'hail storm'%;\
    /set autocast=0%;\
    /acast%;\
    /addq /acast
/alias acloud \
    /clrq%;\
    /send wear fire=c cloudburst%;\
    /set autocast=0%;\
    /acast%;\
    /addq /acast
    
;;; ----------------------------------------------------------------------------
;;; Lord spell aliases
;;; Thunderhead - single target; Blizzard - AoE
;;; ----------------------------------------------------------------------------
/alias mael \
    /if ({#} > 1 | {1} > 0) surge %1%;/endif%;\
    c maelstrom %2%;\
    /if ({#} > 1 | {1} > 0) surge off%;/endif

/alias bliz /send c blizzard
/alias abliz \
    /clrq%;\
    /send c 'blizzard'%;\
    /set autocast=0%;\
    /acast%;\
    /addq /acast

/alias thun /send c thunderhead
/alias athun \
    /clrq%;\
    /send c thunderhead %1%;\
    /set autocast=0%;\
    /acast%;\
    /addq /acast

;;; ----------------------------------------------------------------------------
;;; Triggers to toggle stuff when entering/leaving sustained spells so that the
;;; spells are not broken inadvertantly.
;;; ----------------------------------------------------------------------------

/def -mglob -p9 -F -t"You call forth a blitz of hail\!" hail_storm_toggle = \
    /set autolkb=0%;/set autoloot 0
;/def -mglob -p9 -F -t"The hail stops, and all is eerily silent\." hail_storm_tickon = /tickon
/def -mglob -p9 -F -t"You gather the wrath of the clouds\!" cloudburst_tickoff = \
    /set autolkb=0%;/set autoloot 0
;/def -mglob -p9 -F -t"The clouds calm, and the lightning subsides\." cloudburst_tickon = /tickon

/def -mglob -p9 -F -t"Swirling snow and ice arrive at your beckoning\!" blizzard_toggle = \
    /set autolkb=0%;/set autoloot 0
;/def -mglob -p9 -F -t"Your blizzard dwindles to a flurry, then stops\." hail_storm_tickon = /tickon

;; Load in the variables saved from previous state.
/loadCharacterState torvald

