<?php
//Sample XML
//<message type="dr">
//<adn>123</adn>
//<msisdn>9820202020</msisdn>
//<tid>1234567890</tid>]
//<ccode>123SMSPULL2000</ccode>
//<status>1</status>
//<tdate>2012-02-21 12:31:20</tdate>
//</message>
 
$body = file_get_contents('php://input');
file_put_contents('/tmp/x', "---\n$body\n---\n");
$xml = simplexml_load_string($body);
//CP shortcode
$adn = $xml->adn;
//Handset number
$msisdn = $xml->msisdn;
//Transaction Id
$tid = $xml->tid;
//Charging code
$ccode = $xml->ccode;
//DR status
$status = $xml->status;
//Transaction date
$tdate = $xml->tdate;
?>