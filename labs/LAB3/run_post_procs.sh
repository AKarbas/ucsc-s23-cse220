#!/bin/bash
set -eEuxo pipefail

for x in runs/*; do ./post_process.py ${x} dcache_miss dcache_miss_compulsory dcache_miss_capacity dcache_miss_conflict ipc; done
