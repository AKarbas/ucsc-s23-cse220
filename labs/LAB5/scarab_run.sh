#!/bin/bash
set -eEuxo pipefail

. vars.env

TRACE_NAME=$1
TRACE_CONFIG_NAME=$2
TRACE_DIR=$(find "${ALL_TRACES_DIR}" -type d -iname "*${TRACE_NAME}*.dir")
TRACE_FILE=$(find "${TRACE_DIR}" -type f -iname "*${TRACE_NAME}*.trace*")
TRACE_RAW_DIR=${TRACE_DIR}/raw
RUN_DIR="$(pwd)/runs/${TRACE_NAME}-${TRACE_CONFIG_NAME}"

EXTRA_ARGS=""
EXTRA_ARGS="${EXTRA_ARGS} --fetch_off_path_ops=0"
EXTRA_ARGS="${EXTRA_ARGS} --inst_limit=10000000" # 10M
EXTRA_ARGS="${EXTRA_ARGS} ${@:3}"

START_DIR=$(pwd)
mkdir -p "${RUN_DIR}"
cp "${DEFAULT_PARAMS_IN}" "${RUN_DIR}/PARAMS.in"
cd "${RUN_DIR}"

# Run:
${SCARAB_DIR}/src/scarab \
  --frontend memtrace \
  --cbp_trace_r0=${TRACE_FILE} \
  --memtrace_modules_log=${TRACE_RAW_DIR} \
  ${EXTRA_ARGS} >run.out 2>run.err

cd "${START_DIR}"
