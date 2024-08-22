#!/bin/bash
source db-config.sh
set -e

sql=$1

echo ">>>> Running SQL Script:" $sql on $(date)
echo
psql -f $sql
echo
echo "<<<< Finished SQL Script:" $sql on $(date)
