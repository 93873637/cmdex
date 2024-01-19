#!/bin/bash

if [ $# -eq 0 ];
then
    echo "Usage: "
    echo "$0 launch strings"
    exit
fi
LAUNCH_STR=$*
echo "LAUNCH_STR='$LAUNCH_STR'"

export GST_DEBUG=realsensesrc:6
echo "** GST_DEBUG=$GST_DEBUG"

# open and set dir to dump gstreamer dot file
export GST_DEBUG_DUMP_DOT_DIR=~/tmp/
echo "** GST_DEBUG_DUMP_DOT_DIR=$GST_DEBUG_DUMP_DOT_DIR"

# set realsensesrc plugin path
# set realsensesrc plugin path
ARCH=`arch`
if [ $ARCH =~ "x86_64" ];
then
    echo "  ARCH: x86_64"
elif [ $ARCH =~ "aarch64" ];
then
    echo "  ARCH: aarch64"
else
    echo "ERROR: unsupport arch: $ARCH"
    exit -1
fi
export GST_PLUGIN_PATH=/usr/lib/${ARCH}-linux-gnu/gstreamer-1.0/:/usr/local/lib/${ARCH}-linux-gnu/gstreamer-1.0/
echo "** GST_PLUGIN_PATH=$GST_PLUGIN_PATH"

gst-launch-1.0 -v -m $LAUNCH_STR
if [ $? -ne 0 ]; then
    echo "** test run failed."
    exit -1
fi

./dot_dir GST_DEBUG_DUMP_DOT_DIR

###########################################################################################

# # build&install realsensesrc
# # MESON=/data/user/ginger/meson.0.59.99/meson.py
# # $MESON . build
# /data/user/ginger/meson.0.59.99/meson.py . bulid
# sudo ninja -C build install

# export GST_DEBUG_DUMP_DOT_DIR=~/tmp
# export GST_PLUGIN_PATH=/usr/lib/x86_64-linux-gnu/gstreamer-1.0/:/usr/local/lib/x86_64-linux-gnu/gstreamer-1.0/:$GST_PLUGIN_PATH

# # test realsensesrc
# gst-launch-1.0 -v -m realsensesrc ! fakesink

# #gstreamer 1.0  v4l2 capture/display
# gst-launch-1.0 v4l2src device=/dev/video0  !  video/x-raw,width=1280,height=720,framerate=20/1  !  autovideosink

# # realsensesrc capture/display
# gst-launch-1.0 -v -m realsensesrc ! videoconvert ! autovideosink
# gst-launch-1.0 -v -m realsensesrc ! jpegenc ! jpegdec ! videoconvert ! autovideosink

# # send
# gst-launch-1.0 realsensesrc ! queue ! videoconvert! x264enc ! rtph264pay mtu=1300 name=pay0 pt=96 ! udpsink host=127.0.0.1 port=5600
# # recv
# gst-launch-1.0 udpsrc port=5600 caps='application/x-rtp, media=(string)video, clock-rate=(int)90000, encoding-name=(string)H264' ! rtph264depay ! avdec_h264 ! autovideosink sync=false
