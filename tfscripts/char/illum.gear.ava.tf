;; illum.gear.ava.tf
/cleangear

/set main_bag="bodybag body bag loot"

/load -q char/hero.evilmana1.ava.tf
/load -q char/hero.evilac1.ava.tf

/def -willum wa = /send stand%;/mana2ac

/def -willum ac_post_on =  \
    /set unbrandish=%{ac_held}%;\
    /set offhand=%{ac_offhand}%;\
    /send wear fire%;\
    /send get fingerbone %{main_bag}=wear fingerbone%;\
    /send get "Girth quest" %{main_bag}=wear "Girth quest"%;\
    /send wear displacer%;\
    /def -willum sle = /ac2mana%%;/send sleep

/def mana_post_on = \
    /send wield %{mana_wield}=wear %{mana_offhand}%;\
    /send get "Girth quest" %{main_bag}=wear "Girth quest"%;\
    /def -willum wa = /send stand%%;/mana2ac

/def -willum ac_pre_off = \
    /send remove fingerbone=put fingerbone %{main_bag}%;\
    /send remove "girth quest"=put "girth quest" %{main_bag}
/def -willum mana_pre_off = \
    /send remove "girth quest"=put "girth quest" %{main_bag}
