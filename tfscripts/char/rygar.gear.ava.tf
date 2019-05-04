;; rygar.gear.ava.tf
;;
;; Contributors:
;;	Harliquen ( khaosse_angel@alpha.net.au )
;;
;; This file shows the sort of things required in the character definition
;; files. Basically anything that is personal to you, and specific to a 
;; character should go here, rather than in the tiny.personalise.
;; Primaraliy, it's good for gear definitions, but also for character specific
;; messages, triggers, etc.

/set main_bag "encrusted shells"

/load -q char/hero.roghit.ava.tf
/set hit_waist "girth quest"
/load -q char/hero.mana3.ava.tf

/def -wrygar hit_post_on = \
        get girth %{main_bag}%;wear girth%; \
        /set unbrandish=%{hit_held}%; \
        /def -wrygar rygarunlvl = /send rem ciquala=rem hat=put ciquala %{main_bag}=put hat %{main_bag}=wear %{hit_held}=wear %{hit_head}%; \
        /def -wrygar rygarlvl = /send get hat %{main_bag}=get ciquala %{main_bag}=rem %{hit_held}=rem %{hit_head}=wear hat=wear ciquala
/def -wrygar hit_pre_off = /send rem girth=put girth %{main_bag}

/def -wrygar mana_pre_on = /send put %{mana_waist} %{mana_bag}
/def -wrygar mana_post_on = \
        /send get girth %{main_bag}=wear girth=%;/set unbrandish=%{mana_held}%; \
        /def -wrygar rygarlvl = /send get hat %{main_bag}=get ciquala %{main_bag}=wear hat=wear ciquala%; \
        /def -wrygar rygarunlvl = /send rem ciquala=rem hat=put ciquala %{main_bag}=put hat %{main_bag}=wear %{mana_head}=wear %{mana_held}
/def -wrygar mana_pre_off = /send rem girth=put girth %{main_bag}
