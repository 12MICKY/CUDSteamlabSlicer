#!/bin/bash
set -e

APPIMAGE_URL="https://github.com/12MICKY/snapmaker-printers/releases/latest/download/StemlabSlicer.AppImage"
INSTALL_DIR="$HOME/Applications"
APPIMAGE="$INSTALL_DIR/StemlabSlicer.AppImage"
echo "=== StemlabSlicer Setup ==="

# 1. Download AppImage
mkdir -p "$INSTALL_DIR"
if [ ! -f "$APPIMAGE" ]; then
  echo "[1/2] Downloading StemlabSlicer..."
  wget -q --show-progress -O "$APPIMAGE" "$APPIMAGE_URL"
  chmod +x "$APPIMAGE"
else
  echo "[1/2] StemlabSlicer already exists — skipping"
fi

# 2. Desktop shortcut
ICON="$HOME/.local/share/icons/orcaslicer-chula.png"
mkdir -p "$(dirname "$ICON")"
wget -q -O "$ICON" "https://raw.githubusercontent.com/12MICKY/snapmaker-printers/main/icon.png"

DESKTOP="$HOME/.local/share/applications/orcaslicer.desktop"
mkdir -p "$(dirname "$DESKTOP")"
cat > "$DESKTOP" <<EOF
[Desktop Entry]
Name=StemlabSlicer
Exec=$APPIMAGE
Icon=$ICON
Type=Application
Categories=Graphics;
EOF
echo "[2/2] Desktop shortcut created"

echo ""
echo "Done! Printer configs (U1-1 to U1-8) are built into StemlabSlicer."
echo "Connect to VPN then launch:"
echo "  $APPIMAGE"
