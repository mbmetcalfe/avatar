;; asha.gear.ava.tf

/set hit_bag "bullet skin bag"

/set hit_light "sceptre blazing fury"
/set hit_finger1 "ring higher power"
/set hit_finger2 "ring higher power"
/set hit_neck1 "necklace severed fae ears"
/set hit_neck2 "necklace severed fae ears"
/set hit_body "tuatar battle tunic loose gi"
/set hit_head "crown pain wire shards glass"
/set hit_legs "living dark mystical daemonstone"
/set hit_feet "boots planewalking mithril"
/set hit_hands "zarradyn's gauntlets"
/set hit_arms "watermark tattoo wave"
;/set hit_offhand="psi-blade energy pure pain"
/set hit_offhand="ant wing chakram boss2"
/set hit_about "cloud dancing shards glass"
/set hit_waist "belt souls strap"
/set hit_wrist1 "broken shackles tyranny"
/set hit_wrist2 "broken shackles tyranny"
/set hit_wield "sword githyanki gith silver lordgear pain"
/set hit_held="sand sandblasted emerald"

/set main_bag "floating icesphere loot"

/def -washa hit_post_on = \
	/set unbrandish=%{hit_held}%; \
	/def -washa ashaunlvl = /send rem all.levelgear=put all.levelgear %{main_bag}=wear %{hit_neck1}=wear %{hit_held}%; \
	/def -washa ashalvl = /send get all.levelgear %{main_bag}=rem %{hit_neck1}=rem %{hit_held}=wear all.levelgear

/def -washa mana_post_on = \
	/set unbrandish=%{mana_held}%; \
	/def -washa ashalvl = /send get all.levelgear %{main_bag}=wear all.levelgear%; \
	/def -washa ashaunlvl = /send rem all.levelgear=put all.levelgear %{main_bag}=wear %{mana_head}=wear %{mana_neck1}

/def -washa ac_post_on =  \
	/set unbrandish=%{ac_held}%; \
	/def -washa ashaunlvl = /send rem all.levelgear=put all.levelgear %{main_bag}=wear %{ac_neck1}=wear %{ac_head}%; \
	/def -washa ashalvl = /send get all.levelgear %{main_bag}=rem %{ac_neck1}=rem %{ac_head}=wear all.levelgear
