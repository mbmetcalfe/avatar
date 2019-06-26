#!/usr/bin/python

import sqlite3 as lite
import sys
import argparse
import logging

def insertAlt(connection, mainAlt, alt):
    "Insert an alternate character for a main character."

    logger.debug('insertAlt: mainAlt = %s, alt = %s', mainAlt, alt)
    try:
        curExits = connection.cursor()
        curExists = connection.execute("select count(*) from alt_list where lower(name) = :alt or lower(main_alt) = :alt", {"alt": alt.lower()})
        exists = curExists.fetchone()[0]
        logger.debug('insertAlt: exists = %d' % exists)
    
        if exists > 0:
            print("%s already exists." % alt)
            return 0;

        logger.info("Insert %s as an alt of %s" % (alt, mainAlt))
        curInsAlt = connection.cursor()
        curInsAlt.execute("insert into alt_list (name, main_alt, imm) values (:alt, :main_alt, 0)", 
            {"main_alt": mainAlt.title(), "alt": alt.title()})
        connection.commit()

    except lite.Error as e:
        print("insertAlt: Error %s: " % e.args[0])
        return 0
    finally:
        return 1

conn = None

# create logger
logger = logging.getLogger('insert_alt')
logger.setLevel(logging.ERROR)
# create console handler
ch = logging.StreamHandler()
ch.setLevel(logging.ERROR)
# create formatter and add it to the handlers
formatter = logging.Formatter('%(levelname)s:  %(message)s')
ch.setFormatter(formatter)
# add the handlers to the logger
logger.addHandler(ch)

parser = argparse.ArgumentParser(description='Insert a character\'s alternates.')
parser.add_argument('-m', '--main', help='Main alt name.', required=True)
parser.add_argument('-a', '--alts', help='List of alts.', required=True)
args = parser.parse_args()

logger.debug("Main: %s. Alts: %s", args.main, args.alts)

try:
    qryName = args.main
    alts = args.alts

    conn = lite.connect('avatar.db')
    curMainAltName = conn.cursor()
    curMainAltName.execute("Select main_alt from alt_list where lower(name) = :qryName", {"qryName": qryName.lower()})

    mainAltRow = curMainAltName.fetchone()
    if mainAltRow == None:
        mainAlt = qryName.title()
        logger.info("%s not found.  Making %s the main alt.", qryName.title(), qryName.title())
    else:
        mainAlt = mainAltRow[0].title()

    curAltCount = conn.cursor()
    curAltCount.execute("select count(*) from alt_list where lower(name) = :mainAlt and lower(main_alt) = lower(name)", {"mainAlt": mainAlt.lower()})
    altCountRow = curAltCount.fetchone()
    # If main alt isn't in the db, insert it now.
    if altCountRow == None:
        altCount = 0
    else:
        altCount = altCountRow[0]
        
    if altCount == 0:
        insertAlt(conn, mainAlt, mainAlt)
        
    # Insert the alts
    for alt in alts.split():
        insertAlt(conn, mainAlt, alt)

except lite.Error as e:
    print("Error %s: " % e.args[0])
    sys.exit(1)

finally:
    if conn:
        conn.close()
