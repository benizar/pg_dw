# pg_popyramids
A PostgreSQL extension for creating chichinabo popyramids database.

Installation
------------

Requirements: PostgreSQL 9.5+, postgis extension

In directory where you downloaded pg_popyramids run

    make makefile
    sudo make install

Now, go to postgres and create a new database with some recommended parameters. For example:

    -- DROP DATABASE popyramids_ign_spain;
    CREATE DATABASE popyramids_ign_spain
        WITH OWNER = postgres
        ENCODING = 'UTF8'
        TABLESPACE = pg_default
        LC_COLLATE = 'es_ES.UTF-8'
        LC_CTYPE = 'es_ES.UTF-8'
        CONNECTION LIMIT = -1;
        
We plan to log only certain queries, so we start by disabling logging

    ALTER DATABASE popyramids_ign_spain SET log_statement = 'none';

Now, create the postgis extension

    CREATE EXTENSION IF NOT EXISTS postgis;

Structure
------------
*what_project_n* schemas are only for demo purposes. Create one schema per project and use these schemas for importing raw data from this organization (e.g IGN - Spain). You can rename these schemas as "project_scale_year" e.g. census_province_2011. Create as many as necessary

*stage* schema will be used for reshaping the imported data into ods types. It will contain a set of data reshaping functions for easiness the process.

*ods* schema is designed to store all stage imported and prepared data into one single table.The popyramids_database only stores functional data in the ods schema.

*dms* schema provides some useful materialized views for the popyramids database. Mainly, those materialized views provide geojson datamarts filled up with data summaries, statistics, data agreggated at different levels, (e.g. age groups and units or %) and other convenient functions. These materialized views are application oriented (e.g. for the chichinabo Shiny apps) and they should be used instead of using the ODS schema for app querying purposes.

Sample data
------------
You can upload some sample data from the sample_data folder. Just execute any of the backups containing insert commands. For example, 'ine_prov_2011.sql' will be faster for a first test.

Future work
------------
* New functionalities:
  * Log usage statistics (e.g. user/usage maps and bounding box statistics).
* Improve features:
  * In PostgreSQL 9.5 we can create customized range queries for big range groups.
  * Improve the pyramid classification methods.
* Data:
  * Compile a detailed list of available sources.
  * Import more and more Open Data
