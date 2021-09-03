#!/usr/bin/php
<?php
 $passed=$argv[1];
 $fname = "damages.dat";
 $lines = file($fname);
 foreach ($lines as $line){
  $words=sscanf($line,"%s\t%d\r");
  if(count($words)==2){
   if($words[0] == $passed){
    echo $words[1];
    return $words[1];
   }
  }
 }
?>
