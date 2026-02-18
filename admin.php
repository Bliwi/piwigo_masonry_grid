<?php

if (!defined('PHPWG_ROOT_PATH')) die('Hacking attempt!');

global $template, $conf, $page;

if (!isset($conf['masonry_grid'])) {
  include(dirname(__FILE__).'/config_default.inc.php');
  conf_update_param('masonry_grid', $config_default);
  load_conf_from_db();
}
// Support both serialized-string and array forms for configuration
if (isset($conf['masonry_grid'])) {
  if (is_string($conf['masonry_grid'])) {
    $params = @unserialize($conf['masonry_grid']);
  } else {
    $params = $conf['masonry_grid'];
  }
} else {
  $params = array();
}
if (!is_array($params)) {
  $params = array();
}

if (isset($_POST['submit'])) {
  check_pwg_token();
  $width = isset($_POST['width']) ? intval($_POST['width']) : 220;
  $gap = isset($_POST['gap']) ? intval($_POST['gap']) : 16;
  $nb = isset($_POST['nb_image_page']) ? intval($_POST['nb_image_page']) : 80;

  if ($width <= 0) {
    $page['errors'][] = 'Thumbnail width must be a positive integer';
  }
  if ($gap < 0) {
    $page['errors'][] = 'Gap between thumbnails must be zero or a positive integer';
  }
  if ($nb <= 0) {
    $page['errors'][] = 'Number of photos per page must be a positive integer';
  }

  if (empty($page['errors'])) {
    $params = array(
      'width' => $width,
      'gap' => $gap,
      'nb_image_page' => $nb
    );
    conf_update_param('masonry_grid', $params);
    $page['infos'][] = 'Settings saved';
  }
}

$template->assign(array(
  'MASONRY_WIDTH'        => isset($params['width']) ? $params['width'] : 220,
  'MASONRY_GAP'          => isset($params['gap']) ? $params['gap'] : 16,
  'MASONRY_NB_IMAGE'     => isset($params['nb_image_page']) ? $params['nb_image_page'] : 80,
  'PWG_TOKEN'            => get_pwg_token(),
));

$template->set_filenames(array('plugin_admin_content' => dirname(__FILE__) . '/template/admin.tpl'));
$template->assign_var_from_handle('ADMIN_CONTENT', 'plugin_admin_content');
