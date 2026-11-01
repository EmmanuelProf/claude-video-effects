# Codex video-effects workflow

This repository is a CPU-based portrait-video renderer. Treat `SKILL.md` as
reference documentation written for Claude Code; use the workflow below in
Codex.

## Setup

- In Codex Cloud, run `bash scripts/setup-cloud.sh` once from the repository
  root. It installs FFmpeg and creates `.venv`.
- On Windows, run `powershell -ExecutionPolicy Bypass -File scripts/setup.ps1`.
- Do not claim the renderer works until `bash scripts/verify.sh` (cloud/Linux)
  or `powershell -ExecutionPolicy Bypass -File scripts/verify.ps1` (Windows)
  succeeds.

## Rendering

- Input videos should be 9:16 portrait. The renderer preserves the input aspect
  ratio; it does not automatically convert landscape footage to portrait.
- Use `.venv/bin/python scripts/fx.py` on Linux/Cloud and
  `.venv\Scripts\python.exe scripts\fx.py` on Windows.
- Prefer a short 360-pixel-wide check render before a full 1080x1920 render.
- Put downloadable deliverables in `outputs/` and never commit rendered MP4s.
- Inspect output with `ffprobe` and report the exact dimensions, codecs, and
  duration. Never report success based only on a zero exit code.
- The public repository contains 20 effects plus the `glitter-spotlight` named
  look. Do not describe the private 27-effect add-on as included.

## Example task

For a video at `inputs/talking-head.mp4`:

```bash
mkdir -p outputs
.venv/bin/python scripts/fx.py backdrop-word inputs/talking-head.mp4 \
  outputs/talking-head-effects.mp4 --start 0 --end 3 --text CODEX --width 1080
ffprobe -v error -select_streams v:0 \
  -show_entries stream=width,height,codec_name -show_entries format=duration \
  -of json outputs/talking-head-effects.mp4
```

