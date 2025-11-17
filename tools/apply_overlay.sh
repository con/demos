#!/usr/bin/env bash
# Apply image overlay to video between markers
set -euo pipefail

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <input.mp4> <overlay.png> <output.mp4>"
    exit 1
fi

INPUT="$1"
IMAGE="$2"
OUTPUT="$3"
CAST="${INPUT%.mp4}.json"

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Find overlay times from the cast file
times=$("$SCRIPT_DIR/find_overlay_times.py" "$CAST")
start=${times%,*}
end=${times#*,}

echo "Applying overlay from ${start}s to ${end}s"

# Apply overlay with ffmpeg
ffmpeg -y -i "$INPUT" -i "$IMAGE" \
  -filter_complex "overlay=W-w-10:10:enable='between(t,${start},${end})'" \
  -c:a copy "$OUTPUT"

echo "Created $OUTPUT with overlay"
