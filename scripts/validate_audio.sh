#!/bin/bash

# ================================================
# BSVG Audio Validator
# ================================================
# Validiert alle Audio-Dateien
# Verwendung: ./validate_audio.sh
# ================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "${GREEN}=== BSVG Audio Validator ===${NC}"
echo ""

ERRORS=0
WARNINGS=0

# Prüfe alle MP3-Dateien
find public/announcements -name "*.mp3" | while read -r file; do
    # Dateiname prüfen (nur Kleinbuchstaben und Unterstriche)
    filename=$(basename "$file")
    if [[ ! "$filename" =~ ^[a-z0-9_]+\.mp3$ ]]; then
        echo "${RED}ERROR: Ungültiger Dateiname: $filename${NC}"
        ((ERRORS++))
    fi
    
    # Prüfe Audio-Format
    info=$(ffprobe -v quiet -print_format json -show_format -show_streams "$file")
    
    # Bitrate
    bitrate=$(echo "$info" | jq -r '.format.bit_rate' | awk '{print int($1/1000)}')
    if [ "$bitrate" -gt 128 ]; then
        echo "${YELLOW}WARNING: Hohe Bitrate ($bitrate kbps): $filename${NC}"
        ((WARNINGS++))
    fi
    
    # Channels (sollte Mono sein)
    channels=$(echo "$info" | jq -r '.streams[0].channels')
    if [ "$channels" -ne 1 ]; then
        echo "${YELLOW}WARNING: Nicht Mono ($channels channels): $filename${NC}"
        ((WARNINGS++))
    fi
    
    # Sample Rate
    sample_rate=$(echo "$info" | jq -r '.streams[0].sample_rate')
    if [ "$sample_rate" -ne 44100 ]; then
        echo "${YELLOW}WARNING: Sample Rate nicht 44.1kHz ($sample_rate Hz): $filename${NC}"
        ((WARNINGS++))
    fi
done

echo ""
if [ "$ERRORS" -eq 0 ] && [ "$WARNINGS" -eq 0 ]; then
    echo "${GREEN}✅ Alle Dateien sind valide!${NC}"
else
    echo "${YELLOW}Errors: $ERRORS | Warnings: $WARNINGS${NC}"
fi
