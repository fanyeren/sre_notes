#!/bin/bash

cc=$(grep -c processor /proc/cpuinfo)
uptime=$(cat /proc/uptime | awk '{print $1}')
idletime=$(cat /proc/uptime | awk '{print $2}')
idle=$(echo $cc $uptime $idletime | perl -ne '{my @input = split(/\s+/, $_); my $idle = $input[2] / ($input[0] * $input[1]); print $idle, "\n";}')
idle=$(printf "%.04s" $idle)

echo -e "\t\t\t\t\t\e[1;31m开机以来空闲率：$idle\e[0m\n"
echo

echo -e "\t\t\t\t\t\e[1;31m登录情况\e[0m\n"
last -n 6
echo -e "\n\t\t\t\t\t\e[1;31mcpu负载情况\e[0m\n"
uptime
echo -e "\n\t\t\t\t\t\e[1;31m磁盘利用情况\e[0m\n"
df -l -h | grep -v -E '^tmpfs'
echo -e "\n\t\t\t\t\t\e[1;31m内存利用情况\e[0m\n"
free -m

echo -e "\n"
echo -e "\t\t\t\t\t\e[1;31m僵尸进程\e[0m\n"
ps ajxf | perl -ne 'my @arr=split(" "); print if $arr [6] =~ m/[zZ].*/'
