
#!/usr/bin/perl -w

use strict;
use warnings;

# Set path to input HTML files
my $inpath="B:\\Research\\Projects\\Incarceration\\Michigan\\html";

# Open data file
my $outpath="B:\\Research\\Projects\\Incarceration\\Michigan\\test";
open (OUTFILE_DATA, ">$outpath\\michigan_offendernumbers.txt") or die "Can't open subjects file: michigan_offendernumbers.txt";
print OUTFILE_DATA "offnum\n";

my $startfile=97495; my $endfile=100000;

my $recordnum=0;
my $pct;
for (my $pageindex=$startfile; $pageindex<=$endfile; $pageindex++) {

  $recordnum++;
  $pct=$recordnum/($endfile-$startfile);
  print "$pageindex   ($startfile to $endfile)--------$pct\n";

  # Add leading zeros to numbers.
  # http://www.perlmonks.org/?node_id=201244
  my $shortnum = $pageindex; my $len = 6; my $paddednum = sprintf ("%0${len}d", $shortnum ); my $offnum="$paddednum";

  # Test if file exists. If it does, add the offender number to the data file. If not, just skip it.
  if (-e "$inpath\\michigan_html_$offnum.txt") { print OUTFILE_DATA "$offnum\n" }
}

