#!/bin/bash
source constants.sh
shopt -s extglob
set -e

source db-config.sh

LOG='./sql/30-data-modeling-hralit/'
DIR=$RAW_DIR/$VERSION

# MedLine Author ORCID and Affiliations
psql -f sql/30-data-modeling-hralit/11-ml_author_orcid_MV.sql 2>$1$LOG/11-ml_author_orcid_MV.log
psql -f sql/30-data-modeling-hralit/12-ml_author_aff_MV.sql 2>$1$LOG/12-ml_author_aff_MV.log

# Journal data modeling
psql -f sql/30-data-modeling-hralit/21-hra_jparts_MV.sql 2>$1$LOG/21-hra_jparts_MV.log
psql -f sql/30-data-modeling-hralit/22-hra_journals_MV.sql 2>$1$LOG/22-hra_journals_MV.log
psql -f sql/30-data-modeling-hralit/23-hra_vparts_MV.sql 2>$1$LOG/23-hra_vparts_MV.log
psql -f sql/30-data-modeling-hralit/24-hra_jvol_MV.sql 2>$1$LOG/24-hra_jvol_MV.log
psql -f sql/30-data-modeling-hralit/25-hra_jiss_MV.sql 2>$1$LOG/25-hra_jiss_MV.log

# Author data modeling
psql -f sql/30-data-modeling-hralit/31-hra_author_names_MV.sql 2>$1$LOG/31-hra_author_names_MV.log
psql -f sql/30-data-modeling-hralit/32-hra_author_id_MV.sql 2>$1$LOG/32-hra_author_id_MV.log
psql -f sql/30-data-modeling-hralit/33-hra_authors_MV.sql 2>$1$LOG/33-hra_authors_MV.log 
psql -f sql/30-data-modeling-hralit/34-hra_author_affiliations_MV.sql 2>$1$LOG/34-hra_author_affiliations_MV.log

# Article data modeling
psql -f sql/30-data-modeling-hralit/41-hra_jids_MV.sql 2>$1$LOG/41-hra_jids_MV.log
psql -f sql/30-data-modeling-hralit/42-hra_titles_MV.sql 2>$1$LOG/42-hra_titles_MV.log
psql -f sql/30-data-modeling-hralit/43-hra_abs_MV.sql 2>$1$LOG/43-hra_abs_MV.log
psql -f sql/30-data-modeling-hralit/44-hra_dates_MV.sql 2>$1$LOG/44-hra_dates_MV.log
psql -f sql/30-data-modeling-hralit/45-hra_doi_MV.sql 2>$1$LOG/45-hra_doi_MV.log
psql -f sql/30-data-modeling-hralit/46-hra_mesh_all_MV.sql 2>$1$LOG/46-hra_mesh_all_MV.log