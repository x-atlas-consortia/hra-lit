#!/bin/bash
source constants.sh
shopt -s extglob
set -e

source db-config.sh

DIR=$RAW_DIR/$VERSION

#Journal, Volume & Issue entities
psql -f sql/50-build-hralit-entities/51-hraj_graph.sql 1> 51-hraj_sql.log
#Person entities
psql -f sql/50-build-hralit-entities/52-hrap_graph.sql 1> 52-hrap_sql.log
#Organization entities
psql -f sql/50-build-hralit-entities/53-hrao_graph.sql 1> 53-hrao_sql.log
#Article entities
psql -f sql/50-build-hralit-entities/54-hraa_graph.sql 1> 54-hraa_sql.log
