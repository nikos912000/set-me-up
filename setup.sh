# Function to install a specific version of Java (Temurin)
install_java() {
    local version=$1
    echo "Checking if Java version $version has been installed..."
    if ! brew list --cask "temurin@$version" &> /dev/null; then
        echo "Installing Java version $version..."
        brew install --cask "temurin@$version"
    else
        echo "Java version $version is already installed."
    fi
}

# Function to install a specific version of Go
install_go() {
    local version=$1
    local formula_name="go@$version"
    echo "Checking if Go version $version has been installed..."
    if ! brew list --formula "$formula_name" &> /dev/null; then
        echo "Installing Go version $version..."
        brew install "$formula_name"
    else
        echo "Go version $version is already installed."
    fi
}

# Function dispatcher
run_function() {
    local function_name=$1
    shift
    if declare -f "$function_name" > /dev/null; then
        "$function_name" "$@"
    else
        echo "Function $function_name not found."
        exit 1
    fi
}

# Extract the function name and the rest of the arguments
function_name=$1
# Remove the function name from the argument list
shift

# Call the function dispatcher
run_function "$function_name" "$@"