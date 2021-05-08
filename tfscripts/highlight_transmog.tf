;;; ---------------------------------------------------------------------------
;;; highlight_transmog.tf
;;; Highlight when highlight_transmog gear is mentioned/listed
;;; ---------------------------------------------------------------------------
/loaded __TFSCRIPTS__/highlight_highlight_transmog.tf

/def searchighlight_transmog = /recall -l -mregexp 0- (highlight_transmog)

;;; ---------------------------------------------------------------------------
;; Cubes
;;; ---------------------------------------------------------------------------
/def -ag -P -F -t'a Token of the Gyrosphinx(.*)' h_transmog_001 = /test $[echoGearItem({PL}, "@{hCblack} a Token of the Gyrosphinx@{n}",  "transmog-token", strcat({P1}, " (token to get cube OR 20% death xp redux)"), {PR})]
/def -ag -P -F -t'a lordly cloak engraved cube(.*)' h_transmog_002 = /test $[echoGearItem({PL}, "a lordly cloak engraved cube",  "transmog-cube", strcat({P1}, " (about body)"), {PR})]
/def -ag -P -F -t'a lordly leggings engraved cube(.*)' h_transmog_003 = /test $[echoGearItem({PL}, "a lordly leggings engraved cube",  "transmog-cube", strcat({P1}, " (legs)"), {PR})]
/def -ag -P -F -t'a lordly chestplate engraved cube(.*)' h_transmog_022 = /test $[echoGearItem({PL}, "a lordly chestplate engraved cube",  "transmog-cube", strcat({P1}, " (on body)"), {PR})]
/def -ag -P -F -t'a lordly stone engraved cube(.*)' h_transmog_006 = /test $[echoGearItem({PL}, "a lordly stone engraved cube",  "transmog-cube", strcat({P1}, " (held)"), {PR})]
/def -ag -P -F -t'a lordly gauntlet engraved cube(.*)' h_transmog_025 = /test $[echoGearItem({PL}, "a lordly gauntlet engraved cube",  "transmog-cube", strcat({P1}, " (hands)"), {PR})]

;;; ---------------------------------------------------------------------------
;; Base Items
;;; ---------------------------------------------------------------------------
/def -ag -P -F -t'twinkling stars(.*)' h_transmog_004 = /test $[echoGearItem({PL}, "@{hCblue}twinkling @{hCyellow}stars@{n}", "transmog-base", strcat({P1}, " (30hp, 30mana)"), {PR})]
/def -ag -P -F -t'the greaves of desolation(.*)' h_transmog_005 = /test $[echoGearItem({PL}, "@{hCblack}the greaves of desolation@{n}", "transmog-base", strcat({P1}, " (-45ac)"), {PR})]
/def -ag -P -F -t'aura of corruption(.*)' h_transmog_018 = /test $[echoGearItem({PL}, "@{hCblack}aura of corruption@{n}", "transmog-base", strcat({P1}, " (base item)"), {PR})]
/def -ag -P -F -t'Verdant Gloves(.*)' h_transmog_024 = /test $[echoGearItem({PL}, "@{Cgreen}Verdant Gloves@{n}", "transmog-base", strcat({P1}, " (base item)"), {PR})]

;;; ---------------------------------------------------------------------------
;; Ingredients
;;; ---------------------------------------------------------------------------

;;; Ingredients for the greaves of desolation
/def -ag -P -F -t'A kyanite gauntlet(.*)' h_transmog_007 = /test $[echoGearItem({PL}, "@{Cblue}A kyanite gauntlet@{n}", "transmog-mat", strcat({P1}, " (30hp, 25mana)"), {PR})]
/def -ag -P -F -t'a jade gauntlet(.*)' h_transmog_010 = /test $[echoGearItem({PL}, "@{Cgreen}a jade gauntlet@{n}", "transmog-mat", strcat({P1}, " (1hr, 2dr)"), {PR})]
/def -ag -P -F -t'A malachite gauntlet(.*)' h_transmog_011 = /test $[echoGearItem({PL}, "@{Cgreen}A malachite gauntlet@{n}", "transmog-mat", strcat({P1}, " (2hr, -20dr, 3%crit)"), {PR})]
/def -ag -P -F -t'an axinite gauntlet(.*)' h_transmog_012 = /test $[echoGearItem({PL}, "an axinite gauntlet", "transmog-mat", strcat({P1}, " (-5ac)"), {PR})]

;;; Ingredients for the Seal of the Abbot
/def -ag -P -F -t'[fF]inest [gG]rog(.*)' h_transmog_013 = /test $[echoGearItem({PL}, "Finest Grog", "transmog-mat", strcat({P1}, " (-5ac)"), {PR})]
/def -ag -P -F -t'[bB]utcher\'s [kK]nife(.*)' h_transmog_014 = /test $[echoGearItem({PL}, "butcher's knife", "transmog-mat", strcat({P1}, " (4dr)"), {PR})]
/def -ag -P -F -t'[fF]amiliar [mM]ane(.*)' h_transmog_015 = /test $[echoGearItem({PL}, "familiar mane", "transmog-mat", strcat({P1}, " (25mana)"), {PR})]

;; Ingredients for twinkling stars
/def -ag -P -F -t'[cC]rown of the [aA]ges(.*)' h_transmog_016 = /test $[echoGearItem({PL}, "Crown of the Ages", "transmog-mat", strcat({P1}, " (5stasis, -5leeching)"), {PR})]
/def -ag -P -F -t'a black bracer(.*)' h_transmog_008 = /test $[echoGearItem({PL}, "@{hCblack}a @{hCblack}black bracer@{n}", "transmog-mat", strcat({P1}, " (-10ac)"), {PR})]
/def -ag -P -F -t'a cretelli tooth(.*)' h_transmog_009 = /test $[echoGearItem({PL}, "a @{hCblack}cretelli tooth@{n}", "transmog-mat", strcat({P1}, " (2hr)"), {PR})]

;; Ingredients for aura of corruption
/def -ag -P -F -t'a black velvet cape(.*)' h_transmog_019 = /test $[echoGearItem({PL}, "a black velvet cape", "transmog-mat", strcat({P1}, " (-20ac)"), {PR})]
/def -ag -P -F -t'a random ring(.*)' h_transmog_020 = /test $[echoGearItem({PL}, "a random ring", "transmog-mat", strcat({P1}, " (60mana)"), {PR})]
/def -ag -P -F -t'a whip of thorns(.*)' h_transmog_021 = /test $[echoGearItem({PL}, "a whip of thorns", "transmog-mat", strcat({P1}, " (40mana)"), {PR})]

;; Ingredients for Verdant Gloves
/def -ag -P -F -t'A golden torque(.*)' h_transmog_023 = /test $[echoGearItem({PL}, "@{hCyellow}A golden torque@{n}", "transmog-mat", strcat({P1}, " (40mana)"), {PR})]
/def -ag -P -F -t'The Heart of the Forest(.*)' h_transmog_026 = /test $[echoGearItem({PL}, "@{hCgreen}The Heart of the Forest@{n}", "transmog-mat", strcat({P1}, " (2hr, 2dr)"), {PR})]

;; Ingredients for KWALASHAI
/def -ag -P -F -t'survivor tattoo(.*)' h_transmog_027 = /test $[echoGearItem({PL}, "@{hCblack}survivor tattoo@{n}", "transmog-mat", strcat({P1}, " (4dr)"), {PR})]


;;; ---------------------------------------------------------------------------
;; Base & Ingredients
;;; ---------------------------------------------------------------------------
/def -ag -P -F -t'the Seal of the Abbot(.*)' h_transmog_017 = /test $[echoGearItem({PL}, "@{hCblack}the Seal of the Abbot@{n}", "transmog-base", strcat({P1}, " (base item AND ingredient)"), {PR})]


