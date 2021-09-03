;;; helmer.ava.tf
;;; Helmer - German origin, meaning "the wrath of a warrior".

;/load -q char/helmer.gear.ava.tf

/set main_bag="drake scale skin smoldering rucksack loothelmer"
/set lootContainer=loothelmer

;; Wear seneca robe to bipass curse on the ofcol rings
/def -whelmer -p0 -mglob -ag -h'SEND wear all' hook_helmer_wear_all = \
    /send wear all=get "robes sustainment" %{main_bag}=wear "robes sustainment"=wear "deathshroud"=put "robes sustainment" %{main_bag}

/loadCharacterState helmer
