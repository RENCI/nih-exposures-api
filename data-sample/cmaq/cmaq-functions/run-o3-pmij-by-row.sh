#!/usr/bin/env bash

if [[ "${1}" == '2010' ]]; then
    MIN_ROW=1
    MAX_ROW=112
else
    MIN_ROW=1
    MAX_ROW=299
    MAX_ROW=4 # delete this line when in production
fi

source ../../database.cfg

YEAR=$1

# validate min and max columns
echo "min_col = ${MIN_ROW}, max_col = ${MAX_ROW}"
read -p "Does this match expected?: [Y/n] " answer
case ${answer:0:1} in
    y|Y )
        echo Yes
    ;;
    * )
        echo No
        exit 1;
    ;;
esac

iter=${MIN_ROW}

while [ $iter -le $MAX_ROW ]; do
    echo "Processing Row: ${iter}"
    docker exec -u postgres ${DB_CONTAINER_NAME} psql ${DB_NAME} -c \
        "select cmaq_o3_pmij_stats_row('"${1}"', "${iter}");"
    (( iter++ ))
done

exit 0;
