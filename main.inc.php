<?php
/*
Plugin Name: Masonry Grid
Version: 1
Description: Pinterest style masonry grid on piwigo.
Plugin URI: placeholder
Author: Bliwi
Author URI: https://bliwi.uk
Has Settings: true
*/
defined('PHPWG_ROOT_PATH') or die('Hacking attempt!');

if (basename(dirname(__FILE__)) != 'piwigo_masonry_grid')
{
  add_event_handler('init', 'masonry_grid_error');
  function masonry_grid_error()
  {
    global $page;
    $page['errors'][] = 'Masonry Grid folder name is incorrect, uninstall the plugin and rename it to "Piwigo_masonry_grid"';
  }
  return;
}

define('USER_COLLEC_PATH',   PHPWG_PLUGINS_PATH . 'piwigo_masonry_grid/');
define('USER_COLLEC_ADMIN',  get_root_url() . 'admin.php?page=plugin-piwigo_masonry_grid');
