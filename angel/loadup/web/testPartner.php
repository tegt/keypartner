#! /usr/bin/php
<?Php
include '../../inc/boot.inc';
rpiBoot(__FILE__);

echo "\n<pre>\n";
print_r(new Partner($argv[1].$_SERVER['QUERY_STRING']));
echo "\n</pre>\n";
?>