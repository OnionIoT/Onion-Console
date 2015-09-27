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

# function to return an array of all apps and if the app has an icon there
# 	argument 1: directory to check
AppList () {
	bExists=0

	# json setup           
	json_init              
	
	# create the directory array
	json_add_array apps
	
	#check if the directory exists
	if [ -d $1 ]
	then
		# denote that the directory exists
		bExists=1

		# go to the directory
		cd $1
		
		# grab all the directories and correct the formatting                          
		dirs=`find . -type d -maxdepth 1 -mindepth 1 | tr '\n' ';'`
		
		
		
		# split the list of directories
		rest=$dirs
		while [ "$rest" != "" ]
		do
			val=${rest%%;*}
			rest=${rest#*;}

			# find if this directory has icon.png
			icon=`find $val -name "icon.png"`

			bIcon=0
			if [ "$icon" != "" ]; then
				bIcon=1
			fi

			# format the directory name
			val=`echo $val | sed -e 's/\.\///'`

			# create and populate object for this network
			json_add_object
			json_add_string "app" "$val"
			json_add_boolean "icon.png" $bIcon
			json_close_object
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

appLocation="/www/apps"

cmdAppList="app-list"
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
				# run the app-list scan
				AppList "$appLocation"
			;;
			$cmdStatus)
				# dummy call for now
				echo '{"status":"good"}'
		;;
		esac
    ;;
esac