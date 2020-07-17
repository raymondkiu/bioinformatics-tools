#!/bin/bash

#print the options
usage () { 
  echo ""
  echo "This bash script extracts pair-wise SNP distance from a list using snp-dists csv output"
  echo "snp-dists output in molten csv format is needed"
  echo ""
  echo "Usage: $0 [options] LIST snp-dists-OUTPUT.csv"
  echo "Option:"
  echo " -h print usage and exit"
  echo " -a print author and exit"
  echo " -v print version and exit"
  echo ""
  echo "Version 1.0"
  echo "Author: Raymond Kiu Raymond.Kiu@quadram.ac.uk"
  echo "";
}
version () { echo "version 1.0 (2020)";}
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
SNPDIST=$2

awk -F "," 'NR==FNR { a[$1]=$0 ; next } $1 in a { print $0 }' $LIST $SNPDIST > $1-filtered 
awk -F "," 'NR==FNR { a[$1]=$0 ; next } $2 in a { print $0 }' $LIST $1-filtered > $1-COUNT

# Extract counts eliminating self comparison
awk -F "," '{ if ($1!~$2) print $1","$2","$3}' $1-COUNT

# Remove intermediary files
rm $1-filtered
rm $1-COUNT
