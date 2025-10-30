#!/bin/bash

sourceFile=$HOME/lib/farmPlan/.archive/lists/GermTemp.list
d=$HOME/lib/farmPlan/lists/.crops/

x=0
while IFS= read -r line; do
	if [ $x -gt 0 ] ; then
		touch tmp.txt
		echo "$line" > tmp.txt && s=tmp.txt
		Name=$(cut -f1 $s)
		f=$d$Name
		[ ! -f $f ] && touch -f $f
		echo "GrowTempMin=$(cut -f2 $s)" >> $f
		echo "GrowTempOptimumMin=$(cut -f3 $s)" >> $f
		echo "GrowTempOptimumMax=$(cut -f4 $s)" >> $f
		echo "GrowTempMax=$(cut -f5 $s)" >> $f
		echo "GrowTempNote=$(cut -f6 $s)" >> $f
	fi
	let "x+=1"
done < $sourceFile

	exit

#if [ ! -z $d$Name ] ; then touch $d$Name ; fi
#[ ! -s $d$Name ] && touch $d$Name

