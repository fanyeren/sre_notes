#!/bin/bash

tcpflow -S enable_report=NO -c -p -i any dst port 6379 | tr -d '\r' | tee /tmp/redis_hotkeys_result >/dev/null
