#!/bin/bash
set -eEuo pipefail

cat runs/config*/*/out.csv | grep metric | sort | uniq | sed 's/^/run,/g' > aggregate.csv

for batch in $(ls runs); do
  batch_dir=runs/${batch}
  for run in $(ls ${batch_dir}); do
    run_dir=${batch_dir}/${run}
    cat ${run_dir}/out.csv | grep -v metric | sed "s/^/${run}-${batch},/g" >> aggregate.csv
  done
done
