#!/bin/bash

usage () {
  echo ""
  echo "This script runs Kallisto for multiple FASTQ files (RNAseq)"
  echo ""
  echo "Usage: $0 [options] lib.txt r1.txt r2.txt outputPath refPath"
  echo ""
  echo ""
  echo "lib.txt         txt file with a list of filenames for new directory e.g ABC12 (same working directory)"
  echo "r1.txt          a list of forward fastq reads, e.g. ABC12_1.fastq (same working directory)"
  echo "r2.txt          a list of reverse fastq reads, e.g. ABC12_2.fastq (same working directory)"
  echo "outputPath      Path for directory outputs, e.g. home/fastq/Kallisto/"
  echo "refPath         Path for Kallisto index files for alignment"
  echo ""
  echo "Options:"
  echo " -h print usage and exit"
  echo " -a print author and exit"
  echo " -v print version and exit"
  echo ""
}
version () { echo "version 1.0";}
author () { echo ""
echo "Author: Shabhonam Caim and Raymond Kiu (2019)"
echo "";}

while getopts ":o:hav" OPTION;
do
  case $OPTION in
    h) usage; exit;;
    a) author; exit;;
    v) version; exit;;
    \?) echo "Invalid option $OPTARG" >&2; exit 1;;
    :) echo "Missing option argument $OPTARG" >&2; exit 1;;
    *) echo "Unimplemented option $OPTARG" >&2; exit 1;;

esac
done

echo ""
echo "Usage: $0 [options] lib.txt r1.txt r2.txt outputPath refPath"
echo ""
echo "Options:"
echo " -h print detailed usage and exit"
echo " -a print authors and exit"
echo " -v print version and exit"
echo ""
echo "Press CTRL-C now to abort"
echo "........................."
sleep 2s
echo "........................."
sleep 2s
echo "........................."


libList=$1
r1PathList=$2
r2PathList=$3
outputPath=$4
refPath=$5

r1Param="";
r2Param="";
paramSep=",";

for lib in `cat ${libList}`
do
  mkdir ${outputPath}/${lib}

  r1Param="";
  r2Param="";

  for r1Path in `cat ${r1PathList} | grep "${lib}" | grep "_1.fastq"`
  do
        r1Param=$r1Param$paramSep$r1Path
  done

  r1Param=${r1Param#","}
  r1Param=${r1Param%","}

  for r2Path in `cat ${r2PathList} | grep "${lib}" | grep "_2.fastq"`
  do
        r2Param=$r2Param$paramSep$r2Path
  done

  r2Param=${r2Param#","}
  r2Param=${r2Param%","}

  #echo ${r1Param}
  #echo ${r2Param}

 sbatch --wrap "/usr/bin/time -v  kallisto quant -i ${refPath}  -o ${outputPath}/${lib}/ -b 100 ${r1Param} ${r2Param} -t 6" -c 6 -N 1 -e slurm_kallisto_${lib}.err -o slurm_kallisto_${lib}.out --mem=20G -J kallisto -p nbi-medium

done
