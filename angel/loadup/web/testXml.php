<?Php
include '../../inc/boot.inc';
kptBoot(__FILE__);

class KptXMLWriter extends XMLWriter {

    /** Simple wrapper for optional elements
     */

    /** Works exactly like writeElement except element is omitted of
     *  the content is empty.
     */
    function optEle($name, $content) {
        if (! empty($content))
            $this->writeElement($name, $content);
        return;
    }

    /** Works exactly like writeAttribute but is omitted if the
     *  content is empty.
     */
    function optAttr($name, $content) {
        if (! empty($content))
            $this->writeAttribute($name, $content);
        return;
    }
}

// THIS IS ABSOLUTELY ESSENTIAL - DO NOT FORGET TO SET THIS 
@date_default_timezone_set("GMT"); 

$orderkey = $argv[1].$_SERVER['QUERY_STRING'];

$o = new Order($orderkey);
//print_r($o);
//print "------------------------\n";

$uos = new KptXMLWriter(); 

// Output directly to the user 

$uos->openURI('php://output'); 
$uos->startDocument('1.0'); 
$uos->setIndentString('    ');
$uos->setIndent(true);

$uos->startElement('Order'); // begin Order

$uos->writeAttribute('version', '1.0'); 
$uos->writeAttribute('xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance'); 
$uos->writeAttribute('xsi:schemaLocation', 'http://uos.kptprint.com/xml/KPTOrderXML'
                     .' '.'http://uos.kptprint.com/xml/KPTOrderXMwL-1-0.xsd'); 

$uos->writeElement('Sender', 'StoreFront'); 
$uos->writeElement('CustomerID', 'Tegt'); 
$uos->writeElement('OrderID', $orderkey); 
$uos->writeElement('OrderDate', date('c')); 
$uos->writeElement('StatusUrl', 'http://storefronttest.kptprint.com/statusup/'); 

$uos->writeElement('ShipMethod', $o->shipping); 

$uos->startElement('ShipTo'); // begin ShipTo

$uos->writeElement('Name', $o->customer->name); 
$uos->optEle('Phone', $o->customer->phone); 
$uos->optEle('Email', $o->customer->email); 
$uos->optEle('MemberID', $o->customer->id); 
$uos->optEle('MemberName', $o->customer->login); 
$uos->writeElement('Address1', $o->customer->addr1); 
$uos->optEle('Address2', $o->customer->addr2); 
$uos->optEle('Address3', $o->customer->addr3); // not real yet
$uos->optEle('City', $o->customer->city); 
$uos->optEle('State', $o->customer->state); 
$uos->writeElement('Postal', $o->customer->postal); 
$uos->optEle('Country', $o->customer->country); 

$uos->endElement(); // end ShipTo


$uos->startElement('OrderItems'); // begin OrderItems

foreach ($o->items as $item) {
    
    file_put_contents('/tmp/x', $item->model->structure."---\n");
    $struct = unserialize($item->model->structure);

    $uos->writeElement('ItemID', $orderkey.'-'.$item->seq); 
    $uos->writeElement('Quantity', $item->copies); 
    $uos->writeElement('Sku', $struct->sku); 

    $uos->startElement('OrderItems'); // begin Images    

    foreach ($item->model->assets as $aName=>$aList) {

        $uos->startElement('Image'); // begin Image
        $uos->optAttr('Page', $struct->page($aName));
        $uos->optAttr('PageStart', $struct->pageStart($aName));
        $uos->optAttr('PageEnd', $struct->pageEnd($aName));
        $uos->optAttr('URL', $struct->pickUrl($aList));
        $uos->optAttr('Rotation', $struct->rotation($aName));
        $uos->endElement(); // end Image

    }
    $uos->endElement(); // end Images

}
$uos->endElement(); // end OrderItems


$uos->endElement(); // end Order

$uos->endDocument(); 

$uos->flush(); 
?>