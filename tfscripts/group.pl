#!/usr/bin/perl

# TODO: Make it so that it only reads the file if it exists and if it has changed
# http://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
my $INPUTFILENAME = ".gstats.dat";
my $interval = 8;    # time (in seconds) between checks
my $tableBorder = "$GREEN+$WHITE-------------$GREEN+$WHITE----$GREEN+$WHITE--------$GREEN+$WHITE------$GREEN+$WHITE------$GREEN+$WHITE------$GREEN+$WHITE------$GREEN+$WHITE------$GREEN+$WHITE------$GREEN+$WHITE-------$GREEN+$WHITE-----$GREEN+$WHITE-----$GREEN+\n";

#my $NOCOLOUR    = "\033[0m";
my $NOCOLOUR    = "\x1B[0m";
my $BLACK       = $NOCOLOUR."\x1B[30m";
my $RED         = $NOCOLOUR."\x1B[31m";
my $GREEN       = $NOCOLOUR."\x1B[32m";
my $YELLOW      = $NOCOLOUR."\x1B[33m";
my $BLUE        = $NOCOLOUR."\x1B[34m";
my $MAGENTA     = $NOCOLOUR."\x1B[35m";
my $CYAN        = $NOCOLOUR."\x1B[36m";
my $WHITE       = $NOCOLOUR."\x1B[37m";
my $BBLACK       = $NOCOLOUR."\x1B[01;30m";
my $BRED         = $NOCOLOUR."\x1B[01;31m";
my $BGREEN       = $NOCOLOUR."\x1B[01;32m";
my $BYELLOW      = $NOCOLOUR."\x1B[01;33m";
my $BBLUE        = $NOCOLOUR."\x1B[01;34m";
my $BMAGENTA     = $NOCOLOUR."\x1B[01;35m";
my $BCYAN        = $NOCOLOUR."\x1B[01;36m";
my $BWHITE       = $NOCOLOUR."\x1B[01;37m";

while (1)
{
    open fileHandle, $INPUTFILENAME or die "Cannot find $INPUTFILENAME :$!";
    
    @lines = <fileHandle>;
    $lineCount = @lines;
    print `clear`;
    # grab first line that has group leader.
    $_ = shift @lines;
    /leader: ([a-zA-Z]+) talent: (.*) monitor: ([a-zA-Z]*)./;
    $gLeader = $1;
    $gTalent = $2;
    $gMonitor = $3;
    my $extraMessage = shift @lines;
#    print "ext"
    # chomp($extraMessage);

    printf "$GREEN|$YELLOW%-13s$GREEN|$YELLOW%4s$GREEN|$YELLOW%6s$GREEN|$YELLOW%7s$GREEN|$YELLOW%7s$GREEN|$YELLOW%7s$GREEN|$YELLOW%7s$GREEN|$YELLOW%6s$GREEN|$YELLOW%6s$GREEN|$YELLOW%7s$GREEN|$YELLOW%5s$GREEN|$YELLOW%3s$GREEN|$NOCOLOUR\n", "Name", "Info", "Level", "CurHP", "MaxHP", "CurMn", "MaxMn", "CurMv", "MaxMv", "TNL", "Align", "Pos";
    print "$GREEN+$WHITE-------------$GREEN+$WHITE----$GREEN+$WHITE------$GREEN+$WHITE-------$GREEN+$WHITE-------$GREEN+$WHITE-------$GREEN+$WHITE-------$GREEN+$WHITE------$GREEN+$WHITE------$GREEN+$WHITE-------$GREEN+$WHITE-----$GREEN+$WHITE---$GREEN+$NOCOLOUR\n";
    while ($line = shift @lines)
    {
        $gLevel = 0;
        $gTier = na;
        $gName = na;
        $gNameCol = $WHITE;
        $gPosition = na;
        $gPosCol = $YELLOW;
        $gCurHP = 0;
        $gMaxHP = 0;
        $gHPCol = $CYAN;
        $gCurMn = 0;
        $gMaxMn = 0;
        $gMnCol = $YELLOW;
        $gCurMv = 0;
        $gMaxMv = 0;
        $gMvCol = $GREEN;
        $gAlign = na;
        $gTnl = 0;
        $gTnlCol = $WHITE;
        $gInfo = "";
        
        $_ = $line;
        /([0-9]+)[ ]+([a-zA-Z]+)[ ]+([a-zA-Z ]+)[ ]+(STUN|DROWN|Fight|Sleep|Stand|Rest|Busy)[ ]+([0-9\-]+)\/([0-9\-]+)[ ]+([0-9\-]+)\/([0-9\-]+)[ ]+([0-9\-]+)\/([0-9\-]+)[ ]+([0-9]+)[ ]+([0-9\-]+)/;
        $gLevel = $1;
        #$gTier = $2;
        $gTier = substr($2, 0, 2);
        $gName = $3;
        if (lc($gName) eq lc($gMonitor))
        {
            $gInfo .= "*";
        }
        if (lc($gName) eq lc($gLeader))
        {
            $gNameCol = $BMAGENTA;
            $gInfo .= "@";
        }

        $gPosition = substr($4, 0, 3);
        $gCurHP = $5;
        $gMaxHP = $6;
        $gCurMn = $7;
        $gMaxMn = $8;
        $gCurMv = $9;
        $gMaxMv = $10;
        $gTnl = $11;
        $gAlign = $12;
        
        # Logic to pretty the colours based on specific conditions
        if (lc($gPosition) eq "stun" or lc($gPosition) eq "drown")
        {
            $gPosCol = $BRED;
        }
        my $perHP = ($gCurHP / $gMaxHP) * 100;
        my $perMn = ($gCurMn / $gMaxMn) * 100 if $gMaxMn > 0;
        my $perMv = ($gCurMv / $gMaxMv) * 100;
        
        if ($perHP < 35)
        {
            $gHPCol = $RED;
            $gNameCol = $RED;
        }
        elsif ($perHP < 50)
        {
            $gHPCol = $YELLOW;
            $gNameCol = $YELLOW;
        }
        elsif ($perHP < 70)
        {
            $gHPCol = $MAGENTA;
            $gNameCol = $MAGENTA;
        }
        elsif ($perHP < 85)
        {
            $gHPCol = $BLUE;
            $gNameCol = $BLUE;
        }

        if ($perMn < 35) {$gMnCol = $RED;}
        elsif ($perMn < 50) {$gMnCol = $YELLOW;}
        elsif ($perMn < 70) {$gMnCol = $MAGENTA;}
        elsif ($perMn < 85) {$gMnCol = $BLUE;}

        if ($perMv < 35) {$gMvCol = $RED;}
        elsif ($perMv < 50) {$gMvCol = $YELLOW;}
        elsif ($perMv < 70) {$gMvCol = $MAGENTA;}
        elsif ($perMv < 85) {$gMvCol = $BLUE;}
        
        #print "$gLevel $gTier $gName $gPosition $gCurHP $gMaxHP $gCurMn $gMaxMn $gCurMv $gMaxMv rest: $gRest\n";
        printf "$GREEN|$WHITE$gNameCol%-13s$NOCOLOR$GREEN|$WHITE%4s$GREEN|$WHITE%2s %3d$GREEN|$gHPCol%7d$GREEN|$BCYAN%7d$GREEN|$gMnCol%7d$GREEN|$BYELLOW%7d$GREEN|$gMvCol%6d$GREEN|$BGREEN%6d$GREEN|$gTnlCol%7d$GREEN|$YELLOW%5s$GREEN|$YELLOW%3s$GREEN|$WHITE$NOCOLOUR\n", $gName, $gInfo, $gTier, $gLevel, $gCurHP, $gMaxHP, $gCurMn, $gMaxMn, $gCurMv, $gMaxMv, $gTnl, $gAlign, $gPosition;
    }
    
    my $groupSize = $lineCount - 2; # -2 to account for the first two info lines
    print "$GREEN+$WHITE-------------$GREEN+$WHITE----$GREEN+$WHITE--------$GREEN+$WHITE------$GREEN+$WHITE------$GREEN+$WHITE------$GREEN+$WHITE------$GREEN+$WHITE------$GREEN+$WHITE------$GREEN+$WHITE-------$GREEN+$WHITE-----$GREEN+$WHITE-----$GREEN+$NOCOLOUR\n";
    print "$GREEN|$WHITE Size: $YELLOW$groupSize$WHITE; Lead: $YELLOW$gLeader$WHITE; Talent: $YELLOW$gTalent$GREEN|$NOCOLOUR $extraMessage";
    
    undef $fileHandle;
    
    sleep $interval;
}
##close INPUTFILE
