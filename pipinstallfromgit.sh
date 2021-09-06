#!/bin/bash
# This script assumes it is run from the directory holding all github projects in parellel
# sh SupportScripts/gitupdate.sh a_branch_name


update(){
	cd $1 || return
	echo
	pwd
	if [ setup.py ]; then
	    sudo pip install -e .
	else
	    echo "No setup.py"
	fi
	cd ..
}

update SpiNNUtils
update SpiNNMachine
update SpiNNStorageHandlers
update SpiNNMan
update PACMAN
update DataSpecification
update SpiNNFrontEndCommon
update sPyNNaker
update sPyNNaker7
update sPyNNaker8
update sPyNNakerVisualisers
