# This script assumes it is run from the directory holding all github projects in parallel
# bash SupportScripts/uninstall.sh

do_uninstall() {
    (pip uninstall -y $1 && echo "Uninstalled $1") || echo "$1 is not installed"
}

do_uninstall SpiNNUtils
do_uninstall SpiNNMachine
do_uninstall SpiNNMan
do_uninstall SpiNNaker_PACMAN
do_uninstall DataSpecification
do_uninstall spalloc
do_uninstall SpiNNFrontEndCommon
do_uninstall SpiNNakerGraphFrontEnd
do_uninstall sPyNNaker
do_uninstall sPyNNaker8
do_uninstall sPyNNakerVisualisers
