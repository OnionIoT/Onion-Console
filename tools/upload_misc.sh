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

#check for a script argument to set the IP address
if [ "$1" != "" ]; then
        ipAddr="$1"
fi

echo "Omega IP: $ipAddr"


# transfer files
cmd="rsync --progress -rv ./acl.d/* root@$ipAddr:/usr/share/rpcd/acl.d"
echo "$cmd"
$cmd

cmd="rsync --progress -rv ./rpcd/onion-console.sh root@$ipAddr:/usr/libexec/rpcd/onion-console"
echo "$cmd"
$cmd

cmd="rsync --progress -rv ./bin/factory-reset.sh root@$ipAddr:/usr/sbin/factory-reset"
echo "$cmd"
$cmd

cmd="rsync --progress -rv ./bin/power-down.sh root@$ipAddr:/usr/sbin/power-down"
echo "$cmd"
$cmd

cmd="rsync --progress -rv ./bin/change-password.sh root@$ipAddr:/usr/sbin/change-password"
echo "$cmd"
$cmd

cmd="rsync --progress -rv ./bin/disk-space.sh root@$ipAddr:/usr/sbin/disk-space"
echo "$cmd"
$cmd


