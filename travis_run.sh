#!/usr/bin/env bash

# Fail if any command fails.
set -ex

# Set the NODE_ENV for this script.
export NODE_ENV='development'

echo "running $RUNTEST tests"
if [ "$RUNTEST" == "frontend" ]; then
    yarn run gulp test --travis --headless
    bash <(curl -s https://codecov.io/bash) -F frontend -X coveragepy
elif [ "$RUNTEST" == "backend" ]; then
    tox -e lint
    tox -e missing-migrations
    tox -e fast
    bash <(curl -s https://codecov.io/bash) -F backend
elif [ "$RUNTEST" == "backend3" ]; then
    tox -e lint-py36
    tox -e unittest-py36-dj111-wag113-fast agreements alerts ask_cfpb core jobmanager legacy permissions_viewer regulations3k scripts search wellbeing
elif [ "$RUNTEST" == "docs" ]; then
    mkdocs build
fi
