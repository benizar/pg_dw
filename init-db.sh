#!/bin/bash -e

set -e

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"


echo "Load extensions into $POSTGRES_DB"
for DB in "$POSTGRES_DB"; do

	"${psql[@]}" --dbname="$DB" <<-'EOSQL'

		CREATE EXTENSION IF NOT EXISTS postgis;
		CREATE EXTENSION IF NOT EXISTS pg_geohash_extra;
		
		CREATE EXTENSION IF NOT EXISTS pgcrypto;
		CREATE EXTENSION IF NOT EXISTS plpython3u;
		CREATE EXTENSION IF NOT EXISTS bedquilt;

		CREATE EXTENSION IF NOT EXISTS pg_dw;
EOSQL
done



