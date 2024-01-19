#!/bin/bash

export GST_DEBUG_DUMP_DOT_DIR=~/tmp
export GST_PLUGIN_PATH=/usr/lib/x86_64-linux-gnu/gstreamer-1.0/:/usr/local/lib/x86_64-linux-gnu/gstreamer-1.0/:$GST_PLUGIN_PATH

gst-inspect-1.0 > gst-inspect-1.0.txt

##
# play v4l2 device video
##
# gst-launch-1.0 v4l2src device=/dev/video0 ! jpegdec ! video/x-raw,width=1280,height=720,framerate=20/1,format=I420 ! autovideosink

##
# send/recv rtp video stream by udp on localhost
##
# send
# gst-launch-1.0 v4l2src device=/dev/video0 ! jpegdec ! video/x-raw,width=1280,height=720,framerate=20/1,format=I420 ! x264enc ! rtph264pay mtu=1300 name=pay0 pt=96 ! udpsink host=127.0.0.1 port=5600
# recv
# gst-launch-1.0 udpsrc port=5600 caps='application/x-rtp, media=(string)video, clock-rate=(int)90000, encoding-name=(string)H264' ! rtph264depay ! avdec_h264 ! autovideosink sync=false


# ./test-readme
# ./test-launch  --gst-debug=3 "( v4l2src ! video/x-raw,width=640,height=480 ! omxh264enc ! h264parse ! rtph264pay name=pay0 pt=96 )"

# ! udpsink host=127.0.0.1 port=5600

# "( appsrc name=rtsp-src is-live=true do-timestamp=true format=3 ! "
#            "jpegdec ! video/x-raw,format=I420 ! videoconvert ! "
#            "capsfilter name=filter ! x264enc name=h264enc ! rtph264pay mtu=1300 "
#            "name=pay0 pt=96 )"