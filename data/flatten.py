# encoding: utf-8
import dataset
import csv

ds = dataset.connect('sqlite:///prognosen.db')
t = ds['prognosen']

out = csv.writer(open('flat.csv', 'w'), dialect='excel-tab')
out.writerow(['date', 'inst', 'party', 'value'])

def clean_inst(s):
    s = s.encode('utf-8')
    s = s.replace('Forsch’gr.Wahlen', 'FGW')
    s = s.replace('Forschgr.Wahlen', 'FGW')
    return s

for r in t:
    for k in r:
        if k != 'inst' and k != 'date' and k != 'id':
            row = [str(r['date']), clean_inst(r['inst']), k]
            if r[k] is None:
                row.append('')
            else:
                row.append(str(r[k]))
            out.writerow(row)
