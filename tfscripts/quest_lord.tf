;; -----------------------------------------------------------------------------
;;; quest_lord.tf
;;; This script will contain some helpful triggers/macroes to automate some of
;;; the lord-level quests
;; -----------------------------------------------------------------------------

/def autoquest = /toggle autoquest%;/echoflag %autoquest Auto-@{hCred}Questing@{n}

;; Vault Thief's Bane (aka Hide quest)
;; https://avatar.melanarchy.info/index.php/Vault_Thief%27s_Bane
/def -ag -Ph -F -t'an embossed hide' highlight_hide_quest_001 = /test $[echoGearItem({PL}, "an embossed hide", "quest", {P1}, {PR})]
/def -ag -Ph -F -t'the whole hide of a merman' highlight_hide_quest_002 = /test $[echoGearItem({PL}, "the whole hide of a merman", "quest", %{P1}, {PR})]
/def -ag -Ph -F -t'a glazed gith hide' highlight_hide_quest_003= /test $[echoGearItem({PL}, "a glazed gith hide", "quest", {P1}, {PR})]
/def -ag -Ph -F -t'a soft nubuc hide' highlight_hide_quest_004 = /test $[echoGearItem({PL}, "a soft nubuc hide", "quest", {P1}, {PR})]
/def -ag -Ph -F -t'the hide of an unlucky human' highlight_hide_quest_005 = /test $[echoGearItem({PL}, "the hide of an unlucky human", "quest", {P1}, {PR})]

/def -ag -Ph -F -t'a mindflayer scalp' highlight_gith_remort_quest = /test $[echoGearItem({PL}, "a mindflayer scalp", "quest", {P1}, {PR})]

;; Once Sundered tickets (for UD Girth "upgrade")
/def -ag -P -F -t'half of the Sundered Ring' highlight_once_sundered = /test $[echoGearItem({PL}, "half of the Sundered Ring", "quest", {P1}, {PR})]

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


;;
;;; Faerie Script Quest
;;
/def -p5 -mglob -t"A seamstress from the Kzin home plane offers to trade her wares." quest_faerie_script_ashara = \
  /if ({autoquest} == 1) /send give "tablet scroll black" ashara%;\
  /else /echo -pw @{Cred}[QUEST INFO]: Faerie Script Quest: @{Cyellow}give "tablet scroll black" ashara%;\
  /endif

/def -p5 -mglob -t"Ashara gives you a silken scarf." quest_faerie_script_scarf = \
  /echo -pw @{Cred}[QUEST INFO]: Faerie Script Quest: @{Cyellow}Give a silken scarf to Ceilican on Midgaard, he will give you a strand of golden hair.

/def -p5 -mglob -t"A withered old Gypsy is here, playing an enchanting melody." quest_faerie_script_ceilican = \
  /if ({autoquest} == 1) /send give "silken scarf" ceilican%;\
  /else /echo -pw @{Cred}[QUEST INFO]: Faerie Script Quest: @{Cyellow}give "silken scarf" ceilican%;\
  /endif

/def -p5 -mglob -t"Ceilican the Gypsy gives you a strand of golden hair!" quest_faerie_script_strand = \
  /echo -pw @{Cred}[QUEST INFO]: Faerie Script Quest: @{Cyellow}Give a strand of golden hair to Laz on Thorngate, he will give you a Faerie script.

/def -p5 -mglob -t"A Fae wanderer from Arcadia is here." quest_faerie_script_laz = \
  /if ({autoquest} == 1) /send give "strand golden hair" laz%;\
  /else /echo -pw @{Cred}[QUEST INFO]: Faerie Script Quest: @{Cyellow}give "strand golden hair" ceilican%;\
  /endif

;; 
;; Conundrum things
;;
/def -p5 -mglob -t"* A crack on another demiplane is leaking out dusty air." quest_conundrum_enter_crack = /send enter crack
