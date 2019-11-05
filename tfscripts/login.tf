;;; ---------------------------------------------------------------------------
;;; login.tf
;;; Login/connection helpers
;;; ---------------------------------------------------------------------------

;;; ---------------------------------------------------------------------------
;;; Persistent connection 
;;; ---------------------------------------------------------------------------
/def persistent_connection = \
    /echo -p %%% @{Cyellow}Turning on persistent connection@{n}%;\
    /set permanent_connection=1%;\
    /perm_con

/def perm_con = \
    /if ($[is_connected()] != 1) \
        /set permanent_connection=0%;\
        /eval /connect ${world_name}%;\
    /else /repeat -00:02:30 1 /perm_con%;\
    /endif

/def -p0 -h'CONNECT' login = \
    /if ({permanent_connection} != 1) \
        /set permanent_connection=1%;\
        /perm_con%;\
    /endif

;/persistent_connection

;;; ---------------------------------------------------------------------------
;;; Auto-logon triggers
;;; ---------------------------------------------------------------------------
/def -mregexp -t'( *)Please press <enter> to continue' contiuecr = %;
/def -mregexp -t'^When you have read this, please press \<RETURN\> to continue \-\-\-\-\>' readthiscr = %;
;/def -mglob -t"Time to get to work..." immlogin = \
/def -mregexp -t"\<\<\(Please Press \<enter\>  continue\)\>\>" continue_cr = /send =
/def -p1 -mglob -t'***** Please Press Enter to Continue *****' continue_cr2 = /send =

    
/def -mregexp -t'^Ah, the Immortal ([a-zA-Z]+) has returned\! Addicted, eh\?' char_immlogin = \
    /hook_resize%;\
    /edit -c0 reloghook%;\
    /let logincharname=$[strip_attr({P1})]%;\
    /let logincharname=$[tolower({logincharname})]%;\
    /set myname=%logincharname

/def -mregexp -t'^Welcome back to the AVATAR System ([a-zA-Z]+), hope you get beyond level ([0-9]+) today!' welcomeback1 = \
    /hook_resize%;\
    /let logincharname=$[strip_attr({P1})]%;\
    /set mytier=lowmort%;/let level=%P2%;\
    /set mylevel=$[{level}-1]%;\
    /atitle (%mylevel)%;\
    /let logincharname=$[tolower(strip_attr({logincharname}))]%;\
    /set myname=%logincharname%;\
    /def -hload -ag ~gagload%;\
    /undef ~gagload%;\
    /send worth

/def -mregexp -t'Good luck getting (Hero|Lord|Legend) level ([0-9]*) today!' set_level = \
    /let tier=%P1%;/let level=%P2%;\
    /set mylevel=$[{level}-1]%;\
    /set mytier=$[tolower({tier})]%;\
    /atitle (%mytier %mylevel)%;\
    /send worth

/def -mregexp -t'Welcome to the AVATAR System, (Hero|Lord) [a-zA-Z]+\.' set_tier = \
    /set mytier=$[tolower({P1})]
/def -mregexp -t"^Why haven\'t you morphed yet\?$" set_level999 = \
    /hook_resize%;\
;    /set mylevel=999%;\
    /let logincharname=${world_character}%;\
    /let logincharname=$[tolower({logincharname})]%;\
    /set myname=%{logincharname}%;\
    /def -hload -ag ~gagload%;\
    /undef ~gagload%;\
    /atitle (%mytier %mylevel)%;\
    /send worth


/def -mregexp -t'-------\'---,--\{\@ \( Please press \<enter\> to continue \) \@\}--,---\'-------' continue_cr3 = %;
/def -mregexp -t'\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*' continue_cr4 = /send =
/def -mglob -t"*+*+O+b+i+t+u+m+*+*+*+  ( Press <enter> to continue )  +*+*+*+*+*+*+*+" continue_cr5 = /send =


/def -mregexp -t'^Welcome back to the AVATAR System, ([a-zA-Z]+) ([a-zA-Z]+).' welcomeback2 = \
    /hook_resize%;\
    /let logincharname=$[strip_attr({P2})]%;\
    /let logincharname=$[tolower({logincharname})]%;\
    /set myname=%logincharname%;\
    /def -hload -ag ~gagload%;\
    /undef ~gagload

;;; ========== hook to change X title when go to new world
/if ({TERM} =~ "xterm" | {TERM} =~ "cygwin" | {TERM} =~ "vt100") \
  /require tools.tf%;\
  /def -i -h"WORLD" x_fg_hook=/xtitle ${world_character}%;\
/endif

;;; ---------------------------------------------------------------------------
;;; Relog stuff
;;; ---------------------------------------------------------------------------
/def -p0 -h'DISCONNECT' reloghook = \
    /echo -p %%% @{hCwhite}Relogging @{Ccyan}%relogchar@{Cwhite}.@{n} %; \
    /connect %{relogchar}

/def -p1 -F -h'DISCONNECT' reloghook2 = \
    /xtitle [No Connection]

;;; toggle the relog.  Give it a param to relog, give no param to not relog
/def relog = \
    /let t1=%1%; \
    /let paramCount=%# %; \
    /if ({paramCount} = 0) \
        /edit -c0 reloghook %; \
        /echo -p %%% Will not relog. %; \
    /else \
        /edit -c100 reloghook %; \
        /set relogchar=%t1 %; \
        /echo -p %%% Will relog @{hCcyan}%relogchar@{nCwhite}. %; \
    /endif
/def r = /relog %1%;quit

;;; Turn off auto-relog if AFK.
;/def -mregexp -p9 -F -t'^You are now AFK.$' afk_trigger = \
;    /edit -c0 reloghook%;\
;    /set afk=1

;;; Turn off auto-relog if wrong password entered.
/def -mregexp -t"Wrong password\." stoptrying = /edit -c0 reloghook

;;; Turn off auto-relog if wizlocked
/def -mregexp -t"The game is currently wizlocked\." wizlocked = \
    /edit -c0 reloghook%;\
    /sendEmail Game is currently wizlocked%;\
    /sendSlackNotificationMsg Game is currently wizlocked.%;\
    /sendDiscordNotifyMsg :lock: Game is currently wizlocked.

;;; Stuff to be fixed, but should work
/def autorelog = /toggle arelog%;/echoflag %arelog Auto-Relog
/def -mregexp -t"^With a sizzling arc of light, ([a-zA-Z]*) has entered the realm!$" follow_leader = \
    /if (({arelog} = 1) & ({P1} =~ {leader})) \
        follow %P1 %; \
    /endif

/def -mregexp -t"^\*([a-zA-Z]*)\* tells the group '(relog|Relog|RELOG)([\!\.]*)'$" leader_relog = \
    /if (({arelog} = 1) & ({P1} =~ {leader})) \
        /send quit %; \
    /endif

/def rc = /dc%;/connect ${world_character}
