#!/usr/bin/perl
#
# extract-contig.pl
# =====================================================
# Extracts contig sequences from a fasta file. Either 
# a single sequence name is given, or a text file with 
# a list of names (type must be given as input, either
# "single" or "list" .
# =====================================================
# Usage: extractFromFasta.pl <sequence.fa> 
#				<single|list> <contig name|list>
#
# Example: extractFromFasta.pl mySeq.fa single contig4 > contig4.fa
 
use strict;
use warnings;
 
# Input parameters
my $scaffold_file = $ARGV[0];
my $type = $ARGV[1];
my $query = $ARGV[2];
 
# Save wanted fasta headers
my %list=();
if ($type eq "list") {
	open(IN, $query);
	while(<IN>) {
		chomp($_);
		$_=~s/>//;
		$list{$_} = 1;
	}
}
elsif($type eq "single") {
	$query=~s/>//;
	$list{$query}=1;
}
else {
	die &usage();
}
 
#Go through fasta file, extract sequences
open(IN, $scaffold_file);
my $seq = "";
my $flag = "off";
while(<IN>) {
	if($_ =~ m/^>/) {
 
		my $head = $_;
		chomp($head);
		$head=~s/>//;
 
		if(defined $list{$head}) {
			print $_;
			$flag = "on";
		}
		else {
			if($type eq "single" && $flag eq "on") {
				exit;
			}
			$flag = "off";
		}
	}
	else {
 
		if($flag eq "on") {
			print $_;
		}
	}
}
 
sub usage {
	print << "A";
\nextract-contig.pl
=====================================================
Extracts contigs from a fasta file. Either a
single sequence name is given, or a text file with 
a list of names (type must be given as input, either
 "single" or "list" without double quote
=====================================================
Usage: extractFromFasta.pl <seqfile.fa> <single|list> <contig name|list.txt>
\nExample: extractFromFasta.pl mySeq.fa single contig1 > contig1.fa\n
A
 
exit;
}
