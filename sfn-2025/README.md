# SFN 2025 Demo: Duct + DataLad

Demonstrates how `duct` and `datalad` compose to provide structured, reproducible execution of neuroimaging workflows.

![Demo](./duct-datalad-demo.gif)

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

Create the asciinema recording:

```bash
SCREENCAST_HOME=/tmp/demo cast2asciinema duct-datalad-demo.sh .
```

This will generate `duct-datalad-demo.json`.

## Viewing the Recording

View the asciinema recording:

```bash
asciinema play duct-datalad-demo.json
```

Or upload to asciinema.org for web viewing.

## Generating the GIF

Convert the recording to an animated GIF:

```bash
datalad run -m "Generate GIF from asciinema recording" \
  --input duct-datalad-demo.json \
  --output duct-datalad-demo.gif \
  "docker run --rm -v \"\$PWD:/data\" kayvan/agg /data/duct-datalad-demo.json /data/duct-datalad-demo.gif"
```

This creates `duct-datalad-demo.gif` with full provenance tracking.
