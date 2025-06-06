#!/bin/bash
#
# Bash script by Michael Milk under GPL @2025
#
# This script was created so that my family could play Twister by Hasboro.
# Behavior:  
#
a[1]="Right hand"
a[2]="Left hand"
a[3]="Right foot"
a[4]="Left foot"
c[1]="blue"
c[2]="yellow"
c[3]="green"
c[4]="red"
#appendage=$[RANDOM % ${#a[@]}]
#color=$[RANDOM % ${#c[@]}]
g='y'

while [[ $g == "y" ]] ; do
	appendage=${a[$(seq 4 | shuf | head -1)]}
	if [[ "$old_a" == "$appendage" ]] ; then
		appendage=${a[$(seq 4 | shuf | head -1)]}
	fi
	color=${c[$(seq 4 | shuf | head -1)]}
	
	echo -e "$appendage $color."
	echo -e "Press any key to spin.  Press 'q' to quit."
	read q
	if [[ $q == "q" ]] ; then echo "Bye!" && exit ; fi
	old_a="$appendage"
done

