#!/bin/bash

# Check and install Yarn


# Check if package.json exists
if [ ! -f package.json ]; then
    echo "package.json not found. Doing yarn init..."
    # Do Yarn init
    yarn init
fi


# Create directories for packages and apps
mkdir packages apps

# Add these in the package.json as workspaces
# Open package.json and add packages and apps to workspaces
jq '.workspaces += ["packages/*", "apps/*"]' package.json > tmp.json && mv tmp.json package.json
