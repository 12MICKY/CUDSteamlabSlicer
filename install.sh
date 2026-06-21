#!/bin/bash
set -e

REPO="12MICKY/CUDSteamlabSlicer"
BASE_URL="https://github.com/$REPO/releases/latest/download"
RAW_URL="https://raw.githubusercontent.com/$REPO/main"

detect_platform() {
  case "$(uname -s)" in
    Linux*)  echo "linux" ;;
    Darwin*) [[ "$(uname -m)" == "arm64" ]] && echo "macos-arm" || echo "macos-intel" ;;
    *)       echo "unsupported" ;;
  esac
}

PLATFORM=$(detect_platform)

case "$PLATFORM" in
  linux)
    echo "=== StemlabSlicer Setup (Linux) ==="
    INSTALL_DIR="$HOME/Applications"
    APPIMAGE="$INSTALL_DIR/StemlabSlicer.AppImage"

    mkdir -p "$INSTALL_DIR"
    if [ ! -f "$APPIMAGE" ]; then
      echo "[1/2] Downloading StemlabSlicer..."
      wget -q --show-progress -O "$APPIMAGE" "$BASE_URL/StemlabSlicer_Linux.AppImage"
      chmod +x "$APPIMAGE"
    else
      echo "[1/2] Already installed — skipping download"
    fi

    ICON="$HOME/.local/share/icons/stemlabslicer.png"
    mkdir -p "$(dirname "$ICON")"
    wget -q -O "$ICON" "$RAW_URL/icon.png"

    DESKTOP="$HOME/.local/share/applications/stemlabslicer.desktop"
    mkdir -p "$(dirname "$DESKTOP")"
    cat > "$DESKTOP" <<EOF
[Desktop Entry]
Name=StemlabSlicer
Exec=$APPIMAGE
Icon=$ICON
Type=Application
Terminal=false
StartupNotify=true
Categories=Graphics;
EOF
    echo "[2/2] Desktop shortcut created"
    echo ""
    echo "Done! Connect to VPN then launch: $APPIMAGE"
    ;;

  macos-intel|macos-arm)
    echo "=== StemlabSlicer Setup (macOS) ==="
    [[ "$PLATFORM" == "macos-arm" ]] && DMG="StemlabSlicer_Mac_arm64.dmg" || DMG="StemlabSlicer_Mac.dmg"

    echo "[1/2] Downloading $DMG..."
    curl -L --progress-bar -o "/tmp/$DMG" "$BASE_URL/$DMG"

    echo "[2/2] Installing to /Applications..."
    hdiutil attach "/tmp/$DMG" -quiet -nobrowse -readonly -mountpoint /tmp/stemlabslicer_mount
    rm -rf /Applications/StemlabSlicer.app
    cp -r "/tmp/stemlabslicer_mount/StemlabSlicer.app" "/Applications/"
    hdiutil detach /tmp/stemlabslicer_mount -quiet
    rm "/tmp/$DMG"

    echo ""
    echo "Done! Connect to VPN then open StemlabSlicer from Launchpad."
    echo "Note: Right-click → Open on first launch if Gatekeeper blocks it."
    ;;

  *)
    echo "Unsupported platform. Use install.ps1 on Windows." >&2
    exit 1
    ;;
esac
