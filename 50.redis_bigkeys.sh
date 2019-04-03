#!/bin/bash

dbs=$(redis-cli info keyspace | grep -E '^db' | awk -F':' '{print $1}' | tr '[a-z]' ' ' | xargs)
bigkeys=""

for db in `echo $dbs`; do
    redis-cli --bigkeys -i 0.1 -n $db | tail -11 > /tmp/redis_bigkeys_result
    size=$(cat /tmp/redis_bigkeys_result | grep 'Biggest string' | awk '{print $(NF-1)}')
    if [[ x$bigkeys == 'x' ]]; then
        bigkeys=`printf "db%2d: %d" $db $size 2>&1`
    else
        bigkeys=`printf "$bigkeys;db%2d: %d" $db $size 2>&1`
    fi
done

echo $bigkeys | tr ';' '\n'
rm -f /tmp/redis_bigkeys_result
