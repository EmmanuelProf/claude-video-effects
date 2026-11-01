# Run the video effects from Codex Cloud and your phone

The public repository contains 20 effects, not 47. It also includes a named
`glitter-spotlight` variation. The additional 27 effects mentioned in the code
are a separate private pack and are not present here.

## One-time cloud setup

1. Put this adapted repository in a GitHub repository that your Codex account
   can access. Codex Cloud starts from a connected GitHub repository; it cannot
   use the copy that exists only on this Windows PC.
2. On Codex desktop or web, create a Cloud environment for that GitHub
   repository.
3. Set its setup command to:

   ```bash
   bash scripts/setup-cloud.sh
   ```

4. Allow network access during environment setup so `apt` and `pip` can fetch
   FFmpeg and Python packages. Rendering itself does not need network access.
5. Use a **large** cloud container for normal 1080x1920 renders. A medium
   container is suitable for short checks; the small 1 GB container is not
   recommended for MediaPipe plus 1080p frame compositing.
6. Publish the environment only after the setup script prints `READY`.

## Use it from a phone

After the environment is published, open Codex on mobile, select the same
repository and published environment, attach a portrait video, and ask:

> Put my attached video in `inputs/`. Add the `backdrop-word` effect from 0 to
> 3 seconds with the text `CODEX`. First make a short check render at width 360.
> If it succeeds, render at width 1080 into `outputs/final.mp4`. Verify with
> ffprobe that it is H.264, 1080x1920, and keeps the source audio. Give me the
> MP4 as a downloadable result. Do not claim success unless ffprobe succeeds.

Cloud tasks continue while the Windows laptop is asleep or switched off. The
phone is the controller; rendering occurs on OpenAI-managed Linux compute.

## Important limitations

- A source video must already be 9:16 for an exact 1080x1920 result. The current
  renderer preserves aspect ratio and does not intelligently reframe landscape
  video.
- Rendering is CPU-only and processes the video twice. Long 1080p clips can be
  slow and consume significant cloud time.
- The repository adds visuals only. It does not add sound effects or captions.
- `words.py` downloads a Whisper model the first time word-level timing is used;
  that requires network access and more time/storage.
- Keep final MP4s out of Git. Download them from the task result or move them to
  persistent storage before the cloud workspace expires.

