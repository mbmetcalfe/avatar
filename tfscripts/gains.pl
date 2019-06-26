#!/usr/bin/perl

# Initialization
my $output = "gtell";
my $numGains = 1000;
my @minGains = (9999, 9999, 9999);
my @maxGains = (-1, -1, -1);
my $tier = "all";
my $lowerLevel = 0;
my $upperLevel = 1000;
my $predictStats = 0;
my $tBaseHp = -1;
my $tBaseMana = -1;
my $tBaseMv = -1;
my $tClass = "";
%classMultipliers = (
    "arc" => {hp => 3.5, mana => 2},
    "asn" => {hp => 3, mana => 2.5},
    "bci" => {hp => 3, mana => 3},
    "bld" => {hp => 3, mana => 3},
    "bod" => {hp => 4, mana => 1},
    "bzk" => {hp => 4.5, mana => 0},
    "cle" => {hp => 2.5, mana => 3.5},
    "dru" => {hp => 2.5, mana => 3.5},
    "fus" => {hp => 3.5, mana => 1.5},
    "mag" => {hp => 2, mana => 4},
    "mnd" => {hp => 2, mana => 4.5},
    "mon" => {hp => 3.5, mana => 2.5},
    "pal" => {hp => 3.5, mana => 2.5},
    "prs" => {hp => 1.5, mana => 4.5},
    "psi" => {hp => 2, mana => 4},
    "ran" => {hp => 3.5, mana => 2.5},
    "rog" => {hp => 3, mana => 2},
    "shf" => {hp => 3.5, mana => 2},
    "sor" => {hp => 1.5, mana => 4.5},
    "stm" => {hp => 2, mana => 4},
    "war" => {hp => 4, mana => 2},
    "wzd" => {hp => 1.5, mana => 4.5}
);

my $OUTFILENAME = "gains-out.dat";

#for $class ( keys %classMultipliers ) {
#    print "$class: ";
#    for $stat ( keys %{ $classMultipliers{$class} } ) {
#         print "$stat=$classMultipliers{$class}{$stat} ";
#    }
#    print "\n";
#}


if ($#ARGV < 0) {
       die "Usage: $0 char [-o channel] [-t tier] [-n num gains] [-min] [-max] [-p level] [-r level1-level2] [-hp hp] [-mana mana] [-mv mv] [-class class]\n";
} else {
    for ($i = 0; $i <= $#ARGV; $i++) {
        if ($ARGV[$i] eq "-o") {
            $output = $ARGV[$i+1];
            $i++;
        } elsif ($ARGV[$i] eq "-t") {
            $tier = $ARGV[$i+1];
            $i++;
        } elsif ($ARGV[$i] eq "-n") {
            $numGains = $ARGV[$i+1];
            $i++;
        } elsif ($ARGV[$i] eq "-p") {
            $predictStats = 1;
            $levelGoal = $ARGV[$i+1];
            $i++;
        } elsif ($ARGV[$i] eq "-min") {
            $minGain = 1;
        } elsif ($ARGV[$i] eq "-max") {
            $maxGain = 1;
        } elsif ($ARGV[$i] eq "-r") {
            $_ = $ARGV[$i+1];
            /^([0-9]+)[-|:]+([0-9]+)$/;
            $lowerLevel = $1;
            $upperLevel = $2;
            $i++;            
        } elsif($ARGV[$i] eq "-hp") {
            $tBaseHp = $ARGV[$i+1];
            $i++;
        } elsif($ARGV[$i] eq "-mana") {
            $tBaseMana = $ARGV[$i+1];
            $i++;
        } elsif($ARGV[$i] eq "-mv") {
            $tBaseMv = $ARGV[$i+1];
            $i++;
        } elsif($ARGV[$i] eq "-class") {
            $tClass = $ARGV[$i+1];
            $i++;
        } else {
            $gChar .= $ARGV[$i];
        }
    }
}
my $lcName=lc($gChar);
my $charFile="char\/$lcName.gains.dat";
open CHARFILE, $charFile or die "Cannot find $charFile :$!";

@lines = <CHARFILE>;
my $found = 0;
my $basePredictStats = 0;
#20080901 - 191 hero:5/1258 hp, 3/1427 m, 2/889 mv 4/984 prac.
while (!$found and $line = pop @lines) {
    $tLevel=0;
    $tTier=na;
    $tHpGain=0;
    $tManaGain=0;
    $tMvGain=0;
    $tPracGain=0;

    $_ = $line;
    /^[0-9]+ \- ([0-9]+) (lowmort|hero|lord|legend):([0-9]+)\/([0-9]+) hp, ([0-9]+)\/([0-9]+) m, ([0-9]+)\/([0-9]+) mv ([0-9]+)\/([0-9]+) prac\.$/;
    $tLevel=$1;
    $tTier=lc($2);
    $tHpGain=$3;
    $tManaGain=$5;
    $tMvGain=$7;
    $tPracGain=$9;
    if ($basePredictStats eq 0) {
        if ($tBaseHp eq -1) {$tBaseHp=$4;}
        if ($tBaseMana eq -1) {$tBaseMana=$6;}
        if ($tBaseMv eq -1) {$tBaseMv=$8;}
    }

#    print "--- ($tLevel) from $lowerLevel to $upperLevel\n";
    if ($tTier eq lc($tier) and $tPracGain > 0 and ($tLevel ne $prevLevel)) {
        if ($basePredictStats eq 0) {
            $baseHp=$tBaseHp;
            $baseMana=$tBaseMana;
            $baseMv=$tBaseMv;
            $baseLevel=$tLevel;
            $basePredictStats=1;
        }
 
        $prevLevel = $tLevel;
        if ($tHpGain < 50 and $tManaGain < 50 and $tMvGain < 50) {
            $totHp += $tHpGain;
            $totMana += $tManaGain;
            $totMv += $tMvGain;
            $totPrac += $tPracGain;
            $totGains++;

            # Calculate mins and maxes
            if ($tHpGain < $minGains[0])   {$minGains[0] = $tHpGain;}
            if ($tHpGain > $maxGains[0])   {$maxGains[0] = $tHpGain;}
            if ($tManaGain > $maxGains[1]) {$maxGains[1] = $tManaGain;}
            if ($tManaGain < $minGains[1]) {$minGains[1] = $tManaGain;}
            if ($tMvGain > $maxGains[2])   {$maxGains[2] = $tMvGain;}
            if ($tMvGain < $minGains[2])   {$minGains[2] = $tMvGain;}
        
            if ($totGains == $numGains) {$found = 1;}
        }
    }
}

# open up a restult file and print what was found.
open(OUTFILE, ">$OUTFILENAME") or die "Can't open output file!:$!";

printf OUTFILE "%s %s's avg gain for %d %s levels:  %3.2f hp, %3.2f mana, %3.2f mv.\n", $output, ucfirst($gChar), $totGains, ucfirst($tier), $totHp/$totGains, $totMana/$totGains, $totMv/$totGains;
if ($minGain and $maxGain) {
    printf OUTFILE "%s Min (Max): %d (%d) hp,  %d (%d) mana, %d (%d) mv\n", $output, $minGains[0], $maxGains[0], $minGains[1], $maxGains[1], $minGains[2], $maxGains[2];
} elsif ($minGain) {
    printf OUTFILE "%s Min: %d hp, %d mana, %d mv\n", $output, $minGains[0], $minGains[1], $minGains[2];
} elsif ($maxGain) {
    printf OUTFILE "%s Max: %d hp, %d mana, %d mv\n", $output, $maxGains[0], $maxGains[1], $maxGains[2];
}
if ($predictStats eq 1) {
#    my $twinkHp = 0;
#    my $twinkMana = 0;
#    my $twinkMv = 0;
#    if ($tTier eq "lord") {
#        $numTwinks = $levelGoal
#    }
    print "Predicting stats from $baseLevel.  From these stats: $baseHp hp, $baseMana mana, $baseMv mv.\n";
    $numLevels = $levelGoal - $baseLevel;
    printf OUTFILE "%s Predicted %d stats: %d hp, %d mana, %d mv\n", $output, $levelGoal, $baseHp+($numLevels * $totHp/$totGains), $baseMana+($numLevels * $totMana/$totGains), $baseMv+($numLevels * $totMv/$totGains);
    if ($tClass ne "") {
        print "$tClass Multipliers: HP = $classMultipliers{$tclass}{hp}; Mana =  $classMultipliers{$tclass}{mana}\n";
    }
}

close OUTFILE;
close CHARFILE;
