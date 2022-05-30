#!/bin/bash

#print the options
usage () {
  echo ""
  echo "This bash script can generate complement nucleotides in FASTA files - does not work on multi-fasta"
  echo ""
  echo "Usage: $0 [options] FASTAFILE > NEWFILENAME"
  echo "Option:"
  echo " -h print usage and exit"
  echo " -a print author and exit"
  echo " -v print version and exit"
  echo ""
  echo "Version 1.0"
  echo "Author: Raymond Kiu Raymond.Kiu@quadram.ac.uk"
  echo "";
}
version () { echo "version 1.0";}
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
  echo "Usage: $0 [options] FASTAFILE > NEWFILENAME"
  echo "Option:"
  echo " -h print usage and exit"
  echo " -a print author and exit"
  echo " -v print version and exit"
  echo ""
  echo "Version 1.0
  echo "Author: Raymond Kiu Raymond.Kiu@quadram.ac.uk"
  echo "";
exit 1
fi

#cat $1|grep "^[ATGCatgc]" |tr ACGTacgt TGCAtgca | rev
#cat $1 | while read L; do echo $L; read L; echo "$L" | tr "ATGC" "TACG"|tr "atgc" "tacg"|rev ; done
awk 'BEGIN{RS=">";FS="\n";a["T"]="A";a["A"]="T";a["C"]="G";a["G"]="C";a["N"]="N"}NR>1{for (i=2;i<=NF;i++) seq=seq""$i;for(i=length(seq);i!=0;i--) {k=substr(seq,i,1);x=x a[k]}; printf ">%s\n%s\n",$1,x}' $1
#cat $complement > $output

exit 1;
