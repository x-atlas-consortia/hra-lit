#!/bin/bash
source constants.sh
shopt -s extglob
set -e

./src/sql-rundir.sh ./sql/50-build-hralit-entities
