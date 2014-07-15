<?php
include '../../inc/boot.inc';
rpiBoot(__FILE__);

$s = unserialize('O:11:"ModelStruct":3:{s:7:"version";i:1;s:5:"slots";a:2:{s:5:"inset";s:26:"image/jpeg; charset=binary";s:10:"background";s:26:"image/jpeg; charset=binary";}s:3:"sku";s:13:"SKU goes here";}');
var_dump($s);
echo "----\n".serialize($s)."\n----\n";
?>