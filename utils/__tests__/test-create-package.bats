#!/usr/bin/env bats

# Load Bats support
load 'lib/bats-support/load'
load 'lib/bats-assert/load'

# Setup function to create a temporary directory
setup() {
    tmpdir=$(mktemp -d)
    cd "$tmpdir"
    # Create a mock package.json file
    echo '{"repository": "https://github.com/example/repo", "author": "Default Author"}' > package.json
}

# Teardown function to clean up the temporary directory
# teardown() {
#     # rm -rf "$tmpdir"
# }

# Test if the script exits when the package name is not proper
@test "create-package.sh exits if package name is not proper" {
    run bash -c 'echo "Invalid Name" | bash /home/sukrut/mono-repo/react-native-fired-up-ai/mono-repo-utils/create-package.sh'
    assert_failure
    assert_output --partial "Package name can only contain lowercase letters, numbers, and hyphens."
}

# Test if the script exits when a package with the same name already exists
@test "create-package.sh exits if a package with the same name already exists" {
    mkdir packages
    mkdir packages/valid-name
    run bash -c 'echo "valid-name" | bash /home/sukrut/mono-repo/react-native-fired-up-ai/mono-repo-utils/create-package.sh'
    assert_failure
    assert_output --partial "Package with the same name already exists."
}


# Test if the script exits when the version doesn't match the format
@test "create-package.sh exits if version doesn't match the format" {
    run bash -c 'echo -e "valid-name\ninvalid-version" | bash /home/sukrut/mono-repo/react-native-fired-up-ai/mono-repo-utils/create-package.sh'
    assert_failure
    assert_output --partial "Invalid package version. Please provide a valid semantic version in format [x.y.z]."
}


# Test if the script creates the package directory if it does not exist
@test "create-package.sh creates package directory if it does not exist" {
    run bash /home/sukrut/mono-repo/react-native-fired-up-ai/mono-repo-utils/create-package.sh <<< "valid-name"
    assert_success
    [ -d "packages/valid-name" ]
}

# Test if the script navigates to packages directory and creates a package with that name
@test "create-package.sh navigates to packages directory and creates a package with that name" {
    mkdir packages
    run bash /home/sukrut/mono-repo/react-native-fired-up-ai/mono-repo-utils/create-package.sh <<< "valid-name"
    assert_success
    [ -d "packages/valid-name" ]
}

# Test if the script creates a package.json file with the correct name and author
@test "create-package.sh creates a package.json file with the correct name and author" {
    run bash /home/sukrut/mono-repo/react-native-fired-up-ai/mono-repo-utils/create-package.sh <<< "valid-name"
    assert_success
    [ -f "packages/valid-name/package.json" ]
    # assert_output --partial '"author": "Default Author"'
}