Run PostgresSQL Docker environment locally to be used by Gekko

PREREQUISITES

Docker

Git

1. Read but skip this step if you will be customizing #3 below.
    Create three folders on your local computer to be used as persistent storage by postgresSql.

    cd ~

    mkdir postgres

    cd postgres

    mkdir data

    mkdir logs

    mkdir backup

    In these three folders the PostgresSql server will store data, logs, and backups.  This is how persistence of the database will happen between different instances of the postgres container.

    These folders can exist anywhere in the filesystem.  You can put them on external media, such as a USB drive.  Performance of the media should be very high.

2. Clone this git respository

    mkdir ~/git

    cd ~/git

    git clone https://github.com/mikemichaelis/postgekko.git
    
3. make ~/git/postgekko your CWD

    cd postgekko

4. Customize the following values in the ./settings.sh file.

    nano settings.sh
    
    The default values will work and will write to a postgres folder (created above) in the users home.  Otherwise update to folders on the local file system.  This can be an external USB drive (ie /media/usb1/postgres/[data|logs|backup]).  Set the password that will be assigned to the postgres sa user.

    export POSTGRESPASS="password"

    export POSTGRES_DATA="~/postgres/data"  

    export POSTGRES_LOGS="~/postgres/logs"

    export POSTGRES_BACKUP="~/postgres/backup"

    The use of ENVIRONMENT VARIABLES is because these values are used in the ./docker-compose.yml file, not in a shell script.  So one mechanism to pass parameters to docker-compose is through the environment.

5. Build the docker image:

    cd postgres
    
    docker build .

6. Start the contained using docker-compose

    cd ..

    chmod +x ./run_postgres.sh

    ./run_postgres.sh
    
7. You should at this point run a single instance of gekko and have it create the initial database.  The postgresSql server will be available on localhost:5432 password=$POSTGRESPASS (from above).  I will leave this as an excercise for the reader to perform.  You should afterward determine the name of the db that was created.  You may now also begin populating the db with data.

8. Attach to the postgres container to backup and restore the database

    docker ps

        [copy container id of postgres]

    docker exec -i -t [container id] /bin/bash

        [you are now running a shell in the docker container]

    ./backup.sh -d [name of db to backup]

    ./restore.sh -d /postgres/backup/[name of db to restore]
    
     NOTE to see the following errors during restore is acceptable
     
     ERROR:  current user cannot be dropped

     ERROR:  role "postgres" already exists

    