;; tiati.gear.ava.tf
/cleangear

/set main_bag "icesphere loot"
/load -q char/lord.hit1.ava.tf
/set hit_bag="floating watersphere hitgear!"
/def -wtiati hit_pre_on = /set wield %{hit_wield}%;/set unbrandish=%{hit_held}

/load -q char/lord.ac1.ava.tf
/set ac_wield="gray staff regenwield"
/def -wtiati ac_pre_on = /set wield %{ac_wield}%;/set unbrandish=%{ac_held}

;;; load lord det gearset
/load -q char/lord.det.ava.tf
/load -q char/lord.mana2.ava.tf
/set mana_waist "Girth Holy Tiati 01/24/2003 quest"

