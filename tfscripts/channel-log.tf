;; channel-log.tf
/load -q settings.tf

/set channel_logging=0

/def -i logchanmsg = \
    /if ({channel_logging}=1) \
        /quote -S /echo !mysql -u %{DB_USERNAME} --password=%{DB_PASSWORD} %{DB_NAME} -s -e "insert into channel_log (to_char, from_char, channel, channel_text) values ('%{1}', '%{2}', '%{3}', '%{-3}')"%;\
    /endif

/def -Fp900 -mregexp -t"^\*?([a-zA-Z]+)\*? tells? the group '(.*)'" log_gtell = \
    /if ({P1} =~ "You") /let from_char=${world_character}%;\
    /else /let from_char=%{P1}%;\
    /endif%;\
    /logchanmsg ${world_character} %{from_char} gtell %{P2}

/def -Fp900 -mregexp -t"([a-zA-Z]+) (dream of telling|tells?) ([a-zA-Z]+) '(.*)'" log_tell = \
    /if ({P1} =~ "You") /let from_char=${world_character}%;\
    /else /let from_char=%{P1}%;\
    /endif%;\
    /if ({P2} =~ "you") /let to_char=${world_character}%;\
    /else /let to_char=%{P3}%;\
    /endif%;\
    /logchanmsg %{to_char} %{from_char} tell %{P4}

/def -Fp900 -mregexp -t"^([a-zA-Z]+) (exclaim|say|ask)s? the group '(.*)'" log_say = \
    /if ({P1} =~ "You") /let from_char=${world_character}%;\
    /else /let from_char=%{P1}%;\
    /endif%;\
    /logchanmsg ${world_character} %{from_char} say %{P3}

/def -Fp900 -mregexp -t"^([\ a-zA-Z]+)\> (.*)" log_herochat = \
    /logchanmsg ${world_character} %{P1} herochat %{P2}

/def -Fp900 -mregexp -t"^([\ a-zA-Z]+) chats '(.*)'" log_chat = \
    /if ({P1} =~ "You") /let from_char=${world_character}%;\
    /else /let from_char=%{P1}%;\
    /endif%;\
    /logchanmsg ${world_character} %{from_char} chat %{P3}

/def -Fp900 -mregexp -t"^\{([\ a-zA-Z]+)\} (.*)" log_herochat = \
    /logchanmsg ${world_character} %{P1} buddychat %{P2}
