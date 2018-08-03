#!/bin/bash
# Raymond Kiu Raymond.Kiu@quadram.ac.uk
# a one-line script to print basename of files with same suffixes for various purposes.
for j in *.$1 ; do basename $j .$1 ;done |sed ':a;N;$!ba;s/\n/ /g'
