#!/bin/bash
source constants.sh
set -e

sql=$1

echo ">>>> Running SQL Script:" $sql on $(date)
time psql -f $sql
