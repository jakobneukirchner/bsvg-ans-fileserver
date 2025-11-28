# Deutsche Ansagen

Hier werden alle deutschen Audio-Ansagen gespeichert.

## Ordnerstruktur

```
de/
├── intro_tram.mp3         # "Dies ist eine Straßenbahn"
├── lines/                 # Liniennummern
├── connectors/            # Verbindungswörter (nach, über)
├── conjunctions/          # Konjunktionen (und)
├── destinations/          # Ziele
├── stops/                 # Haltestellen
├── via/                   # Via-Stops (Umleitungen)
└── chimes/                # Töne (Türschließton)
```

## Datei-Anforderungen

- **Format:** MP3
- **Bitrate:** 96-128 kbps
- **Sample Rate:** 44.1 kHz
- **Kanäle:** Mono (bevorzugt)
- **Dateiname:** Kleinbuchstaben, Unterstriche

## Beispiel-Ansage

**Linie 3 nach Gliesmarode über Ersatzhaltestelle:**

1. `intro_tram.mp3` - "Dies ist eine Straßenbahn"
2. `lines/line_3.mp3` - "der Linie 3"
3. `connectors/nach.mp3` - "nach"
4. `destinations/gliesmarode.mp3` - "Gliesmarode"
5. `connectors/ueber.mp3` - "über"
6. `via/ersatz_awr.mp3` - "Ersatzhaltestelle Altewiekring"
