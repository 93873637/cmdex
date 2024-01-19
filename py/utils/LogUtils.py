# !/usr/bin/env python
#  -*- coding: utf-8 -*

from __future__ import print_function

import os
import sys
import re
import inspect
import logging
from logging import handlers
from datetime import *
import time


# -----------------------------------------------------------------------------------
# color definitions

COLOR_NONE = "\033[0m"
COLOR_BLACK = "\033[0;30m"
COLOR_DARK_GRAY = "\033[1;30m"
COLOR_BLUE = "\033[0;34m"
COLOR_LIGHT_BLUE = "\033[1;34m"
COLOR_GREEN = "\033[0;32m"
COLOR_LIGHT_GREEN = "\033[1;32m"
COLOR_CYAN = "\033[0;36m"
COLOR_LIGHT_CYAN = "\033[1;36m"
COLOR_RED = "\033[0;31m"
COLOR_LIGHT_RED = "\033[1;31m"
COLOR_PURPLE = "\033[0;35m"
COLOR_LIGHT_PURPLE = "\033[1;35m"
COLOR_BROWN = "\033[0;33m"
COLOR_YELLOW = "\033[1;33m"
COLOR_LIGHT_GRAY = "\033[0;37m"
COLOR_WHITE = "\033[1;37m"

COLOR_END = "\033[0m"

#  "\033[0;32m---test---\033[0m"
# [%(levelname)-18s]

# color definitions
# -----------------------------------------------------------------------------------


#
# Log Level Names
#
LEVEL_NAME_DEBUG = "D"
LEVEL_NAME_INFO = "I"
LEVEL_NAME_WARNING = "W"
LEVEL_NAME_ERROR = "E"
LEVEL_NAME_CRITICAL = "C"

#
# Log Level Info
#
LEVEL_INFO_DEBUG = "Debug"
LEVEL_INFO_INFO = "Info"
LEVEL_INFO_WARNING = "Warning"
LEVEL_INFO_ERROR = "Error"
LEVEL_INFO_CRITICAL = "Critical"


# map of log level name
LEVEL_NAME = {
    logging.DEBUG: LEVEL_NAME_DEBUG,
    logging.INFO: LEVEL_NAME_INFO,
    logging.WARNING: LEVEL_NAME_WARNING,
    logging.ERROR: LEVEL_NAME_ERROR,
    logging.CRITICAL: LEVEL_NAME_CRITICAL,
}

# map of log level info
LEVEL_INFO = {
    logging.DEBUG: LEVEL_INFO_DEBUG,
    logging.INFO: LEVEL_INFO_INFO,
    logging.WARNING: LEVEL_INFO_WARNING,
    logging.ERROR: LEVEL_INFO_ERROR,
    logging.CRITICAL: LEVEL_INFO_CRITICAL,
}


def valid_level_name(level_name):
    return level_name == LEVEL_NAME_DEBUG \
        or level_name == LEVEL_NAME_INFO \
        or level_name == LEVEL_NAME_WARNING \
        or level_name == LEVEL_NAME_ERROR \
        or level_name == LEVEL_NAME_CRITICAL


class Logger(object):
    # map of log level
    level_relations = {
        LEVEL_NAME_DEBUG: logging.DEBUG,
        LEVEL_NAME_INFO: logging.INFO,
        LEVEL_NAME_WARNING: logging.WARNING,
        LEVEL_NAME_ERROR: logging.ERROR,
        LEVEL_NAME_CRITICAL: logging.CRITICAL
    }

    # map of log color
    color_map = {
        LEVEL_NAME_DEBUG: COLOR_GREEN,
        LEVEL_NAME_INFO: COLOR_WHITE,
        LEVEL_NAME_WARNING: COLOR_YELLOW,
        LEVEL_NAME_ERROR: COLOR_RED,
        LEVEL_NAME_CRITICAL: COLOR_BROWN
    }

    inst_ = None

    def inst():
        if Logger.inst_ is None:
            Logger.inst_ = Logger()
        return Logger.inst_

    def __init__(self, level_name=LEVEL_NAME_INFO):
        self.logger = logging.getLogger()

        # read and set log level from cfg file if exist
        # if ~/.cmdex not exist, a new file with default created
        if os.path.isfile("~/.cmdex"):
            level_cfg = os.popen("cat ~/.cmdex").read()
            level_cfg = level_cfg.replace("\r", "")
            level_cfg = level_cfg.replace("\n", "")
            # print("read level config: '" + level_cfg + "'")
            if valid_level_name(level_cfg):
                level_name = level_cfg
                # print("** update level to: '" + level_name + "'")
            else:
                self.set_level(level_name)
                # print("** set level by default: '" + level_name + "'")

        self.logger.setLevel(self.level_relations.get(level_name))
        self.sh = logging.StreamHandler()  # output to screen
        self.logger.addHandler(self.sh)  # add handler to logger
    # def __init__

    def get_level(self):
        return self.logger.getEffectiveLevel()

    def set_level(self, level_name):
        self.logger.setLevel(self.level_relations[level_name])
        os.system("echo " + level_name + " > ~/.cmdex")
        print_white_line("** set log level: " + str(self.level_relations[level_name]) + "(" + level_name + ")")

    def format(self, level_name):
        fmt = Logger.color_map[level_name] + '%(asctime)s ' + level_name + \
            ' %(filename)s:%(lineno)s %(funcName)s - %(message)s' + COLOR_END
        format_str = logging.Formatter(fmt)
        self.sh.setFormatter(format_str)  # format on screen
# class Logger


def d():
    Logger.inst().format(LEVEL_NAME_DEBUG)
    return Logger.inst().logger


def i():
    Logger.inst().format(LEVEL_NAME_INFO)
    return Logger.inst().logger


def w():
    Logger.inst().format(LEVEL_NAME_WARNING)
    return Logger.inst().logger


def e():
    Logger.inst().format(LEVEL_NAME_ERROR)
    return Logger.inst().logger


def c():
    Logger.inst().format(LEVEL_NAME_CRITICAL)
    return Logger.inst().logger


def get_level():
    return Logger.inst().get_level()


def get_level_str():
    return str(get_level()) + "(" + LEVEL_NAME[get_level()] + ")"


def set_level_d():
    Logger.inst().set_level(LEVEL_NAME_DEBUG)


def set_level_i():
    Logger.inst().set_level(LEVEL_NAME_INFO)


def set_level_w():
    Logger.inst().set_level(LEVEL_NAME_WARNING)


def set_level_e():
    Logger.inst().set_level(LEVEL_NAME_ERROR)


def set_level_c():
    Logger.inst().set_level(LEVEL_NAME_CRITICAL)


def set_log_level(level):
    if level.upper() == LEVEL_NAME_DEBUG or level == str(logging.DEBUG):
        set_level_d()
    elif level.upper() == LEVEL_NAME_INFO or level == str(logging.INFO):
        set_level_i()
    elif level.upper() == LEVEL_NAME_WARNING or level == str(logging.WARNING):
        set_level_w()
    elif level.upper() == LEVEL_NAME_ERROR or level == str(logging.ERROR):
        set_level_e()
    elif level.upper() == LEVEL_NAME_CRITICAL or level == str(logging.CRITICAL):
        set_level_c()
    else:
        e().error("Unknown log level '" + level + "'")


def get_var_name(p):
    # print(inspect.getframeinfo(inspect.currentframe().f_back.f_back))
    for line in inspect.getframeinfo(inspect.currentframe().f_back.f_back)[3]:
        # print("line=" + line)
        m = re.search(
            r'\bprint_var\s*\(\s*([A-Za-z_][A-Za-z0-9_]*)\s*\)', line)
        if m:
            return m.group(1)
# def get_var_name


def print_var(var):
    var_name = None
    for line in inspect.getframeinfo(inspect.currentframe().f_back)[3]:
        m = re.search(
            r'\bprint_var\s*\(\s*([A-Za-z_][A-Za-z0-9_]*)\s*\)', line)
        if m:
            var_name = m.group(1)
            break
    if var_name:
        print(var_name + " = " + str(var))
    else:
        print("WARNING: var name none.")
        print(str(var))
# def print_var


def printl(line_str):
    print(line_str)


def prints(str):
    print(str, end="")


def empty_line():
    printl("")


def get_color_str(str, color):
    return color + str + COLOR_END


def print_color_line(line_str, color):
    print(get_color_str(line_str, color))


def print_light_green_line(line_str):
    print(get_color_str(line_str, COLOR_LIGHT_GREEN))


def print_green_line(line_str):
    print(get_color_str(line_str, COLOR_GREEN))


def print_red_line(line_str):
    print(get_color_str(line_str, COLOR_RED))


def print_white_line(line_str):
    print(get_color_str(line_str, COLOR_WHITE))


def print_log_levels():
    for l in LEVEL_NAME:
        print(str(l) + ": " + LEVEL_NAME[l] + " - " + LEVEL_INFO[l])

# -------------------------------------------------------------
# Test
# -------------------------------------------------------------


def test_print_var():
    print("")
    print("test_print_var: E...")
    test_var_name0 = 100.0
    print_var(test_var_name0)
    test_var_name = 588
    print_var(test_var_name)
    spam2 = "faddef"
    print_var(spam2)
    spam3 = None
    print_var(spam3)
    spam44 = "中文顶顶顶顶aaaa"
    print_var(spam44)
    varset = set()
    varset.add("pppp")
    varset.add("pppp0")
    varset.add("pppp1")
    print_var(varset)
    print("test_print_var: X.")
    print("")
# def test_print_var


def test_log():
    print("")
    print("test_log: E...")
    d().debug('这是debug消息')
    i().info('这是info消息')
    w().warning('这是warning消息')
    e().error('这是error消息')
    c().critical('这是critical消息')
    print("test_log: X.")
    print("")
# def test_log


if __name__ == '__main__':
    print("")
    print("main: E...")
    # test_print_var()
    test_log()
    print("main: X.")
    print("")
