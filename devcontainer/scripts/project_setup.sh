#!/bin/bash
# Project Setup Script - Checks The Local System and Configures Local Variables For The Project

# Change To VSCode Devcontainer Path
cd "${PWD}/.devcontainer" || exit 1

# Check For Needed Commands On System
MISSING=0
for needed in Docker Docker-Compose
do
    if ! command -v ${needed,,} &> /dev/null ; then echo " ${needed} Is Needed On The System To Run The Project" ; MISSING=1 ; fi
done
if [ ${MISSING} -eq 1 ] ; then exit 1 ; fi

# Create A Local Directory Store
[ ! -d ./.local ] && mkdir .local

# Write Environment File
chmod 0755 ./scripts/build_environment_file.sh
./scripts/build_environment_file.sh

# Create A Home Container To Map To For Storing Local Sessions
if [ ! -d ./.local/development_home ] ; then mkdir -p ./.local/development_home ; fi
