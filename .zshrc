## Java
# Function to switch between Java versions
javaswitch() {
    local java_version=$1
    local java_path

    # Ensure JAVA_HOME is unset
    unset JAVA_HOME

    # Get the JAVA_HOME path for the specified version
    java_path=$(/usr/libexec/java_home -v "$java_version" 2>/dev/null)

    # Check if the JAVA_HOME path was found
    if [ -z "$java_path" ]; then
        echo "Java version $java_version is not installed. Use brew to install it."
        return 1
    else
        # Set JAVA_HOME and update PATH
        export JAVA_HOME="$java_path"
        export PATH="$JAVA_HOME/bin:$PATH"

        # Confirm the switch
        echo "Switched to Java version $java_version"
        java -version
    fi
}
alias javaswitch='javaswitch'

## Go
# Function to switch between Go versions
goswitch() {
    local go_version=$1
    local go_path

    go_path=$(brew --prefix "go@$go_version")/libexec

    if [ -d "$go_path" ]; then
        # Set GOROOT and update PATH
        export GOROOT="$go_path"
        export PATH="$GOROOT/bin:$PATH"
        echo "Switched to Go version $go_version"
        go version
    else
        echo "Go version $go_version is not installed. Use brew to install it."
    fi
}

# Create an alias for easier function call
alias goswitch='goswitch'