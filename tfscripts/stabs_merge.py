#!/usr/bin/env python3
import sqlite3
import os
import yaml
#import ruamel.yaml
import sys
#from ruamel.yaml.comments import CommentedMap
from pprint import pprint
from collections import OrderedDict

fd = os.open('mine/av.db', os.O_RDONLY)
db = sqlite3.connect('/dev/fd/%d' % fd)

#ordered_stabs = CommentedMap()
ordered_stabs = {}
stabs = {}
stabs_yaml = open('stabs.yaml')
with open('stabs.yaml') as f:
    stabs = yaml.safe_load(f)

def load_stabs_data(like, f):
    f.write("# %s\n" % like)
    #print("# %s" % like)
    curs = db.cursor()
    stmt = "select mob, zoneid from zonemob where zoneid in (select id from zone where name like ?) order by zoneid asc, mob asc"
    curs.execute(stmt, (like,))
    last_zoneid = 0
    area = ""
    for mob in curs.fetchall():
        if last_zoneid != mob[1]:
            last_zoneid = mob[1]
            stmt2 = "select name from zone where id = ?"
            curs2 = db.cursor()
            curs.execute(stmt2, (last_zoneid,))
            zone = curs.fetchone()
            area = zone[0]
            print("# " + area)
            f.write("# %s\n" % area)
        mobname = mob[0]

        delay = stabs.get(mobname, 0)
        #if type(foundmob) != dict:
        #    delay = foundmob
        #    foundmob = {'delay': foundmob}

        #if 'delay' not in foundmob:
        #    foundmob['delay'] = 0

        #foundmob['area'] = area
        mobname = mobname.replace('"', r'\"')
        ordered_stabs[mobname] = delay
        print("{}: {}".format(mob[0], delay))
        f.write("\"{}\": {}\n".format(mobname, delay))


with open('stabs.yaml', 'w') as f:
    load_stabs_data('%51%51%', f)
    load_stabs_data('%HERO%', f)
    load_stabs_data('%LORD%', f)
    
    #print("# unknown area")
    f.write("# unknown area\n")

    for mob, delay in stabs.items():
        if mob not in ordered_stabs:
            #ordered_stabs[mob] = {'delay': 0, 'area': 'unknown'}
            ordered_stabs[mob] = 0
            mob = mob.replace('"', r'\"')
            #print("{}: {}".format(mob, delay))
            f.write("\"{}\": {}\n".format(mob, delay))

#pprint(stabs)
#print(yaml.safe_dump(ordered_stabs, sort_keys=False))
#with open('stabs.yaml', 'w+') as f:
#    ruamel.yaml.round_trip_dump(ordered_stabs, f)

