#!/usr/bin/env python
# -*- coding: utf-8 -*

#
# Common Command Names
#

CC_CMDEX_ENV = "CMDEX Environments"

CC_EMPTY_LINE_ID = -1
CC_EMPTY_LINE = [CC_EMPTY_LINE_ID, "Show a empty line", "", 0]

#
# Common Commands
#
# Format As:
# [
#   ...
#   [cmd_id, cmd_name, cmd_str, parameter_number],
#   CC_EMPTY_LINE,
#   ...
# ]
#
# cmd_str: symbol %1a, %2a...%Na in cmd_str are the parameter places to replace
#

COM_CMD = [
    [1, CC_CMDEX_ENV, "cx_env.sh", 0],
    CC_EMPTY_LINE,

    # @EX: ginger commands
    # @todo: move to ginger python and register to cmdex
    [400, "Ginger - View Battery State", "rostopic echo /BatteryState | grep dump", 0],
    [401, "Ginger - Move Chassis", "roslaunch chassis_teleoperation teleop_twist_keyboard.launch only_omni_wheels:=true", 0],
    [402, "Ginger - Zero Pose", "rostopic pub -1 /ginger/robot_animation/motion_cmd ginger_msgs/ActionCommand \"header: \n  seq: 0\n  stamp:\n    secs: 0\n    nsecs: 0\n  frame_id: ''\naction: 0\naction_name: ''\ncommand: 2\"", 0],
    CC_EMPTY_LINE,
]

def get_com_cmd_by_id(cmd_id):
    for cmd in COM_CMD:
        if cmd[0] == cmd_id:
            return cmd
    return None
