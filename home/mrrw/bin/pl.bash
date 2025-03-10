#!/bin/bash
# ~/bin/pl.bash
# Archive your personal feelings, ideas, and progress into a simple log.
# Use options to manipulate or print personal log data.
 #set -x ## debug mode
# 
# INITIAL COMMANDS:
	d=$HOME/lib/txt/pl-$USER && [ ! -d $d ] && mkdir -p $d
	f="$d/pl-$(date +%Y%m%d).txt"
	var=$HOME/var/ && [ ! -d $var ] && mkdir -p $d
	ftmp=$var/pl-tmp.txt

# GET OPTIONS:
while getopts ":aptxy" opt; do
	case ${opt} in
		a) #append
			[ ! -e $f ] && touch $f ] && echo -e "Creating $f." ;
			tail -3 $f
			echo "Appending standard input to todays file.  Press ctr-d when done." ;
			cat - >> $f ;
			exit ;;
		t) # print last few lines after last empty line
			shift
			if [ ! -e $f ] ; then
				f=$(find $d | sort | tail -n 1)
			fi
			sed ':a;/$/{N;s/.*\n\n//;ba;}' $f
			exit ;;
		x) # debug
			set x;
			shift;
			;;
		y) # call yesterdays pl instead of todays
			PS3="Choose a file from up to seven days ago."
			select f in $(ls $d | tail -n 8 | head -n 7 | sort -r); do
				sed ':a;/$/{N;s/.*\n\n//;ba;}' $d/$f
				break
			done
			exit ;;
		*)
			echo "Invalid option: -${OPTARG}."
			exit 1 ;;	
	esac
done
		

# Execute code:
# EXPERIMENTAL:  TAKE STANDARD INPUT AND APPEND TO $f
# while IFS="\n" read -r line ; do
#   echo "${line}" >> $f
# done

if [ ! -s $f ] ; then
	echo -e "Creating $f." ;
	date > $f;
	echo -e '\n' >> $f ;
	vim + -c 'startinsert' $f
else
	echo -e '\n' >> $f ;
	echo -e '*************\n' >> $f ;
	date >> $f;
	echo -e '\n' >> $f ;
	vim + -c 'startinsert' $f
fi

