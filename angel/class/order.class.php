<?php
  /**
   *  Order Class for Storefront
   *  
   *  @author Grant Tegtmeier <Grant@Tegt.com>
   *  @package keypartner
   *  @copyright Copyright (c) 2013 Grant Tegtmeier for eLimn LLC
   */

class Order extends Kpt {

    /**
     *  Order id
     *  
     *  @var int
     */

    public $id;

    /**
     *  Customer id
     *  
     *  @var int
     */

    public $cid;

    /**
     *  State machine for order
     *  
     *  1 = being composed
     *  2 = placed
     *
     *  @var string
     */

    public $state;

    /**
     *  Partner reference string
     *  
     *  @var string
     */

    public $pref;

    /**
     *  Order note
     *  
     *  @var string
     */

    public $note;

    /**
     *  Shipping choice
     *  
     *  @var string
     */

    public $shipping;

    /**
     *  Custmoer for this order
     *  
     *  @var Customer
     */

    public $customer;

    /**
     *  Items for this order
     *  
     *  @var Customer
     */

    public $items = array();

    /** Construct from key or id
     *
     *  @param mixed $seed if int fetch id, string fetch key
     *  
     */
    public function __construct($seed=null) {
        global $DBO;
         if (isset($seed)) {

             if (isIndex($seed)) { // seed is an index
             $s = 'SELECT * FROM orders'
                 .' LEFT JOIN keysorder ON koOId=oId'
                 .' LEFT JOIN customers ON cId=ocId'
                 .' LEFT JOIN items ON ioId=oId'
                 .' LEFT JOIN models ON mId=imId'
                 .' LEFT JOIN slots ON smId=mmId'
                 .' LEFT JOIN assetspartner ON appId=mpId AND apmId=mId AND apsId=sId'
                 .' LEFT JOIN assetscustomer ON acsId=sId AND aciId=iId'
                 .'   WHERE oId='.(int)$seed;
             }

             elseif (KptKey::check($seed)) { // seed must be a key
             $s = 'SELECT * FROM keysorder'
                 .' JOIN orders ON oId = koOId'
                 .' LEFT JOIN customers ON cId=ocId'
                 .' LEFT JOIN items ON oId=ioId'
                 .' LEFT JOIN models ON mId=imId'
                 .' LEFT JOIN slots ON smId=mmId'
                 .' LEFT JOIN assetspartner ON appId=mpId AND apsId=sId AND apmId=mId'
                 .' LEFT JOIN assetscustomer ON acsId=sId AND aciId=iId'
                 .'   WHERE koKey='.$DBO->esq($seed);
             }
             else { // empty object
                 return;
             }

             $r = $DBO->run($s); // fetch full order

             // seperate order, items, models, slots, assetspartner and assetscustomer
             $koObj = null;
             $koKey = $oId = $cId = $iId = $mId = $sId = $apId = $acId = '';

             while ($a = $r->assoc()) {

                 if (isset($a['koKey']) // order key exists once
                     && $koKey == 0) {
                     $koKey = $a['koKey'];
                     $koObj = new KptKey;
                     $koObj->key = $koKey;
                 }

                 if ($oId <> $a['oId']) { // new order content
                     $oId = $a['oId'];
                     $this->dbFill('o', $a);
                     if (is_a($koObj, 'KptKey')) { // link in key for order
                         $koObj->oid = $this->id;
                         $this->key = $koObj;
                     }
                 }

                 if ($cId <> $a['cId']) { // new customer
                     $cId = $a['cId'];
                     if (isset($this->customer))
                         throw new Exception('Multiple Customers on Order ['.$a['cId'].'-'.$a['cKey']);
                     $this->customer = new Customer;
                     $this->customer->dbFill('c', $a);
                 }

                 if ($iId <> $a['iId']) { // new item
                     $iId = $a['iId'];
                     $i = new Item;
                     $i->dbFill('i', $a);
                     $this->items[$a['iSeq']] = $i;
                 }

                 if ($mId <> $a['mId']) { // new model
                     $mId = $a['mId'];
                     $m = new Model;
                     $m->dbFill('m', $a);
                     $i->model = $m;
                 }

                 if ($sId <> $a['sId']) { // new slot
                      $sId = $a['sId'];
                     $m->assets[$a['sName']] = array('sid' => $sId);
                 }

                 if ($apId <> $a['apId']) { // new asset from partner
                     $apId = $a['apId'];
                     if (isset($apId)) {
                         $ap = new Asset;
                         $ap->dbFill('ap', $a);
                         $m->assets[$a['sName']]['p'] = $ap;
                     }
                     else {
                         $apId = 0; // empty
                     }
                 }
                 if ($acId <> $a['acId']) { // new asset from customer */
                     $acId = $a['acId'];
                     if (isset($acId)) {
                         $ac = new Asset;
                         $ac->dbFill('ac', $a);
                         $m->assets[$a['sName']]['c'] = $ac;
                     }
                     else {
                         $acId = 0; // no customer asset
                         if (! isset($a['apId'])) { // no partner asset
                             $m->assets[$a['sName']] = array(); // empty asset
                         }
                     }
                 }
             }
         }
    }

  } // class Order