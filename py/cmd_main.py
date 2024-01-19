#!/usr/bin/env python
# -*- coding: utf-8 -*

import os
from os import path

import sys
import time

import utils.LogUtils as LogUtils
import utils.TimeUtils as TimeUtils

import comdef
import cmd_mgr
import cmd_opt


#
# exec cmd by args array
#
def exec_cmd_args(args):
    LogUtils.d().debug("args len=" + str(len(args)) + "...")
    for i in range(0, len(args)):
        LogUtils.d().debug("args[ " + str(i) + " ]=" + args[i])

    if len(args) == 0:
        return comdef.CMD_RET_PASS

    # filter out command options
    idx = 0
    cmd_args = []
    while idx < len(args):
        if not cmd_opt.check_opt(args, idx):
            cmd_args.append(args[idx])
        idx = idx + 1

    LogUtils.d().debug("cmd_args len = " + str(len(cmd_args)) + "...")
    for i in range(0, len(cmd_args)):
        LogUtils.d().debug("cmd_args[ " + str(i) + " ]=" + cmd_args[i])

    if len(cmd_args) == 0:
        if cmd_opt.show_help():
            cmd_mgr.help_cx()
        return comdef.CMD_RET_PASS

    cmd_key = cmd_args[0]
    LogUtils.d().debug("get cmd_key = " + cmd_key)

    cmd_obj = cmd_mgr.find(cmd_key)
    if cmd_obj is not None:
        if cmd_opt.show_help():
            cmd_mgr.show_cmd_usage(cmd_key)
            return comdef.CMD_RET_PASS
        if len(cmd_args) > 1 and cmd_args[1] in cmd_opt.OPT_HELP:
            cmd_mgr.show_cmd_usage(cmd_key)
        else:
            time_begin = time.time()
            ret = cmd_obj.exec(cmd_args)
            time_end = time.time()
            duration = int(round(time_end * 1000)) - int(round(time_begin * 1000))
            LogUtils.empty_line()
            LogUtils.d().debug("## exec cmd '" + cmd_key + "' over, time elapsed " + TimeUtils.format_time(duration))
            LogUtils.empty_line()
            return ret
    else:
        LogUtils.e().error("unsupported cmd '" + cmd_key + "'")
        return comdef.CMD_RET_PASS
# def exec_cmd_args


def exec_cmd_line(cmd_line):
    return exec_cmd_args(cmd_line.split())


def run_cmd_loop():
    cont_work = True
    while cont_work:
        LogUtils.prints(">> ")
        cmd_line = input()
        LogUtils.d().debug("get cmd line '" + cmd_line + "'")
        ret = exec_cmd_line(cmd_line)
        if ret == comdef.CMD_RET_ERROR:
            LogUtils.e().error("exec cmd failed, err = " + str(ret))
            cont_work = False
        elif ret == comdef.CMD_RET_EXIT:
            LogUtils.d().debug("exec cmd quit")
            cont_work = False
        else:
            # LogUtils.d().debug("exec cmd over")
            cont_work = True
# def run_cmd_loop


if __name__ == '__main__':
    LogUtils.d().debug("CMD Extensions v" + comdef.CMDEX_VERSION)
    LogUtils.empty_line()
    LogUtils.d().debug("[CMDEX]: E...")
    LogUtils.d().debug("argv len=" + str(len(sys.argv)))
    if len(sys.argv) > 1:
        exec_cmd_args(sys.argv[1:])
    else:
        run_cmd_loop()
    LogUtils.d().debug("[CMDEX]: X.")
