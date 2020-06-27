;;; maggot.gear.ava.tf
/cleangear

/load -q char/lord.arc.ava.tf
/set quiver_bag "bodybag body bag quiver"

/set arc_held "brace ice arrows"
;/set arc_wield "lightning crossbow"
;/set arc_held "brace mithril bolts"
/set arc_wield="long bow deep shadow"

/def -wmaggot arc_pre_on = /send get quiver %{main_bag}
/def -wmaggot arc_post_on = /set unbrandish=%{arc_held}
/def -wmaggot arc_pre_off = /send put quiver %{main_bag}
/def -wmaggot mana_pre_on = /send get quiver %{main_bag}
/def -wmaggot mana_post_on = /set unbrandish=%{mana_held}
/def -wmaggot mana_pre_off = /send put quiver %{main_bag}
