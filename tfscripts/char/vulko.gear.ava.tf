;; vulko.gear.ava.tf
;;
/cleangear

/set main_bag "jumpsuit white loot"

/load -q char/hero.ac2.ava.tf
/load -q char/hero.mana4.ava.tf
/load -q char/hero.roghit2.ava.tf

;/def -wvulko mana_post_on = \
;    /def -wvulko vulkolvl = /send get all.levelgear %{main_bag}=rem all.talisman=rem %{mana_head}=wear all.levelgear%; \
;    /def -wvulko vulkounlvl = /send rem all.levelgear=put all.levelgear %{main_bag}=wear %{mana_head}=wear all.talisman

/def -wvulko ac_pre_off = /send remove fingerbone=put fingerbone %{main_bag}
/def -wvulko hit_pre_off = /ac_pre_off

/def -wvulko hit_on_cleanup = /send get %{hit_bag} %{main_bag}=put %{hit_neck1} %{hit_bag}=put all.hero %{hit_bag}=put %{hit_wield} %{hit_bag}=put %{hit_offhand} %{hit_bag}=put %{hit_bag} %{main_bag}
/def -wvulko hit_post_on = \
    wield %{hit_wield}%;wear %{hit_offhand}%; \
    /set unbrandish=%{hit_held}%; \
    /send get fingerbone %{main_bag}=wear fingerbone%;\
    /hit_on_cleanup%;\
    /def -wvulko sle = /hit2mana%%;/send sleep%;\
    /def -wvulko wa = stand%%;/mana2hit%;\
    /def -wvulko vulkounlvl = /send remove all.levelgear=put all.levelgear %lootContainer=wear %{hit_neck1}%; \
    /def -wvulko vulkolvl = /send remove %{hit_neck1}=get all.levelgear %lootContainer=wear all.levelgear

/def -wvulko mana_on_cleanup = \
    get %{mana_bag} %{main_bag}%;\
    put %{mana_wield} %{mana_bag}%;put %{mana_offhand} %{mana_bag}%;put %{mana_wield} %{mana_bag}%;\
    put %{mana_bag} %{main_bag}
/def -wvulko mana_post_on = \
    /set unbrandish=%{mana_held}%; \
    /mana_on_cleanup%;\
    /def -wvulko vulkolvl = /send get all.levelgear %{main_bag}=wear levelgear%; \
    /def -wvulko vulkounlvl = /send rem all.levelgear=put all.levelgear %{main_bag}=wear %{mana_neck1}

/def -wvulko ac_on_cleanup = /send get %{ac_bag} %{main_bag}=put %{ac_neck1} %{ac_bag}=put all.hero %{ac_bag}=put %{ac_wield} %{ac_bag}=put %{ac_bag} %{main_bag}
/def -wvulko ac_post_on =  \
    /set unbrandish=%{ac_held}%; \
    /send get fingerbone %{main_bag}=wear fingerbone%;\
    /ac_on_cleanup%;\
    /def -wvulko sle = /ac2mana%%;/send sleep%;\
    /def -wvulko wa = stand%%;/mana2ac%;\
    /def -wvulko vulkounlvl = /send rem all.levelgear=put all.levelgear %{main_bag}=wear all.bone%; \
    /def -wvulko vulkolvl = /send get all.levelgear %{main_bag}=rem bone=wear all.levelgear
