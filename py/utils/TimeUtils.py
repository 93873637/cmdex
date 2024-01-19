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

##
# return time format string as hh:mm:ss.MMM
##


def format_time(time_ms):
    MMM = "%03d" % int(time_ms % 1000)
    ss = "%02d" % int(time_ms / 1000 % 60)
    mm = "%02d" % int(time_ms / (60*1000) % 60)
    hh = "%02d" % int(time_ms / (60*60*1000))
    return hh + ":" + mm + ":" + ss + "." + MMM
# format_time


if __name__ == '__main__':
    print("")
    print("main: E...")
    print("format time(12345)="+format_time(12345))
    print("format time(1234567)="+format_time(1234567))
    print("format time(12345678)="+format_time(12345678))
    print("main: X.")
    print("")
