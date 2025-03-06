#!/bin/bash
set +v; set +x; set -e; set -u
# ~/bin/.testRadio.sh
# by Michael Milk (mrrw.github)
# See EOF for known issues and bugs.

# Sources: 
. /home/$USER/bin/.sh.conf.sh 
. /home/$USER/.radio/alarm.conf
. /home/$USER/.radio/music.conf
. /home/$USER/.radio/timer.conf

Help()
{
	#Display Help.
	echo "USAGE:  $script [--options]; [user input]; [user input]"
	echo "DESCRIPTION:  Create and run custom radio programs"
	echo "							using sox, crontab, and bash."
	echo "OPTIONS:"
	echo "-c  Check for music files recursively in ~."
	echo "-h	Display this help."
	echo "-v	Verbose mode."
	echo "-x	Trace/Debug mode."
	echo
}
# Get the options:
while getopts ":chvx --morn1" option; do
	case $option in
		c) # check for .mp3 files in all of home, shuffle and create a list:
			tree -if ~ | grep .mp3 | shuf > ~/.radio/.playlist.tmp;;
		h) # display help
			Help
			exit;;
		v) # verbose mode
			set -v;;
		x) # trace mode
			set -x;;
		--morn1)
			radio=morn1
			;;
	  \?) # invalid option
			echo "Error: Invalid option."
			exit;;
	esac
done

# Assign some variables:

# The following are now controlled in ~/.radio/*.conf:
t=$radiotimer			#Program runtime, in minutes; source is timer.conf
#search=		#Search string, if any
#ext=.mp3	#Search extension, default is .mp3

###  BEGIN PROGRAM EXECUTION
# Uncomment to allow:
#	CTR-C will kill the program, and trapping it will do the tasks
#	in quotes.
#trap "rm .playlist.tmp; exit" SIGINT

# Enter the directory
[[ ! -d ~/.radio ]] && mkdir ~/.radio
cd ~/.radio

# gather all music into one list 
touch .masterlist.tmp
tree -if ~| grep "$search""$ext" >> .masterlist.tmp
#rm masterlist.music


# Sort masterlist into playlists:
listARGS=*.list
while [[ -s .masterlist.tmp ]]
do
	while [[ ! -s $listARGS ]]
	do
		listhead=$(head -n 1 .masterlist.tmp);
		grep "$listhead" music.conf >> .slavelist.tmp;	
		#sed '' .masterlist.tmp | grep "$listPlay" | shuf >> .playlist.tmp
		#echo -n '*/' >> "$listM" && basename "$listhead" >> "$listM";
	done
	sed -i '1d' .masterlist.tmp;
done
rm .masterlist.tmp


while [[ -s .slavelist.tmp ]]
do
	listhead=$(head -n 1 .slavelist.tmp);
	grep "$listhead" "$station".station >> "$station".tmp
	sed -i '1d' .slavelist.tmp;
done
rm .slavelist.tmp




# Play some music:
runtime="$t minute"
endtime=$(date -ud "$runtime" +%s)
while [[ $(date -u +%s) -le $endtime ]]
do
	listhead=$(head -n 1 .playlist.tmp);
	D=$(soxi -D "$listhead" | sed 's/^\(.\{3\}\).*/\1/');
	slp=$(expr "$D" - 2);
	(play -V0 "$listhead")&
	sed -i '1d' .playlist.tmp;
	sleep $slp;
	clear
done
rm .playlist.tmp
# Create playlist of all .mp3 files in ~/.radio:
#ls *.mp3 | shuf > radio.tmp
#play $list 

#ls *.mp3 | shuf > radio.tmp
#play $list

	#id3v2 -l "$s";



# Source gitPush by mrrw:
#. /home/$USER/bin/gitPush.sh

###  BEGIN ISSUES

#####  END ISSUES
#!/bin/bash
#
# echo's "OK" for awhile.



#!/bin/bash
#
# Config file for mrrw radio.
#touch ~/bin/radio.tmp
#[[ ! -d ~/.radio ]] && {
#		mkdir ~/.radio && cd ~/.radio;
#		}
#


