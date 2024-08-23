#!/bin/bash
source constants.sh
shopt -s extglob
set -e

psql -c "DROP SCHEMA IF EXISTS ${SCHEMA} CASCADE; CREATE SCHEMA ${SCHEMA};"
