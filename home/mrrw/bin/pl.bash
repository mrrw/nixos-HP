#!/bin/bash
# ~/bin/pl.bash
# By mrrw (@mrrw.github), @2025, under Gnu Public License.
# Archive your personal feelings, ideas, and progress into a simple log.
# Use options to manipulate or print personal log data.
# set -x ## debug mode
# 
# INITIAL COMMANDS:
	DIRback=$HOME/var/pl && d=DIRback && [ ! -d $d ] && mkdir -p $d
	DIRmain=$HOME/lib/txt/pl-$USER && d=$DIRmain && [ ! -d $d ] && mkdir -p $d
	DIRvar=$HOME/var && [ ! -d $DIRvar ] && mkdir -p $DIRvar
	FILEmain="$DIRmain/pl-$(date +%Y%m%d).txt" && f=$FILEmain
	FILEtmp=$DIRvar/pl-tmp.txt && ftmp=$FILEtmp && touch $ftmp
		options="aehptTxy"

Help()
{
echo ""
echo "   USAGE: pl [-$options] "
echo "   DESCRIPTION:  Archive your feelings, ideas, and progress into a simple log."
echo "                 Use options to manipulate or print personal log data."
echo "   OPTIONS:"
echo ""
echo "    -a --append      |  Append from standard input."
echo "    -e --edit        |  Edit personal log without adding new date-stamp."
echo "    -h --help        |  Display this help."
echo "    -p --previous    |  Choose a previous personal log."
echo "    -t --tail        |  Instead of editing the personal log, "
echo "                     |    display the last section of the personal log."
echo "    -T --trim        |  Remove all empty lines after last line of text."
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
			echo -e "\n\t!!! $USER is now appending standard input to todays file.  \n\tPress ctr-d when done." ;
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
		T | --trim)  ## Remove trailing empty lines after last line of text
			set -x
			grep -v '^\s*$' $f > $ftmp  ## @fedorqui.askubuntu
			#cat $ftmp > $f
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
		
### BUILD COMMANDS:

backup()
{
	d=$DIRback
	fb0=$d/tmp.txt
	fb1=$(echo $fb)_
	fb2=$(echo $fb)_1
	if [ -f $fb2 ] ; then cp $fb1 $fb2 ; fi
	if [ -f $fb1 ] ; then cp $fb0 $fb1 ; fi
	cp $f $fb0

}

mainCommand()
{
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

}

# Execute code:
backup
mainCommand

# EXPERIMENTAL:  TAKE STANDARD INPUT AND APPEND TO $f
# while IFS="\n" read -r line ; do
#   echo "${line}" >> $f
# done
