<?php
/** StatusUp process status acks which are expected to be POSTs with
 *  XML in the body.
 */
include '../../inc/boot.inc';
kptBoot(__FILE__);

$body = file_get_contents('php://input');
file_put_contents('/tmp/x', "---\n$body\n---\n");
$xml = @simplexml_load_string($body);

$tr = "---$body+++\n".var_export($xml,true);

$DBO->run('INSERT INTO work SET'
          .' wMsg='.$DBO->esq($tr));
?>