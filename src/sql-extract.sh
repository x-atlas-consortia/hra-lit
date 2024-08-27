#!/bin/bash
source constants.sh
set -e

sql=$1
out=$2

echo ">>>> psql -f" $sql to $(basename $out) on $(date)
time psql -t -A -f $sql > $out
