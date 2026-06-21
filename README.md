<div align="center">

<picture>
  <img alt="StemlabSlicer" src="icon.png" width="18%" height="18%">
</picture>

<h1>StemlabSlicer</h1>

<p><strong>OrcaSlicer · Stemlabs Edition</strong></p>

<p>
  A customized build of OrcaSlicer with 8 Snapmaker U1 printers built in.<br>
  Connect to VPN, open the app, and start printing — no setup required.
</p>

[![Build & Release](https://github.com/12MICKY/CUDSteamlabSlicer/actions/workflows/release.yml/badge.svg)](https://github.com/12MICKY/CUDSteamlabSlicer/actions/workflows/release.yml)
[![GitHub Release](https://img.shields.io/github/v/release/12MICKY/CUDSteamlabSlicer?label=release&color=brightgreen)](https://github.com/12MICKY/CUDSteamlabSlicer/releases/latest)
[![GitHub Downloads](https://img.shields.io/github/downloads/12MICKY/CUDSteamlabSlicer/total?color=blue)](https://github.com/12MICKY/CUDSteamlabSlicer/releases)

</div>

---

## Quick Start

**Linux / macOS**
```bash
curl -sL https://raw.githubusercontent.com/12MICKY/CUDSteamlabSlicer/main/install.sh | bash
```

**Windows (PowerShell)**
```powershell
irm https://raw.githubusercontent.com/12MICKY/CUDSteamlabSlicer/main/install.ps1 | iex
```

---

## Download

<div align="center">

### 📥 [Download StemlabSlicer (Latest Release)](https://github.com/12MICKY/CUDSteamlabSlicer/releases/latest)

</div>

| Platform | File |
|:---:|:---|
| 🐧 Linux | `StemlabSlicer_Linux.AppImage` |
| 🍎 macOS Intel | `StemlabSlicer_Mac.dmg` |
| 🍎 macOS Apple Silicon | `StemlabSlicer_Mac_arm64.dmg` |
| 🪟 Windows | `StemlabSlicer_Windows_Setup.exe` (installer) |
| 🪟 Windows | `StemlabSlicer_Windows.zip` (portable) |

> [!IMPORTANT]
> VPN must be connected to reach the printer network (`10.15.5.0/24`)

> [!NOTE]
> **macOS:** Right-click → Open on first launch (app is not notarized by Apple)

---

## Printers

All 8 printers are embedded as **read-only system presets** inside the app.

| # | Printer | IP Address | Web Interface |
|:---:|:---|:---:|:---:|
| 1 | Snapmaker U1-1 | `10.15.5.66` | [Fluidd ↗](http://10.15.5.66) |
| 2 | Snapmaker U1-2 | `10.15.5.160` | [Fluidd ↗](http://10.15.5.160) |
| 3 | Snapmaker U1-3 | `10.15.5.152` | [Fluidd ↗](http://10.15.5.152) |
| 4 | Snapmaker U1-4 | `10.15.5.69` | [Fluidd ↗](http://10.15.5.69) |
| 5 | Snapmaker U1-5 | `10.15.5.164` | [Fluidd ↗](http://10.15.5.164) |
| 6 | Snapmaker U1-6 | `10.15.5.174` | [Fluidd ↗](http://10.15.5.174) |
| 7 | Snapmaker U1-7 | `10.15.5.165` | [Fluidd ↗](http://10.15.5.165) |
| 8 | Snapmaker U1-8 | `10.15.5.70` | [Fluidd ↗](http://10.15.5.70) |

---

## How to Print

1. **Connect VPN** → network `10.15.5.0/24` must be reachable
2. **Open StemlabSlicer**
3. **Select a printer** from the machine dropdown
4. **Import your model**, slice, and click **Print**

### Check Connectivity

```bash
for ip in 10.15.5.66 10.15.5.160 10.15.5.152 10.15.5.69 10.15.5.164 10.15.5.174 10.15.5.165 10.15.5.70; do
  ping -c1 -W2 $ip &>/dev/null && echo "✓  $ip online" || echo "✗  $ip unreachable"
done
```

---

## How It Works

StemlabSlicer is built automatically by a [GitHub Actions workflow](.github/workflows/release.yml) for all platforms on every push:

```
OrcaSlicer (latest release)
        │
        ├─── Linux   → Extract AppImage → inject presets → repack AppImage
        ├─── Windows → Silent install → inject presets → Inno Setup .exe + portable .zip
        └─── macOS   → Mount DMG → inject presets → repackage DMG
                      (Intel x86_64 + Apple Silicon arm64)
        │
        ▼
  Publish to GitHub Releases
```

**Printer configs are baked into every binary** at build time via [`embed_printers.py`](embed_printers.py).  
All printer data is defined once in [`printers.json`](printers.json).

---

## Files

| File | Purpose |
|---|---|
| [`install.sh`](install.sh) | One-liner installer for Linux and macOS |
| [`install.ps1`](install.ps1) | One-liner installer for Windows (PowerShell) |
| [`installer.iss`](installer.iss) | Inno Setup script for Windows .exe installer |
| [`embed_printers.py`](embed_printers.py) | Injects printer presets at build time (reads `printers.json`) |
| [`printer-setup.sh`](printer-setup.sh) | Manual preset setup for existing OrcaSlicer installations |
| [`printers.json`](printers.json) | Single source of truth — printer IPs and API keys |
| [`printers.csv`](printers.csv) | Printer list in CSV format |
| [`.github/workflows/release.yml`](.github/workflows/release.yml) | CI/CD: cross-platform build and publish |

---

## License

StemlabSlicer is built on [OrcaSlicer](https://github.com/OrcaSlicer/OrcaSlicer), licensed under the **GNU Affero General Public License v3**.
