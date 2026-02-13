<?php
/*
Plugin Name: Masonry Grid
Version: auto
Description: Pinterest style masonry grid on piwigo.
Plugin URI: auto
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

define('MASONRY',   PHPWG_PLUGINS_PATH . 'piwigo_masonry_grid/');

add_event_handler('loc_begin_index_thumbnails', 'masonry_replace_template');

function masonry_replace_template()
{
    global $template;

    $template->set_prefilter('index_thumbnails', 'masonry_prefilter');
}

function masonry_prefilter($content)
{
    return file_get_contents(MASONRY . 'template/masonry.tpl');
}
