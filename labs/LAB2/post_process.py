import os
import sys
import csv


# Identify desired path
path = sys.argv[1]
print(path)

arg_size = len(sys.argv)
entries_list=[]

# Get passed entries
for i in range(2,arg_size):
    entries_list.append(sys.argv[i])

# Prep CSV output
csv_output = csv.writer(open('csv_output.csv', 'w'))
csv_output.writerow(['entry','total','ratio'])


files = os.listdir(path)
# Search for the listed entries
for file in files:
    if os.path.isdir(file):
        continue
    text_file = open(file,"r")
    lines = text_file.readlines()
    text_file.close()
    for line in lines:
        check = any(item in entries_list for item in line.split())
        if check is True:
            text = line.split()
            entry = text[0]
            total = text[1]
            ratio = text[2]
            csv_output.writerow([entry, total, ratio])
