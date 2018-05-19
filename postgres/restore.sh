#!/bin/bash
##############################################################
# This script will restore a PostgresSql databae            ##
##############################################################

username="postgres"

# get database to restore
while getopts ":d:" opt; do
  case $opt in
    d) database="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

if [ ! -d $logsFolder ]; then
  mkdir -p $logsFolder;
fi

# Collect variables from the user
echo "postgres password:"
read PGPASSWORD
export PGPASSWORD

## Restore the most recent database globals
echo "Now restoring globals"
pg_dumpall --globals-only --clean -U$username -h localhost | \
psql -AtU $username -h localhost > $logsFolder/"globals-log" ;

echo "Restoring database $database"
pg_dump -U$username -h localhost --clean --format=c $database | \
pg_restore -U $username -d "postgres" -e --clean --create --if-exists > $logsFolder/"${f##*/}-log" 

echo "The restore of $database is complete"

