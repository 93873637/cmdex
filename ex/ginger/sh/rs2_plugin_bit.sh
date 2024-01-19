#!/bin/bash

# --------------------------------------------------------
if [ -z $GINGER_HOME ]; then
    echo "ERROR: GINGER_HOME not set"
    exit -1
fi
echo "** GINGER_HOME = $GINGER_HOME"
# --------------------------------------------------------

cd $GINGER_HOME/src/third_party/realsense_gstreamer_plugin
./bit.sh
