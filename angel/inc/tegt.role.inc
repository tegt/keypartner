<?php
/** Role file for development
 *
 *  Contains configuration0 info when system is in a development role.
 *
 */
error_reporting(E_ALL ^ E_NOTICE);

define ('DBURL', 'mysqli://tegtrpi:tegt4RPI@db.tegt.com/tegtrpi');

define ('assetDir', '/home/tegt/rpi.tegt.com/angel/loadup/web/assets');
?>