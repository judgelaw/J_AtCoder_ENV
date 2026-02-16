################################################
################################################
import io
import sys

_INPUT = """\

"""
sys.stdin = io.StringIO(_INPUT)
sys.stdin.buffer = io.BytesIO(_INPUT.encode('ascii'))
################################################
################################################

import sys
input = lambda: sys.stdin.readline().rstrip()

