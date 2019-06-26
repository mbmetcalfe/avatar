#!/opt/csw/bin/perl
 
#if ($#ARGV != 0) {
#	die "Usage: $0 display_channel\n";
#}
 
#$displayChannel=$ARGV[0];
 
# Open up init file with the info on character to find.
$initFile="findThis.dat";
open INITFILE, $initFile or die "Cannot find init file $initFile: $!";

chomp($findTier=<INITFILE>);
chomp($findName=<INITFILE>);
chomp($findRace=<INITFILE>);
chomp($findLevel=<INITFILE>); # Bad name, but consistent
$_=$findLevel;
/([0-9]*)[dhnrst]*/;
$findLevel=$1;
chomp($findClass=<INITFILE>);
close INITFILE;

$lcFindName=lc($findName);
$charFile="avatarChars.dat";

open CHARFILE, $charFile or die "Cannot find $charFile :$!";

# Initialization
$index=0;
$raceRank=0;
$classRank=0;
$bothRank=0;
$charRank=0;
$found=0;
$prevRaceTier='NA';
$prevRaceChar='Noone';
$prevClassTier='NA';
$prevClassChar='Noone';
$prevBothTier='NA';
$prevBothChar='Noone';

while (<CHARFILE>) {
	# Grab the values from the input line.
	/(^[a-zA-Z]+),([a-zA-Z]+),([a-zA-Z\-\ ]+),([0-9]+),([a-zA-Z\ ]+)$/;
	$tempTier=$1;
	$tempName=$2;
	$tempRace=$3;
	$tempLevel=$4;
	$tempClass=$5;
	
	# check the race/class and race/class combo for the
	# highest character.
	if ($tempRace eq $findRace && $found != 1) {
		if (($lcFindName ne lc($tempName)) && 
		    ($findLevel ne $tempLevel)) {
			$prevRaceChar=$tempName;
			$prevRaceTier=$tempTier;
			$prevRaceLevel=$tempLevel;
			}
			$raceRank++;
			#$prevRaceLevel=$tempLevel;
		}
	
	if ($tempClass eq $findClass && $found != 1) {
		if ($prevClassLevel ne $tempLevel) {
			if (($lcFindName ne lc($tempName))
				&& ($findLevel ne $tempLevel)) {
				$prevClassChar=$tempName;
				$prevClassTier=$tempTier;
                                $prevClassLevel=$tempLevel;
			}
			$classRank++;
			#$prevClassLevel=$tempLevel;
		}
	}
	if (($tempRace eq $findRace) &&
	    ($tempClass eq $findClass) &&
            $found != 1) {
		if ($prevBothLevel ne $tempLevel) {
			if (($lcFindName ne lc($tempName))
				&& ($findLevel ne $tempLevel)) {
				$prevBothChar=$tempName;
				$prevBothTier=$tempTier;
                                $prevBothLevel=$tempLevel;
			}
			$bothRank++;
			#$prevBothLevel=$tempLevel;
		}
	}
	# Found a match.  Could probably exit loop here, but processing
	# is quick anyway and could count all lines if needed.
	if (lc($tempName) eq $lcFindName) {
		$found=1;
		#set the output name as the one from the last command.
		$findName=$tempName;
		$charRank=$index+1;
	}
	if ($tempLevel ne $prevLevel) {
		$prevLevel=$tempLevel;
		$index++;
	}
}

# open up a restult file and print what was found.
open(COUNTRESULT, ">countres.dat") or die "Can't open result file!:$!";
# If the person isn't in the file, make a special message. 
if (!$found) {
	$outmsg="|bc|$findName |c|$findTier |by|$findLevel|w|: |r|No rank info|w|.";
}
else {
	$outmsg="|bc|$findName |c|$findTier |by|$findLevel|w|: |c|#|y|$charRank |c|overall|w|.";
	if ($raceRank eq 1) {
		$outmsg="$outmsg |bc|#|by|$raceRank |bc|$findRace|w|,";
	} else {
		$outmsg="$outmsg |c|#|y|$raceRank |c|$findRace |w|(|c|next |bc|$prevRaceChar |k|[|y|$prevRaceLevel|k|]|w|),";
	}
	if ($classRank eq 1) {
		$outmsg="$outmsg |bc|#|by|$classRank |bc|$findClass,";
	} else {
        	$outmsg="$outmsg |c|#|y|$classRank |c|$findClass |w|(|c|next |bc|$prevClassChar |k|[|y|$prevClassLevel|k|]|w|),";
    	}
    	if ($bothRank eq 1) {
        	$outmsg="$outmsg and |bc|#|by|$bothRank |bc|$findRace|bw|-|bc|$findClass|w|.\n";
    	} else {
        	$outmsg="$outmsg and |c|#|y|$bothRank |c|$findRace|w|-|c|$findClass |w|(|c|next |bc|$prevBothChar |k|[|y|$prevBothLevel|k|]|w|).\n"
    	}
}

print COUNTRESULT $outmsg;

close COUNTRESULT;
close CHARFILE;
