#! /usr/bin/env python

import argparse
import subprocess

parser = argparse.ArgumentParser(
	description='This utility will call git status, followed by git add ., git commit the result with the message supplied by -m and finally push it all to the current upstream branch')
parser.add_argument('-m', required=True, help='The message to commit the changes with (not actually optional)')
args = parser.parse_args()

for command_args in [
	['status'],
	['add', '.'],
	['commit', '-m', args.m],
	['push']
]:
	print 'performing: ', ['git'] + command_args
	print subprocess.check_output(['git'] + command_args)
