#!/usr/bin/env python
# -*- coding: utf-8 -*


class CmdKey(object):
    def __init__(self, keys, help):
        self.keys_ = keys
        self.help_ = help
    # def __init__

    def list_keys(self):
        key_str = ""
        for i, key in enumerate(self.keys_):
            if i > 0:
                key_str += ", "
            key_str += key
        return key_str
# class CmdKey
