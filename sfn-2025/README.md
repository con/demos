# SFN 2025 Demo: Duct + DataLad

Demonstrates how `duct` and `datalad` compose to provide structured, reproducible execution of neuroimaging workflows.

![Demo](./outputs/duct-datalad-demo.gif)

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
rm -f outputs/duct-datalad-demo.{cmds,json,gif}
```

### Create the Recording

Create the asciinema recording:

```bash
SCREENCAST_HOME=/tmp/demo cast2asciinema duct-datalad-demo.sh outputs
```

This will generate `outputs/duct-datalad-demo.json` and `outputs/duct-datalad-demo.cmds`.

## Viewing the Recording

View the asciinema recording:

```bash
asciinema play outputs/duct-datalad-demo.json
```

Or upload to asciinema.org for web viewing.

## Generating the GIF

Convert the recording to an animated GIF:

```bash
datalad run -m "Generate GIF from asciinema recording" \
  --input outputs/duct-datalad-demo.json \
  --output outputs/duct-datalad-demo.gif \
  "podman run --rm -v \"\$PWD:/data:Z\" docker.io/kayvan/agg /data/outputs/duct-datalad-demo.json /data/outputs/duct-datalad-demo.gif"
```

Note: Using `podman` instead of `docker` avoids creating files owned by root.

This creates `outputs/duct-datalad-demo.gif` with full provenance tracking. The demo also generates a resource usage plot at `outputs/mriqc-resources.png`.
