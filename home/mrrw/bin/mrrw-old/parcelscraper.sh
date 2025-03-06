###
#!/bin/sh
set +v; set +x; set -e; set +u
# set -u # exit if no positional parameters provided by user.
# ~/bin/parcelscraper.sh
# by Michael Milk (mrrw.github)
# See EOF for known issues and bugs.
#
   ###  SOURCES
#. $HOME/bin/.sh.conf.sh 
#. $HOME/bin/libmrrwCommands.sh
   ###  VARIABLES
home=$HOME/parcelscraper
conf=$HOME/.config/parcelscraper
lib=$HOME/lib/parcelscraper
var=$HOME/var/parcelscraper
conf_0=$HOME/.config/parcelscraper/parcelscraper.conf
log_0=$HOME/var/log/parcelscraper.log
   ###  OPEN LOGS
exec 3<> $log_0                  # Open log under file descriptor 3
exec 2>&3                        # Redirect stderr to $file_log_0
exec 4<> /dev/pts/4              # Open tty 4 for sending user messages, fd 4
#exec 1>&4                        # OPTIONAL:  Send all stdout to tty 4
#
Help()
{
	#Display Help.
	echo "USAGE:  parcelscraper [--options]; [user input]; [user input]"
	echo "DESCRIPTION:  ScrapeParcels online repository list into a database."
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
   ###  MAIN PROGRAM EXECUTION
Exec_PARCELSCRAPER

	###  ISSUES AND BUGS
	###  NOTES

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

#while :; do #This while loop is always open.
#	sleep 60
#done
#
# 
# 

