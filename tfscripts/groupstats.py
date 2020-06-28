#!/usr/bin/env python
import time
import subprocess as sp
import sqlite3
from tabulate import tabulate

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
  curs.execute('select substr(position,1, 3) position, name, hpcurr, hpmax, manacurr, manamax from groupies order by hpcurr asc')
  rows = list(curs.fetchall())
  cnt = 0
  msg = ''
  groupTable = []
  for groupie in rows:
      newGroupie = list(groupie)
      hpcol = WHITE
      mncol = WHITE
      namecol = YELLOW
      poscol = WHITE
      if (groupie[2] < groupie[3]*0.75):
          hpcol = RED
          namecol = BRED
      if (groupie[4] < groupie[5]/2):
          mncol = BRED
      if (groupie[0] == 'fig'):
          poscol = BRED
          newGroupie[0] = newGroupie[0].upper()
      newGroupie[0] = poscol + groupie[0] + NOCOLOUR
      newGroupie[1] = namecol + groupie[1] + NOCOLOUR
      newGroupie[2] = hpcol + str(groupie[2]) + NOCOLOUR
      newGroupie[3] = CYAN + str(groupie[3]) + NOCOLOUR
      newGroupie[4] = mncol + str(groupie[4]) + NOCOLOUR
      newGroupie[5] = GREEN + str(groupie[5]) + NOCOLOUR
      groupTable.append(newGroupie)
      cnt += 1

  #print(tabulate(groupTable, headers=["Pos", "Name", "HP", "MaxHP", "Mn", "MaxMn"], tablefmt="presto", colalign=("right", "right", "right", "left", "right", "left")))
  print(tabulate(groupTable, headers=["Pos", "Name", "HP", "MaxHP", "Mn", "MaxMn"], tablefmt="presto"))

#  time.sleep(0.25)
  time.sleep(1)
