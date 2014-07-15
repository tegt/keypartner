<?php
  /**
   *  This file establishes the server environment for all
   *  sub-systems. The environment itself relocates to the location of
   *  this file. Globals a class loader and include file pathing for
   *  inc, class, css, and js files is established. See the ROLE file
   *  section below for details of http and database configuration
   *  tailoring per role.
   *
   *  Usage:
   *      include <path-to-this-file>/rpiboot.inc
   *      rpiBoot(__FILE__);
   *
   *  @author Grant Tegtmeier <Grant.Tegtmeier@RPIPrint.com>
   *  @package angel
   *  @copyright Copyright (c) 2013 Reischling Press Inc
   */

  /** The boot include path.
   *
   *  This path is used to relocate the include structure making rpiboot
   *  and all of its plugin's relocatable. Thus multiple copies/versions
   *  can be used on a single machine without conflict.
   *
   */
define('RPIBOOT', str_replace('/inc/', '/',
                              dirname(__FILE__).'/'));

error_reporting(E_ALL ^ E_NOTICE);

/** Establish RPI directory heirarchies.
 *
 *  Any include is searched for first in the file's directory then in
 *  the file's rpiboot/plug-in-directory/inc followed by rpiboot/inc
 *  followed by the system defaults.
 *
 *  The same hierarchy applies to .class.php files from class
 *  directories. By convention only .inc files are placed in the inc
 *  directories and only .class.php files are placed in the /class
 *  directories.
 *
 */

function rpiBoot($scriptfile, $db=true) {

    define('RPIPLUG', str_replace('/web/','/', 
                                  dirname($scriptfile).'/'));

    set_include_path( '.'
                      .':'.RPIPLUG.'inc'
                      .':'.RPIPLUG.'class'
                      .':'.RPIBOOT.'inc'
                      .':'.RPIBOOT.'class'
                      .str_replace(':.:', ':',':'
                                   .get_include_path()));

    if ($db) {
        include 'dbutil.inc';
        $GLOBALS['DBO'] = new DBOmy(DBURL);
    }
}

/** This autoload for boot and plug classes
 *  
 *  Note use of include rather than require here
 *  permits actual error to fall on the generating code rather than
 *  generating a terminal error here without pointing to the cause.
 *  
 */
function __autoload($name) {
    if (preg_match('|^\w+$|', $name)) { // insure classname is a valid word
        $fname = strtolower($name).'.class.php';
        include $fname;
    }
}

/** Choose the configuration by looking for a *.role file. 
 *
 *  The file's contents are not used! A system is configured in two
 *  steps:
 *
 *      rm *.role
 *      touch xxx.role
 *
 *  All .role files are ignored by source control so freshly checked
 *  out systems will fail until a role file is created. 
 *
 */
$role = glob(RPIBOOT.'*.role');
if (! $role) die ('TERMINAL: No role file found:'.RPIBOOT."*.role\n");
if (count($role) > 1) die ('TERMINAL: Multiple role files found:'.RPIBOOT."../*.role\n");
define ('ROLE', basename($role[0]));
require_once ROLE.'.inc';

?>
