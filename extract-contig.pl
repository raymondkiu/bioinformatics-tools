#!/usr/bin/perl
 
use strict;
use warnings;
 
# Input parameters
my $scaffold_file = $ARGV[2];
my $type = $ARGV[0];
my $query = $ARGV[1];
 
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
===============================================================================================
Extracts contigs from a fasta file. Either a single sequence name is given, or a text file with 
a list of names (type must be given as input, either single contig or a list of desired contigs
================================================================================================
Usage: extract-contig.pl single|list contig_name|list SEQ.fasta > NEW-FILE.fasta
\nExample to extract a contig named contig1 from file SEQ.fasta: extract-contig.pl single contig1 SEQ.fasta > contig1.fasta
\n
A
 
exit;
}
