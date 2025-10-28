#!/bin/bash

sourceFile=$HOME/lib/farmPlan/lists/GermTemp.list
d=$HOME/lib/farmPlan/list/.crops/

x=2
while IFS= read -r line; do
		echo "$line"
	done < $sourceFile

Name=$(cut -f1 $s)
#if [ ! -z $d$Name ] ; then touch $d$Name ; fi
#[ ! -s $d$Name ] && touch $d$Name
echo "GermTempMin=$(cut -f2 $s)" >> $d$Name
echo "GermTempOptimumMin=$(cut -f3 $s)" >> $d$Name
echo "GermTempOptimumMax=$(cut -f4 $s)" >> $d$Name
echo "GermTempMax=$(cut -f5 $s)" >> $d$Name
echo "GermTempNote=$(cut -f6 $s)" >> $d$Name

