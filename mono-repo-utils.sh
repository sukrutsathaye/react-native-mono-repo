#!/bin/bash

# Main script to run various utilities

# Function to create a new package
create_package() {
    ./utils/create-package.sh
}

mono_repo_init() {
    ./utils/mono-repo-init.sh
}

do_initial_setup() {
    ./utils/setup.sh
}

# Add more functions for other utilities as needed

# Main menu
echo "Select an option:"
echo "1. Create a new package"
echo "2. Do initial setup"
echo "3. Initialize a mono-repo"
# Add more options as needed

read -p "Enter your choice [1]: " choice
choice=${choice:-1}

case $choice in
    1)
        create_package
        ;;
    # Add more cases for other options
    2)
        do_initial_setup
        ;;
    3)
        mono_repo_init
        ;;
    *)
        echo "Invalid option"
        ;;
esac