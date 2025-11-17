This repo is to contain various CON demos.

Use repos/ to clone in tools used in demos for AI context.
 - If it doesnt exist clone https://github.com/datalad/screencaster into repos/
    - and use screencaster README for top-level workflow.

Each demo should have its own directory.
  - each demo dir should have a venv, which should be used to execute demo
  - each demo dir may provide its own gitignore
  - each demo should have a README with:
    - GIF preview at the top
    - Prerequisites and setup instructions
    - How to generate the recording and GIF

## Demo Structure

Demo scripts should:
- Be executable bash scripts with screencaster `say` and `run` commands
- Activate venv within the script: `run "source $SCRIPT_DIR/venv/bin/activate"`
- Run in ~/tmp/ to avoid storing large datasets in the repo
- Use `SCRIPT_DIR` for portable paths to scripts/files in the demo directory

## Recording and GIF Generation

Generate asciinema recording:
```bash
SCREENCAST_HOME=/tmp/demo cast2asciinema script.sh .
```

Generate GIF with provenance:
```bash
datalad run -m "Generate GIF from asciinema recording" \
  --input outputs/script.json \
  --output outputs/script.gif \
  "podman run --rm -v \"\$PWD:/data:Z\" docker.io/kayvan/agg /data/outputs/script.json /data/outputs/script.gif"
```

**Note:** Use `podman` instead of `docker` to avoid root-owned files. The `:Z` flag is required for SELinux contexts to allow container write access. Use full image paths like `docker.io/kayvan/agg` to avoid registry resolution issues.

Top level README should be an index of demos:
 - Title, Short summary, GIF embedded in table.
