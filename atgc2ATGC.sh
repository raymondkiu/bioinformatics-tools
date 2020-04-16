#!/bin/bash
# Raymond Kiu Raymond.Kiu@quadram.ac.uk

#print the options
usage () {
  echo ""
  echo "This bash script converts atgc to ATGC  in FASTA files"
  echo ""
  echo "Usage: $0 [options] FASTAFILE"
  echo "Option:"
  echo " -o output filename (default: FASTAFILE.converted.fasta)"
  echo " -h print usage and exit"
  echo " -a print author and exit"
  echo " -v print version and exit"
  echo ""
  echo "Version 1.0"
  echo "Author: Raymond Kiu Raymond.Kiu@quadram.ac.uk (2020)"
  echo "";
}
version () { echo "version 1.0";}
author () { echo "Author: Raymond Kiu Raymond.Kiu@quadram.ac.uk";}

output=($1.converted.fasta)


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
  echo "This bash script converts atgc to ATGC in FASTA files"
  echo ""
  echo "Usage: $0 [options] FASTAFILE"
  echo "Option:"
  echo " -o output filename (default: FASTAFILE.converted.fasta)"
  echo " -h print usage and exit"
  echo " -a print author and exit"
  echo " -v print version and exit"
  echo ""
  echo "Version 1.0"
  echo "Author: Raymond Kiu Raymond.Kiu@quadram.ac.uk (2020)"
  echo "";
exit 1
fi


cat $1|awk 'BEGIN{FS=" "}{if(!/>/){print toupper($0)}else{print $1}}' > $output
exit 1;
