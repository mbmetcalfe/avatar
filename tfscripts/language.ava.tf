;; language.ava.tf
;;
;; Contributors:
;;	Harliquen ( khaosse_angel@alpha.net.au )
;;
;; A very rough language translator.
;; At the moment the only language it translates is thief cant, this is due
;; to the complexity of a translator capable of doing a shift through each
;; possible language shift and a dictionary match of some description to
;; identify which language was being used.
;; I am contemplating completing this, but for now it's in the 'too much
;; effort, too litle interest' basket. If enough people express interst in
;; this I may get around to it, or if someone's really keen on writing a
;; tf shift-cipher decription module, that'd be great. But until then....

/require tr.tf
/def -mregexp -t'^[A-Z][a-z]+ (.*) \'(.*)\', in a foreign tongue.' translate = \
	/tr OKLMUNPQARSTVWEXYZBCIDFGHJoklmunpqarstvwexyzbcidfghj ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz %{P2}
/def -mregexp -t'^[A-Za-z]+ tells the group \'(.*)\', in a foreign tongue.' translategt = \
	/tr OKLMUNPQARSTVWEXYZBCIDFGHJoklmunpqarstvwexyzbcidfghj ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz %{P1}
