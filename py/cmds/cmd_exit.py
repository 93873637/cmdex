#!/usr/bin/env python
# -*- coding: utf-8 -*

import comdef
from cmd_obj import CmdObj
import cmd_def as cmddef


class CmdExit(CmdObj):
    def __init__(self):
        CmdObj.__init__(self)
        self.set_name(self.__class__.__name__[3:])
        self.add_cmd_keys(cmddef.CMD_KEY_EXIT)
    # def __init__

    def exec(self, args):
        return comdef.CMD_RET_EXIT
# class CmdExit


def get_obj():
    return CmdExit()
