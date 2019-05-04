/def -p0 -mregexp -t'^You receive ([0-9]+) experience points.$' rcvexp = \
    /setXp $[xp+{P1}]%;\
    /set kills=$[++kills]%;\
    /if (regmatch({myclass},{arcType})) get all.brace corpse%;/endif%;\
    /if ({autosac} = 1) sacrifice corpse%;/endif%;\
    /if ({psichk} = 1) /chkpsis %; /endif%;\
    /if ({autolkb} = 1) get lockbox corpse%;/endif%;\
    /performQ %; \
    /dochk

