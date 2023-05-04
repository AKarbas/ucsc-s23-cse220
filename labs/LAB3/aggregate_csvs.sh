#!/bin/bash
set -eEuo pipefail

cat runs/*/out.csv | grep metric | sort | uniq | sed 's/^/run,/g' > aggregate.csv

for run in $(ls runs/); do
  run_dir=runs/${run}
  cat ${run_dir}/out.csv | grep -v metric | sed "s/^/${run},/g" >> aggregate.csv
done
