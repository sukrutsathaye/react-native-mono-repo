#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Update package lists
sudo apt update

# Check and install Node.js and npm
if ! command_exists node; then
    echo "Installing Node.js and npm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    nvm install 21
    sudo apt-get install -y nodejs
else
    echo "Node.js is already installed."
fi

# Check and install Yarn
if ! command_exists yarn; then
    echo "Installing Yarn..."
    sudo npm install -g yarn
else
    echo "Yarn is already installed."
fi

# Check and install Java
if ! command_exists java; then
    echo "Installing Java..."
    sudo apt-get update
    sudo apt-get upgrade
    sudo apt install openjdk-17-jdk openjdk-17-jre
else
    echo "Java is already installed."
fi

# Check and install Expo CLI
if ! command_exists expo; then
    echo "Installing Expo CLI..."
    sudo npm install -g expo-cli
else
    echo "Expo CLI is already installed."
fi

# Check and install Firebase CLI
if ! command_exists firebase; then
    echo "Installing Firebase CLI..."
    curl -sL https://firebase.tools | bash
else
    echo "Firebase CLI is already installed."
fi

# Install project dependencies
echo "Installing project dependencies..."
yarn install

# Check and install Firebase Emulator Suite
# if ! firebase emulators:exec --only firestore,database,pubsub,storage,ui "exit 0" 2>/dev/null; then
#     echo "Setting up Firebase Emulator Suite..."
#     firebase setup:emulators:firestore
#     firebase setup:emulators:database
#     firebase setup:emulators:pubsub
#     firebase setup:emulators:storage
#     firebase setup:emulators:ui
# else
#     echo "Firebase Emulator Suite is already set up."
# fi

# Check and install Maestro
if ! command_exists maestro; then
    echo "Installing Maestro..."
    curl -Ls "https://get.maestro.mobile.dev" | bash
    export PATH="$PATH":"$HOME/.maestro/bin"
else
    echo "Maestro is already installed."
fi

echo "Setup complete!"
