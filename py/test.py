#!/usr/bin/env python
# -*- coding: utf-8 -*

import cmd_utils
import json
import utils.LogUtils as LogUtils

print("test begin...")


cmd_str = "rosservice call /robot_vision/ctrl \"data: 'info'\""
cmd_utils.run_cmd_view_rv_info(cmd_str)

# res = "{\"Mode\": \"Robot Vision Pipeline\", \"Device\": \"V4L2\", \"Frame Rate\": 30, \"\
#   Image Width\": 1280, \"Image Height\": 1280, \"Enable RGBD Stream\": 0, \"Enable\
#   \ Face Detect\": 1, \"Enable Face Tracking\": 1, \"Enable Person Detect\": 1, \"\
#   Enable Object Detect\": 0, \"Rtsp Connect Num\": 0}"
# res = "{\"Mode\": \"Robot Vision Pipeline\", \"Device\": \"V4L2\", \"Frame Rate\": 30, \"Image Width\": 1280, \"Image Height\": 1280, \"Enable RGBD Stream\": 0}"
# json_obj = json.loads(res)
# LogUtils.printl(json.dumps(json_obj, sort_keys=False, indent=2))

'''
CMD_KEY_LOGLEVEL = ('log',)
CMD_HLP_LOGLEVEL = 'set log level, require PARAM #1: d/i/w/e/c'

CMD_KEY_FACETRACKING = ('facetracking', 'ft')
CMD_HLP_FACETRACKING = 'enable/disable face tracking, require PARAM #1: on/off'


keys_ = []

def add_cmd_key(keys):
    for key in keys:
        keys_.append(key)

add_cmd_key(CMD_KEY_LOGLEVEL)
add_cmd_key(CMD_KEY_FACETRACKING)

print("names=" + str(keys_))

for name in keys_:
    print(name)

if 'log' in keys_:
    print("okkkkkkkkkkkkkkkk")
else:
    print("nooooooooooooo")

if 'ft' in CMD_KEY_FACETRACKING:
    print("okkkkkkkkkkkkkkkk222222222222222222")
else:
    print("nooooooooooooo22222222222222")
'''

'''
    # def __init__

    def exec(self, args):
        cmd_type = args[0]
        if cmd_type == 'facetracking' or cmd_type == 'ft':
            self.exec_cmd_facetracking(args)
        else:
            LogUtils.e().error("Unknown cmd type '" + cmd_type + "'")
        return comdef.CMD_RET_PASS
    # def exec

    def exec_cmd_facetracking(self, args):
        if not self.check_param(args, 2):
            return
        cmd_str = "rosservice call /robot_vision/enable_face_tracking"
        cmd_opt = args[1]
        if cmd_opt == 'on':
            cmd_str += " \"data: true\""
        elif cmd_opt == 'off':
            cmd_str += " \"data: false\""
        else:
            LogUtils.e().error("Unknown cmd opt '" + cmd_opt + "'")
            return
        cmd_utils.run_sys_cmd(cmd_str)
    # def exec_cmd_facetracking
# class MyTestCls
'''
