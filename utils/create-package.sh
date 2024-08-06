#!/bin/bash

# Extract repository URL and author from root package.json
root_package_json="./package.json"

# Check if root package.json exists
if [ ! -f "$root_package_json" ]; then
    echo "Root package.json not found."
    exit 1
fi

repository_url=$(jq -r '.repository' "$root_package_json")
default_author=$(jq -r '.author' "$root_package_json")

# Prompt for package name and version
read -p "Enter package name: " package_name
# Check if package name is empty
if [ -z "$package_name" ]; then
    echo "Package name cannot be empty."
    exit 1
fi

# Check if package name is valid
if ! [[ "$package_name" =~ ^[a-z0-9-]+$ ]]; then
    echo "Package name can only contain lowercase letters, numbers, and hyphens."
    exit 1
fi

# Check if any other package with the same name exists
if [ -d "packages/$package_name" ]; then
    echo "Package with the same name already exists."
    exit 1
fi

read -p "Enter package version [0.1.0]: " package_version

# Set default package version if not provided
package_version=${package_version:-0.1.0}

# Check if package version if provided is valid
# regex check for semantic versioning
if ! [[ "$package_version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Invalid package version. Please provide a valid semantic version in format [x.y.z]."
    exit 1
fi



# Prompt for author name
read -p "Enter author name [$default_author]: " author_name
author_name=${author_name:-$default_author}

# Check if packages directory exists
if [ ! -d "packages" ]; then
    echo "Packages directory not found."
    echo "Creating a new packages directory..."
    mkdir -p packages
fi



# Move to packages directory
cd packages



# Create package directory
mkdir -p "$package_name"
cd "$package_name"

# Create package.json file
cat > package.json <<EOF
{
    "name": "@fired-up-ai/$package_name",
    "version": "$package_version",
    "main": "index.ts",
    "license": "MIT",
    "private": true,
    "repository": "$repository_url",
    "author": "$author_name",
    "scripts": {
        "test": "jest"
    },
    "peerDependencies": {
        "//": "Use peerDependencies if already present in root package.json"
    },
    "dependencies": {
        "//": "Project specific dependencies"
    },
    "devDependencies": {
        "//": "Project specific test dependencies"
    }
}
EOF

# Create index.ts file
touch index.ts

# Create src directory
mkdir src

# Create test directory
mkdir __tests__

# Create .gitignore file
cat > .gitignore <<EOF
node_modules
dist
coverage
.env
EOF

# Create README.md file
cat > README.md <<EOF
# $package_name

## Description
add description here

## Installation
\`\`\`bash
npm install @fired-up-ai/$package_name
\`\`\`

## Usage
\`\`\`typescript
// add usage here
\`\`\`

## License
MIT

## Author
$author_name

## Repository
$repository_url

EOF

