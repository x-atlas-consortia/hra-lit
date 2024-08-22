#!/bin/bash
source constants.sh
shopt -s extglob
set -e

./src/sql-rundir.sh ./sql/30-data-modeling-hralit
