#!/bin/sh

. /usr/share/libubox/jshn.sh

bLogEnabled=0
logFile="/tmp/$logName"

# function to setup logging
SetupLog () {
	if [ $bLogEnabled == 1 ]; then
		if [ -f $logFile ]; then
			rm -rf $logFile
		fi

		touch $logFile
	fi
}

# function to perform logging
#	argument 1: message to be logged
Log () {
	if [ $bLogEnabled == 1 ]; then
		echo "$1" >> $logFile
	fi
}


# function to parse json params object
# returns a string via echo
_ParseArgumentsObject () {
	local retArgumentString=""

	# select the arguments object
	json_select params
	
	# read through all the arguments
	json_get_keys keys

	for key in $keys
	do
		# get the key value
		json_get_var val "$key"
		
		# specific key modifications
		if 	[ "$key" == "ssid" ] ||
			[ "$key" == "password" ];
		then
			# add double quotes around ssid and password
			val="\"$val\""
		fi

		retArgumentString="$retArgumentString-$key $val "
	done

	echo "$retArgumentString"
}

# function to return an array of all directories
# 	argument 1: directory to check
DirList () {
	bExists=0

	# json setup           
	json_init              
	
	# create the directory array
	json_add_array directories
	
	#check if the directory exists
	if [ -d $1 ]
	then
		# denote that the directory exists
		bExists=1

		# go to the directory
		cd $1
		
		# grab all the directories and correct the formatting                          
		dirs=`find . -type d -maxdepth 1 -mindepth 1 | sed -e 's/\.\///' | tr '\n' ';'`
		
		
		
		# split the list of directories
		rest=$dirs
		while [ "$rest" != "" ]
		do
			val=${rest%%;*}
			rest=${rest#*;}

			# val now holds a directory
			json_add_string "dir" "$val"
		done	
	fi

	# finish the array
	json_close_array
	
	# add the note that the directory exists
	json_add_boolean exists $bExists

	# print the json
	json_dump
}


########################
##### Main Program #####

cmdAppList="dir-list"
cmdStatus="status"

jsonAppList='"'"$cmdAppList"'": { }'
jsonStatus='"'"$cmdStatus"'": { }'

case "$1" in
    list)
		echo "{ $jsonAppList, $jsonStatus }"
    ;;
    call)
		Log "Function: call, Method: $2"

		case "$2" in
			$cmdAppList)
				# set the location to check for directories
				appLocation="/www/apps"

				# run the wifi scan
				DirList "$appLocation"
			;;
			$cmdStatus)
				# dummy call for now
				echo '{"status":"good"}'
		;;
		esac
    ;;
esac