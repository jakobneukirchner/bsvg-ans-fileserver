# BSVG Ansagesystem - Fileserver

📦 **Zentraler Fileserver für Audio-Dateien und JSON-Daten**

Dieser Fileserver stellt alle Audio-Dateien und JSON-Konfigurationsdateien für das BSVG Ansagesystem bereit.

---

## 📁 Ordnerstruktur

```
bsvg-ans-fileserver/
├── netlify.toml              # Netlify-Konfiguration (CORS)
├── README.md                 # Diese Datei
├── package.json              # NPM-Konfiguration
└── public/                   # Publish Directory
    ├── lines.json           # Linien-Konfiguration
    ├── stops.json           # Haltestellen-Konfiguration
    ├── cycles.json          # Umlauf-Konfiguration
    ├── audio-library.json   # Audio-Bibliothek (Index)
    ├── announcements/       # Audio-Dateien
    │   └── de/              # Deutsche Ansagen
    │       ├── intro_tram.mp3
    │       ├── lines/       # Liniennummern
    │       │   ├── line_1.mp3
    │       │   ├── line_2.mp3
    │       │   ├── line_3.mp3
    │       │   ├── line_5.mp3
    │       │   └── line_10.mp3
    │       ├── connectors/  # Verbindungswörter
    │       │   ├── nach.mp3
    │       │   └── ueber.mp3
    │       ├── conjunctions/ # Konjunktionen
    │       │   └── und.mp3
    │       ├── destinations/ # Ziele
    │       │   ├── gliesmarode.mp3
    │       │   ├── volkmarode.mp3
    │       │   ├── lehndorf.mp3
    │       │   ├── heidberg.mp3
    │       │   ├── rautheim.mp3
    │       │   ├── stoeckheim.mp3
    │       │   └── melverode.mp3
    │       ├── stops/       # Haltestellen
    │       │   ├── hauptbahnhof.mp3
    │       │   ├── rathaus.mp3
    │       │   └── altewiekring.mp3
    │       ├── via/         # Via-Stops (Umleitungen)
    │       │   └── ersatz_awr.mp3
    │       └── chimes/      # Töne
    │           └── door_closing.mp3
    └── placeholder/         # Placeholder-Audio (Entwicklung)
        └── silent_1s.mp3
```

---

## 🚀 Deployment auf Netlify

### 1. Netlify verbinden

1. Gehe zu [netlify.com](https://www.netlify.com/)
2. "Add new site" → "Import an existing project"
3. Wähle GitHub → `jakobneukirchner/bsvg-ans-fileserver`
4. **Build Settings:**
   - **Build command:** (leer lassen)
   - **Publish directory:** `public`
5. **Deploy!**

### 2. Domain konfigurieren

Empfohlene Domain:
```
https://bsvg-ans-files.netlify.app
```

### 3. CORS ist aktiviert

Die `netlify.toml` enthält bereits CORS-Header:
```toml
Access-Control-Allow-Origin = "*"
```

---

## 🎵 Audio-Dateien hinzufügen

### Format-Anforderungen

- **Format:** MP3
- **Bitrate:** 128 kbps (empfohlen)
- **Sample Rate:** 44.1 kHz
- **Mono/Stereo:** Mono bevorzugt (kleinere Dateigröße)
- **Dateiname:** Kleinbuchstaben, Unterstriche statt Leerzeichen

### Beispiel-Dateinamen

```
✅ intro_tram.mp3
✅ line_3.mp3
✅ dest_gliesmarode.mp3
✅ ersatz_awr.mp3

❌ Intro Tram.mp3
❌ Line 3.mp3
❌ Dest-Gliesmarode.mp3
```

### Upload-Methoden

**Option 1: GitHub Web-Interface**
1. Navigiere zu `public/announcements/de/[ordner]/`
2. Klicke auf "Add file" → "Upload files"
3. Wähle MP3-Dateien aus
4. Commit!

**Option 2: Git Command Line**
```bash
git clone https://github.com/jakobneukirchner/bsvg-ans-fileserver.git
cd bsvg-ans-fileserver

# Füge Dateien hinzu
cp /path/to/audio/*.mp3 public/announcements/de/lines/

git add .
git commit -m "Add line audio files"
git push
```

**Option 3: Netlify CLI**
```bash
netlify deploy --prod
```

---

## 📝 JSON-Dateien bearbeiten

### lines.json

Definiert alle verfügbaren Linien:

```json
{
  "lines": [
    {
      "id": "3",
      "paddedId": "003",
      "name": "Linie 3",
      "displayName": "3",
      "color": "#0066B3",
      "textColor": "#FFFFFF",
      "type": "tram",
      "operator": "BSVG",
      "audioId": "line_3"
    }
  ]
}
```

### cycles.json

Definiert Umläufe und Routen:

```json
{
  "cycles": [
    {
      "cycleId": "3_10",
      "paddedId": "10",
      "lineId": "3",
      "type": "diversion",
      "direction": "Gliesmarode",
      "destinationAudioId": "dest_gliesmarode",
      "viaStops": ["ERS-A"],
      "route": [...]
    }
  ]
}
```

### audio-library.json

Index aller Audio-Dateien:

```json
{
  "audioFiles": [
    {
      "id": "line_3",
      "path": "announcements/de/lines/line_3.mp3",
      "duration": 0.8,
      "language": "de",
      "tags": ["line", "line_number"],
      "description": "der Linie 3"
    }
  ]
}
```

---

## 🔗 Integration mit Haupt-App

### In bsvg-ans-ibis konfigurieren

**File:** `public/js/config.js`

```javascript
const CONFIG = {
  // ANPASSEN: Fileserver-URL nach Deployment
  FILESERVER_URL: 'https://bsvg-ans-files.netlify.app',
  
  ENDPOINTS: {
    LINES: '/lines.json',
    STOPS: '/stops.json',
    CYCLES: '/cycles.json',
    AUDIO_LIBRARY: '/audio-library.json'
  }
};
```

---

## 🛠️ Entwicklung lokal

### Server starten

```bash
cd bsvg-ans-fileserver
python -m http.server 8001 --directory public
```

### In Browser testen

```
http://localhost:8001/lines.json
http://localhost:8001/announcements/de/intro_tram.mp3
```

### CORS lokal

Für lokale Entwicklung CORS deaktivieren:
- Chrome: `--disable-web-security --user-data-dir=/tmp/chrome`
- Oder Python-Server mit CORS:

```python
# server.py
from http.server import HTTPServer, SimpleHTTPRequestHandler
import os

class CORSRequestHandler(SimpleHTTPRequestHandler):
    def end_headers(self):
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, OPTIONS')
        SimpleHTTPRequestHandler.end_headers(self)

if __name__ == '__main__':
    os.chdir('public')
    server = HTTPServer(('localhost', 8001), CORSRequestHandler)
    print('Server running on http://localhost:8001')
    server.serve_forever()
```

```bash
python server.py
```

---

## 📊 Dateigrößen optimieren

### Audio komprimieren

**Mit FFmpeg:**

```bash
# Mono, 64 kbps (sehr klein, ausreichend für Ansagen)
ffmpeg -i input.mp3 -ac 1 -b:a 64k output.mp3

# Mono, 96 kbps (gute Qualität)
ffmpeg -i input.mp3 -ac 1 -b:a 96k output.mp3

# Mono, 128 kbps (sehr gute Qualität)
ffmpeg -i input.mp3 -ac 1 -b:a 128k output.mp3
```

### Batch-Konvertierung

```bash
# Alle MP3s in Ordner konvertieren
for file in *.mp3; do
  ffmpeg -i "$file" -ac 1 -b:a 96k "converted_$file"
done
```

---

## 📊 Monitoring

### Netlify Analytics

- Requests pro Tag
- Bandwidth Usage
- Top Files

### Bandbreiten-Schätzung

**Beispielrechnung:**

- Durchschnittliche Ansage: 5 Audiodateien à 50 KB = **250 KB**
- 1000 Ansagen/Tag = **250 MB/Tag**
- 30.000 Ansagen/Monat = **7.5 GB/Monat**

Netlify Free Tier: **100 GB/Monat** → Mehr als ausreichend!

---

## ⚠️ Wichtige Hinweise

### Audio-Dateien NICHT committen!

Große Binärdateien machen Git langsam. Verwende stattdessen:

**Option 1: Git LFS (Large File Storage)**

```bash
git lfs install
git lfs track "*.mp3"
git add .gitattributes
```

**Option 2: Netlify Direct Upload**

Upload direkt via Netlify Web-Interface oder CLI.

### Placeholder während Entwicklung

Bis echte Audio-Dateien vorhanden:

1. Nutze `public/placeholder/silent_1s.mp3`
2. Oder generiere Placeholder mit Text-to-Speech:

```bash
# Mit macOS 'say' command
say "der Linie 3" -o line_3.aiff
ffmpeg -i line_3.aiff -b:a 96k line_3.mp3
```

---

## 🔒 Sicherheit

### Öffentlicher Zugriff

Dieser Fileserver ist **öffentlich zugänglich**. Keine sensiblen Daten speichern!

### Rate Limiting

Netlify hat eingebautes Rate Limiting:
- 3 Requests/Sekunde pro IP
- 100 GB Bandwidth/Monat (Free Tier)

---

## 📧 Kontakt

**Repository:** [https://github.com/jakobneukirchner/bsvg-ans-fileserver](https://github.com/jakobneukirchner/bsvg-ans-fileserver)

**Haupt-App:** [https://github.com/jakobneukirchner/bsvg-ans-ibis](https://github.com/jakobneukirchner/bsvg-ans-ibis)

---

**Made with ❤️ for BSVG Braunschweig**
