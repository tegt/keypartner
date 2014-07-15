<?php
require '../../wp-config.db.php';

define('FNAME', 'latest.sql');

if ($argc > 1 && $argv[1] == 'd') {
    if (is_file(FNAME)) {
        $s = stat(FNAME);
        rename(FNAME, date('Y-m-d-Hi',$s[8]).'.sql');
    }
    echo ('mysqldump -h '.DB_HOST.' -u '.DB_USER.' -p'.DB_PASSWORD.' '.DB_NAME.' >'.FNAME."\n");

} else {
    if (is_file(FNAME)) {
        echo "\. latest.sql\n";
    }
    else {
        passthru('ls -l *.sql');
    }
}
?>