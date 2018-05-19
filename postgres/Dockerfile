FROM postgres:9.6 
WORKDIR /postgres/db_resources
COPY pg_hba.conf . 
COPY startup.sh .
COPY backup.sh .
COPY restore.sh .
RUN ["chmod", "+x", "/postgres/db_resources/startup.sh"]
RUN ["chmod", "+x", "/postgres/db_resources/backup.sh"]
RUN ["chmod", "+x", "/postgres/db_resources/restore.sh"]
ENTRYPOINT ["./startup.sh"]