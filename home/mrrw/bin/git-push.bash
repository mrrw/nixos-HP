#!/bin/bash
#set -x

# By mrrw, @2025
f='/home /etc'

# To update the root repository, enter the following commands:
cd /
sudo git add $f
sudo git commit -a
sudo git push -u origin main

#This repository tracks my first foray into nixos.  This is my personal backup (in case I REALLY donk things up and can't rollback somehow).  It's also public, for ease of access to myself and anyone interested in peeking at my code.
