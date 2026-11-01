#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

if command -v apt-get >/dev/null 2>&1; then
  if command -v sudo >/dev/null 2>&1; then
    sudo apt-get update
    sudo env DEBIAN_FRONTEND=noninteractive apt-get install -y ffmpeg python3-venv
  else
    apt-get update
    env DEBIAN_FRONTEND=noninteractive apt-get install -y ffmpeg python3-venv
  fi
fi

command -v ffmpeg >/dev/null 2>&1 || { echo "ERROR: FFmpeg is missing." >&2; exit 1; }
command -v ffprobe >/dev/null 2>&1 || { echo "ERROR: ffprobe is missing." >&2; exit 1; }

PYTHON=""
for candidate in python3.12 python3.11 python3; do
  if command -v "$candidate" >/dev/null 2>&1; then PYTHON="$candidate"; break; fi
done
test -n "$PYTHON" || { echo "ERROR: Python 3.11 or 3.12 is required." >&2; exit 1; }

"$PYTHON" -m venv .venv
.venv/bin/python -m pip install --upgrade pip
.venv/bin/python -m pip install -r requirements.txt

mkdir -p inputs outputs
export MPLCONFIGDIR="$PWD/.cache/matplotlib"
mkdir -p "$MPLCONFIGDIR"
.venv/bin/python -c "import cv2, mediapipe, numpy, PIL; print('Python dependencies: READY')"
ffmpeg -version | head -n 1
echo READY

