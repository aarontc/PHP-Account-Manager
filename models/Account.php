<?php

namespace AccountManager {

	class Account extends ActiveRecord\Model {
		static $belongs_to = array(
			array('parent_account_id', 'class_name' => 'Account')
		);

		static $has_many = array(
			array('roles', 'through' => 'account_roles'),
			array('groups', 'through' => 'account_groups')
		);
	}

}

?>