
#!/usr/bin/perl -w

use strict;
use warnings;

# Set path to input HTML files
my $inpath="B:\\Research\\Projects\\Incarceration\\Ohio\\html";

# Open data file
my $outpath="B:\\Research\\Projects\\Incarceration\\Ohio\\test";
open (OUTFILE_DATA, ">$outpath\\ohio_offendernumbers.txt") or die "Can't open subjects file: ohio_offendernumbers.txt";
print OUTFILE_DATA "offnum\n";

my @types=("A", "R", "W");
foreach my $type (@types) {

  my $startfile=1; my $endfile=999999;

  my $recordnum=0;
  my $pct;
  for (my $pageindex=$startfile; $pageindex<=$endfile; $pageindex++) {

    $recordnum++;
    #$pct=$recordnum/($endfile-$startfile);
    #print "$type   $pageindex   ($startfile to $endfile)--------$pct\n";

    # Add leading zeros to numbers.
    # http://www.perlmonks.org/?node_id=201244
    my $shortnum = $pageindex; my $len = 6; my $paddednum = sprintf ("%0${len}d", $shortnum ); my $offnum="$type$paddednum";
  
    # Test if file exists. If it does, add the offender number to the data file. If not, just skip it.
    if (-e "$inpath\\ohio_html_$offnum.txt") { print OUTFILE_DATA "$offnum\n" }
  }
}

