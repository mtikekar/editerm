#!/usr/bin/env python
"""Edit a file in the host nvim instance."""
# Setup: put this file on your $PATH with name vim
from __future__ import print_function
import os
import sys

addr = os.environ.get("NVIM_LISTEN_ADDRESS", None)
if not addr:
    sys.argv[0] = 'nvim'
    os.execvp('nvim', sys.argv)

from neovim import attach
import argparse

parser = argparse.ArgumentParser(description=__doc__, conflict_handler='resolve')
parser.add_argument('files', nargs='+', help='one or more files to edit')
group = parser.add_mutually_exclusive_group()
group.add_argument('-o', dest='mode', action='store_const', const='split', help='open in horizontally split windows') 
group.add_argument('-O', dest='mode', action='store_const', const='vsplit', help='open in vertically split windows')
group.add_argument('-p', dest='mode', action='store_const', const='-tabedit', help='open in separate tabs')
group.add_argument('-d', dest='mode', action='store_const', const='vert diffsplit', help='open in diff mode')
args = parser.parse_args()
if not args.mode:
    args.mode = 'edit'

def escape(s):
    return s.replace(' ', r'\ ')

nvim = attach("socket", path=addr)
nvim.input('<c-\\><c-n>')  # exit terminal mode
# first one is opened in new tab
nvim.command('cd ' + escape(os.getcwd()))

if len(args.files) > 1 or args.mode == 'edit':
    nvim.command('-tabedit ' + escape(args.files[0]))
    del args.files[0]

for f in args.files:
    nvim.command(args.mode + ' ' + escape(f))
