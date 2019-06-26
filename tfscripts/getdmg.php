#!/opt/php/bin/php
<?php 
  $passed=$argv[1];
  $fname = "damages.dat";
  $last=0;
  $lastverb="nil";
  $lines = file($fname);
  foreach ($lines as $line){ 
    $words=sscanf($line,"%s\t%d\r");
    if(count($words)==2){
      $new = $words[1];
      if($new == $passed){
        echo $words[0];
        exit;
      } else if($new>$passed){
        echo "$lastverb|w| to |c|$words[0]";
        exit;
      } else{
        $last=$words[1];
        $lastverb=$words[0];
      }
    }
  }
?>
