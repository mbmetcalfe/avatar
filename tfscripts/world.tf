;;; ava-world.tf
;;; This is where your store your world definitions for Avatar.
;; The first line is just a place holder, the second is the avatar world.
/set gains_suffix=gains

/addworld -T'diku' null 127.0.0.1 4000
/test addworld("aveast", "diku", "avatar.outland.org", "3000")
/test addworld("testport", "diku", "avatar.outland.org", "5005")

;; "local" world for GMCP stuff
/addworld local 127.0.0.1 10002

;;; Load in server-specific worlds
/load -q ava-world.tf
