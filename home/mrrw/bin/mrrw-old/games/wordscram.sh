#!/bin/sh
set +v; set +x; set -e; set -u
# ~/bin/wordscram.sh
# by Michael Milk (mrrw.github)
# See EOF for known issues and bugs.
#
###  SOURCES
. $HOME/bin/.sh.conf.sh 
. $HOME/bin/libmrrwCommands.sh
###  VARIABLES
dir_0=$HOME/lib/wordscram && [ ! -d $dir_0 ] && mkdir $dir_0
dir_1=$dir_0/Languages && [ ! -d $dir_1 ] && mkdir $dir_1
file_test=$dir_0/.testfile.txt
file_0=$dir_0/.tmp
file_1=$dir_0/startwords.dat
file_conf_0=$HOME/.config/wordscram/wordscram.conf
file_log_0=$HOME/var/log/wordscram.log
 # '$C' is a masterlist of consonants.
C=bcdfghjklmnprstvwxz 
 # The following variable can be renamed to track experiments:
X=testfile

#
Help()
{
	#Display Help.
	echo "USAGE:  wordscram [--options]; [user input]; [user input]"
	echo "DESCRIPTION:  Make nonsense words."
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
###  PROGRAM COMMANDS

LanguageStarterTest()
{ #{{{
	# Clear testfile:
		[ -s $file_0 ] && rm $file_0
  C=bcdfghjklmnprstvwxz 
#randomize the consonants to be used:
	C=$(echo $C | sed 's/./&\n/g' | shuf | tr -d "\n")
# Determine how many words to make:
	x=$(seq 30 50 | shuf | head -n 1)
# Make the determined number of words:
for run in $(seq $(wc -l $file_1 | awk '{print $1}')) ; do
	echo -n "Creating word:  "
		WordCreate 
			# Excluding words containing only one letter...
	#			if [[ $(expr length "$word") > 1 ]] ; then
			# ...put the words in a file:
					echo $word >> $file_0
	#			fi
		#[ $x = 1 ] && break
		#x=$(expr $x - 1)
	echo -e "$word"
done
cat $file_0 | awk '{ print length, $0 }' | sort -n | cut -d " " -f2- | uniq > $file_0

} #}}}
LanguageStarter()
{ #{{{
#randomize the consonants to be used:
	C=$(echo $C | sed 's/./&\n/g' | shuf | tr -d "\n")
# Determine how many words to make:
	x=$(seq 30 50 | shuf | head -n 1)
# Make the determined number of words:
	while [[ $x != 0 ]] ; do
		WordCreate 
			# Excluding words containing only one letter...
				if [[ $(expr length "$word") > 1 ]] ; then
			# ...put the words in a file:
					echo $word >> $file_0
				fi
		[ $x = 1 ] && break
		x=$(expr $x - 1)
	done
cat $file_0 | awk '{ print length, $0 }' | sort -n | cut -d " " -f2- | uniq > $file_0
echo "Done done"
# Sort something?
#for i in $(cat $file_0)

} #}}}
WordCreate()
{ #{{{
# Determine word length:
	a=$(seq 12 22 | shuf | head -n 1)
# Hash out word 
	word=$(xxd -l $a -c $a -p < /dev/random | sed 's/[0-9]//g' | tr bdfg c | tr ae v)
# Define letters:
	v="aeiouyouy"
	c=$C
# Replace hash with defined letters:
	word=$(echo $word |
	sed "s/ccccccccc/${c:7:1}/g"|
	sed "s/cccccccc/${c:6:1}/g"|
	sed "s/ccccccc/${c:5:1}/g"|
	sed "s/cccccc/${c:4:1}/g"|
	sed "s/ccccc/${c:3:1}/g"|
	sed "s/cccc/${c:2:1}/g"|
	sed "s/ccc/${c:1:1}/g"|
	sed "s/cc/${c:0:1}/g"|
	sed "s/c//g"|
	sed "s/vvvvvvvvv/${v:9:1}/g"|
	sed "s/vvvvvvvv/${v:8:1}/g"|
	sed "s/vvvvvvv/${v:7:1}/g"|
	sed "s/vvvvvv/${v:6:1}/g"|
	sed "s/vvvvv/${v:5:1}/g"|
	sed "s/vvvv/${v:4:1}/g"|
	sed "s/vvv/${v:3:1}/g"|
	sed "s/vv/${v:2:1}/g"|
	sed "s/v/${v:1:1}/g") 

paste $file_0 $file_1 >> $dir_1/$(tail -n 1 $file_0).txt

} #}}}

###  MAIN PROGRAM EXECUTION
Test()
{ ###  START TEST SCRIPT
	#
	# The following program calls WordCreate $x times:
		LanguageStarterTest
	#
} ###  END TEST SCRIPT

#Test
Test #| awk '{ print length, $0 }' | sort -n | cut -d " " -f2- | uniq >> $file_0

#for i in $(cat $file_0) ; do
#	echo -en $i | awk '{ print $1 }' #$(echo $i)
#done
		# print, number, sort by number of characters, remove number:
#cat $file_0
#cat $file_1 #| awk '{ print length, $0 }' | sort -n | cut -d " " -f2- | uniq #> $file_0
#less $file_0

###  ISSUES AND BUGS
#
###  CODE SNIPPETS
