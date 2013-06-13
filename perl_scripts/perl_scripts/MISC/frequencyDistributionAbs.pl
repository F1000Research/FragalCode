#!/usr/bin/perl -w 
use strict ;
use FileHandle ;
use Getopt::Long;
use Cwd ;
use MyUtils;
use POSIX qw(floor);
my $commandline = util_get_cmdline("",\@ARGV) ;
my ($infile,$outfile,$which_tech);
my ($delta,$maxscore);
GetOptions(
            "which_tech=s"=>\$which_tech ,
            "infile=s"=>\$infile ,
            "maxscore=i"=>\$maxscore ,
            "delta=i"=>\$delta ,
            "outfile=s"=>\$outfile 
           );
die "Dont recognize command line arg @ARGV " if(@ARGV);
usage( "Need to give a output file name => option -outfile ") if(!defined $outfile);
use Statistics::Descriptive;
usage( "Need to give a output file name => option -outfile ") if(!defined $outfile);
usage( "Need to give a input file name => option -infile ") if(!defined $infile);

usage( "Need to give max score approximately => option -maxscore ") if(!defined $maxscore);
usage( "Need to give a delta => option -delta ") if(!defined $delta);

my $ofh = util_write($outfile);

my $stat = Statistics::Descriptive::Full->new();
my $ifh = util_read($infile);
my $pdbfile = "$infile.pdb";
my $ooo = util_write($pdbfile);
while(<$ifh>){
         next if(/^\s*$/);
		 my @l = split ; 
         $stat->add_data($l[1]);
		 #print "$l[0]\n";
}

 
my @bins = ();
my $start = 0 ; 
my $iter = $maxscore/$delta ;
foreach my $i (0..$iter){
    push @bins,($start + $i*$delta); 	
}


my $f = $stat->frequency_distribution_ref(\@bins);
for (sort {$a <=> $b} keys %$f) {
      print $ofh " $_ $f->{$_}\n";
}


sub usage{
    my ($msg) = @_ ;
    print $msg , "\n" ; 
print << "ENDOFUSAGE" ; 
ENDOFUSAGE
    die ;
}
