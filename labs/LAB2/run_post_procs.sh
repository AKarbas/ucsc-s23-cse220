#!/bin/bash
set -eEuxo pipefail

for x in runs/config*/*; do ./post_process.py ${x} bp_on_path_mispredict icache_miss dcache_miss ipc; done
