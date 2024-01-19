#!/bin/bash

# ginger@pisces:~$ rosservice call /ginger/robot_vision/set "header:
#   seq: 0
#   stamp:
#     secs: 0
#     nsecs: 0
#   frame_id: ''
# values:
# - key: 'Pub Color Depth'
#   value: '0'"

rosservice call /ginger/robot_vision/set "header:
  seq: 0
  stamp:
    secs: 0
    nsecs: 0
  frame_id: ''
values:
- key: 'Pub Color Depth'
value: '0'"

# it not work?
# rosservice call /ginger/robot_vision/set "header: {seq: 0, stamp: {secs: 0, nsecs: 0}, frame_id: ''} \n values: [{key: 'Pub Color Depth', value: '1'}]"
