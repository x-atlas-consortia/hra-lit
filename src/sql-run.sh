#!/bin/bash
source constants.sh
set -e

sql=$1

echo ">>>> psql -f" $sql on $(date)
time psql -f $sql
