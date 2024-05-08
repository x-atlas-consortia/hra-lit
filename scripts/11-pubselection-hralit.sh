#!/bin/bash
source constants.sh
shopt -s extglob
set -e

source db-config.sh

DIR=$RAW_DIR/$VERSION

# MedLine Author ORCID and Affiliations
psql -f sql/20-pub-selection-hralit/01_hra_mesh_descriptors_T.sql 1> 01_hra_mesh_descriptors.log
psql -f sql/20-pub-selection-hralit/05_hra_pmid_MV_v0.3.sql 1> 05_hra_pmid.log