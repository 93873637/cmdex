#!/usr/bin/env python
# -*- coding: utf-8 -*

#
# Command Definitions
#

CMD_KEY_HELP = ('help', 'h', 'version', 'ver', 'v', 'home')
CMD_HLP_HELP = '''
show cmdex info, cmd list or cmd info, etc.
*        help/h --- show show cmd help info if PARAM #1 given, or show cmd list
* version/ver/v --- show cmdex version info
*          home --- show home directory of cmdex scripts 
'''


CMD_KEY_MAP = ('map', 'env', 'sync', 'clear')
CMD_HLP_MAP = '''
map cmd name to its shell file, including:
    env --- cx_env.sh
   sync --- sync_to_vendor.sh
  clear --- cx_clear.sh
'''


CMD_KEY_LIST = ('list', 'ls', 'l', 'listshell', 'sh', 'comcmd', 'cc')
CMD_HLP_LIST = '''
list cmds info, including:
* list/ls/l ------- list cmd keys
* listshell/sh ---- list shell files of sh dir
* comcmd/cc ------- list common used commands and choose to exec
'''


CMD_KEY_EXIT = ('exit', 'quit', 'q')
CMD_HLP_EXIT = '''exit cmd loop'''


CMD_KEY_LOGLEVEL = ('loglevel', 'll', 'getloglevel',
                    'gll', 'setloglevel', 'sll')
CMD_HLP_LOGLEVEL = '''
--get/set cmd log level:
* loglevel/ll/getloglevel/gll: get log level
* setloglevel/sll: set log level, require PARAM #1: d/i/w/e/c
--for example:
cx ll
cx sll d
'''
