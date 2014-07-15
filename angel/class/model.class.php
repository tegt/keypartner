<?php
  /**
   *  Model information
   *  
   *  @author Grant Tegtmeier <Grant@Tegt.com>
   *  @copyright Copyright (c) 2013 Grant Tegtmeier eLimn LLC
   *  @package keypartner
   */

 class Model extends Kpt {

    /** Reads a partner object from the db
     *
     *  @param int $seed int is items id
     *  @param int $iId order item id for customer slots
     *  @returns string error message, null for no error 
     */
    function __construct($seed=null, $iId=0) {
        global $DBO;
        if (isset($seed)) {

             if (isIndex($seed)) { // seed is an index
                 $s = 'SELECT * FROM models'
                     .' LEFT JOIN slots ON smId=mmId'
                     .' LEFT JOIN assetspartner ON appId=mpId AND apmId=mId AND apsId=sId'
                     .' LEFT JOIN assetscustomer ON acsId=sId AND aciId='.$iId
                     .'   WHERE mId='.(int)$seed;
             }

             elseif (KptKey::check($seed)) { // seed must be a key
                 $s = 'SELECT * FROM keysmodel'
                     .' JOIN models ON kmMId=mId'
                     .' LEFT JOIN slots ON smId=mmId'
                     .' LEFT JOIN assetspartner ON mpId=appId AND apmId=mId AND apsId=sId'
                     .' LEFT JOIN assetscustomer ON acsId=sId AND aciId='.$iId
                     .'   WHERE kmKey='.$DBO->esq($seed);
             }
             else { // empty object
                 return;
             }

             $r = $DBO->run($s); // fetch full model

             // seperate models, slots, assetspartner and assetscustomer
             $kmKey = $mId = $sId = $apId = $acId = '';

             while ($a = $r->assoc()) {

                 if (isset($a['kmKey']) // model key exists once
                     && $kmKey <> $a['kmKey']) {
                     $kmKey = $a['kmKey'];
                     $kmObj = new KptKey;
                     $kmObj->key = $kmKey;
                     $kmObj->mid = $a['mId'];
                 }

                 if ($mId <> $a['mId']) { // new model
                     $mId = $a['mId'];
                     $this->dbFill('m', $a);
                     
                     if (is_a($kmObj, 'KptKey')) { // link key we came in on
                         $this->keys[0] = $kmObj;
                     }
                     $this->assets = array();
                 }

                  if ($sId <> $a['sId']) { // new slot
                      $sId = $a['sId'];
                     $this->assets[$a['sName']] = array('sid' => $sId);
                 }

                 if ($apId <> $a['apId']) { // new asset from partner
                     $apId = $a['apId'];
                     if (isset($apId)) {
                         $ap = new Asset;
                         $ap->dbFill('ap', $a);
                         $this->assets[$a['sName']]['p'] = $ap;
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
                         $this->assets[$a['sName']]['c'] = $ac;
                     }
                     else {
                         $acId = 0; // empty
                     }
                 }
             }


        }
    }

    /**
     *  This Models #
     *  
     *  @var int
     */
    public $id;

    /**
     *  This Models keys (1 in located by key)
     *  
     *  @var int
     */
    public $keys = array();

    /**
     *  Master Model id
     *  
     *  @var int
     */
    public $mId;

    /**
     *  Partner id
     *  
     *  @var int
     */
    public $pId;

    /**
     *  Model Name
     *  
     *  @var int
     */
    public $name;

    /**
     *  Model uos Part Number
     *  
     *  @var int
     */
    public $partNum;

    /**
     *  Model PrintFlo Part
     *  
     *  @var string
     */
    public $printFloPart;

    /**
     *  Model Structure
     *  
     *  @var string
     */
    public $structure;

    /**
     *  OEM Cost in pennies
     *  
     *  @var int
     */
    public $cost;

    /**
     *  Row date stamp
     *  
     *  @var string
     */
    public $stamp;

    /** Validates a property
     *  @param string name of property
     *  @returns string error message, null for no error 
     */

    function need($p) {
        $v = trim($this->$p);
        switch ($p) {
        case 'pid':
            $pat = '[1-9][0-9]*';
            break;
        default:
            return null;
        }
        if (preg_match("/^$pat$/",$v))
            return '';
        return "\"$v\" is not valid";
    }

  }
?>
