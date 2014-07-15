<?php
  /**
   *  Customer information
   *  
   *  @author Grant Tegtmeier <Grant.Tegtmeier@RPIPrint.com>
   *  @package angel
   *  @copyright Copyright (c) 2013 Reischling Press Inc
   */
 class Customer extends Person {

    function __construct($seed=null) {
        if (isset($seed)) {
            global $DBO;
            $this->dbFill ('c', 
                           $DBO->
                           run('SELECT * FROM customers'
                               .' WHERE cId='.(int)$seed
                               )->
                           assoc() ); // extract matching names
        }
    }

    /**
     *  This customers #
     *  
     *  @var int
     */
    public $id;

    /**
     *  Partner id of owner
     *  
     *  @var int
     */
    public $pid;

    /**
     *  Partner reference string
     *  
     *  @var string
     */
    public $pref;

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
        default:
            return parent::need($p);
        }
        return $this->needErr($pat, $v);
    }

  }
?>
