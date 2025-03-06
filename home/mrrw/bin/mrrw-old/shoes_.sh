#!/bin/bash
set +v; set +x; set -e; set -u
# ~/bin/shoes.sh
# by Michael Milk (mrrw.github)
# See EOF for known issues and bugs.
cd ~

# Sources: 
[[ -a /home/$USER/bin/.sh.conf.sh ]] && . /home/$USER/bin/.sh.conf.sh 

Help()
{
	#Display Help.
	echo "USAGE:  radio [--options]; [user input]; [user input]"
  echo "        radio -prt [filename]"
	echo "        radio  (plays a radio programming block by default.)"
	echo ""
	echo "DESCRIPTION:  Limited sound recording and manipulation tool."
	echo "Command-line wrapper for sox and other audio utilities."
  echo ""
	echo "OPTIONS:"
	echo "-f	Apply various formats as defined in format.conf."
	echo "-h	Display this help."
	echo "-m	Mix all takes starting with [filename]."
	echo "-p	Play file if listed in ~/.radio/.playlist.tmp"
	echo "-r	Record [filename]."
	echo "-t	Record an additional take to mix with previous recording [filename]."
	echo "-v	Verbose mode."
	echo "-x	Trace/Debug mode."
	echo
}
# Get the options:
while getopts ":fhmprstTvx" option; do
	case $option in
		f | --format)
			filename=$2
			format    ;;
		h) # display help
			Help      ;
			exit      ;;
		m | --mix)
			mix       ;	
			exit      ;;
		p | --play | --playsong | --songplay)
			filename=$2;
			songplay  ;
			exit      ;;
		r | --record)
			filename=$2;
			record    ;
			exit      ;;
		s | --songplay | --playsong)
			songplay  ;
			exit      ;;
		t | --take)
			take      ;
			exit      ;;
		T | --Test)
			TestScript;;
		v) # verbose mode
			set -v		;;
		x) # trace mode
			set -x		;;
	  \?) # invalid option
			echo "Error: Invalid option."
			exit;;
	esac
done

###  ISSUES

#####  NOTES
