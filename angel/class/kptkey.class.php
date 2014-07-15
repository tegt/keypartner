<?php
  /** KPT key composition/decompsition static class 
   *
   */

define ('KptKeySeed', 0XA98C18E9);

class KptKey {

    /** Compose, decompose and validate key formats
     *
     *  Keys are 'ViiiiiiiiThhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh' where
     *            012345678901234567890123456789012345678901 
     *                      1         2         3         4 
     *        V - version character currently R
     *        i - hex value of index xor'ed with seed
     *        T - Type ('P' or 'I')
     *        h - hash of generation time
     *
     */

    /**
     *  Key value
     *  
     *  @var string
     */

    public $key;

    /**
     *  Id of partner or null
     *  
     *  @var index
     */

    public $pid;

    /**
     *  Id of model or null
     *  
     *  @var index
     */

    public $mid;

    /**
     *  Id of order or null
     *  
     *  @var index
     */

    public $oid;

    /**
     *  Creators Note
     *  
     *  @var string
     */

    public $note;

    /**
     *  Stamp
     *  
     *  @var time
     */

    public $stamp;

    /** Read or generate a new Key
     *
     *  @param  object $seed object needing new key
     *  @param  string $note
     */
    function __construct($seed=null, $note='') {
        global $DBO;
        $this->note = $note;
        $stable = '';
        switch (@get_class($seed)) {

        case 'Partner':
            $this->key = $this->gen($seed->id, 'P');
            $stable = 'keyspartner (kpKey,kpPid,kpNote)';
            break;

        case 'Model':
            $this->key = $this->gen($seed->id, 'M');
            $stable = 'keysmodel (kmKey,kmMid,kmNote)';
            break;


        case 'Order':
            $this->key = $this->gen($seed->id, 'O');
            $stable = 'keysorder (koKey,koOid,koNote)';
            break;

        default:
            break;
        }
        if ($stable > '') {
            $DBO->run('INSERT INTO '.$stable.' VALUES ('
                      .$DBO->esq($this->key).','
                      .$seed->id.','
                      .$DBO->esq($this->note).')');
        }
    }

    /** Return all keys for a object
     *
     *  @param  object seed The Partner or Model for which keys are wanted.
     *  @param  bool onlyValid on return only the valid keys
     *  @returns array possibly empty of key objects.
     */

    static function all($seed=null, $onlyValid=true) {
        global $DBO;
        $sTable = '';

        switch ($sClass = get_class($seed)) {

            case 'Partner':
                $this->key = $this->gen($seed->id, 'P');
                $sTable = 'keyspartner WHERE kpPid=';
                $sPre = 'kp';
                break;

            case 'Model':
                $this->key = $this->gen($seed->id, 'M');
                $sTable = 'keysmodel WHERE kmMid=';
                $sPre = 'km';
                break;

            default:
                throw new Exception("Can't produce key list '$sClass'");
                break;
        }
        
        $a = array();
        if ($stable > '') {
            $r = $DBO->run('SELECT * FROM '.$sTable.$seed->id);

            while ($o = $r->assoc()) {
                $n = new Key();
                $n->dbFill($sPre, $o);
                $a[] = $n;
            }
        }
        return $a;
    }
    /** Validate a key
     *
     *  @param  key  A key
     *  @returns bool key is valid
     */
    static function check($key) {
        return preg_match('/^R[0-9A-F]{8}(P|O|M)[0-9A-F]{32}$/', $key);
    }

    /** Extract a key's index value
     *
     *  @param  key  A valid key
     *  @param  type Throws error if keytype differs
     *  @returns Index value
     */
    static function index($key, $type='') {
        if (! KptKey::check($key))
            throw new Exception('Ill formed key: '.$key);
        $r = base_convert((int)substr($key,1,8), 16, 10) ^ (int)KptKeySeed;
        /* if ($r > 2147483647)  */
        /*     throw new Exception('Key index too large: '.$key); */
        if ($type <> '' && substr($key,9,1) <> $type) {
            throw new Exception('Key has different type: '.$key.' is not a "'.$type.'"');
        }
        return $r;
    }

    /** Extract a key's type flag
     *
     *  @param  key  A valid key
     *  @returns Index type character 
     */
    static function type($key) {
        if (! KptKey::check($key))
            throw new Exception('Ill formed key: '.$key);
        return substr($key,9,1);
    }

    /** Generate/regenerate a key
     *
     *  @param  index  The item index integer or an old key
     *  @param  flag   KPT type for this key (currently 'P' or 'I')
     */
    static function gen($index, $flag='') {
        if (substr($index,1,1) == 'R') {
            $flag = substr($index,9,1);
            $index = KptKey::index($index);
        }
        if ($index > PHP_INT_MAX)  { // input too large
            throw new Exception('Key index too large: '.$index);
        }
        return strtoupper('R'.base_convert((int)$index ^ (int)KptKeySeed, 10, 16)
                          .$flag.md5(time()));
    }
    
  }