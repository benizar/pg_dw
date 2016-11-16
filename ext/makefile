#
# Makefile for pg_popyramids
# \
# sql/dms/materialized_views/*.sql
# 

EXTENSION = pg_popyramids
EXTVERSION = $(shell grep default_version $(EXTENSION).control | sed -e "s/default_version[[:space:]]*=[[:space:]]*'\([^']*\)'/\1/")

PG_CONFIG = pg_config
PG95 = $(shell $(PG_CONFIG) --version | egrep " 8\.| 9\.0| 9\.1| 9\.2| 9\.3| 9\.4" > /dev/null && echo no || echo yes)

ifeq ($(PG95),yes)
DOCS = $(wildcard doc/*.md)


all: $(EXTENSION)--$(EXTVERSION).sql

$(EXTENSION)--$(EXTVERSION).sql: sql/schemas.sql \
\
sql/ods/types/*.sql \
sql/ods/tables/*.sql \
sql/ods/views/*.sql \
sql/ods/triggers/*.sql \
\
sql/stage/functions/*.sql \
\
sql/dms/types/*.sql \
sql/dms/functions/*.sql

	cat $^ > $@

DATA = $(wildcard updates/*--*.sql) $(EXTENSION)--$(EXTVERSION).sql
EXTRA_CLEAN = $(EXTENSION)--$(EXTVERSION).sql
else
$(error Minimum version of PostgreSQL required is 9.5.0)
endif


PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
