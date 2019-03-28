#!/bin/bash
# 原版来自 叶金荣 叶大师，这里做了一些修改。

echo
echo "Welcome to MySQL Server, make sure all of the check result is OK"
echo

. ~/.bash_profile
# 1. check who is login
echo "#1# check who is login"
w
echo
echo

# 2. check system's load and other info.
echo "#2# check disk free"
df -l -hT | grep -v 'Filesystem.*Type.*Size' | sort -rn -k 6 | head -3
echo
echo

echo "#3# check memory and swap"
echo "show memory & swap usage, check if memory leaks"
free -h
echo
echo

# 3. check which process's load is high
echo "#4# check which process's load is high"
ps -eo pid,pcpu,size,rss,cmd | head -1
ps -eo pid,pcpu,size,rss,cmd | sort -rn -k 2 | head -5 | grep -iv 'PID.*CPU.*SIZE' | grep -E -v 'head -5|sort -rn -k 2'
echo
echo

# 4. check mysql status
echo "#5# check MySQL status"
/home/admin/server/mysql/bin/mysqladmin --login-path=root3306 pr 2>/dev/null | grep -E -v 'Sleep|\-\-\-\-\-|\| Id    \|' | sort -rn -k 12 | head -5
/home/admin/server/mysql/bin/mysqladmin --login-path=root pr 2>/dev/null | grep -E -v 'Sleep|\-\-\-\-\-|\| Id    \|' | sort -rn -k 12 | head -5
