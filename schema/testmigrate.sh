#!/bin/bash

export DBHOST=obrien
export PGUSER=pamtest
DB=pamtest

[[ -z $1 ]] && echo "Specify username with superuser privileges as first argument" && exit 1

DROPUSER=$1
CREATEUSER=$1

echo 'WARNING WARNING WARNING WARNING'
echo 'WARNING WARNING WARNING WARNING'
echo 'WARNING WARNING WARNING WARNING'
echo 'THIS SCRIPT WILL ERASE ALL YOUR DATA, POST YOUR PICTURE ON 4chan AND NEUTER YOUR DOGS!'
echo 'DO NOT UNDER ANY CIRCUMSTANCE RUN THIS ON A PRODUCTION DATABASE OR YOU WILL PROBABLY LOSE YOUR JOB!'
echo
echo -n 'Continue? (y/N) '
read x

if [[ "${x}" != "y" && "${x}" != "Y" ]]; then
	echo 'Terminating'
	exit 0
fi

echo 'Dropping database...'
echo -e "\set ON_ERROR_STOP\nDROP DATABASE IF EXISTS ${DB}" | psql -h "${DBHOST}" --username "${DROPUSER}" postgres
[[ "$?" -ne '0' ]] && exit $?

echo 'Creating database...'
echo -e "\set ON_ERROR_STOP\nCREATE DATABASE ${DB} OWNER ${PGUSER}" | psql -h "${DBHOST}" --username "${CREATEUSER}" postgres
[[ "$?" -ne '0' ]] && exit $?

for mig in *.sql; do
echo "Running migration [${mig}]..."
	cont=$(cat "$mig")
	echo -e "\set ON_ERROR_STOP\n${cont}" | psql -h "${DBHOST}"
	[[ "$?" -ne '0' ]] && break
done

