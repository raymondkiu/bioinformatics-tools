# informatics-tools
Some small and simple scripts useful for various bioinformatics purposes. 

## 1. extract-contigs.pl
This convenient Perl script is able to extract contigs of FASTA files either by contig name or a list of contig names.
```
$ extract-contigs.pl single CONTIGNAME FASTAFILE
```
or with a list of contigs
```
$ extract-contigs.pl list LISTNAME FASTAFILE
```
To save into a new file, use ">" sign
```
$ extract-contigs.pl list LISTNAME FASTAFILE > NEW_FILENAME
```
## 2. ver-horizontal.sh
This Bash script converts a list to horizontal view on the standard output for various automation purposes.
```
$ ver-horizontal.sh LIST
```
For instance, a file named LIST
```
hello
world
happy
```
will be converted to 
```
hello world happy
```
## 3. assembly-stats.pl
This Perl script gives you general assembly statistics including contig number, genome size, largest contig (bases), GC content, N count and gap count. It takes the inputs of FASTA assemblies.
```
$ assembly-stats.pl FASTAFILE
```
It generates data on standard output as follows:
```
Sample_ID  Genome  Contigs Mean    Median  N50     Largest GC(%)   N_count N(%)    Gap_count
test.fasta 158     2       79      89      89      89      5.95    26      16.46   4
```
**Output explanations**
* Genome: Genome size
* Contigs: Number of contigs in the fasta file
* Mean: Average size of contigs in bases
* Median: Size of median contig
* N50: Yardstick of assembly quality - 50% of the contigs are larger than this size (in nucleotide bases) 
* Largest: Size (nucleotide bases) of largest contigs
* GC(%): GC (guanine and cytosine) content of the genome
* N_count: Number of N found in the genome (uncertain base calling)
* N(%): N count in percentage
* Gap_count: count "-" in the fasta file, usually appears in alignment file

## 4. reverse-complement.sh
This Bash script generates reverse complement for nucleotide FASTA files. That is, A -> T, G -> C and vice versa.
```
$ reverse-complement.sh -o OUTPUT_FILENAME FASTAFILE
```
Option -o can be omitted, the default output filename is FASTAFILE-complement.fasta

## 5. basename_dir.sh
This one-line bash script is able to extract the basenames of files with same suffixes for various purposes.
If a directory has 3 files with suffixes .fasta namely ABC.fasta, CDE.fasta and EFG.fasta, usage is below:
```
$ basename_dir.sh .fasta
```
It will print on standard output:
```
$ ABC CDE EFG
```

## 6. extract-sequences-ids.sh
This Bash script is superquick at extracting sequences (or, contigs if you like) from multifasta files using an external file of ids list and display on the standard output.
```
$ extract-sequences-ids.sh ids multifasta
```
You can do the below for usage options:
```
$ extract-sequences-ids.sh -h

This bash script can extract sequences from multifasta files using sequence ids

Usage: extract-sequences-ids.sh [options] ids.file multifasta.file
Options:
 -h print usage and exit
 -a print author and exit
 -v print version and exit
 
```
You will see something like this on the standard output:
```
>ABC123
ATGATAAGATTTAAGAAAACAAAATTAATAGCAAGTATTGCAATGGCTTTATGTCTGTTT
TCTCAACCAGTAATCAGTTTCTCAAAGGATATAACAGATAAAAATCAAAGTATTGATTCT
GGAATATCAAGCTTAAGTTACAATAGAAATGAAGTTTTAGCTAGTAATGGAGATAAAATT
GAAAGTTTTGTTCCAAAGGAAGGTAAAAAGACTGGTAATAAATTTATAGTTGTAGAACGT
CAAAAAAGATCCCTTACAACATCACCAGTAGATATATCAATAATTGATTCTGTAAATGAC
```
To generate the ids file, use vim editor and create any file name e.g. ids and enter the sequence ids line by line
```
ABC123
DMF123
dlfppt
```
## 7. contigs-ids-length.sh
This script estimates the length of each contig in a multi-fasta file.

##	8. filter-contig.pl
This script filters genome assembly by specifying minimum contig length.
For example, too filter out contigs with <500 bp,
```
$ filter-contig.pl 500 fasta
```

##	9. atgc2ATGC.sh
This bash script converts atgc to ATGC using AWK - super fast, >300MB fasta file in under 15 seconds.

## 10. rename_contigs.sh
This script renames contigs in multi-fasta files.
```
$ rename_contigs.sh fasta PREFIX
```
For example (123.fasta is your fasta file, ABC is the prefix you want to use for renaming your contigs)
```
$ rename_contigs.sh 123.fasta ABC
>ABC.1
ATGCATGC
>ABC.2
AGGTCTCT
>ABC.3
AGGGCCGT
```
So use > to save into new fasta file, e.g.
```
$ rename_contigs.sh 123.fasta ABC > ABC.fna
```
