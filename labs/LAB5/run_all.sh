#!/bin/bash

set -eEuo pipefail

. vars.env

ALL_TRACE_NAMES=$(find "${ALL_TRACES_DIR}" -type d -iname "*.dir" | grep drmemtrace. | awk -F . '{print $2}')
ALL_RUN_CONFIGS=$(cat <<-END
  0
  1
END
)

for TRACE_NAME in ${ALL_TRACE_NAMES}; do
  echo "${ALL_RUN_CONFIGS}" | sed "s/^/${TRACE_NAME} /"
done | parallel --colsep ' +' ./scarab_run.sh

