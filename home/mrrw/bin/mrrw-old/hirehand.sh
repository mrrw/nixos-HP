#!/bin/bash
set +v; set +x; set -e; set -u
# ~/bin/hirehand.sh
# by Michael Milk (mrrw.github)
# See EOF for known issues and bugs.
#
###  SOURCES
. $HOME/bin/.sh.conf.sh 
. $HOME/bin/libmrrwCommands.sh
###  VARIABLES
log=$HOME/var/log/hirehand.log

#
Help()
{
	#Display Help.
	echo "USAGE:  hirehand [--options]; [user input]; [user input]"
	echo "DESCRIPTION:  Populate templates for cover letters and resumes."
	echo
	echo "OPTIONS:"
	echo "-h	Display this help and exit."
	echo "-l	Display log and exit."
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
#

Exec_HIREHAND()
{ #{{{
mainDIR=$HOME/hirehand
[ ! -d $mainDIR ] && mkdir -p $mainDIR
echo "What's the name of the company?"
read c
echo "What's the name of the position?"
read p
mkdir -p $mainDIR/$c
echo "Now, write a sentence or two describing why you're chosing this company."
read d
PS3="Choose a file to populate:  "
select t in $(ls -A $mainDIR | grep .template) ; do
	f=$(echo $p-$t | sed 's/template/txt/ ; s/\.// ; s/\ //g')
	cat $mainDIR/$t | sed "s/\$c/$c/ ; s/\$d/$d/ ; s/\$p/$p/" > $mainDIR/$c/$f
	echo "created $mainDIR/$c/$f"
done

} #}}}
