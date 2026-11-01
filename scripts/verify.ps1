$ErrorActionPreference = 'Stop'
Set-Location (Join-Path $PSScriptRoot '..')

if (-not (Test-Path -LiteralPath '.venv\Scripts\python.exe')) { throw 'Missing .venv' }
if (-not (Get-Command ffmpeg -ErrorAction SilentlyContinue)) { throw 'Missing ffmpeg' }
if (-not (Get-Command ffprobe -ErrorAction SilentlyContinue)) { throw 'Missing ffprobe' }
$env:MPLCONFIGDIR = Join-Path (Get-Location) '.cache\matplotlib'
New-Item -ItemType Directory -Force -Path $env:MPLCONFIGDIR | Out-Null
& '.\.venv\Scripts\python.exe' -c "import cv2, mediapipe, numpy, PIL"
$effects = (& '.\.venv\Scripts\python.exe' scripts\fx.py --list) -join "`n"
if ($effects -notmatch 'messages') { throw 'Effects list check failed' }
Write-Output 'READY'

