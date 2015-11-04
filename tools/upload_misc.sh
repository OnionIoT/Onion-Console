#!/bin/bash

#default IP address of Omega
ipAddr="192.168.3.1"

#check for a config file that defines another IP Address
file="config.ini"
param="ipAddr"

cd `dirname $0`
if [ -f "$file" ]; then
	ipAddr=`cat $file | grep -v "^#" | grep -v "^$" | grep "^$param" | sed -e 's/.*=//'`
fi
cd -
echo "Omega IP: $ipAddr"


# transfer files
rsync --progress -rv ./acl.d/* root@$ipAddr:/usr/share/rpcd/acl.d
rsync --progress -rv ./rpcd/onion-console.sh root@$ipAddr:/usr/libexec/rpcd/onion-console
rsync --progress -rv ./bin/factory-reset.sh root@$ipAddr:/usr/sbin/factory-reset
rsync --progress -rv ./bin/power-down.sh root@$ipAddr:/usr/sbin/power-down
rsync --progress -rv ./bin/change-password.sh root@$ipAddr:/usr/sbin/change-password

