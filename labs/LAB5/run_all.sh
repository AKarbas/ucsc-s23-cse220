#!/bin/bash

set -eEuo pipefail

. vars.env

ALL_TRACE_NAMES=$(find "${ALL_TRACES_DIR}" -type d -iname "*.dir" | grep drmemtrace. | awk -F . '{print $2}')
ALL_RUN_CONFIGS=$(cat <<-END
  default --pref_sms_pht_size=2048 --pref_sms_on=0
  none    --pref_sms_pht_size=2048 --pref_ghb_on=0 --pref_stream_on=0 --pref_stride_on=0 --pref_stridepc_on=0 --pref_phase_on=0 --pref_2dc_on=0 --pref_markov_on=0 --pref_sms_on=0
  ghb     --pref_sms_pht_size=2048 --pref_ghb_on=1 --pref_stream_on=0 --pref_stride_on=0 --pref_stridepc_on=0 --pref_phase_on=0 --pref_2dc_on=0 --pref_markov_on=0 --pref_sms_on=0
  sms     --pref_sms_pht_size=2048 --pref_ghb_on=0 --pref_stream_on=0 --pref_stride_on=0 --pref_stridepc_on=0 --pref_phase_on=0 --pref_2dc_on=0 --pref_markov_on=0 --pref_sms_on=1
END
)

for TRACE_NAME in ${ALL_TRACE_NAMES}; do
  echo "${ALL_RUN_CONFIGS}" | sed "s/^/${TRACE_NAME} /"
done | parallel --colsep ' +' ./scarab_run.sh

