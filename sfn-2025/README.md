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

### Cleanup Before Recording

Before running a new recording, clean up any previous demo runs:

```bash
# Clean up demo environment
cd ~/tmp
chmod -R +w myproject ds000007-mriqc-hoffstaedter 2>/dev/null || true
rm -rf myproject ds000007-mriqc-hoffstaedter

# Clean up screencaster temp directory
rm -rf /tmp/demo

# Clean up previous recording files
cd /home/austin/devel/demos/sfn-2025
rm -f duct-datalad-demo.cmds duct-datalad-demo.json
```

### Create the Recording

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
  "podman run --rm -v \"\$PWD:/data\" kayvan/agg /data/duct-datalad-demo.json /data/duct-datalad-demo.gif"
```

Note: Using `podman` instead of `docker` avoids creating files owned by root.

This creates `duct-datalad-demo.gif` with full provenance tracking.
