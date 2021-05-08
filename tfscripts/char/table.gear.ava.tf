;; table.gear.ava.tf
/cleangear

/set main_bag="bodybag loot"

/load -q char/lord.hit1.ava.tf
/set hit_bag="urn black hitgear!"
/load -q char/lord.ac6.ava.tf
/set ac_bag="looter sack acgear!"

/def -wtable hit_pre_off = \
;    /send remove "once-sundered"=put "once-sundered" %{main_bag}%;\
    /send remove table=put table %{main_bag}%;\
    /send remove "scepter silver githyanki"=put "scepter silver githyanki" %{main_bag}
/def -wtable ac_pre_off = /hit_pre_off

/def -wtable hit_post_on = \
    /set unbrandish=%{hit_held}%; \
;    /send get "once-sundered" %{main_bag}=wear "once-sundered"%;\
    /send get table %{main_bag}=wield table%;\
    /send get "scepter silver githyanki" %{main_bag}

/def -wtable ac_post_on =  \
    /set unbrandish=%{ac_held}%; \
;    /send get "once-sundered" %{main_bag}=wear "once-sundered"%;\
    /send get table %{main_bag}=wield table%;\
    /send get "scepter silver githyanki" %{main_bag}
