;; paxan.gear.ava.tf
/cleangear

/set main_bag="loot"

;/load -q char/hero.lightmana.ava.tf
/load -q char/hero.mana2.ava.tf
/load -q char/hero.ac3.ava.tf

/def -wpaxan ac_post_on =  \
    /set unbrandish=%{ac_held}%;\
    /set offhand=%{ac_offhand}%;\
    /send wear %{ac_offhand}%;\
    /send get fingerbone %{main_bag}=wear fingerbone%;\
;    /send get "Girth quest" %{main_bag}=wear "Girth quest"%;\
    /def -wpaxan sle = /ac2mana%%;/send sleep
;/def -wpaxan mana_post_on = /send get "Girth quest" %{main_bag}=wear "Girth quest"

/def -wpaxan ac_pre_off = \
    /send remove fingerbone=put fingerbone %{main_bag}
;    /send remove "Girth quest"=put "Girth quest" %{main_bag}
;/def -wpaxan mana_pre_off = /send remove "Girth quest"=put "Girth quest" %{main_bag}
