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
rm -rf dist
mkdir dist
cp -r www/elements www/apps www/fonts www/images www/index.html www/lib www/services dist
rm -rf dist/lib/juicy-ace-editor

find dist -name "*bower*" -exec rm -rf {} \; 2>/dev/null
find dist -name "demo" -exec rm -rf {} \; 2>/dev/null
find dist -name "test" -exec rm -rf {} \; 2>/dev/null
find dist -name "*.md" -exec rm -rf {} \; 2>/dev/null
find dist -name "LICENSE*" -exec rm -rf {} \; 2>/dev/null
find dist -name "COPYING*" -exec rm -rf {} \; 2>/dev/null
find dist -name "package.json" -exec rm -rf {} \; 2>/dev/null
find dist -name ".git*" -exec rm -rf {} \; 2>/dev/null
find dist -name ".DS_Store" -exec rm -rf {} \; 2>/dev/null

rsync --progress --del -crv ./dist/* root@$ipAddr:/www/console

rm -rf dist
