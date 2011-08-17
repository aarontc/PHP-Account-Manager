<?php

namespace AccountManager {

	/**
	 * \brief Main interface to account management
	 */
	 class AccountManager {


		/**
		 * \brief Constructs an AccountManager object
		 */
		function __construct() {



			// Check to see all authentication providers are registered in the database
			$this->CheckAndRegisterProviders();

		}


	 }

}

?>