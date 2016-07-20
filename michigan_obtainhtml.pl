
#!/usr/bin/perl -w

use strict;
use warnings;
use LWP::Simple;
use String::Util 'trim';

# Set path for the HTML files.
my $outpath="B:\\Research\\Projects\\Incarceration\\Michigan\test";

# Initialize the starting number and ending number
# Each prisoner in Michigan is assigned a 6 digit number (many have leading zeros). We don't know which numbers are used,
#  so we need to loop through all possible numbers ~1 million iterations.
my $startfile=1; my $endfile=999999;

# The recordnum and $pct are just for output display to keep track of progress.
my $recordnum=0; my $pct;
for (my $pageindex=$startfile; $pageindex<=$endfile; $pageindex++) {

  $recordnum++;
  $pct=$recordnum/($endfile-$startfile);
  print "$pageindex   ($startfile to $endfile)--------$pct\n";

  # Add leading zeros to numbers.
  # http://www.perlmonks.org/?node_id=201244
  my $shortnum = $pageindex; my $len = 6; my $paddednum = sprintf ("%0${len}d", $shortnum ); my $offnum="$paddednum";

  # Fetch URL
  my $url = "http://mdocweb.state.mi.us/OTIS2/otis2profile.aspx?mdocNumber=$offnum";
  my $content = get $url;
  die "Couldn't get $url" unless defined $content;

  # Check whether a particular number has been assigned to anyone by checking whether the webpage associated with that number contains an offender's name.
  my $name="";
  if ($content=~/<span id="valFullName">(.*?)<\/span>/) {
     
     $name=$2; $name=trim($name);
     if ($name eq "") { }
     else {
      # Open and print HTML
      open (OUTFILE_HTML, ">$outpath\\michigan_html_$offnum.txt") or die "Can't open subjects file: michigan_html_$offnum.txt";
      print OUTFILE_HTML $content;
      close OUTFILE_HTML;
     }
  }
}

