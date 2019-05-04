;;; ---------------------------------------------------------------------------
;;; more_complete.tf
;;; Allows you to easily add to the tab-complete list and saves the list to a 
;;; file so that it can be reloaded everytime TF starts.
;;; /tabadd value[s]	- to add word[s] to the tab list.
;;; /tabsave		- to save current tablist to file.
;;; /retab		- load tab list from file.
;;; /tablist		- show current tab list.
;;; ---------------------------------------------------------------------------
/require complete.tf

; Map 'TAB' to be completion char
;/def -ib'^I'  = /complete
/def key_tab = /complete

/def tabadd = /set completion_list=%completion_list %*

/def tabsave = \
    /echo -p %% Saving tab list to ".tablist"%; \
    /sys echo "/set completion_list="%completion_list > .tablist
/def retab = \
    /echo -p %% Loading tab list from ".tablist"%; \
    /load -q .tablist
/def tablist = /echo %% Tab List: %completion_list
/retab

