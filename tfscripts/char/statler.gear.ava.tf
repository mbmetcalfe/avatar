;; statler.gear.ava.tf
/cleangear

/set main_bag="jumpsuit white loot"

;/load -q char/hero.lightmana.ava.tf
/load -q char/hero.evilmana1.ava.tf
/load -q char/hero.evilac1.ava.tf


/def -wstatler ac_post_on =  \
    /set unbrandish=%{ac_held}%;\
    /set offhand=%{ac_offhand}%;\
    /send wear fire%;\
    /send get fingerbone %{main_bag}=wear fingerbone%;\
    /send wear displacer%;\
    /def -wstatler sle = /ac2mana%%;/send sleep

/def -wstatler ac_pre_off = /send remove fingerbone=put fingerbone %{main_bag}
