;; verlegenheit.gear.ava.tf
/cleangear

/set main_bag="floating icesphere loot"

/load -q char/lord.hit1.ava.tf
/set hit_bag="the town crier skin bag"
/load -q char/lord.ac6.ava.tf
/set ac_bag="looter sack acgear!"

/def -wverlegenheit hit_pre_off = \
    /send remove "once-sundered"=put "once-sundered" %{main_bag}%;\
    /send remove verlegenheit=put verlegenheit %{main_bag}%;\
    /send remove "scepter silver githyanki"=put "scepter silver githyanki" %{main_bag}
/def -wverlegenheit ac_pre_off = /hit_pre_off

/def -wverlegenheit hit_post_on = \
    /set unbrandish=%{hit_held}%; \
    /send get "once-sundered" %{main_bag}=wear "once-sundered"%;\
    /send get verlegenheit %{main_bag}=wield verlegenheit%;\
    /send get "scepter silver githyanki" %{main_bag}

/def -wverlegenheit ac_post_on =  \
    /set unbrandish=%{ac_held}%; \
    /send get "once-sundered" %{main_bag}=wear "once-sundered"%;\
    /send get verlegenheit %{main_bag}=wield verlegenheit%;\
    /send get "scepter silver githyanki" %{main_bag}
