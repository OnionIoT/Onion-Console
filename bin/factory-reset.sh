#!/bin/sh

### calling this will perform a factory reset
### only if called with -f option

bReset=0
bUsage=1

# function to print usage
Usage () {
	echo "Functionality:"
	echo "	DANGER!"
	echo "	Restore filesystem to factory settings"
	echo "	DANGER!"
	echo " 	This will delete all custom data from device"
	echo ""
	echo "Usage:"
	echo "$0 -f"
	echo "	Performs factory reset"
	echo ""
}

# function to perform the factory reset
FactoryReset () {
	echo "Resetting to factory settings..."
	echo "Goodbye, farewell, see you soon!"
	sleep 1

	killall dropbear uhttpd
	sleep 1

	mtd -r erase rootfs_data
}


########################
##### Main Program #####

# accept arguments
while [ "$1" != "" ]
do
	case "$1" in
    	-h|-help|--help|help)
			bUsage=1
			shift
		;;
		-f|-force|--force)
			bUsage=0
			bReset=1
			shift
		;;
		*)
			echo "ERROR: Invalid Argument: $1"
			echo ""
			bUsage=1
			shift
		;;
	esac
done

if [ $bUsage == 1 ]; then
	Usage
	exit
fi

if [ $bReset == 1 ]; then
	FactoryReset
fi

