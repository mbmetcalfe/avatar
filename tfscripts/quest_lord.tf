;; -----------------------------------------------------------------------------
;;; quest_lord.tf
;;; This script will contain some helpful triggers/macroes to automate some of
;;; the lord-level quests
;; -----------------------------------------------------------------------------

;; Hide quest
/def -ag -Ph -F -t'an embossed hide' highlight_hide_quest_001 = /test $[echoGearItem(%{PL}, "an embossed hide", "quest", %{P1})]
/def -ag -Ph -F -t'the whole hide of a merman' highlight_hide_quest_002 = /test $[echoGearItem(%{PL}, "the whole hide of a merman", "quest", %{P1})]
/def -ag -Ph -F -t'a glazed gith hide' highlight_hide_quest_003= /test $[echoGearItem(%{PL}, "a glazed gith hide", "quest", %{P1})]

/def -ag -Ph -F -t'a mindflayer scalp' highlight_gith_remort_quest = /test $[echoGearItem(%{PL}, "a mindflayer scalp", "quest", %{P1})]


