;; generic.tf

;; /sendlocal stuff         Sends stuff to the local server. Used for tracking stats, healing, etc.
/def sendlocal=/if /test $[is_connected('local')] == 1%;/then /echo -wlocal %*%;/send -wlocal %*%;/endif

/def -F -ar -mregexp -p99 -t"^Link refreshed. Enjoy the priority.$" gmcp_group_refresh = /send-gmcp char.group.list
/def -F -ar -mregexp -p99 -t"[a-zA-Z]+'s group:" gmcp_group_list = /send-gmcp char.group.list
/def -F -ar -mregexp -p99 -t"^You remove [a-zA-Z]+ from your group." gmcp_groupie_removed = /send-gmcp char.group.list
/def -F -ar -mregexp -p99 -t"^([A-Za-z]+ disbands the group|Your group has disbanded)." gmcp_group_disbanded = /send-gmcp char.group.list
/def -F -ar -mregexp -p99 -t"^[a-zA-Z]+ (joins your group|stops following you)." gmcp_groupie_change = /send-gmcp char.group.list
/def -F -ar -mregexp -p99 -t"^[a-zA-Z]+ joins ([a-zA-Z]+)'s group\." gmcp_groupie_added = /if ({P1} =~ {leader}) /send-gmcp char.group.list%;/endif    
/def -F -ar -mregexp -p99 -t"^You stop following ([a-zA-Z]+)." gmcp_stop_following = /if ({P1} =~ {leader}) /send-gmcp char.group.list%;/endif

;; create air hammers and throw away the old ones. Only keeps ones with >= 24 dr
;; /hammer                     Toggle on/off for continuous casting
;; /set rcbot=someone          Who to send tells for remove curse to
/def hammer=/auto hammer %1

/def -F -mregexp -t"^'air hammer     '  modifies damage roll by  (1[0-9]|2[0-3]) continuous" air_hammer01 = drop hammer
/def -ahCyellow -F -mregexp -t"^'air hammer     '  modifies damage roll by  (2[4-9]|3[0-9]) continuous" air_hammer02 = put ham %{main_bag}
/def -F -mregexp -t"^'air hammer     '  modifies hit roll by " autoham=/if /test $(/getvar auto_hammer) == 1%;/then c 'air hammer'%;/endif
/def -F -mregexp -t"^You create a magic air hammer!$" autoham2=/if /test $(/getvar auto_hammer) == 1%;/then t %{rcbot} rc%;/endif
/def -F -mregexp -t"^Your a magic air hammer glows blue.$" autoham3=/if /test $(/getvar auto_hammer) == 1%;/then c id ham%;/endif

