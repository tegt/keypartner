<?php
/**
 *  Holds information common to all people.
 *  
 *  @author Grant Tegtmeier <Grant.Tegtmeier@RPIPrint.com>
 *  @package angel
 *  @copyright Copyright (c) 2013 Reischling Press Inc
 */

class Person extends Addr {

    /**
     *  Full name
     *  
     *  @var string
     */
    public $name;

    /**
     *  Company
     *  
     *  @var string
     */
    public $company;

    /**
     *  Any set of 10 or more digits + opt: x and digits.
     *  
     *  @var string
     */
    public $phone;

    /**
     *  email address 
     *  
     *  @var string
     */
    public $email;

    /** Validates a property
     *  @param string name of property
     *  @returns string message
     */
    function need($p) {
        $v = trim($this->$p);
        $this->$p = $v;
        switch ($p) {
        case 'name':
            $pat = "[A-Za-z]+(\'[A-Za-z]+)?(\s*\-?\s*[A-Za-z]+)?";
            break;
        case 'company':
            $pat = "\w[-\w\'\.]*(\s*[-\w\'\.]+)*";
            break;
        case 'phone':
            $pat = '(1-?)?(\([2-9]\d{2}\)|[2-9]\d{2})\s*-?\s*[2-9]\d{2}\s*-?\s*\d{4}';
            break;
        case 'email':
            $pat ='[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}';
            break;
        default:
            return parent::need($p);
        }
        return $this->needErr($pat, $v);
    }
}
?>
