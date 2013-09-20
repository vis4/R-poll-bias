# encoding: utf-8
import csv
from os.path import exists
from datetime import date
import json
import dataset
import sqlalchemy

src = json.load(open('prognosen-live.json'))
# out = csv.writer(open('progrnosen.csv', 'w'), dialect='excel-tab')

init = not exists('prognosen.db')

ds = dataset.connect('sqlite:///prognosen.db')
t = ds['prognosen']

if init:
    print "init"
    t.create_column('inst', sqlalchemy.Enum('Emnid', 'Infratestdimap', 'Forsa', 'GMS', 'Forsch’gr.Wahlen', 'Allensbach'))
    t.create_column('date', sqlalchemy.Date)
    t.create_index(['inst', 'date'])
    t.create_index(['inst'])
    t.create_index(['date'])

for e in src:
    date_parts = map(int, e['date'].split('-'))
    e['date'] = date(*date_parts)
    for k in e:
        if k != 'date' and k != 'inst' and k not in t.columns:
            print 'new column', k
            t.create_column(k, sqlalchemy.Float)
    t.upsert(e, ['date', 'inst'])

# also read progrnosen.csv
src = csv.reader(open('sonntagsfrage.csv', 'r'), dialect='excel-tab')
keys = src.next()

for row in src:
    e = dict()
    for i in range(len(keys)):
        k = keys[i]
        if k == 'date':
            try:
                e[k] = date(*map(int, row[i].split('-')))
            except ValueError:
                print map(int, row[i].split('-'))
                exit()
        elif k == 'inst':
            e[k] = row[i].decode('utf-8')
        else:
            if k not in t.columns:
                print 'new column', k
                t.create_column(k, sqlalchemy.Float)
            try:
                e[k] = float(row[i])
            except ValueError:
                e[k] = None
    t.upsert(e, ['date', 'inst'])