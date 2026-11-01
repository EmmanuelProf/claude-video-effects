#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

test -x .venv/bin/python
command -v ffmpeg >/dev/null
command -v ffprobe >/dev/null
export MPLCONFIGDIR="$PWD/.cache/matplotlib"
mkdir -p "$MPLCONFIGDIR"
.venv/bin/python -c "import cv2, mediapipe, numpy, PIL"
.venv/bin/python scripts/fx.py --list | grep -q 'messages'
echo READY

