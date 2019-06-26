#!/usr/bin/python

import sqlite3 as lite
import sys
import argparse

parser = argparse.ArgumentParser(description='Retrieve list of alternate characters.')
parser.add_argument('-f', '--filter', help='Filter imm alts.', action="store_true", default=False)
parser.add_argument("name", help='Name of character to find their alts.', type=str)
args = parser.parse_args()

filterAlts = args.filter
qryName = args.name

#print "%s, %s" % (filterAlts, qryName)

conn = None
alts = None

try:
    conn = lite.connect('avatar.db')
    curMainAltName = conn.cursor()
    curMainAltName.execute("Select main_alt from alt_list where lower(name) = lower(:qryName)", {"qryName": qryName})


    mainAltRow = curMainAltName.fetchone()
    if mainAltRow == None:
        print("%s not found." % qryName.title())
        sys.exit(0)

    mainAlt = mainAltRow[0]

    curAlts = conn.cursor()
    altSql = "select name from alt_list where \
        lower(main_alt) = lower(:mainAlt) and \
        lower(name) <> lower(main_alt) "
    if filterAlts:
        altSql = "%s %s" % (altSql, "and imm <> 1")
     
    altSql = "%s %s" % (altSql, "order by name")
#    print altSql
    
    curAlts.execute(altSql, {"mainAlt": mainAlt})

    sep = ''
    alts = ''
    while True:
        row = curAlts.fetchone()
        if row == None:
            break

        alts = ''.join([alts, sep, row[0].title()])
        sep = ' '
    if (alts == ''):
        print("%s has no registered alts." % mainAlt.title())
    else:
        print("%s %s" % (mainAlt, alts))

except lite.Error as e:
    print("Error %s: " % e.args[0])
    sys.exit(1)

finally:
    if conn:
        conn.close()

