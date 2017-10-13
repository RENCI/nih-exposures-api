#!/usr/bin/env bash

source ../../database.cfg

# create cmaq-functions.sql file
cat cmaq-indices.sql > cmaq-functions.sql
echo '' >> cmaq-functions.sql
echo '\di;' >> cmaq-functions.sql
echo '' >> cmaq-functions.sql
cat cmaq-grid-size.sql >> cmaq-functions.sql
cat cmaq-o3-pmij-stats-row.sql >> cmaq-functions.sql
echo '' >> cmaq-functions.sql
echo '\df cmaq*;' >> cmaq-functions.sql
echo '' >> cmaq-functions.sql

# load cmaq-functions.sql to backend container:
docker cp cmaq-functions.sql ${DB_CONTAINER_NAME}:/cmaq-functions.sql

# ingest sample data into cmaq table
docker exec -u postgres ${DB_CONTAINER_NAME} psql ${DB_NAME} -f cmaq-functions.sql

# wait for indices to populate
#echo "wait 20s for indices to populate..."
#sleep 20s
#docker exec -u postgres ${DB_CONTAINER_NAME} psql ${DB_NAME} -c "SELECT * FROM cmaq_grid_size('2011');"
#docker exec -u postgres ${DB_CONTAINER_NAME} psql ${DB_NAME} -c "SELECT * FROM cmaq_o3_pmij_stats('2011');"
#docker exec -u postgres ${DB_CONTAINER_NAME} psql ${DB_NAME} -c "SELECT * FROM cmaq_exposures_data ORDER BY utc_date_time LIMIT 10 OFFSET 360;"

exit 0;
