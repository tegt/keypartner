<?php
  /**
   *  Simple database object wrapper for mysqli
   * 
   *  It provides Result objects and throws exceptions as appropriate.
   *
   *  @author Grant Tegtmeier <Grant@Tegt.com>
   *  @copyright Copyright (c) 2011 Grant Tegtmeier eLimn LLC
   *  @package dbomy
   */

class DboMy extends mysqli {

    /** Construct object
     */
    function __construct($host, $user='', $pass='', $db='') {
        if ($user == '') { // no user assume $host is really a URI
            $p = parseUri($host);
            if ($p['scheme'] <> 'mysqli')  {
                @parent::__construct($host, $user, $pass, $db);
            }
            @parent::__construct($p['host'], $p['user'], $p['pass'], $p['path'][0],
                                $p['port']<>''? $p['port']: ini_get('mysqli.default_port'));
        }
        if (mysqli_connect_error()) {
            throw new Exception('Connect Error (' . mysqli_connect_errno() . ') '
                . mysqli_connect_error());
        }
    }

    /**
     *  Runs a SQL statement against the this objects database.
     *  
     *  @param string $stmt The SQL to execute
     *  @return Result object from execution
     */
    function run($stmt) {
        global $debugLastBegSec, $debugLastUBegSec, $debugLastMicrosec, $DebugOmy;
        $debugLastMicrosec = -1.0;
        list($debugLastBegUSec, $debugLastBegSec) = explode(' ',microtime());

        $try=@$this->query($DebugOmy = $stmt);

        if ($try)
            return new Result($this, $try);
        throw new Exception
            ('SQL error: '
             .str_replace
             ('You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use',
              '',$this->error)
             ."\nWhile executing--"
             .$stmt."--");
    }

    /** Use esc and add a pair of 's
     *
     *  Simply to make  things more readable.
     *
     *  @param    string   Any input string
     *  @returns  validly encoded string
     */
    function esq($string) {
        return "'".$this->escape_string($string)."'";
    }

    /** Use real_escape_string as esc for readability
     *
     *  Simply to make  things more readable.
     *
     *  @param    string   Any input string
     *  @returns  validly encoded string
     */
    function esc($string) {
        return $this->escape_string($string);
    }

    /** Syntactic sugar for a DB value list
     *  
     *  @param strings (*) - (any number of params)
     *  @returns string ' VALUES ('.list0,.. .') ' 
     */
    function values() {
        return ' VALUES ('.implode(', ', func_get_args()).') ';
    }


    /** Builds a DB value list for properties
     *  
     *  @param string $property name (any number of params)
     *  @returns string of values quoted and slashed for a DB statement.
     */
    function valuesArray($list) {
        $ret = '';
        foreach($list as $p) {
            $ret .= $this->$p == ''?
                ', DEFAULT':
                ", '".$this->esc($this->$p)."'";
        }
        return substr($ret,2);
    }

    /** Builds a DB value list for properties
     *  
     *  @param string $property name (any number of params)
     *  @returns string of values quoted and slashed for a DB statement.
     */
    function valueList() {
        $list = func_get_args(); // list as given
        return $this->valueArray($list);
    }


    /** Builds a DB value list for properties
     *  
     *  @param string $property name (any number of params)
     *  @returns string of values quoted and slashed for a DB statement.
     */
    function valueArray($list) {
        $ret = '';
        foreach($list as $p) {
            $ret .= $this->$p == ''?
                ', DEFAULT':
                ", '".$this->esc($this->$p)."'";
        }
        return substr($ret,2);
    }

    /** Conditions to an array of arrays or objects
     *  
     *  Wraps single array or obj in array.
     *  
     *  @param string $in item to condition
     *  @return Result object from execution
     */
    function condAO(&$in) {
        if (is_array($in)) {
            $e = end($in);
            if ($e === false) return NULL;
            if (is_object($e) || is_array($e)) {
                return $in;
            }
            else {
                return array($in);
            }
        }
        elseif (is_object($in)) {
            return array($in);
        }
        else {
            throw new Exception('Invalid input '.__class__.'; Expected array of arrays or objects.');
        }
  }
    /**
     *  Runs a multi-row REPLACE/INSERT from an array or object.
     *  
     *  Constructs and runs an REPLACE statement where each key or
     *  property is a field. If $in is a array of arrays or objects
     *  then produces an row for each item in the array.
     *  
     *  @param string $op 'INSERT' or 'REPLACE'
     *  @param string $table The table name
     *  @param array $in an Object, keyed array or an array of either
     *  @return Result object from execution or NULL if count($in) == 0
     */
    function mapIR ($op, $table, $in) {
        if(is_null($add = $this->condAO($in))) return NULL;
        $sql = "$op $table ("
            .implode(',', array_keys((array)end($add)))
            .") VALUES ('";
        foreach ($add as $a) { // new data row
            $sql .= implode("','", array_map('addslashes',(array)$a))."'),('";
        }
        return $this->run(substr($sql,0,-3));
    }

    /**
     *  Runs a multi-row insert from an array or object.
     *  
     *  Constructs and runs an INSERT statement where each key or
     *  property is a field. If $in is a array of arrays or objects
     *  then produces an row for each item in the array.
     *  
     *  @param string $table The table name
     *  @param array $in an Object, keyed array or an array of either
     *  @return Result object from execution
     */
    function mapInsert ($table, $in) {
        return $this->mapIR('INSERT', $table, $in);
    }

    /**
     *  Runs a multi-row REPLACE from an array or object.
     *  
     *  Constructs and runs an REPLACE statement where each key or
     *  property is a field. If $in is a array of arrays or objects
     *  then produces an row for each item in the array.
     *  
     *  @param string $table The table name
     *  @param array $in an Object, keyed array or an array of either
     *  @return Result object from execution
     */
    function mapReplace ($table, $in) {
        return $this->mapIR('REPLACE', $table, $in);
    }

    /** Runs a REPLACE/INSERT omitting names not in table (caseful)
     *  
     *  Constructs and runs an REPLACE/INSERT statement only for keys
     *  or properties which completely match column names.
     *
     *  @param string $op 'INSERT' or 'REPLACE'
     *  @param string $table The table name
     *  @param array $in an Object, keyed array or an array of either
     *  @return Result object from execution
     */
    function matchIR ($op, $table, $in) {
        $fields = $this->mapRows("DESCRIBE $table", "Field");
        $same = array_intersect_key((array)$in, $fields);
        return $this->mapIR ($op, $table, $same);
    }

    /**
     *  Runs a single Insert but only on matching keys
     *  
     *  Constructs and runs an INSERT statement 
     *  
     *  @param string $table The table name
     *  @param array $in an Object, keyed array or an array of either
     *  @return Result object from execution
     */
    function matchInsert ($table, $in) {
        return $this->matchIR('INSERT', $table, $in);
    }

    /**
     *  Runs a multi-row REPLACE from an array or object.
     *  
     *  Constructs and runs an REPLACE statement where each key or
     *  property is a field. If $in is a array of arrays or objects
     *  then produces an row for each item in the array.
     *  
     *  @param string $table The table name
     *  @param array $in an Object, keyed array or an array of either
     *  @return Result object from execution
     */
    function matchReplace ($table, $in) {
        return $this->mapIR('REPLACE', $table, $in);
    }

    /**
     *  Number of rows affected by the last INSERT, UPDATE, REPLACE or
     *  DELETE
     *
     * @returns int number of rows or FALSE on error
     */
    function affectedRows(){
        return affected_rows($this);
    }

    /** Retrieves the Id generated for an AUTO_INCREMENT column by the
     *  previous INSERT query.
     *  
     *  @param int check that these many rows were affected if given
     *  @returns int id generated for last auto inc group
     */
    function insertId($num=null) {
        if (isset($num)) {
            $was = $this->affectedRows();
            if ($was <> $num) {
                throw new Exception("Database Update ERROR: expected '$num' changes observed '$was'");
            }
        }
        $insId=$this->insert_id;
        if($insId==0) {
            throw new Exception('Error getting insert ID');
        }
        return $insId;
    }

    /** Runs a multi-row inactivate from an array of objects.
     *  
     *  Constructs and runs an UPDATE statement which sets `active` to
     *  0 where all properties of each $in match and active isn't already 1.
     *  
     *  @param string $table The table name
     *  @param array $in an Object, keyed array or an array of either
     *  @return Result object from execution
     */
    function deactivate ($table, $in) {
        if(is_null($dis = $this->condAO($in))) return NULL;
        $sql = "UPDATE $table SET active = 0 WHERE active = 1 AND (0";
        foreach ($dis as $it) {
            $sql .= ' OR ('; 
            foreach ($it as $k=>$v) {
                $sql .= "$k='".addslashes($v)."' AND ";
            }
            $sql .= '1)';
        }
        $sql .= ')';
        return $this->run($sql);
    }

    /** Fetch and map a table in one operation
     *  
     *  Uses args to construct a query and do a $Result->mapRows on the
     *  result.
     *  
     *  @param string $table name or a full sql statment
     *  @param string $col column to index by, added to list unless sql given
     *  @param mixed $list column names, array or ',' sep string, default '*'
     *  @param string $where content of the where clause and any following
     *  @return array of objects indexed by value of cols, col=null unindexed
     */
    function mapRows($table, $col=null, $list='', $where='') {
        if (strpos($table, ' ') === false) { // not query, build one
            $list = is_array($list)? implode(',',$list): $list;
            $list = $list == ''? '*': $list;
            $listby = isset($col)? (','.$col): '';
            $where = $where <> ''? 'WHERE '.$where: '';
            $table = "SELECT $list $listby FROM $table $where";
        }
        $r = $this->run($table);
        return $r->mapRows($col);
    }
  }

?>
