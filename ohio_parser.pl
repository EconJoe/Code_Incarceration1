
#!/usr/bin/perl -w

use strict;
use warnings;
use File::Slurp;


my $listpath="B:\\Research\\Projects\\Incarceration\\Ohio\\data";
my $inpath="B:\\Research\\Projects\\Incarceration\\Ohio\\html";
my $outpath="B:\\Research\\Projects\\Incarceration\\Ohio\\data";

open (OUTFILE_DATA, ">$listpath\\ohio_data_test.txt") or die "Can't open subjects file: ohio_data_test";
print OUTFILE_DATA "offnum	name	dob	inst	county	date\n";

my @types=("A", "R", "W");
foreach my $type (@types) {

  open (LISTFILE, "<$listpath\\ohio_offnumbers_$type.txt") or die "Can't open subjects file: ohio_offnumbers_$type.txt";
  while (my $offnum = <LISTFILE>) {
    chomp($offnum);
    my $content = read_file("$inpath\\ohio_html_$offnum.txt");
    #print $text;

    # Parse DOB, County, and Admission Date
    my $name; my $dob; my $inst; my $county; my $date;
    if ($content=~/<span id="ctl00_ContentPlaceHolder1_Lbl_FullName(.*?)>(.*?)<\/span>/) { $name=$2; }
    if ($content=~/<span id="ctl00_ContentPlaceHolder1_Lbl_DOB" class="coltext">(.*?)<\/span>/) { $dob=$1; }
    if ($content=~/<span id="ctl00_ContentPlaceHolder1_Lbl_Inst" class="coltext">(.*?)<\/span>/) { $inst=$1; }
    while ($content=~/Lbl_CommCnt" class="coltext">(.*?)<span>(.*?)<\/span>(.*?)Lbl_AdminDate" class="coltext">(.*?)<span>(.*?)<\/span>/gs) { $county=$2; $date=$5;
        print OUTFILE_DATA "$offnum	$name	$dob	$inst	$county	$date\n";
    }
    

  }
}

