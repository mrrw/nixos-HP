###
#!/bin/bash
set +v; set +x; set -e; set +u
# set -u # exit if no positional parameters provided by user.
# ~/bin/mrrw-song.bash
# by Michael Milk (mrrw.github) under GPL, @2025
# See EOF for known issues and bugs.
   ###  VARIABLES
DIRconf=$HOME/.config/song
DIRlib=$HOME/lib/song
DIRvar=$HOME/var/song
FILEconf_0=$DIRconf/song.conf
FILElog_0=$HOME/var/log/song.log
	options="aceEhlx"
#
Help()
{
	echo "USAGE:  mrrw-song [-$options]; [user input]; [user input]"
	echo "DESCRIPTION:  Create, edit, organize, and view poetry and song."
	echo
	echo "OPTIONS:"
	echo "     -a --add        |  Add songs to a set-list."
	echo "     -e --edit       |  Edit a song chosen from a list, then exit."
	echo "     -E --edits      |  Edit a song chosen from a list, then edit more."
	echo "     -h	--help       |  Display this help and exit."
	echo "     -l --logs       |  Display log and exit."
	echo "     -v --verbose    |  Enable verbose mode (for debugging purposes)."
	echo "     -x --debug      |  Trace/Debug mode.  Display script as it runs."
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
if [ ! -d $DIR0 ] ; then
	echo "You're using this program for the first time.  "
	echo "Would you like to create a directory?"
	read r && if [ $r = y ] ;then mkdir $DIR0 ; fi
	
	echo "Hello world.  Exec_SONGing \"$0\"." | tee $FILElog_0
fi

} #}}}
Exec_SONG()
{ #{{{
#while getopts ":ehlvx" option; do
#	case $option in
#		e | --edit)
#			COMMAND=$EDITOR
if [ -z "$COMMAND" ] ; then
	COMMAND="lolcat -S 1 -f -p 2000 -F 0.053" 
fi
cd $DIRlib
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
Edit_SONG()
{ #{{{
if [ -z "$COMMAND" ] ; then
	COMMAND="lolcat -f -p 2000 -F 0.053" 
fi
cd $DIRlib
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
   ### EXECUTION:
	 if [[ $COMMAND == $EDITOR ]] ; then
		Edit_SONG
	else
		Exec_SONG
	 fi


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
