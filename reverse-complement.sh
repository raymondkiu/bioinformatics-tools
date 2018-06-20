#!/bin/bash

#print the options
usage () {
  echo ""
  echo "This bash script can generate complement nucleotides in FASTA files"
  echo ""
  echo "Usage: $0 [options] FASTAFILE"
  echo "Option:"
  echo " -o output filename (default: FASTAFILE-complement.fasta)"
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

output=($1-complement.fasta)


while getopts ':o:hav' opt;
do
  case $opt in
    o) output=$OPTARG ;;
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
  echo " -o output filename (default: FASTAFILE-complement.fasta)"
  echo " -h print usage and exit"
  echo " -a print author and exit"
  echo " -v print version and exit"
  echo ""
  echo "Version 0.1"
  echo "Author: Raymond Kiu Raymond.Kiu@quadram.ac.uk"
  echo "";
exit 1
fi

cat $1| while read L; do echo $L; read L; echo "$L"|tr "ATGC" "TACG"|tr "atgc" "tacg";done > $output

#cat $complement > $output
exit 1;
