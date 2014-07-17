<?php
  /**
   *  Functionality common to all KPT classes
   *
   *  @author Grant Tegtmeier <Grant@Tegt.com>
   *  @package keypartner
   *  @copyright Copyright (c) 2013 Grant Tegtmeier for eLimn LLC
   */
abstract class Kpt {

    /** Fills an object's properties from database names
     *
     *  @param string $pre This string is prepended db property name
     *  @param array $dbList an associative array keyed in lower case
     */

    function dbFill($pre, $dbList) {
        $preLen = strlen($pre);
        $list = array();
        foreach ($dbList as $key=>$val) {
            if (substr($key, 0, $preLen) === $pre) {
                $list[strtolower(substr($key,$preLen))] = $val;
            }
        }
        foreach ($this as $prop=>$val) {
            $lProp = strtolower($prop);
            if (array_key_exists($lProp, $list)) {
                $this->$prop = $list[$lProp];
            }
        }
    }

    /** Import all scalars from the given object to this one
     *
     *  N.B. this is an non-matching form. Use {@link Foot::shoe()} to
     *  copy all content that matches properties which already
     *  exists. Use importScalar() to copy and add all properties
     *  which are not complex whether or not they exist.
     */
    function importScalars($o) {
        // Add all scalars from $o
        foreach ($o as $prop=>$val) {
            if (is_scalar($val))
                $this->$prop = $val; // add to template
        }
    }

    /** Fall thru for needed properties
     *  @returns array string messages
     */
    function need($p) {
        return null;
    }

    /** Validates properties in php
     *  
     *  Chains through all properties recursing on object properties
     *  and calling ->need('name') on others. Need error messages are
     *  assembled as arrays inside of object msg arrays for return.
     *  
     *  @param array of optional property names (recurs for objs)
     *  @returns array nested string messages 'prop_name'=>'err msg'
     */
    function optional($opt=array()) {

        if (!is_array($opt)) 
            $opt = array($opt);

        $errs = array();        // no error messages yet
        foreach ($this as $p=>$v) { // each property value

            if ($this->$p <> ''            // not empty or
                || ! in_array($p, $opt)) {  // not optional - check it

                if (! is_object($v) && ! is_array($v)) { // property is scaler
                    $m = $this->need($p);
                    if (strlen($m) > 0) {
                        $errs[$p] = $m; // error in property
                    }
                }
            }
        }
        return $errs;
    }

    /** Return error message for pattern checks */
    function needErr($pat, $v) {
        if (preg_match("/^$pat$/",$v))
            return '';
        if ($v == '')
            return "missing";
        return  "invalid";

    }

    /** Instantiate or update object in db
     *
     *  @param string $pre item prefix 
     *  @param string $table name to take insert
     *  @param array $except fields to be ignored
     *  @returns key of inserted element
     */
    function write($table, $pre='', $except=array()) {
        global $DBO;

        $except['stamp'] = -1; // never force stamp
        $names = array();
        $values = array();

        foreach ($this as $p=>$v) {
            if (($alt = $except[$p]) <> '') { // use alternate name
                    $p = $alt;                
                    if ($p == -1) { // skip over if alt is -1
                        continue;
                    }
            }
            if (isset($v)) {

                if (is_object($v)
                    || is_array($v)) continue; // skip objects and arrays

                if (! dbNum($v))
                    $v = $DBO->esq($v); // escape and quote if not a number
            }
            else {
                $v = 'DEFAULT';
            }
            $names[] = $pre.$p;
            $values[] = $v;
        }

        if (isIndex($this->id)) { // build update
            $s = 'UPDATE `'.$table
                .'` SET ';
            for ($i=0; $i < count($names); $i++) {
                $s .= '`'.$names[$i].'`='.$values[$i].', ';
            }
            $s = substr($s, 0, -2)
                .'  WHERE '.$pre.'id='.(int)$this->id;
            $DBO->run($s);
            return $this->id;
        }
        else { // build insert
            $s = 'INSERT INTO `'.$table
                .'` (`'.implode('`, `', $names).'`)'
                .' VALUES ('.implode(', ', $values).')';

            return $this->id = $DBO->run($s)->insertId();
        }
    }

    /** Output a JSON encoded reply */
    static function jsonExit($reply) {
        header("Content-Type: application/json");  
        echo json_encode($reply);
        exit;
    }

  } // Class Kpt

?>
