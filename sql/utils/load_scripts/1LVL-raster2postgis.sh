#!/bin/bash

echo -e "\n=================================="
echo "1LVL-raster2postgis"
echo -e "==================================\n"
echo -e "Batch import of a folder containing multiple raster Files to a PostGIS database.\n"
echo "FOLDER"
echo "   |-asciigrid 1.1"
echo "   |-asciigrid 1.2"
echo "   |-asciigrid 1.n"
echo ""

## HEADER
echo -e "\n=================================="
echo -e "INSERT PARAMETERS"
echo -e "==================================\n"

read -p "1.- Main folder to import (e.g. /path/to/asciigrids): " -i "$PWD" -e FOLDER

defprefix=$(basename "$FOLDER")_
read -p "2.- Table prefix (e.g. dataset year as '2006'; try to avoid this): " -i "$defprefix" -e PREFIX

defformat=.asc
read -p "3.- Grid format as extension (e.g. asc, sdat, etc): " -i "$defformat" -e FORMAT

defepsg=4258
read -p "4.- EPSG (e.g. 4326, 4258, etc): " -i $defepsg -e EPSG

deftilesize=auto
read -p "5.- Set TILE_SIZE is expressed as WIDTHxHEIGHT or set to the value 'auto' to allow the loader to compute an appropriate value (e.g. 100x100): " -i "$deftilesize" -e TILE_SIZE

defhost=localhost
read -p "6.- Host: " -i $defhost -e HOST

defdbname=yourdbname
read -p "7.- Database name (e.g. cnig, icv, coput, etc): " -i $defdbname -e DBNAME

defschemas=public
read -p "8.- Schemas list (e.g schema1, schema2, schema-n): " -i $defschemas -e SCHEMAS

defuser=postgres
read -p "9.- Postgres user: " -i $defuser -e USER

defpassword=postgres
read -p "10.- Postgres password: " -i $defpassword -e PASSWORD
export PGPASSWORD=$PASSWORD

## BODY
echo -e "\n=================================="
echo -e "START UPLOADING..."
echo -e "==================================\n"

FILES=$FOLDER/*$FORMAT

filecounter=1
for FILE in $FILES
do
	FILENAME=$(basename "$FILE" $FORMAT)
	NEWNAME=$PREFIX$FILENAME
	NEWNAME=${NEWNAME//[-+=., ]/_}

	echo "File $filecounter: $FILENAME"
	echo "-----------------------------------"
	
raster2pgsql -s $EPSG -I -C -M $FILE -F -t $TILE_SIZE $SCHEMAS.$NEWNAME | psql -U $USER  -d $DBNAME -h $HOST -p 5432

echo"raster2pgsql -s $EPSG -I -C -M $FILE -F -t $TILE_SIZE $SCHEMAS.$NEWNAME | psql -U $USER  -d $DBNAME -h $HOST -p 5432"

	filecounter=$[$filecounter +1]
	echo ""

done

echo -e "=================================="
echo -e "UPLOADING COMPLETE!!"
echo -e "==================================\n"

echo -e "PLEASE CHECK THIS LOG FOR FAILURES. Depending on your input data you could need to run again this script with different parameters (e.g. for files with a different encoding). Failures return empty Postgis tables, remove them by hand and run again this script.\n"
