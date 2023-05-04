#!/bin/bash

set -eEuo pipefail

. vars.env

ALL_TRACE_NAMES=$(find "${ALL_TRACES_DIR}" -type d -iname "*.dir" | grep drmemtrace. | awk -F . '{print $2}')
ALL_RUN_CONFIGS=$(cat <<-END
  32768  4
  4096   1
  4096   4
  4096   64
  262144 1
  262144 4
  262144 64
END
)

for TRACE_NAME in ${ALL_TRACE_NAMES}; do
  echo "${ALL_RUN_CONFIGS}" | sed "s/^/${TRACE_NAME} /"
done | parallel --colsep ' +' ./scarab_run.sh

