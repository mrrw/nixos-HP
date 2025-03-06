#!/bin/bash
set +v; set +x; set -e; set -u
# ~/bin/newScript.slate.sh
# by Michael Milk (mrrw.github)
# See EOF for known issues and bugs.
. /home/$USER/bin/.sh.conf.sh

Help()
{
	#Display Help.
	echo "USAGE:  pl [--options]; [user input]; [user input]"
	echo "DESCRIPTION:  Create a datestamped personal log entry."
	echo
	echo "OPTIONS:"
	echo "-v	Verbose mode."
	echo "-h	Display this help."
	echo
}

# Get the options:
while getopts ":hv" option; do
	case $option in
		h) # display help
			Help
			exit;;
		v) # verbose mode
			set -v;;
		x) # trace mode
			set -x;;
	  \?) # invalid option
			echo "Error: Invalid option."
			exit;;
	esac
done

###  BEGIN USER CONFIGURATION

#####  END USER CONFIGURATION


###  BEGIN PROGRAM EXECUTION

echo "What's the name of your program?"
read script
if
	[[ $script == *.sh ]]; then
	echo -en "Shall we store this in ~/bin?";
	read b;
	s=$script;
else
	echo -en "Shall we call this $script.sh?";
	read s;
	echo -en "Shall we store this in ~/bin?";
	read b;
fi

if
	[[ $b == y ]]; then
		b=/bin;
		cd ~/bin
	else
		b=;
		cd ~
fi
if
	[[ $s == y ]]; then
		s=.sh
	else
		s=
fi

name="/home/$USER$b/$script$s"
if
	[[ ! -e $name ]] ; then
	echo "Creating $name..." && sleep 1;
	touch "$name";
	sed '' ~/bin/.sh.TEMPLATE > $name;
else
	echo -en "'$name' already exists.  Choose another name.\n";
	read script; 
	name="/home/$USER$b/$script$s"
	echo -en "OK, creating $script$s.\n" && sleep 1;
	touch "$name";
	sed '' ~/bin/.sh.TEMPLATE >> $name;
fi
chmod +x $name
$editor $name
exit


###  BEGIN ISSUES

#####  END ISSUES
