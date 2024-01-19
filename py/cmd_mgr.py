#!/usr/bin/env python
# -*- coding: utf-8 -*

import utils.LogUtils as LogUtils

import comdef
import cmd_def as cmddef
from cmd_key import CmdKey
import cmd_opt as cmdopt

##
# ADD CMD STEPS:
# 1: write a command class file, such as cmd_list.py
# 2. on file cmd_mgr.py:
#   2.1: import the command file
#   2.2: register the command object
##

# ADD CMD #2: import the command file
import cmds.cmd_log as cmd_log
import cmds.cmd_help as cmd_help
import cmds.cmd_map as cmd_map
import cmds.cmd_exit as cmd_exit
import cmds.cmd_list as cmd_list

# ------------------------------------------------------------------------------------
# CMD DICT&LIST DECL.

# cmd object list
cmd_obj_list = []

# the dict to map multiple keys to a obj
cmd_obj_dict = {}

cmd_key_dict = {}
cmd_hlp_dict = {}

cmd_key_list = []

# CMD DICT&LIST DECL.
# ------------------------------------------------------------------------------------


def add_cmd_key(keys, cmd_help):
    # print("keys num="+str(len(keys)))
    keys_str = None
    for key in keys:
        # print("get key '" + key + "'...")
        cmd_key_dict[key] = keys[0]
        if keys_str is None:
            keys_str = key
        else:
            keys_str += ", " + key

    usage_str = keys_str
    usage_str += "\n"
    usage_str += "--" + cmd_help
    # print("get cmd_help '" + usage_str + "'...")

    cmd_hlp_dict[keys[0]] = usage_str
    cmd_key_list.append(CmdKey(keys, cmd_help))
# def add_cmd_key


def cmd_keys_str(keys):
    keys_arr = []
    for key in keys:
        keys_arr.append(key)
    keys_str = None
    for key_str in keys_arr:
        if keys_str is None:
            keys_str = key_str
        else:
            keys_str += ", " + key_str
    return keys_str
# def cmd_key_str


def show_cmd_usage(cmd_key):
    usage_str = None
    try:
        usage_str = cmd_hlp_dict[cmd_key_dict[cmd_key]]
    except KeyError:
        usage_str = None
    if usage_str is not None:
        LogUtils.print_green_line("Usage:")
        LogUtils.print_green_line("[CMD KEY]: " + usage_str)
    else:
        LogUtils.d().debug("no usage found by cmd '" + cmd_key + "'")
# def usage


def usage(args):
    if len(args) == 0:
        LogUtils.d().debug("no args to show usage.")
    else:
        show_cmd_usage(args[0])
# def usage


def list_keys():
    for i, cmd_key in enumerate(cmd_key_list):
        LogUtils.printl(str(i+1).rjust(3) + ": " + cmd_key.list_keys())


def list_obj():
    for i, cmd_obj in enumerate(cmd_obj_list):
        LogUtils.printl(str(i+1).rjust(3) + ": " + cmd_obj.list_info())


def list():
    list_keys()


def help_cx():
    LogUtils.printl("# Options: ")
    LogUtils.printl("--------------------")
    cmdopt.list_options()
    LogUtils.empty_line()
    LogUtils.printl("# Command Keys: ")
    LogUtils.printl("--------------------")
    list_keys()
    LogUtils.empty_line()


def help(args):
    if len(args) > 1:
        show_cmd_usage(args[1])
    else:
        help_cx()


def version():
    LogUtils.printl("CMD Extensions v" + comdef.CMDEX_VERSION)


def find(cmd_key):
    return cmd_obj_dict.get(cmd_key, None)


def reg(cmd_obj):
    if len(cmd_obj.keys_) == 0:
        LogUtils.e().error("cmd name not available")
        return

    cmd_obj_list.append(cmd_obj)

    for key in cmd_obj.keys_:
        find_obj = cmd_obj_dict.get(key, None)
        if find_obj is not None:
            LogUtils.e().error("key '" + key + "' already registered by cmd '" +
                               find_obj.__class__.__name__ + "'")
        else:
            cmd_obj_dict[key] = cmd_obj


# ------------------------------------------------------------------------------------
# CMD DICT&LIST INIT

add_cmd_key(cmddef.CMD_KEY_HELP, cmddef.CMD_HLP_HELP)
add_cmd_key(cmddef.CMD_KEY_MAP, cmddef.CMD_HLP_MAP)
add_cmd_key(cmddef.CMD_KEY_LIST, cmddef.CMD_HLP_LIST)
add_cmd_key(cmddef.CMD_KEY_EXIT, cmddef.CMD_HLP_EXIT)
add_cmd_key(cmddef.CMD_KEY_LOGLEVEL, cmddef.CMD_HLP_LOGLEVEL)

# CMD DICT&LIST INIT
# ------------------------------------------------------------------------------------


# ADD CMD #3: register the command object
reg(cmd_help.get_obj())
reg(cmd_map.get_obj())
reg(cmd_list.get_obj())
reg(cmd_log.get_obj())
reg(cmd_exit.get_obj())

# ------------------------------------------------------------------------------------
# TEST/MAIN


def test_arg_key(test_key):
    print("")
    print("test_arg_key '" + test_key + "'...")
    args = []
    args.append(test_key)
    usage(args)
    print("")


def test_print_key(cmd_key):
    print("")
    print("test_print_key '" + str(cmd_key) + "'...")
    print(cmd_key)


def test_list_cmd_keys():
    print("")
    print("list...")
    list()


if __name__ == '__main__':
    print("main...")
    test_arg_key('facetracking')
    test_arg_key('ft')
    # test_arg_key('fts')
    test_print_key(cmd_key_list[2])
    test_list_cmd_keys()
