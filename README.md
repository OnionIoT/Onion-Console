# Onion-Console
Web application for accessing Onion devices

## Setup on Omega
Follow the table below for information on setting up the Console on an Omega

| Repo File                | Location on Omega                        |
|--------------------------|------------------------------------------|
| www/*                    | /www/.                                   |
| acl.d/onion-console.json | /usr/share/rpcd/acl.d/onion-console.json |
| rpcd/onion-console.sh    | /usr/libexec/rpcd/onion-console          |
| bin/factory-reset.sh     | /usr/sbin/factory-reset                  |
| bin/power-down.sh        | /usr/sbin/power-down                     |
| bin/change-password.sh   | /usr/sbin/change-password                |
| bin/disk-space.sh        | /usr/sbin/disk-space                     |

Run `/etc/init.d/rpcd restart` after copying rows 2 and 3


## onion-console ubus Service
The onion-console ubus service implements any functionality the console needs to communicate with the Omega hardware or filesystem

### app-list
##### Functionality
Identifies all console apps installed in the /www/apps directory.

##### Usage
Takes no arguments

##### Return Data
Returns an array of all installed console apps, information includes everything in the app.json file of each app
```
{
	"apps": [
		{
			"id": "onion-editor",
			"name": "Editor",
			"icon": true
		},
		.....
		{
			"id": "onion-terminal",
			"name": "Terminal",
			"icon": true
		}
	],
	"exists": true
}
```

### shellinabox
##### Functionality
Allows for control of the shellinabox daemon through ubus

##### Usage
Takes argument in following format `{"params":{"key":"value"}}`

Possible Keys:
* start
  * This will start the shellinabox daemon
  * Value should be null string, ""
* check
  * This will check for running shellinabox daemon
  * Return will be in following format `
{
        "pids": "1211 1213 ",
        "running": 2
}
`
  * Value should be null string, ""
* stop
  * This will stop any running shellinabox daemon
  * Value should be null string, ""
* restart
  * This will restart the shellinabox daemon
  * Value should be null string, ""


### wifi-info
#### Functionality
Returns all wifi network data for a specified network type (access-point or client mode)

#### Usage
Takes argument in following format `{"params":{"key":"value"}}`

Possible Keys:
* type
  * should be either sta or ap

#### Return Value
Returns a json object with the following keys:
* ssid
* encryption
* password

#Copyright and License
Code and documentation copyright 2014-2015 Onion Corporation. 
Code released under the GNU Public License Version 3. Documentation is released under Creative Commons.
