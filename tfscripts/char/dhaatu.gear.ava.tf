;; dhaatu.gear.ava.tf
/cleangear

/set main_bag "jumpsuit white loot"

/load -q char/hero.roghit2.ava.tf
/set hit_wield="paladinwield greatsword Dhaatu"

/load -q char/hero.ac2.ava.tf
;/eval /set ac_wield=%{hit_wield}

/def -wdhaatu ac_pre_on = get all.fingerbone %{main_bag}=get seven %{main_bag}
;/def -wdhaatu ac_pre_on = /send get %{ac_wield} %{main_bag}=get all.fingerbone %{main_bag}

/def -wdhaatu ac_pre_off = remove all.fingerbone=put all.fingerbone %{main_bag}=remove seven=put seven %{main_bag}
;/def -wdhaatu ac_pre_off = /send remove %{ac_wield}=put %{ac_wield} %{main_bag}=remove all.fingerbone=put all.fingerbone %{main_bag}=remove seven=put seven %{main_bag}

/def -wdhaatu hit_pre_on = /ac_pre_on
/def -wdhaatu hit_pre_off = /ac_pre_off

/def -wdhaatu hit_post_on = /send remove all.medallion=wear all.fingerbone=wield %{hit_wield}
/def -wdhaatu ac_post_on = /send remove all.carved=wear all.fingerbone=wield %{ac_wield}

