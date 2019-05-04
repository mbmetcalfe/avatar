;; dhaatu.gear.ava.tf
/cleangear

/set main_bag "jumpsuit white loot"

;;; load hitgear set
/load -q char/hero.roghit2.ava.tf

;/def -wdhaatu ac_pre_on = \
;    /send get all.dhaatu! %{main_bag}

;/def -wdhaatu ac_pre_off = \
;    /send remove all.dhaatu!=put all.dhaatu! %{main_bag}

;/def -wdhaatu hit_pre_on = /ac_pre_on
;/def -wdhaatu hit_pre_off = /ac_pre_off

;/def -wdhaatu hit_post_on = /send wear %{hit_offhand}

;;; load hitgear set
;/load -q char/lord.hit3.ava.tf
;;; load lord ac gearset
;/load -q char/lord.ac1.ava.tf

