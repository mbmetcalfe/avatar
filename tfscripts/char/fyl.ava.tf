/require rogue.tf

/set main_bag "bodybag body bag loot"

/load -q char/hero.hit1.ava.tf
/set hit_offhand="narrow blade sword fyloffhand"
/set hit_wield="dragon bone blade sword fylwield"
/set hit_held="glyph tao"
/eval /set unbrandish=%{hit_held}

;; Load in the variables saved from previous state.
/loadCharacterState fyl
