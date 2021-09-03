#!/usr/bin/env python

import socket
import SocketServer
import sys
import time
import threading
import sqlite3

HOST = '127.0.0.1'
PORT = 10002
BUFFER_SIZE = 1

verbs = {}
vals = {}

def verb2val(verb):
  return verbs.get(verb, 0)
def val2verb(val):
  if val not in vals:
    for v in sorted(vals.keys()):
      if val <= v:
         return vals.get(v).replace('=','-')
  return vals.get(val, 'pathetic').replace('=','-')

def handleData(msg, curs):
  print "received data:", msg
  parts = msg.split(':', 1)
  prefix = parts[0]
  try:
    if prefix == 'groupieclr':
      curs.execute("delete from groupies;")
    elif prefix == 'groupie':
      data = parts[1].split('|')
      data[0] = data[0].strip().lower()
      stats = map(int, data[1:-1])
      pos = data[-1].lower()
      name = data[0]
      data = [name]
      data.extend(stats)
      data.extend([pos])
      stmt = """insert into groupies(name, hpcurr, hpmax, manacurr, manamax, position) values(?,?,?,?,?,?);"""
      try:
        curs.execute(stmt, data)
      except:
        stmt = """update groupies set hpcurr = ?, hpmax = ?, manacurr = ?, manamax = ?, position = ? where name = ?;"""
        if "**" in pos:
          data.pop() # remove position
          stmt = """update groupies set hpcurr = ?, hpmax = ?, manacurr = ?, manamax = ? where name = ?;"""
        data.append(name)
        data.pop(0)
        curs.execute(stmt, data)
    elif prefix == 'level':
      data = parts[1].split('|')
      name = data[0].strip().lower()
      stats = map(int, data[1:])
      data = (name,)
      data = data + tuple(stats)
      stmt = """insert into gains(name, hp, mana, moves, practices) values(?,?,?,?,?);"""
      curs.execute(stmt, data)
    elif prefix == 'heal':
      targets = parts[1].split('|')
      healer = targets[0]
      targets = "','".join(targets[1:])
      stmt = "select name, hpcurr, hpmax from groupies where name in ('%s') order by hpcurr;" % targets
      #stmt = "select name, hpcurr, hpmax, (hpcurr*100/hpmax) from groupies where name in ('%s') order by 4;" % targets
      needsHeal = []
      curs.execute(stmt)
      for row in curs.fetchall():
        name = row[0]
        hpcurr = row[1]
        hpmax = row[2]
        if hpcurr + 800 < hpmax or hpmax / 2 > hpcurr:
          needsHeal.append(name)
      if len(needsHeal) > 2:
        return "%s:pc" % (healer)
      elif len(needsHeal) > 0:
        ret = ''
        for nh in needsHeal:
            ret += "%s:c comf %s\n" % (healer, nh)
        return ret.rstrip()
    elif prefix == 'groupstats':
      stmt = "select * from groupies order by hpcurr asc;"
      groupies = []
      curs.execute(stmt)
      for row in curs.fetchall():
        groupies.append("%s|%d|%d|%d|%d|%s" % (row[0], row[1], row[2], row[3], row[4], row[5]))
      return ','.join(groupies)
    elif prefix == 'avgs':
      p = parts[1].split('|')
      user = p[0]
      alt = p[1]
      limit = p[2]
      if not alt:
        alt = user
      stmt = """select count(*), round(avg(hp),2), round(avg(mana),2) from (select * from gains where name = ? order by id desc limit ?)"""
      curs.execute(stmt, (alt,limit))
      r = curs.fetchone()
      return "%s:bud avgs for %s over %d levels: %s/%s" % (user, alt, r[0], r[1], r[2])
    elif prefix == 'groupsort':
      stmt = "select name from groupies order by hpmax desc;"
      user = parts[1]
      curs.execute(stmt)
      cnt = 0
      ret = ""
      last = None
      for row in curs.fetchall():
        if cnt == 0:
          ret = "%s:grouporder %s front\n" % (user, row[0])
          last = row[0]
        else:
          ret += "%s:grouporder %s after %s\n" % (user, row[0], last)
          last = row[0]
        cnt += 1
      return ret.rstrip()
    elif prefix == 'dmg':
      stmt = "insert into damage_others(name, dam_val, dam_type) values(?, ?, ?)"
      data = parts[1].split('|')
      groupie = data[0]
      verb = data[1]
      dmgtype = data[2]
      val = verb2val(verb)
      curs.execute(stmt, (groupie, val, dmgtype))
    elif prefix == 'dmgrep':
      data = parts[1].split('|')
      charname = data[0]
      stmt = "select name, cast(round(avg(dam_val)) as integer), max(dam_val), sum(dam_val) as total from damage_others group by name order by total desc"
      qs = ()
      if len(data) == 2 and data[1]:
        stmt = "select name, cast(round(avg(dam_val)) as integer), max(dam_val), sum(dam_val) from damage_others where name = ?"
        qs = (data[1],)
      rets = []
      for row in curs.execute(stmt, qs):
        verb = val2verb(row[1])
        maxv = val2verb(row[2])
        s = "%s:gt |g|%s |n|averaged |y|%s(%d)|n|, max |r|%s|n|, total |c|%d|n|"
        args = (charname, row[0], verb, row[1], maxv, row[3])
	if charname == "echo":
          s = "/echo -p @{Cwhite}%s @{Cgreen}averaged @{Cyellow}%s (%d)@{Cgreen}, max @{Cred}%s@{Cgreen}, total @{Ccyan}%d"
          args = (row[0], verb, row[1], maxv, row[3])
        rets.append(s % args)
      return '\n'.join(rets)
    elif prefix == 'dmgclr':
      curs.execute("delete from damage_others")
    elif prefix == 'auctionclr':
      curs.execute("delete from auction;")
    elif prefix == 'auctiondel':
      data = parts[1].split('|')
      itemnum = int(data[0])
      itemname = data[1].strip()
      stmt = """delete from auction where item_number = ? and item = ?;"""
      try:
        curs.execute(stmt, (itemnum, itemname ))
      except Exception as e:
        print "Could not delete auction item #%d: %s" % (itemnum, e)
        pass
    elif prefix == 'auctionupd':
      data = parts[1].split('|')
      itemnum = int(data[0])
      itemname = data[1].strip()
      currentbid = int(data[2].replace(',', ''))
      
      stmt = """update auction set current_bid = ? where item_number = ? and item = ?;"""
      try:
        res = curs.execute(stmt, (currentbid, itemnum, itemname))
      except Exception as e:
        print "Could not update bid on item %d: %s" % (itemnum, e)

    elif prefix == 'auction':
      data = parts[1].split('|')
      itemnum = data[0]
      itemname = data[1].strip()
      currentbid = int(data[2].replace(',', ''))
      mins = data[3]
      itelevel = data[4]
      minbid = int(data[5].replace(',', ''))
      seller = data[6]

      stmt = """insert into auction(item_number, item, current_bid, current_mins, level, min_bid, seller) values(?,?,?,?,?,?,?);"""
      try:
        curs.execute(stmt, (itemnum, itemname, currentbid, mins, itelevel, minbid, seller))
      except:
        stmt = """update auction set current_bid = ?, current_mins = ?, level = ?, min_bid = ?, updated = datetime('now') where item_number = ? and item = ? and current_bid <> ?;"""
        try:
          curs.execute(stmt, (currentbid, mins, itelevel, minbid, itemnum, itemname, currentbid))
        except Exception as e:
          print "Could not insert or update auction item #%d: %s" % (itemnum, e)

    elif prefix == 'mobile':
      data = parts[1].split('|')
      zone_q = 'select id from zone where name = ?'
      zoneid = None
      for row in curs.execute(zone_q, (data[0],)):
        zoneid = row[0]
      if not zoneid:
        q = 'insert into zone(name) values(?)'
        curs.execute(q, (data[0],))
        zoneid = curs.lastrowid
      q = 'insert or ignore into zonemob(zoneid, mob) values(?, ?)'
      params = (zoneid, data[1])
      curs.execute(q, params)
    
  except (KeyboardInterrupt, SystemExit):
    return
  except Exception as e:
    print e
    pass
  return

class TCPHandler(SocketServer.BaseRequestHandler):
  def handle(self):
    try:
      db = sqlite3.connect('/home/mike/avatar/tfscripts/mine/av.db')
      curs = db.cursor()
      try:
        db.execute('CREATE TABLE gains(id integer primary key autoincrement, name text, hp integer, mana integer, moves integer, practices integer)')
      except Exception as e:
        pass
      #try:
      #  db.execute('CREATE TABLE damages(verb text, value integer)')
      #except:
      #  pass
      try:
        db.execute('CREATE TABLE groupies(name text, hpcurr integer, hpmax integer, manacurr integer, manamax integer, position text)')
      except:
        pass
      try:
        db.execute('CREATE UNIQUE INDEX groupies_name on groupies(name)')
      except:
        pass
      try:
        db.execute('CREATE TABLE zone(id integer primary key autoincrement, name text)')
      except:
        pass
      try:
        db.execute('CREATE UNIQUE INDEX zone_name on zone(name)')
      except:
        pass
      try:
        db.execute('CREATE TABLE zonemob(id integer primary key autoincrement, zoneid integer, mob text, unique(zoneid, mob))')
      except:
        pass
    
      try:
        db.execute('CREATE TABLE auction(item_number integer, item text, current_bid integer, current_mins integer, level integer, min_bid integer, seller text, updated DATE default current_timestamp)')
      except:
        pass
      try:
        db.execute('CREATE UNIQUE INDEX auction_item_number on auction(item_number, item)')
      except:
        pass
      db.commit()

      #mdb = sqlite3.connect(":memory:", isolation_level=None)
      #mcurs = mdb.cursor()
      #try:
      #  mdb.execute('CREATE TABLE groupies(name text, hpcurr integer, hpmax integer, manacurr integer, manamax integer, position text)')
      #except:
      #  pass
 
      stmt = "select * from damage"
      for dmg in curs.execute(stmt):
        verbs[str(dmg[4])] = dmg[2]
	vals[dmg[2]] = str(dmg[4])
      last_commit_time = time.time()
      msg = ""
      self.request.settimeout(0.5)
      while 1:
        try:
          data = self.request.recv(BUFFER_SIZE)
          if data == "\n":
            msg = msg.rstrip()
            resp = handleData(msg, curs)
            if time.time() - last_commit_time > 0.5:
                db.commit()
                last_commit_time = time.time()
            if resp != None:
              self.request.sendall(resp + "\n")
            msg = ""
          else:
            msg += data
          if not data: break
        except socket.timeout:
          db.commit()
          last_commit_time = time.time()
    except (KeyboardInterrupt, SystemExit):
      return
    except Exception as e:
      print e

if __name__ == "__main__":
 
  SocketServer.TCPServer.allow_reuse_address = True
  server = SocketServer.TCPServer((HOST, PORT), TCPHandler)
  ip, port = server.server_address
  print "Listening on {}:{}".format(HOST, PORT)
  server.serve_forever()
