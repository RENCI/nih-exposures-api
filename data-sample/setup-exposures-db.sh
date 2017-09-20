#!/usr/bin/env bash

source database.cfg

# Setup bdtgreen database with user datatrans
if [[ -z $(docker ps | grep database_${DB_CONTAINER_NAME}) ]]; then
    cd ../database/
    docker-compose stop ${DB_CONTAINER_NAME}
    docker-compose rm -f ${DB_CONTAINER_NAME}
    docker-compose build
    docker-compose up -d
    sleep 10s
    cd -
else
    echo "Database container already exists";
fi

# Create datatrans user if it does not already exist
if [[ -z $(docker exec -u postgres ${DB_CONTAINER_NAME} psql postgres -tAc \
"SELECT 1 FROM pg_roles WHERE rolname='${DB_USER}'") ]]; then
    docker exec -u postgres ${DB_CONTAINER_NAME} psql -c "CREATE USER "${DB_USER}" WITH PASSWORD '"${DB_PASS}"';";
else
    echo "User ${DB_USER} already exists";
fi

# Create bdtgreen database if it does not already exist
if [[ -z $(docker exec -u postgres ${DB_CONTAINER_NAME} psql postgres -tAc \
"SELECT 1 from pg_database WHERE datname='${DB_NAME}'") ]]; then
    docker exec -u postgres ${DB_CONTAINER_NAME} psql -c "CREATE DATABASE "${DB_NAME}";";
else
    echo "Database ${DB_NAME} already exists";
fi

# Grant all privileges on bdtgreen to datatrans if not already applied
docker exec -u postgres ${DB_CONTAINER_NAME} psql -c 'GRANT ALL PRIVILEGES ON DATABASE "'${DB_NAME}'" TO '${DB_USER}';'

# Create extension postgis, postgis_topology and ogr_fdw
# $ docker exec -u postgres ${DB_CONTAINER_NAME} psql ${DB_NAME} -c '\dx'
#                                          List of installed extensions
#        Name       | Version |   Schema   |                             Description
# ------------------+---------+------------+---------------------------------------------------------------------
#  ogr_fdw          | 1.0     | public     | foreign-data wrapper for GIS data access
#  plpgsql          | 1.0     | pg_catalog | PL/pgSQL procedural language
#  postgis          | 2.3.3   | public     | PostGIS geometry, geography, and raster spatial types and functions
#  postgis_topology | 2.3.3   | topology   | PostGIS topology spatial types and functions
# (4 rows)

if [[ -z $(docker exec -u postgres ${DB_CONTAINER_NAME} psql ${DB_NAME} -tAc \
"SELECT 1 from pg_extension WHERE extname='postgis'") ]]; then
    docker exec -u postgres ${DB_CONTAINER_NAME} psql ${DB_NAME} -c "CREATE EXTENSION postgis;";
else
    echo "Extension postgis already exists";
fi
if [[ -z $(docker exec -u postgres ${DB_CONTAINER_NAME} psql ${DB_NAME} -tAc \
"SELECT 1 from pg_extension WHERE extname='postgis_topology'") ]]; then
    docker exec -u postgres ${DB_CONTAINER_NAME} psql ${DB_NAME} -c "CREATE EXTENSION postgis_topology;";
else
    echo "Extension postgis_topology already exists";
fi
if [[ -z $(docker exec -u postgres ${DB_CONTAINER_NAME} psql ${DB_NAME} -tAc \
"SELECT 1 from pg_extension WHERE extname='ogr_fdw'") ]]; then
    docker exec -u postgres ${DB_CONTAINER_NAME} psql ${DB_NAME} -c "CREATE EXTENSION ogr_fdw;";
else
    echo "Extension ogr_fdw already exists";
fi

docker exec -u postgres ${DB_CONTAINER_NAME} psql -c '\l'
docker exec -u postgres ${DB_CONTAINER_NAME} psql ${DB_NAME} -c '\dx'

exit 0;
