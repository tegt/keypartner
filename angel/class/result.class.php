<?php
  /**
   *  mySqli result wrapper package.
   *  
   *  @author Grant Tegtmeier <Grant@Tegt.com>
   *  @package dbomy
   *  @copyright Copyright (c) 2009 Grant Tegtmeier for eLimn LLC
   */

class Result {

    /**
     *  The DBOhMy that created this result.
     *  @var DboMy holds the open MySql object
     */
    public $dbo;

    /**
     *  The result resource from the original action
     *  @var resource returned from this DboMy action
     */
    public $result;

    public function __construct($dbo, $result) {
        $this->dbo = $dbo;
        $this->result = $result;
    }

    /** Record the time microtime delta since the initial DB
     *  call. This is the actual DB execution time. The values are
     *  left in the globals $debugLastBegSec, $debugLastUBegSec,
     *  $debugLastMicrosec where the first 2 represent the before
     *  values from microtime (allowing further timings) and the
     *  latter is either the microsecond delta until the first result
     *  request or -1.0.
     */
    public function firstTime() {
        global $debugLastBegSec, $debugLastUBegSec, $debugLastMicrosec;
        if ($debugLastMicrosec <> -1.0) return;
        list($debugLastEndUSec, $debugLastEndSec) = explode(' ',microtime());
        $debugLastMicrosec = ($debugLastEndSec - $debugLastBegSec) + ($debugLastEndUSec - $debugLastUBegSec);
    }
    /**
     *  Fetch the next numeric array row or false
     */
    public function row() {
        $this->firstTime();
        return $this->result->fetch_row();
    }

    /**
     *  Fetch the next associative array row or false
     */
    public function assoc() {
        $this->firstTime();
        return $this->result->fetch_assoc();
    }

    /**
     *  Fetch the next object row or false
     */
    public function object() {
        $this->firstTime();
        return $this->result->fetch_object();
    }

    /**Map all rows to std. objects.
     *
     * @param string $key from row used as index, null = 0..n-1
     * @return array of objects keyed by key
     */
    public function mapRows($key=null, $sort=false) {
        $a = array();
        if (isset($key)) {
            while ($row = $this->object()) {
                $a[$row->$key] = $row;
            }
            if ($sort) ksort($a);
        }
        else {
            for ($k = 0; $row = $this->object(); $k++) {
                $a[$k] = $row;
            }
        }
        return $a;
    }

    /**
     *  Seeks and fetches the given row. 
     *    Example: for($row=$r->seek(3); $row; $row=$r->fetch())
     *  
     *  @param int row number
     */
    public function seek($row) {
        $this->firstTime();
        if(!$this->dbo->data_seek($this->result, $row)){
            throw new Exception("Invalid row to seek ('{${print_r($row)}}')");
        }
        return $this->assoc();
    }

    /**
     *  Number of rows affected by the last INSERT, UPDATE, REPLACE or
     *  DELETE
     */
    public function affectedRows(){
        return $this->dbo->affectedRows();
    }

    /**
     *  Retrieves the Id generated for an AUTO_INCREMENT column by the
     *  previous INSERT query.
     */
    public function insertId() {
        $this->firstTime();
        return $this->dbo->insertId();
    }

  }
?>
