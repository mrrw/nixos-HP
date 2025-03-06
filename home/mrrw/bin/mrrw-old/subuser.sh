###
#!/bin/sh
set +v; set +x; set -e; #set -u
# ~/bin/subuser.sh
# by Michael Milk (mrrw.github)
# See EOF for known issues and bugs.
#
   ###  SOURCES
#. $HOME/bin/.sh.conf.sh 
#. $HOME/bin/libmrrwCommands.sh
   ###  VARIABLES
dir_0=$HOME/.subuser
file_0=$dir_0/.testfile.txt
file_1=$dir_0/.tmp
file_conf_0=$HOME/.config/subuser/subuser.conf
file_log_0=$HOME/var/log/subuser.log
 # The following variable can be renamed to track experiments:
X=testfile

#
Help()
{
	#Display Help.
	echo "USAGE:  subuser [--options]; [user input]; [user input]"
	echo "DESCRIPTION:  Call a customized command tree for registered visitors."
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

CallUser()
{ #{{{
[ ! -R $1 ] && echo "Calling subuser $1" && user=$1
r=y
u=$dir_0/$user
[ ! -s $u ] && echo -e "Subuser \"$user\" does not exist.  Create?" && read r 
if [[ $r == y ]] ; then
	echo "Creating subuser $user." && touch $u;
else exit
fi
# uncomment the following to ask questions and fill $user conf:
#[ ! -s $u ] && FillUser
BUILTINpl

} #}}}
FillUser()
{ #{{{
f=y
while [ $f = y ] ; do
	echo "Type a command and hit enter.  $user will be able to call this command."
	read r && echo $r >> $u
	echo "Briefly describe the command.  $user will see only the description."
	read r && echo $r >> $u
	echo "Would you like to add another command?" && read f
done

[ ! -s $u ] && rm $u && echo "$u is empty; removing."
} #}}}
BUILTINpl()
{ #{{{
DIR=~/Documents/
entrytypeOut=".$user--"
entrynameOut=`date +%F`
title=$entrynameIn
DOC=$entrytypeOut$entrynameOut.txt
cd $DIR
date +%c >> "$DOC"
echo -en "\t$title\n\n\n" >> "$DOC"
vim + -c startinsert "$DOC"
echo -en "\n**********\n" >> "$DOC"
echo "\"$DOC\" was modified: $(stat -c %y "$DOC")" | tee -a $u

} #}}}
###  MAIN PROGRAM EXECUTION

	###  ISSUES AND BUGS
#
###  CODE SNIPPETS
