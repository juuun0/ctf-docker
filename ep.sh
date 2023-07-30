#!/bin/bash

echo "[!] Container is started... Setting up xinetd"
/etc/init.d/xinetd restart 1>/dev/null

echo "[!] If challenge session is connected, gdbserver is run automatically..."
while [[ 1 ]]; do
	PID=$(pidof /root/chall.bin 2>/dev/null)
	if [[ -n $PID ]]; then
		gdbserver 0.0.0.0:929 --attach $PID 2>/dev/null
	fi
done
