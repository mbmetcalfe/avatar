;; fyl.gear.ava.tf

/set main_bag "jumpsuit loot"

/load -q char/hero.hit1.ava.tf

/def -wfyl hit_post_on = \
        get girth %{main_bag}%;wear girth%; \
        /set unbrandish=%{hit_held}%; \
        /def -wfyl fylunlvl = /send rem ciquala=rem hat=put ciquala %{main_bag}=put hat %{main_bag}=wear %{hit_held}=wear %{hit_head}%; \
        /def -wfyl fyllvl = /send get hat %{main_bag}=get ciquala %{main_bag}=rem %{hit_held}=rem %{hit_head}=wear hat=wear ciquala
/def -wfyl hit_pre_off = /send rem girth=put girth %{main_bag}

/def -wfyl mana_pre_on = /send put %{mana_waist} %{mana_bag}
/def -wfyl mana_post_on = \
        /send get girth %{main_bag}=wear girth=%;/set unbrandish=%{mana_held}%; \
        /def -wfyl fyllvl = /send get hat %{main_bag}=get ciquala %{main_bag}=wear hat=wear ciquala%; \
        /def -wfyl fylunlvl = /send rem ciquala=rem hat=put ciquala %{main_bag}=put hat %{main_bag}=wear %{mana_head}=wear %{mana_held}
/def -wfyl mana_pre_off = /send rem girth=put girth %{main_bag}
