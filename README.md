# BSVG Ansagesystem - Fileserver

📦 **Zentraler Fileserver für Audio-Dateien und JSON-Daten**

## 🌐 Live-URLs

**GitHub Raw (Primär):** https://raw.githubusercontent.com/jakobneukirchner/bsvg-ans-fileserver/main/public/

**Netlify (Backup):** https://bsvg-ibis-fs.netlify.app

**Haupt-App:** https://bsvg-ibis.netlify.app

---

## 📁 Ordnerstruktur

```
bsvg-ans-fileserver/
├── public/
│   ├── lines.json
│   ├── stops.json
│   ├── cycles.json
│   ├── audio-library.json
│   └── announcements/de/
│       ├── lines/
│       ├── connectors/
│       ├── conjunctions/
│       ├── destinations/
│       ├── stops/
│       ├── via/
│       └── chimes/
├── netlify.toml
├── package.json
└── README.md
```

---

## 🚀 Zugriff

### GitHub Raw (Primär)

**Vorteile:**
- ✅ Immer verfügbar (99.9% Uptime)
- ✅ Kein Server nötig
- ✅ Automatische Updates bei Git Push
- ✅ Kostenlos und unbegrenzt

**JSON-Dateien:**
```
https://raw.githubusercontent.com/jakobneukirchner/bsvg-ans-fileserver/main/public/lines.json
https://raw.githubusercontent.com/jakobneukirchner/bsvg-ans-fileserver/main/public/stops.json
https://raw.githubusercontent.com/jakobneukirchner/bsvg-ans-fileserver/main/public/cycles.json
https://raw.githubusercontent.com/jakobneukirchner/bsvg-ans-fileserver/main/public/audio-library.json
```

**Audio-Dateien:**
```
https://raw.githubusercontent.com/jakobneukirchner/bsvg-ans-fileserver/main/public/announcements/de/lines/line_3.mp3
```

### Netlify (Backup)

```
https://bsvg-ibis-fs.netlify.app/lines.json
https://bsvg-ibis-fs.netlify.app/announcements/de/lines/line_3.mp3
```

---

## 🎵 Audio-Dateien hinzufügen

### Format-Anforderungen

- **Format:** MP3
- **Bitrate:** 96-128 kbps
- **Sample Rate:** 44.1 kHz
- **Kanäle:** Mono bevorzugt
- **Dateiname:** Kleinbuchstaben, Unterstriche

### Upload via GitHub Web-Interface

1. Gehe zu: https://github.com/jakobneukirchner/bsvg-ans-fileserver
2. Navigiere zu `public/announcements/de/[ordner]/`
3. "Add file" → "Upload files"
4. Wähle MP3-Dateien
5. Commit!

→ Sofort verfügbar via GitHub Raw!

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

### lines.json

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

### audio-library.json

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

Die Haupt-App nutzt GitHub Raw als primäre Quelle:

```javascript
// config.js in bsvg-ans-ibis
const CONFIG = {
  FILESERVER_URL: 'https://raw.githubusercontent.com/jakobneukirchner/bsvg-ans-fileserver/main/public'
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

## ✅ Testen

### JSON-Dateien

```bash
curl https://raw.githubusercontent.com/jakobneukirchner/bsvg-ans-fileserver/main/public/lines.json
```

### Audio-Dateien (wenn hochgeladen)

```bash
curl -I https://raw.githubusercontent.com/jakobneukirchner/bsvg-ans-fileserver/main/public/announcements/de/lines/line_3.mp3
```

### In der App testen

1. Öffne: https://bsvg-ibis.netlify.app
2. Eingabe: `003/10`
3. "HAUPTANSAGE ABSPIELEN"
4. Audio sollte von GitHub Raw geladen werden!

---

## 📊 Monitoring

### GitHub Raw Health Check

```bash
curl -f https://raw.githubusercontent.com/jakobneukirchner/bsvg-ans-fileserver/main/public/lines.json && echo "OK" || echo "FAIL"
```

### Netlify Dashboard (Backup)

https://app.netlify.com/sites/bsvg-ibis-fs

---

## 📧 Links

**Live:**
- Haupt-App: https://bsvg-ibis.netlify.app
- GitHub Raw: https://raw.githubusercontent.com/jakobneukirchner/bsvg-ans-fileserver/main/public/
- Netlify (Backup): https://bsvg-ibis-fs.netlify.app

**Repositories:**
- Fileserver: https://github.com/jakobneukirchner/bsvg-ans-fileserver
- Haupt-App: https://github.com/jakobneukirchner/bsvg-ans-ibis

**Dokumentation:**
- Audio-Upload-Guide: [AUDIO_UPLOAD_GUIDE.md](AUDIO_UPLOAD_GUIDE.md)

---

## 🚀 Status

🟢 **Live & Production Ready**

- ✅ GitHub Raw aktiv
- ✅ Netlify Backup deployed
- ✅ JSON-Dateien verfügbar
- ✅ Haupt-App integriert
- ⏳ Audio-Dateien müssen hochgeladen werden

---

**Made with ❤️ for BSVG Braunschweig**
