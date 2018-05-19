#!/bin/bash
##############################################################
#This script will backup all postgres databases on localhost##
##############################################################

username="postgres"
globals_filename="globals_backup_$(date +%Y-%m-%d)"
databases_filename="backup_$(date +%Y-%m-%d)"
output_path="/postgres/backup"

## First we grab the command line parameters for the output path
## and the number of days for our retention period
while getopts ":p:d:" opt; do
  case $opt in
    d) database="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

# Third we create a backup up of all the global cluster metadata (users, permissions, etc.)
echo "Now backing up globals to $output_path/$globals_filename"
pg_dumpall --globals-only -U$username --file="$output_path/$globals_filename"; 

#Lastly we backup the databases
echo "Now backing up $database to $output_path"

filename="${database}_${databases_filename}"
pg_dump -U$username --format=c --clean --file="$output_path/$filename" $database;