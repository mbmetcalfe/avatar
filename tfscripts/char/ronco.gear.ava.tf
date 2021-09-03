;; ronco.gear.ava.tf
;;
/cleangear

/set main_bag="floating icesphere loot"

/load -q char/lord.hit1.ava.tf
/set hit_bag="floating watersphere hitgear!"
/load -q char/lord.ac6.ava.tf
/set ac_bag="floating icesphere acgear!"

/def -wronco hit_pre_on = /set unbrandish=%{hit_held}%;/send extend
/def -wronco ac_pre_on = /send retract
/def -wronco mana_pre_on = /send retract


/def -wronco hit_pre_off = /send remove "once-sundered"=put "once-sundered" %{main_bag}
/def -wronco ac_pre_off = /hit_pre_off

/def -wronco hit_post_on = \
    /set unbrandish=%{hit_held}%;\
    /send get "once-sundered" %{main_bag}=wear "once-sundered"

/def -wronco ac_post_on =  \
    /set unbrandish=%{ac_held}%;\
    /send get "once-sundered" %{main_bag}=wear "once-sundered"
