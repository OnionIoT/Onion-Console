#!/bin/sh

### find the disk space used, available, and total


# function to check a specific filesystem
#	arg1	- the mount point
CheckMountPoint () {
	local df=$(df $1 | grep -v Filesystem)
	local dfReduced=$(echo "$df" | sed -e 's/^[[:graph:]]*[[:space:]]*[[:graph:]]*[[:space:]]*//' -e 's/[[:graph:]]*%.*$//')

	echo "$dfReduced"
}

# function to find used space 
#	arg1	- the mount point data from CheckMountPoint
FindUsedSpace () {
	local dfUsed=$(echo "$1" | sed -e 's/[[:space:]].*$//')

	echo "$dfUsed"
}

# function to find free space 
#	arg1	- the mount point data from CheckMountPoint
FindFreeSpace () {
	local dfFree=$(echo "$1" | sed -e 's/^[[:graph:]]*[[:space:]]*//')

	echo "$dfFree"
}


########################
##### Main Program #####

# find free and used space on / mount point
mount0="/"
disk0=$(CheckMountPoint "$mount0")
disk0Free=$(FindFreeSpace "$disk0")
disk0Used=$(FindUsedSpace "$disk0")

# find free and used space on /rom mount point
mount1="/rom"
disk1=$(CheckMountPoint "$mount1")
disk1Free=$(FindFreeSpace "$disk1")
disk1Used=$(FindUsedSpace "$disk1")

# find the total numbers
free=$(($disk0Free + $disk1Free))
used=$(($disk0Used + $disk1Used))

total=$(($free + $used))

echo "free:$free, used:$used, total:$total"
