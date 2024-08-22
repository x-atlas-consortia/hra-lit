#!/bin/bash
source constants.sh
shopt -s extglob
set -e

source db-config.sh

LOG='./sql/50-build-hralit-entities/'
DIR=$RAW_DIR/$VERSION

#Journal, Volume & Issue entities
psql -f sql/50-build-hralit-entities/51-hraj_graph.sql 2>$1$LOG/51-hraj_graph.log

#Person entities
psql -f sql/50-build-hralit-entities/52-hrap_graph.sql 2>$1$LOG/52-hrap_graph.log

#Organization entities
psql -f sql/50-build-hralit-entities/53-hrao_graph.sql 2>$1$LOG/53-hrao_graph.log

#Article entities
psql -f sql/50-build-hralit-entities/54-hraa_graph.sql 2>$1$LOG/54-hraa_graph.log
