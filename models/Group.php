<?php

namespace AccountManager {

	class Group extends ActiveRecord\Model {
		static $has_many = array(
			array('roles', 'through' => 'group_roles')
		);
	}

}

?>