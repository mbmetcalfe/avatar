;; auction house testing
; ### |  Curr Bid  | Time | Level | min bid
;---------------------------------------------------------------------
;   1 |       1050 |  510 |   125 |    1000
;   3 |          0 | 4150 |   125 | 3000000
;   4 |    8400000 | 4151 |   125 | 8000000
;   5 |    5000000 | 4152 |   125 | 5000000
;   6 |          0 | 4156 |   125 |  100000
;   7 |    1500000 | 4157 |   124 |  100000
;   8 |          0 | 4158 |     2 | 1000000
;   9 |    1000000 | 4158 |   125 |  200000
;  10 |    1000000 | 4159 |   126 |  200000
;  11 |          0 | 4161 |   125 |  100000
;  12 |          0 | 4162 |   124 | 2000000
;  13 |          0 | 4164 |   126 |  100000
;  14 |          0 | 4164 |   125 |  100000

/def -mregexp -ag -p0 -t"^ +([0-9]+) \| +([0-9]+) \| +([0-9]+) \| +([0-9]+) \| +([0-9]+)$" auction_house_list = \
    /let itemNumber=%{P1}%;\
    /let currentBid=%{P2}%;\
    /let bidTime=%{P3}%;\
    /let bidLevel=%{P4}%;\
    /let minBid=%{P5}%;\
    /echo -pw Item#: %{itemNumber} | Curr Bid: %{currentBid} | Time: %{bidTime} | Level: %{bidLevel} | Min Bid: %{minBid}

 
;; TBD
/def -mregexp -ah -p0 -t"^You brandish the (Black Staff of Typhus|emerald sceptre of light).$" self_brandish_count = \
    /let lcgroupiename=%{myname}%;\
    /let tempcount=$(/listvar -vmglob %{lcgroupiename}_brandish)%;\
    /set %{lcgroupiename}_brandish=$[tempcount+1]

/def -mregexp -ah -p0 -t"^([a-zA-Z]+) brandishes the (Black Staff of Typhus|emerald sceptre of light).$" groupie_brandish_count = \
    /let lcgroupiename=$[tolower({P1})]%;\
    /let brandtemp=<%{lcgroupiename}<%;\
    /if ( regmatch(tolower({brandtemp}),{groupies})) \
        /let tempcount=$(/listvar -vmglob %{lcgroupiename}_brandish)%;\
        /set %{lcgroupiename}_brandish=$[tempcount+1]%;\
    /endif
