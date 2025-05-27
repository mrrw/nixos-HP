#!/bin/bash
# ~/bin/mrrwnix.bash
# By Michael Milk (@mrrw.github), @2025, under GNU PUBLIC LICENSE.
set +x
	options='hrux'

Help()
{
	echo "   "
	echo "   USAGE: mrrwnix [-$options] "
	echo "   DESCRIPTION:  Update nixos."
	echo "   "
	echo "   OPTIONS:"
	echo "   "
	echo "    -h --help       |  Print this help and exit. "
	echo "    -r --rebuild    |  sudo nixos-rebuild switch --no-flake "
	echo "    -u --upgrade    |  sudo nixos-rebuild switch --no-flake --upgrade"
	echo "    -x --debug      |  Print script functions as they occur."
	echo "   "
}

# GET OPTIONS:
	while getopts ":$options" opt; do
		case ${opt} in
			h | --help)
				Help ; exit ;;
			r | --rebuild)
				sudo nixos-rebuild switch --no-flake
				exit ;;
			u | --upgrade)
				sudo nixos-rebuild switch --no-flake --upgrade
				exit ;;
			x | --debug)
				set -x ;
				shift ;;
			*)
				echo "Invalid option: -${OPTARG}." ;
				exit 1 ;;
		esac
	done

###  DEFAULT ACTION:
Help
