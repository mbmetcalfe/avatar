;; isz.gear.ava.tf

/set main_bag "jumpsuit loot"

/load -q char/hero.roghit.ava.tf
;/set hit_waist "girth quest"
;/load -q char/hero.mana3.ava.tf

/def -wisz hit_post_on = \
        get girth %{main_bag}%;wear girth%; \
        /set unbrandish=%{hit_held}%; \
        /def -wisz iszunlvl = /send rem ciquala=rem hat=put ciquala %{main_bag}=put hat %{main_bag}=wear %{hit_held}=wear %{hit_head}%; \
        /def -wisz iszlvl = /send get hat %{main_bag}=get ciquala %{main_bag}=rem %{hit_held}=rem %{hit_head}=wear hat=wear ciquala
/def -wisz hit_pre_off = /send rem girth=put girth %{main_bag}

/def -wisz mana_pre_on = /send put %{mana_waist} %{mana_bag}
/def -wisz mana_post_on = \
        /send get girth %{main_bag}=wear girth=%;/set unbrandish=%{mana_held}%; \
        /def -wisz iszlvl = /send get hat %{main_bag}=get ciquala %{main_bag}=wear hat=wear ciquala%; \
        /def -wisz iszunlvl = /send rem ciquala=rem hat=put ciquala %{main_bag}=put hat %{main_bag}=wear %{mana_head}=wear %{mana_held}
/def -wisz mana_pre_off = /send rem girth=put girth %{main_bag}
