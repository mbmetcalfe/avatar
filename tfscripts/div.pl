#!/opt/csw/bin/perl
if ($#ARGV < 1) {die "Usage: $0 num1 num2\n";}
else {
    $num1 = $ARGV[0];
    $num2 = $ARGV[1];
    $res = $num1 / $num2;
    printf("%6.2f\n", $res);
}
exit 0;
