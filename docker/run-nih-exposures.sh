#!/usr/bin/env bash

PATH_TO_DOCKERFILE=../server/
LOCAL_PORT=5000
PATH_TO_ENV_FILE=nih-exposures.env
PATH_TO_SSL_CERTS=

cd $PATH_TO_DOCKERFILE
docker build -t nih-exposures .
cd -

docker stop nih-exposures
sleep 2s
docker rm -fv nih-exposures
sleep 2s
if [[ ! -z ${PATH_TO_SSL_CERTS} ]]; then
    docker run -d --name nih-exposures \
        --env-file=${PATH_TO_ENV_FILE} \
        -p ${LOCAL_PORT}:5000 \
        -v ${PATH_TO_SSL_CERTS}:/certs \
        nih-exposures
    echo "NIH Exposures API running over https"
else
    docker run -d --name nih-exposures \
        --env-file=${PATH_TO_ENV_FILE} \
        -p ${LOCAL_PORT}:5000 \
        nih-exposures
    echo "NIH Exposures API running over http"
fi

exit 0;