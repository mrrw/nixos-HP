#!/bin/bash
set +v; set +x; set -e; set -u
# ~/bin/appTimer.sh
# by Michael Milk (mrrw.github)
# See EOF for known issues and bugs.

# The following line sources necessary variables:
. /home/$USER/bin/.sh.conf.sh 
#touch radio.tmp
#list=$(cat radio.tmp)

Help()
{
	#Display Help.
	echo "USAGE:  $script [--options]; [user input]; [user input]"
	echo "DESCRIPTION:  Use sox and shuf to play music."
	echo
	echo "OPTIONS:"
	echo "-h	Display this help."
	echo "-v	Verbose mode."
	echo "-x	Trace/Debug mode."
	echo
}
# Get the options:
while getopts ":chvx" option; do
	case $option in
		h) # display help
			Help
			exit;;
		v) # verbose mode
			set -v;;
		x) # trace mode
			set -x;;
	  \?) # invalid option
			echo "Error: Invalid option."
			exit;;
	esac
done

# Assign some variables:
t=5

func=
{
	echo -en "cool!"
}
###  BEGIN PROGRAM EXECUTION

runtime="$t minute"
endtime=$(date -ud "$runtime" +%s)
while [[ $(date -u +%s) -le $endtime ]]
do
	sleep 1;
done

# Source gitPush by mrrw:
#. /home/$USER/bin/gitPush.sh

###  BEGIN ISSUES

#####  END ISSUES
#!/bin/bash
#
# echo's "OK" for awhile.



