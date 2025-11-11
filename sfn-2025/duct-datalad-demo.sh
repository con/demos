#!/bin/bash

# SFN 2025 Demo: Duct + DataLad for Reproducible Neuroimaging Workflows

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Set demo root directory
DEMO_ROOT=~/tmp

say "Welcome to the Duct + DataLad demo!"
say "We'll show how these tools compose for structured, reproducible execution."

# Setup
say "Setting up demo environment in $DEMO_ROOT..."
run "mkdir -p $DEMO_ROOT"
run "cd $DEMO_ROOT"
run "rm -rf myproject"

say "Creating a DataLad dataset..."
run "datalad create -c text2git myproject"
run "cd myproject"

say "Creating output directory for YODA principles..."
run "mkdir -p outputs"

say "Installing example BOLD fMRI dataset from ReproNim..."
run "datalad install -d . -s https://github.com/ReproNim/ds000003-demo sourcedata/raw"

# Stage 1: Basic Execution
say "Stage 1: Running nib-ls with duct for structured logging..."
run "datalad run -m 'Check BOLD file metadata' --input sourcedata/raw/sub-02/func/sub-02_task-rhymejudgment_bold.nii.gz duct -- nib-ls sourcedata/raw/sub-02/func/sub-02_task-rhymejudgment_bold.nii.gz"

say "Duct captured the command, output, and exit code."
run "con-duct ls"

# Stage 2: Resource Monitoring
say "Stage 2: Check file size with resource monitoring..."
run "datalad run -m 'Check file size' --input sourcedata/raw/sub-02/func/sub-02_task-rhymejudgment_bold.nii.gz duct -- du -sh sourcedata/raw/sub-02/func/sub-02_task-rhymejudgment_bold.nii.gz"

say "Duct tracked peak memory and CPU usage."
run "con-duct ls -f summaries"

# Stage 3: Output Tracking
say "Stage 3: Create compressed copy, tracking outputs..."
run "datalad run -m 'Compress BOLD file' --input sourcedata/raw/sub-02/func/sub-02_task-rhymejudgment_bold.nii.gz --output outputs/sub-02_bold.nii.gz duct -- bash -c 'gzip -c sourcedata/raw/sub-02/func/sub-02_task-rhymejudgment_bold.nii.gz > outputs/sub-02_bold.nii.gz'"

say "New output automatically tracked and committed by datalad."
run "ls -lh outputs/"
run "git log --oneline -n 5"

# Stage 4: Real Analysis (simplified)
say "Stage 4: Running a more complex analysis workflow..."
run "datalad run -m 'Extract brain mask' --input sourcedata/raw/sub-02/func/sub-02_task-rhymejudgment_bold.nii.gz --output outputs/mask.nii.gz duct -- python $SCRIPT_DIR/extract_mask.py sourcedata/raw/sub-02/func/sub-02_task-rhymejudgment_bold.nii.gz outputs/mask.nii.gz"

say "Check the execution history..."
run "con-duct ls"

# Final: Comparison
say "Final view: Compare duct logs with datalad provenance..."
run "echo '=== Duct execution logs ==='"
run "con-duct ls -f summaries"

say "And the DataLad commit history..."
run "git log --oneline"

say "Demo complete! Duct + DataLad = Transparent, reproducible workflows."
