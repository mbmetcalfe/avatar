;;; table.ava.tf

/load -q char/table.gear.ava.tf


;/set main_bag="bodybag loot"
;/load -q char/hero.roghit2.ava.tf
;/load -q char/hero.lightmana.ava.tf

;; Wear seneca robe to bipass curse on the ofcol rings
/def -wtable -p1 -mglob -ag -h'SEND wear all' hook_table_wear_all = /send wear all=get "robes sustainment" %{main_bag}=wear "robes sustainment"=wear "robe greatness"=put "robes sustainment" %{main_bag}

/set table_prayer_boon=precision
/def -wtable -au -mregexp -p10 -F -t"^(Werredan|Bhyss|Shizaga|Gorn|Kra|Tul\-Sith|Quixoltan)\'s presence disappears\.$" table_prayer_drop = \
  /if ({repray} == 1) /refreshSkill c prayer %{table_prayer_boon}%;/endif

/def -mglob -wtable -p5 -F -t"One of your Exhaust timers has elapsed. (shoulder burden)" table_keep_shoulder_burden = \
  /if ({table_reshoulder} == 1) \
    c 'shoulder burden'%;\
  /endif
/def -wtable reshoulder = /toggle table_reshoulder%;/echoflag %table_reshoulder Re-@{hCblue}Shoulder Burden@{n}

;; refresh sneak if running
/def -p9 -t"You feel less fatigued. (sneak)" table_refresh_sneak = /if ({running}==1) /send racial sneak%;/endif
/def -wtable -mregexp -t"^Your innate mental strength defeats ([a-zA-Z]+)'s (awen|frenzy) spell\!" table_tranquil_frenzy = /send emote is filled with rage!

/loadCharacterState table
