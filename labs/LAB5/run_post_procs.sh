#!/bin/bash
set -eEuxo pipefail

for x in runs/*;
do
	./post_process.py ${x} \
		dcache_miss \
		dcache_miss \
		dcache_miss_capacity \
		dcache_miss_compulsory \
		dcache_miss_conflict \
		ipc \
		l1_hit \
		l1_miss \
		pref_sms_window_1 \
		pref_sms_window_1 \
		pref_sms_window_16 \
		pref_sms_window_2 \
		pref_sms_window_24 \
		pref_sms_window_32 \
		pref_sms_window_4 \
		pref_sms_window_64 \
		pref_sms_window_8 \
		pref_sms_window_wtf \
		pref_unused_evict
done
