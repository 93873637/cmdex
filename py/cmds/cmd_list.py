#!/usr/bin/env python
# -*- coding: utf-8 -*

import comdef
import utils.LogUtils as LogUtils
import utils.FileUtils as FileUtils

from cmd_obj import CmdObj
import cmd_mgr
import cmd_def as cmddef
import cmd_com
from cmd_com import COM_CMD
from cmd_com import CC_EMPTY_LINE_ID
import cmd_utils


class CmdList(CmdObj):
    def __init__(self):
        CmdObj.__init__(self)
        self.set_name(self.__class__.__name__[3:])
        self.add_cmd_keys(cmddef.CMD_KEY_LIST)
    # def __init__

    def exec(self, args):
        cmd_key = args[0]
        if cmd_key == 'list' or cmd_key == 'ls' or cmd_key == 'l':
            cmd_mgr.list()
        elif cmd_key == 'listshell' or cmd_key == 'sh':
            self.list_sh_files()
        elif cmd_key == 'comcmd' or cmd_key == 'cc':
            self.on_list_common_cmds(args)
        else:
            self.usage()
        return comdef.CMD_RET_PASS

    def list_sh_files(self):
        cmd_utils.run_sh_cmd("cxsh.sh")

    def on_list_common_cmds(self, args):
        if len(args) < 2:
            self.list_common_cmds()
        else:
            self.exec_common_cmd_args(args[1:])
    # def on_list_common_cmds(self, args)

    def list_common_cmds(self):
        LogUtils.printl("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        for cmd in COM_CMD:
            cmd_id = cmd[0]
            cmd_name = cmd[1]
            # LogUtils.i().info("cmd="+str(cmd))
            if cmd_id == CC_EMPTY_LINE_ID:
                LogUtils.empty_line()
            else:
                LogUtils.printl(str(cmd_id).rjust(4) + ": " + cmd_name)
        LogUtils.printl("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        LogUtils.prints("Please input cmd (<ID> [arg1] [arg2]...): ")
        input_str = input()
        LogUtils.empty_line()
        self.exec_common_cmd(input_str)
    # def list_common_cmds

    def exec_common_cmd(self, input_str):
        LogUtils.d().debug("input_str=" + input_str)
        input_str.strip()
        if len(input_str) == 0:
            LogUtils.d().debug("Input cmd empty")
        else:
            cmd_args = input_str.split(" ")
            self.exec_common_cmd_args(cmd_args)
    # def exec_common_cmd

    def exec_common_cmd_args(self, cmd_args):
        LogUtils.d().debug("cmd_args=" + str(cmd_args))

        # check input number
        try:
            cmd_id = int(cmd_args[0])
        except Exception as e:
            LogUtils.e().error(e)
            return
        cc = cmd_com.get_com_cmd_by_id(cmd_id)
        if cc is None:
            LogUtils.e().error("No common command found by id " + str(cmd_id))
            return

        # check and run cmd
        cmd_name = cc[1]
        cmd_str = cc[2]
        param_required = int(cc[3])
        if param_required == 0:
            cmd_utils.run_sys_cmd(cmd_str)
        else:
            cmd_params = cmd_args[1:]
            if len(cmd_params) < param_required:
                LogUtils.e().error("[" + cmd_name + "]: No enough params, require " + str(param_required) + " but " + str(len(cmd_params)))
            else:
                # replace %xa with param input
                for i, param in enumerate(cmd_params):
                    rep_sym = "%"+str(i+1)+"a"
                    # print("rep_sym=" + rep_sym)
                    # print("param=" + param)
                    cmd_str = cmd_str.replace(rep_sym, param)
                cmd_utils.run_sys_cmd(cmd_str)
    # def exec_common_cmd_args
# class CmdList


def get_obj():
    return CmdList()
