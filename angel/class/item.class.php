<?php
  /**
   *  Item information
   *  
   *  @author Grant Tegtmeier <Grant@Tegt.com>
   *  @copyright Copyright (c) 2013 Grant Tegtmeier eLimn LLC
   *  @package keypartner
   */

 class Item extends Kpt {

    /** Reads a partner object from the db
     *
     *  @param int $seed int is items id
     *  @returns string error message, null for no error 
     */
    function __construct($seed=null) {
        global $DBO;
        if (isset($seed)) {
            if (isIndex($seed)) { // seed is an index
                $s = 'SELECT * FROM items'
                    .' WHERE iId='.(int)$seed;
                $this->dbFill('i', $DBO->run($s)->assoc()); // extract matching names
            }
        }
    }

    /**
     *  This items #
     *  
     *  @var int
     */
    public $id;

    /**
     *  Items Order id
     *  
     *  @var int
     */
    public $oId;

    /**
     *  Items Model id
     *  
     *  @var int
     */
    public $mId;

    /**
     *  Sequence # in order
     *  
     *  @var int
     */
    public $seq;

    /**
     *  # of copies
     *  
     *  @var int
     */
    public $copies = 1;

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
     *  item sttus
     *  
     *  @var string
     */
    public $status;

    /**
     *  uosId #
     *  
     *  @var int
     */
    public $uosid;

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
