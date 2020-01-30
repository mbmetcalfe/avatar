;; tiati.gear.ava.tf
/cleangear

/set main_bag "icesphere loot"
;;; load hitgear set
/load -q char/lord.hit3.ava.tf
/def -wtiati hit_pre_on = /set wield %{hit_wield}%;/set unbrandish=%{hit_held}

;;; load lord ac gearset
/load -q char/lord.ac1.ava.tf
/def -wtiati ac_pre_on = /set wield %{ac_wield}%;/set unbrandish=%{ac_held}

;;; load lord det gearset
/load -q char/lord.det.ava.tf
/load -q char/lord.mana2.ava.tf
/set mana_waist "Girth Holy Tiati 01/24/2003 quest"

