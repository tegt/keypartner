<?php
/** OrderUp process order steps from field inputs. Take the order
 *  through as many steps as data is provided for and then issue a
 *  JSON response to indicate status.
 */
include '../../inc/boot.inc';
kptBoot(__FILE__);

$orderIn = $_POST['order'];
$partnerKey = $_POST['partnerkey'];
$orderKey = $_POST['orderkey'];
$debug = explode(',', $_POST['debug']);
$reply['order'] = '** incomplete';

/** Starting new order
 *
 *  Only starts a new order if the partnerkey is set AND the orderkey
 *  is not.
 */
if (isset($partnerKey) && ! isset($orderKey)) { 

    $partner = new Partner($partnerKey);
    if (! isIndex($partner->id)) {
        $reply['order'] = '** none';
        $reply['partnerkey'] = '** invalid: partner key';
        Kpt::jsonExit($reply);
    }

    $order = new Order;
    $order->dbFill('order-', $_POST);
    $errors = $order->optional();
    if ($errors) {
        $reply['order'] = '** invalid';
        foreach ($errors as $eName => $eMsg) {
            $reply['order_'.strtolower($eName)] = '** invalid: '.$eMsg;
        }
        Kpt::jsonExit($reply);
    }

    $customer = new Customer; // empty customer label
    $customer->id = $customer->write('customers', 'c');

    /** If manditory order info was given open a blank order */
    $order->customer = $customer;
    $order->cid = $customer->id;
    $order->id = $order->write('orders', 'o');

    $oKeyUpdate = new KptKey($order); // Put new key in db under our order
    $orderKey = $oKeyUpdate->key;
}

// Continue order in process

if (isset($orderKey)) { 
    
    if (isset($_POST[$partnerkey]) && isset($_POST[$orderkey]))
        $reply['partnerkey'] = 'Ignored when orderkey is given.';

    $order = new Order($orderKey); // Reconstitute Order from Key
    if (in_array('order', $debug))
        $reply['debug']['order'] = $order;

    if (! isIndex($order->id)) {
        $reply['orderkey'] = '** invalid: order key';
        Kpt::jsonExit($reply);
    }

    /** At this point we have an order in progress, new or
     * reconstituted.
     *
     *  Look to complete customer and at least one item before responding ready.
     */

    $reply['orderkey'] = $orderKey; // ack key accepted
    
    
    foreach ($_FILES as $fkey => $val) { // merge files list into post list
        $_POST[$fkey] = $val;
    }
    $keyTree = keyTree($_POST); // form the keys into a tree by seperators

    /** Process the database tree from the leaves down
     *
     *  This creates the node's before the parent elements are in place. 
     */ 

    // --- The Customer Label

    if (is_object($keyTree->label)) { 

        if (! is_a($order->customer, 'Customer')) { // need new customer label
            $order->customer = new Customer;
            $order->customer->pid = $partner->id;
        }
        
        $order->customer->dbFill('label_', $_POST); // update values 
        $customerId = $order->customer->write('customers','c');
        
        $errors = $order->customer->optional('company');
        foreach ($errors as $eName => $eMsg) {
            $reply['label_'.strtolower($eName)] = '** '.$eMsg;
        }
    }

    // --- The Order itself
            
    if ($order->customer->id <> $customerId) { // update order if change
        $order->customer->id = $id;
        $order->cid = $order->customer->id;
        $order->id = $order->write('orders', 'o');
    }

    // --- The Items

    if (is_object($keyTree->item))  {

        foreach ($keyTree->item as $p => $v) { 
            if (isIndex($p)) // skip non index values
                $num[(int)$p] = 1; // item extract unique numbers
        }        
        ksort($num, SORT_NUMERIC); // put numbers in order

        foreach ($num as $n => $x) { // for each Item $n

            // item_$n selected. Check model key if set
            $itemPreKey = $keyTree->item->$n->preKey; // bare item_$n
            $modelKey = $_POST[$itemPreKey]; // it's value or null

            if (isset($modelKey)) {

                $modelNew = new Model($modelKey); // construct new model
                
                if (! isIndex($modelNew->id)) {// bad key
                    $reply[$itemPreKey] = "** Invalid: model key";
                }
                else {
                    if (! isset($order->items[$n])) { // new item needed
                        $order->items[$n] = new Item;
                        $order->items[$n]->oId = $order->id;
                        $order->items[$n]->seq = $n;
                    }
                    $oin = $order->items[$n]; // save typing

                    if (! isset($oin->model)  // new model needed
                        || $oin->model->id <> $modelNew->id) {
                        $oin->model = $modelNew;
                        $oin->mId = $modelNew->id; 
                    }
                }
                // do item_$n_set_<property>
                $oin->dbFill($itemPreKey.'_set_', $_POST);

                $errors = $oin->optional();
                foreach ($errors as $eName => $eMsg) {
                    $reply[$itemPreKey.'_set_'.strtolower($eName)] = '** '.$eMsg;
                }

                $oin->write('items', 'i'); // record changes
            }

            // New values for assets: item_$n_$name of model

            foreach($oin->model->assets as $assetName => $assetArray) { // wal 
                $assetPreKey = $itemPreKey.'_'.$assetName;
                $assetVal = $_POST[$assetPreKey]; // incoming value
                
                if (is_array($assetVal)) { // new file asset

                    $upName = assetDir.'/customer/'.$assetName.'_'.$order->key->key.'_'.$oin->seq;
                    
                    $mime = 'image/jpeg; charset=binary'; //**HACK
                    /* $fi = new finfo(FILEINFO_MIME); */
                    /* $mime = $fi->file($_FILES['ufile']['tmp_name']); */
                    /* $fi = finfo_open(FILEINFO_MIME_TYPE); */
                    /* $mime = finfo_file($_FILES['ufile']['tmp_name']); */

                    if ($assetVal['error'] <> UPLOAD_ERR_OK) { // error msg
                        $errs = array( UPLOAD_ERR_INI_SIZE => 'UPLOAD_ERR_INI_SIZE',
                                       UPLOAD_ERR_FORM_SIZE => 'UPLOAD_ERR_FORM_SIZE',
                                       UPLOAD_ERR_PARTIAL => 'UPLOAD_ERR_PARTIAL',
                                       UPLOAD_ERR_NO_FILE => 'UPLOAD_ERR_NO_FILE',
                                       UPLOAD_ERR_NO_TMP_DIR => 'UPLOAD_ERR_NO_TMP_DIR',
                                       UPLOAD_ERR_CANT_WRITE => 'UPLOAD_ERR_CANT_WRITE'
                                       );
                        $reply[$assetPreKey] = '** Upload failed '.$errs[$assetVal['error']];

                    } 

                    elseif (! @move_uploaded_file($assetVal['tmp_name'], $upName)) {
                        $reply['error'][$assetPreKey] = '** File move error on server';
                    }

                    else { // change 'c' values for new customer upload
                        $thisAsset = $oin->model->assets[$assetName]['c'];
                        if (! is_a($thisAsset, 'Asset')) { // need new asset record
                            $thisAsset = new Asset;
                            $oin->model->assets[$assetName]['c'] = $thisAsset;
                        }
                        $thisAsset->val = $upName;
                        $thisAsset->mime = $mime;
                        $thisAsset->iId = $oin->id;
                        $thisAsset->sId = $oin->model->assets[$assetName]['sid'];
                        $thisAsset->id = $thisAsset->write('assetscustomer', 'ac', 
                                                           array ('mId' => -1, 
                                                                  'pId' => -1));
                    }
                }
                // new asset types go here in elseif chain
                elseif (isset($assetVal)) {
                    $reply['error'][$assetPreKey] = '** Invalid: data type';
                }
            }
        }

    }
    
    /** All input complete. Look for missing item assets.
     *
     *  Walk entire order after updates and create missing item list.
     */

    foreach ($order->items as $item) {
        $reply['order'] = 'ready'; // assume ready

        foreach ($item->model->assets as $aName=>$asset) {

            $r = '';
            if (is_a($asset['c'], 'Asset'))
                continue; //$r = 'ready';
            
            elseif (is_a($asset['p'], 'Asset'))
                continue; // $r = 'defaulted';
            
            elseif (is_a($asset['x'], 'Asset'))
                continue; 
            
            else  {
                $reply['order'] = '** incomplete';
                $r = '** missing';
            }                    
            
            $aField = 'item_'.$item->seq.'_'.$aName;
            if ($r <> '') {
                if (! isset($reply[$aField])
                    || substr($reply[$aField], 0, 2) <> '**') {

                    $reply[$aField] = ''; // chuck non-error
                }
            }
            $reply[$aField] = $r.': '.$reply[$aField]; // summerize error
        }
    }

    /** All input complete. Look for label
     */

    if (empty($order->customer->name)) {
        $reply['order'] = '** incomplete';
        $reply['label_name'] = "** missing";
    }

    /** Should it be placed?
     */

    if ($reply['order'] == 'ready' 
        && $orderIn == 'place')  {
        $order->state = 2;
        $order->write('orders', 'o'); // record shippable!
        $reply['order'] = 'placed';
    }

}

else {
    $reply['order'] = '** none';
    $reply['partnerkey'] = '** missing';
    $reply['orderkey'] = '** missing';
}

Kpt::jsonExit($reply);
?>
