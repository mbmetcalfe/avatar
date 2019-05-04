/def -p5 -mglob -t"Quarters of the Banshee Commander" count_animated_corpses_start = /set numAnimatedCorpses=0
/def -p5 -mglob -t"*The animated corpse of *" count_animated_corpses = /set numAnimatedCorpses=$[{numAnimatedCorpses}+1]
/def -p5 -mglob -t"*The banshee commander is here planning the destruction of her enemies." count_animated_corpses_stop = /echo -pw @{Cred}[MOB INFO]: @{Cred}There are @{Cyellow}%{numAnimatedCorpses} @{Cred}animated corpses in @{Cyellow}Quarters of the Banshee Commander@{Cred}.@{n}

