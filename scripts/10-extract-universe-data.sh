#!/bin/bash
source constants.sh
shopt -s extglob
set -e

source db-config.sh

DIR=$RAW_DIR/$VERSION

psql -t -A -f sql/10-universe-data/10-publications.sql > $DIR/universe-publications.jsonl
psql -t -A -f sql/10-universe-data/20-pmid-mesh.sql > $DIR/universe-pmid-mesh.jsonl
