#!/bin/bash
# To rename file names by adding a prefix, can be used in a for loop
usage () {
  echo ""
  echo "This bash script renames files by adding a prefix"
  echo ""
  echo "Usage: $0 [options] NEWPREFIX filenames"
  echo ""
  echo "e.g. $0 ABC bin.*.fasta"
  echo ""
  echo "Options:"
  echo " -h print usage and exit"
  echo " -a print author and exit"
  echo " -v print version and exit"
  echo ""
}
version () { echo "version 1.0";}
author () { echo "Author: Raymond Kiu Raymond.Kiu@quadram.ac.uk";}

while getopts ':o:hav' opt;
do
  case $opt in
    h) usage; exit;;
    a) author; exit;;
    v) version; exit;;
    \?) echo "Invalid option: -$OPTARG" >&2; exit 1;;
    :) echo "Missing option argument for -$OPTARG" >&2; exit 1;;
    *) echo "Unimplemented option: -$OPTARG" >&2; exit 1;;

esac
done
prefix=$1
shift
for f in "$@"
do
  mv "$f" "$prefix$f"
done
