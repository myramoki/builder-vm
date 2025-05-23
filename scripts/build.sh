#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

. ${SCRIPT_DIR}/setup.sh

# ----

case "${JAVA_VERSION}" in
8)      export JAVA_HOME=/usr/lib/jvm/java-1.8.0 ;;
21)     export JAVA_HOME=/usr/lib/jvm/java-21 ;;
esac

log "Building ${BRANCH}"

printf "==== GIT NEW COMMITS ====\n\n" \
&& git log @..@{u} \
&& printf "\n\n==== GIT PULL ====\n\n" \
&& git pull \
&& printf "\n\n==== BUILD LOG ====\n\n" \
&& ./create-archives.sh pkg 2>&1
