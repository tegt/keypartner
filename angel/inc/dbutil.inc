<?php //-*-php-*-
/** System wide data utility functions
 *  
 *  @author Grant Tegtmeier <Grant@Tegt.com>
 *  @package dbomy
 *  @copyright Copyright (c) 2009 Grant Tegtmeier for eLimn LLC
 */

  /** Uses the syslog facility to present message and some php context.
   *  @param $msg string the message to be recorded
   *  @returns bool got it out
   */
function userLog($msg) {
    openlog($_SERVER['HTTP_HOST'].'|'.$_SERVER['PHP_SELF'], LOG_USER);
    syslog($msg);
  }

/** parses URI similar to parse_url
 *
 *  * scheme - e.g. http
 *  * host
 *  * port
 *  * user
 *  * pass
 *  * path - an array of names ending with '' if theres a final /
 *  * query - an assoc. array of key => value (=> NULL if no =) 
 *  * fragment - after the hashmark
 *
 *  @param URI string 
 *  @returns array associating part names to thier content
 */

function parseUri($uri) { 
    $a = parse_url($uri);
    $a['path'] = explode('/',$a['path']);
    array_shift($a['path']); // chuck initial NIL

    $aqs = explode('&',$a['query']);
    $kvs = array();
    foreach ($aqs as $q) {
        $x = explode('=', $q, 2); // only first =
        $kvs[$x[0]] = $x[1];
    }
    unset($kvs['']); // chuck any empties
    $a['query'] = $kvs;

    return $a;
}

/** connectURL
 *  @param resource database connection
 *  @returns connection or throws exception
 */
function connectDbUri($uri) { 

    $a = parseUri($uri);

    if ($a['scheme'] <> "mysql" && $a['scheme'] <> "mysqli") {
        throw new Exception("URI: mysql or mysqli not specified in database connection string.");
    }

    //@TODO including these global vars is a hack to support bad SMS code
    global $database, $user, $password, $host, $port;
    $GLOBALS['database'] = $a['path'][0];
    $GLOBALS['user'] = $a['user'];
    $GLOBALS['password'] = $a['pass'];
    $GLOBALS['host'] = $a['host'];
    $GLOBALS['port'] = $a['port'];

    $connection = @mysql_connect( $host . ":" . $port, $user, $password );
    if(! $connection) 
        throw new Exception("Could not connect to data source.");
    $dbIsSelected = mysql_select_db($database, $connection);
    if(! $dbIsSelected) 
        throw new Exception("Could not select specific data source.");

    return $connection;
}

/**
 *  Utility funciton to check user input that will be used in a LIKE.
 *
 *  The return is escaped for use by mysql with special meaning
 *  escaped on _ and %. It also returns undefined as ''. You may want
 *  to pre/append % to the result to create a match begin, end or
 *  anywhere result.
 *  
 *  $param string $s to be made LIKE safe
 *  $return string fully escaped for LIKE and MySql characters
 */
function likable($s) {
    if (is_null($s) or $s == '') return '';
    return str_replace(array('_','%'),array("\\_","\\%"),
                       mysql_real_escape_string($s));
}

/** Produces AND LIKE string or nothing
 *  
 *  $param string $s '' returned, or used as LIKE target
 *  $param string $b before $s in LIKE, default '%' 
 *  $param string $a after $s in LIKE, default '%' 
 *  $return string fully escaped for LIKE and MySql characters
 */
function andLikable($field, $s, $b = '%', $a = '%') {
    if ($s == '') return '';
    return " AND $field LIKE ('".$a.likeable($s).$a."')";
}

/** Produces 'AND ( $left $right[0] OR... )' 
 *  
 *  This primarily useful for a LIKE claus. See {@link andIn()} for
 *  non-LIKE operation combination.
 *
 *  $right may be an array, a
 *  simple scaler, or a string with $break (,) characters.  Note andIn()
 *  or 'NOT ('.andIn().') are more effecient for = and !=
 *  
 *  @param string $left the field/expression to be repeated
 *  @param mixed $right target(s) to be ORed may be scaler, if '' returns ''
 *  @param string $break (!array($right) & break <> '')? explode, default ','
 *  @param string $pre prepended to each right
 *  @param string $app appended to each right
 */
function andOrChain($left, $right, $pre='', $app='%', $break=',') {
    if ($right == '') return ''; 
    if (is_string($right) && $break <> '')
        $right = explode($break, $right);
    if (!is_array($right))
        $right = array($right);
    return " AND ( $left '$pre".implode("$app' OR $left '$pre",$right)."$app' ) ";
}

/** This funciton checks for a proper index as numeric, integer and
 *  positive
 *  
 *  @param mixed $i item to be tested.
 *  @return boolean
 */
function isIndex($i) {
    return is_numeric($i) && is_int($i+0) && $i>0;
}

/** This funciton checks for proper numbers to a database
 *  
 *  @param mixed $i item to be tested.
 *  @return boolean
 */
function dbNum($i) {
    $s = (string)$i;
    if (ctype_digit($s))
        return true; // integer

    if ($s[0] == '+' || $s[0] == '-')
        return dbNum(substr($s,1)); // signed

    $a = explode('.', $s);
    $b = explode('e', $a[1]);

    if (! ctype_digit($a[0].$b[0]))
        return false; // non-digit content

    if ($b[1][0] == '+' || $b[1][0] == '-')
        $e = substr($$b[1],1);

    return (ctype_digit($e)); // exponent
}

/** This funciton returns an =, IN() OR multiple operator terms
 *
 *  If $values is '' or an empty array '' is returned. If $values is a
 *  string it is exploded by $break (,) and used as an array. If any
 *  array value begins with ">", "<", ">=" or "<=" it is used as a
 *  comparison value and ANDed. Other values and those beginning "="
 *  are included as an IN clause which is ORed if needed.
 *  
 *  @param string $field name in DB
 *  @param mixed $values
 *  @return string = or IN expression if valid, else ''
 */
function andIn($field, $values, $break = ',') {
    if ($values == '') return '';
    if (is_string($values) && strpos($values, $break) > 0) {
        $values = explode($break, $values);
    }
    if (isset($values) && !is_array($values)) {
        $values = array($values);
    }
    if (!$values) return ''; // empty array
    $and = $in = array();
    foreach ($values as $v) {
        $c = substr($v,0,1);
        switch ($c) { // seperate operations from constants
        case '<': case '>':
            $c = $field.$c;
            if (substr($v,1,1) == '=')
                $and[] = $c."='".substr($v,2)."'";
            else
                $and[] = $c."'".substr($v,1)."'";                    
            break;
        case '=':
            $v = substr($v,1);
        default:
            $in[] = $v;
        }
    }
    if ($in)
        $in = "$field IN ('"
            .implode("','",
                     array_map('addslashes',
                               array_unique($values)))."')";
    if ($and)
        $and = implode(" AND ",$and);

    if (is_array($in))
        return ' AND '.$and;

    if (is_array($and))
        return ' AND '.$in;

    return ' AND ('.$in.' OR ('.$and.'))';
}

/** Fetches central time from the database
 *  @returns string 'YYYY-MM-DD hh:mm:ss'
 */
function dbTime() {
    global $DBO;
    $i = $DBO->mapRows('select now() as x');
    return $v = $i[0]->x;
}

/** Php version of the DB IFNULL()
 *  
 *  @param mixed $test the value to be tested
 *  @param mixed $use the value returned if $test is null
 *  @returns mixed if $test is null $use, else $test
 */
function ifnull($test, $use) {
    return is_null($test)? $use: $test;
}

/** ifnil works like DB ifnull but allows nil, '', also
 *  
 *  @param mixed $test the value to be tested
 *  @param mixed $use the value returned if $test is nil
 *  @returns mixed if $test is '' $use, else $test
 */
function ifnil($test, $use) {
    return $test == ''? $use: $test;
}


/** Generates a DB check for a given datetime range
 *  
 *  For objects that enter a range into a single string
 *  
 *  @param string $range the given range
 *  @param string $beg the database field for start
 *  @param string $end the database field for end (default = $beg)
 *  @returns string AND expression to check range or '' if none.
 */
function dateRange($range, $beg, $end=null) {
    $r = '';
    if (is_null($end)) $end = $beg;
    $a = explode('|',$range);
    if (count($a) > 2) return $r;
    $after = strtotime($a[0]);
    if ($after) {
        $r = " AND $beg >= ".date("'Y-m-d'",$after);
    }
    $before = strtotime($a[1]);
    if ($before) {
        $r .= " AND $end <= ".date("'Y-m-d'",$before);
    }
    return $r;
}

/** Key Tree - arrange all keys into a tree
 *
 *  @param array $assoc array with full keys 
 *  @param string $sep seperator chars within keys
 *  @returns oject-tree by segments $o->seg1->seg2->value='full-name'
 */
function keyTree($assoc, $sep='_') {
    $r = new stdClass;
    foreach ($assoc as $key => $val) {
        $levels = explode($sep, $key);
        $o = $r;
        foreach ($levels as $lName) {
            if (! isset($o->$lName))
                $o->$lName = new stdClass;
            $o = $o->$lName;
        }
        $o->preKey = $key;
    }
    return $r;
}

/** Php key check
 *  @param mixed $a usually an array
 *  @returns bool false iff empty, not array or any non-integer keys
 */
function hasKeys($a) {
    if (!is_array($a) || !$a) return false;
    foreach ($a as $k=>$v) {
        if (!is_numeric($k)) return true;
    }
    return false;
}

/** Break camel case names into seperated words all upper cased
 *  
 *  Also handles _ - and + seperators
 *  
 *  @param mixed $a string, array or object
 *  @returns mixed string, or array of names 
 */
function camelBreak($a)  {
    if (!is_array($a) && !is_object($a))
        return ucwords
            (preg_replace
             ('/(\s*)([A-Z])/', " $2", 
              trim
              (str_replace
               (array
                ('-', '_', '+'),
                ' ', $a)
               )
              )
             );
    foreach ($a as $i) {
        $r[] = camelBreak($i);
    }
    return $r;
}

/** Natural Index
 *  
 *  Creates a natural order index string by breaking a string into
 *  numeric and non-numeric sequeces. It returns the string
 *  reassembled but with all of the number sequeces padded out to "N"
 *  number of digits (defualt 6). The point is that these can be
 *  sorted normally into the "human readable" form. 
 *  
 *  @param string $a the input index
 *  @param int $d (default 6) number of digits to pad out to
 *  @returns string
 */
function natIndex($n, $d=6)  {
    preg_match_all('/(\D*)(\d*)/',$n,$a);
    $f = '%0'.$d.'d';
    $r = '';
    for ($i=0; $i < count($a[1]); $i++) {
        $r .= $a[1][$i];
        if ($a[2][$i] <> '')
            $r .= sprintf($f,$a[2][$i]);
    }
    return $r;
}

?>
