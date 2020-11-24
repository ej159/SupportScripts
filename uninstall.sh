# This script assumes it is run from the directory holding all github projects in parallel
# bash SupportScripts/uninstall.sh

do_uninstall() {
    if [ -d $1 ]; then
        cd $1
        if [ -z "$VIRTUAL_ENV" ] && [ -z "$CONDA_PREFIX" ] && [ -z "$ASROOT" ]; then
            python setup.py develop --uninstall || pip uninstall -y $2 || exit $1
        else
            python setup.py develop --uninstall --user || pip uninstall --user -y $2 || exit $1
        fi
        cd ..
        echo "Uninstalled $1"
    fi
}

do_uninstall SpiNNUtils
do_uninstall SpiNNMachine
do_uninstall SpiNNMan
do_uninstall SpiNNaker_PACMAN
do_uninstall SpiNNaker_DataSpecification
do_uninstall spalloc
do_uninstall SpiNNFrontEndCommon
do_uninstall SpiNNakerGraphFrontEnd
do_uninstall sPyNNaker
do_uninstall sPyNNaker8
do_uninstall sPyNNakerVisualisers
