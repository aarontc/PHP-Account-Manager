#!/bin/bash
cd $(dirname $0)
phpunit --coverage-html test-results --configuration test/phpunit.xml test/
