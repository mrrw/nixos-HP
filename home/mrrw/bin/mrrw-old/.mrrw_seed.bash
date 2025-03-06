###
#!/bin/bash
set +v; set +x; set -e; set +u
# set -u       # set program to exit if no positional parameters provided by user.
#
# ~/bin/.mrrw_seed.bash
# by Michael Milk (mrrw.github)
#
# This document and all derivitives are hereby covered under Creative Commons license 
# CC BY-NC-SA.  Attribution necessary, non-commercial use only, and any adaptations
# must be licensed under identical terms.
#
 #
  #
   #
   ###  HELP AND OPTIONS
   #
Help()
{
	#Display Help.
	echo "USAGE:  seed [--options]; [user input]; [user input]"
	echo "DESCRIPTION:  Gently unpacks into mrrw's bash libraries and binaries."
	echo
	echo "OPTIONS:"
	echo "-h	Display this help and exit."
	echo "-l	Display log and exit."
	echo "-v	Verbose mode."
	echo "-x	Trace/Debug mode."
	echo
}
   # Get the options:
#{{{
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
   #
   ###  PROGRAM VARIABLES
   #
  dir_main="$HOME/bin"
  dir_lib="$HOME/lib"
  f="$dir_lib/.mrrw.lib.bash"
   #
   ###  PROGRAM EXECUTION
   #
sed -n '/CommandLibrary/,$p' $0 | sed 1,3d > $f
sleep .5 && PROGRM=seed && . $f
   #
   ###  NOTES AND BUGS
   #
  #
 #
#

###
#!/bin/bash
set +v; set +x; set -e; set +u
# set -u       # set program to exit if no positional parameters provided by user.
#
# ~/bin/PROGRM
# by Michael Milk (mrrw.github)
#
# This document and all derivitives are hereby covered under Creative Commons license 
# CC BY-NC-SA.  Attribution necessary, non-commercial use only, and any adaptations
# must be licensed under identical terms.
# by Michael Milk (mrrw.github)
#
#
 #
  #
   #
   ###  HELP AND OPTIONS
   #
Help()
{
	#Display Help.
	echo "USAGE:  PROGRM [--options]; [user input]; [user input]"
	echo "DESCRIPTION:  DSCR"
	echo
	echo "OPTIONS:"
	echo "-h	Display this help and exit."
	echo "-l	Display log and exit."
	echo "-v	Verbose mode."
	echo "-x	Trace/Debug mode."
	echo
}
   # Get the options:
#{{{
while getopts ":hlvx" option; do
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
   #
   ###  PROGRAM COMMANDS
   #
App_ACTIVATE()
{ #{{{  ----- App_ACTIVATE:  Initialization and termination
  #
App_PREP      # Create necessary files and directories, set daemon status
  #
  ###  INITIALIZE
  #
s="Initializing PROGRM.sh..." && App_LOG #&& App_ECHO
  #
  #
  # Start main application:
if [ $daemon = "y" ] ; then
	App_START&  # adding & at the end of a command runs it in the background.
	s="Starting PROGRM as daemon; exiting to terminal." && App_ECHO && App_LOG
else
	App_START   # Program will run in termimal until complete.
	s="Exiting PROGRM.sh." && App_LOG #&& App_ECHO
fi
exit

} #}}}
App_ECHO()
{ #{{{  ----- App_ECHO:  display string in terminal
  #
  echo -e "$s"
  #

} #}}}
App_LOG()
{ #{{{  ----- App_LOG:  append string to log
  #
  echo -e "$(date +%a_%m%d%y_%T) $s " >&3 
  #

} #}}}
App_PREP()
{ #{{{  ----- App_PREP:  Assign initial values and create necessary directories
  #
  # Standardized variables for files and directories:
dir_conf=$HOME/.config/PROGRM
dir_home=$HOME/PROGRM
dir_lib=$HOME/lib/PROGRM && lib=$dir_lib
dir_log=$HOME/var/log
dir_var=$HOME/var/PROGRM && var=$dir_var
file_conf_0=$HOME/.config/PROGRM/PROGRM.conf
file_log_0=$HOME/var/log/PROGRM.log
#
  #
  ###  PROGRAM VARIABLES
  #
daemon=n      # A daemon is an application that runs in the background. 
              # This frees up the terminal for further use,
              # but makes it harder for the user to terminate the program.
  #
  ###  SOURCES
  #
#. $HOME/bin/.sh.conf.sh 
#. $HOME/bin/libmrrwCommands.sh
  #
  ###  DIRECTORIES AND  FILES
  #
  # Address file structure for all mrrw scripts:
#[ ! -d $HOME/var ] && mkdir 
  #
  ###  LOGS
  #
file_log_0=$dir_log/PROGRM_0.log && fl0=$file_log_0
file_log_1=$dir_log/PROGRM_1.log && fl1=$file_log_1
file_log_2=$dir_log/PROGRM_2.log && fl2=$file_log_2
  # curate logs:
[ -s $fl1 ] && mv $fl1 $fl2
[ -s $fl0 ] && mv $fl0 $fl1
  # open main log:
exec 3<> $fl0                    # Open log under file descriptor 3
  # set stdout and stderr direction:
exec 2>&3                        # Redirect stderr to $file_log_0
exec 4<> /dev/pts/4              # Open tty 4 for sending user messages, fd 4
#exec 1>&4                        # OPTIONAL:  Send all stdout to tty 4
#
  # Create required files and directories:
  s="Looking for missing directories..." && App_LOG
#[ ! -d $dir_conf ] && mkdir -p $dir_conf  && s="Creating $dir_conf." && App_LOG
#[ ! -d $dir_home ] && mkdir -p $dir_home  && s="Creating $dir_home." && App_LOG
#[ ! -d $dir_lib ] && mkdir -p $dir_lib  && s="Creating $dir_lib." && App_LOG
#[ ! -d $dir_log ] && mkdir -p $dir_log  && s="Creating $dir_log." && App_LOG
#[ ! -d $dir_var ] && mkdir -p $dir_var  && s="Creating $dir_var." && App_LOG
  s="Prepared for execution." && App_LOG

} #}}}
App_START()
{ #{{{  ----- App_START:  open main application 
  #
  s="Executing main application." && App_LOG
  #
  # Executing program main commands:
  Exec_MAIN

} #}}}
App_UNPACK()
{ #{{{  ----- App_UNPACK:  assemble script from libraries
  #
  s="Unpacking application." && App_LOG
  #

} #}}}
Exec_MAIN()
{ #{{{  ----- Exec_MAIN:  execute command
  #
  s="Executing main command." && App_LOG
  #
  # Main command:
  s="Echoed \"hello world\"."
  echo "hello world"

} #}}}
   #
   ###  PROGRAM EXECUTION
   #
   ###  ISSUES AND BUGS
   #
   ###  NOTES
   #
###    ###  #########   #########   #        #
####  ####  ###     ##  ###     ##  ##      ##
# ###### #  ###     ##  ###     ##  ##      ##
##  ##  ##  #########   #########   ##  ##  ##
##      ##  ##  ###     ##  ###     ## #### ##
##      ##  ##    ###   ##    ###    ###  ###
##      ##  ##      ##  ##      ##   ##    ##
###    ###  ###    ###  ###    ###    #    #   
   #
#### Code clippings
   #
  #
 #
#
# 
# Take 3rd-from-last line, break each word each into their own line using xargs,
# taking the 7th-from-last line:
#tail -n 3 tmp.txt | head -n 1 | xargs -n1 | tail -n 7 | head -n 1
#
Exec_SCRIBE()
{ #{{{  Exec_SCRIBE
  #
name="$HOME/bin/${1-default}.bash"
s=$1
[ -s $name ] && echo "$name already exists." && exit
echo "Create a description of the script, no longer than this."
read 's'
cd $HOME && cat $HOME/bin/.sh.TEMPLATE | sed "s/PROGRM/$1/g ; s/DSCR/$s/" > $name

echo "sudo chmod +x $name" && sudo chmod +x $name
alias "$1"="$name" && echo -e " # Added $(date '+%Y-%m-%d'): \nalias $1=\"$name\"" >> $HOME/.alias 
alias "$1"
$EDITOR $name
[ -s .zshistory ] && echo "$EDITOR $name" >> .zshistory

} #}}}
Exec_ARMmain()
{ #{{{  ----- Exec_ARMmain:  execute command
  #
  s="Executing command ARMmain." && App_LOG
  #
  # Prep 
	cd $dir_downloads && ls | grep -i .zip > $tmp && s="Creating $tmp." && App_LOG
	r=n
	clear && ls | grep -i .zip 
	# Main
	while [ -s $tmp ] ; do
		Exec_ARMvars
		echo ""
		echo "Would you like to create $dir_arm?"
		echo -e "\t\t{n=no, y=yes, Y=yes-all}"
		read r
		if [[ $r == "Y" ]] ; then
			while [ -s $tmp ] ; do
				Exec_ARMvars
				Exec_FIRE
			done
		elif [[ $r == "y" ]] ; then
			Exec_ARMvars
			Exec_FIRE
		else
			sed -i '1d' $tmp
		fi
	done

} #}}}
Exec_ARMvars()
{ #{{{  ----- Exec_ARMvars:  execute command
	#
	# Prep
	s=$(head -n 1 $tmp)
	sArt=$(echo $s | awk -F- '{ print $1 }' | sed 's/\ //')
	sAlb=$(echo $s | awk -F- '{ st = index($0,"-");print substr($0,st+1)}' | sed 's/.zip// ; s/\ //g ; s/\ /_/g')
	#
	# Main
	dir_arm=$dir_music/$sArt/$sAlb/
	fZipFrom=$dir_downloads/$s
	fZipTo=$dir_arm/$s

} #}}}
Exec_FIRE()
{ #{{{  ----- Exec_FIRE:  execute command
  #
  s="Unzipping $fZip in $dir_arm." && App_ECHO && App_LOG
  #
  # main 
	cd "$dir_music"
	mkdir -p "$dir_arm"
	mv "$fZipFrom" "$dir_arm"
	cd "$dir_arm"
	unzip -q "$fZipTo"&
	sed -i '1d' $tmp

} #}}}
Exec_USERselect()
{ #{{{  ----- Exec_USERselect
	d=$lib/user && [ ! -d $d ] && mkdir -p $d 
	cd $d && [ ! -d .New_user ] && mkdir .New_user
	echo "Welcome to boss, where you control the commands."
	echo "Let's get you logged in!" && sleep 2
	echo -e "\n    Users:"
	if [[ $(ls $d) == "" ]] ; then 
		Exec_USERcreate
	else
		PS3="   Press the appropriate number, then hit enter:  "
		select u in $(ls -A) ; do
			if [[ $u  == ".New_user" ]] ; then
				Exec_USERcreate
			fi
			break
		done 2>&1
	fi 

} #}}}
Exec_USERcreate()
{ #{{{  ----- Exec_USERcreate
		echo "What's your name?" 
		read u && d=$u && mkdir $d
		. $dir/
		. $f

} #}}}
Exec_ACTS()
{ #{{{  ----- Exec_ACTS
	d=$u && cd $d
	if [[ $(ls) == "" ]] ; then
		touch "1 2 3"
	else
		echo
	fi

} #}}}
Exec_FLIP()
{ #{{{  ----- Exec_FLIP:  execute command
  #
  s="Executing main command." && App_LOG
  #
  # Main command:
  s="Echoed \"hello world\"."
	echo -e "Enter a letter for each subject you want to randomize between."
	read r
	n=$(echo -n $r | wc -m)
	echo -e "\nOrder after randomization:"
for x in $(shuf -i 1-$n) ; do
	if [[ $n != 1 ]] ; then
		echo "    $(echo $r | head -c $x | tail -c 1),"
	else
		echo "and $(echo $r | head -c $x | tail -c 1)."
	fi
	n=$(expr $n - 1)
	sleep 1
done

} #}}}
Exec_FOODFINDER()
{ #{{{  Exec_FOODFINDER
  #
[ ! -d $main ] && mkdir $main && echo "$main/ does not exist; making." >> $log
[ ! -d $list ] && mkdir $list && echo "$list/ does not exist; making." >> $log
cd $list
[ -s $(ls | grep .txt) ] && echo "No species list found in $list" && exit
# User chooses source file.
select f in $(ls -p | grep -v /) ; do
		ft="$list/.$f.tmp"
		s=$(head -n 1 $f)
	[ ! -s $ft ] && cat $f > .$f.tmp && echo "creating $ft from $list/$f" >> $log
	subdir=$(echo "$main/$f" | sed 's/\.[^.]*$//')
		[ ! -d $subdir ] && mkdir $subdir
	cd $subdir
	while read s ; do
		x=$(echo $s | sed 's/.*/\u&/;s/ /_/g')
		# Here, we ask sgpt questions about edibility and all that.  tee to log!
		# After questions, scrape wikipedia entry.
		# We'll also want to capture and store images somewhere somehow...
		w3m "$w/$x" |sed -n '/Species/,$p' | sed -n '/Retrieved\ from/,$!p'> "$x.txt" ;
		echo "scraped $w/$x" | tee -a $log
	done < "$ft"
done

} #}}}
Exec_FOODFINDER()
{ #{{{  Exec_FOODFINDER
  #
# Set some variables:
FileLog=$HOME/var/foodfinder.log
FileQuestions=$HOME/foodfinder/.questionlist.txt
DIRmain=$HOME/lib/foodfinder
DIRlist=$HOME/lib/foodfinder/.locallist
main=$DIRmain
list=$DIRlist
log=$FileLog
qfile=$FileQuestions
n=0 
PS3="Select the file containing the species you want to identify:  "
w="www.wikipedia.org/wiki"
[ ! -d $main ] && mkdir $main && echo "$main/ does not exist; making." >> $log
[ ! -d $list ] && mkdir $list && echo "$list/ does not exist; making." >> $log
cd $list
[ -s $(ls | grep .txt) ] && echo "No species list found in $list" && exit
# User chooses source file.
select f in $(ls -p | grep -v /) ; do
		ft="$list/.$f.tmp"
		s=$(head -n 1 $f)
	[ ! -s $ft ] && cat $f > .$f.tmp && echo "creating $ft from $list/$f" >> $log
	subdir=$(echo "$main/$f" | sed 's/\.[^.]*$//')
		[ ! -d $subdir ] && mkdir $subdir
	cd $subdir
	while read s ; do
		x=$(echo $s | sed 's/.*/\u&/;s/ /_/g')
		# Here, we ask sgpt questions about edibility and all that.  tee to log!
		# After questions, scrape wikipedia entry.
		# We'll also want to capture and store images somewhere somehow...
		w3m "$w/$x" |sed -n '/Species/,$p' | sed -n '/Retrieved\ from/,$!p'> "$x.txt" ;
		echo "scraped $w/$x" | tee -a $log
	done < "$ft"
done

} #}}}
Exec_GATHERERS()
{ #{{{
  #
dir1="/home/$USER/foodfinder/"
dir2="/home/$USER/wikifiles/"
dir3="/home/$USER/foodfound/"
dir4="/home/$USER/foodfound/yes/"
dir5="/home/$USER/foodfound/unknown/"
[ ! -d $dir3 ] && mkdir $dir3
[ ! -d $dir4 ] && mkdir $dir4
[ ! -d $dir5 ] && mkdir $dir5
for name in $(ls $dir1) ; do
	size=$(ls -l $dir1 | grep $name | awk '{print $5}' | head -c 2)
		cat $dir1$name > $dir3$name && echo $dir1$name
		cat $(tree -if $dir2| grep $name) >> $dir3$name
#	if [ $size == 14 ] ; then
#		cat $dir1$name > $dir4$name && echo $dir1$name
#		cat $(tree -if $dir2| grep $name) >> $dir4$name
#	else
#		cat $dir1$name > $dir5$name && echo $dir1$name
#		cat $(tree -if $dir2| grep $name) >> $dir5$name
#	fi	 
done

} #}}}
Exec_GITstuff()
{ #{{{
  #
git add /home/$USER/Documents/
git add /home/$USER/bin
git commit -a -m "pl" 
#sed '1s/^/pl' /home/$USER/.git/COMMIT_EDITMSG
#sed 'i/Created $name' /home/$USER/.git/COMMIT_EDITMSG
echo "Pulling from repo (no rebase, of course)..."
git pull --no-rebase
echo "Pushing to repo..."
git push

} #}}}
Exec_HELP()
{ #{{{
  #
COMMAND=
SUGGEST=
dir_lib="$HOME/lib/help"
if [ -z "$SUGGEST" ] ; then
	SUGGEST="view" ;fi
if [ -z "$COMMAND" ] ; then
	COMMAND="cat" ;fi
PS3="Which file would you like to $SUGGEST? ..."

###  MAIN PROGRAM EXECUTION
cd $dir_lib
select FILE in HELP*
do
		if [ "$COMMAND" != "vim" ] ; then 
			$COMMAND "$FILE" | less ;
		else
			$COMMAND "$FILE" ;
		fi
	break
done

} #}}}
Exec_HIREHAND()
{ #{{{
mainDIR=$HOME/hirehand
[ ! -d $mainDIR ] && mkdir -p $mainDIR
echo "What's the name of the company?"
read c
echo "What's the name of the position?"
read p
mkdir -p $mainDIR/$c
echo "Now, write a sentence or two describing why you're chosing this company."
read d
PS3="Choose a file to populate:  "
select t in $(ls -A $mainDIR | grep .template) ; do
	f=$(echo $p-$t | sed 's/template/txt/ ; s/\.// ; s/\ //g')
	cat $mainDIR/$t | sed "s/\$c/$c/ ; s/\$d/$d/ ; s/\$p/$p/" > $mainDIR/$c/$f
	echo "created $mainDIR/$c/$f"
done

} #}}}
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
Exec_NOW()
{ #{{{
# Display calendar and weather.  Refresh periodically.
clear
echo
echo "Today is $(date +%A), $(date +%B) $(date +%d)."
echo
echo
cal -3vm 
echo
curl wttr.in 
echo
echo "Weather snapshot taken $(date)"
# feh --no-xinerama -z --bg-fill ~/Pictures/* 
sleep 600 && ~/bin/now.sh

} #}}}
Exec_PARCELSCRAPER()
{ #{{{
	echo "Initializing parcelscraper."
	echo "$(date +%a_%m%d%y_%T) Initializing parcelscraper... " >&3
[ ! -d $var ] && mkdir -p $var
[ ! -d $lib ] && mkdir -p $lib
ScrapeList
ScrapeParcels
Pare_MAIN
Pare_school
	echo "Exiting."
	echo "$(date +%a_%m%d%y_%T) ...exiting parcelscraper." >&3 && exit

} #}}}
ScrapeList()
{ #{{{
	echo "Scraping site to main list."
	echo "$(date +%a_%m%d%y_%T) Scraping site to main list. " >&3
f1=$var/rawlist.tmp 
f2=$var/trimlist.tmp
f3=$lib/RepositorySaleList_$(date +%y%m%d).dat
s="https://public.eriecountypa.gov/property-tax-records/sales/tax-sales/repository-list"
	echo "Trimming main list."
	echo "$(date +%a_%m%d%y_%T) Trimming main list. " >&3
	set -x
w3m -dump $s > $f1
awk 'found,0;/TAX/{found=1}' $f1 | sed -e '/./!Q' > $f2
sed -i 's/-//g ; s/\.//g' $f2
sed -i 's/ /_/g' $f2
sed -i 's/_/ /' $f2
cat $f2 > $f3
	set +x

} #}}}
ScrapeParcels()
{ #{{{
	echo -n "Scraping entry sites using main list... Please wait...  "
	echo "$(date +%a_%m%d%y_%T) Scraping entry sites using main list. " >&3
f1=$lib/RepositorySaleList_$(date +%y%m%d).dat
f2=""  #defined in while loop
f3=""  #defined in while loop
s1="https://public.eriecountypa.gov/property-tax-records/property-records/property-tax-search/parcel-profile.aspx?parcelid="
while IFS= read -r line; do
	l1=$(echo $line | awk '{ print $1 }')
	l2=$(echo $l1 | cut -b 1,2,4,5,7,8)
	f2="$var/$l1"
	f3="$lib/$l1"
	s2="https://public.eriecountypa.gov/taxmaps/full/$l2.pdf"  # Tax map pdf
	if [ ! -s $f3 ] ; then
		set -x
		w3m -dump $s$l1 >$f2 
		awk 'found,0;/Address/{found=1}' $f2 | sed '/County/q' > $f3
	fi
	[ ! -d "$var/maps" ] && mkdir "$var/maps"
	[ ! -d "$lib/maps" ] && mkdir "$lib/maps"
	[ ! -s "$var/maps/$l2.pdf" ] && wget -P $var/maps $s2&
	pdftoppm -png "$var/maps/$l2.pdf" "$lib/maps/$l2.png"
	[ -s $f2 ] && rm $f2
		set +x
done < $f1
	echo "...done."
	echo "Done." >&3

} #}}}
Pare_MAIN()
{ #{{{
	echo "Paring files..."
	echo "$(date +%a_%m%d%y_%T) Paring files. " >&3
	Pare_school
	
	# Paring can help provide a means for user-selection of sort criteria.

} #}}}
Pare_school()
{ #{{{
f1=$lib/RepositorySaleList_$(date +%y%m%d).dat
f2=$var/.tmp && touch $f2
f3=$var/pare_s.tmp && touch $f3
	[ -s $f2 ] && rm $f2
	set -x
for f in $(cat $f1 | awk '{ print $1 }') ; do
	cat $lib/$f | grep -i school | tr -s " " >> $f2
done
	sort -u $f2 > $f3
	set +x
	echo "...done."
	echo "Done." >&3

} #}}}
Pare_value()
{ #{{{
	#############################################################################
	#
	# BROKEN: This command could be used in conjunction with Sort-by-price-range,
	#         but is not helpful as-is.
	#
f1=$lib/RepositorySaleList_$(date +%y%m%d).dat
f2=$var/.tmp && touch $f2
f3=$var/pare_v.tmp && touch $f3
	[ -s $f2 ] && rm $f2
	set -x
for f in $(cat $f1 | awk '{ print $1 }') ; do
	cat $lib/$f | grep -i "total value" | tr -s " " >> $f2
done
	sort -u $f2 > $f3
	set +x
	echo "...done."
	echo "Done." >&3

} #}}}
Exec_PL()
{ #{{{
	# set pl storage directory, if not already set
if [ ! -v u ] ; then u=$USER ; fi
d=$dir_usr/$u
if [ ! -d $d ] ; then mkdir -p $d ; fi
	# Make sure folding works:
set foldopen& #opens the fold that the cursur lands on.
	# Catagorize and name the document: 
		entrytypeOut="pl--"
		entrynameOut=`date +%F`
#NOTE: Placing $DOC in quotes allows for spaces in the title.
# Otherwise, .sh throws error 'ambiguous redirect.'
DOC=$d/$entrytypeOut$entrynameOut.txt
date +%c >> "$DOC"
echo -en "\n\n" >> "$DOC"
vim + -c startinsert "$DOC"
echo -en "\n**********\n" >> "$DOC"
echo "\"$DOC\" was modified:" && stat -c %y "$DOC"

} #}}}
MenuMain()
{ #{{{ MenuMain
dHome=~/.ppts
dValues=~/.ppts/values
today=$(date +%A)
	echo "1) Fetch chores"
	echo "2) Create chores"
	echo "3) Assign chores to person "
	echo "4) Assign value to chores"
	echo "5) Generate chores list"
	echo "6) Check a person"
	echo "7) Add a person"
	echo "8) "
	echo -en "\tWhat would you like to do?\t"
	read qCommand
		case $qCommand in
			1) ChoreCheck ;;
			2) ChoreAddQ ;;
			3) ChoreAssign ;;
			4) ChoreValue ;;
			5) ChoreGenList ;;
			6) PersonCheck ;;
			7) PersonCreate ;;
		esac
} #}}}
MenuChore()
{ #{{{ MenuChore

	echo "1) Fetch chores"
	echo "2) Create chores"
	echo "3) Assign chores to person "
	echo "4) Assign value to chores"
	echo "5) Generate chores list"
	echo "6) Check a person"
	echo "7) Add a person"
	echo "8) "
	echo -en "\tWhat would you like to do?\t"
	read qCommand
		case $qCommand in
			1) ChoreCheck ;;
			2) ChoreAddQ ;;
			3) ChoreAssign ;;
			4) ChoreValue ;;
			5) ChoreGenList ;;
			6) PersonCheck ;;
			7) PersonCreate ;;
		esac
} #}}}
PptsEarn()
{ #{{{ PptsEarn

	d=$dValues && ADMINcd
	while [[ -s $f ]]; do
		ADMINclipLine
		score=$(cat * | grep -il "$s")
		if [ score = "" ] ; then
			AssignValue;
		else 
			echo "$score -- $s" >> $name.prsn
			echo "$score +" >> score.tmp
		fi
	done
	echo "0" >> score.tmp
	echo -en $(cat score.tmp)
	expr $(cat score.tmp)
	while [[ ! -s score.tmp ]]; do
		ADMINclipLine
		score=$(cat *.pts | grep -il "$s")
		if [ score = "" ] ; then
			AssignValue;
		else 
			echo "$score -- $s" >> $name.prsn
			echo "$score" >> score.tmp
		fi
	done
} #}}}
ChoreAssign()
{ #{{{ ChoreAssign

	while [[ -s $f ]] ; do
		ADMINclipLine;
		ps3="Who Will/Did complete this chore today?";
		select name in $(ls | grep *.prsn) ; do
			echo "$s" >> "$name.prsn";
		done
	done
} #}}}
ChoreCheck()
{ #{{{ ChoreCheck

	f=.chore.tmp
	echo -n "Checking $f for undone chores...  " && sleep 1;
	if [[ -s $f ]] ; then
		echo Found some!
		echo 
		ChoreAssign
	else
		echo "No chores found.  Fetching chores..." && sleep 1;
		ChoreGenList
	fi
} #}}}
ChoreAddQ()
{ #{{{ ChoreAddQ

		qChoreCreate=y
		while [ $qChoreCreate = "y" ] ; do
			ChoreCreate ; 
			echo "Would you like to add new chores?"
			read qChoreCreate
		done
#	if [ $qChoreCreate = "y" ] ; then
#		ChoreCreate ; else
		exit
	#fi
} #}}}
ChoreCreate()
{ #{{{ ChoreCreate

	n="1NewChoreCategory"
	touch "$n"
	echo "What's the name of the new chore?" && read chore
	echo "Is this a daily chore?" && read daily && echo
	if [ $daily = "y" ] ; then
			echo "By default, this chore will be done daily." && echo;
			day=Daily;
		else
			echo "By default, this chore will repeat $today's." && echo;
			day="$today";
	fi
	PS3="Categorize the new chore.  (this can be changed later)"
	select category in $(ls -A $dHome | grep -i chore); 
	do
		if [[ $category = $n ]] ; then 
			echo "Name the new category." && read category;
			echo "$day -- $chore" >> $category.chore;
			echo "Created $category.chore."
			echo "Added \"$chore\" to $category.chore."
		else
			echo "$day -- $chore" >> $category;
			echo "Added \"$chore\" to $category."
		fi
		rm "$n";
		break;
	done
} #}}}
ChoreGenList()
{ #{{{ ChoreGen

	if [ ! -s .chore.tmp ] ; then
		f=$(ls | grep chore);
	 	cat $f | grep -i daily >> .chore.tmp;
	 	cat $f | grep -i $today >> .chore.tmp&
		echo ; 
		echo -e "\tChores left to do:";
		cat .chore.tmp
	else
		echo ; 
		echo "No action taken.";
		echo ; 
		echo -e "\tChores left to do:";
		cat .chore.tmp
	fi
} #}}}
ChoreSelect()
{ #{{{ ChoreCheck

	f=.chore.tmp
	qChoreSelect=y
	while [ $qChoreSelect = "y" ] ; do
		select chore in $f ; do
			MenuChore
		done
	done
} #}}}
ChoreValue()
{ #{{{ AssingValue

	
	d=$dValues && ADMINcdForce
	f=$dHome/.chore.tmp
	while [[ -s $f ]] ; do
		head -n 1 "$f"
		echo "How many points is this chore worth?"
		echo -n "[number]:"
		read value
		echo
		echo $(head -n 1 $f) >> "$value"
		sed -i '1d' $f
	done
} #}}}
GeneratePersonList()
{ #{{{
pl=/home/$USER/.ppts/person.list
touch $pl
echo "List your household members, each seperated by a space:  " 
read r
for p in $r; do
		touch "$p.prsn" 
		echo "$p" >> $pl
	done
} #}}}
PersonCheck()
{ #{{{ PersonCheck
	
	names=$(echo "$(tree -if | grep prsn)")
	if [ -z $names ] ; then
		echo none && PersonCreate; else
		echo found && PersonSelect;
	fi


} #}}}
PersonCreate()
{ #{{{ PersonCreate

	echo "What is the person's first name?"
	read name
	if [ "$name.prsn" == "$(ls | grep "$name")" ] ; then
		echo "That name is already taken.  Choose another.";
		read name;
		touch "$name.prsn"
	else
		touch "$name.prsn"
	fi
	PersonSelect
} #}}}
PersonSelect()
{ #{{{ PersonSelect

		ps3="Select a person."
		select name in $(ls | grep *.prsn) ; do
			$qCommand
		done
} #}}}
# Get the options:
#{{{
while getopts ":aghlqvx" option; do
	case $option in
		a | --addRecipient)
			addRecipient
			;;
		g | --generateQuestions)
			generateQuestions
			;;
		h | --help) # display help
			Help
			exit;;
		l | --loadRecipient)
			loadRecipient
			;;
		q | --answerQuestions)
			answerQuestions
			;;
		v) # verbose mode
			set -v;;
		x) # trace mode
			set -x;;
	  \?) # invalid option
			echo "Error: Invalid option."
			exit;;
	esac
done

#}}}
Exec_ROLL()
{ #{{{  ----- Exec_ROLL:  execute command
  #
  s="Executing main command." && App_LOG
  #
  # Main command:
	s="Rolling..." && App_LOG
	s="\$1 equals $1." && App_LOG
	if [[ $1 != "" ]] ; then
		echo "no"
	else
		echo "yes"
	fi
	echo -n "Rolling dice.  How many sides is it?  "
	read r
	echo "We rolled a $(seq $r | shuf | head -n 1)."

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
Check_APPS()
{ #{{{ ----- Check_APPS
	# Scan list of apps to run, both daemons and periodical instances.
echo "$(date +%a_%m%d%y_%T) Scanning run-list every 60 seconds..." >&3
while :; do #This while loop is always open.
		 ### Daemons:
		radiod
		 ### Periodical Instances:
		moveFiles
	sleep 60
done

} #}}}
moveFiles()
{ #{{{
	mv $HOME/*scrot* ~/usr/Images 2>/dev/null&
	mv $HOME/*--* ~/lib/help 2>/dev/null&

} #}}}
radiod()
{ #{{{
s=$HOME/bin/radio.sh
if [ -z $(ps ax |grep $s| grep -iv grep | head -n 1 | awk '{ print $1 }') ] ; then
	echo "$(date +%a_%m%d%y_%T) Initializing radiod." >&3
	sh -c $s
fi

} #}}}
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
Exec_GREET()
{ #{{{  ----- Exec_GREET
#
f=$dir_conf/greet.conf
if [ -s $f ] ; then
	. $f
else
	echo '#!/bin/bash' > $f
	echo '#' >> $f
	echo 'd=$dir_lib/images' >> $f
	echo 's1="\n\nGreetings from the taboret."' >> $f
	echo 's2="\nToday is $(date +%A,\ %B\ %d,\ %Y).\n\n"' >> $f
	[ ! -d $d ] && cd $dir_lib && mkdir images
fi
cd $d
	x=$(seq 7|tail -n 2|shuf|head -n 1)	
	while [[ $x != 1 ]] ; do
		f=$(ls $d|shuf|head -n 1)
		echo "$d/$f" >&3
		jp2a -f --color --size=65x65 $d/$f
		x=$(expr $x - 1)
		sleep 0.05
	done
	clear
			cmatrix="cmatrix -obcr -ur .$(seq 9|tail -n 4|shuf|head -n 1)"
			$cmatrix&
			sleep .$(seq 4|tail -n 4|shuf|head -n 1) && kill $!
			f=$(ls $d|shuf|head -n 1)
			jp2a -f --color --invert --size=65x65 $d/$f |shuf| head -n 9
	echo -e $s1 
	echo -e $s2 
			jp2a -f --flipy --color --invert --size=65x65 $d/$f|shuf | head -n 5
			sleep 5
			clear
			$cmatrix&
			sleep .$(seq 4|tail -n 4|shuf|head -n 1) && kill $!

} #}}}
Exec_HOME()
{ #{{{  ----- Exec_HOME
f=$dir_conf/home.conf
if [ -s $f ] ; then
	. $f
else
	echo '#!/bin/bash' > $f
	echo 'Exec_HOME=Exe_Neofetch' >> $f
	echo 'sleeptimer=$(seq 4|tail -n 2|shuf|head -n 1)$(seq 9|tail -n 1|shuf|head -n 1)' >> $f
fi
clear && $Exec_HOME
sleep $sleeptimer
	Exec_JUNC

} #}}}
Exec_JUNC()
{ #{{{ ----- Exec_JUNC
# (create and) source .conf:
f=$dir_conf/junc.conf
if [ -s $f ] ; then
	. $f
else
	echo '#!/bin/bash' > $f
	echo 'n=$(seq 1 | shuf | head -n 1)' >> $f
	echo 'Exec_TRANS="Exec_TRANS_$n"' >> $f
fi
# Transition:
	echo "$Exec_TRANS" >&3
	clear && $Exec_TRANS
	touch $fT
	t=$(head -n 1 $fT)
	[[ $t != "" ]] && $t
	Exec_HOME

	# Transition:
} #}}}
Exec_Neofetch()
{ #{{{  ----- Exhibit
#while [[ $x != 0 ]] ; do 
	l=$(grep -2 "pacman -Syu" /var/log/pacman.log | tail -1 | sed "s~T.*~~" | sed "s/^\[//") 
	s="butts"
	u=$(expr $(date +%j) - $y + 1) 
	y=$(date -d $l +%j) 
	neofetch="neofetch --disable theme icons memory packages wm de term uptime"
	colorize="lolcat -F .03 -p 6"
	clear 
	$neofetch|$colorize
	if [[ $radio == "y" ]] ; then
		echo -en $s
	else
		echo -n "Last system update:  $u days ago." 
	fi
	#sleep 600
#done

} #}}}
Exec_RadioConsole()
{ #{{{  ----- Exhibit
#while [[ $x != 0 ]] ; do 
	l=$(grep -2 "pacman -Syu" /var/log/pacman.log | tail -1 | sed "s~T.*~~" | sed "s/^\[//") 
	y=$(date -d $l +%j) 
	u=$(expr $(date +%j) - $y + 1) 
	neofetch="neofetch --disable theme icons memory packages wm de term uptime"
	echo="Last system update:  $u days ago."
	colorize="lolcat -F .03 -p 6"
	clear 
	echo $echo|$colorize
	
	#sleep 600
#done

} #}}}
Exec_TRANS_0()
{ #{{{  ----- Exec_TRANS_0
	d=$dir_lib/images
	[ ! -d $d ] && cd $dir_lib && mkdir images
	cd $d
	x=$(seq 7|tail -n 2|shuf|head -n 1)	
	while [[ $x != 1 ]] ; do
		f=$(ls $d|shuf|head -n 1)
		echo "$d/$f" >&3
		jp2a -f --color --size=65x65 $d/$f
		x=$(expr $x - 1)
		sleep 0.05
	done

} #}}}
Exec_TRANS_1()
{ #{{{  ----- Exec_TRANS_1
f=$dir_conf/trans.conf
if [ -s $f ] ; then
	. $f
else
	echo '#!/bin/bash' > $f
	echo 'n=$(seq 1 | shuf | head -n 1)' >> $f
	echo 'Exec_TRANS="Exec_TRANS_$n"' >> $f
fi
	cmatrix="cmatrix -obcr -ur .$(seq 9|tail -n 4|shuf|head -n 1)"
	f=$(ls $d|shuf|head -n 1)
		jp2a -f --color --size=65x65 $d/$f
		sleep .1
	f=$(ls $d|shuf|head -n 1)
		jp2a -f --color --invert --size=65x65 $d/$f
		sleep .1
	if [ $m = "" ] ; then
			$cmatrix&
			sleep .$(seq 8|tail -n 4|shuf|head -n 1) && kill $!
		else
			$cmatrix&
			sleep .$(seq 4|tail -n 4|shuf|head -n 1) && kill $!
			f=$(ls $d|shuf|head -n 1)
			jp2a -f --color --invert --size=65x65 $d/$f |shuf| head -n 9
			echo -e "\n\n$m\n\n"
			jp2a -f --flipy --color --invert --size=65x65 $d/$f|shuf | head -n 5
			sleep 5
			clear
			$cmatrix&
			sleep .$(seq 4|tail -n 4|shuf|head -n 1) && kill $!
	fi
	f=$(ls $d|shuf|head -n 1)
		jp2a -f --color --invert --size=65x65 $d/$f
	f=$(ls $d|shuf|head -n 1)
		jp2a -f --color --size=65x65 $d/$f | shuf

} #}}}
CONVERTfiletype() 
{ #{{{  CONVERTfiletype
	ftA=wav && ftB=mp3
	touch .tmp 
	echo "Convert all files in this directory from $ftA to $ftB?"
	read ur
if [ $ur = y ] ; then
	ls -A | grep -i ".wav" > .tmp 
	while [ -s .tmp ] ; do
		fA=$(head -n 1 .tmp) ;
		fB=$(head -n 1 .tmp | sed 's/wav// ; s/WAV//') ;
		ffmpeg -i "$fA" -af aformat=s16:44100 "$fB"MP3 ;
		rm $fA
		sed -i '1d' .tmp; 
	done ;
else
	echo "Convert all files in this directory from $ftB to $ftA?" ;
	read ur
	if [ $ur = y ] ; then
	ls -A | grep -i ".mp3" > .tmp 
		while [ -s .tmp ] ; do
			fA=$(head -n 1 .tmp) ;
			fB=$(head -n 1 .tmp | sed 's/mp3// ; s/MP3//') ;
			mpg123 -w "$fB"WAV "$fA" ;
			rm $fA
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
Exec_WIKISCRAPER()
{ #{{{
[ ! -d $maindir ] && mkdir $maindir
w="www.wikipedia.org/wiki"
for file in $(ls /home/$USER/.wikiscraper/) ; do
	n=0
	subdir=$(echo "$file" | sed 's/\.[^.]*$//')
	cd $maindir
	[ ! -d $subdir ] && mkdir $subdir
	cd $subdir
	while read s ; do
		n=$(expr $n + 1) ;
		x=$(echo $s | sed 's/.*/\u&/;s/ /_/')
		w3m "$w/$x" |sed -n '/Species/,$p' | sed -n '/Retrieved\ from/,$!p'> "$x.txt" ;
		echo "created ~/wikifiles/$(echo "$file" | sed 's/\.[^.]*$//')/$x.txt" | tee -a ~/wikiscraper.log
	done < "/home/$USER/.wikiscraper/$file"
done

} #}}}
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
$command
