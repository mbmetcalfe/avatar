;; sombra.gear.ava.tf
/cleangear

/set main_bag="jumpsuit white loot"

/load -q char/hero.roghit2.ava.tf
/set hit_bag="urn black hitgear!"
/load -q char/hero.ac3.ava.tf

;/set hit_wield="dagger flame shaped unodagger"
;/set hit_offhand="dagger flame shaped dosdagger"
/set hit_wield="portia dagger unohit"
/set hit_offhand="portia dagger doshit"
/set ac_wield="crimson spellshard shard spell unoac"
/set ac_offhand="crimson spellshard shard spell dosac"

;/set hit_held="necrostaff necro staff health"

;/load -q char/lord.hit2.ava.tf
;/load -q char/lord.ac2.ava.tf
;/set ac_wield="stiletto poignant memories unostiletto"
;/set ac_offhand="stiletto poignant memories dosstiletto"

/def -wsombra hit_pre_on = /send altof rygar
/def -wsombra hit_post_on = \
    /send remove all.portia=wield %{hit_wield}=wear %{hit_offhand}%; \
    /set unbrandish=%{hit_held}

/def -wsombra ac_pre_on = /send altof zaratan
/def -wsombra ac_post_on = \
    /set unbrandish=%{ac_held}%;\
    /send rem all.spellshard=wield %{ac_wield}=offhand %{ac_offhand}

