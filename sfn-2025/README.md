# SFN 2025 Demo: Duct + DataLad

Demonstrates how `duct` and `datalad` compose to provide structured, reproducible execution of neuroimaging workflows.

## Prerequisites

### 1. Create and activate virtual environment

```bash
python -m venv venv
source venv/bin/activate
```

### 2. Install Python dependencies

```bash
pip install -r requirements.txt
```

### 3. Install screencaster

Follow the installation instructions at:
https://github.com/datalad/screencaster

## Generating the Demo Recording

```bash
cast2asciinema duct-datalad-demo.sh
```

This will generate `duct-datalad-demo.cast`.

## Viewing the Recording

```bash
asciinema play duct-datalad-demo.cast
```

Or upload to asciinema.org for web viewing.
