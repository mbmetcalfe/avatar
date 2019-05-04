;; eronak.gear.ava.tf
;;
;; Contributors:
;;      Harliquen ( khaosse_angel@alpha.net.au )
;;
;; This file shows the sort of things required in the character definition
;; files. Basically anything that is personal to you, and specific to a
;; character should go here, rather than in the tiny.personalise.
;; Primaraliy, it's good for gear definitions, but also for character specific
;; messages, triggers, etc.

;; Usage:
;;      /<current geat set>2<new gear set>
/cleangear

/set main_bag "floating icesphere loot"

;;; load ac gearset
/load -q char/lord.ac1.ava.tf
;;; load hero arc gearset for hit
/load -q char/hero.arc.ava.tf
/set hit_held="doom shard"
/set hit_wield=""
/set hit_offhand="hero shield"
/set hit_hands="killing gloves black"
/set hit_arms="sleeves spiked"
/set hit_wrist1="scorpion tattoo picture"
/set hit_wrist2="scorpion tattoo picture"

/def -weronak ac_pre_off = \
    rem all.shield%;put all.shield %{main_bag}%; \
    rem all.scorpion%;put all.scorpion %{main_bag}%; \
    rem %{hit_hands}%;put %{hit_hands} %{main_bag}%; \
    rem %{hit_arms}%;put %{hit_arms} %{main_bag}
/def -weronak hit_pre_on = \
    get %{hit_held} %{main_bag}%;wear %{hit_held}%; \
    get %{hit_hands} %{main_bag}%;wear %{hit_hands}%; \
    get all.scorpion %{main_bag}%;wear all.scorpion%; \
    get %{hit_arms} %{main_bag}%;wear %{hit_arms}
/def -weronak hit_post_on = \
    get all.shield %{main_bag}%; \
    get %{hit_bag} %{main_bag}%; \
    put gauntlet %{hit_bag}%; \
    put all.wrist %{hit_bag}%; \
    put %{hit_bag} %{main_bag}%; \
    /def -weronak eronaklvl = /send get all.levelgear %{main_bag}=rem all.tooth=rem %{hit_head}=wear all.levelgear%; \
    /def -weronak eronakunlvl = /send rem all.levelgear=put all.levelgear %{main_bag}=wear all.tooth=wear %{hit_head}

/def -weronak hit_pre_off = /ac_pre_off
/def -weronak ac_pre_on = /hit_pre_on

/def -weronak ac_post_on = \
    get all.shield %{main_bag}%; \
    get %{ac_bag} %{main_bag}%; \
    remove dragonscale%;put dragonscale %{ac_bag}%;wear crimsonscale%; \
    put all.rune %{ac_bag}%; \
    put %{ac_hands} %{ac_bag}%; \
    put %{ac_arms} %{ac_bag}%; \
    put %{ac_legs} %{ac_bag}%; \
    put %{ac_bag} %{main_bag}%; \
    /def -weronak eronaklvl = /send get all.levelgear %{main_bag}=rem all.necklace=rem %{ac_head}=wear all.levelgear%; \
    /def -weronak eronakunlvl = /send rem all.levelgear=put all.levelgear %{main_bag}=wear all.necklace=wear %{ac_head}
