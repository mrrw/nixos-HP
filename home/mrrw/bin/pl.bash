#!/bin/bash
# ~/bin/pl.bash
# ...by mrrw, @2025, no rights reserved
# Archive your personal feelings, ideas, and progress into a simple log.
# Use options to manipulate or print personal log data.
 #set -x ## debug mode
# 
# INITIAL COMMANDS:
	d=$HOME/lib/txt/pl-$USER && [ ! -d $d ] && mkdir -p $d
	f="$d/pl-$(date +%Y%m%d).txt"
	options="aehptxy"
	var=$HOME/var/ && [ ! -d $var ] && mkdir -p $d
	ftmp=$var/pl-tmp.txt

Help()
{
echo ""
echo "   USAGE: pl [-$options] "
echo "   DESCRIPTION:  Archive your feelings, ideas, and progress into a simple log."
echo "                 Use options to manipulate or print personal log data."
echo "   OPTIONS:"
echo ""
echo "    -a --append      |  Append from standard input."
echo "    -h --help        |  Display this help."
echo "    -p --previous    |  Choose a previous personal log."
echo "    -t --tail        |  Instead of editing the personal log, "
echo "                     |    display the last section of the personal log."
echo "    -x --debug       |  Print script functions as they occur."
echo ""
}

# GET OPTIONS:
#while getopts ":aehptxy" opt; do
while getopts ":$options" opt; do
	case ${opt} in
		a) #append
			[ ! -e $f ] && touch $f ] && echo -e "Creating $f." ;
			tail -3 $f
			echo "Appending standard input to todays file.  Press ctr-d when done." ;
			cat - >> $f ;
			exit ;;
		e | --edit)
			$EDITOR $f
			exit ;;
		h | --help)
			Help ;
			exit ;;
		p) # call yesterdays pl instead of todays
			PS3="Choose a file from up to seven days ago."
			select f in $(ls $d | tail -n 8 | head -n 7 | sort -r); do
				echo ""
				sed ':a;/$/{N;s/.*\n\n//;ba;}' $d/$f
				break
			done
			exit ;;
		t) # print last few lines after last empty line
			shift
			if [ ! -e $f ] ; then
				f=$(find $d | sort | tail -n 1)
			fi
			sed ':a;/$/{N;s/.*\n\n//;ba;}' $f
			exit ;;
		x) # debug
			set -x;
			shift;
			;;
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

