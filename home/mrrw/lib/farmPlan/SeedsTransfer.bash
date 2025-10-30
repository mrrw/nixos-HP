#!/bin/bash

sourceFile=$HOME/lib/farmPlan/lists/Seeds.list
d=$HOME/lib/farmPlan/lists/.crops/

while IFS= read -r line; do
		touch tmp.txt
		echo "$line" > tmp.txt && s=tmp.txt
		Name=$(cut -f1 $s)
		f=$d$Name
		[ ! -f $f ] && touch -f $f
done < $sourceFile

	exit

#if [ ! -z $d$Name ] ; then touch $d$Name ; fi
#[ ! -s $d$Name ] && touch $d$Name

