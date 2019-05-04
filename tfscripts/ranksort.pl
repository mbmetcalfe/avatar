#!/usr/bin/perl
# ranksort.pl
# Sort the avatar chars data file.  Some characters may have leveled since
# the list was updated.
 
$inFile="avatarChars.dat";
$outFile="avatarChars.dat";

open INFILE, $inFile or die "Cannot find init file $inFile: $!";

# Initialization
$index=0;
my @srtArray;

# Read data from file to an array.
# Format array elements as such:
#	N-Level-Name-Race-Class
#	N = 0 | 1 | 2 | 3 | 4
#          where 0 is Lowmort, 1 is Hero, 2 is Lord , 3 is Legend, 4 is Titan
#	Level: 3 chars (left paded with 0's)
while (<INFILE>) {
	# Grab the values from the input line.
#	Lord,Name,Race,Level,Class
	/(^[a-zA-Z]+),([a-zA-Z]+),([a-zA-Z\-\ ]+),([0-9]+)([dhnrst]*),([a-zA-Z\ ]+)$/;
        if($1 eq "Titan") {
                @srtArray[$index] = sprintf("4%03s-%s-%s-%s", $4, $2, $3, $6);
        } elsif($1 eq "Legend") {
                @srtArray[$index] = sprintf("3%03s-%s-%s-%s", $4, $2, $3, $6);
	} elsif($1 eq "Lord") {
		@srtArray[$index] = sprintf("2%03s-%s-%s-%s", $4, $2, $3, $6);
	} elsif($1 eq "Hero") {
		@srtArray[$index] = sprintf("1%03s-%s-%s-%s", $4, $2, $3, $6);
        } elsif($1 eq "Lowmort") {
                @srtArray[$index] = sprintf("0%03s-%s-%s-%s", $4, $2, $3, $6);
	} else {
		print "Error: $1, $2, $3, $4, $5\n";
	}
	$index++;
}	
close INFILE;

$swaps = 0;
$firstItem = 0;
$lastSwap = $#srtArray;

# Sort the array using bubblesort algorithm.
while ($lastSwap) {
	$indexLimit = $lastSwap - 1;
	$lastSwap = 0;
	for($index = $firstItem; $index <= $#srtArray; $index++) {
		$currentValue = $srtArray[$index];
		$_ = $currentValue;
		/^([0-9]+)-([a-zA-Z]+)-([a-zA-Z\-\ ]+)-([a-zA-Z\ ]+)$/;
		$value = $1; 
		$_ = $srtArray[$index+1];
		/^([0-9]+)-([a-zA-Z]+)-([a-zA-Z\-\ ]+)-([a-zA-Z\ ]+)$/;
		$nextValue = $1;
		# if the items are not in order, swap them
		if($nextValue > $value) {
		#	print "$index :: Swapping: $srtArray[$index] <--> $srtArray[$index+1]\n";
			@srtArray[$index] = $srtArray[$index+1];
			@srtArray[$index+1] = $currentValue;
			$lastSwap = $index;
			$swaps++;
		}
	}
}
print "Swapped $swaps items.\n";

# Output the array back to the data file.
open(OUTFILE, ">$outFile") or die "Can't open result file!:$!";
for($index = 0; $index <= $#srtArray; $index++) {
	$tier = "Lord";
	$_ = $srtArray[$index];
	/^(0|1|2)([0-9]+)-([a-zA-Z]+)-([a-zA-Z\-\ ]+)-([a-zA-Z\ ]+)$/;
	if($1 == 1) {
		$tier = "Hero";
	} elsif($1 == 0) {
                $tier = "Lowmort";
        }
	$level = sprintf("%d", $2);
	$name = $3;
	$race = $4;
	$class = $5;
        print OUTFILE "$tier,$name,$race,$level,$class\n";
}

close OUTFILE;
