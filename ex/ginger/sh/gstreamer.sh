#!/bin/bash

# gst.sh: gstreamer commands

echo "GST_PLUGIN_PATH=$GST_PLUGIN_PATH"
echo "GST_DEBUG_DUMP_DOT_DIR=$GST_DEBUG_DUMP_DOT_DIR"

export GST_PLUGIN_PATH=/usr/local/lib/x86_64-linux-gnu/gstreamer-1.0/   # x86
export GST_PLUGIN_PATH=/usr/local/lib/aarch64-linux-gnu/gstreamer-1.0/  # tx2

gst-inspect-1.0 | grep realsense

gst-launch-1.0 -v -m realsensesrc ! fakesink
gst-launch-1.0 -v -m realsensesrc ! videoconvert ! autovideosink
gst-launch-1.0 realsensesrc ! capsfilter ! tee ! queue ! appsink

for file in `ls $1`
do
    if [ -f "$1/$file" ]
    then
        if [[ $file == *.dot ]]
        then
            echo "get file: $file"
            dot -Tpng $file > $file.png
        fi
    fi
done
