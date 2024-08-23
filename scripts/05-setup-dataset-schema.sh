#!/bin/bash
source constants.sh
shopt -s extglob
set -e

psql -c "DROP SCHEMA IF EXISTS ${SCHEMA} CASCADE; CREATE SCHEMA ${SCHEMA};"

./src/sql-rundir.sh ./sql/05-setup-dataset-schema
