;;; purohitah.ava.tf
;; 
;/load -q char/purohitah.gear.ava.tf

;;; set up other variables
/set myclass=prs
/set myrace=tua
/set lootContainer=loot
;; spell queue spell to give.
/set my_spell=invincibility

/redef off
/alias hos c 'holy sight' %*
/alias invinc c invinc %1

/def -wpurohitah gsup = \
	filter +spellother%; \
	gtell |c|Ok, here comes spells, sleep if you want to avoid spam.  You may want to |y|remove capes|c|.|w|%; \
	preach water breath%;preach iron skin%;preach fortitudes%;preach foci%;preach aegis%; \
	filter -spellother%; \
	gtell |r|Frenzy |c|if you need to.|w|

/alias p preach %*
/alias pt c 'pure touch' %*
/alias cla c clarify %*
/alias pan c panacea %*
/alias pcc preach cure critical
/alias phe preach heal
/alias pdiv preach div
/alias pto preach pure touch
/alias pinn preach innocence
/alias inno c innocence %*
/alias swa sleep%;/addq wake
;/alias kin /eval /send emote attacks %targetMob=c innoc %1
;/alias pin /eval /send emote attacks %targetMob=preach innoc
/alias comf c comfort %*
/redef on
