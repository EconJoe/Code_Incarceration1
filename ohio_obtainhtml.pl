
#!/usr/bin/perl -w

use strict;
use warnings;
use LWP::Simple;

# Set path for the HTML files.
my $outpath="B:\\Research\\Projects\\Incarceration\\Ohio\\test";

# Initialize the starting number, ending number, and number "type".
# Each prisoner in Ohio is assigned a 6 digit number (many have leading zeros). We don't know which numbers are used,
#  so we need to loop through all possible numbers ~1 million iterations.
# Each prisoner's "number" begins with either A, R, or W. Men are A and R and women are W. We need to loop through all possible
#  numbers for each of these types. Thus, the total number of passes is ~3 million.
my @types=("A", "W", "R");
my $startfile; my $endfile;

foreach my $type (@types) {
        
  # The recordnum and $pct are just for output display to keep track of progress.
  my $recordnum=0; my $pct;
  $startfile=1; $endfile=999999;
  for (my $pageindex=$startfile; $pageindex<=$endfile; $pageindex++) {

    # The recordnum and $pct are just for output display to keep track of progress.
    $recordnum++; $pct=$recordnum/($endfile-$startfile);
    print "$type   $pageindex   ($startfile to $endfile)--------$pct\n";

    # Add leading zeros to numbers.
    # http://www.perlmonks.org/?node_id=201244
    my $shortnum = $pageindex; my $len = 6; my $paddednum = sprintf ("%0${len}d", $shortnum ); my $offnum="$type$paddednum";
  
    # Fetch URL
    my $url = "http://www.drc.ohio.gov/offendersearch/details.aspx?id=$offnum";
    my $content = get $url;
    die "Couldn't get $url" unless defined $content;
  
    # Check whether a particular number has been assigned to anyone by checking whether the webpage associated with that number contains an offender's name.
    my $name;
    if ($content=~/<span id="ctl00_ContentPlaceHolder1_Lbl_FullName(.*?)>(.*?)<\/span>/) {
       
       $name=$2;
       if ($name eq "") { }
       else {
        # Open and print HTML
        open (OUTFILE_HTML, ">$outpath\\ohio_html_$type$paddednum.txt") or die "Can't open subjects file: ohio_$type$paddednum.txt";
        print OUTFILE_HTML $content;
        close OUTFILE_HTML;
       }
    }
  }
}

