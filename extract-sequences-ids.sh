#!/bin/bash

#print the options
usage () {
  echo ""
  echo "This bash script can extract sequences from multifasta files using sequence ids"
  echo ""
  echo "Usage: $0 [options] ids.file multifasta.file"
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

ids=$1
multifasta=$2

awk 'FNR==NR{a[$0];next} /^>/{val=$0;sub(/^>/,"",val);flag=val in a?1:0} flag' $ids $multifasta
