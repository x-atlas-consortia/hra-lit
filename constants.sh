
INPUT_DIR="./input-data"
OUTPUT_DIR="./output-data"
RAW_DIR="./raw-data"

export PATH=./node_modules/.bin:${PATH}

source input-data/hra-lit/v0.7.0/config.sh

mkdir -p $RAW_DIR/$DATASET/$VERSION
mkdir -p $INPUT_DIR/$DATASET/$VERSION
mkdir -p $OUTPUT_DIR/$DATASET/$VERSION

JAVA_OPTS="-Xms2g -Xmx64g"

export PGOPTIONS="--search_path=${SCHEMA},public"
source db-config.sh
