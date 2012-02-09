<?php

	// PHP Account Manager Header Goes Here

namespace AccountManager {

	// Get current path
	define('ACCOUNTMANAGER_ROOT', __DIR__);

	// Autoloader for AccountManager components
	function accountmanager_autoload($class) {
		$testpath = ACCOUNTMANAGER_ROOT.'/lib/class.'.$class.'.php';
		$testpath = realpath($testpath);
		if($testpath !== false)
			if(strpos($testpath, ACCOUNTMANAGER_ROOT, 0) == 0)
				if(file_exists($testpath))
					require_once($testpath);
	}

	spl_autoload_register('AccountManager\accountmanager_autoload');


	// Libraries

	/** @note PHP-ActiveRecord must be in your system include path */
	/** @todo Determine if this include is necessary or if we expect our parent application to have loaded ActiveRecord already */
	require_once('php-activerecord/ActiveRecord.php');


	/** @note ActiveRecord needs a database connection. Your application should deal with this */
}

?>