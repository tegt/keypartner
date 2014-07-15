<?php
// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define('DB_NAME', 'wpress');

/** MySQL database username */
define('DB_USER', 'wpress');

/** MySQL database password */
define('DB_PASSWORD', 'rpipod');

/** MySQL hostname */
define('DB_HOST', 'localhost');

/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8');

define('WP_SITEURL', 'http://'.$_SERVER['SERVER_NAME'].'/partner');
define('WP_HOME', 'http://'.$_SERVER['HTTP_HOST'].'/partner');

?>