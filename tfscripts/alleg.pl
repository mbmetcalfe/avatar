#!/usr/bin/perl

my @fileList = <char/.*state.dat>;
my %allegItems;

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

my $all = 1;
my $needs = 0;
my $completed = 0;

if ($#ARGV >= 0)
{
    for ($i = 0; $i <= $#ARGV; $i++)
    {
        if ($ARGV[$i] eq "-all")
        {
            $all = 1;
        }
        elsif ($ARGV[$i] eq "-needs")
        {
            $needs = 1;
        }
        elsif ($ARGV[$i] eq "-completed")
        {
            $completed = 1;
        }
    }
}

if ($needs == 1 or $completed == 1)
{
    $all = 0;
}

print "$YELLOW URL: http://avatar.melanarchy.info/index.php/Allegaagse\n";

foreach $fileName (@fileList)
{
    open fileHandle, $fileName or die "Cannot find $fileName :$!";
    $_ = $fileName;
    /char\/\.([a-zA-Z]+)\-state\.dat/;
    my $charName=ucfirst($1);

    @lines = <fileHandle>;
    while ($line = shift @lines)
    {
        $_ = $line;
        /\/set ([a-zA-Z]+)\=(.*)/;
        my $varName = $1;
        my $varValue = $2;
        if ($varName eq "allegItem")
        {
            if (lc($varValue) !~ m/completed/ and lc($varValue) ne "reset" and lc($varValue) !~ m/gave up/)
            {
                $itemColor = $YELLOW;
                if (exists $allegItems{$varValue})
                {
                    $allegItems{$varValue} = $allegItems{$varValue} + 1;
                }
                else
                {
                    $allegItems{$varValue} = 1;
                }
                
                if ($all or $needs)
                {
                    print"$GREEN$charName$WHITE: $itemColor$varValue$NOCOLOUR\n";
                }
            }
            else
            {
                $itemColor = $RED;
                
                if ($all or $completed)
                {
                    print"$GREEN$charName$WHITE: $itemColor$varValue$NOCOLOUR\n";
                }
            }
            
            last;
        }
    }

    undef $fileHandle;
}

my $outMessage = $BRED . "Needed Allegaagse items: $WHITE: $YELLOW";
my $separator = "";
foreach my $item (sort {lc $a cmp lc $b} keys %allegItems)
{
    $outMessage = $outMessage . $separator;
    if ($allegItems{$item} gt 1)
    {
        $outMessage = $outMessage . $allegItems{$item} . "x ";
    }
    $outMessage = $outMessage . ucfirst($item);
    $separator = "$WHITE, $YELLOW";
}
print $outMessage . "$NOCOLOUR\n";
