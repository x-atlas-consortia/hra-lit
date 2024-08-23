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
CCF=https://purl.humanatlas.io/graph/ccf
UBERON=https://purl.humanatlas.io/vocab/uberon

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
ndjsonld canonize -c context.jsonld $DIR/hralit-articles.jsonl $DIR/hra-lit.nq
ndjsonld canonize --unsafe -c context.jsonld $DIR/hralit-journals.jsonl - >> $DIR/hra-lit.nq # FIXME: Relative @id reference found. https://purl.humanatlas.io/graph/hra-lit/v0.6#421031_114_4%20SupplÂ 1 
ndjsonld canonize -c context.jsonld $DIR/hralit-organizations.jsonl - >> $DIR/hra-lit.nq
ndjsonld canonize -c context.jsonld $DIR/hralit-persons.jsonl - >> $DIR/hra-lit.nq

blazegraph-runner load --journal=$JNL "--graph=${HRA_LIT}" $DIR/hra-lit.nq

# Import CCF.OWL
curl -s $CCF -H "Accept: application/rdf+xml" > $DIR/ccf.owl
blazegraph-runner load --journal=$JNL "--graph=${CCF}" $DIR/ccf.owl

# Import UBERON
curl -s $UBERON -H "Accept: application/rdf+xml" > $DIR/uberon.owl
blazegraph-runner load --journal=$JNL "--graph=${UBERON}" $DIR/uberon.owl

# Import MESH
curl $MESH_DL | zcat > $DIR/mesh.nt
blazegraph-runner load --journal=$JNL "--graph=${MESH}" $DIR/mesh.nt
