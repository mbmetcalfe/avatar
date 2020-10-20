;;; state.tf
;;; Scripts to maintain session state.

;;; Save some char info to file.
/def -mglob -t"Your equipment info has been saved (just in case)!" avatar_save = /avatar_quit

/def -mglob -t"Leaving the AVATAR System for the 'real world'\.\.\." avatar_quit = \
    /eval /sys echo Last login: $[ftime("%Y%m%d", time())] > char/.%{myname}-info.dat%;\
    /eval /sys echo %{mylevel} %{mytier} >> char/.%{myname}-info.dat%;\
    /eval /sys echo Gold: %{myGold} >> char/.%{myname}-info.dat%;\
    /eval /sys echo %{curr_hp} / %{max_hp} hp, %{curr_mana} / %{max_mana} m, %{curr_move} / %{max_move} mv, %{tnl} tnl.>> char/.%{myname}-info.dat%;\
    /eval /sys echo /echo -pw %% Loading %{myname} state-file.> char/.%{myname}-state.dat%;\
    /eval /sys echo /set tnlthreshold=%{tnlthreshold}>> char/.%{myname}-state.dat%;\
    /eval /sys echo /set brandish=%{brandish}>> char/.%{myname}-state.dat%;\
    /eval /sys echo /set unbrandish=%{unbrandish}>> char/.%{myname}-state.dat%;\
    /eval /sys echo /set branRemaining=%{branRemaining}>> char/.%{myname}-state.dat%;\
    /eval /sys echo /set rechargeContainer=%{rechargeContainer}>> char/.%{myname}-state.dat%;\
    /eval /sys echo /set levelGoal=%{levelGoal}>> char/.%{myname}-state.dat%;\
    /eval /sys echo /set myTnl=%{myTnl}>> char/.%{myname}-state.dat%;\
    /eval /sys echo /set myrace=%{myrace}>> char/.%{myname}-state.dat%;\
    /eval /sys echo /set myclass=%{myclass}>> char/.%{myname}-state.dat%;\
    /eval /sys echo /set mytier=%{mytier}>> char/.%{myname}-state.dat%;\
    /eval /sys echo /set mylevel=%{mylevel}>> char/.%{myname}-state.dat%;\
    /eval /sys echo /set wield=%{wield}>> char/.%{myname}-state.dat%;\
    /eval /sys echo /set offhand=%{offhand}>> char/.%{myname}-state.dat%;\
    /eval /sys echo /set lootContainer=%{lootContainer}>> char/.%{myname}-state.dat%;\
    /eval /sys echo /set lvlon=%{lvlon}>> char/.%{myname}-state.dat%;\
; Save any auto-flags
    /let this=$[world_info()]%;\
    /let auto_cast_v %{this}_auto_cast%;\
    /let auto_cast $[expr({auto_cast_v})]%;\
    /if (strlen({auto_cast}) > 0) /eval /sys echo /set %{auto_cast_v}=%{auto_cast}>> char/.%{myname}-state.dat%;/endif%;\
    /let auto_drone_v %{this}_auto_drone%;\
    /let auto_drone $[expr({auto_drone_v})]%;\
    /if (strlen({auto_drone}) > 0) /eval /sys echo /set %{auto_drone_v}=%{auto_drone}>> char/.%{myname}-state.dat%;/endif%;\
    /let auto_ammo_v %{this}_auto_ammo%;\
    /let auto_ammo $[expr({auto_ammo_v})]%;\
    /if (strlen({auto_ammo}) > 0) /eval /sys echo /set %{auto_ammo_v}=%{auto_ammo}>> char/.%{myname}-state.dat%;/endif%;\
    /eval /sys echo /set self_buffs=%{self_buffs}>> char/.%{myname}-state.dat%;\
    /sys echo /set action=%{action}>> char/.%{myname}-state.dat%;\
    /if ({mytier} =~ "lord") \
        /eval /sys echo "/set allegItem=%{allegItem}">> char/.%{myname}-state.dat%;\
    /endif%;\
    /if ({myclass} =~ "prs") \
        /eval /sys echo /set maxheal=%{maxheal}>> char/.%{myname}-state.dat%;\
    /endif%;\
    /if (regmatch({myclass},{rogType})) \
        /eval /sys echo /set poisonkit=%{poisonkit}>> char/.%{myname}-state.dat%;\
        /eval /sys echo /set lockpick_chest=%{lockpick_chest}>> char/.%{myname}-state.dat%;\
        /eval /sys echo /set lockpick_door=%{lockpick_door}>> char/.%{myname}-state.dat%;\
    /endif

;; Macro to load the character file and do any other commands required upon login
/def loadCharacterState = \
;/let lcName=$[tolower({1})]%;\
    /let this=$[world_info()]%;\
    /load -q char/.%{this}-state.dat%;\
    /if ({brandish} !~ "") /setbrandish %{brandish} %{branRemaining}%;\
    /else /setbrandish%;\
    /endif
;    /let auto_cast_v %{this}_auto_cast%;\
;    /let auto_cast $[expr({auto_cast_v})]%;\
;    /if (strlen({auto_cast}) > 0) /cast %{auto_cast}%;/endif%;\
;    /let auto_drone_v %{this}_auto_drone%;\
;    /let auto_drone $[expr({auto_drone_v})]%;\
;    /if (strlen({auto_drone}) > 0) /drone %{auto_drone}%;/endif%;\
;    /let auto_ammo_v %{this}_auto_ammo%;\
;    /let auto_ammo $[expr({auto_ammo_v})]%;\
;    /if (strlen({auto_ammo}) > 0) /drone %{auto_ammo}%;/endif


/def charReset = \
    /set myname=${world_name}%;\
    /loadCharacterState %{myname}
