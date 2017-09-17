#!/bin/sh

### change the password of the specified user

bUsage=1

# function to print usage
Usage () {
	echo "Functionality:"
	echo "	Change the password"
	echo ""
	echo "Usage:"
	echo "$0 -user <username> -password <new password> -verify <new password>"
	echo ""
}

# function to perform password change
#	arg1	- username
#	arg2	- new password
# 	arg3	- verify new password
ChangePassword () {
	# check to ensure password is the same as the verify password
	if [ "$2" == "$3" ]
	then
		# passwords match, perform the password change
                echo -e "$2\n$3" | (passwd $1)
	else
		# do not perform password change
		echo "New passwords don't match!!"
	fi
}


########################
##### Main Program #####

inputUser=""
inputPassword=""
inputVerify=""

# accept arguments
while [ "$1" != "" ]
do
	case "$1" in
    	-h|-help|--help|help)
			bUsage=1
			shift
		;;
		-u|-user|--user)
			bUsage=0
			shift
			inputUser=$1
			shift
		;;
		-p|-password|--password)
			bUsage=0
			shift
			inputPassword=$1
			shift
		;;
		-v|-verify|--verify)
			bUsage=0
			shift
			inputVerify=$1
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

if 	[ "$inputUser" != "" ] &&
	[ "$inputPassword" != "" ] &&
	[ "$inputVerify" != "" ]; 
then
	ChangePassword "$inputUser" "$inputPassword" "$inputVerify"
fi

