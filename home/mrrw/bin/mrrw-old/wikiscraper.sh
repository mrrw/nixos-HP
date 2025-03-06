#!/bin/bash
set +v; set +x; set -e; set -u
# /home/mrrw/bin/wikiscraper.sh
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
	echo "DESCRIPTION:  Scrape info from wikipedia.org/wiki using local lists. "
	echo "Local lists can be found in [ ~/.wikiscraper ]."
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
n=0 
maindir=/home/$USER/wikifiles/

###  MAIN PROGRAM EXECUTION

Exec_WIKISCRAPER
{ #{{{
[ ! -d $maindir ] && mkdir $maindir
w="www.wikipedia.org/wiki"
for file in $(ls /home/$USER/.wikiscraper/) ; do
	n=0
	subdir=$(echo "$file" | sed 's/\.[^.]*$//')
	cd $maindir
	[ ! -d $subdir ] && mkdir $subdir
	cd $subdir
	while read s ; do
		n=$(expr $n + 1) ;
		x=$(echo $s | sed 's/.*/\u&/;s/ /_/')
		w3m "$w/$x" |sed -n '/Species/,$p' | sed -n '/Retrieved\ from/,$!p'> "$x.txt" ;
		echo "created ~/wikifiles/$(echo "$file" | sed 's/\.[^.]*$//')/$x.txt" | tee -a ~/wikiscraper.log
	done < "/home/$USER/.wikiscraper/$file"
done

} #}}}
###  ISSUES AND BUGS
#
# To-Do:
