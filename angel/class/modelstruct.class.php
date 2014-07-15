<?php
  /**
   *  Struct carries UOS specifics for a model
   *  
   *  The main reason for this layer of object is that the evolution
   *  of uos is not predictable. The storefront may want to enhance
   *  this model or conform to new information in the structure as
   *  work goes on. By encasing the values in a serialized object the
   *  meaning and processing routines can change without having to
   *  change the actual database content.
   *  
   *  @author Grant Tegtmeier <Grant.Tegtmeier@RPIPrint.com>
   *  @package angel
   *  @copyright Copyright (c) 2013 Reischling Press Inc
   */
 class ModelStruct extends Rpi {

    public $version = 1;

    public $slots = array();

    public function page($name) {
        return 1;
    }

    public function pageStart($name) {
        return null;
    }

    public function pageEnd($name) {
        return null;
    }

    public function rotation($name) {
        return null;
    }

    public function pickUrl($array) {

        if (! is_array($array)) 
            return '--struct non-array--';

        if (array_key_exists('c', $array))
            return $this->wrapUrl($array['c']->val);

        if (array_key_exists('p', $array))
            return $this->wrapUrl($array['p']->val);

        return '--struct empty--';
    }

    public function wrapUrl($path) {
        return 'http://'.$_SERVER['HTTP_HOST'].strstr($path, '/assets/');
    }

  } // struct
?>
