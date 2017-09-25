#!/bin/bash

check_or_install() {
    if [ -d "$1" ]; then
        # Control will enter here if DIRECTORY exists.
        if [ -d "$1/.git" ]; then
            echo $1 already exists
        else
            echo Directory $1 exists but does not appear to be connected to git
            echo Unable to install $2 there
            exit
        fi
    else
        while true; do
            read -p "Do you wish to install $2 to $(pwd)/$1" yn
            case $yn in
                [Yy]* ) echo instaling $2;
                    git clone $2
                    echo installed $2 to $(pwd)/$1;
                    break;;
                [Nn]* ) echo Exiting script please rerun or install manually
                    exit;;
                * ) echo "Please answer yes or no.";;
            esac
        done
    fi
}

install_seven(){
    check_or_install sPyNNaker7 https://github.com/SpiNNakerManchester/sPyNNaker7.git ;
    check_or_install sPyNNaker7NewModelTemplate https://github.com/SpiNNakerManchester/sPyNNaker7NewModelTemplate.git
    check_or_install PyNN7Examples https://github.com/SpiNNakerManchester/PyNN7Examples.git
}

install_eight(){
    check_or_install sPyNNaker8 https://github.com/SpiNNakerManchester/sPyNNaker8.git ;
    check_or_install sPyNNaker8NewModelTemplate https://github.com/SpiNNakerManchester/sPyNNaker8NewModelTemplate.git
    check_or_install PyNN8Examples https://github.com/SpiNNakerManchester/PyNN8Examples.git
}

case $1 in
    *7 ) echo "Installing for PyNN7";
        break;;
    *8 ) echo "Installing for PyNN8";
        break;;
    man ) echo "Installing special manchester repositories";;
    all ) echo "Installing All the main repositories8";
        break;;
    * ) echo "Please specifiy if you wish to install for PyNN7, PyNN8, or all?  ";
        exit;;
esac

check_or_install spinnaker_tools https://github.com/SpiNNakerManchester/spinnaker_tools.git
check_or_install spinn_common https://github.com/SpiNNakerManchester/spinn_common.git
check_or_install SpiNNUtils https://github.com/SpiNNakerManchester/SpiNNUtils.git
check_or_install SpiNNMachine https://github.com/SpiNNakerManchester/SpiNNMachine.git
check_or_install SpiNNStorageHandlers https://github.com/SpiNNakerManchester/SpiNNStorageHandlers.git
check_or_install PACMAN https://github.com/SpiNNakerManchester/PACMAN.git
check_or_install SpiNNMan https://github.com/SpiNNakerManchester/SpiNNMan.git
check_or_install DataSpecification https://github.com/SpiNNakerManchester/DataSpecification.git
check_or_install SpiNNFrontEndCommon https://github.com/SpiNNakerManchester/SpiNNFrontEndCommon.git
check_or_install SpiNNakerGraphFrontEnd https://github.com/SpiNNakerManchester/SpiNNakerGraphFrontEnd.git
check_or_install sPyNNaker https://github.com/SpiNNakerManchester/sPyNNaker.git
check_or_install sPyNNakerExternalDevicesPlugin https://github.com/SpiNNakerManchester/sPyNNakerExternalDevicesPlugin.git
check_or_install sPyNNakerExtraModelsPlugin https://github.com/SpiNNakerManchester/sPyNNakerExtraModelsPlugin.git
check_or_install sPyNNakerVisualisers https://github.com/SpiNNakerManchester/sPyNNakerVisualisers.git
check_or_install IntroLab https://github.com/SpiNNakerManchester/IntroLab.git
check_or_install spalloc https://github.com/SpiNNakerManchester/spalloc.git

case $1 in
    *7 )g
        install_seven
        echo "Please insure your locally install PyNN is version 7"
        break;;
    *8 )
        install_eight
        echo "Please insure your locally install PyNN is version 8"
        break ;;
    man )
        install_seven
        install_eight
        check_or_install IntegrationTester https://github.com/SpiNNakerManchester/IntegrationTester.git
        check_or_install sphinx7 https://github.com/SpiNNakerManchester/sphinx7.git
        check_or_install sphinx8 https://github.com/SpiNNakerManchester/sphinx8.git ;
        check_or_install SupportScripts https://github.com/SpiNNakerManchester/SupportScripts.git
        check_or_install spalloc_server https://github.com/SpiNNakerManchester/spalloc_server.git
        check_or_install SpiNNakerManchester.github.io https://github.com/SpiNNakerManchester/SpiNNakerManchester.github.io.git
        check_or_install lab_answers https://github.com/SpiNNakerManchester/lab_answers.git
        echo "Warning you will need to use virtual machines or reinstall PyNN each time you switch Pynn version"
        break ;;
    all )
        install_seven
        install_eight
        echo "Warning you will need to use virtual machines or reinstall PyNN each time you switch Pynn version"
        break;;
    * ) echo "Please specifiy if you wish to install for PyNN7, PyNN8, or All. ";
        exit;;
esac


