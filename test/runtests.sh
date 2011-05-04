#!/bin/bash
cd $(dirname $0)
phpunit --coverage-html test-results --configuration phpunit.xml unit
