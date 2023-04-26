#!/bin/bash
set -eEuxo pipefail

for x in runs/config*/*; do ./post_process.py ${x} BP_ON_PATH_MISPREDICT OP_ISSUED IPC; done
