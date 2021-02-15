# This script assumes it is run from the directory holding all github projects in parallel
# bash SupportScripts/setup_install.sh a_branch_name

do_setup() {
    if [ -d $1 ]; then
        cd $1
        if [ -z "$VIRTUAL_ENV" ] && [ -z "$CONDA_PREFIX" ] && [ -z "$ASROOT" ]; then
            python setup.py install --user || exit $1
        else
            python setup.py install || exit $1
        fi
        cd ..
        echo "Finished setup of $1"
    fi
}

do_setup SpiNNUtils
do_setup SpiNNMachine
do_setup SpiNNMan
do_setup PACMAN
do_setup DataSpecification
do_setup spalloc
do_setup SpiNNFrontEndCommon
do_setup SpiNNakerGraphFrontEnd
do_setup sPyNNaker
do_setup sPyNNaker8
do_setup sPyNNakerVisualisers
