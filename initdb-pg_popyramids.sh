#!/bin/sh

set -e

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"

# Create the 'popyramids_db'
"${psql[@]}" <<- 'EOSQL'
	CREATE DATABASE popyramids_db;

	-- create a new role that will be used for application SELECT queries only.
	CREATE ROLE apis NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION VALID UNTIL '2020-06-02 00:00:00';
	CREATE ROLE postgrest LOGIN ENCRYPTED PASSWORD 'md5ea4c9e85db3ee26e23d65bb44d7e7733' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION VALID UNTIL '2020-06-02 00:00:00';
	GRANT apis TO postgrest;

EOSQL

# Load extensions into both popyramids_db and $POSTGRES_DB databases
for DB in popyramids_db "$POSTGRES_DB"; do
	echo "Loading extensions into $DB"
	"${psql[@]}" --dbname="$DB" <<-'EOSQL'
		CREATE EXTENSION IF NOT EXISTS postgis;
		CREATE EXTENSION geohash_extra;
		CREATE EXTENSION pg_popyramids;
EOSQL
done
