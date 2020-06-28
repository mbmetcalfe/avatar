;;; status_line.tf
;; Some macros and triggers to manipulate status line variables

;;; Generic macro used to return current stance and duration in the format
;;; Stance:Duration
;;; TODO: Try to make it better/smarter!
;;;  Possibly create a list of all stance to report back.
/def -i getStanceStatus = \
  /let active_stance=None%;\
  /let stance_duration=-1%;\
; bladedancer stances
  /if ({bladedanceleft} > 0) \
    /let active_stance=bladedance%;\
    /let stance_display=Blade%;\
  /endif%;\
  /if ({dervishdanceleft} > 0) \
    /let active_stance=dervishdance%;\
    /let stance_display=Dervish%;\
  /endif%;\
  /if ({inspiringdanceleft} > 0) \
    /let active_stance=inspiringdance%;\
    /let stance_display=Inspiring%;\
  /endif%;\
  /if ({unendingdanceleft} > 0) \
    /let active_stance=unendingdance%;\
    /let stance_display=Unending%;\
  /endif%;\
  /if ({veilofbladesleft} > 0) \
    /let active_stance=veilofblades%;\
    /let stance_display=Veil%;\
  /endif%;\
; warrior stances
  /if ({protectivestanceleft} > 0) \
    /let active_stance=protectivestance%;\
    /let stance_display=Protective%;\
  /endif%;\
  /if ({relentlessstanceleft} > 0) \
    /let active_stance=relentlessstance%;\
    /let stance_display=Relentless%;\
  /endif%;\
  /if ({surefootstanceleft} > 0) \
    /let active_stance=surefootstance%;\
    /let stance_display=Surefoot%;\
  /endif%;\
; soldier stances
  /if ({phalanxleft} > 0) \
    /let active_stance=phalanx%;\
    /let stance_display=Phalanx%;\
  /endif%;\
  /if ({echelonleft} > 0) \
    /let active_stance=echelon%;\
    /let stance_display=Echelon%;\
  /endif%;\
  /if ({squareleft} > 0) \
    /let active_stance=square%;\
    /let stance_display=Square%;\
  /endif%;\
  /if ({columnleft} > 0) \
    /let active_stance=column%;\
    /let stance_display=Column%;\
  /endif%;\
  /let stance_duration_name=%{active_stance}left%;\
  /if ({active_stance} =~ "None") \
    /return "No Stance"%;\
  /else \
    /let stance_duration=$[expr({stance_duration_name})]%;\
    /return "%{stance_display}:%{stance_duration}"%;\
  /endif

;;; Curde method of getting spell duration - just take the greater of the macro spell duration
/def -i getSpellDuration = \
    /let spellDuration=%{aegisleft}%;\
    /if ({awenleft} > {spellDuration}) /let spellDuration=%{awenleft}%;/endif%;\
    /if ({focileft} > {spellDuration}) /let spellDuration=%{focileft}%;/endif%;\
    /if ({fortitudesleft} > {spellDuration}) /let spellDuration=%{fortitudesleft}%;/endif%;\
    /if ({spellDuration} < 0) /let spellDuration=0%;/endif%;\
    /return "Spells:%{spellDuration}"

;;; Set misc status line field as spell duration
/def generic_char_status = \
  /set status_misc=$[getSpellDuration()]%;\
  /let curDurationLen=$[strlen({status_misc})]%;\
  /status_edit_misc %{curDurationLen}

