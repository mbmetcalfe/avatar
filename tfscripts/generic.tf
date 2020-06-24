;; generic.tf

;; /sendlocal stuff         Sends stuff to the local server. Used for tracking stats, healing, etc.
/def sendlocal=/if /test $[is_connected('local')] == 1%;/then /echo -wlocal %*%;/send -wlocal %*%;/endif

/def -F -ar -mregexp -p99 -t"^Link refreshed. Enjoy the priority.$" gmcp_group_refresh = /send-gmcp char.group.list
/def -F -ar -mregexp -p99 -t"[a-zA-Z]+'s group:" gmcp_group_list = /send-gmcp char.group.list
/def -F -ar -mregexp -p99 -t"^You remove [a-zA-Z]+ from your group." gmcp_groupie_removed = /send-gmcp char.group.list
/def -F -ar -mregexp -p99 -t"^([A-Za-z]+ disbands the group|Your group has disbanded)." gmcp_group_disbanded = /send-gmcp char.group.list
/def -F -ar -mregexp -p99 -t"^[a-zA-Z]+ (joins your group|stops following you)." gmcp_groupie_change = /send-gmcp char.group.list
/def -F -ar -mregexp -p99 -t"^[a-zA-Z]+ joins ([a-zA-Z]+)'s group\." gmcp_groupie_added = /if ({P1} =~ {leader}) /send-gmcp char.group.list%;/endif    

