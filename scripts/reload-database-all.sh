#!/usr/bin/env bash

docker stop database
docker start database

# deploy cmaq-list
cd ../data-sample/cmaq/exposures-list/
./load-cmaq-list.sh
cd -

# deploy cmaq-exposures
cd ../data-sample/cmaq/exposures-data/
./load-cmaq-sample.sh
cd -

# deploy cmaq-functions
cd ../data-sample/cmaq/cmaq-functions/
./load-cmaq-functions.sh
cd -

exit 0