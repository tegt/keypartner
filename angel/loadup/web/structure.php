<?php
/* dummy structure for early templates */

class ProductMold  {
}

$t = new ProductMold;
$t->parts = array('inset_image');
echo '->>'.serialize($t)."<<-\n";
?>