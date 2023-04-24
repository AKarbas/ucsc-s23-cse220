#!/bin/bash
set -eEuxo pipefail

SCARAB_DIR=/home/estebanramos/projects/scarab
DEFAULT_PARAMS_IN=${SCARAB_DIR}/src/PARAMS.kaby_lake

TRACE_NAME=$1;
echo "Trace Name: $TRACE_NAME";
TRACE_FILE=$2;
echo "Trace File: $TRACE_FILE";
TRACE_RAW_DIR=$3
echo "Trace Raw Dir: $TRACE_RAW_DIR"
RUN_DIR="$(pwd)/runs/${TRACE_NAME}"
echo "Run Directory: $RUN_DIR";

EXTRA_ARGS="" # --decode_cycles 10 --map_cycles 10

mkdir -p "${RUN_DIR}"
cp "${DEFAULT_PARAMS_IN}" "${RUN_DIR}/PARAMS.in"
START_DIR=$(pwd)
cd "${RUN_DIR}"

# Run:
${SCARAB_DIR}/src/scarab \
  --frontend memtrace \
  --cbp_trace_r0=${TRACE_FILE} \
  --memtrace_modules_log=${TRACE_RAW_DIR} \
  ${EXTRA_ARGS}

cd "${START_DIR}"
