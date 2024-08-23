#!/bin/bash
source constants.sh
shopt -s extglob
set -e

./src/sql-run.sh ./sql/20-pub-selection-hralit/01_hra_mesh_descriptors_T.sql
psql -c "\COPY hra_meshd_anatomy FROM '${MESH_TERMS}' WITH CSV HEADER;"

./src/sql-run.sh ./sql/20-pub-selection-hralit/05_hra_pmid_MV_v0.3.sql
