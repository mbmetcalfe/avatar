;;; log-channels.tf
/load -q settings.tf

; Toggle if messages are logged elsewhere (i.e. Discord, etc)
/set logging_channels=1
/def logChannels = \
    /toggle logging_channels%;\
    /echoflag %logging_channels Logging-Channels%;\
    /statusflag %logging_channels LC

; Generic macro to send message to other places (i.e. Discord)
/def -i logChannel = \
    /if ({logging_channels} == 1) \
        /sendDiscordPrivateMsg %{*}%;\
    /endif

;;; ----------------------------------------------------------------------------
;;; ----------------------------------------------------------------------------

/def -i sendDiscordPrivateMsg = \
    /let message=$[replace("'","",{*})]%;\
    /quote -S /nothing !curl -H "Content-Type: application/json" -X POST -d '{"username": "AvNotifier", "content": "%message"}' %{DISCORD_PRIVATE_HOOK}

/def -i sendNewDiscordPrivateMsg = \
    /let message=$[replace("'","",{2})]%;\
    /quote -S /nothing !curl -H "Content-Type: application/json" -X POST -d '{"username": "AvNotifier", "embeds": [{"title": "%{1}", "description": "%{message}"}]}' %{DISCORD_PRIVATE_HOOK}

;/def -p1 -t -mregexp -t'^([a-zA-Z\ \-\,\.]+)\> (.*)$' log_hero_channel = /logChannel **%{P1}**> %{P2}
;/def -p1 -t -mregexp -t'^\(([a-zA-Z\ \-\,\.]+)\) (.*)$' log_lord_channel = /logChannel (**%{P1}**) %{P2}
;/def -mregexp -t"^[a-zA-Z\ \-\,\.\]+ [n]?chats '.*'$" log_channel_chat = /logChannel %{P0}

; Format the long channel versions (XXX herochats 'blah' -> XXX> blah) and optionally
; log the message
/def -i logGenericChannel = \
    /if ({#} != 3) \
        /echo -pw @{Cred}/logGenericChannel @{Cwhite}[Chatter] [Channel] [Message]@{n}%;\
    /else \
        /let _chatter=%{1}%;\
        /let _channel=%{2}%;\
        /let _message=%{3}%;\
        /if ({_chatter} =~ "You") \
            /let _chatter=${world_name}%;\
            /let _chatter=$[strcat(toupper(substr({_chatter}, 0, 1)), substr({_chatter}, 1))]%;\
        /endif%;\
        /if ({_channel} =~ "buddychat") \
            /logChannel {**%{_chatter}**} %{_message}%;\
            /let _chatter={%{_chatter}}%;\
            /let _channel=%;\
        /elseif ({_channel} =~ "herochat") \
;/logChannel **%{_chatter}**> %{_message}%;\
            /let _channel=>%;\
        /elseif ({_channel} =~ "lordchat") \
;/logChannel (**%{_chatter}**) %{_message}%;\
            /let _channel=%;\
            /let _chatter=(%{_chatter})%;\
        /endif%;\
        /echo -pw %{_chatter}%{_channel} %{_message}@{n}%;\
    /endif

; Need config +blind for this macro to work. Changes channel output to be the long versions.
/def -ag -p1 -t -mregexp -t"^([a-zA-Z\ \-\,\.]+) (buddychat|lordchat|herochat)s? '(.*)'$" log_channels = /test $[logGenericChannel({P1}, {P2}, {P3})] 

/def -F -p50 -mregexp -t"^[a-zA-Z\\ \\-\\,\\.]+ buddychats? \'!stats ([a-zA-Z]+)\'$" buddylist_charstats = /charstat %{P1} buddy
/def -F -p50 -mregexp -t"^[a-zA-Z\\ \\-\\,\\.]+ buddychats 'No altlist found for ([a-zA-Z]+).'$" buddylist_altlist = /altlist %{P1} buddy
/def -F -p50 -mregexp -t"^[a-zA-Z\\ \\-\\,\\.]+ buddychats 'moron ?list'" buddylist_moronlist = \
  /let qryalt=$[strip_attr({P1})]%;\
  /quote -S buddy !sqlite3 avatar.db "select 'Current list of morons: ' || main_alt" from alt_list where lower(name) = lower('%{qryalt}')"
/def -F -p50 -mregexp -t"^[a-zA-Z\\ \\-\\,\\.]+ buddychats '([a-zA-Z]+) is not one of my active characters or no gains recorded\.'$" buddylist_stats = /charstat %{P1} buddy

/def -mregexp -ag -t"^\[BUDDY INFO\]\: ([a-zA-Z]+) has logged out\.$" buddy_logout = \
      /let qryalt=$[strip_attr({P1})]%;\
        /quote -S /echo -pw @{Cred}[BUDDY INFO]: !sqlite3 avatar.db "select '@{Cwhite}' || main_alt || '@{Cred} has logged out of @{Cwhite}%{P1}@{Cred}.@{n}' from alt_list where lower(name) = lower('%{qryalt}')"

