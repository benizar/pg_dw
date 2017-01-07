#!/bin/bash -e

set -e

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"

echo "Creating dw database"
"${psql[@]}" <<- 'EOSQL'
CREATE DATABASE dw;
EOSQL


echo "Load extensions into both dw and $POSTGRES_DB"
for DB in dw "$POSTGRES_DB"; do
	echo "Loading extensions into $DB"
	"${psql[@]}" --dbname="$DB" <<-'EOSQL'

		CREATE EXTENSION IF NOT EXISTS postgis;
		CREATE EXTENSION IF NOT EXISTS pgcrypto;
		CREATE EXTENSION IF NOT EXISTS plpython3u;
		CREATE EXTENSION IF NOT EXISTS bedquilt;

		CREATE EXTENSION IF NOT EXISTS pg_geohash_extra;
		CREATE EXTENSION IF NOT EXISTS pg_dw;
EOSQL
done



