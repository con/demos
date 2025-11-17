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
run "export PS1='$ '"
say "Activating Python environment..."
run "source $SCRIPT_DIR/venv/bin/activate"
run "datalad --version"
run "con-duct --version"

say "Creating a DataLad dataset..."
run "datalad create -c text2git myproject"
run "cd myproject"

say "Creating output directory for YODA principles..."
run "mkdir -p outputs"

say "Installing example BOLD fMRI dataset from ReproNim..."
run "datalad install -d . -s https://github.com/ReproNim/ds000003-demo sourcedata/raw"

# Stage 1: Basic Execution
say "Stage 1: Running nib-ls with duct for structured logging and resource monitoring..."
say "The --input flag tells datalad run to unlock git-annex files for reading."
run "datalad run -m 'Check BOLD file metadata' --input sourcedata/raw/sub-02/func/sub-02_task-rhymejudgment_bold.nii.gz duct --sample-interval 0.01 --report-interval 0.05 -- nib-ls sourcedata/raw/sub-02/func/sub-02_task-rhymejudgment_bold.nii.gz"

say "Duct captured the command, output, exit code, and resource usage."
run "con-duct ls"

sleep 3
run "clear"
# Stage 2: Resource Monitoring
say "Stage 2: Check file size with resource monitoring..."
run "datalad run -m 'Check file size' --input sourcedata/raw/sub-02/func/sub-02_task-rhymejudgment_bold.nii.gz duct -- du -sh sourcedata/raw/sub-02/func/sub-02_task-rhymejudgment_bold.nii.gz"

say "Duct tracked peak memory and CPU usage."
run "con-duct ls -f summaries"

sleep 3
run "clear"
# Stage 3: Output Tracking
say "Stage 3: Create compressed copy, tracking outputs..."
run "datalad run -m 'Compress BOLD file' --input sourcedata/raw/sub-02/func/sub-02_task-rhymejudgment_bold.nii.gz --output outputs/sub-02_bold.nii.gz duct -- bash -c 'gzip -c sourcedata/raw/sub-02/func/sub-02_task-rhymejudgment_bold.nii.gz > outputs/sub-02_bold.nii.gz'"

say "New output automatically tracked and committed by datalad."
run "ls -lh outputs/"
say "Note the symlink - git-annex manages large files separately from git."
run "git --no-pager log --oneline -n 5"

sleep 3
run "clear"
# Stage 4: Real Analysis (simplified)
say "Stage 4: Running a more complex analysis workflow..."
run "datalad run -m 'Extract brain mask' --input sourcedata/raw/sub-02/func/sub-02_task-rhymejudgment_bold.nii.gz --output outputs/mask.nii.gz duct -- python $SCRIPT_DIR/scripts/extract_mask.py sourcedata/raw/sub-02/func/sub-02_task-rhymejudgment_bold.nii.gz outputs/mask.nii.gz"

say "We can now use con-duct to check the execution history."
run "con-duct ls"

sleep 3
run "clear"
# Stage 5: Real-world MRIQC dataset
say "Stage 5: Exploring a real-world MRIQC dataset with existing duct logs..."
run "cd $DEMO_ROOT"

say "Cloning ds000007-mriqc from cerebra.fz-juelich.de..."
run "datalad clone https://cerebra.fz-juelich.de/f.hoffstaedter/ds000007-mriqc.git ds000007-mriqc-hoffstaedter"
run "cd ds000007-mriqc-hoffstaedter"

say "Fetching duct logs from git-annex..."
say "DataLad/git-annex store file content separately - we fetch it on demand."
run "datalad get logs/duct/*.json"

say "Viewing git log showing datalad run records with ReproNim containers..."
run "git --no-pager log --oneline | head -20"

say "Listing execution records captured by duct..."
run "con-duct ls logs/duct/*"

say "Viewing detailed execution info in JSON format..."
run "con-duct ls logs/duct/* -f json_pp | head -50"

say "Generating resource usage plot..."
run "con-duct plot logs/duct/sub-01_2025.10.10T00.36.37-3899234_usage.json -o $SCRIPT_DIR/outputs/mriqc-resources.png"

say "See more plot examples at https://github.com/con/duct"

# Final: Comparison
say "Final view: Compare duct logs with datalad provenance..."
run "echo '=== Duct execution logs from MRIQC dataset ==='"
run "con-duct ls $DEMO_ROOT/ds000007-mriqc-hoffstaedter/logs/duct/* -f summaries | head -20"

say "And the DataLad commit history from MRIQC dataset..."
run "git -C $DEMO_ROOT/ds000007-mriqc-hoffstaedter --no-pager log --oneline | head -20"

say "Demo complete! Duct + DataLad = Transparent, reproducible workflows."
