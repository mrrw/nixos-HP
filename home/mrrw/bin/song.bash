###
#!/bin/bash
set +v; set +x; set -e; set +u
# set -u # exit if no positional parameters provided by user.
# ~/bin/song2.sh
# by Michael Milk (mrrw.github)
# See EOF for known issues and bugs.
#
   ###  SOURCES
#. $HOME/bin/.sh.conf.sh 
#. $HOME/bin/libmrrwCommands.sh
   ###  VARIABLES
dir_conf=$HOME/.config/song
dir_lib=$HOME/lib/song
dir_var=$HOME/var/song
file_conf_0=$dir_conf/song.conf
file_log_0=$HOME/var/log/song.log
#
Help()
{
	#Display Help.
	echo "USAGE:  song2 [--options]; [user input]; [user input]"
	echo "DESCRIPTION:  fill later"
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
while getopts ":ehlvx" option; do
	case $option in
		e | --edit)
			COMMAND=$EDITOR
			;;
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
Gate()
{ #{{{
if [ ! -d $dir_0 ] ; then
	echo "You're using this program for the first time.  "
	echo "Would you like to create a directory?"
	read r && if [ $r = y ] ;then mkdir $dir_0 ; fi
	
	echo "Hello world.  Exec_SONGing \"$0\"." | tee $file_log_0
fi

} #}}}
Exec_SONG()
{ #{{{
#while getopts ":ehlvx" option; do
#	case $option in
#		e | --edit)
#			COMMAND=$EDITOR
if [ -z "$COMMAND" ] ; then
	COMMAND="lolcat -f -p 2000 -F 0.053" 
fi
cd $dir_lib
x=1
PS3="... song:  "
select FILE in S*NG* 
do
	if [[ $(echo "$FILE" | grep -o SING) == "SING" ]] ; then
		$EDITOR "$FILE" ;
	else
		if [ "$COMMAND" != "$EDITOR" ] ; then 
			$COMMAND "$FILE" | less ;
		else
			$COMMAND "$FILE" ;
		fi
	fi
	echo "              $(echo $FILE | sed 's/S.NG//' | sed 's/\.txt//')." | lolcat -F .05
	if [ $x != 1 ] ; then
		break;	
	fi
done

} #}}}
   ###  MAIN PROGRAM EXECUTION
Exec_SONG

	###  ISSUES AND BUGS
	###  NOTES

###    ###  #########   #########   #        #
####  ####  ###     ##  ###     ##  ##      ##
# ###### #  ###     ##  ###     ##  ##      ##
##  ##  ##  #########   #########   ##  ##  ##
##      ##  ##  ###     ##  ###     ## #### ##
##      ##  ##    ###   ##    ###    ########
##      ##  ##      ##  ##      ##   ########
###    ###  ###    ###  ###    ###    ##  ##   

	###  CODE SNIPPETS

#ls --format=single-column SONG* | sed 's/SONG--//' | sed 's/.txt//'
