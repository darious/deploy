echo "Backing up Uptime Kuma"
duplicity --no-encryption --full-if-older-than 1M --volsize 640 --allow-source-mismatch /mnt/docker/uptime-kuma/ file:///mnt/backup/kangtao/raspmonitor/duplicity/uptime-kuma/
duplicity --force --force remove-all-but-n-full 2 file:///mnt/backup/kangtao/raspmonitor/duplicity/uptime-kuma/
