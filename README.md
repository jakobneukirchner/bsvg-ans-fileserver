# BSVG Ansagesystem - Fileserver

📦 **Zentraler Fileserver für Audio-Dateien und JSON-Daten**

## 🌐 Live-URLs

**Netlify (Primär):** https://bsvg-ibis-fs.netlify.app

**GitHub Raw Content (Backup):** https://raw.githubusercontent.com/jakobneukirchner/bsvg-ans-fileserver/main/public/

---

## 📁 Ordnerstruktur

```
bsvg-ans-fileserver/
├── netlify.toml
├── README.md
├── package.json
└── public/
    ├── lines.json
    ├── stops.json
    ├── cycles.json
    ├── audio-library.json
    └── announcements/de/
        ├── lines/
        ├── connectors/
        ├── conjunctions/
        ├── destinations/
        ├── stops/
        ├── via/
        └── chimes/
```

---

## 🚀 Deployment

**Status:** ✅ Deployed auf Netlify

**URL:** https://bsvg-ibis-fs.netlify.app

### Testen

```bash
# JSON-Dateien
curl https://bsvg-ibis-fs.netlify.app/lines.json
curl https://bsvg-ibis-fs.netlify.app/audio-library.json

# Audio-Dateien (wenn vorhanden)
curl -I https://bsvg-ibis-fs.netlify.app/announcements/de/lines/line_3.mp3
```

### GitHub Raw Alternative

```bash
# JSON über GitHub Raw
curl https://raw.githubusercontent.com/jakobneukirchner/bsvg-ans-fileserver/main/public/lines.json

# Audio über GitHub Raw
curl https://raw.githubusercontent.com/jakobneukirchner/bsvg-ans-fileserver/main/public/announcements/de/lines/line_3.mp3
```

---

## 🎵 Audio-Dateien hinzufügen

### Format-Anforderungen

- **Format:** MP3
- **Bitrate:** 96-128 kbps
- **Sample Rate:** 44.1 kHz
- **Kanäle:** Mono bevorzugt
- **Dateiname:** Kleinbuchstaben, Unterstriche

### Upload via GitHub

1. Navigiere zu `public/announcements/de/[ordner]/`
2. "Add file" → "Upload files"
3. Wähle MP3-Dateien
4. Commit!

Netlify deployed automatisch nach jedem Push!

### Upload via Git

```bash
git clone https://github.com/jakobneukirchner/bsvg-ans-fileserver.git
cd bsvg-ans-fileserver

# Audio-Dateien hinzufügen
cp ~/audio/*.mp3 public/announcements/de/lines/

git add public/announcements/
git commit -m "Add audio files"
git push origin main
```

---

## 📝 JSON-Struktur

### Beispiel: lines.json

```json
{
  "lines": [
    {
      "id": "3",
      "paddedId": "003",
      "name": "Linie 3",
      "displayName": "3",
      "color": "#0066B3",
      "audioId": "line_3"
    }
  ]
}
```

### Beispiel: audio-library.json

```json
{
  "audioFiles": [
    {
      "id": "line_3",
      "path": "announcements/de/lines/line_3.mp3",
      "duration": 0.8,
      "language": "de",
      "description": "der Linie 3"
    }
  ]
}
```

---

## 🔗 Integration

Die Haupt-App `bsvg-ans-ibis` ist bereits konfiguriert:

```javascript
// config.js
const CONFIG = {
  FILESERVER_URL: 'https://bsvg-ibis-fs.netlify.app',
  // Fallback auf GitHub Raw falls Netlify down
  FILESERVER_URL_FALLBACK: 'https://raw.githubusercontent.com/jakobneukirchner/bsvg-ans-fileserver/main/public'
};
```

---

## ⚙️ Lokale Entwicklung

```bash
cd bsvg-ans-fileserver
python -m http.server 8001 --directory public
```

Testen:
```
http://localhost:8001/lines.json
```

---

## 📊 Monitoring

### Netlify Dashboard

- Deploy Status: https://app.netlify.com
- Bandwidth Usage
- Request Analytics

### Health Check

```bash
curl -f https://bsvg-ibis-fs.netlify.app/lines.json && echo "OK" || echo "FAIL"
```

---

## 📧 Links

- **Fileserver:** https://github.com/jakobneukirchner/bsvg-ans-fileserver
- **Haupt-App:** https://github.com/jakobneukirchner/bsvg-ans-ibis
- **Live-Demo:** https://bsvg-ibis-fs.netlify.app
- **Audio-Upload-Guide:** [AUDIO_UPLOAD_GUIDE.md](AUDIO_UPLOAD_GUIDE.md)

---

**Status:** 🟢 Production Ready
