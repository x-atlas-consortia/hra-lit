#!/bin/bash
source constants.sh
shopt -s extglob
set -e

source db-config.sh

DIR=$RAW_DIR/$VERSION

# Export data to jsonld format
psql -t -A -f sql/60-extract-hralit/61-hraj_graph_jsonld.sql > $DIR/hralit-journals.jsonl
psql -t -A -f sql/60-extract-hralit/62-hrap_graph_jsonld.sql > $DIR/hralit-persons.jsonl
psql -t -A -f sql/60-extract-hralit/63-hrao_graph_jsonld.sql > $DIR/hralit-organizations.jsonl
psql -t -A -f sql/60-extract-hralit/64-hraa_graph_jsonld.sql > $DIR/hralit-articles.jsonl
