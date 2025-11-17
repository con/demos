#!/bin/bash
# Simple test case for overlay

say() { echo "# $1"; }
run() { echo "$ $1"; eval "$1"; }

say "Testing overlay functionality"
run "echo 'Before plot'"
run "echo '<<<SHOW_PLOT>>>'"
run "sleep 2"
run "echo 'During plot display'"
run "sleep 1"
run "echo '<<<HIDE_PLOT>>>'"
run "echo 'After plot'"
