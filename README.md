# pg_popyramids
A PostgreSQL extension for creating several schema in a popyramids database.

INSTALLATION
------------

Requirements: PostgreSQL 9.3+, postgis extension

In directory where you downloaded pg_popyramids run

    make -f makefile_ods
    sudo make -f makefile_ods install
    make -f makefile_dms
    sudo make -f makefile_dms install
    make -f makefile_setup
    sudo make -f makefile_setup install


PostgreSQL setup
------------
Log into PostgreSQL and run the following commands. New schemas ('ods', 'dms') will be created and that can not be modified after installation. Then you can reate a new role that will be used for application SELECT queries.

    CREATE EXTENSION IF NOT EXISTS postgis;
    CREATE EXTENSION IF NOT EXISTS pg_popyramids_ods; -- At this point you already can upload some sample data from the pg_popyramids/sample_data folder
    CREATE EXTENSION IF NOT EXISTS pg_popyramids_dms;
    CREATE EXTENSION IF NOT EXISTS pg_popyramids_setup;
    CREATE ROLE chichinabo NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION VALID UNTIL '2020-06-02 00:00:00';
    CREATE ROLE chibo LOGIN ENCRYPTED PASSWORD 'md5ea4c9e85db3ee26e23d65bb44d7e7733' NOSUPERUSER INHERIT NOCREATEDB  NOCREATEROLE NOREPLICATION VALID UNTIL '2020-06-02 00:00:00';
    GRANT chichinabo TO chibo;
    
    