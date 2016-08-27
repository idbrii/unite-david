#! /usr/bin/env python

from __future__ import absolute_import
from __future__ import division
from __future__ import print_function
from __future__ import unicode_literals

import os

import walkup


index = 'filelist'
for root, dirs, files in walkup.walk_up(os.getcwd()):
    print (root)
    if index in files:
        with open(os.path.join(root, index), 'r') as f:
            print(f.read())
