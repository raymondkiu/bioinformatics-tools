#!/bin/bash
#Converting text to horizontal direction
# Author: Raymond Kiu Raymond.Kiu@quadram.ac.uk

IFS=''
while read line
do
   echo -n -e $line\
done < $1
echo -e \
