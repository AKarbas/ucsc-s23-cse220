#!/usr/bin/env python3

import os
import sys
import csv


# Identify desired path
path = sys.argv[1]
files = os.listdir(path)
metrics = [x.lower() for x in sys.argv[2:]]
csv_path = os.path.join(path, 'out.csv')
res = {}

csv_output = csv.writer(open(csv_path, 'w'))
csv_output.writerow(['entry','total','ratio'])

for f in files:
    if (os.path.isdir(f)
        or not f.endswith('.out')
        or not '.stat.' in f):
        continue

    with open(os.path.join(path, f), 'rt') as stat_file:
        for line in stat_file:
            line_parts = line.strip().lower().split()
            if 'ipc:' in line_parts and 'ipc' in metrics:
                ratio = line_parts[line_parts.index('ipc:') + 1]
                res['ipc'] = ('n/a', ratio)
            if any(x in metrics for x in line_parts):
                metric, total, ratio = line_parts[:3]
                res[metric] = (total, ratio)

with open(csv_path, 'wt') as csv_file:
    csv_writer = csv.writer(csv_file)
    csv_writer.writerow(['entry', 'tota', 'ratio'])
    for metric, vals in res.items():
        print(metric, vals)
        csv_writer.writerow([metric, *vals])

