#!/bin/bash
# Raymond Kiu Raymond.Kiu@quadram.ac.uk
# one-line script to generate length for each contig in a multi-fasta sequence file
usage () {
  echo ""
  echo "This bash script generates sequence length for each contig in a multifasta file with contig ids"
  echo ""
  echo "Usage: $0 [options] multifasta.file"
  echo "Options:"
  echo " -h print usage and exit"
  echo " -a print author and exit"
  echo " -v print version and exit"
  echo ""
}
version () { echo "version 0.1";}
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

awk '$0 ~ ">" {print c; c=0;printf substr($0,2,100) "\t"; } $0 !~ ">" {c+=length($0);} END { print c; }' $fasta
