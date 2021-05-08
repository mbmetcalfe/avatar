;; autotrack.tf
;;
;; Contributors:
;;    Harliquen ( khaosse_angel@alpha.net.au )
;;
;; Avatar specific track trigger
;; Apparently it's not at all broken(?)....
;; It will automatically open doors, so long as they are unlocked, or you
;; have the key.
;;
;; /autotrack on|off (alt: /trackon|/trackoff)
;;    turn on/off auto-tracking
;; /find character|mob
;;    turns on autotrack and defines more triggers to turn off autotrack if
;;    trail is lost
;;
;; /logpath on|off
;;    if on, when you follow someone, or track something/someone, the path to
;;    them will be logged.
;; /showpath
;;    show path thus far
;; /clrpath
;;    clear current path

/def -i open =  \
    /def -t"It's locked." opentrig=/send unlock %{lastdir}=open %{lastdir}%;\
    /send open %{lastdir}%=%{lastdir}%;/set lastdir mutter%;\
    /repeat -1 1 /undef opentrig

/def autotrack = \
    /if (tolower({1}) =~ "on") \
        /trackon %; \
    /elseif (tolower({1}) =~ "off") \
        /trackoff %; \
    /else \
        /echo -p %%% @{Cyellow}Syntax: @{Cgreen}autotrack @{Cgreen}ON@{n}|@{Cred}OFF@{n}. %; \
    /endif

/def trackon =\
    /def -p5 -mregexp -t"^You see your quarry's trail head (north|south|east|west|up|down) from here!$$" tracktrig = \
        /set lastdir=%%{P1}%%; \
        /send %%{P1}%%; \
        /if /ismacro logpathtrig %%; /then \
            /addpath %%{lastdir} %%; \
        /endif%;\
    /def -p5 -mregexp -t'^The scent leads (north|south|east|west|up|down) from here!$$' scenttrigg = \
        /set lastdir=%%{P1}%%; \
        /if /ismacro logpathtrig %%; /then \
            /let directionChar=$[substr({lastdir}, 0, 1)] %%;\
            /addpath %%{lastdir} %%; \
        /endif %; \
    /def -mregexp -t"^The (north|south|east|west|up|down) is closed." doortrig1 = /send open %%{P1}=%%{P1}%;\
    /def -mregexp -t"^You are unable to pass through the (.*).  Ouch!" doortrig2 = /send open %%{P1}=%%{P1}%; \
    /def -mregexp -t"^The .*'s magical aura prevents you from moving (north|south|east|west|up|down)\." doortrig3 = /send unlock %%{P1}=open %%{P1}=%%{P1}%;\
    /echo -p %%% Auto-@{Cgreen}Track @{n}is @{Cgreen}ON@{n}.

/def trackoff = \
    /if /ismacro tracktrig %; /then \
        /undef tracktrig scenttrigg doortrig1 doortrig2 doortrig3 unfind1 unfind2 unfind3 %; \
    /endif %; \
    /echo -p %%% Auto-@{Cgreen}Track @{n}is @{Cred}OFF@{n}.

/def find = \
    /trackon%;\
    /def -t"You have found your quarry!!" unfind1 = /trackoff%;\
    /def -t"You have lost your quarry's trail!!" unfind2 = /trackoff%;\
    /def -t"You can't sense a trail to * from here." unfind3 = /trackoff%;\
    /send track %{*}

/def logpath = \
    /if (tolower({1}) =~ "on") \
        /def -mregexp -p99 -F -t"^You follow ([a-zA-Z]+) (north|south|east|west|up|down)." logpathtrig = \
            /addpath %%{P2}%;\
        /echo -p %%% @{Cgreen}Log Path @{Cwhite}is @{Cgreen}ON@{n}.%;\
        /unset loggedpath%;\
    /elseif (tolower({1}) =~ "off") \
        /if /ismacro logpathtrig %; /then \
            /undef logpathtrig%;\
        /endif%;\
        /echo -p %%% @{Cgreen}Log Path @{Cwhite}is @{Cred}OFF@{n}.%;\
    /else \
        /echo -p %%% @{Cyellow}Syntax: @{Cgreen}logpath @{Cgreen}ON@{n}|@{Cred}OFF@{n}.%;\
    /endif

/def echotrack = \
    /if (tolower({1}) =~ "on") \
        /def -p99 -F -mregexp -t"^You see your quarry's trail head (north|south|east|west|up|down) from here!$$" echo_tracking_trigger = /send gtell check for %%{tracktarget} |bg|%%{P1}|n|%;\
        /def -p1 -ag -mregexp -h"SEND ^track (.*)$$" hook_tracktarget = /send track %%{P1}%%;/set tracktarget=%%{P1}%;\
        /def -t"You have found your quarry!!" echo_tracking_unfind1 = /echotrack off%;\
        /def -t"You have lost your quarry's trail!!" echo_tracking_unfind2 = /send gtell can't find %%{tracktarget}%;\
        /echo -p %%% @{Cgreen}Echo Tracking @{Cwhite}is @{Cgreen}ON@{n}.%;\
        /if ({#} >= 2) track %{2}%;/endif%;\
    /elseif (tolower({1}) =~ "off") \
        /if /ismacro echo_tracking_trigger %; /then \
            /undef echo_tracking_trigger hook_tracktarget echo_tracking_unfind1 echo_tracking_unfind2%;\
        /endif%;\
        /echo -p %%% @{Cgreen}Echo Tracking @{Cwhite}is @{Cred}OFF@{n}.%;\
    /else \
        /echo -p %%% @{Cyellow}Syntax: @{Cgreen}echotrack @{Cgreen}ON [target]@{n}|@{Cred}OFF@{n}.%;\
    /endif

/set bloodhounders=rog war arc bzk dru bod fus bld rip
/def -mregexp -t"^\*?([a-zA-Z]+)\*? tells the group 'track (.+)'$" leader_gtell_track_trig = \
    /let _leader=$[strip_attr({P1})]%;\
    /let tTarget=$[strip_attr({P2})]%;\
    /if ((regmatch({myclass},{bloodhounders})) & {_leader} =~ {leader}) \
        /echotrack on %{tTarget}%;\
    /endif

/def addpath = \
    /let _directionChar=$[substr({1}, 0, 1)]%;\
    /set loggedpath=%{loggedpath}%{_directionChar}

/def showpath = /echo -p %%% @{Cgreen}Path so far: @{hCcyan}%{loggedpath}@{n}

/def clrpath = /echo -p %%% @{Cgreen}Path cleared@{n}. %; /unset loggedpath
