#!/bin/bash
# This script assumes it is run from the directory holding all github projects in parellel
# sh SupportScripts/gitupdate.sh a_branch_name

# checks a branch found locally
# May try to merge but exits on a conflict

update(){
	cd $1 || return
	echo
	pwd
	if [ -d .git ]; then
	    # update master
	    git fetch
	    git checkout -q master || exit -1
	    git pull
      	else
	    echo "Not a git repsoitory"
    	fi	    
	cd ..
	}

update SpiNNUtils
update SpiNNMachine
update SpiNNStorageHandlers
update SpiNNMan
update PACMAN
update spalloc
update DataSpecification
update SpiNNFrontEndCommon
update sPyNNaker
update sPyNNaker7
update sPyNNaker8
update sPyNNakerVisualisers
