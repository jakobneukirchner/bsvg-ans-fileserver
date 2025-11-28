# Placeholder Audio

Placeholder-Audiodateien für Entwicklung und Testing.

## Generierung mit FFmpeg:

```bash
# 1 Sekunde Stille
ffmpeg -f lavfi -i anullsrc=r=44100:cl=mono -t 1 -q:a 9 -acodec libmp3lame silent_1s.mp3
```
