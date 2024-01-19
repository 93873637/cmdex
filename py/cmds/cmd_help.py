#!/usr/bin/env python
# -*- coding: utf-8 -*

import comdef
import utils.LogUtils as LogUtils

from cmd_obj import CmdObj
import cmd_mgr
import cmd_def as cmddef
import cmd_utils


class CmdHelp(CmdObj):
    def __init__(self):
        CmdObj.__init__(self)
        self.set_name(self.__class__.__name__[3:])
        self.add_cmd_keys(cmddef.CMD_KEY_HELP)
    # def __init__

    def exec(self, args):
        cmd_key = args[0]
        if cmd_key == 'help' or cmd_key == 'h':
            cmd_mgr.help(args)
        elif cmd_key == 'version' or cmd_key == 'ver' or cmd_key == 'v':
            cmd_mgr.version()
        elif cmd_key == 'home':
            cmd_utils.run_sys_cmd("echo ${CMDEX_HOME}")
        else:
            LogUtils.e().error("unknown cmd key '" + cmd_key + "'")
        return comdef.CMD_RET_PASS
# class CmdHelp


def get_obj():
    return CmdHelp()
