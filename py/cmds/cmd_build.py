#!/usr/bin/env python
# -*- coding: utf-8 -*

import comdef
import utils.LogUtils as LogUtils
import utils.FileUtils as FileUtils

from cmd_obj import CmdObj
import cmd_def as cmddef
import cmd_utils
import cmd_abbr


class CmdBuild(CmdObj):
    def __init__(self):
        CmdObj.__init__(self)
        self.set_name(self.__class__.__name__[3:])
        self.add_cmd_keys(cmddef.CMD_KEY_BUILD)
        self.add_cmd_keys(cmddef.CMD_KEY_LAUNCH)        
    # def __init__

    def exec(self, args):
        if not self.check_param(args, 2):
            return comdef.CMD_RET_ERROR

        cmd_str = ""
        module_name = cmd_abbr.translate(args[1])
        if args[0] == 'build' or args[0] == 'bo' or args[0] == 'b':
            cmd_str = "bo.sh " + module_name
        elif args[0] == 'bol':
            cmd_str = "bol.sh " + module_name
        elif args[0] == 'bdl':
            cmd_str = "bdl.sh " + module_name
        elif args[0] == 'bl':
            cmd_str = "bl.sh " + module_name
        elif args[0] == 'bd':
            cmd_str = "bd.sh " + module_name
        elif args[0] == 'bio':
            cmd_str = "bio.sh " + module_name
        elif args[0] == 'bi':
            cmd_str = "bi.sh " + module_name
        elif args[0] == 'bir':
            cmd_str = "bir.sh " + module_name
        elif args[0] == 'launch' or args[0] == 'la':
            cmd_str = "l_" + module_name + ".sh"
        else:
            LogUtils.e().error("Unknown cmd '" + args[0])
            return comdef.CMD_RET_ERROR

        cmd_utils.run_sh_cmd(cmd_str)
        return comdef.CMD_RET_PASS
# class CmdBuild


def get_obj():
    return CmdBuild()
