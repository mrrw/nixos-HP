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
CONVERTfiletype() 
{ #{{{  CONVERTfiletype
	ftA=mp3 && ftB=wav
	touch .tmp 
	echo "Convert all files in this directory from $ftA to $ftB?"
	read ur
if [ $ur = y ] ; then
	ls -A | grep -i ".mp3" > .tmp 
	while [ -s .tmp ] ; do
		fA=$(head -n 1 .tmp) ;
		fB=$(head -n 1 .tmp | sed 's/mp3// ; s/MP3//') ;
		mpg123 -w "$fB".WAV "$fA" ;
		sed -i '1d' .tmp; 
	done ;
else
	echo "Convert all files in this directory from $ftB to $ftA?" ;
	read ur
	if [ $ur = y ] ; then
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
fi
rm .tmp

	} #}}}
SORTlength()
{ #{{{  SORTlength
touch ~/b.tmp
ls > ~/b.tmp && ls -d */ >> ~/b.tmp 
cat ~/b.tmp | sort | uniq -u > ~/.tmp
rm ~/b.tmp
while [[ -s ~/.tmp ]]; do
	f=$(head -n 1 ~/.tmp) ;
	T=$(soxi -D $f)
	if [ $T <= 31 ] ; then
		cp -r $f .30/$f
	elif [ $T >= 90 ] ; then
		cp -r $f .90/$f ; 
	else
		cp -r $f .60/$f ; 
	fi
	sed -i '1d' ~/.tmp
	echo "$f sorted."
done
} #}}}
ZOOMcopy()
{ #{{{  COPYfiles

sudo mount /dev/sdb1 ~/mnt/USB
cd ~/mnt/USB/STEREO/FOLDER01
ls > ~/.tmp
while [[ -s ~/.tmp ]]; do
	f=$(head -n 1 ~/.tmp) ;
	F=$(head -n 1 ~/.tmp | sed "s/ZOOM/$T/") ;
	cp -p "$f" "$d$F" ;
	sed -i '1d' ~/.tmp
	echo "$d$F copied."
done
sudo umount /dev/sdb1
ADMINcd
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
# Set some variables:
###  MAIN PROGRAM EXECUTION
d=~/Audio/ZOOM/ && ADMINcdForce
T=$(date +%m%d)

### EXPERIMENTAL CODE
# Source gitPush by mrrw:
#. /home/$USER/bin/gitPush.sh

###  ISSUES AND BUGS
# To-Do:
#
