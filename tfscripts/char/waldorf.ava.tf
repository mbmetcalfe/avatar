;;; ---------------------------------------------------------------------------
;;; waldorf.ava.tf
;;; ---------------------------------------------------------------------------
;;; 20160705: Killed UD at Hero 829
;;;    Full hit with carb, shroud, smoldering crown, no frenzy
;;;    Was tailed for 7 rounds, forgot to quicken until UD was at "quite a few wounds"
;;;    Didn't quaff and ended fight with: 943/  6157 hp   3058/  3881 ma
;;; 20160802: Morphed: 14506 hp  18300 ma   7458 mv
;;; 20160802: Evolved: 15240 hp  17740 ma   7536 mv
;;; 20200526: Evolved:
;;;           Before: 250 Lord: 17771 hp 19386 mana 8697 mv.
;;;           After:  250 Lord: 20297 hp 20622 mana 8277 mv.
/require psionic.tf

/load -q char/waldorf.gear.ava.tf

;;; ---------------------------------------------------------------------------
;;; Misc other triggers/aliases
;;; ---------------------------------------------------------------------------

/alias danc c 'dancing weapon'
/def kiwait = \
    /send kill %1%;\
    /if ({automidround} == 0) /repeat -0:0:03 1 amid%;/endif
/def kiwaitdw = \
    /send kill %1%;\
    /repeat -0:0:04 1 /waldorfmidround

/def -wwaldorf waldorfSetMySpell = \
  /let newSpell=='%{*}'%;\
  /if ({newSpell} !/ {waldorfMidSpell}) \
    /send a 1=a 1 c '%{*}' \%1%;\
  /endif
/def -wwaldorf waldorfSetMyAOESpell = \
  /let newSpell=='%{*}'%;\
  /if ({newSpell} !/ {waldorfAOESpell}) \
    /send a 2=a 2 c '%{*}'%;\
  /endif
/def waldorffren = /q 5 c frenzy %1

;;; ----------------------------------------------------------------------------
;;; waldorfPromptHookCheck is called from the prompt_hook via /promptHookCheck
;;; What we want to do here is just cast dancing weapon if autocast is on
;;; ----------------------------------------------------------------------------
/set waldorfPromptHookCheckToggle=1
;/set waldorfManaThreshold=9000
/set waldorfDWManaCost=22
/def waldorfPromptHookCheck_failing = \
    /if ({waldorfPromptHookCheckToggle} == 1 & {automidround} == 1) /echo -pw Position: %{currentPosition}%;/endif%;\
    /if ({curr_mana} >= {waldorfDWManaCost} & {waldorfPromptHookCheckToggle} == 1 & {automidround} == 1 & {currentPosition} == "fight") \
        /waldorfmidround_fromprompt%;\
        /set waldorfPromptHookCheckToggle=0%;\
    /endif

/def -wwaldorf -mregexp -auCwhite -p9 -t'Your illusory shield dissipates.' waldorf_illusoryshielddrop = \
    /set illusoryshieldleft=-1%;\
    /if ({refreshmisc} == 1) /q 5 c 'illusory shield'%;/endif

;; mob-specific triggers
;/def -p99 -ab -F -mregexp -t"^You start fighting (an elemental|a crushing force of stone)." waldorf_stomper_mobs_start = /setMySpell rupture
;/def -p99 -ab -F -mregexp -t"^(An elemental|A Crushing Force Of Stone) is DEAD!!" waldorf_stomper_dead = /setMySpell dancing weapon

/def -wwaldorf -au -mregexp -p2 -t'^Your lungs begin to burn as you fight the urge to gasp for air\!$' waldorf_drowning = c 'water breath'

;; Cast minds eye before wearing all
/def -wwaldorf -p0 -mglob -ag -h'SEND wear all' hook_waldorf_wear_all = /send stand=quicken 5=c 'minds eye'=quicken off=wear all

;;; scripts to bipass migraine effects if stuff is stacked
/def -wwaldorf -p1900 -mregexp -ahCwhite -t"^You feel a slight headache growing stronger\.\.\." waldorf_migraine=/if ({running}==1) c 'water breath'%;/endif

/def -wwaldorf -au -p9 -F -mglob -t'Your force shield shimmers then fades away.' waldorf_focidrop = \
    /if ({running} == 1) /send racial fly%;/endif

;; Some stomp avoidance tricks
/def -p800 -F -t"A Dark Fae beastmaster is DEAD!!" waldorf_beastmaster_dead = /setMySpell mindwipe%;/aq /setMySpell fandango

;;; ---------------------------------------------------------------------------
;;; Random quotes
;. The question is, who cares?
;. Just when you think this run is terrible something wonderful happens. It ends.

;; Load in the variables saved from previous state.
/loadCharacterState waldorf
