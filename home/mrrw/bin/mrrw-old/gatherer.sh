#!/bin/bash
set +v; set +x; set -e; set -u
# /home/mrrw/bin/gatherer.sh
# by Michael Milk (mrrw.github)
# See EOF for known issues and bugs.
#
# Required sources:
. /home/$USER/bin/.sh.conf.sh 
. /home/$USER/bin/libmrrwCommands.sh
#
Help()
{
	#Display Help.
	echo "USAGE:  $script [--options]; [user input]; [user input]"
	echo "DESCRIPTION:  Combine files with same keywords in name string into one file. "
	echo
	echo "OPTIONS:"
	echo "-h	Display this help."
	echo "-v	Verbose mode."
	echo "-x	Trace/Debug mode."
	echo
}
#{{{
# Get the options:
while getopts ":hvx" option; do
	case $option in
		h | --help) 
			Help; exit
			;;
		v | --verbose) 
			set -v
			shift
			;;
		x) 
			set -x
			shift
			;;
	  \?) 
			echo "Error: Invalid option."
			exit
			;;
	esac
done
#}}}
# Set some variables:

###  MAIN PROGRAM EXECUTION
#

Exec_GATHERERS()
{ #{{{
  #
dir1="/home/$USER/foodfinder/"
dir2="/home/$USER/wikifiles/"
dir3="/home/$USER/foodfound/"
dir4="/home/$USER/foodfound/yes/"
dir5="/home/$USER/foodfound/unknown/"
[ ! -d $dir3 ] && mkdir $dir3
[ ! -d $dir4 ] && mkdir $dir4
[ ! -d $dir5 ] && mkdir $dir5
for name in $(ls $dir1) ; do
	size=$(ls -l $dir1 | grep $name | awk '{print $5}' | head -c 2)
		cat $dir1$name > $dir3$name && echo $dir1$name
		cat $(tree -if $dir2| grep $name) >> $dir3$name
#	if [ $size == 14 ] ; then
#		cat $dir1$name > $dir4$name && echo $dir1$name
#		cat $(tree -if $dir2| grep $name) >> $dir4$name
#	else
#		cat $dir1$name > $dir5$name && echo $dir1$name
#		cat $(tree -if $dir2| grep $name) >> $dir5$name
#	fi	 
done

} #}}}

###  ISSUES AND BUGS
#
# To-Do:
