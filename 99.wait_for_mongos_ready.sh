LW_MONGO_PORT=20000

ln -s /lib/systemd/system/mongos.service /etc/systemd/system/multi-user.target.wants/mongos.service
systemctl daemon-reload >/dev/null 2>&1
systemctl start mongos

while true; do
    grep "waiting for connections on port ${LW_MONGO_PORT}" /home/admin/logs/mongodb/mongos.log && break
    sleep 2
done
