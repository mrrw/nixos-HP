#!/bin/bash
#
# Bash script by Michael Milk under GPL @2025
#
# This script was created so that my family could play Twister by Hasboro.
# Behavior:  
#
a1="Right hand"
a2="Left hand"
a3="Right foot"
a4="Left foot"
c1=blue
c2=yellow
c3=green
c4=red
g="y"  ## game ends if $g does not equal "y".

while [[ $g == "y" ]] ; do
	#echo -e "$(echo "$a$(seq 4 | shuf | head -1")) $c$(seq 4 | shuf | head -1)."
	echo -e "
	echo -e "Press any key to spin.  Press 'q' to quit."
	read q
	if [[ $q == "q" ]] ; then echo "Bye!" && exit ; fi
done
