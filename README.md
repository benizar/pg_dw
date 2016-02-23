# pg_popyramids
A PostgreSQL extension for creating several schema in a popyramids database.

Installation
------------

Requirements: PostgreSQL 9.3+, postgis extension

First step is to install tree new extensions. In directory where you downloaded pg_popyramids run

    make -f makefile_ods
    sudo make -f makefile_ods install
    make -f makefile_dms
    sudo make -f makefile_dms install
    make -f makefile_setup
    sudo make -f makefile_setup install

Now, go to postgres and create a new database with some recommended parameters. For example:

    -- DROP DATABASE chibo_pyramids;
    CREATE DATABASE chibo_pyramids
        WITH OWNER = postgres
        ENCODING = 'UTF8'
        TABLESPACE = pg_default
        LC_COLLATE = 'es_ES.UTF-8'
        LC_CTYPE = 'es_ES.UTF-8'
        CONNECTION LIMIT = -1;
        
We plan to log only certain queries, so we start by disabling logging

    ALTER DATABASE chibo_pyramids SET log_statement = 'none';
    
Define grants and privileges for at least two diferent roles, one superuser and  another user with select permisions 

    GRANT CONNECT, TEMPORARY ON DATABASE chibo_pyramids TO public;
    GRANT ALL ON DATABASE chibo_pyramids TO postgres;
    GRANT ALL ON DATABASE chibo_pyramids TO chichinabo;
    ALTER DEFAULT PRIVILEGES 
    GRANT INSERT, SELECT, UPDATE, DELETE, TRUNCATE, REFERENCES, TRIGGER ON TABLES TO postgres;
    ALTER DEFAULT PRIVILEGES 
    GRANT SELECT ON TABLES
    TO chichinabo;

Finally, create the postgis extension

    CREATE EXTENSION IF NOT EXISTS postgis;


Operational Data Store (ODS)
------------
Log into PostgreSQL and run the following commands. A new schema 'ods' will be created that can not be modified after installation. If you didn't, you can reate a new role that will be used for application SELECT queries only.

    CREATE EXTENSION IF NOT EXISTS pg_popyramids_ods;
    CREATE ROLE chichinabo NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION VALID UNTIL '2020-06-02 00:00:00';
    CREATE ROLE chibo LOGIN ENCRYPTED PASSWORD 'md5ea4c9e85db3ee26e23d65bb44d7e7733' NOSUPERUSER INHERIT NOCREATEDB  NOCREATEROLE NOREPLICATION VALID UNTIL '2020-06-02 00:00:00';
    GRANT chichinabo TO chibo;

At this point, you already can upload some sample data from the sample_data folder. Just execute any of the backups containing insert commands. For example, 'ine_prov_2011.sql' will be faster for a firs setup.

Data Marts (DMS)
------------
*pg_popyramids_dms* is an extension that provides some useful materialized views for the popyramids database. The popyramids_database only stores functional data in the ODS schema. Mainly, those materialized views provide geojson datamarts filled up with data summaries, statistics, data agreggated at different levels, (e.g. age groups and units or %) and other convenient functions. These materialized views are application oriented (e.g. for the chichinabo Shiny apps) and they should be used instead of using the ODS schema for app querying purposes.

Log into PostgreSQL and run the following commands. Schema has to be 'dms' and it cannot be changed after installation. We create the schema first so these privileges can be inheritated when we create materialized views.

    CREATE SCHEMA IF NOT EXISTS dms;
    GRANT USAGE ON SCHEMA dms TO chichinabo;
    ALTER DEFAULT PRIVILEGES IN SCHEMA dms GRANT SELECT ON TABLES TO chichinabo;
    CREATE EXTENSION IF NOT EXISTS pg_popyramids_dms;
    
When you create this schema, some materialized views will be created or refreshed. This process took aproximately 8,5ms per ods row in my computer. This depends on the sample data uploaded in previous steps, don't worry and maybe drink some coffee ;)

Performance setup
------------
Triggers, indexes and other features affecting a popyramids database. This extension is only installed once ods and dms are created.

Install pg_popyramids_setup for speeding up chibo queries and easiness the database maintenance.

    CREATE EXTENSION IF NOT EXISTS pg_popyramids_setup;

Future work
------------
* New extensions:
  * Log usage statistics (e.g. user/usage maps and bounding box statistics).
  * Create a set of data import functions for easiness the process.
* Improve features:
  * In PostgreSQL 9.5 we can create customized range queries for big range groups.
  * Improve the pyramid classification methods.
* Data:
  * Compile a detailed list of available sources.
  * Import more and more Open Data
