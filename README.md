Run PostgresSQL Docker environment locally to be used with Gekko
**This guide assumes you have Docker installed on your local machine**

1. cd into the ./local folder

2. Update the following variables to match the settings of your local environment. These env vars will specify the configuration used to create the postgres container.  

DATA and LOGS specify the local folders that postgres will use for data
(possibly /media/usb/postgres/)?  
PASS is the password that will be set for the user postgres of the new container.

    NOTE: the postgres folders should exist upon initial startup.

    export POSTGRESPASS="**CRONSERV PASSWORD**"
    export POSTGRES_DATA="**LOCAL POSTGRES DATA FOLDER**"  
    export POSTGRES_LOGS="**LOCAL POSTGRES LOG FOLDER**"

If you are wondering why the use of ENVIRONMENT VARIABLES it is because these are used in
the docker-compose.yml file, not in a shell script.

3. To build or rebuild your docker image please execute the following command 
    'sh ./run_postgres.sh --build' to build and start the postgres docker image.

4. To just start the docker container please execute the following command 
    'sh ./run_postgres.sh'