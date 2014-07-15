<?php
  /**
   *  Holds information common to all addresses.
   *  
   *  @author Grant Tegtmeier <Grant@Tegt.com>
   *  @copyright Copyright (c) 2009 Grant Tegtmeier eLimn LLC
   *  @package person
   */

class Addr extends Kpt {

    /**
     *  Street line of address 1.
     *  
     *  @var string
     */
    public $addr2;

    /**
     *  Street line of address 2.
     *  
     *  @var string
     */
    public $addr1;

    /**
     *  City
     *  
     *  @var string
     */
    public $city;

    /**
     *  State
     *  
     *  @var string
     */
    public $state;

    /**
     *  Postal code (zip or foriegn)
     *  
     *  @var string
     */
    public $postal;


    /** Validates a property
     *  @param string name of property
     *  @returns string error message, '' for no error or null for unknown
     */

    function need($p) {
        $v = trim($this->$p);
        switch ($p) {
        case 'addrStreet':
            $pat = '[\w\s.,@&\-#*]*?[A-Za-z]{2}[\w\s.,@&\-#*]*';
            break;
        case 'addrCity':
            $pat = '[a-z\s.-]*?[A-Za-z]{2}[a-z\s.-]*';
            break;
        case 'addrState':
            $pat = '[A-Za-z]{2}';
            break;
        case 'addrZip':
            $pat = '\~?\d{5}(-\d{4})?(\~\d{1,3})?';
            break;
        default:
            return parent::need($p);
        }
        return $this->needErr($pat, $v);
    }

  }
?>
