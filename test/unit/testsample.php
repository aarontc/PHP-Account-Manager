<?php
	class ApplicationConfigTest extends PHPUnit_Framework_TestCase {
		protected $appconfig;

		/**
		 * Test Fixture SetUp
		 */
		protected function setUp() {
			$this->appconfig = new ApplicationConfig;
		}

		/**
		 * @test Insert and retrieve some application configuration settings
		 */
		public function BasicTest() {
			$this->appconfig->SetValue('test', 'This is a test value');

			$this->assertEquals($this->appconfig->GetValue('test'), 'This is a test value');
		}

		/**
		 * @test Ask for a value that doesn't exist, expect failure
		 */
		public function NullTest() {
			$this->assertEquals($this->appconfig->GetValue('NonExistantValueMustNotExist'), null);
		}

	}

?>
