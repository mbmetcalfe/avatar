;;; Load in files we want for Avatar
/echo -p %% @{hCyellow}Loading @{CWhite}Avatar @{Cyellow}files...@{n}

;;; Avatar ticksize
/load -q tick.tf
/ticksize 28
/load -q ava-tick.tf
/def -i tick_warn = \
    /if ({visual} =~ "off" ) \
       /echo %% Tick in about 10 seconds.%;\
    /endif
;/def -i tick_action = \
;    /if ({myclass} !~ "stm" & $[is_connected()] == 1) \
;        /send =%;\
;    /endif%;\
;    /echo %% TICK
;/def -i tick_action = \
;    /if ($[is_connected()] == 1) \
;        /send =%;\
;    /endif%;\
;    /echo %% TICK
/def -i tick_action = \
    /echo %% TICK%;\
    /send =
;    /if ({running} == 1) /send =%;/endif

;;; Damage display/counter
/load -q damage.tf
;;; Autorescue
/load -q rescue.tf
;;; Run stats counter/reporter
/load -q runstuff.tf
;;; Spell info/displaying
/load -q spellinfo.tf
;;; Kill target triggers
/load -q targets.tf
;;; Queue for commands emulation
/load -q queue.tf
;;; Read/Execute commands from a DB table
/load -q cmdinfusion.tf
;;; Auto-loot stuff
/load -q loot.tf
;;; login/connection helpers
/load -q login.tf
;;; language translations
/load -q language.ava.tf
;;; Auto-tracking
/load -q autotrack.tf
;;; prompt hook
/load -q prompt.tf
;; load the default prompt
/my_default_prompt

;;; Gear swapping
/load -q gear.tf
;;; autowalk macroes/trigs
/load -q autowalk.tf
;;; highlights
/load -q highlights.tf
;;; group stats
/load -q groupstats.tf
;;; ranking scripts
/load -q rank.tf
;;; Email/SMS
/load -q notify.tf

;;; Other supporting scripts
/load -q resistance.tf
/load -q archer.tf
/load -q rogue.tf
/load -q repair.tf

;;; char 'state' saving stuff
/load -q state.tf

;;; Bot/Auto heal scripts
/load -q autospell.tf

;;; Auto charge
/load -q autocharge.tf

;;;  Logging stuff
/load -q gear-logging.tf
/load -q log-channels.tf

;;; Quest-related scripts
/load -q quest_allegaagse.tf
/load -q quest_bovul_treasure.tf
/load -q quest_eragora.tf
/load -q quest_midgaard.tf
/load -q quest_lord.tf

;;; GMCP, etc
/load -q gmcp.tf
/load -q generic.tf
/load -q vars.tf

;; to avoid having to reload ava-macro.tf, will try putting this here
/def -b'^P' key_prev_hx = /dokey recallb
/def -b'^N' key_next_hx = /dokey recallf

/echo -p %% @{hCyellow}Done loading @{Cwhite}Avatar @{Cyellow}files.@{n}
