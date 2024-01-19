#!/usr/bin/env python
# -*- coding: utf-8 -*

import comdef

from cmd_obj import CmdObj
import cmd_mgr
import cmd_def as cmddef
import cmd_utils


class CmdMap(CmdObj):
    def __init__(self):
        CmdObj.__init__(self)
        self.set_name(self.__class__.__name__[3:])
        self.add_cmd_keys(cmddef.CMD_KEY_MAP)
        self.add_cmd_help(cmddef.CMD_HLP_MAP)
    # def __init__

    def exec(self, args):
        cmd_key = args[0]
        if cmd_key == 'map':
            self.usage()
        elif cmd_key == 'env':
            cmd_utils.run_sh_cmd("cx_env.sh")
        elif cmd_key == 'sync':
            cmd_utils.run_sh_cmd("sync_to_vendor.sh")
        elif cmd_key == 'clear':
            cmd_utils.run_sh_cmd("cx_clear.sh")
        else:
            self.usage()
        return comdef.CMD_RET_PASS
# class CmdMap


def get_obj():
    return CmdMap()
