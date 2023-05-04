#!/bin/bash
set -eEuxo pipefail

for x in runs/*/*; do ./post_process.py ${x} dcache_miss ipc; done
