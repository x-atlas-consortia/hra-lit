#!/bin/bash
source constants.sh
set -e

sql=$1

echo ">>>> Running SQL Script:" $sql on $(date)
echo
time psql -f $sql
echo
echo "<<<< Finished SQL Script:" $sql on $(date)
