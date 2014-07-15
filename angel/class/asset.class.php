<?php
  /**
   *  Model information
   *  
   *  @author Grant Tegtmeier <Grant@Tegt.com>
   *  @copyright Copyright (c) 2013 Grant Tegtmeier eLimn LLC
   *  @package keypartner
   */

 class Asset extends Kpt {

    /** Reads a partner object from the db
     *
     *  @param int $seed int is items id
     *  @returns string error message, null for no error 
     */
    function __construct($seed=null) {
        global $DBO;
        if (isset($seed)) {
            if (isIndex($seed)) { // seed is an index
                $s = 'SELECT * FROM models'
                    .' WHERE iId='.(int)$seed;
                $this->dbFill('m', $DBO->run($s)->assoc()); // extract matching names
            }
        }
    }

    /**
     *  This Assets id
     *  
     *  @var int
     */
    public $id;

    /**
     *  Asset Slot Id
     *  
     *  @var int
     */
    public $sId;

     /**
     *  Model id or Null for Customer Assset
     *  
     *  @var int
     */
    public $mId;

     /**
     *  Partner id or Null for Customer Assset
     *  
     *  @var int
     */
    public $pId;

     /**
     *  Owning item id or null Partner Asset
     *  
     *  @var int
     */
    public $iId;

    /**
     *  Asset Value
     *  
     *  @var string
     */
    public $val;

    /**
     *  Asset mime type
     *  
     *  @var string
     */
    public $mime;

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
