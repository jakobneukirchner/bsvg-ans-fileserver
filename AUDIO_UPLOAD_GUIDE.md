# Audio-Upload Anleitung

🎵 **Schritt-für-Schritt Anleitung zum Hochladen von Audio-Dateien**

---

## ⚙️ Voraussetzungen

### Software

- **FFmpeg** (zum Konvertieren)
  ```bash
  # macOS
  brew install ffmpeg
  
  # Ubuntu/Debian
  sudo apt install ffmpeg
  
  # Windows
  # Download von https://ffmpeg.org/
  ```

- **Git** (zum Uploaden)
  ```bash
  git --version
  ```

### Audio-Format Anforderungen

✅ **Empfohlen:**
- Format: MP3
- Bitrate: 96 kbps (gute Balance zwischen Qualität und Größe)
- Sample Rate: 44.1 kHz
- Kanäle: Mono
- Normalisierung: -16 LUFS

---

## 🎤 Methode 1: Professionelle Aufnahmen

### Schritt 1: Aufnahme

**Equipment:**
- USB-Mikrofon (z.B. Blue Yeti, Rode NT-USB)
- Leiser Raum ohne Hall
- Aufnahme-Software (Audacity, Adobe Audition, etc.)

**Aufnahme-Einstellungen:**
- 44.1 kHz, 24-bit
- Mono-Spur
- Mikrofon-Abstand: 15-20 cm
- Aufnahme-Pegel: -12 dB bis -6 dB (Spitzen)

### Schritt 2: Bearbeitung

1. **Rauschen entfernen** (in Audacity: Effect → Noise Reduction)
2. **Normalisieren** auf -16 LUFS (Effect → Loudness Normalization)
3. **Trimmen** - Stille am Anfang/Ende entfernen (100-200ms Padding lassen)
4. **Fade In/Out** (50ms am Anfang/Ende)

### Schritt 3: Export

**In Audacity:**
1. File → Export → Export as MP3
2. Bitrate: 96 kbps
3. Channel Mode: Mono
4. Dateiname: `line_3.mp3` (Kleinbuchstaben, Unterstriche)

---

## 🤖 Methode 2: Text-to-Speech (TTS)

### Option A: macOS `say` Command

```bash
#!/bin/bash
# generate_audio.sh

# Intro
say -v Anna "Dies ist eine Straßenbahn" -o intro_tram.aiff
ffmpeg -i intro_tram.aiff -ac 1 -b:a 96k public/announcements/de/intro_tram.mp3

# Linien
say -v Anna "der Linie eins" -o line_1.aiff
ffmpeg -i line_1.aiff -ac 1 -b:a 96k public/announcements/de/lines/line_1.mp3

say -v Anna "der Linie zwei" -o line_2.aiff
ffmpeg -i line_2.aiff -ac 1 -b:a 96k public/announcements/de/lines/line_2.mp3

say -v Anna "der Linie drei" -o line_3.aiff
ffmpeg -i line_3.aiff -ac 1 -b:a 96k public/announcements/de/lines/line_3.mp3

# Cleanup
rm *.aiff
```

### Option B: Google Cloud Text-to-Speech

```bash
# Install Google Cloud SDK
curl https://sdk.cloud.google.com | bash

# Setup
gcloud init
gcloud auth application-default login

# Generate Audio
curl -X POST \
  -H "Authorization: Bearer $(gcloud auth print-access-token)" \
  -H "Content-Type: application/json; charset=utf-8" \
  -d @request.json \
  "https://texttospeech.googleapis.com/v1/text:synthesize" > response.json

# request.json:
{
  "input": {"text": "der Linie drei"},
  "voice": {"languageCode": "de-DE", "name": "de-DE-Standard-A"},
  "audioConfig": {"audioEncoding": "MP3", "sampleRateHertz": 44100}
}
```

### Option C: Amazon Polly

```bash
# Install AWS CLI
pip install awscli

# Configure
aws configure

# Generate Audio
aws polly synthesize-speech \
  --output-format mp3 \
  --voice-id Vicki \
  --text "der Linie drei" \
  line_3.mp3
```

---

## 📦 Upload-Methoden

### Methode 1: GitHub Web-Interface (Einfachst)

1. Gehe zu [github.com/jakobneukirchner/bsvg-ans-fileserver](https://github.com/jakobneukirchner/bsvg-ans-fileserver)
2. Navigiere zu `public/announcements/de/[ordner]/`
3. Klicke **"Add file" → "Upload files"**
4. Ziehe MP3-Dateien ins Fenster
5. Commit Message: `Add [description] audio files`
6. Klicke **"Commit changes"**
7. Netlify deployed automatisch!

### Methode 2: Git Command Line (Fortgeschritten)

```bash
# Clone Repository
git clone https://github.com/jakobneukirchner/bsvg-ans-fileserver.git
cd bsvg-ans-fileserver

# Dateien hinzufügen
cp ~/Desktop/audio/*.mp3 public/announcements/de/lines/

# Status prüfen
git status

# Alle neuen Dateien hinzufügen
git add public/announcements/

# Commit
git commit -m "Add line audio files (1, 2, 3, 5, 10)"

# Push
git push origin main
```

### Methode 3: Git LFS (Für große Dateien)

```bash
# Install Git LFS
git lfs install

# Track MP3 files
git lfs track "*.mp3"

# Add .gitattributes
git add .gitattributes

# Add audio files
git add public/announcements/
git commit -m "Add audio files via LFS"
git push origin main
```

---

## ✅ Validierung nach Upload

### 1. Netlify Build prüfen

Gehe zu [app.netlify.com](https://app.netlify.com) und prüfe den Build-Status.

### 2. Dateien testen

```bash
# JSON prüfen
curl https://bsvg-ans-files.netlify.app/audio-library.json

# Audio-Datei testen
curl -I https://bsvg-ans-files.netlify.app/announcements/de/lines/line_3.mp3

# Erwartete Response:
HTTP/2 200
content-type: audio/mpeg
```

### 3. Im Browser testen

```
https://bsvg-ans-files.netlify.app/announcements/de/lines/line_3.mp3
```

→ Sollte MP3 direkt abspielen!

### 4. In Haupt-App testen

1. Öffne [bsvg-ans-ibis.netlify.app](https://bsvg-ans-ibis.netlify.app)
2. Gib `003/10` ein
3. Klicke "HAUPTANSAGE ABSPIELEN"
4. Audio sollte abgespielt werden!

---

## 🛠️ Batch-Konvertierung

### Script für alle Dateien

```bash
#!/bin/bash
# convert_all.sh

INPUT_DIR="~/Desktop/raw_audio"
OUTPUT_DIR="public/announcements/de"

# Erstelle Output-Verzeichnisse
mkdir -p "$OUTPUT_DIR/lines"
mkdir -p "$OUTPUT_DIR/connectors"
mkdir -p "$OUTPUT_DIR/destinations"

# Konvertiere alle WAV zu MP3 (Mono, 96 kbps)
for file in "$INPUT_DIR"/*.wav; do
    filename=$(basename "$file" .wav)
    ffmpeg -i "$file" -ac 1 -b:a 96k "$OUTPUT_DIR/$filename.mp3"
done

echo "Konvertierung abgeschlossen!"
```

### Normalisierung batch

```bash
#!/bin/bash
# normalize_all.sh

for file in public/announcements/de/**/*.mp3; do
    # Backup
    cp "$file" "$file.bak"
    
    # Normalisiere auf -16 LUFS
    ffmpeg-normalize "$file" -o "$file" -c:a libmp3lame -b:a 96k -ar 44100
    
    echo "Normalized: $file"
done
```

---

## 📄 Checkliste vor Upload

- [ ] Alle Dateinamen kleingeschrieben
- [ ] Keine Leerzeichen (nur Unterstriche)
- [ ] Format: MP3, 96 kbps, 44.1 kHz, Mono
- [ ] Audio normalisiert (-16 LUFS)
- [ ] Keine Stille > 500ms am Anfang/Ende
- [ ] Dateien im richtigen Ordner
- [ ] `audio-library.json` aktualisiert (falls neue Dateien)

---

## 🐛 Troubleshooting

### Problem: "File too large"

**Lösung:** Komprimiere stärker

```bash
ffmpeg -i input.mp3 -ac 1 -b:a 64k output.mp3
```

### Problem: "Git push rejected"

**Lösung:** Verwende Git LFS

```bash
git lfs install
git lfs track "*.mp3"
git add .gitattributes
git add .
git commit -m "Add audio via LFS"
git push origin main
```

### Problem: "Audio not playing in app"

**Lösung 1:** Prüfe CORS

```bash
curl -I https://bsvg-ans-files.netlify.app/announcements/de/lines/line_3.mp3

# Sollte enthalten:
Access-Control-Allow-Origin: *
```

**Lösung 2:** Prüfe Path in `audio-library.json`

```json
{
  "id": "line_3",
  "path": "announcements/de/lines/line_3.mp3"  // KEIN führender Slash!
}
```

---

## 📊 Dateigrößen-Referenz

| Bitrate | 1 Sekunde | 10 Sekunden | Qualität |
|---------|-----------|-------------|----------|
| 64 kbps | 8 KB | 80 KB | Ausreichend für Ansagen |
| 96 kbps | 12 KB | 120 KB | **Empfohlen** |
| 128 kbps | 16 KB | 160 KB | Sehr gut |
| 192 kbps | 24 KB | 240 KB | Übertrieben für Ansagen |

**Beispiel-Rechnung:**
- Durchschnittliche Ansage-Datei: 1 Sekunde = **12 KB** (96 kbps)
- 50 Audio-Dateien = **600 KB**
- Sehr gut für Web-Delivery!

---

**Bei Fragen:** [Issue im Repository erstellen](https://github.com/jakobneukirchner/bsvg-ans-fileserver/issues)
