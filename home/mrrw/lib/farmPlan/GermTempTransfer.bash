#!/bin/bash

sourceFile=$HOME/lib/farmPlan/lists/GermTemp.list
d=$HOME/lib/farmPlan/list/.crops/

x=0
while IFS= read -r line; do
	if [ $x -gt 0 ] ; then
		touch tmp.txt
		echo "$line" > tmp.txt && s=tmp.txt
		Name=$(cut -f1 $s)
		f=$d$Name
		[ ! -f $f ] && touch -f $f
		echo "GermTempMin=$(cut -f2 $s)" > $f
		echo "GermTempOptimumMin=$(cut -f3 $s)" >> $f
		echo "GermTempOptimumMax=$(cut -f4 $s)" >> $f
		echo "GermTempMax=$(cut -f5 $s)" >> $f
		echo "GermTempNote=$(cut -f6 $s)" >> $f
	fi
	let "x+=1"
done < $sourceFile

	exit

#if [ ! -z $d$Name ] ; then touch $d$Name ; fi
#[ ! -s $d$Name ] && touch $d$Name

