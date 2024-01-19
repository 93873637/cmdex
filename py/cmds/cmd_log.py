#!/usr/bin/env python
# -*- coding: utf-8 -*

import comdef
import utils.LogUtils as LogUtils

from cmd_obj import CmdObj
import cmd_def


class CmdLog(CmdObj):
    def __init__(self):
        CmdObj.__init__(self)
        self.set_name(self.__class__.__name__[3:])
        self.add_cmd_keys(cmd_def.CMD_KEY_LOGLEVEL)
    # def __init__

    def exec(self, args):
        cmd_key = args[0]
        if cmd_key == 'loglevel' or cmd_key == 'll':
            LogUtils.print_log_levels()
            LogUtils.empty_line()
            self.exec_cmd_get_log_level()
        elif cmd_key == 'getloglevel' or cmd_key == 'gll':
            self.exec_cmd_get_log_level()
        elif cmd_key == 'setloglevel' or cmd_key == 'sll':
            self.exec_cmd_set_log_level(args)
        else:
            self.usage()
        return comdef.CMD_RET_PASS

    def exec_cmd_get_log_level(self):
        LogUtils.print_white_line("** current log level: " + LogUtils.get_level_str())

    def exec_cmd_set_log_level(self, args):
        if not self.check_param(args, 2):
            return
        LogUtils.set_log_level(args[1])
    # def exec_cmd_set_log_level
# class CmdLog


def get_obj():
    return CmdLog()
