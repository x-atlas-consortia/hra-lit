#!/bin/bash
source constants.sh
shopt -s extglob
set -e

source db-config.sh

DIR=$RAW_DIR/$VERSION

# MedLine Author ORCID and Affiliations
psql -f sql/30-data-modeling-hralit/11-ml_author_orcid_MV.sql 1> 11-ml_author_orcid.log
psql -f sql/30-data-modeling-hralit/12-ml_author_aff_MV.sql 1> 12-ml_author_aff.log

# Journal data modeling
psql -f sql/30-data-modeling-hralit/21-hra_jparts_MV.sql 1> 21-hra_jparts.log
psql -f sql/30-data-modeling-hralit/22-hra_journals_MV.sql 1> 22-hra_journals.log
psql -f sql/30-data-modeling-hralit/23-hra_vparts_MV.sql 1> 23-hra_vparts.log
psql -f sql/30-data-modeling-hralit/24-hra_jvol_MV.sql 1> 24-hra_jvol.log
psql -f sql/30-data-modeling-hralit/25-hra_jiss_MV.sql 1> 25-hra_jiss.log

# Author data modeling
psql -f sql/30-data-modeling-hralit/31-hra_author_names_MV.sql 1> 31-hra_author_names.log
psql -f sql/30-data-modeling-hralit/32-hra_author_id_MV.sql 1> 32-hra_author_id.log
psql -f sql/30-data-modeling-hralit/33-hra_authors_MV.sql 1> 33-hra_authors.log
psql -f sql/30-data-modeling-hralit/31-hra_author_affiliations.sql 1> 34-hra_author_affiliations.log

# Article data modeling
psql -f sql/30-data-modeling-hralit/41-hra_jids_MV.sql 1> 41-hra_jids.log
psql -f sql/30-data-modeling-hralit/42-hra_titles_MV.sql 1> 42-hra_titles.log
psql -f sql/30-data-modeling-hralit/43-hra_abs_MV.sql 1> 43-hra_abs.log
psql -f sql/30-data-modeling-hralit/44-hra_dates_MV.sql 1> 44-hra_dates.log
psql -f sql/30-data-modeling-hralit/45-hra_doi_MV.sql 1> 45-hra_doi.log
psql -f sql/30-data-modeling-hralit/46-hra_mesh_all_MV.sql 1> 46-hra_mesh_all.log