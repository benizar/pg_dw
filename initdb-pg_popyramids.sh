#!/bin/sh

set -e

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"

# Create the 'popyramids_db'
"${psql[@]}" <<- 'EOSQL'
	CREATE DATABASE popyramids_db;
	CREATE ROLE apis  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION VALID UNTIL '2020-06-02 00:00:00';
	CREATE ROLE postgrest LOGIN PASSWORD 'postgrest' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION VALID UNTIL '2020-06-02 00:00:00';
	GRANT apis TO postgrest;
EOSQL

# Load extensions into both popyramids_db and $POSTGRES_DB databases
for DB in popyramids_db "$POSTGRES_DB"; do
	echo "Loading extensions into $DB"
	"${psql[@]}" --dbname="$DB" <<-'EOSQL'
		CREATE EXTENSION postgis;
		CREATE EXTENSION pg_popyramids;
EOSQL


# Grants/privileges
"${psql[@]}" <<- 'EOSQL'

	GRANT USAGE ON SCHEMA ods TO apis;
	ALTER DEFAULT PRIVILEGES IN SCHEMA ods GRANT SELECT ON TABLES TO apis;

	GRANT USAGE ON SCHEMA dms TO apis;
	ALTER DEFAULT PRIVILEGES IN SCHEMA dms GRANT SELECT ON TABLES TO apis;

EOSQL




done
