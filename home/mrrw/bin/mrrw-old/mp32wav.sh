#!/bin/bash
set +v; set +x; set -e; set -u
# ~/bin/ZOOMcopy.sh
# by Michael Milk (mrrw.github)
# See EOF for known issues and bugs.
#
# The following line sources necessary variables:
. /home/$USER/bin/.sh.conf.sh 
. ~/bin/libmrrwCommands.sh
#
Help()
{
	#Display Help.
	echo "USAGE:  $script [--options]; [user input]; [user input]"
	echo "DESCRIPTION:  Copy contents of USB to .radio/audio"
	echo
	echo "OPTIONS:"
	echo "-h	Display this help."
	echo "-v	Verbose mode."
	echo "-x	Trace/Debug mode."
	echo
}
#
### List of Commands:

Exec_CONVERTfiletype() 
{ #{{{  CONVERTfiletype
	ftA=mp3 && ftB=wav
	touch .tmp 
	echo "Convert all files in this directory from $ftA to $ftB?"
	read r
if [ $r = y ] ; then
	ls -A | grep -i ".mp3" > .tmp 
	while [ -s .tmp ] ; do
		fA=$(head -n 1 .tmp) ;
		fB=$(head -n 1 .tmp | sed 's/mp3// ; s/MP3//') ;
		mpg123 -w "$fB".WAV "$fA" ;
		sed -i '1d' .tmp; 
	done ;
else
	echo "Convert all files in this directory from $ftB to $ftA?" ;
	read r
	if [ $r = y ] ; then
	ls -A | grep -i ".wav" > .tmp 
		while [ -s .tmp ] ; do
			fA=$(head -n 1 .tmp) ;
			fB=$(head -n 1 .tmp | sed 's/wav// ; s/WAV//') ;
			ffmpeg -i "$fA" -af aformat=s16:44100 "$fB.MP3" ;
			sed -i '1d' .tmp; 
		done
	fi
fi
	exit
rm .tmp

} #}}}
# Get the options:
#{{{
while getopts ":achsvx" option; do
	case $option in
		a | --copyUSB)
			ZOOMcopy
			;;
		c | --convert)
			CONVERTfiletype
			;;
		s | --sort-by-length)
			SORTlength
			;;
		h | --help) 
			Help; exit
			;;
		v | --verbose) 
			set -v
			;;
		x) 
			set -x
			;;
	  \?) 
			echo "Error: Invalid option."
			exit
			;;
	esac
done

#}}}
