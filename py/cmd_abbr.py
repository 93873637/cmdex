#!/usr/bin/env python
# -*- coding: utf-8 -*


ABBR_MAP = {
}


def translate(str):
    str_map = ABBR_MAP.get(str)
    if str_map is None:
        return str
    else:
        return str_map
# def translate


def test_translate(str):
    print("translate(\"" + str + "\")=" + translate(str))
# def test_translate


if __name__ == '__main__':
    print("")
    print("main: E...")

    test_translate("aa")
    test_translate("rv")
    test_translate("hc")
    test_translate("robot_vision")

    print("main: X.")
    print("")
