#!/bin/bash
source constants.sh
shopt -s extglob
set -e

DIR=$RAW_DIR/$VERSION
SQL=sql/10-extract-universe-data

./src/sql-extract.sh $SQL/10-publications.sql $DIR/universe-publications.jsonl
./src/sql-extract.sh $SQL/20-pmid-mesh.sql $DIR/universe-pmid-mesh.jsonl
