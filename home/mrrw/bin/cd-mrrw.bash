#!/bin/bash
# by mrrw @2025 under GPL
#
set +x
description="Enhanced cd command.  By mrrw."  
options="hx"

Help()
{
	echo ""
	echo "   USAGE:  cd [-$options] "
	echo "   DESCRIPTION:  $description"
	echo "   OPTIONS:"
	echo ""
	echo "    -h --help     |  Display this help"
	echo "    -x --debug    |  Show script as it executes."
	echo ""
}

# GET OPTIONS:
while getopts ":$options" opt; do
	case ${opt} in
		h | --help)
			Help ;
			exit ;;
		x | --debug)
			set -x ;;
		*)
			echo "Invalid option: -${OPTARG}." ;
			exit 1 ;;
	esac
done

### BUILD COMMANDS:
cd-default()
{
	alias cd="\cd"
}

cd-execute()
{
	cd-default
}

### EXECUTE CODE:
cd-execute

