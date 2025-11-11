#!/bin/bash

# SFN 2025 Demo: Duct + DataLad for Reproducible Neuroimaging Workflows

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

say "Creating directory structure for YODA principles..."
run "mkdir -p inputs outputs"
run "datalad save -m 'Add YODA structure'"

say "Adding a sample BOLD fMRI file..."
run "curl -L -o inputs/sub-01_bold.nii.gz https://github.com/datalad/example-data/raw/master/bids/sub-01/func/sub-01_task-rest_bold.nii.gz"
run "datalad save -m 'Add sample BOLD data' inputs/"

# Stage 1: Basic Execution
say "Stage 1: Running nib-ls with duct for structured logging..."
run "datalad run -m 'Check BOLD file metadata' --input inputs/sub-01_bold.nii.gz duct -- nib-ls inputs/sub-01_bold.nii.gz"

say "Duct captured the command, output, and exit code."
run "con-duct ls"

# Stage 2: Resource Monitoring
say "Stage 2: Check file size with resource monitoring..."
run "datalad run -m 'Check file size' --input inputs/sub-01_bold.nii.gz duct -- du -sh inputs/sub-01_bold.nii.gz"

say "Duct tracked peak memory and CPU usage."
run "con-duct ls -f summary"

# Stage 3: Output Tracking
say "Stage 3: Create compressed copy, tracking outputs..."
run "datalad run -m 'Compress BOLD file' --input inputs/sub-01_bold.nii.gz --output outputs/sub-01_bold.nii.gz duct -- gzip -c inputs/sub-01_bold.nii.gz > outputs/sub-01_bold.nii.gz"

say "New output automatically tracked and committed by datalad."
run "ls -lh outputs/"
run "git log --oneline -n 5"

# Stage 4: Real Analysis (simplified)
say "Stage 4: Running a more complex analysis workflow..."
run "datalad run -m 'Extract brain mask' --input inputs/sub-01_bold.nii.gz --output outputs/mask.nii.gz duct -- python -c 'import nibabel as nib; import numpy as np; img = nib.load(\"inputs/sub-01_bold.nii.gz\"); mask = np.ones(img.shape[:3]); nib.save(nib.Nifti1Image(mask, img.affine), \"outputs/mask.nii.gz\")'"

say "Check the execution history..."
run "con-duct ls"

# Final: Comparison
say "Final view: Compare duct logs with datalad provenance..."
run "echo '=== Duct execution logs ==='"
run "con-duct ls -f summary"

say "And the DataLad commit history..."
run "git log --oneline"

say "Demo complete! Duct + DataLad = Transparent, reproducible workflows."
