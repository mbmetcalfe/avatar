/load -q healer.tf

/alias hos c 'holy sight' %*
/alias invinc c invinc %1

;/def -mregexp -p9 -F -wjekyll -t'^You are now AFK.$' jekyll_afk_trigger = \
;    /if ({drone}=0) /drone%;/endif

;; Load in the variables saved from previous state.
/loadCharacterState jekyll

