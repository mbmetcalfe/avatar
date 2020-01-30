;; eti.gear.ava.tf
/cleangear

/set main_bag="jumpsuit white loot"

;/load -q char/hero.lightmana.ava.tf
/load -q char/hero.mana2.ava.tf
/load -q char/lord.ac1.ava.tf

/def -weti ac_post_on =  \
    /set unbrandish=%{ac_held}%;\
    /set offhand=%{ac_offhand}%;\
    /send wear %{ac_offhand}%;\
    /send get all.fingerbone %{main_bag}=wear all.fingerbone%;\
    /def -weti sle = /ac2mana%%;/send sleep
/def -weti mana_post_on = \
    /send get all.fingerbone %{main_bag}=wear all.fingerbone

/def -weti ac_pre_off = /send remove all.fingerbone=put all.fingerbone %{main_bag}
/def -weti mana_pre_off = /ac_pre_off

