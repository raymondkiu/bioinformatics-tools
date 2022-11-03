#!/bin/bash

#print the options
usage () {
  echo ""
  echo "This bash script extracts lines [FILE] if supplied with a list of specific field pattern [LIST] that matches the first column of FILE"
  echo "csv format is needed"
  echo ""
  echo "For example,"
  echo "FILE has a pattern of:"
  echo "Genome,Sample,Size"
  echo "AB,C90,12345"
  echo "CD,C92,12333"
  echo "DE,C93,12495"
  echo ""
  echo "And you only want data (lines) from Samples CD and DE"
  echo "So you supply a LIST of the following pattern:"
  echo ""
  echo "CD"
  echo "DE"
  echo ""
  echo "Usage: $0 [options] LIST FILE"
  echo "Option:"
  echo " -h print usage and exit"
  echo " -a print author and exit"
  echo " -v print version and exit"
  echo ""
  echo "Version 1.0"
  echo "Author: Raymond Kiu Raymond.Kiu@quadram.ac.uk"
  echo "";
}
version () { echo "version 1.0 (2022)";}
author () { echo "Author: Raymond Kiu Raymond.Kiu@quadram.ac.uk";}

if (($# == 0))
then
    echo "No positional arguments specified"
    exit 0
fi

while getopts 'hav' opt;do
  case $opt in
    h) usage; exit;;
    a) author; exit;;
    v) version; exit;;
    \?) echo "Invalid option: -$OPTARG" >&2; exit 1;;
    :) echo "Missing option argument for -$OPTARG" >&2; exit 1;;
    *) echo "Unimplemented option: -$OPTARG" >&2; exit 1;;

esac
done

LIST=$1
FILE=$2

awk -F "," 'NR==FNR { a[$1]=$0 ; next } $1 in a { print $0 }' $LIST $FILE

exit 0
