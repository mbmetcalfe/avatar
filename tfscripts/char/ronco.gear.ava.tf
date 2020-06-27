;; ronco.gear.ava.tf
;;
/cleangear

/set main_bag="bodybag loot"

/load -q char/hero.hit1.ava.tf
/set hit_bag="bodybag body bag hitgear!"
/set hit_feet "fatewalkers"

;/load -q char/lord.hit1.ava.tf
;/set hit_bag="floating watersphere hitgear!"
/def -wronco hit_pre_on = /set unbrandish=%{hit_held}%;/send extend

;/load -q char/lord.ac6.ava.tf
;/set ac_bag="floating icesphere acgear!"
/def -wronco ac_pre_on = /set unbrandish=%{ac_held}%;/send retract

