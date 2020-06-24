;; vars.tf
;; Sets per world (character) vars so auto cast/stab/heal/etc can be turned on for each character
;; also lets xp/stat gain from a run be per character
;; /getvar somevar               Used in macros to get a var for the current world
;; /chkvar somevar               Echoes somevar
;; /setvar somevar somevalue     Sets somevar to somevalue for current world
;; /addvar somevar someint       Adds someint to somevar for current world

/def getvar=\
  /let this=$[world_info()]%;\
  /test getopts("w:", "a")%;\
  /if (opt_w =~ 'a') /let this=$[world_info()]%;\
  /else /let this=%opt_w%;\
  /endif%;\
  /let vname %1%;\
  /let vnamefull %{this}_%{vname}%;\
  /let isnum $[regmatch('^\d+$', $[expr({vnamefull})])]%;\
  /let isstr $[regmatch('^[A-Za-z\s]*$', $[expr({vnamefull})])]%;\
  /let isempty $[regmatch('^$', $[expr({vnamefull})])]%;\
  /if /test ({isempty} == 1)%;/then /setvar -w%this %{vname} 0%;/endif%;\
  /let ret $[expr({vnamefull})]%;\
  /result ret

/def chkvar=\
  /let this=$[world_info()]%;\
  /test getopts("w:", "a")%;\
  /if (opt_w =~ 'a') /let this=$[world_info()]%;\
  /else /let this=%opt_w%;\
  /endif%;\
  /let vname=%1%;\
  /eval /echo %{this}: $[getvar(vname)]

/def ck=/chkvar %1

/def setvar=\
 /let this=$[world_info()]%;\
 /test getopts("w:", "a")%;\
 /if (opt_w =~ 'a') /let this=$[world_info()]%;\
 /else /let this=%opt_w%;\
 /endif%;\
 /let vname=%1%;\
 /let spaceindex=$[strchr(strip_attr(%*), ' ')]%;\
 /let val=$[substr(strip_attr(%*), %spaceindex)]%;\
 /set %{this}_%{vname} %val

/def addvar=\
  /let this=$[world_info()]%;\
  /test getopts("w:", "a")%;\
  /if (opt_w =~ 'a') /let this=$[world_info()]%;\
  /else /let this=%opt_w%;\
  /endif%;\
  /let vname %1%;/let addv %2%;\
  /let ov=$(/getvar -w%this %1)%;\
  /setvar -w%this %1 $[ov+%2]
