;; verlegenheit.gear.ava.tf
/cleangear

/set main_bag="floating icesphere loot"

/load -q char/lord.hit1.ava.tf
/set hit_bag="floating watersphere hitgear!"
/load -q char/lord.ac6.ava.tf
/set ac_bag="floating icesphere acgear!"

/def -wverlegenheit hit_pre_off = \
    /send remove "once-sundered"=put "once-sundered" %{main_bag}%;\
    /send remove verlegenheit=put verlegenheit %{main_bag}%;\
    /send remove "scepter silver githyanki"=put "scepter silver githyanki" %{main_bag}
/def -wverlegenheit ac_pre_off = /hit_pre_off

/def -wverlegenheit hit_post_on = \
    /set unbrandish=%{hit_held}%; \
    /send get "once-sundered" %{main_bag}=wear "once-sundered"%;\
    /send get verlegenheit %{main_bag}=wield verlegenheit%;\
    /send get "scepter silver githyanki" %{main_bag}%;\
    /def -wverlegenheit verlegenheitunlvl = /send remove all.levelgear=put all.levelgear %main_bag=wear %{hit_neck1}=wear %{hit_head}%; \
    /def -wverlegenheit verlegenheitlvl = /send remove %{hit_neck1}=remo %{hit_head}=get all.levelgear %main_bag=wear all.levelgear

/def -wverlegenheit mana_post_on = \
    /set unbrandish=%{mana_held}%;\
    /def -wverlegenheit verlegenheitlvl = /send get all.levelgear %{main_bag}=wear hat=wear crucifix%; \
    /def -wverlegenheit verlegenheitunlvl = /send rem all.levelgear=put all.levelgear %{main_bag}=wear %{mana_head}=wear %{mana_neck1}

/def -wverlegenheit ac_post_on =  \
    /set unbrandish=%{ac_held}%; \
    /send get "once-sundered" %{main_bag}=wear "once-sundered"%;\
    /send get verlegenheit %{main_bag}=wield verlegenheit%;\
    /send get "scepter silver githyanki" %{main_bag}%;\
    /def -wverlegenheit verlegenheitunlvl = /send rem all.levelgear=put all.levelgear %{main_bag}=wear %{ac_neck1}=wear %{ac_head}=wear %{ac_held}%; \
    /def -wverlegenheit verlegenheitlvl = /send get all.levelgear %{main_bag}=rem %{ac_neck1}=rem %{ac_head}=rem %{ac_held}=wear all.levelgear
