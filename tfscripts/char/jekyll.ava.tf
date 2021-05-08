/load -q healer.tf

;/def -mregexp -p9 -F -wjekyll -t'^You are now AFK.$' jekyll_afk_trigger = \
;    /if ({drone}=0) /drone%;/endif

/loadCharacterState jekyll

