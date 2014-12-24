#! /usr/bin/env python

from __future__ import absolute_import
from __future__ import division
from __future__ import print_function
from __future__ import unicode_literals

import os
import walkup


index = 'filelist'
for root, dirs, files in walkup.walk_up(os.getcwd()):
    if index in files:
        with open(os.path.join(root, index), 'r') as f:
            for line in f:
                line = line.strip()
                print("%s\tedit %s" % (line, os.path.join(root, line)))
