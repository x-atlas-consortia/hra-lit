#!/bin/bash
source constants.sh
shopt -s extglob
set -e

DIR=$RAW_DIR/$DATASET/$VERSION
SQL=sql/60-extract-hralit-entities

# Export data to jsonld format
./src/sql-extract.sh $SQL/61-hraj_graph_jsonld.sql $DIR/hralit-journals.jsonl
./src/sql-extract.sh $SQL/62-hrap_graph_jsonld.sql $DIR/hralit-persons.jsonl
./src/sql-extract.sh $SQL/63-hrao_graph_jsonld.sql $DIR/hralit-organizations.jsonl
./src/sql-extract.sh $SQL/64-hraa_graph_jsonld.sql $DIR/hralit-articles.jsonl
./src/sql-extract.sh $SQL/65-hram_graph_jsonld.sql $DIR/hralit-mesh-terms.jsonl
