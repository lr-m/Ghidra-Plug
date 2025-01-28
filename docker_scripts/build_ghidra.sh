#!/bin/bash
set -ex
START_DIR=$(pwd)
OUTPUT_DIR=$START_DIR/out
BRANCH='stable' # master, stable, patch

rm -rf $OUTPUT_DIR || true
mkdir -p $OUTPUT_DIR

if [ ! -d "ghidra" ]; then
    git clone -b $BRANCH https://github.com/NationalSecurityAgency/ghidra
fi

cd $START_DIR/ghidra
gradle --init-script gradle/support/fetchDependencies.gradle init
gradle yajswDevUnpack
gradle buildGhidra
gradle prepDev
gradle eclipse -PeclipsePDE

cp build/dist/*.zip $OUTPUT_DIR
cd $OUTPUT_DIR
unzip *.zip