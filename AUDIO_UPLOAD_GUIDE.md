# Audio-Upload Anleitung

🎵 **Schritt-für-Schritt Anleitung zum Hochladen von Audio-Dateien**

---

## 🎯 Quick Start

### 1. Audio-Datei vorbereiten

```bash
# Mit FFmpeg konvertieren (Mono, 96 kbps)
ffmpeg -i input.wav -ac 1 -b:a 96k line_3.mp3
```

### 2. Hochladen via GitHub

1. Gehe zu: https://github.com/jakobneukirchner/bsvg-ans-fileserver
2. Navigiere zu `public/announcements/de/lines/`
3. "Add file" → "Upload files"
4. Wähle `line_3.mp3`
5. Commit!

### 3. Automatisches Deployment

Netlify deployed automatisch → Audio ist live unter:
```
https://bsvg-ibis-fs.netlify.app/announcements/de/lines/line_3.mp3
```

---

## ⚙️ Format-Anforderungen

✅ **Empfohlen:**
- Format: MP3
- Bitrate: 96 kbps
- Sample Rate: 44.1 kHz
- Kanäle: Mono
- Dateiname: Kleinbuchstaben, Unterstriche

❌ **Nicht erlaubt:**
- Leerzeichen im Dateinamen
- Großbuchstaben
- Sonderzeichen außer Unterstrich

---

## 🎤 Aufnahme-Methoden

### Methode 1: Professionelle Aufnahme

**Equipment:**
- USB-Mikrofon (z.B. Blue Yeti)
- Audacity (kostenlos)

**Prozess:**
1. Aufnahme in Audacity (44.1 kHz, Mono)
2. Rauschen entfernen (Effect → Noise Reduction)
3. Normalisieren (Effect → Normalize)
4. Trimmen (Stille entfernen)
5. Export als MP3 (96 kbps, Mono)

### Methode 2: Text-to-Speech (Testing)

**macOS:**
```bash
say -v Anna "der Linie drei" -o temp.aiff
ffmpeg -i temp.aiff -ac 1 -b:a 96k line_3.mp3
rm temp.aiff
```

**Linux:**
```bash
espeak-ng -v de "der Linie drei" -w temp.wav
ffmpeg -i temp.wav -ac 1 -b:a 96k line_3.mp3
rm temp.wav
```

---

## 📦 Upload-Methoden

### Methode 1: GitHub Web (Einfachst)

1. https://github.com/jakobneukirchner/bsvg-ans-fileserver
2. `public/announcements/de/[ordner]/`
3. "Add file" → "Upload files"
4. Drag & Drop MP3
5. Commit!

### Methode 2: Git CLI

```bash
git clone https://github.com/jakobneukirchner/bsvg-ans-fileserver.git
cd bsvg-ans-fileserver

cp ~/audio/line_3.mp3 public/announcements/de/lines/

git add public/announcements/
git commit -m "Add line 3 audio"
git push origin main
```

### Methode 3: GitHub CLI

```bash
gh repo clone jakobneukirchner/bsvg-ans-fileserver
cd bsvg-ans-fileserver

cp ~/audio/line_3.mp3 public/announcements/de/lines/

gh repo sync
```

---

## ✅ Validierung

### Nach Upload prüfen

**1. Netlify Build:**
https://app.netlify.com/sites/bsvg-ibis-fs/deploys

**2. Datei testen:**
```bash
curl -I https://bsvg-ibis-fs.netlify.app/announcements/de/lines/line_3.mp3

# Erwartete Response:
HTTP/2 200
content-type: audio/mpeg
```

**3. Im Browser:**
```
https://bsvg-ibis-fs.netlify.app/announcements/de/lines/line_3.mp3
```

**4. In der App:**
1. Öffne https://bsvg-ans-ibis.netlify.app
2. Eingabe: `003/10`
3. "HAUPTANSAGE ABSPIELEN"
4. Audio sollte abgespielt werden!

---

## 🛠️ FFmpeg Cheat Sheet

```bash
# WAV zu MP3 (Mono, 96 kbps)
ffmpeg -i input.wav -ac 1 -b:a 96k output.mp3

# Stereo zu Mono
ffmpeg -i stereo.mp3 -ac 1 mono.mp3

# Bitrate reduzieren
ffmpeg -i high.mp3 -b:a 96k low.mp3

# Sample Rate ändern
ffmpeg -i input.mp3 -ar 44100 output.mp3

# Batch-Konvertierung
for f in *.wav; do ffmpeg -i "$f" -ac 1 -b:a 96k "${f%.wav}.mp3"; done
```

---

## 📊 Dateigrößen

| Bitrate | 1 Sek | 10 Sek | Qualität |
|---------|-------|--------|----------|
| 64 kbps | 8 KB | 80 KB | Ausreichend |
| 96 kbps | 12 KB | 120 KB | **Empfohlen** |
| 128 kbps | 16 KB | 160 KB | Sehr gut |

---

## 🐛 Troubleshooting

### Problem: "Audio nicht gefunden"

**Lösung:** Prüfe Path in `audio-library.json`

```json
{
  "id": "line_3",
  "path": "announcements/de/lines/line_3.mp3"  // KEIN führender Slash!
}
```

### Problem: "CORS Error"

**Lösung:** `netlify.toml` prüfen:

```toml
[[headers]]
  for = "/*"
  [headers.values]
    Access-Control-Allow-Origin = "*"
```

### Problem: "Datei zu groß"

**Lösung:** Stärker komprimieren

```bash
ffmpeg -i large.mp3 -ac 1 -b:a 64k small.mp3
```

---

## 📝 Checkliste

- [ ] Dateiname: Kleinbuchstaben, Unterstriche
- [ ] Format: MP3, 96 kbps, 44.1 kHz, Mono
- [ ] Datei < 200 KB
- [ ] Kein Rauschen
- [ ] Keine lange Stille am Anfang/Ende
- [ ] Im richtigen Ordner
- [ ] `audio-library.json` aktualisiert (falls neu)
- [ ] Netlify Build erfolgreich
- [ ] Audio in App getestet

---

**Bei Fragen:** [Issue erstellen](https://github.com/jakobneukirchner/bsvg-ans-fileserver/issues)
