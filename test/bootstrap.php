<?php

	// Get AccountManager file
	require_once(__DIR__.'/../AccountManager.php');

	// Set up activerecord
	$cfg = ActiveRecord\Config::instance();
	$cfg->set_connections(array(
		'Development' => 'pgsql://pamtest:pamtest@obrient/pamtest')
	));
	$cfg->set_model_directory(AccountManager\ACCOUNTMANAGER_ROOT.'/models');
	$cfg->set_default_connection('Development');
	unset($cfg);

?>