#!/bin/bash
set +x

sourceFile=$HOME/lib/farmPlan/cropStart.txt
source=$HOME/lib/farmPlan/source.tmp.txt
awk NF $sourceFile > $source  # This removes those pesky empty lines.
d=$HOME/lib/farmPlan/lists/.crops/

while IFS= read -r line ; do
	touch tmp.txt
	echo "$line" > tmp.txt && s=tmp.txt
	name=$(cut -f 1 $s)
	string=$(cut -f 2 $s)
	f=$d$name
	touch $f
	echo -e "StartNote=\"$string\"" >> $f
done < $source
