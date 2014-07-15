<?php
include '../../inc/boot.inc';
kptBoot(__FILE__);

$s = new ModelStruct;
$s->slots['inset'] = 'image/jpeg; charset=binary';
$s->slots['background'] = 'image/jpeg; charset=binary';
$s->sku = 'SKU goes here';
var_dump($s);
echo "----\n".serialize($s)."\n----\n";
?>