#!/usr/bin/env bash

PATH_TO_DOCKERFILE=../server/
LOCAL_PORT=5000
DOCKER_NETWORK=database_default
PATH_TO_SSL_CERTS=''

cd $PATH_TO_DOCKERFILE
docker build -t nih-exposures .
cd -

docker stop nih-exposures
sleep 2s
docker rm -fv nih-exposures
sleep 2s
if [[ ! -z ${PATH_TO_SSL_CERTS} ]]; then
    docker run -d --name nih-exposures \
        -p ${LOCAL_PORT}:5000 \
        --network=${DOCKER_NETWORK} \
        -v ${PATH_TO_SSL_CERTS}:/certs \
        nih-exposures
    echo "NIH Exposures API running at https://localhost:"${LOCAL_PORT}"/v1/ui/#/default"
else
    docker run -d --name nih-exposures \
        -p ${LOCAL_PORT}:5000 \
        --network=${DOCKER_NETWORK} \
        nih-exposures
    echo "NIH Exposures API running at http://localhost:"${LOCAL_PORT}"/v1/ui/#/default"
fi

exit 0;