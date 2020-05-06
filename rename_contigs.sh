#!/bin/bash
# Raymond Kiu Raymond.Kiu@quadram.ac.uk
usage () {
  echo ""
  echo "This bash script renames contigs in multi-fasta files"
  echo ""
  echo "Usage: $0 [options] multifasta.file PREFIX"
  echo ""
  echo "e.g. $0 abc.fasta ABC"
  echo ""
  echo ">ABC.1"
  echo "ATGCATGC"
  echo ">ABC.2"
  echo "AGGCCTTT"
  echo ">ABC.3"
  echo "ACCGGGTT"
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

fasta=$1
name=$2

awk ' \
    BEGIN { \
        contigIdx = 1; \
    } \
    { \
        if ($0 ~ /^>/) { \
            print ">'$name'."contigIdx; \
            contigIdx++; \
        } \
        else { \
            print $0; \
        } \
    }' $1
    
exit 0
