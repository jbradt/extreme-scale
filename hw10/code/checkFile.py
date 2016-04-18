#!/usr/bin/env python3

import numpy as np
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('filename', help='File to check')
args = parser.parse_args()

a = np.fromfile(args.filename)

if np.all(a == np.sort(a)) and np.all(np.diff(a) == 1.0):
    print('OK')

else:
    print('Not ok')
