;; bauchan.gear.ava.tf
/load -q char/hero.arc.ava.tf
/set arc_wield "david sling"
/set arc_held "brace piercing stone"

/def -wbauchan arc_pre_on = /send get quiver %{main_bag}
/def -wbauchan arc_post_on = \
	/set unbrandish=%{arc_held}
/def -wbauchan arc_pre_off = /send put quiver %{main_bag}

/def -wbauchan mana_pre_on = /send get quiver %{main_bag}
/def -wbauchan mana_post_on = \
	/set unbrandish=%{mana_held}
/def -wbauchan mana_pre_off = /send put quiver %{main_bag}
