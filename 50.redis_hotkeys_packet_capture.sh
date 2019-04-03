#!/bin/bash

# 这是个简单的例子，只找最大的热度，生产环境最好算一下 P95 P99 热度，这样好过滤掉偶发的热点。
# 还要考虑业务高峰期和低谷期。

nohup bash -c "tcpflow -S enable_report=NO -c -p -i any dst port 6379 | tr -d '\r' | tee /tmp/redis_hotkeys_result >/dev/null" >/dev/null 2>&1 &
pid=$!

sleep 60

kill -HUP $pid

hot=$(perl -e 'open (my $in, "<", "/tmp/redis_hotkeys_result") or die $!; my @arr; my $new=0; my $result; while (my $line = <$in>) { chomp $line; if ($line eq "") { $new=1; $result=$arr[4] if $arr[4]; @arr=() } else { push @arr, $line;}; print $result, "\n" if $new && $result; $new=0}' | sort | grep -v ACK | uniq -c | sort -rn | head -1)

echo "$hot"

rm -f /tmp/redis_hotkeys_result
