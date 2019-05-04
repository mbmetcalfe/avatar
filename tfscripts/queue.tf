;;; ----------------------------------------------------------------------------
;;; queue.tf
;;; Commands to maintain a queue of commands to execute.
;;; it builds up a string composed of commands that are separated by #
;;; these commands can be mud commands or tf commands or even tf code pieces
;;; eg. /add_cmd look
;;; /add_cmd /do_this
;;; /add_cmd /look_at me%;/look_at enemy
;;; ----------------------------------------------------------------------------
/def addq = \
    /if (cmd_list =~ "") /set cmd_list=%*%;\
    /else /set cmd_list=%cmd_list#%*%;\
    /endif%;\
    /showq%;\
    /if (cmd_list !~ "") /statusflagcolour 1 CBlue Q%;/endif
    
/def insq = \
    /if (cmd_list=~"") /set cmd_list=%*%;\
    /else /set cmd_list=%*#%cmd_list%;\
    /endif%;\
    /showq
    
;; Command to take last command and put it in queue
/def key_f3 = /addq $(/recall -i -q /2)
/def key_f4 = /addq $[kbhead()]%;/kb_backward_kill_line

/alias insq /insq %*
/def iq = /insq %*
/alias iq /insq %*

/alias addq /addq %*
/def aq = /addq %*

;;; ----------------------------------------------------------------------------
;;; alias to quicken a move/kill
;;; ----------------------------------------------------------------------------
/def qi=/addq $(/first %{*})%;/addq ki $(/rest %{*})
/def ni=/addq ki %*
/alias qi /qi %*
/alias ni /ni %*
/alias clrq /clrq

;;; ----------------------------------------------------------------------------
;;; Grab first item in the list and excute is as a command
;;; ----------------------------------------------------------------------------
/def next_cmd = \
	/if (cmd_list!~"") \
        /let off=$[strchr(cmd_list,"#")]%; \
        /if (off>-1) \
            /let this_cmd=$[substr(cmd_list,0,off)]%; \
            /set cmd_list=$[substr(cmd_list,off+1)]%; \
        /else \
            /let this_cmd=%cmd_list%; \
            /set cmd_list=%; \
        /endif%; \
        /eval %this_cmd%; \
	/endif
;;; ----------------------------------------------------------------------------
;;; Execute all commands in the queue
;;; ----------------------------------------------------------------------------
/def key_f2 = /performQ
/def -i performQ = \
    /if (cmd_list !~ "") \
        /statusflagcolour 0 Cblue Q%;\
    /endif%;\
    /while (cmd_list!~"") \
        /next_cmd %; \
    /done

;;; ----------------------------------------------------------------------------
;;; Binded Queue commands
;;; /popq   (CTRL+P)    - pop next command off the queue
;;; /showq  (CTRL+Q)    - Show contents of queue.
;;; /clrq   (CTRL+E)    - Clear the queue.
;;; ----------------------------------------------------------------------------
/def -b'^O' popq = /next_cmd
/def -b'^E' clrq = \
    /if (cmd_list !~ "") \
        /unset cmd_list%;\
        /statusflagcolour 0 Cblue Q%;\
        /echo -p % @{Cred}Queue cleared.@{n}%;\
    /endif
/def -b'^Q' showq = /echo -p % @{Cred}Commands in Queue: @{Cyellow}%cmd_list@{n}

