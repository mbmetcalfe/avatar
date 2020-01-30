;;; helfyre.ava.tf
;;; Specific variables/macroes for Helfyre
;;; Hero 254, evolved to black dragon (4 tries)
;;; Went full hit, stabbed, swapped to ac, and s3 ultra/quaffed.
;;; Had an intervention potion and accidentally stayed in mana 
;;; gear until it kicked in.  Used 10 3xdiv pots as well.

;;; read in Helfyre's gear file
/load -q char/helfyre.gear.ava.tf
/require rogue.tf
/require psionic.tf

/def -whelfyre wa = /send wake%;/mana2hit
;/def -whelfyre wa = /send wake%;/mana2ac
/def helfyresanc = /send mysanc
/def helfyremidround = /send -whelfyre c ultrablast

/alias df \
    /if ({#} = 1) surge %1%; /endif %;\
    c 'death field'%;\
    /if ({#} = 1) surge off%; /endif

/def ultcost = \
    /mcost Ultrablast 37%;\
    /mcost Ultrablast-S@{hCmagenta}2 111%;\
    /mcost Ultrablast-S@{hCmagenta}3 222%;\
    /mcost Ultrablast-Q@{hCgreen}1 74%;\
    /mcost Ultrablast-Q@{hCgreen}2 111%;\
    /mcost Ultrablast-Q@{hCgreen}3 148%;\
    /mcost Ultrablast-Q@{hCgreen}4 185%;\
    /mcost Ultrablast-Q@{hCgreen}5 222%;\
    /mcost Ultrablast-Q@{hCgreen}6 259%;\
    /mcost Ultrablast-Q@{hCgreen}7 296%;\
    /mcost Ultrablast-Q@{hCgreen}8 333%;\
    /mcost Ultrablast-Q@{hCgreen}9 371

/set grouped_fusilier=Giterdun
/def -p2 -ah -whelfyre -mglob -t"* catches it\!" fusilier_mob_catch = \
    /addq get short corpse#give short %{grouped_fusilier}

;; Racial prowl support
;; Prowl can only be used during nighttime which lasts from 8pm until 6 am game time.
/def -whelfyre -p99 -F -mregexp -t"^Racial prowl fatigue for  ([\d]+) hours\.$" prowl_fatigue_left = \
    /set prowlFatigue=%{P1}
;Spell: 'midnight prowl'  modifies stealth by + 2% for 5 hours.
/def -whelfyre -abh -p5 -mregexp -t"^It is ([\d]+) o'clock (am|pm)\, Day of [\w ]+\, [\d]+(th|st|nd|rd) day in the Month of the [\w ]+\.$" prowl_mud_date = \
    /set canProwl=0%;\
    /let prowlHour=$[strip_attr({P1})]%;/let prowlTimeAttr=$[strip_attr({P2})]%;\
    /if (({prowlTimeAttr} =~ "am" & ({prowlHour} <= 6 | {prowlHour} = 12)) | ({prowlTimeAttr} =~ "pm" & ({prowlHour} >= 8) & {prowlHour} != 12)) \
        /set canProwl=1%;\
    /endif%;\
    /if ({canProwl} = 1) /echo -pw %%% @{Cwhite}Night time, can prowl%;/endif

/def -whelfyre -ah -p5 -mregexp -t"^You must wait for nightfall before you can begin the hunt\." prowl_daytime = /set canProwl=0

/def -whelfyre -mglob -p1 -t"Mayflower, Explorer and Trailblazer exclaims 'Follow me for Ocean Transport!'" mayflower_timed_follow = \
    /if ({leader} =~ "Self") /repeat -0:0:04 1 /send follow mayflower%;/endif

/def -whelfyre -mglob -p1 -t"Mayflower, Explorer and Trailblazer says 'All aboard! Last call for Ocean Transport! If you aren't coming, go back to the geyser.'" mayflower_setup = \
    /send vis=move=move=sneak=sneak%;\
    /if ({leader} =~ "Self") /send west=fol self=linkrefresh group%;/endif


/def -whelfyre -au -p9 -F -mglob -t'Your force shield shimmers then fades away.' helfyre_focidrop = \
    /if ({running} == 1) /send racial fly%;/endif

;; Load in the variables saved from previous state.
/loadCharacterState helfyre

