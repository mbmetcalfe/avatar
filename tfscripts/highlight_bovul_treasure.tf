;;; ---------------------------------------------------------------------------
;;; highlight_bovul_treasure.tf
;;; Highlight when Bo'vul Treasure gear is mentioned/listed
;;; ---------------------------------------------------------------------------
/def searchtreasure = /recall -l -mregexp 0- (treasure)
/def -ag -P -F -t'a necklace of severed Fae ears(.*)' highlight_bovul_001 = /test $[echoGearItem({PL}, "a necklace of severed Fae ears",  "treasure", {P1})]
/def -ag -P -F -t'Amulet of Guiding Wind(.*)' highlight_bovul_002 = /test $[echoGearItem({PL}, "Amulet of Guiding Wind",  "treasure", {P1})]
/def -ag -P -F -t'a jade bracer(.*)' highlight_bovul_003 = /test $[echoGearItem({PL}, "a jade bracer",  "treasure", {P1})]
/def -ag -P -F -t'naeadonna\'s choker(.*)' highlight_bovul_004 = /test $[echoGearItem({PL}, "naeadonna's choker",  "treasure", {P1})]
/def -ag -P -F -t'exaltra\'s mirror(.*)' highlight_bovul_005 = /test $[echoGearItem({PL}, "exaltra's mirror",  "treasure", {P1})]
/def -ag -P -F -t'majestre\'s crop(.*)' highlight_bovul_006 = /test $[echoGearItem({PL}, "majestre's crop",  "treasure", {P1})]
/def -ag -P -F -t'some astral powder(.*)' highlight_bovul_007 = /test $[echoGearItem({PL}, "some astral powder",  "treasure", {P1})]
/def -ag -P -F -t'a silver iguana(.*)' highlight_bovul_008 = /test $[echoGearItem({PL}, "a silver iguana",  "treasure", {P1})]
/def -ag -P -F -t'a floating circle of books(.*)' highlight_bovul_009 = /test $[echoGearItem({PL}, "a floating circle of books",  "treasure", {P1})]
/def -ag -P -F -t'a green silken sarong(.*)' highlight_bovul_010 = /test $[echoGearItem({PL}, "a green silken sarong",  "treasure", {P1})]
/def -ag -P -F -t'an orb of gith(.*)' highlight_bovul_011 = /test $[echoGearItem({PL}, "an orb of gith",  "treasure", {P1})]
/def -ag -P -F -t'Yorimandil\'s Blindfold(.*)' highlight_bovul_012 = /test $[echoGearItem({PL}, "Yorimandil's Blindfold",  "treasure", {P1})]
/def -ag -P -F -t'a sandblasted emerald' highlight_bovul_013 = /test $[echoGearItem({PL}, "a sandblasted emerald",  "treasure", {P1})]
/def -ag -P -F -t'the amulet of the Cat\'s Eye' highlight_bovul_014 = /test $[echoGearItem({PL}, "the amulet of the Cat's Eye",  "treasure", {P1})]
/def -ag -P -F -t'the Orb of Bravery' highlight_bovul_015 = /test $[echoGearItem({PL}, "the Orb of Bravery",  "treasure", {P1})]
/def -ag -P -F -t'Treaty of purity of faith' highlight_bovul_016 = /test $[echoGearItem({PL}, "Treaty of purity of faith",  "treasure", {P1})]
/def -ag -P -F -t'Rod of the wicked rulers' highlight_bovul_017 = /test $[echoGearItem({PL}, "Rod of the wicked rulers",  "treasure", {P1})]
/def -ag -P -F -t'a crown of crystal' highlight_bovul_018 = /test $[echoGearItem({PL}, "a crown of crystal", "treasure", {P1})]
/def -ag -P -F -t'the armband of the Unseen' highlight_bovul_019 = /test $[echoGearItem({PL}, "the armband of the Unseen", "treasure", {P1})]
