#!/usr/bin/perl

$heroFile="herolist.dat";
$lordFile="lordlist.dat";
$outFile="avatarcharlast.dat";
$tmplPack='A48';

# open the output file
open(OUTFILE, ">$outFile") or die "Can't create result file!:$!";

####################################################################
# Lord rank portion
####################################################################
open LORDFILE, $lordFile or die "Cannot find $lordFile :$!";
while (<LORDFILE>) {
	# parse through all the lines, and pick up only then names.
	# Once names are retrieve, output the last command to
	# a text file.
	$mylen=length($_);
	if ($mylen >= 76) {
		/([a-zA-Z]+)\.*\[[0-9]+\]\ +([a-zA-Z]+)\.*\[[0-9]+\]\ +([a-zA-Z]+)\.*\[[0-9]+\]/;
		$char1=$1;
		$char2=$2;
		chomp($char3=$3);
		if ((length($1) > 0) && (length($2) > 0) && (length($3) > 0)) {
			print OUTFILE "$char1 $char2 $char3\n";
		}
	}
	elsif ($mylen >= 51 && $mylen < 76) {
		/([a-zA-Z]+)\.*\[[0-9]*\]\ +([a-zA-Z]+)\.*\[[0-9]*\]\ */;
		$char1=$1;
		chomp($char2=$2);
		if ((length($1) > 0) && (length($2) > 0)) {
			print OUTFILE "$char1 $char2\n";
		}
	}
	else {
		/([a-zA-Z]+)\.*\[[0-9]*\]\ */;
		chomp($char1=$1);
		if (length($1) > 0) {
			print OUTFILE "$char1\n";
		}
	}
}

close LORDFILE;

####################################################################
# Hero rank portion
####################################################################
open HEROFILE, $heroFile or die "Cannot find $lordFile :$!";
while (<HEROFILE>) {
        # parse through all the lines, and pick up only then names.
        # Once names are retrieve, output the last command to
        # a text file.
        $mylen=length($_);
        if ($mylen >= 78) {
                 /([a-zA-Z]+)\.*\[[0-9]+\]\ +([a-zA-Z]+)\.*\[[0-9]+\]\ +([a-zA-Z]+)\.*\[[0-9]+\]\ +([a-zA-Z]+)\.*\[[0-9]+\]/;
                $char1=$1;
                $char2=$2;
		$char3=$3;
                chomp($char4=$4);
                if ((length($1) > 0) && (length($2) > 0) && (length($3) > 0) && (length($4) > 0)) {
                        print OUTFILE "$char1 $char2 $char3 $char4\n";
                }
        }
        elsif ($mylen >= 60 && $mylen < 76) {
                 /([a-zA-Z]+)\.*\[[0-9]+\]\ +([a-zA-Z]+)\.*\[[0-9]+\]\ +([a-zA-Z]+)\.*\[[0-9]+\]/;
                $char1=$1;
                $char2=$2;
                chomp($char3=$3);
                if ((length($1) > 0) && (length($2) > 0) && (length($3) > 0)) {
                        print OUTFILE "$char1 $char2 $char3\n";
                }
        }
        elsif ($mylen >= 40 && $mylen < 60) {
                /([a-zA-Z]+)\.*\[[0-9]*\]\ +([a-zA-Z]+)\.*\[[0-9]*\]\ */;
                $char1=$1;
                chomp($char2=$2);
                if ((length($1) > 0) && (length($2) > 0)) {
                        print OUTFILE "$char1 $char2\n";
                }
        }
        else {
                /([a-zA-Z]+)\.*\[[0-9]*\]\ */;
                chomp($char1=$1);
                if (length($1) > 0) {
                        print OUTFILE "$char1\n";
                }
        }
}

close HEROFILE;
close OUTFILE;
