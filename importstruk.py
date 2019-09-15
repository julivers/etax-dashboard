#!/usr/bin/env python

import sys
import os

import csv
import MySQLdb

mydb = MySQLdb.connect(host='localhost',
    user='batam',
    passwd='batam2016',
    db='taxdb',unix_socket="/var/run/mysqld/mysqld.sock")
cursor = mydb.cursor()

def loadcsv(csvfile):
 csv_data = csv.reader(file(csvfile))
 for row in csv_data:
    cursor.execute('INSERT IGNORE INTO struk(deviceid,msisdn,tgltransaksi,jumlah,nostruk) VALUES(%s, %s, %s, %s, %s)',row)
#    cursor.execute('UPDATE data_gis set status = %s where msisdn = %s',(row[1],row[0]))
#close the connection to the database.
 mydb.commit()
 cursor.close()
    #print row[1]

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print >>sys.stderr, "Usage: %s <csv file>" % sys.argv[0]
        sys.exit(1)
    loadcsv(sys.argv[1])

