;; -----------------------------------------------------------------------------
;;; quest_lord.tf
;;; This script will contain some helpful triggers/macroes to automate some of
;;; the lord-level quests
;; -----------------------------------------------------------------------------

/def autoquest = /toggle autoquest%;/echoflag %autoquest Auto-@{hCred}Questing@{n}

;; Hide quest
/def -ag -Ph -F -t'an embossed hide' highlight_hide_quest_001 = /test $[echoGearItem(%{PL}, "an embossed hide", "quest", %{P1})]
/def -ag -Ph -F -t'the whole hide of a merman' highlight_hide_quest_002 = /test $[echoGearItem(%{PL}, "the whole hide of a merman", "quest", %{P1})]
/def -ag -Ph -F -t'a glazed gith hide' highlight_hide_quest_003= /test $[echoGearItem(%{PL}, "a glazed gith hide", "quest", %{P1})]

/def -ag -Ph -F -t'a mindflayer scalp' highlight_gith_remort_quest = /test $[echoGearItem(%{PL}, "a mindflayer scalp", "quest", %{P1})]


;; -----------------------------------------------------------------------------
;;; Shadowrun
;;; Wiki: 
;;; Google doc: 
;; -----------------------------------------------------------------------------
/def fshadow = \
    /toggle folshadow%;\
    /if ({folshadow} == 0) \
        /statusflag %{folshadow} sr_%{followShadowRunQuester}%;\
        /undef folshadow_die folshadow_vortex_quester folshadow_shroud folshadow_vortex folshadow_die2%;\
        /echo -pw %%% @{Cred}No longer automatically following Shadow Run Quester.@{n}%;\
    /else \
        /set followShadowRunQuester=%{1}%;\
        /statusflag %{folshadow} sr_%{followShadowRunQuester}%;\
        /def -p99 -F -mregexp -t"^%{followShadowRunQuester} suddenly dies for no apparent reason\." folshadow_die = /if ({folshadow} = 1) /send die%%;/endif%;\
        /def -p99 -F -mregexp -t"^%{followShadowRunQuester} enters the dark vortex\." folshadow_vortex_quester = /if ({folshadow} = 1) /send give shadow djehuti%%;/endif%;\
        /def -p99 -F -mregexp -t"^Djehuti gives you a shroud of shadow\." folshadow_shroud = /if ({folshadow} = 1) /send wear shroud=enter vortex%%;/endif%;\
        /def -p99 -F -mregexp -t"^You step through the dark vortex and feel energy drain from your body\!" folshadow_vortex = /if ({folshadow} = 1) /send east=east%%;/endif%;\
        /def -p99 -F -mregexp -t"^%{followShadowRunQuester} is pulled through the barrier\." folshadow_die2 = /if ({folshadow} = 1) /send die%%;/endif%;\
        /echo -pw %%% @{Cred}Will follow after @{hCYellow}%{followShadowRunQuester} @{Cred}on Shadow Run.@{n}%;\
    /endif
