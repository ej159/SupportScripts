# This script assumes it is run from the directory holding all github projects in parellel
# sh SupportScripts/automatic_make.sh

do_make() {
    if [ -d "$1" ]; then
        # Control will enter here if DIRECTORY exists.
        # Run setup.bash if it exists
        if [ -f "$1/setup.bash" ]; then
            cd $1
            source setup.bash
            cd -
        fi
        # Clean
        make -C $1 clean || exit $?
        # Clean installation; ignore error if install-clean doesn't work
        # (probably because there is no install clean for most targets)
        make -C $1 install-clean || true
        # Make
        make -C $1 $3 || exit $?
        # Install if needed
        if [ "$2" == "install" ]; then
            make -C $1 install || exit $?
        fi
    fi
}

cd spinnaker_tools && source ./setup && cd ..
do_make spinnaker_tools
do_make spinn_common install
do_make SpiNNFrontEndCommon/c_common/front_end_common_lib install FEC_DEBUG=DEBUG
do_make SpiNNFrontEndCommon/c_common/ install
cd sPyNNaker/neural_modelling && source ./setup.bash && cd ../..
do_make sPyNNaker/neural_modelling/ noinstall SPYNNAKER_DEBUG=DEBUG
do_make SpiNNakerGraphFrontEnd/spinnaker_graph_front_end/examples/
