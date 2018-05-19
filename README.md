Run PostgresSQL Docker environment locally to be used with Gekko
**This guide assumes you have Docker installed on your local machine**

1. Skip doing if you will be customizing #3 below, but you should read anyway.
    First create three folders on your local computer.

    cd ~
    mkdir postgress
    cd postgress
    mkdir data
    mkdir logs
    mkdir backup

    In these three folders the postgresSql server will store data, logs, and backups.

    These folders can exist anywhere in the filesystem.  You can put them on external media, such as a USB drive.  Performance of the media should be very high.

2. cd into the ~/git/postgekko folder

3. Customize the following values in the ./settings file.

    nano settings
    
    The default values will work as is and will write to a postgres folder the users home,
    or update to an external USB drive (ie /media/usb1/postgres/[data|logs|backup])

    export POSTGRESPASS="password"
    export POSTGRES_DATA="~/postgres/data"  
    export POSTGRES_LOGS="~/postgres/logs"
    export POSTGRES_BACKUP="~/postgres/backup"

    If you are wondering why the use of ENVIRONMENT VARIABLES it is because these are used in the ./docker-compose.yml file, not in a shell script.  So the mechanism to pass parameters to docker-compose is through the environment.

4. Build the docker image:
    cd postgress
    docker build .

5. Start the contained using docker-compose
    cd ..
    chmod +x ./run_postgres.sh
    ./run_postgres.sh

6. You can now check the values you assgned above for POSTGRES_DATA|LOGS|BACKUP
    Most likely you will be denied access to the folders while the container is executing.  

7. Attach to the postgres container to backup and restore a database

    docker ps
        [copy container id of postgres]
    docker exec -i -t [container id] /bin/bash
        [you are now running a shell in the docker container]
    ls
        [you will see custom scripts to backup / restore]
        [the commands are]
    ./backup -p /postgres/backup -d [name of db to backup]
    ./restore -d /postgres/backup/[name of db to restore]
     
     NOTE to see the following errors during restore is acceptable
     
     ERROR:  current user cannot be dropped
     ERROR:  role "postgres" already exists

    