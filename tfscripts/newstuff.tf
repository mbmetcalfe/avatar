/def -mregexp -p2 -t"The System time \(EST\) is currently:[ ]+ (Mon|Tue|Wed|Thr|Fri|Sat|Sun) (.*)" ava_systime = \
    /echo 1: %p1 - 2: %p2
;The last restore was done by Pulse at:        Wed Nov  8 04:25:10 2006
