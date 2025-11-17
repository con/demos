#!/usr/bin/env python3
"""Find timestamps for image overlay markers in asciinema cast."""
import json
import sys

cast_path = sys.argv[1]

with open(cast_path, "r", encoding="utf-8") as f:
    header = json.loads(f.readline())
    events = [json.loads(line) for line in f]

start = None
end = None

for t, kind, data in events:
    if kind != "o":
        continue
    if "<<<SHOW_PLOT>>>" in data and start is None:
        start = t
    if "<<<HIDE_PLOT>>>" in data and end is None:
        end = t

if start is None:
    raise SystemExit("No SHOW_PLOT marker found")
if end is None:
    # default to +3s if no hide marker
    end = start + 3.0

print(f"{start},{end}")
