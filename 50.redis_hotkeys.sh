#!/bin/bash

# 这是个简单的例子，只找最大的热度，生产环境最好算一下 P95 P99 热度，这样好过滤掉偶发的热点。
# 还要考虑业务高峰期和低谷期。

nohup redis-cli monitor >/tmp/monitor 2>&1 &
pid=$!

sleep 10

kill -HUP $pid

hot=$(cat /tmp/monitor | awk '{print $5}' | sed 's/"//g' | grep -E '[a-z]' | sort | uniq -c | sort -rn | head -1)

echo "$hot"
