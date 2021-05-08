;; purohitah.gear.ava.tf
;;
/cleangear

/set main_bag "bodybag body bag loot"

/load -q char/lord.ac4.ava.tf
/load -q char/lord.mana1.ava.tf
/set mana_bag="Iini skin bag"

/set ac_wield "scepter silver githyanki"
/set wield "scepter silver githyanki"

/def -wpurohitah mana_post_on = \
    /set unbrandish=%{mana_held}%;\
    /send get "once-sundered ring" %{main_bag}=wear "once-sundered ring"%;\
    /send get "talisman gauntlets magence" %{main_bag}=wear "talisman gauntlets magence"

/def -wpurohitah mana_pre_off = \
    /send remove "once-sundered ring"=put "once-sundered ring" %{main_bag}%;\
    /send remove "talisman gauntlets magence"=put "talisman gauntlets magence" %{main_bag}

/def -wpurohitah ac_pre_off = \
    /send remove "once-sundered ring"=put "once-sundered ring" %{main_bag}%;\
    /send remove "talisman gauntlets magence"=put "talisman gauntlets magence" %{main_bag}

/def -wpurohitah ac_post_on =  \
	/set unbrandish=%{ac_held}%; \
    /def -wpurohitah sle = /ac2mana%%;/send sleep%;\
    /def -wpurohitah wa = stand%%;/mana2ac%;\
    /send get "once-sundered ring" %{main_bag}=wear "once-sundered ring"%;\
        /send get "talisman gauntlets magence" %{main_bag}=wear "talisman gauntlets magence"
