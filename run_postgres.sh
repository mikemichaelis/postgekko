#!/bin/bash
#This script will set all necessary env variables and start all docker containers locally

. ./settings.sh

if [ -z $POSTGRESPASS ]; 
then 
    echo "POSTGRESPASS env variable is not set, now exiting.";
    exit;
fi;

if [ -z $POSTGRES_DATA ]; 
then 
    echo "POSTGRES_DATA env variable is not set, now exiting.";
    exit;
fi;

if [ -z $POSTGRES_LOGS ]; 
then 
    echo "POSTGRES_LOGS env variable is not set, now exiting.";
    exit;
fi;

if [ -z $POSTGRES_BACKUP ]; 
then 
    echo "POSTGRES_BACKUP env variable is not set, now exiting.";
    exit;
fi;

#bring down any old cronus runner containers
docker-compose down

#bring up all containers
docker-compose up -d --force-recreate --build --remove-orphans