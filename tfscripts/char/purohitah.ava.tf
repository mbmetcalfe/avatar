;;; purohitah.ava.tf
;; 
;; 20201030 - 538 hero, Killed UD
/load -q char/purohitah.gear.ava.tf

;; Autohealing variables
/set comfGain=1500
/set divGain=235
/set healGain=117
/set cureLightGain=27

;;; set up other variables
/def -wpurohitah gsup = \
	filter +spellother%; \
	gtell |c|Ok, here comes spells, sleep if you want to avoid spam.|w|%; \
	preach holy sight%;preach water breath%;preach iron skin%;preach fortitudes%;preach foci%;preach aegis%;preach sanc%; \
	filter -spellother%; \
	gtell |r|Frenzy |c|if you need to.|w|

/def -wpurohitah wa = /send wake%;/mana2ac

; Temp trigger to swap to ac when leader does
/def -wpurohitah -mregexp -t"^(Nit|Roku) smoothes out its clothes\." leader_smooth_to_ac = /if ({running}==1) /mana2ac%;/endif

; Swap to mana when leader does
/def -wpurohitah -mregexp -t"^(Nit|Roku) takes it easy and relaxes." leader_swap_to_mana = /if ({running}==1) /ac2mana%;sleep%;/endif

; follow teleport
/def -wpurohitah -p4 -au -mglob -t"Nit steps into a shimmering portal." purohitah_follow_nit = /if ({running}==1) c teleport nit%;/endif

;; Migraine stuff
/def -wpurohitah -p1900 -mregexp -ahCwhite -t"^You feel a slight headache growing stronger\.\.\." purohitah_migrained = c 'water breath' 

;; inno things
/def -wpurohitah -mregexp -au -t"^([a-zA-z]+) tries to tell you a story to make .* look innocent\.$" purohitah_inno_other = \
  /if ({running}==1) c innocence %{P1}%;/endif

/def -wpurohitah -mregexp -au -t"^\*Roku\* tells the group \'inno\'" purohitah_preach_inno_gt = \
    /if ({running}==1) preach innocence%;/endif

/def -wpurohitah -mregexp -au -t"^(Fluent) tells the group '(clarify|pana) ?(pls)?'" purohitah_clarify_gt = /send wak=c %{P2} %{P1}=slee
/def -wpurohitah -mregexp -au -t"^(Purohitah|Fluent) looks at your description." purohitah_noafk = /let wait_time=$[rand(0,24)]%;\
 /repeat -00:00:%{wait_time} 1 look

/loadCharacterState purohitah
