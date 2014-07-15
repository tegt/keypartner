<?php
/** Role file for development
 *
 *  Contains configuration0 info when system is in a development role.
 *
 */
error_reporting(E_ALL ^ E_NOTICE);
define ('DBURL', 'mysqli://market:kptpod@localhost/market');

define ('assetDir', '/home/tegt/storefront/angel/loadup/web/assets');
?>