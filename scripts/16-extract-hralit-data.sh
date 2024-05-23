#!/bin/bash
source constants.sh
shopt -s extglob
set -e

source db-config.sh

DIR=$RAW_DIR/$VERSION

psql -t -A -f sql/60-extract-hralit/61-hraj_graph_jsonld.sql > $DIR/61-hralit-journals.jsonl
psql -t -A -f sql/60-extract-hralit/62-hrap_graph_jsonld.sql > $DIR/62-hralit-persons.jsonl
psql -t -A -f sql/60-extract-hralit/62-hrao_graph_jsonld.sql > $DIR/63-hralit-organizations.jsonl
psql -t -A -f sql/60-extract-hralit/63-hraa_graph_jsonld.sql > $DIR/64-hralit-articles.jsonl
