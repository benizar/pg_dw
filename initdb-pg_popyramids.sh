#!/bin/sh

set -e

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"

# Create the 'popyramids_db'
"${psql[@]}" <<- 'EOSQL'
	CREATE DATABASE popyramids_db;
EOSQL

# Load extensions into both popyramids_db and $POSTGRES_DB databases
for DB in popyramids_db "$POSTGRES_DB"; do
	echo "Loading extensions into $DB"
	"${psql[@]}" --dbname="$DB" <<-'EOSQL'
		CREATE EXTENSION IF NOT EXISTS postgis;
		CREATE EXTENSION IF NOT EXISTS postgis_topology;
		CREATE EXTENSION pg_popyramids;
EOSQL
done
