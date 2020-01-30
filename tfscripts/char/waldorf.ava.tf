;;; ---------------------------------------------------------------------------
;;; waldorf.ava.tf
;;; ---------------------------------------------------------------------------
;;; 20160705: Killed UD at Hero 829
;;;    Full hit with carb, shroud, smoldering crown, no frenzy
;;;    Was tailed for 7 rounds, forgot to quicken until UD was at "quite a few wounds"
;;;    Didn't quaff and ended fight with: 943/  6157 hp   3058/  3881 ma
;;; 20160802: Morphed: 14506 hp  18300 ma   7458 mv
;;; 20160802: Evolved: 15240 hp  17740 ma   7536 mv
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

;/test waldorfMidSpell := (waldorfMidSpell | 'fandango')
;/def waldorfmidround = /send =
/def waldorfmidround = \
    /if ({waldorfMidSpell} =~ "fandango") \
        /if ({weapon_inhand} == 1) \
            c %{waldorfMidSpell}%;\
        /else \
;            /send get %{hit_wield}=wield %{hit_wield}%;\
            /echo -pw @{Cwhite}Weapons possibly missing/down.@{n}%;\
        /endif%;\
    /else \
        c %{waldorfMidSpell}%;\
    /endif

; * only named it _fromprompt since without it is automatically checked elsewhere.
/def waldorfmidround_fromprompt = \
    /if ({waldorfMidSpell} =~ "fandango") \
        /if ({weapon_inhand} == 1) \
            c %{waldorfMidSpell}%;\
        /else \
;            /send get %{hit_wield}=wield %{hit_wield}%;\
            /echo -pw @{Cwhite}Weapons possibly missing/down.@{n}%;\
        /endif%;\
    /else \
        c %{waldorfMidSpell}%;\
    /endif%;\
    /send =


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
;        /def generalPromptHookCheck=/set waldorfPromptHookCheckToggle=1%;\
;    /else /echo %{curr_mana} %{waldorfDWManaCost} %{waldorfPromptHookCheckToggle} %{automidround} %{currentPosition}%;\
    /endif

/def -wwaldorf -mregexp -auCwhite -p9 -t'Your illusory shield dissipates.' waldorf_illusoryshielddrop = \
    /set illusoryshieldleft=-1%;\
    /if ({refreshmisc} == 1) /q 5 c 'illusory shield'%;/endif

;; mob-specific triggers
;/def -wwaldorf -au -mregexp -p2 -t'You start fighting (Sieghard|A Glacial Guardian|gypsy bandit|The Frozen Demon Tourach|a gypsy bandit|a neonate Ecstasy Cultist|an Ecstasy Cult member|Warla)\.' waldorf_deception_hero_mobs = c deception
;/def -wwaldorf -au -mregexp -p2 -t'You start fighting (a desert dervish|Geisha guardian|a monk|Uda|Madam Muriel|a warlock|High Mage of the Mashan|a sorcerer|Veyah\'s sorcerer|Crullius the White|Ophanya|a drider priestess|The True Emperor|Shogun Senjisama)\.' waldorf_scramble_hero_mobs = c scramble
;/def -wwaldorf -au -mregexp -p2 -t'You start fighting (The small cook|An Adept of the Mashan|a Black assassin|the Black Circle assassin|a large behir|Kahbyss\' Grand Assassin|Velkor|a High Drow child|a giant pike|an Arachnakan|a Lizard Man assassin|an undead gardener)\.' waldorf_overconf_hero_mobs = c overconf

;/def -p99 -ab -F -mregexp -t"^You start fighting (an elemental|a crushing force of stone)." waldorf_stomper_mobs_start = /setMySpell rupture
;/def -p99 -ab -F -mregexp -t"^(An elemental|A Crushing Force Of Stone) is DEAD!!" waldorf_stomper_dead = /setMySpell dancing weapon

/def -wwaldorf -au -mregexp -p2 -t'^Your lungs begin to burn as you fight the urge to gasp for air\!$' waldorf_drowning = c 'water breath'

;;; ---------------------------------------------------------------------------
;/def -wwaldorf waldorflvl = /send get orb %{main_bag}=wear orb
;/def -wwaldorf waldorfunlvl = /send wear %{hit_held}=put orb %{main_bag}

;; Cast minds eye before wearing all
;/def -wwaldorf -p0 -mglob -ag -h'SEND wear all' hook_waldorf_wear_all = /send quicken 5=c 'minds eye'=quicken off=wear all

;;; scripts to bipass migraine effects if stuff is stacked
/def -wwaldorf -p1900 -mregexp -ahCwhite -t"^You feel a slight headache growing stronger\.\.\." migraine_disconnect_waldorf = \
    /if ({running}==1) /rc%;quicken off%;surge off%;c 'psychic drain'%;/endif

/def -wwaldorf -au -p9 -F -mglob -t'Your force shield shimmers then fades away.' waldorf_focidrop = \
    /if ({running} == 1) /send racial fly%;/endif

;/def -wwaldorf -mglob -p1 -t"Mayflower, Explorer and Trailblazer exclaims 'Follow me for Ocean Transport!'" mayflower_timed_follow = \
;    /if ({leader} =~ "Self") /repeat -0:0:04 1 /send follow mayflower%;/endif

;/def -wwaldorf -mglob -p1 -t"Mayflower, Explorer and Trailblazer says 'All aboard! Last call for Ocean Transport! If you aren't coming, go back to the geyser.'" mayflower_setup = \
;    /send vis=move=move=sneak=sneak%;\
;    /if ({leader} =~ "Self") /send west=fol self=linkrefresh group%;/endif

;;; ---------------------------------------------------------------------------
;;; Random quotes
;. The question is, who cares?
;. Just when you think this run is terrible something wonderful happens. It ends.

;; Load in the variables saved from previous state.
/loadCharacterState waldorf
