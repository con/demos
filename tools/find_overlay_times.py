#!/usr/bin/env python3
"""Find timestamps for image overlay markers in asciinema cast."""
import json
import sys

cast_path = sys.argv[1]

with open(cast_path, "r", encoding="utf-8") as f:
    header = json.loads(f.readline())
    events = [json.loads(line) for line in f]

# Get idle_time_limit from header if present
idle_limit = header.get("idle_time_limit")

# Calculate compressed video time for each event
video_time = 0.0
prev_time = 0.0
event_video_times = []

for t, kind, data in events:
    elapsed = t - prev_time
    if idle_limit is not None and elapsed > idle_limit:
        # Compress idle time to the limit
        elapsed = idle_limit
    video_time += elapsed
    event_video_times.append(video_time)
    prev_time = t

# Find markers in compressed timeline
start = None
end = None

for i, (t, kind, data) in enumerate(events):
    if kind != "o":
        continue
    if "<<<SHOW_PLOT>>>" in data and start is None:
        start = event_video_times[i]
    if "<<<HIDE_PLOT>>>" in data and end is None:
        end = event_video_times[i]

if start is None:
    raise SystemExit("No SHOW_PLOT marker found")
if end is None:
    # default to +3s if no hide marker
    end = start + 3.0

print(f"{start},{end}")
