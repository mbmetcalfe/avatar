;; gear.tf
;;
;; Contributors:
;;	Harliquen ( khaosse_angel@alpha.net.au)
;;
;; Gear change definitions.
;; This has been done in a very complex, but flexible way. Basically, you
;; define gear and bag sets for each character, and it allows you to update
;; it without having to change all associated aliases any time you change
;; a single piece of gear.
;;
;; Usage:
;;	/<current geat set>2<new gear set>
;;	As you can see this is very flexable, as it can take any gear set
;;	and switch to any other. So long as it knows how. It can do more
;;	than just take all the bits from 1 bag and put them on. There are
;;	provisions for things it should do before and after wearing and
;;	removing each set of gear. Unfortunatly there is no easy interface
;;	for this. It uses the following 4 macros when they exist:
;;		/<gear set>_pre_on
;;		/<gear set>_pre_off
;;		/<gear set>_post_on
;;		/<gear set>_post_off
;;	I think their names speak for themselves.
;;	All the gear definitions and additional macros should be set up in
;;	the individual world files.

/set slot_0 wield
/set slot_1 light
/set slot_2 finger1
/set slot_3 finger2
/set slot_4 neck1
/set slot_5 neck2
/set slot_6 body
/set slot_7 head
/set slot_8 legs
/set slot_9 feet
/set slot_10 hands
/set slot_11 arms
/set slot_12 offhand
/set slot_13 about
/set slot_14 waist
/set slot_15 wrist1
/set slot_16 wrist2
/set slot_17 held

/def gear_off = \
	/if /ismacro %{1}_pre_off%; /then /%{1}_pre_off%; /endif%;\
	/eval /send get %%{%{1}_bag} %{main_bag}=rem all%;\
	/eval /send put all %%{%{1}_bag}%;\
	/eval get %{main_bag} %%{%{1}_bag}%;\
	/eval /send put %%{%{1}_bag} %{main_bag}%;\
	/if /ismacro %{1}_post_off%; /then /%{1}_post_off%; /endif

/def gear_on = \
	/if /ismacro %{1}_pre_on%; /then /%{1}_pre_on%; /endif%;\
	/eval /send get %%{%{1}_bag} %{main_bag}=get all %%{%{1}_bag}%;\
	/eval /send wield %%{%{1}_wield}%;\
	/send wear all%;\
	/eval /send put %%{%{1}_bag} %{main_bag}%;\
	/if /ismacro %{1}_post_on%; /then /%{1}_post_on%; /endif

/def -ag -mregexp -h"NOMACRO ([a-z]+)2([a-z]+)" change_gear_hook =\
	/eval /if (({%{P1}_bag} !~ "") & ({%{P2}_bag} !~ "")) /gear_off %{P1}%%; /gear_on %{P2}%%;\
	/else /echo %%% %%{1}: No such command or macro. %%; /endif
	
;; clear pre/post on/off macroes and gear bags
/def cleangear = \
    /unset $(/listvar -smglob *_bag)%; \
    /if /ismacro hit_pre_on%; /then /undef hit_pre_on%; /endif%; \
    /if /ismacro hit_post_on%; /then /undef hit_post_on%; /endif%; \
    /if /ismacro hit_pre_off%; /then /undef hit_pre_off%; /endif%; \
    /if /ismacro hit_post_off%; /then /undef hit_post_off%; /endif%; \
    /if /ismacro mana_pre_on%; /then /undef mana_pre_on%; /endif%; \
    /if /ismacro mana_post_on%; /then /undef mana_post_on%; /endif%; \
    /if /ismacro mana_pre_off%; /then /undef mana_pre_off%; /endif%; \
    /if /ismacro mana_post_off%; /then /undef mana_post_off%; /endif%; \
    /if /ismacro ac_pre_on%; /then /undef ac_pre_on%; /endif%; \
    /if /ismacro ac_post_on%; /then /undef ac_post_on%; /endif%; \
    /if /ismacro ac_pre_off%; /then /undef ac_pre_off%; /endif%; \
    /if /ismacro ac_post_off%; /then /undef ac_post_off%; /endif%; \
    /if /ismacro det_pre_on%; /then /undef det_pre_on%; /endif%; \
    /if /ismacro det_post_on%; /then /undef det_post_on%; /endif%; \
    /if /ismacro det_pre_off%; /then /undef det_pre_off%; /endif%; \
    /if /ismacro det_post_off%; /then /undef det_post_off%; /endif
