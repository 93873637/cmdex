#!/usr/bin/env python
# -*- coding: utf-8 -*

import os
from os import path

import comdef
import utils.LogUtils as LogUtils
import utils.FileUtils as FileUtils

import comdef
import cmd_mgr as cmdmgr

class CmdObj(object):
    def __init__(self):
        self.name_ = "UNTITLED"
        self.help_ = "No help available."
        self.keys_ = []
    # def __init__

    def set_name(self, name):
        self.name_ = name

    def get_name(self):
        return self.name_
    
    def add_cmd_keys(self, keys):
        for key in keys:
            self.keys_.append(key)

    def add_cmd_help(self, help):
        self.help_ = help

    def exec(self, args):
        LogUtils.e().error("can't call base exec() directly")
        return comdef.CMD_RET_ERROR

    def list_keys(self):
        name_str = ""
        for i, name in enumerate(self.keys_):
            if i > 0:
                name_str += ", "
            name_str += name
        return name_str

    def list_info(self):
        return self.name_ + " - " + self.list_keys() 

    def usage(self):
        LogUtils.i().info(self.list_keys())
        LogUtils.printl(self.help_)
        
    def check_param(self, args, param_num_required):
        if len(args) < param_num_required:
            LogUtils.e().error("No enough params of cmd '" + args[0] +
                               "', require " + str(param_num_required) + " but " + str(len(args)))
            cmdmgr.usage(args)
            return False
        else:
            return True

    def check_param_more_than(self, args, param_num_required):
        if len(args) < param_num_required:
            LogUtils.e().error("No enough params of cmd '" + args[0] +
                               "', require at least " + str(param_num_required) + " but only " + str(len(args)))
            cmdmgr.usage(args)
            return False
        else:
            return True
# class CmdObj
