#!/bin/bash
set +v; set +x; set -e; set -u
# /home/mrrw/bin/wikiscraper.sh
# by Michael Milk (mrrw.github)
# See EOF for known issues and bugs.
#
# Required sources:
. $HOME/bin/.sh.conf.sh 
. $HOME/bin/libmrrwCommands.sh
#
#
Help()
{
	#Display Help.
	echo "USAGE:  $script [--options]; [user input]; [user input]"
	echo "DESCRIPTION:  Slowly feed species names into sgpt, asking about edibility."
	echo "Local lists can be found in [ ~/foodfinder ]."
	echo
	echo "OPTIONS:"
	echo "-h	Display this help and exit."
	echo "-l  View log and exit."
	echo "-v	Verbose mode."
	echo "-x	Trace/Debug mode."
	echo
}
#{{{
# Get the options:
while getopts ":hlvx" option; do
	case $option in
		h | --help) 
			Help; exit
			;;
		l | --log) 
			less $log; exit
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
###  MAIN PROGRAM EXECUTION
Exec_FOODFINDER()
{ #{{{  Exec_FOODFINDER
  #
# Set some variables:
FileLog=$HOME/var/foodfinder.log
FileQuestions=$HOME/foodfinder/.questionlist.txt
DIRmain=$HOME/lib/foodfinder
DIRlist=$HOME/lib/foodfinder/.locallist
main=$DIRmain
list=$DIRlist
log=$FileLog
qfile=$FileQuestions
n=0 
PS3="Select the file containing the species you want to identify:  "
w="www.wikipedia.org/wiki"
[ ! -d $main ] && mkdir $main && echo "$main/ does not exist; making." >> $log
[ ! -d $list ] && mkdir $list && echo "$list/ does not exist; making." >> $log
cd $list
[ -s $(ls | grep .txt) ] && echo "No species list found in $list" && exit
# User chooses source file.
select f in $(ls -p | grep -v /) ; do
		ft="$list/.$f.tmp"
		s=$(head -n 1 $f)
	[ ! -s $ft ] && cat $f > .$f.tmp && echo "creating $ft from $list/$f" >> $log
	subdir=$(echo "$main/$f" | sed 's/\.[^.]*$//')
		[ ! -d $subdir ] && mkdir $subdir
	cd $subdir
	while read s ; do
		x=$(echo $s | sed 's/.*/\u&/;s/ /_/g')
		# Here, we ask sgpt questions about edibility and all that.  tee to log!
		# After questions, scrape wikipedia entry.
		# We'll also want to capture and store images somewhere somehow...
		w3m "$w/$x" |sed -n '/Species/,$p' | sed -n '/Retrieved\ from/,$!p'> "$x.txt" ;
		echo "scraped $w/$x" | tee -a $log
	done < "$ft"
done

} #}}}
