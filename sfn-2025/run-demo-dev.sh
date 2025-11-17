#!/bin/bash
# Development wrapper - run cast script without screencaster

# Simple say function - just prints the message
say() {
    echo ">> $1"
}

# Simple run function - echoes then executes the command
run() {
    echo "$ $1"
    eval "$1"
}

# Source the demo script
source duct-datalad-demo.cast
