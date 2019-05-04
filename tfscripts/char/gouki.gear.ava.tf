;; gouki.gear.ava.tf
/cleangear

/set main_bag "girdle pouches many"

/load -q char/hero.mana3.ava.tf
/load -q char/hero.ac1.ava.tf
/load -q char/hero.hit3.ava.tf

/def -wgouki hit_post_on = \
    /set unbrandish=%{hit_held}%; \
    /send get fingerbone %{main_bag}=wear fingerbone%;\
    /def -wgouki sle = /hit2mana%%;/send sleep

/def -wgouki mana_post_on = \
    /set unbrandish=%{mana_held}

/def -wgouki ac_post_on =  \
    remove all.shield%;\
    /send get fingerbone %{main_bag}=wear fingerbone%;\
    /set unbrandish=%{ac_held}%; \
    /def -wgouki sle = /ac2mana%%;/send sleep

/def -wgouki hit_pre_off = \
    /send remove fingerbone=put fingerbone %{main_bag}
/def -wgouki ac_pre_off = \
    /send remove fingerbone=put fingerbone %{main_bag}
