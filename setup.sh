#!/bin/bash

# ==========================================================================
# Setup script for installing project dependencies.
# NOTE: Run this script while in the project root directory.
#       It will not run correctly when run from another directory.
# ==========================================================================

# Set script to exit on any errors.
set -e

standalone() {
    ./frontend.sh $1
    ./backend.sh $1

    if [[ ! -z "$CFGOV_SPEAK_TO_ME" ]]; then
        say "Set up has finished."
    fi
}

dockerized() {
    touch .python_env
    source mac-virtualbox-init.sh
}

# Execute requested (or all) functions.
if [ "$1" == "docker" ]; then
    dockerized
else
    standalone
fi
