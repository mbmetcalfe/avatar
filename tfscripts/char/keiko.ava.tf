;;; keiko.ava.tf
;;; Specific variables/macroes for Keiko
;;; Oct 21, 2007: Hero 500 - 5009 hp  565 ma   2582 mv
;;; Jan 19, 2010: Hero 791 - Killed UD.
;;;  Full AC + scorpion tattooes and crimsonscale skirt
;;;  q9 fear, ctr push then ctr kick +emu stance, then ctr hit and vampire
;;;  over quaffed using ~20 quaffs, ended up with 2.3k hps left.
;;; Jan 19, 2010: Hero 791 - Morphed -  32515 / 32515 hp, 1956 / 1956 m, 20208 / 20208 mv
;;; Feb 12, 2010: Remorted to Troll.
;;; Aug 31, 2016: Automorphed (5 extra levels): 38360 hp 2042 ma  14360 mv

;;; read in Keiko's gear file
/load -q char/keiko.gear.ava.tf

/require rogue.tf
/require monk.tf

/set monkHandMod=dagger hand

/def vamp = /send stance vampire fang
/def -wkeiko -p9 -F -t"You adopt vampire fang." keiko_vamp_up = /postpush crush
/def -wkeiko -p9 -F -t"You adopt emu stance." keiko_emu_up = /postpush kick
/def -wkeiko -p9 -F -t"You stop using vampire fang." keiko_vamp_down = /postpush kick

;; Add mon qi status items in manually
/status_add_mon
;; try and remove the status items, but don't work if using the /r command
/def -wkeiko -p0 -mglob -ag -h'SEND quit' hook_keiko_quit = \
    /status_rm_mon%;\
    /send quit

;; Load in the variables saved from previous state.
/loadCharacterState keiko
