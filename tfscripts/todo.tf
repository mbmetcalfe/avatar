;;; todo.tf
;;; List of macroes and triggers that could be handy, with some work.

;; Would like to make this trigger either highlight items, or send it to
;; a file to be parsed by a script.  The items to be highlighted could be
;; contained in a db.
/def -p1 -ah -mregexp -t'^#[ ]*[0-9]+[ ]+\\[[0-9]+[ ]+[0-9]+\\] .*\\.$' shop_list

