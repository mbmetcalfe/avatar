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

/def helfyresanc = /send mysanc
/def helfyrefren = /q 5 c frenzy %1

/alias df \
    /if ({#} = 1) surge %1%; /endif %;\
    c 'death field'%;\
    /if ({#} = 1) surge off%; /endif
/alias svs \
    /send cast 'sense weakness' %1%;\
    /cast on%;/aq /cast off

;; Wear seneca robe to bipass curse on the ofcol rings
/def -whelfyre -p0 -mglob -ag -h'SEND wear all' hook_helfyre_wear_all = /send wear all=get "robes sustainment" %{main_bag}=wear "robes sustainment"=wear "robe greatness"=put "robes sustainment" %{main_bag}

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

