
#!/usr/bin/perl -w

use strict;
use warnings;
use File::Slurp;
use String::Util 'trim';

my $listpath="B:\\Research\\Projects\\Incarceration\\Michigan\\data";
my $inpath="B:\\Research\\Projects\\Incarceration\\Michigan\\html";
my $outpath="B:\\Research\\Projects\\Incarceration\\Michigan\\data";

open (OUTFILE_DATA, ">$listpath\\michigan_data_test.txt") or die "Can't open subjects file: michigan_data_test.txt";
 print OUTFILE_DATA "offnum	name	dob	inst	county	offensedate	sentencedate\n";

open (LISTFILE, "<$listpath\\michigan_offnumbers.txt") or die "Can't open subjects file: michigan_offnumbers.txt";
while (my $offnum = <LISTFILE>) {
  
  chomp($offnum);
  my $content = read_file("$inpath\\michigan_html_$offnum.txt");

  # Parse Name, DOB, County, Offense Date, and Senetence Date
  my $name; my $dob; my $inst; my $county; my $offensedate; my $sentencedate;
  if ($content=~/<span id="valFullName">(.*?)<\/span>/) { $name=$1; $name=trim($name) }
  if ($content=~/Date of Birth:(.*?)valBirthDate">(.*?)&nbsp/s) { $dob=$2; }
  if ($content=~/<a id="valLocation"(.*?)>(.*?)<\/a>/) { $inst=$2; }
     while ($content=~/Date of Offense: <\/div><div class='span3'>(.*?)<\/div>(.*?)County: <\/div><div class='span3'>(.*?)<\/div>(.*?)Date of Sentence: <\/div><div class='span3'>(.*?)<\/div>/g) {
           $offensedate=$1; $county=$3; $sentencedate=$5;
           print OUTFILE_DATA "$offnum	$name	$dob	$inst	$county	$offensedate	$sentencedate\n";
     }
}