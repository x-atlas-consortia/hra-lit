#!/bin/bash
set -e

sqlDir=$1

for sql in $sqlDir/*.sql; do
  ./src/sql-run.sh $sql
done
