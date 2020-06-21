#!/usr/bin/env python
import time
import subprocess as sp
import sqlite3

BUFFER_SIZE=1
HOST='127.0.0.1'
PORT=10002
# Colour variables to make outputting a little easier.
NOCOLOUR    = "\033[0m";
BLACK       = NOCOLOUR + "\033[30m"
RED         = NOCOLOUR + "\033[31m"
GREEN       = NOCOLOUR + "\033[32m"
YELLOW      = NOCOLOUR + "\033[33m"
BLUE        = NOCOLOUR + "\033[34m"
MAGENTA     = NOCOLOUR + "\033[35m"
CYAN        = NOCOLOUR + "\033[36m"
WHITE       = NOCOLOUR + "\033[37m"
BBLACK       = NOCOLOUR + "\033[01;30m"
BRED         = NOCOLOUR + "\033[01;31m"
BGREEN       = NOCOLOUR + "\033[01;32m"
BYELLOW      = NOCOLOUR + "\033[01;33m"
BBLUE        = NOCOLOUR + "\033[01;34m"
BMAGENTA     = NOCOLOUR + "\033[01;35m"
BCYAN        = NOCOLOUR + "\033[01;36m"
BWHITE       = NOCOLOUR + "\033[01;37m"

tmp = sp.call('clear',shell=True)
db = sqlite3.connect('/home/mike/avatar/tfscripts/mine/av.db')
curs = db.cursor()

while True:
  tmp = sp.call('clear',shell=True)
  curs.execute('select * from groupies order by hpcurr asc')
  groupies = curs.fetchall()

  cnt = 0
  msg = ''
  while True:
    cnt = 0
    for groupie in groupies:
      cnt += 1
      hpcol = WHITE
      mncol = WHITE
      namecol = YELLOW
      name = groupie[0][0:8].rjust(9)
      fighting = "  "
      if (groupie[1] < groupie[2]*.75):
        hpcol = RED
        namecol = BRED
      if (groupie[3] < groupie[4]/2):
        mncol = BRED
      if (groupie[5] == 'fight'):
        fighting = BRED + " F" + NOCOLOUR
      else:
        fighting = groupie[5][:2]
      msg = "%s%s%s" + NOCOLOUR + ": %s%d \ " + CYAN + "%d hp  %s%d \ " + GREEN + "%d m" + NOCOLOUR
      print msg % (fighting, namecol, name, hpcol, groupie[1], groupie[2], mncol, groupie[3], groupie[4]),
      if cnt % 2 == 0:
        print
      else:
        print "\n",
    break
  time.sleep(0.25)
