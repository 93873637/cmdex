# !/usr/bin/env python
#  -*- coding: utf-8 -*

import os
from os import path


def get_cur_dir():
    d = path.dirname(__file__)
    d = os.path.dirname(d)
    abspath = path.abspath(d)
    return abspath
# def get_cur_dir
