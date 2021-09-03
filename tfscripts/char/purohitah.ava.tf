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

;; Migraine stuff
/def -wpurohitah -p1900 -mregexp -ahCwhite -t"^You feel a slight headache growing stronger\.\.\." purohitah_migrained = c 'water breath' 

;; inno things
/def -wpurohitah -mregexp -au -t"^([a-zA-z]+) tries to tell you a story to make .* look innocent\.$" purohitah_inno_other = \
  /if ({running}==1) c innocence %{P1}%;/endif

/def -wpurohitah -mregexp -au -t"^\*?(Nit|Fluent|Sludge|Yorimandil)\*? tells the group '(clarify|pana) ?(pls)?'" purohitah_clarify_gt = /send wak=c %{P2} %{P1}=slee
/def -wpurohitah -mregexp -au -t"^\*?(Nit|Fluent|Sludge|Yorimandil)\*? looks at your description." purohitah_noafk = /let wait_time=$[rand(0,24)]%;\
 /repeat -00:00:%{wait_time} 1 look

/def bsetbot = \
    /auto bsetbot %1%;\
	/if ($(/getvar auto_bsetbot) == 1)\
		/let this=$[world_info()]%;\
		/quote -S /set %{this}_whitelist=!sqlite3 avatar.db "select distinct lower(name) from alt_list  where main_alt in ('Zaffer', 'Zarradyn', 'Ebin', 'Calp', 'Bertrand')" | tr '\\n' '  '%;\
		/let rlv=%{this}_whitelist%;\
		/let whitelist=$[expr(%rlv)]%;\
		/let whitelen=$[strlen(whitelist)]%;\
		/let whitelist=$[substr(whitelist, 0, $[whitelen-1])]%;\
		/set %{this}_whitelist=%whitelist%;\
		/let whitelist=$[replace(" ","|",%whitelist)]%;\
		/def -mregexp -au -p99 -wpurohitah -t"((?i)%whitelist) tell[sing]+ you '(full|spells|sanc|div|cp|cd|cb|aegis|foci|fort[itudes]*)([2-5]?)'" purohitah_bset_bot = \
			/let _commander=$[strip_attr({P1})]%%;\
			/let _command=$[strip_attr({P2})]%%;\
			/let _commandAugment=$[strip_attr({P3})]%%;\
			/echo -pw %%{P1}, %%{P2}, %%{P3}%%;\
			/send stand%%;\
			/if ({P2} =~ "spells" | {P2} =~ "full") /osup %%{P1}%%;\
			/elseif ({P2} =~ "cp" | {P2} =~ "cd" | {P2} =~ "cb") /send quicken 5=c panacea %%{P1}=quicken off%%;\
			/elseif ({P2} =~ "div")\
				/if ({P3} > 0 & {P3} < 6) /send augment %%P3%%;/endif%%;\
				/send c '%%{P2}' %%{P1}%%;\
				/if ({P3} > 0 & {P3} < 6) /send augment off%%;/endif%%;\
			/else /send c '%%{P2}' %%{P1}%%;\
			/endif%%;\
			/send sleep%%;\
	/else /undef purohitah_bset_bot%;\
	/endif


/loadCharacterState purohitah
