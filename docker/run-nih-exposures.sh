#!/usr/bin/env bash

PATH_TO_DOCKERFILE=../server/
LOCAL_PORT=5000
DOCKER_NETWORK=database_default
SSL_CERTS=/PATH_TO/nih-exposures-api/server/ssl-certs

cd $PATH_TO_DOCKERFILE
docker build -t nih-exposures .
cd -

docker stop nih-exposures
sleep 2s
docker rm -fv nih-exposures
sleep 2s
docker run -d --name nih-exposures -p ${LOCAL_PORT}:5000 --network=${DOCKER_NETWORK} -v ${SSL_CERTS}:/certs nih-exposures

exit 0;