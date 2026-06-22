#!/bin/bash
set -e

REPO="12MICKY/CUDSteamlabSlicer"
BASE_URL="https://github.com/$REPO/releases/latest/download"
RAW_URL="https://raw.githubusercontent.com/$REPO/main"

detect_platform() {
  case "$(uname -s)" in
    Linux*)  echo "linux" ;;
    Darwin*) echo "macos" ;;
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
      echo "[1/4] Downloading StemlabSlicer..."
      wget -q --show-progress -O "$APPIMAGE" "$BASE_URL/StemlabSlicer_Linux.AppImage"
      chmod +x "$APPIMAGE"
    else
      echo "[1/4] Already installed — skipping download"
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
    echo "[2/4] Desktop shortcut created"

    echo "[3/4] Installing Snapmaker vendor profiles..."
    TMPDIR=$(mktemp -d)
    cd "$TMPDIR"
    "$APPIMAGE" --appimage-extract 'resources/profiles/Snapmaker*' > /dev/null 2>&1
    CONF_DIR="$HOME/.config/OrcaSlicer"
    mkdir -p "$CONF_DIR/system/Snapmaker"
    cp squashfs-root/resources/profiles/Snapmaker.json "$CONF_DIR/system/"
    cp -r squashfs-root/resources/profiles/Snapmaker/. "$CONF_DIR/system/Snapmaker/"
    cd - > /dev/null
    rm -rf "$TMPDIR"
    echo "    Snapmaker vendor installed"

    echo "[4/4] Setting up printer configs..."
    bash <(curl -sL "$RAW_URL/printer-setup.sh")

    echo ""
    echo "Done! Connect to VPN then launch: $APPIMAGE"
    ;;

  macos)
    echo "=== StemlabSlicer Setup (macOS) ==="
    echo "[1/2] Downloading StemlabSlicer_Mac.dmg..."
    curl -L --progress-bar -o "/tmp/StemlabSlicer_Mac.dmg" "$BASE_URL/StemlabSlicer_Mac.dmg"

    echo "[2/2] Installing to /Applications..."
    hdiutil attach "/tmp/StemlabSlicer_Mac.dmg" -quiet -nobrowse -readonly -mountpoint /tmp/stemlabslicer_mount
    rm -rf /Applications/StemlabSlicer.app
    cp -r "/tmp/stemlabslicer_mount/StemlabSlicer.app" "/Applications/"
    hdiutil detach /tmp/stemlabslicer_mount -quiet
    rm "/tmp/StemlabSlicer_Mac.dmg"

    echo ""
    echo "Done! Connect to VPN then open StemlabSlicer from Launchpad."
    echo "Note: Right-click → Open on first launch if Gatekeeper blocks it."
    ;;

  *)
    echo "Unsupported platform. Use install.ps1 on Windows." >&2
    exit 1
    ;;
esac
