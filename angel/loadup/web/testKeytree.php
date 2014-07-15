#! /usr/bin/php
<?Php
include '../../inc/boot.inc';
rpiBoot(__FILE__);

$list = array(
              'item-1', 
              'item-1-slip', 
              'item-1-birth', 
              'item-2', 
              'item-1-watch', 
              'item-2-slip', 
              'label-name', 
              'label-addr1', 
              'item-3-birth', 
              'item-3', 
              'item-2-watch', 
              'label-phone', 
              'label-zip' );

foreach ($list as $item) {
    $a[$item] = 'x';
}

echo "\n<pre>\n";
print_r(keyTree($a));
echo "\n</pre>\n";
?>