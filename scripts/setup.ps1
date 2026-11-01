$ErrorActionPreference = 'Stop'
Set-Location (Join-Path $PSScriptRoot '..')

if (-not (Get-Command ffmpeg -ErrorAction SilentlyContinue) -or
    -not (Get-Command ffprobe -ErrorAction SilentlyContinue)) {
    throw 'FFmpeg and ffprobe are required. Install FFmpeg, then run this script again.'
}

if (-not (Test-Path -LiteralPath '.venv\Scripts\python.exe')) {
    python -m venv .venv
}

& '.\.venv\Scripts\python.exe' -m pip install -r requirements.txt
New-Item -ItemType Directory -Force -Path inputs, outputs | Out-Null
$env:MPLCONFIGDIR = Join-Path (Get-Location) '.cache\matplotlib'
New-Item -ItemType Directory -Force -Path $env:MPLCONFIGDIR | Out-Null
& '.\.venv\Scripts\python.exe' -c "import cv2, mediapipe, numpy, PIL; print('Python dependencies: READY')"
ffmpeg -version | Select-Object -First 1
Write-Output 'READY'

