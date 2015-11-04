#!/bin/sh

### calling this will shutdown the Omega
### only if called with -f option

bShutdown=0
bUsage=1

# function to print usage
Usage () {
	echo "Functionality:"
	echo "	Shutdown the system"
	echo ""
	echo "Usage:"
	echo "$0 -f"
	echo "	Performs shut down sequence"
	echo ""
}

# function to perform the factory reset
ShutDownSequence () {
	echo "Shutting down..."
	echo "See you later!"
	sleep 1

	# turn off the Omega's LED
	fast-gpio set 27 1 >& /dev/null

	# perform the shutdown
	poweroff -d 5
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
			bShutdown=1
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

if [ $bShutdown == 1 ]; then
	ShutDownSequence
fi

