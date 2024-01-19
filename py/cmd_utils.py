#!/usr/bin/env python
# -*- coding: utf-8 -*

import os
import subprocess
import json

import utils.LogUtils as LogUtils
import utils.FileUtils as FileUtils

import cmd_opt


def run_sys_cmd(cmd_str):
    if cmd_opt.no_exec_cmd():
        LogUtils.printl(cmd_str)
        return
    LogUtils.printl("-------------------")
    LogUtils.printl(cmd_str)
    LogUtils.printl("-------------------")
    os.system(cmd_str)


def run_sh_cmd(cmd_str):
    cmd_str = "cd " + FileUtils.get_cur_dir() + "/../sh/ && ./" + cmd_str
    run_sys_cmd(cmd_str)


# '{"mode": "aaa", "fr": 1}'
def run_cmd_res(cmd_str):
    if cmd_opt.no_exec_cmd():
        LogUtils.printl(cmd_str)
        return
    LogUtils.printl("-------------------")
    LogUtils.printl(cmd_str)
    LogUtils.printl("-------------------")
    return os.popen(cmd_str).read()


#
# ~$ rosservice call /robot_vision/ctrl "data: 'info'"
# success: True
# message: "Version: 1.0.22.0301.1200, Mode: Robot Vision Pipeline, ros_log_level: 1, enable_debug:\
#   \ 1, ,Video Source: RS2, Frame Rate: 15, Image Width: 640, Image Height: 480, ,USD:\
#   \ 1, Face Detect: 1, Face Tracking: 0, Person Detect: 1, Object Detect: 1, RGBD\
#   \ Stream: 0, ,RTSP Connect: 0, rtsp_bit_rate: 524288, rtsp_iframeinterval: 30, ,publish_color_image:\
#   \ 1, publish_depth_image: 1, publish_face_detections: 1, publish_object_detections:\
#   \ 1, publish_face_image: 0, publish_osd_image: 1, publish_rgbd_image: 0, ,depth_image_normalize:\
#   \ 0, ,enable_default_motion: 1, "
#
def run_cmd_view_rv_info(cmd_str):
    res_raw = run_cmd_res(cmd_str)
    if res_raw is None:
        return
    # LogUtils.printl("-------------------")
    # LogUtils.printl(res_raw)
    # LogUtils.printl("-------------------")
    res = res_raw.replace("\\", "")
    res = res_raw.replace("\r", "")
    res = res_raw.replace("\n", "")
    # LogUtils.printl("-------------------")
    # LogUtils.printl(res)
    # LogUtils.printl("-------------------")
    KEY_RES = "success: "
    KEY_MSG = "message: "
    KEY_SUCCESS = "True"
    BOOL_KEYS = ["enable_debug", "start_ready", "Camera State",
                 "USD", "Face Detect", "Face Tracking", "Person Detect", "Object Detect", "RGBD Stream",
                 "RS2 Color Image", "RS2 Depth Image", "RS2 Color&Depth Image", "RS2 Depth Normalize",
                 "publish_color_image", "publish_depth_image", "publish_raw_image", "publish_face_detections", "publish_object_detections",
                 "support_ue4_report", "enable_ue4_report",
                 "IMU Stream", "Publish IMU Data",
                 "publish_face_image", "publish_osd_image", "publish_rgbd_image",
                 "depth_image_normalize",
                 "zero_mode", "open_head_pose_svc", "open_focus_gain_svc", "Focus Gain", "enable_default_motion"
                 ]
    GREEN_KEYS = ["true", "enable", "open"]
    res_begin = res.find(KEY_RES)
    res_end = res.find(KEY_MSG)
    success_or_not = res[res_begin:res_end]
    find_true = success_or_not.find(KEY_SUCCESS)
    if find_true == -1:
        return
    msg_begin = res.find(KEY_MSG) + len(KEY_MSG) + 1
    msg_end = len(res) - 3
    msg_str = res[msg_begin:msg_end]
    # LogUtils.printl("-------------------")
    # LogUtils.printl(msg_str)
    # LogUtils.printl("-------------------")
    info_arr = msg_str.split(",")
    LogUtils.empty_line()
    for info in info_arr:
        item_info = info.replace("\\  \\", "").strip()
        if item_info == '':
            LogUtils.empty_line()
        else:
            item_arr = item_info.split(':')
            if len(item_arr) < 2:
                LogUtils.printl(item_info)
            else:
                item_key = item_arr[0].strip()
                item_val = item_arr[1].strip()
                if item_key in BOOL_KEYS:
                    # first process item value
                    if item_val == "1":
                        item_val = "true"
                    if item_val == "0":
                        item_val = "false"

                    # show color by item value
                    if item_val.lower() in GREEN_KEYS:
                        LogUtils.print_light_green_line(item_key + ": " + item_val)
                    else:
                        LogUtils.print_red_line(item_key + ": " + item_val)
                else:
                    LogUtils.printl(item_info)
# def run_cmd_view_rv_info(cmd_str)


def run_cmd_ros_cfg(cmd_str):
    res = run_cmd_res(cmd_str)
    if res != '':
        json_str = res.replace('\'', '"')
        json_str = json_str.replace('True', '1')
        json_str = json_str.replace('False', '0')
        json_obj = json.loads(json_str)
        del json_obj["groups"]
        LogUtils.printl(json.dumps(json_obj, sort_keys=True, indent=2))


def source_sh_file(sh_file):
    LogUtils.printl("Please manually exec following cmd:")
    LogUtils.printl("-------------------")
    LogUtils.printl("source sh/" + sh_file)
    LogUtils.printl("-------------------")


def args_to_str(args):
    arg_str = None
    for arg in args:
        if arg_str is not None:
            arg_str += " " + arg
        else:
            arg_str = arg
    return arg_str


############################################################################################
############################################################################################


# # -*- coding: utf-8 -*-
# import json

# data= {
# "msg": {
#     "crc": 0,
#     "msg_body": "How are you ?",
#     "msg_len": 88,
#     "recv_id": 319371,
#     "send_id": 319371,
#     "send_time": 0,
#     "type": 96
#   },
# "msgLen":90
# }


# print json.dumps(data, sort_keys=True, indent=2) # 排序并且缩进两个字符输出

# import os


# 方法一：os.system()
# 返回值：返回对应状态码，且状态码只会有0(成功)、1、2。
# 其它说明：os.system()的返回值并不是执行程序的返回结果。而是一个16位的数，它的高位才是返回码。也就是说os.system()执行返回256即 0×0100，返回码应该是其高位0×01即1。所以要获取它的状态码的话，需要通过>>8移位获取。
# def adb_shell(cmd):
#     exit_code = os.system(cmd)
#     return exit_code>>8
#     # # os.system(cmd)命令会直接把结果输出，所以在不对状态码进行分析处理的情况下，一般直接调用即可
#     # os.system(cmd)


# # 方法二：os.popen()
# # 返回值：返回脚本命令输出的内容
# # 其它说明：os.popen()可以实现一个“管道”，从这个命令获取的值可以继续被调用。而os.system不同，它只是调用，调用完后自身退出，执行成功直接返回个0。
# def adb_shell(cmd):
#     result = os.popen(cmd).read()
#     return result


# # 方法三：subprocess.Popen()
# # 返回值：Popen类的构造函数，返回结果为subprocess.Popen对象，脚本命令的执行结果可以通过stdout.read()获取。
# def adb_shell(cmd):
#     # 执行cmd命令，如果成功，返回(0, 'xxx')；如果失败，返回(1, 'xxx')
#     res = subprocess.Popen(cmd, shell=True, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE) # 使用管道
#     result = res.stdout.read()  # 获取输出结果
#     res.wait()  # 等待命令执行完成
#     res.stdout.close() # 关闭标准输出
#     return result


# # 方法四：subprocess.getstatusoutput()
# # 返回值：返回是一个元组，如果成功，返回(0, 'xxx')；如果失败，返回(1, 'xxx')
# def adb_shell(cmd):
#     result = subprocess.getstatusoutput(cmd)
#     return result


# cmd = 'adb shell dumpsys activity | grep "Run #"'
# print(adb_shell(cmd))
