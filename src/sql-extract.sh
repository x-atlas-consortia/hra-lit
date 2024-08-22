#!/bin/bash
source db-config.sh
set -e

sql=$1
out=$2

echo ">>>> Extracting data from SQL Script:" $sql on $(date)
echo
psql -t -A -f $sql > $out
echo
echo "<<<< Finished SQL Script:" $sql on $(date)
