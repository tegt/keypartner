<?php
  /**
   *  Partner information
   *  
   *  @author Grant Tegtmeier <Grant@Tegt.com>
   *  @package keypartner
   *  @copyright Copyright (c) 2013 Grant Tegtmeier for eLimn LLC
   */

 class Partner extends Person {

    /** Reads a partner object from the db
     *
     *  @param mixed $seed int is id while string is a key
     */
    function __construct($seed=null) {
        global $DBO;
        if (isset($seed)) {
            if (isIndex($seed)) { // seed is an index
                $s = 'SELECT * FROM partners'
                    .' WHERE pId='.(int)$seed;
            }
            else { // seed must be a key
                $s = 'SELECT * FROM keyspartner'
                    .' JOIN partners ON kpPid=pid'
                    .' WHERE kpKey='.$DBO->esq($seed);
            }

            $a = $DBO->run($s)->assoc();

            $this->key = null;
            if (isset($a['kpKey'])) { // if key add object
                $this->key = new KptKey;
                $this->key->key = $a['kpKey'];
                $this->key->pid = $a['pId'];
            }
            $this->dbFill('p', $a); // extract matching names
        }
    }


    /**
     *  This partners #
     *  
     *  @var int
     */
    public $id;

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
