#!/bin/bash
source constants.sh
shopt -s extglob
set -ev

DIR=$RAW_DIR/$DATASET/$VERSION
JNL=$DIR/blazegraph.jnl
rm -f $JNL

MESH=http://id.nlm.nih.gov/mesh/
MESH_DL=https://nlmpubs.nlm.nih.gov/projects/mesh/rdf/mesh.nt.gz

HRA_LIT_UNIVERSE=https://purl.humanatlas.io/graph/hra-lit-universe
HRA_LIT=https://purl.humanatlas.io/graph/hra-lit

# Digital Objects to import into the Blazegraph Journal
CCF=https://purl.humanatlas.io/graph/ccf
HRA=https://purl.humanatlas.io/collection/hra
HRA_API=https://purl.humanatlas.io/collection/hra-api
DSGRAPHS=https://purl.humanatlas.io/collection/ds-graphs
DSGRAPHS_ENRICHMENTS=https://purl.humanatlas.io/graph/ds-graphs-enrichments
UBERON=https://purl.humanatlas.io/vocab/uberon
MAPPING=https://purl.humanatlas.io/graph/mesh-uberon-cl-human-mapping
MAPPING2=https://purl.humanatlas.io/graph/pubmed-uberon-cl-mapping

DOs_TO_IMPORT="$CCF $HRA $HRA_API $DSGRAPHS $DSGRAPHS_ENRICHMENTS $UBERON $MAPPING $MAPPING2"

run_ndjsonld() {
  QUADS=${1%.jsonld}.nq
  ndjsonld canonize $1 $QUADS -c context.jsonld 
  blazegraph-runner load --journal=$JNL "--graph=${2}" $QUADS
  rm -f $QUADS
}

run_jsonld() {
  QUADS=${1%.jsonld}.nq
  jsonld canonize $1 > $QUADS
  blazegraph-runner load --journal=$JNL "--graph=${2}" $QUADS
  rm -f $QUADS
}

# HRA-LIT Universe
# run_ndjsonld $DIR/universe-publications.jsonl $HRA_LIT_UNIVERSE
# run_ndjsonld $DIR/universe-pmid-mesh.jsonl $HRA_LIT_UNIVERSE

# HRA-LIT World
cat $DIR/hralit-articles.jsonl \
  $DIR/hralit-journals.jsonl \
  $DIR/hralit-organizations.jsonl \
  $DIR/hralit-persons.jsonl \
  $DIR/hralit-mesh-terms.jsonl | \
  ndjsonld canonize -c context.jsonld - $DIR/hra-lit.nq

blazegraph-runner load --journal=$JNL "--graph=${HRA_LIT}" $DIR/hra-lit.nq
rm -f $DIR/hra-lit.nq

# Dump HRA-LIT back out to turtle format for publishing
blazegraph-runner dump --journal=$JNL "--graph=${HRA_LIT}" $DIR/hra-lit.ttl

# Import digital objects from HRA KG to use for querying
for DO in $DOs_TO_IMPORT; do
  # Import the Digital Object
  curl -s $DO -H "Accept: application/rdf+xml" > $DIR/digital-object.owl
  blazegraph-runner load --journal=$JNL "--graph=${DO}" $DIR/digital-object.owl
  rm -f $DIR/digital-object.owl
done

# Import MESH
curl $MESH_DL | zcat > $DIR/mesh.nt
blazegraph-runner load --journal=$JNL "--graph=${MESH}" $DIR/mesh.nt
rm -f $DIR/mesh.nt
