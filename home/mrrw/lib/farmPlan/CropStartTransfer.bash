#!/bin/bash
set +x

sourceFile=$HOME/lib/farmPlan/cropStart.txt
	f=$sourceFile

destinationDirectory=$HOME/lib/farmPlan/lists/.crops/
	d=$destinationDirectory

while IFS= read -r line ; do
	touch tmp.txt
	echo "$line" > tmp.txt && s=tmp.txt
	name=$(cut -f 1 $s)
	string=$(cut -f 2 $s)
	echo "This is $name."
	echo "... $string."
	exit
done < $f
