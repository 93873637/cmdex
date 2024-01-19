#!/usr/bin/env python
# -*- coding: utf-8 -*

import utils.LogUtils as LogUtils

import cmd_mgr as cmdmgr

# -------------------------------------------------------------------------
#
# Option Items: [name, info]
#

OPT_LIST = []

OPT_HELP = ["--help", "-h"]
OPT_LIST.append([OPT_HELP, "If set, show help info."])

OPT_LOG_D = ["--debug", "-d"]
OPT_LIST.append([OPT_LOG_D, "If set, log level will be changed to debug."])

OPT_NO_EXEC = ["--no-exec", "-ne"]
OPT_LIST.append([OPT_NO_EXEC, "If set, only show command info without execute the command."])

# -------------------------------------------------------------------------

# -------------------------------------------------------------------------
# Option Global Variables

opt_val_help = False
opt_val_no_exec = False

# -------------------------------------------------------------------------


def check_opt(raw_args, idx):
    global opt_val_help
    global opt_val_no_exec
    opt = raw_args[idx]
    if opt in OPT_HELP:
        opt_val_help = True
        return True
    if opt in OPT_LOG_D:
        LogUtils.set_level_d()
        return True
    if opt in OPT_NO_EXEC:
        opt_val_no_exec = True
        LogUtils.d().debug("set opt_val_no_exec to " + str(opt_val_no_exec))
        return True
    return False


def show_help():
    global opt_val_help
    LogUtils.d().debug("opt_val_help=" + str(opt_val_help))
    return opt_val_help


def can_run_cmd():
    global opt_val_no_exec
    LogUtils.d().debug("opt_val_no_exec=" + str(opt_val_no_exec))
    return not opt_val_no_exec


def no_exec_cmd():
    global opt_val_no_exec
    LogUtils.d().debug("opt_val_no_exec=" + str(opt_val_no_exec))
    return opt_val_no_exec


def get_opt_info(opt):
    return str(opt[0]) + ": " + opt[1]


def list_options():
    global OPT_LIST
    for i, opt in enumerate(OPT_LIST):
        LogUtils.printl(get_opt_info(opt))
