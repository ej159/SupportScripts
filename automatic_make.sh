# This script assumes it is run from the directory holding all github projects in parellel
# sh SupportScripts/automatic_make.sh

do_make() {
    if [ -d "$1" ]; then
        # Control will enter here if DIRECTORY exists.
        make -C $1 clean || exit $?
        make -C $1 || exit $?
        if [ $# == "install" ]; then
            make -C $1 install || exit $?
        fi
    fi
        
do_make spinnaker_tools
do_make spinn_common install
do_make SpiNNFrontEndCommon/c_common/ install
do_make sPyNNaker/neural_modelling/
do_make SpiNNakerGraphFrontEnd/spinnaker_graph_front_end/examples/
