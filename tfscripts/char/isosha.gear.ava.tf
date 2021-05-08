;; isosha.gear.ava.tf
/cleangear

/set main_bag "bodybag body bag loot"
/set quiver_bag "encrusted layer shells quiver"

/load -q char/hero.arc.ava.tf
;/load -q char/hero.mana4.ava.tf
;;; Zaffer's aranor on loan
;/set arc_wield "bow aranor"

;/load -q char/lord.arc.ava.tf
;/set quiver_bag "bodybag body bag quiver"

;/set arc_held "brace ice arrows"
;/set arc_wield "lightning crossbow"
;/set arc_held "brace mithril bolts"
;/set arc_wield="long bow deep shadow"
;/set arc_xbow="silver crossbow heavy"


;;; ac-hit and hit-ac gear swap aliases
/def -wisosha toac = \
  get %{arc_bag} %{main_bag}%;\
  get all.arcacgear %{arc_bag}%;\
  put bertha %{arc_gear}%;put all.drow %{arc_gear}%;\
  rem %{arc_light}%;put %{arc_light} %{arc_bag}%;\
  rem %{arc_legs}%;put %{arc_legs} %{arc_bag}%;\
  rem %{arc_body}%;put %{arc_body} %{arc_bag}%;\
  rem %{arc_about}%;put %{arc_about} %{arc_bag}%;\
  wear all.arcacgear%;\
  xbow%;\
  put %{arc_bag} %{main_bag}
/def -wisosha tohit = \
  get %{arc_bag} %{main_bag}%;\
  get all %{arc_bag}%;\
  put bertha %{arc_gear}%;put all.drow %{arc_gear}%;\
  remove all.arcacgear%;put all.arcacgear %{arc_bag}%;\
  wear all.barbed%;wear %{arc_light}%;\
  wear %{arc_legs}%;wear %{arc_body}%;\
  wear %{arc_about}%;\
  bow%;\
  put %{arc_bag} %{main_bag}
