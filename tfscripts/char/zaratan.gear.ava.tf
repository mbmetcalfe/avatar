;; zaratan.gear.ava.tf
/cleangear

/set main_bag="jumpsuit white loot"

;/load -q char/hero.lightmana.ava.tf
/load -q char/hero.mana2.ava.tf
/load -q char/hero.ac3.ava.tf

/def -wzaratan ac_post_on =  \
    /set unbrandish=%{ac_held}%;\
    /set offhand=%{ac_offhand}%;\
    /send wear %{ac_offhand}%;\
    /send get all.fingerbone %{main_bag}=wear all.fingerbone%;\
    /def -wzaratan sle = /ac2mana%%;/send sleep

/def -wzaratan ac_pre_off = /send remove all.fingerbone=put all.fingerbone %{main_bag}

