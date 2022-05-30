#!/bin/bash

#print the options
usage () {
  echo ""
  echo "This bash script can generate complement nucleotides in FASTA files"
  echo ""
  echo "Usage: $0 [options] FASTAFILE"
  echo "Option:"
  echo " -h print usage and exit"
  echo " -a print author and exit"
  echo " -v print version and exit"
  echo ""
  echo "Version 0.1"
  echo "Author: Raymond Kiu Raymond.Kiu@quadram.ac.uk"
  echo "";
}
version () { echo "version 0.1";}
author () { echo "Author: Raymond Kiu Raymond.Kiu@quadram.ac.uk";}



while getopts ':hav' opt;
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

# skip over the processed options
shift $((OPTIND-1))

#check for mandatory positional parameters
if [ $# -lt 1 ]; then
  echo ""
  echo "This bash script can generate complement nucleotides in FASTA files"
  echo ""
  echo "Usage: $0 [options] FASTAFILE"
  echo "Option:"
  echo " -h print usage and exit"
  echo " -a print author and exit"
  echo " -v print version and exit"
  echo ""
  echo "Version 0.1"
  echo "Author: Raymond Kiu Raymond.Kiu@quadram.ac.uk"
  echo "";
exit 1
fi

cat $1|tr ACGTacgt TGCAtgca | rev

#cat $complement > $output
exit 1;

