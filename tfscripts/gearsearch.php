#!/usr/local/bin/php
<?php
// web link w\example: http://www.zend.com/pear/tutorials/Console-Getopt.php
require_once 'Console/Getopt.php';
// Define exit codes for errors
define('NO_ARGS',10);
define('INVALID_OPTION',11);
// Reading the incoming arguments - same as $argv
$args = Console_Getopt::readPHPArgv();
// Make sure we got them (for non CLI binaries)
if (PEAR::isError($args)) {
 fwrite(STDERR,$args->getMessage()."\n");
 exit(NO_ARGS);
}
// Short options
$short_opts = 'hg:o:';
// Long options
$long_opts = array('gear=','output=',);

// Convert the arguments to options - check for the first argument
if ( realpath($_SERVER['argv'][0]) == __FILE__ ) {
   $options = Console_Getopt::getOpt($args,$short_opts,$long_opts);
} else {
   $options = Console_Getopt::getOpt2($args,$short_opts,$long_opts);
}

// Check the options are valid
if (PEAR::isError($options)) {
   fwrite(STDERR,$options->getMessage()."\n");
   exit(INVALID_OPTION);
}

print_r($options);
echo "gear: " . $options['g'][1] . "\toutput: " . $options['o'][1] . "\n";
exit(0);
?>