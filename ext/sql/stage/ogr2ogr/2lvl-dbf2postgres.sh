#!/bin/bash

echo -e "\n=================================="
echo "2LVL-dbf2postgres"
echo -e "==================================\n"
echo "Batch import of a folder's structure containing multiple ESRI Shapefiles to a PostGIS database. It names your tables based on the folder structure"
echo ""
echo "MAIN FOLDER"
echo "	|-Subfolder1"
echo "		|-dbf 1.1"
echo "		|-dbf 1.2"
echo "		|-dbf 1.n"
echo "	|-Subfolder2    "
echo "		|-dbf 2.1"
echo "		|-dbf 2.2"
echo "		|-dbf 2.n"
echo "	|-Subfolder n    "
echo "		|- ..."
echo ""

## HEADER
echo -e "\n=================================="
echo -e "INSERT PARAMETERS"
echo -e "==================================\n"

read -p "1.- Main folder to import (e.g. /path/to/shps): " -i "$PWD" -e MAINFOLDER

defprefix=stock_
read -p "2.- Schema prefix (e.g. dataset year as '2006'; try to avoid this): " -i "$defprefix" -e PREFIX

defenc=UTF8
read -p "3.- Input data encoding (e.g. UTF8, WIN1252, Latin1, etc): " -i $defenc -e PGCLIENTENCODING
export PGCLIENTENCODING

defhost=localhost
read -p "4.- Host: " -i $defhost -e HOST

defdbname=yourdbname
read -p "5.- Database name (e.g. cnig, icv, coput, etc): " -i $defdbname -e DBNAME

defuser=postgres
read -p "7.- Postgres user: " -i $defuser -e USER

defpassword=postgres
read -p "8.- Postgres password: " -i $defpassword -e PASSWORD

## BODY
echo -e "\n=================================="
echo -e "START UPLOADING..."
echo -e "==================================\n"

FOLDERS=$MAINFOLDER/*/

foldercounter=1
for FOLDER in $FOLDERS
do
	FOLDERNAME=$(basename "$FOLDER")
	echo -e "\n=================================="
	echo "FOLDER $foldercounter: $FOLDERNAME"
	echo "==================================="

	filecounter=1
	FILES=$FOLDER/*.dbf	
	for FILE in $FILES
	do
		FILENAME=$(basename "$FILE" .dbf)

		echo -e "File $foldercounter.$filecounter: $FILENAME"
		echo "-----------------------------------"

		echo "ogr2ogr -f "PostgreSQL" PG:"host=$HOST user=$USER dbname=$DBNAME schemas=$PREFIX$FOLDERNAME password=$PASSWORD" $FILE"

		ogr2ogr -f "PostgreSQL" PG:"host=$HOST user=$USER dbname=$DBNAME schemas=$PREFIX$FOLDERNAME password=$PASSWORD" $FILE

		filecounter=$[$filecounter +1]
		echo ""
	done

	foldercounter=$[$foldercounter +1]
	
	echo ""

done


echo -e "=================================="
echo -e "UPLOADING COMPLETE!!"
echo -e "==================================\n"

echo -e "PLEASE CHECK THIS LOG FOR FAILURES. Depending on your input data you could need to run again this script with different parameters (e.g. for files with a different encoding). Failures return empty Postgis tables, remove them by hand and run again this script.\n"

