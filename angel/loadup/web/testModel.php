#! /usr/bin/php
<?Php
include '../../inc/boot.inc';
rpiBoot(__FILE__);

$seed = $argv[1].$_GET[1];
$iId = $argv[2].$_GET[2];

if (! isIndex($iId)) {
    $iId = 0;
}
echo "\n<pre>\n";
echo "Using item id=$iId\n\n";
print_r(new Model($seed, $iId));
echo "\n</pre>\n";
?>