/def logChannel = \
    /if ({logging_channels} == 1) \
        /sys echo $[ftime("%Y%m%d", time())]: %{*} >> char/%{myname}.%{gains_suffix}.dat%;\
    /endif
/def -mregexp -t"^[a-zA-Z\ \-\,\.\]+ [n]?chats '.*'$" log_channel_chat = /logChannel %{P0}
/def ssay = /recall -t -mregexp 0- ^([a-zA-Z\ \-\,\.]+) (say|ask|exclaim)[s]? '.*'$$
/def sgt = /recall -w%1 -t 0- *tell* the group*
/def sbc = /recall -w%1 -t -mregexp 0- ^\{(An Immortal|A staff member|[a-zA-Z]+)\} .*$$
/def sbuddy = /sbc %*
/def shero = /recall -w%1 -t -mregexp 0- ^([a-zA-Z\ \-\,\.]+)\>.*$$
/def slord = /recall -w%1 -t -mregexp 0- ^\\(([a-zA-Z\ \-\,\.]+)\\) .*$$
/def sgains = /recall -w%1 -t -mglob 0- *Your gain is*
/def stell = /recall -w%1 -mregexp -t 0- ^([a-zA-Z\ ]+) (tell [a-zA-Z]+|dream of|tells you|is asleep, but you tell)
/def slgchat = /recall -t -mregexp 0- ^([a-zA-Z\ \-\,\.\]+) (azure|gold|silver|team)chats '.*'$$