;;; ----------------------------------------------------------------------------
;;; File: multi.tf
;;; Macroes and triggers to aid in multiplaying
;;; usage:
;;; /all [command] - sends a command to all connected sockets
;;; /oth [command] - sends a command to all sockets but the current front socket
;;; ----------------------------------------------------------------------------
/set background=on
/set bg_output=off
/set notify=0
/set log_auction=0
/set multi=1
/def multi = \
    /toggle multi%;\
    /echoflag %{multi} Multi

;/def all = /send -W %{*}
/def all = /alldo %{*}

/def oth = \
    /let socks $[$(/listsockets -s)]%;\
    /let socks $[strcat({socks}, " ")]%;\
    /let length $[strlen({socks})]%;\
    /let curr=$[world_info()]%;\
    /while ({length}>1) \
        /let this=$[substr({socks},0,strchr({socks}," "))]%;\
        /if (({curr} !~ {this}) & (is_connected({this}))) /send -w%{this} %*%; /endif%;\
        /let socks=$[substr({socks},(strchr({socks}," ")+1))]%;\
        /let lastlength=$[{length}]%;\
        /let length=$[strlen({socks})]%;\
    /done

;/def -i multido = /send gt %{1} do %{-1}
/def -i multido = /send tell %{1} do %{-1}

/def alldo = /send gt do %{*}
/def asha = /multido Asha %{*}
/def bauchan = /multido Bauchan %{*}
/def dhaatu = /multido Dhaatu %{*}
/def duskrta = /multido Duskrta %{*}
/def eronak = /multido Eronak %{*}
/def falrim = /multido Falrim %{*}
/def feir = /multido Feir %{*}
/def gengis = /multido Gengis %{*}
/def ganik = /multido Ganik %{*}
/def gouki = /multido Gouki %{*}
/def granuja = /multido Granuja %{*}
/def helfyre = /multido Helfyre %{*}
/def iratavo = /multido Iratavo %{*}
/def isosha = /multido Isosha %{*}
/def jekyll = /multido Jekyll %{*}
/def kaboo = /multido Kaboo %{*}
/def keiko = /multido Keiko %{*}
/def kromlee = /multido Kromlee %{*}
/def mahal = /multido Mahal %{*}
/def medhya = /multido Medhya %{*}
/def muerte = /multido Muerte %{*}
/def muni = /multido Muni %{*}
/def maxine = /multido Maxine %{*}
/def odium = /multido Odium %{*}
/def paxon = /multido Paxon %{*}
/def phenyx = /multido Phenyx %{*}
/def purohitah = /multido Purohitah %{*}
/def shubie = /multido Shubie %{*}
/def skia = /multido Skia %{*}
/def sombra = /multido Sombra %{*}
/def statler = /multido Statler %{*}
/def table = /multido Table %{*}
/def tahn = /multido Tahn %{*}
/def tarkara = /multido Tarkara %{*}
/def tiati = /multido Tiati %{*}
/def torvald = /multido Torvald %{*}
/def verlegenheit = /multido Verlegenheit %{*}
/def vulko = /multido Vulko %{*}
/def waldorf = /multido Waldorf %{*}
/def zaratan = /multido Zaratan %{*}

/def snore = \
    /send snore%;\
    /def full_mana_action = /send tell Verlegenheit My Mana is full%;\
    /def full_hp_action = /send tell Verlegenheit My Hp is full

/def -p99 -mregexp -t"^\*([a-zA-Z]*)\* tell[s]* the group 'do (.*)'" multi_gtell_action = \
    /if ({P1} =~ {leader}) /eval $[strip_attr({P2})]%;/endif
/def -p99 -mregexp -t"^([a-zA-Z]*) tells you 'do (.*)'" multi_tell_action = \
    /if ({P1} =~ {leader}) /eval $[strip_attr({P2})]%;/endif
/def -p99 -mregexp -t"^You dream of ([a-zA-Z]*) telling you 'do (.*)'" multi_tell_action2 = \
    /if ({P1} =~ {leader}) /eval $[strip_attr({P2})]%;/endif

/def -p99 -mregexp -t"^\*([a-zA-Z]*)\* tell[s]* the group '([a-zA-Z]+) do (.+)'" multi_gtell_char_action = \
    /if ({P1} =~ {leader} & $[tolower({P2})] =~ ${world_name}) \
        /echo -p Found ${world_name}%;\
        /let current_world=$[fg_world()]%;\
        /fg %{P2}%;\
        /eval $[strip_attr({P3})]%;\
;        /fg %{current_world}%;\
    /endif

;; "% Trigger in world " message can be quieted for individual triggers by 
;; defining them with /def -q, or for all triggers with:
/def -ag -hBGTRIG no_background_display
;; Remove '% Activity in world world'
/def -ag -hACTIVITY no_activity_display
