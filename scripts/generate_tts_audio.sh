#!/bin/bash

# ================================================
# BSVG Audio Generator - macOS TTS
# ================================================
# Generiert alle Audio-Dateien mit macOS 'say'
# Verwendung: ./generate_tts_audio.sh
# ================================================

OUTPUT_DIR="public/announcements/de"

# Farben für Output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo "${BLUE}=== BSVG Audio Generator ===${NC}"
echo ""

# Erstelle Verzeichnisse
mkdir -p "$OUTPUT_DIR/lines"
mkdir -p "$OUTPUT_DIR/connectors"
mkdir -p "$OUTPUT_DIR/conjunctions"
mkdir -p "$OUTPUT_DIR/destinations"
mkdir -p "$OUTPUT_DIR/stops"
mkdir -p "$OUTPUT_DIR/via"
mkdir -p "$OUTPUT_DIR/chimes"

echo "${GREEN}Verzeichnisse erstellt${NC}"
echo ""

# Funktion zum Generieren
generate_audio() {
    local text="$1"
    local output="$2"
    local temp="temp_$(basename $output .mp3).aiff"
    
    echo "Generiere: $output"
    say -v Anna "$text" -o "$temp"
    ffmpeg -i "$temp" -ac 1 -b:a 96k -ar 44100 "$output" -y -loglevel quiet
    rm "$temp"
}

# Intro
echo "${BLUE}[1/21] Intro${NC}"
generate_audio "Dies ist eine Straßenbahn" "$OUTPUT_DIR/intro_tram.mp3"

# Linien
echo "${BLUE}[2/21] Linie 1${NC}"
generate_audio "der Linie eins" "$OUTPUT_DIR/lines/line_1.mp3"

echo "${BLUE}[3/21] Linie 2${NC}"
generate_audio "der Linie zwei" "$OUTPUT_DIR/lines/line_2.mp3"

echo "${BLUE}[4/21] Linie 3${NC}"
generate_audio "der Linie drei" "$OUTPUT_DIR/lines/line_3.mp3"

echo "${BLUE}[5/21] Linie 5${NC}"
generate_audio "der Linie fünf" "$OUTPUT_DIR/lines/line_5.mp3"

echo "${BLUE}[6/21] Linie 10${NC}"
generate_audio "der Linie zehn" "$OUTPUT_DIR/lines/line_10.mp3"

# Connectors
echo "${BLUE}[7/21] Connector: nach${NC}"
generate_audio "nach" "$OUTPUT_DIR/connectors/nach.mp3"

echo "${BLUE}[8/21] Connector: über${NC}"
generate_audio "über" "$OUTPUT_DIR/connectors/ueber.mp3"

# Conjunctions
echo "${BLUE}[9/21] Conjunction: und${NC}"
generate_audio "und" "$OUTPUT_DIR/conjunctions/und.mp3"

# Destinations
echo "${BLUE}[10/21] Ziel: Gliesmarode${NC}"
generate_audio "Gliesmarode" "$OUTPUT_DIR/destinations/gliesmarode.mp3"

echo "${BLUE}[11/21] Ziel: Volkmarode${NC}"
generate_audio "Volkmarode" "$OUTPUT_DIR/destinations/volkmarode.mp3"

echo "${BLUE}[12/21] Ziel: Lehndorf${NC}"
generate_audio "Lehndorf" "$OUTPUT_DIR/destinations/lehndorf.mp3"

echo "${BLUE}[13/21] Ziel: Heidberg${NC}"
generate_audio "Heidberg" "$OUTPUT_DIR/destinations/heidberg.mp3"

echo "${BLUE}[14/21] Ziel: Rautheim${NC}"
generate_audio "Rautheim" "$OUTPUT_DIR/destinations/rautheim.mp3"

echo "${BLUE}[15/21] Ziel: Stöckheim${NC}"
generate_audio "Stöckheim" "$OUTPUT_DIR/destinations/stoeckheim.mp3"

echo "${BLUE}[16/21] Ziel: Melverode${NC}"
generate_audio "Melverode" "$OUTPUT_DIR/destinations/melverode.mp3"

# Stops
echo "${BLUE}[17/21] Haltestelle: Hauptbahnhof${NC}"
generate_audio "Hauptbahnhof" "$OUTPUT_DIR/stops/hauptbahnhof.mp3"

echo "${BLUE}[18/21] Haltestelle: Rathaus${NC}"
generate_audio "Rathaus" "$OUTPUT_DIR/stops/rathaus.mp3"

echo "${BLUE}[19/21] Haltestelle: Altewiekring${NC}"
generate_audio "Altewiekring" "$OUTPUT_DIR/stops/altewiekring.mp3"

# Via
echo "${BLUE}[20/21] Via: Ersatzhaltestelle Altewiekring${NC}"
generate_audio "Ersatzhaltestelle Altewiekring" "$OUTPUT_DIR/via/ersatz_awr.mp3"

# Chime (Stille als Placeholder)
echo "${BLUE}[21/21] Chime: Türschließton${NC}"
ffmpeg -f lavfi -i anullsrc=r=44100:cl=mono -t 1 -q:a 9 -acodec libmp3lame "$OUTPUT_DIR/chimes/door_closing.mp3" -y -loglevel quiet

echo ""
echo "${GREEN}=== Fertig! ===${NC}"
echo "${GREEN}Alle Audio-Dateien wurden generiert.${NC}"
echo ""
echo "Nächste Schritte:"
echo "1. Höre die Dateien ab und prüfe die Qualität"
echo "2. git add public/announcements/"
echo "3. git commit -m 'Add generated TTS audio files'"
echo "4. git push origin main"
